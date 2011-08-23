Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: shy <shyboysby@gmail.com>
Date: Tue, 23 Aug 2011 16:54:53 +0800
Message-ID: <CAHabYV7pODc8ZNW_M4auZdwS+Qik8QfobUj6fK9_1rnkivcJ7g@mail.gmail.com>
Subject: HID UNPLUG_VIRTUAL_CABLE event issue
To: Marcel Holtmann <marcel@holtmann.org>
Cc: padovan@profusion.mobi, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
According to connection_disconnect in input/device.c(Bluez version
4.93), it would disconnect INTR and CONTROL L2cap link and then send
HIDP_CTRL_VIRTUAL_CABLE_UNPLUG message by the process sequence.
That seems it doesn't comply to the spec Page120, HID version 1.0.
Could you please confirm this case? If so, I would submit a patch.
Best regards
shy
