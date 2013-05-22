Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [BUG] Set Powered=true doesn't power up the adapter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGd9gwhNgRhgqzhxxZNyD-o=j4ksTXvFFhTQMawt4bv0b2VPcQ@mail.gmail.com>
Date: Wed, 22 May 2013 08:45:27 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Message-Id: <EB6AAB69-26D6-4227-87AD-AA3AB04DBE73@holtmann.org>
References: <CAGd9gwhNgRhgqzhxxZNyD-o=j4ksTXvFFhTQMawt4bv0b2VPcQ@mail.gmail.com>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> I'm seeing a problem while trying to power on the adapter once in a
> while just after reboot. What happens is that sending a dbus call to
> power on the adapter doesn't return. You can read a more detailed
> description of the bug here [1] but the resume is as follows:
> 
> Sending org.freedesktop.DBus.Properties.Set for power up the adapter
> doesn't return (dbus timeouts after a while) just after reboot. Is a
> very rare bug, but happens from time to time. Restarting bluetoothd
> with -n -d to get the logs made it start returning with the error
> org.bluez.Error.Failed to the same call. I don't see any HCI command
> with btmon while doing this, so I think it's not a firmware issue at
> that point (could be some other thing before). From this state, I can
> call Set several times to power up the adapter, but doesn't work.
> What is interesting is that if instead of sending MGMT_OP_SET_POWERED
> from bluetoothd, we try to power up the adapter with hciconfig
> (calling ioctl(ctl, HCIDEVUP, hdev) ) the adapter goes up and
> everything works fine from there. We are running kernel 3.8, I don't
> know if this was already reported in a newer version.
> 
> Hope it helps, I'll try to have more debugging information... but it
> would be useful it someone can tell me where to look at, since this is
> not very easy to reproduce.

when this happens, can you please enable dynamic debug of the Bluetooth subsystem and try to get the logs from our DBG statements.

Also any chance to set MGMT_DEBUG in that case before restarting bluetoothd. If the mgmt socket gets stuck with a missing response, we might be stuck as well. We had these corner cases in older kernels and worked around them with extra timeouts that protect that section.

Regards

Marcel

