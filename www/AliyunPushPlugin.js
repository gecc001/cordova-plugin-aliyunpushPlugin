var exec = require('cordova/exec');


exports.iosInit=function(success,error){
	exec(success,error,"PushIOS","init",[]);
}

exports.iosBindAccount=function(success,error,args){
	exec(success,error,"PushIOS","bindAccount",args);
}
exports.iosBindTagsandAlias=function(success,error,args){
	exec(success,error,"PushIOS","bindTagsandAlias",args);
}
exports.iosUnBindAccount=function(success,error,args){
	exec(success,error,"PushIOS","unBindAccount",args);
}
exports.iosUnBindTagsandAlias=function(success,error,args){
	exec(success,error,"PushIOS","unBindTagsandAlias",args);
}

exports.iosGetDeviceId=function(success,error){
	exec(success,error,"PushIOS","getDeviceId",[]);
}
exports.iosListTags=function(success,error){
	exec(success,error,"PushIOS","listTags",[]);
}
exports.iosListAlias=function(success,error){
	exec(success,error,"PushIOS","listAlias",[]);
}
exports.iosRemoveAlias=function(success,error){
	exec(success,error,"PushIOS","removeAlias",[]);
}
exports.iosOnMessageRes=function(success,error){
	exec(success,error,"PushIOS","onMessageRes",[]);
}
exports.iosOnNotificationClick=function(success,error){
	exec(success,error,"PushIOS","onNotificationClick",[]);
}

//android

exports.androidBindAccount=function(success,error,args){
	exec(success,error,"PushAndroid","bindAccount",args);
}
exports.androidBindTagsandAlias=function(success,error,args){
	exec(success,error,"PushAndroid","bindTagsandAlias",args);
}
exports.androidUnBindAccount=function(success,error,args){
	exec(success,error,"PushAndroid","unBindAccount",args);
}
exports.androidUnbindTagsandAlias=function(success,error,args){
	exec(success,error,"PushAndroid","unBindTagsandAlias",args);
}

exports.androidGetDeviceId=function(success,error){
	exec(success,error,"PushAndroid","getDeviceId",[]);
}
exports.androidListTags=function(success,error){
	exec(success,error,"PushAndroid","listTags",[]);
}
exports.androidListAlias=function(success,error){
	exec(success,error,"PushAndroid","listAlias",[]);
}
exports.androidRemoveAlias=function(success,error){
	exec(success,error,"PushAndroid","removeAlias",[]);
}
exports.androidSetNotificationSoundFilePath=function(success,error,args){
	exec(success,error,"PushAndroid","setNotificationSoundFilePath",args);
}
exports.androidSetNotificationLargeIcon=function(success,error,args){
	exec(success,error,"PushAndroid","setNotificationLargeIcon",args);
}
exports.androidSetNotificationSmallIcon=function(success,error,args){
	exec(success,error,"PushAndroid","setNotificationSmallIcon",args);
}
exports.androidSetDoNotDisturb=function(success,error,args){
	exec(success,error,"PushAndroid","setDoNotDisturb",args);
}
exports.androidSetCloseDoNotturbMode=function(success,error){
	exec(success,error,"PushAndroid","setCloseDoNotturbMode",[]);
}
exports.androidSetClearNotifications=function(success,error){
	exec(success,error,"PushAndroid","setCleraNotifications",[]);
}
exports.androidBindPhoneNumber=function(success,error,args){
	exec(success,error,"PushAndroid","bindPhoneNumber",args);
}
exports.androidUnBindPhoneNum=function(success,error){
	exec(success,error,"PushAndroid","unBindPhoneNum",[]);
}
exports.androidOnMessageRes=function(success,error){
	exec(success,error,"PushAndroid","onMessageRes",[]);
}
exports.androidOnNotifyClick=function(success,error){
	exec(success,error,"PushAndroid","onNotifyClick",[]);
}