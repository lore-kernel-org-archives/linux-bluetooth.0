Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Alex Deymo <deymo@chromium.org>
Date: Mon, 20 May 2013 19:07:23 -0700
Message-ID: <CAGd9gwhNgRhgqzhxxZNyD-o=j4ksTXvFFhTQMawt4bv0b2VPcQ@mail.gmail.com>
Subject: [BUG] Set Powered=true doesn't power up the adapter
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm seeing a problem while trying to power on the adapter once in a
while just after reboot. What happens is that sending a dbus call to
power on the adapter doesn't return. You can read a more detailed
description of the bug here [1] but the resume is as follows:

Sending org.freedesktop.DBus.Properties.Set for power up the adapter
doesn't return (dbus timeouts after a while) just after reboot. Is a
very rare bug, but happens from time to time. Restarting bluetoothd
with -n -d to get the logs made it start returning with the error
org.bluez.Error.Failed to the same call. I don't see any HCI command
with btmon while doing this, so I think it's not a firmware issue at
that point (could be some other thing before). From this state, I can
call Set several times to power up the adapter, but doesn't work.
What is interesting is that if instead of sending MGMT_OP_SET_POWERED
from bluetoothd, we try to power up the adapter with hciconfig
(calling ioctl(ctl, HCIDEVUP, hdev) ) the adapter goes up and
everything works fine from there. We are running kernel 3.8, I don't
know if this was already reported in a newer version.

Hope it helps, I'll try to have more debugging information... but it
would be useful it someone can tell me where to look at, since this is
not very easy to reproduce.
Best regards,
Alex.

[1] https://code.google.com/p/chromium/issues/detail?id=239896#c11
