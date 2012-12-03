Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] test: Add a HFP HF endpoint to simple-endpoint
Date: Mon,  3 Dec 2012 20:42:28 -0300
Message-Id: <1354578148-9089-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-endpoint | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/test/simple-endpoint b/test/simple-endpoint
index 20c8159..79e38c7 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -11,6 +11,7 @@ import gobject
 A2DP_SOURCE_UUID = "0000110A-0000-1000-8000-00805F9B34FB"
 A2DP_SINK_UUID = "0000110B-0000-1000-8000-00805F9B34FB"
 HFP_AG_UUID = "0000111F-0000-1000-8000-00805F9B34FB"
+HFP_HF_UUID = "0000111E-0000-1000-8000-00805F9B34FB"
 HSP_AG_UUID = "00001112-0000-1000-8000-00805F9B34FB"
 
 SBC_CODEC = dbus.Byte(0x00)
@@ -38,6 +39,8 @@ MP3_CONFIGURATION = dbus.Array([dbus.Byte(0x21), dbus.Byte(0x02), dbus.Byte(0x00
 PCM_CODEC = dbus.Byte(0x00)
 PCM_CONFIGURATION = dbus.Array([], signature="ay")
 
+CVSD_CODEC = dbus.Byte(0x01)
+
 class Rejected(dbus.DBusException):
 	_dbus_error_name = "org.bluez.Error.Rejected"
 
@@ -120,6 +123,11 @@ if __name__ == '__main__':
 							"Codec" : PCM_CODEC,
 							"Capabilities" :  PCM_CONFIGURATION })
 			endpoint.default_configuration(dbus.Array([]))
+		if sys.argv[2] == "hfphf":
+			properties = dbus.Dictionary({ "UUID" : HFP_HF_UUID,
+							"Codec" : CVSD_CODEC,
+							"Capabilities" :  PCM_CONFIGURATION })
+			endpoint.default_configuration(dbus.Array([]))
 
 	print(properties)
 
-- 
1.8.0.1

