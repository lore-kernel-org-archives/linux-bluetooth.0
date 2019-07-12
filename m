Return-Path: <SRS0=25t8=VJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA69C742C8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1A2084B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUCdh2Qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGLPNj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:13:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36883 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLPNi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jul 2019 11:13:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so6729228lfh.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2019 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yHMO7IjNpH7sVko+RgaEZV1Cca8UgpqHoRmLICyJwdw=;
        b=cUCdh2QyyaQtdlZQIz9HKqE8TqCaOIse700zoHVjaElqGJPJlXP70YN8oWlhsjkQCC
         Dt8fYWzFiY1UWM4m4vTVfvifRf/UD28hL83v8jmR3mB9I37ouvjWaieJ2ZHk/8UZLnEd
         6vrEUbZHaxdu1/5BZ1SRD7Zg636eno69OCVA3mCTV6L0PNLwydqdj/pw+Hig8NDRYLUW
         d0LMoF+5/p/PEvQQiNcmtNPvQVZ3d5vt44QZBkBHllixf3MKbNxSizH6qf9RI6BLOoEY
         X7hy1m0Q2NJZe1OiFkfgFPbuT8hxsigWT5J+tpWIjEOV7b4pqJaDPMUjuIE0B414RuoQ
         zjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHMO7IjNpH7sVko+RgaEZV1Cca8UgpqHoRmLICyJwdw=;
        b=lQGyRBU+cwfPvlvkG2rKui8bse2b51nf6sItSkKcTP4ozXuDz7csfpxkxlP5v1k7Le
         1gzJCSqF9ZV8/xxQFC/nS15zJaAHQbFOtQy3x8YUCnrRvcFnHNG8KrMW3LiR9XN43mKj
         haZidXY0Y9vJh3hNw6jYcdWS04AuH9inDAddhedQPT920mAv0CTzCtbUx30uxen0/12c
         jMPXFTGYFy7pLyoasuGsx+RNUxKtYtTjIfgUkJMYIra8Cus/Zwr+eASVfcKexmipM9JS
         hapVmphcBXcOqHCIg/3s5bS5uhxRabe2G2pG1mmkEefW6bwv/+/CuAPZ0Gx0pfrPMhBV
         iO1w==
X-Gm-Message-State: APjAAAWph7fDK6s363FLeq037uagT4OjdC3iFSFKw4m+ClJQAHneh15f
        cds2pnsmRbubL+O9IlGqyTVbnWioR5M=
X-Google-Smtp-Source: APXvYqz0sUGZ462R6xZDhQ5eY+LHFxc2Z0PrEnL4vo3DVbAuqXjQDaMcHgQE+R7bv3594/HWdp+BOw==
X-Received: by 2002:ac2:46ef:: with SMTP id q15mr5190359lfo.63.1562944414986;
        Fri, 12 Jul 2019 08:13:34 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id y18sm1478970ljh.1.2019.07.12.08.13.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 08:13:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] test: Add example-endpoint
Date:   Fri, 12 Jul 2019 18:13:28 +0300
Message-Id: <20190712151329.11333-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712151329.11333-1-luiz.dentz@gmail.com>
References: <20190712151329.11333-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds an example of registering an endpoint with use of
RegisterApplication.
---
 test/example-endpoint | 186 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100644 test/example-endpoint

diff --git a/test/example-endpoint b/test/example-endpoint
new file mode 100644
index 000000000..a5f0348a0
--- /dev/null
+++ b/test/example-endpoint
@@ -0,0 +1,186 @@
+#!/usr/bin/python
+
+from __future__ import absolute_import, print_function, unicode_literals
+
+import sys
+import dbus
+import dbus.exceptions
+import dbus.service
+import dbus.mainloop.glib
+
+import array
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
+import bluezutils
+
+ENDPOINT_IFACE =     'org.bluez.MediaEndpoint1'
+DBUS_OM_IFACE =      'org.freedesktop.DBus.ObjectManager'
+DBUS_PROP_IFACE =    'org.freedesktop.DBus.Properties'
+
+A2DP_SOURCE_UUID =   '0000110A-0000-1000-8000-00805F9B34FB'
+A2DP_SINK_UUID =     '0000110B-0000-1000-8000-00805F9B34FB'
+
+SBC_CODEC = dbus.Byte(0x00)
+#Channel Modes: Mono DualChannel Stereo JointStereo
+#Frequencies: 16Khz 32Khz 44.1Khz 48Khz
+#Subbands: 4 8
+#Blocks: 4 8 12 16
+#Bitpool Range: 2-64
+SBC_CAPABILITIES = dbus.Array([dbus.Byte(0xff), dbus.Byte(0xff), dbus.Byte(2), dbus.Byte(64)])
+# JointStereo 44.1Khz Subbands: Blocks: 16 Bitpool Range: 2-32
+SBC_CONFIGURATION = dbus.Array([dbus.Byte(0x21), dbus.Byte(0x15), dbus.Byte(2), dbus.Byte(32)])
+
+MP3_CODEC = dbus.Byte(0x01)
+#Channel Modes: Mono DualChannel Stereo JointStereo
+#Frequencies: 32Khz 44.1Khz 48Khz
+#CRC: YES
+#Layer: 3
+#Bit Rate: All except Free format
+#VBR: Yes
+#Payload Format: RFC-2250
+MP3_CAPABILITIES = dbus.Array([dbus.Byte(0x3f), dbus.Byte(0x07), dbus.Byte(0xff), dbus.Byte(0xfe)])
+# JointStereo 44.1Khz Layer: 3 Bit Rate: VBR Format: RFC-2250
+MP3_CONFIGURATION = dbus.Array([dbus.Byte(0x21), dbus.Byte(0x02), dbus.Byte(0x00), dbus.Byte(0x80)])
+
+PCM_CODEC = dbus.Byte(0x00)
+PCM_CONFIGURATION = dbus.Array([], signature="ay")
+
+CVSD_CODEC = dbus.Byte(0x01)
+
+class Rejected(dbus.DBusException):
+    _dbus_error_name = "org.bluez.Error.Rejected"
+
+class InvalidArgsException(dbus.exceptions.DBusException):
+    _dbus_error_name = 'org.freedesktop.DBus.Error.InvalidArgs'
+
+class Endpoint(dbus.service.Object):
+    def __init__(self, bus, path, properties, configuration):
+        self.path = path
+        self.bus = bus
+        self.properties = properties
+        self.configuration = configuration
+        self.exit_on_release = True
+        dbus.service.Object.__init__(self, bus, self.path)
+
+    def get_properties(self):
+        return self.properties
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    @dbus.service.method(DBUS_PROP_IFACE, in_signature='s',
+                         out_signature='a{sv}')
+    def GetAll(self, interface):
+        if interface != ENDPOINT_IFACE:
+            raise InvalidArgsException()
+
+        return self.get_properties()
+
+    def set_exit_on_release(self, exit_on_release):
+        self.exit_on_release = exit_on_release
+
+    def default_configuration(self, configuration):
+        self.configuration = configuration
+
+    @dbus.service.method(ENDPOINT_IFACE, in_signature="", out_signature="")
+    def Release(self):
+        print("Release")
+        if self.exit_on_release:
+            mainloop.quit()
+
+    @dbus.service.method(ENDPOINT_IFACE, in_signature="o", out_signature="")
+    def ClearConfiguration(self, transport):
+        print("ClearConfiguration (%s)" % (transport))
+
+    @dbus.service.method(ENDPOINT_IFACE, in_signature="oay", out_signature="")
+    def SetConfiguration(self, transport, config):
+        print("SetConfiguration (%s, %s)" % (transport, config))
+        return
+
+    @dbus.service.method(ENDPOINT_IFACE, in_signature="ay", out_signature="ay")
+    def SelectConfiguration(self, caps):
+        print("SelectConfiguration (%s)" % (caps))
+        return self.configuration
+
+class Application(dbus.service.Object):
+    def __init__(self, bus, path, properties, configuration):
+        self.path = '/'
+        self.endpoints = []
+        dbus.service.Object.__init__(self, bus, self.path)
+        self.add_endpoint(Endpoint(bus, path, properties, configuration))
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    def add_endpoint(self, endpoint):
+        self.endpoints.append(endpoint)
+
+    @dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
+    def GetManagedObjects(self):
+        response = {}
+        print('GetManagedObjects')
+
+        for endpoint in self.endpoints:
+            response[endpoint.get_path()] = { ENDPOINT_IFACE:
+                                              endpoint.get_properties() }
+
+        return response
+
+def register_app_cb():
+    print('Media application registered')
+
+
+def register_app_error_cb(error):
+    print('Failed to register application: ' + str(error))
+    mainloop.quit()
+
+if __name__ == '__main__':
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+    bus = dbus.SystemBus()
+
+    if len(sys.argv) > 1:
+            path = bluezutils.find_adapter(sys.argv[1]).object_path
+    else:
+            path = bluezutils.find_adapter().object_path
+
+    media = dbus.Interface(bus.get_object("org.bluez", path),
+                           "org.bluez.Media1")
+
+
+    properties = dbus.Dictionary({ "UUID" : A2DP_SOURCE_UUID,
+                                   "Codec" : SBC_CODEC,
+                                   "DelayReporting" : True,
+                                   "Capabilities" : SBC_CAPABILITIES })
+
+    configuration = SBC_CONFIGURATION
+
+    if len(sys.argv) > 2:
+        if sys.argv[2] == "sbcsink":
+            properties = dbus.Dictionary({ "UUID" : A2DP_SINK_UUID,
+                                           "Codec" : SBC_CODEC,
+                                           "DelayReporting" : True,
+                                           "Capabilities" : SBC_CAPABILITIES })
+        if sys.argv[2] == "mp3source":
+            properties = dbus.Dictionary({ "UUID" : A2DP_SOURCE_UUID,
+                                           "Codec" : MP3_CODEC,
+                                           "Capabilities" : MP3_CAPABILITIES })
+            configuration = MP3_CONFIGURATION
+        if sys.argv[2] == "mp3sink":
+            properties = dbus.Dictionary({ "UUID" : A2DP_SINK_UUID,
+                                           "Codec" : MP3_CODEC,
+                                           "Capabilities" : MP3_CAPABILITIES })
+            configuration = MP3_CONFIGURATION
+
+    print(properties)
+
+    path = "/test/endpoint"
+    app = Application(bus, path, properties, configuration)
+    mainloop = GObject.MainLoop()
+
+    media.RegisterApplication(app.get_path(), {},
+                                reply_handler=register_app_cb,
+                                error_handler=register_app_error_cb)
+    mainloop.run()
-- 
2.21.0

