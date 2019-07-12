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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BFCC742C7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C382084B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsFqvfZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfGLPNk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:13:40 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45599 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfGLPNk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jul 2019 11:13:40 -0400
Received: by mail-lj1-f169.google.com with SMTP id m23so9643651lje.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2019 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h3sTm/ZbHiXmLAfcS+TDy5tSuY2T5lRPvVeXUqCv0D0=;
        b=ZsFqvfZLU9zu8VyR8rY1Dtl9KC5h7bGlF99ZebftTSlI3qYN4kt0SU915OWktOneJ7
         fGH+phg3h5DKEzG1Ur8eaSaMDBhm5gbflkBJZ2p6hiTJOBRc+U28tuvpwqvvvK8QwBgA
         KBDSGHJyh7kJlKpfOILPj86G+XBrRp7R8HPyBzvGfXYZQLMAQzfun9iIgbXpMbIsiULx
         Pj69hpE6T6LAv0cNld6MiVkkyWQOq1IifxA6eIMirKEToU0OtMiTyrryjEWHRVhM3ISX
         FiquvRtAcL4QXjVEe8dI7Sfec/xmKqM//RFj0MHiCek5K9HvrqmvzlU5OeeJwDve8QR6
         y6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3sTm/ZbHiXmLAfcS+TDy5tSuY2T5lRPvVeXUqCv0D0=;
        b=i2HhREnoSSPgTzDQiVpRZSUOPJCAoY+6v/2V8+lRE472OxgAvZO30+woWQ7Zfec9/h
         ms6rJPXrYsbfTxLkSliVeikmn3f6YVpa4cvO1oNz1niOkSD1di2nR3oCUQJbzamzNNSq
         IbmrLQSL0VXibdlbC7TeUsnFdGp4ffuIw9JaQGSmyEL+4CL/gLSORiZ+3PZvFeV1hddZ
         /lH6Pp6ZOiv1DmzbXpEKUrn6lCYBntKQG94n7+4UAfMhtEW1cmNAtEsWX9dTjS86w4Hs
         rp0gcQbtEY8JzFGiT3P/ypOsNpzvZcuumzWYDSYLpHPv68aVfY/EA3ll8Uv9me5l0OFY
         gRJg==
X-Gm-Message-State: APjAAAXhabOx6ZBI6qabRRP/SlbAQxXW9oTR+Qoy5cME/ryCrQTVx2h/
        XYiRT06na5GIxJJkeSZjpICgXnGKe6o=
X-Google-Smtp-Source: APXvYqyIBNF0H56nVUo2w5etmYxTdKLP4wDFeTd+c5HFeKmMJaRTmR9nsUIvNnspDVH166+kp0y4/w==
X-Received: by 2002:a2e:9188:: with SMTP id f8mr6277274ljg.33.1562944416700;
        Fri, 12 Jul 2019 08:13:36 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id y18sm1478970ljh.1.2019.07.12.08.13.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 08:13:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] test: Add example-player
Date:   Fri, 12 Jul 2019 18:13:29 +0300
Message-Id: <20190712151329.11333-4-luiz.dentz@gmail.com>
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

This adds an example of registering a player with use of
RegisterApplication.
---
 test/example-player | 203 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 test/example-player

diff --git a/test/example-player b/test/example-player
new file mode 100644
index 000000000..2beb08e44
--- /dev/null
+++ b/test/example-player
@@ -0,0 +1,203 @@
+#!/usr/bin/python
+
+from __future__ import print_function
+
+import os
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
+import bluezutils
+
+PLAYER_IFACE =       'org.mpris.MediaPlayer2.Player'
+DBUS_OM_IFACE =      'org.freedesktop.DBus.ObjectManager'
+DBUS_PROP_IFACE =    'org.freedesktop.DBus.Properties'
+
+class InvalidArgsException(dbus.exceptions.DBusException):
+    _dbus_error_name = 'org.freedesktop.DBus.Error.InvalidArgs'
+
+class Player(dbus.service.Object):
+    def __init__(self, bus, path, obj):
+        self.path = path
+        dbus.service.Object.__init__(self, bus, self.path)
+
+        if obj != None:
+            mp = dbus.Interface(bus.get_object("org.bluez", obj),
+                                                "org.bluez.MediaPlayer1")
+            prop = dbus.Interface(bus.get_object("org.bluez", obj),
+                                  "org.freedesktop.DBus.Properties")
+
+            self.properties = prop.GetAll("org.bluez.MediaPlayer1")
+
+            bus.add_signal_receiver(self.properties_changed, path = obj,
+                            dbus_interface = "org.freedesktop.DBus.Properties",
+                            signal_name = "PropertiesChanged")
+        else:
+            self.track = dbus.Dictionary({"xesam:title" : "Title",
+                                     "xesam:artist" : ["Artist"],
+                                     "xesam:album" : "Album",
+                                     "xesam:genre" : ["Genre"],
+                                     "xesam:trackNumber" : dbus.Int32(1),
+                                     "mpris:length" : dbus.Int64(10000) },
+                                     signature="sv")
+
+            self.properties = dbus.Dictionary({"PlaybackStatus" : "playing",
+                                        "Identity" : "SimplePlayer",
+                                        "LoopStatus" : "None",
+                                        "Rate" : dbus.Double(1.0),
+                                        "Shuffle" : dbus.Boolean(False),
+                                        "Metadata" : self.track,
+                                        "Volume" : dbus.Double(1.0),
+                                        "Position" : dbus.Int64(0),
+                                        "MinimumRate" : dbus.Double(1.0),
+                                        "MaximumRate" : dbus.Double(1.0),
+                                        "CanGoNext" : dbus.Boolean(False),
+                                        "CanGoPrevious" : dbus.Boolean(False),
+                                        "CanPlay" : dbus.Boolean(False),
+                                        "CanSeek" : dbus.Boolean(False),
+                                        "CanControl" : dbus.Boolean(False),
+                                        },
+                                        signature="sv")
+
+        print('Register media player with:\n\tProperties: %s' \
+              % (self.properties))
+        handler = InputHandler(self)
+        GObject.io_add_watch(sys.stdin, GObject.IO_IN, handler.handle)
+
+    @dbus.service.method("org.freedesktop.DBus.Properties",
+                         in_signature="ssv", out_signature="")
+    def Set(self, interface, key, value):
+        print("Set (%s, %s)" % (key, value), file=sys.stderr)
+        return
+
+    def get_properties(self):
+        return self.properties
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    @dbus.service.method("org.freedesktop.DBus.Properties",
+                         in_signature='s', out_signature='a{sv}')
+    def GetAll(self, interface):
+        if interface != PLAYER_IFACE:
+            raise InvalidArgsException()
+
+        return self.get_properties()
+
+    @dbus.service.signal("org.freedesktop.DBus.Properties",
+                         signature="sa{sv}as")
+    def PropertiesChanged(self, interface, properties,
+                          invalidated = dbus.Array()):
+        """PropertiesChanged(interface, properties, invalidated)
+
+        Send a PropertiesChanged signal. 'properties' is a dictionary
+        containing string parameters as specified in doc/media-api.txt.
+        """
+        pass
+
+    def help(self, func):
+        help(self.__class__.__dict__[func])
+
+    def properties_changed(self, interface, properties, invalidated):
+        print("properties_changed(%s, %s)" % (properties, invalidated))
+
+        self.PropertiesChanged(interface, properties, invalidated)
+
+class InputHandler:
+    commands = { 'PropertiesChanged': '(interface, properties)',
+                        'help': '(cmd)' }
+    def __init__(self, player):
+        self.player = player
+        print('\n\nAvailable commands:')
+        for cmd in self.commands:
+                print('\t', cmd, self.commands[cmd], sep='')
+
+        print("\nUse python syntax to pass arguments to available methods.\n" \
+                "E.g.: PropertiesChanged({'Metadata' : {'Title': 'My title', \
+                'Album': 'my album' }})")
+        self.prompt()
+
+    def prompt(self):
+        print('\n>>> ', end='')
+        sys.stdout.flush()
+
+    def handle(self, fd, condition):
+        s = os.read(fd.fileno(), 1024).strip()
+        try:
+            cmd = s[:s.find('(')]
+            if not cmd in self.commands:
+                print("Unknown command ", cmd)
+        except ValueError:
+            print("Malformed command")
+            return True
+        try:
+            exec "self.player.%s" % s
+        except Exception as e:
+            print(e)
+            pass
+        self.prompt()
+        return True
+
+class Application(dbus.service.Object):
+    def __init__(self, bus, path, obj):
+        self.path = '/'
+        self.players = []
+        dbus.service.Object.__init__(self, bus, self.path)
+        self.add_player(Player(bus, path, obj))
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    def add_player(self, player):
+        self.players.append(player)
+
+    @dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
+    def GetManagedObjects(self):
+        response = {}
+        print('GetManagedObjects')
+
+        for player in self.players:
+            response[player.get_path()] = { PLAYER_IFACE:
+                                            player.get_properties() }
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
+        path = bluezutils.find_adapter(sys.argv[1]).object_path
+    else:
+        path = bluezutils.find_adapter().object_path
+
+    media = dbus.Interface(bus.get_object("org.bluez", path),
+                           "org.bluez.Media1")
+
+    path = "/test/player"
+
+    if len(sys.argv) > 2:
+        app = Application(bus, path, sys.argv[2])
+    else:
+        app = Application(bus, path, None)
+
+    mainloop = GObject.MainLoop()
+
+    media.RegisterApplication(app.get_path(), {},
+                                reply_handler=register_app_cb,
+                                error_handler=register_app_error_cb)
+
+    mainloop.run()
-- 
2.21.0

