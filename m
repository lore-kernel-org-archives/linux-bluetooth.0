Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Yunchuan Geng <yunchuan.geng@nomovok.com>
Subject: property changes emited but not captured, why?::
Message-ID: <57025247.3080709@nomovok.com>
Date: Mon, 4 Apr 2016 14:38:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am testing map-client python script from bluez-5.30. Everything works 
fine, except that I found I can not capture the properties change signal,
which I confirmed from log did been emitted from parse_subject function 
in obexd/client/map.c

In order to check if the signal is captured in python script or not, I 
have patched the script like this. But have not catch any signal the 
parse_subject
function has emitted.

Could anyone tell me why and how to correctly capture property changes 
emitted by g_dbus_emit_property_changed function.


Yunchuan

=====Patch=====
diff --git a/test/map-client b/test/map-client
index b9695da..634b91a 100755
--- a/test/map-client
+++ b/test/map-client
@@ -118,6 +119,9 @@ class MapClient:
                 mainloop.quit()

         def properties_changed(self, interface, properties, 
invalidated, path):
+                print(properties)
+                print(interface)
+                print(path)
                 req = self.props.get(path)
                 if req == None:
                         return

