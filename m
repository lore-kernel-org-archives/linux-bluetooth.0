Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "connman@moblin.org" <connman@moblin.org>,
	"Liu, Bing Wei" <bing.wei.liu@intel.com>,
	"Gao, Bin" <bin.gao@intel.com>,
	"Yin, Kangkai" <kangkai.yin@intel.com>
Date: Thu, 16 Apr 2009 16:49:10 +0800
Subject: CreatDevice signal should be emitted at function
 create_stored_device_from_profiles() in src/adapter.c
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D5B2E7CEF@pdsmsx503.ccr.corp.intel.com>
References: <49D1FE96.1090200@binarywings.net>
	 <2d5a2c100903310644od9cbf69ma2c28c83b7e51@mail.gmail.com>
	 <49D30FD8.9020506@binarywings.net> <49D45501.8030606@binarywings.net>
 <2d5a2c100904021028g78376debke885916eba13cf93@mail.gmail.com>
 <49E5F2BE.1040808@binarywings.net>
In-Reply-To: <49E5F2BE.1040808@binarywings.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi:
I found that at bluez CreatDevice signal is not emitted at function create_stored_device_from_profile() in src/adapter.c. 
That leads to system can not got the CreatDevice singal when the deivce is created though storage. The usage case is that, when I unplug the bluethooth usb dongle and then plug in again. System can not get the CreatDevice signal. So ConnMan can not handle the CreatDevice signal. 
I have created patch to bluez to fix the issue. Please review, any comments are welcome.
diff --git a/src/adapter.c b/src/adapter.c
index 44a93b1..c096375 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1867,6 +1867,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 	struct btd_device *device;
 	bdaddr_t dst;
 	char srcaddr[18], dstaddr[18];
+	const char *path;
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
@@ -1877,6 +1878,12 @@ static void create_stored_device_from_profiles(char *key, char *value,
 	device = device_create(connection, adapter, key);
 	if (!device)
 		return;
+
+	path = device_get_path(device);
+	g_dbus_emit_signal(connection, adapter->path,
+				ADAPTER_INTERFACE, "DeviceCreated",
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
 
 	device_set_temporary(device, FALSE);
 	adapter->devices = g_slist_append(adapter->devices, device);
