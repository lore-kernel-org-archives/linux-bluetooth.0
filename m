Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 23 Jan 2015 15:01:27 -0600
Message-ID: <CAAqhSf6mcSTrPyTrEu8KL7GFmnVGf9OjPNS+vNyARyhQZc=c6A@mail.gmail.com>
Subject: GATT plugin
From: Tyler Arnold <choosetylernol@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi there ,
 I am building a GATT service/plugin for the bluetooth daemon and have
ported 5.27 bluez to my embedded ARM platform.

It seems like the GATT D-Bus API is not quite ready, so my options
appear to be either building the plugin and linking it as a statically
linked object or build it as a shared object library where the daemon
will pick it up from /usr/local/lib/bluetooth/plugins
Are both supported? I saw a message from about a year ago suggesting
the shared object approach was not the best path.

 thanks!
