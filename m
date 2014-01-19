Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: simon@mungewell.org
Cc: linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH] lib: Use bigger IMTU when connecting SDP
Date: Sun, 19 Jan 2014 21:01:54 +0100
Message-ID: <1565501.U8ecNLfzyG@athlon>
In-Reply-To: <d1fe03c920dacec62bc0f59c62a8932c.squirrel@mungewell.org>
References: <1390153036-10030-1-git-send-email-szymon.janc@gmail.com> <d1fe03c920dacec62bc0f59c62a8932c.squirrel@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Simon,

On Sunday 19 January 2014 14:45:43 simon@mungewell.org wrote:
> > Sony Dualshock 4 controller is ignoring L2CAP MTU while sending SDP
> > response. This results in data being dropped and no SDP response is
> > received (so no input device was created and HID connection was
> > refused). Workaround this by using large IMTU for SDP.
> 
> I tried with this and your earlier DS4 patch, on top of a Fedora 20 Live
> CD, and unfortunately it does not work for me. I still get the situation
> where the DS initiates a connection and then turns off immediately.
> 
> I get the log messages
> --
> Jan 19 14:01:14 localhost systemd: Reached target Bluetooth.
> Jan 19 14:01:14 localhost bluetoothd[1803]: Refusing input device connect:
> No such file or directory (2)
> Jan 19 14:01:14 localhost bluetoothd[1803]: Refusing connection from
> 1C:66:6D:07:C3:E0: unknown device
> --
> 
> See log files:
> pair_ds4_fedora.txt
> connect_ds4_fedora.txt
> 
> There is also a problem when the pairing is initiated from the PC side,
> seems that the resultant link key is not accepted on connection.
> 
> See:
> pair_fedora_ds4_2.txt
> connect_ds4_fedora_2.txt
> 
> I note that the cache file for the DS4's mac picks up some details on a
> SDP browse, but not a complete record. This is on an older machine, so BT
> chipset might be a factor.
> 
> Anything I can try?
> Simon

It looks like you are using BT 2.0 dongle. I suggest trying with 2.1.
I didn't check with 2.0 yet.

BTW
This patch is not going to be merge in current form. I'll be sending V2 later.

-- 
Szymon K. Janc
szymon.janc@gmail.com
