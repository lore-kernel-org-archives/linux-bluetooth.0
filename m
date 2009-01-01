Return-Path: <cyrus@holtmann.org>
Message-ID: <60689.209.216.239.242.1230838689.squirrel@webmail.ipns.com>
Date: Thu, 1 Jan 2009 12:38:09 -0700 (MST)
Subject: incoming connection conflicting with alsa?
From: "Dave Schile" <dave@schile.com>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I think I'm having  a conflict between alsa and my headset device making
its own connection.  If there is no connection, programs that are set to
use the alsa bluetooth  device connect fine.  If I have press the button
on the headset before alsa can connect to it, te device makes its own ACL
connection and alsa becomes unable to get the device.

 If alsa makes the connection first then  press the button on the headset
the incoming connection takes the place of the alsa connection and alsa
loses the device.

How can I solve this?  I've tried a number of hciconfig settings, but the
button press always creates a connection, breaking the alsa one.

Thank you
Dave

