Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Feb 2010 23:38:46 -0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Fix segmentation fault when headset disconnects during
 authorization
Message-ID: <20100212013846.GB31360@jh-x301>
References: <f9d4bd31002101510y1435f74ev886d7993959990ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f9d4bd31002101510y1435f74ev886d7993959990ff@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Feb 10, 2010, Claudio Takahasi wrote:
> This patch fix a segmentation fault when the headset disconnected
> during authorization, see gdb backtrace:
> http://pastebin.com/m1529c2dc

Thanks. Strange that we didn't notice this earlier. It's been pushed
upstream now though.

> Can someone fix avctp now? For this case, answering "yes" in agent
> avctp connection will be left open:
> 
> bluetoothd[5406]: Headset disconnected during authorization
> bluetoothd[5406]: State changed
> /org/bluez/5406/hci0/dev_00_15_A0_0F_76_CF: HEADSET_STATE_CONNECTING
> -> HEADSET_STATE_DISCONNECTED
> bluetoothd[5406]: AVCTP: connected to 00:15:A0:0F:76:CF
> bluetoothd[5406]: Can't open input device: No such file or directory (2)
> bluetoothd[5406]: AVRCP: failed to init uinput for 00:15:A0:0F:76:CF
> bluetoothd[5406]: AVCTP Connected

I'll be offline for the next 5 days so someone else will need to look at
this one.

Johan
