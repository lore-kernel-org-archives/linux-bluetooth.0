Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: =?UTF-8?Q?Rafa=c5=82_Bilski?= <rafalbilski@interia.pl>
Subject: [PATCH] Allow bluetoothd to call methods on dbus' system bus
Message-ID: <8ae38491-75b4-b230-2232-fd12a4bd7b7a@interia.pl>
Date: Wed, 30 May 2018 23:26:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Default dbus configuration doesn't allow calling methods on system bus. Only sending signals is 
allowed.
If "mpris-proxy" isn't running "/usr/lib/gsd-media-keys" translates keystrokes from 
"profiles/audio/avctp.c:handle_panel_passthrough()"
to dbus method calls on session bus. This is allowed on dbus by default.
If "mpris-proxy" is running "bluetoothd" executes dbus' method calls on system bus.  These 
apparently are rejected by default.

diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 0c0b221bb..1cafab631 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -8,6 +8,7 @@
    <!-- ../system.conf have denied everything, so we just punch some holes -->
  
    <policy user="root">
+    <allow send_type="method_call"/>
      <allow own="org.bluez"/>
      <allow send_destination="org.bluez"/>
      <allow send_interface="org.bluez.Agent1"/>

