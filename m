Return-Path: <cyrus@holtmann.org>
From: John Frankish <JFrankish@saxonservices.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: agent versus simple-agent
Date: Sun, 22 Jul 2012 12:33:15 +0000
Message-ID: <381B9690B8F4374095EC4BC4B392C5AC68008F41@CALMBX02.SaxonServices.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm trying to find a way to pair without using simple-agent/python/pygtk/dbus-python.

I haven't been able to do this directly with dbus, so I thought I'd try tools/agent from bluez-4.101

Is the C applet tools/agent meant to be an equivalent of simple-agent (I don't know anything about C)?

This works:

$ echo "0000" | simple-agent hci0 00:21:3C:5B:E7:23
$ dbus-send --print-reply --system --dest=org.bluez /org/bluez/11521/hci0/dev_00_21_3C_5B_E7_23  org.bluez.Headset.Connect

Whereas this does not work:

$ agent --adapter hci0 0000 00:21:3C:5B:E7:23
Agent has been released
$ dbus-send --print-reply --system --dest=org.bluez /org/bluez/11521/hci0/dev_00_21_3C_5B_E7_23  org.bluez.Headset.Connect

>From this:

$ agent --help
agent [--adapter adapter-path] [--path agent-path] <passkey> [<device>]

I cannot figure out what "--path agent-path" refers to?




CONFIDENTIAL &amp; PRIVILEGED COMMUNICATION 



The information contained in this message is privileged, 

confidential, and protected from disclosure. This message 

is intended for the individual or entity addressed herein. 

If you are not the intended recipient, please do not read, 

copy, use or disclose this communication to others, also 

please notify the sender by replying to this message, and 

then delete it from your system. The sender totally disclaims, 

and will not accept, any responsibility or liability for the 

unauthorized use, or the consequences of any unauthorized use, 

of this communication or message.
