Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Mar 2014 00:41:21 +0200
From: PhobosK <phobosk@kbfx.net>
To: linux-bluetooth@vger.kernel.org
Subject: PS3 BD Remote Control - always connected problem
Message-ID: <20140303004121.32ac160f.phobosk@kbfx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I have a problem with my PS3 BD Remote Control.
I am running Gentoo with kernel 3.13.3 and bluez 5.15.
I use the PS3 BD Remote Control in XBMC and it works fine, but it stays
connected all the time and the battery is drained very fast... like for
a week. 

There used to be an option in bluez 4.x that helped in fixing the
problem (PS3_REMOTE_TIMEOUT var in the src code) but not anymore.
Now when I try using the IdleTimeout var in input.conf, when the timeout
is reached the device is removed and it cannot be created again nor it
can be used anymore without restarting the bluetooth service (I
use systemd, not openrc if this matters at all).... 


Can anyone help me with this please?

-- 
PhobosK
