Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <f9d4bd31002101510y1435f74ev886d7993959990ff@mail.gmail.com>
References: <f9d4bd31002101510y1435f74ev886d7993959990ff@mail.gmail.com>
Date: Thu, 11 Feb 2010 17:48:30 +0200
Message-ID: <2d5a2c101002110748l5d3b9c23g174dc9cee0e07f12@mail.gmail.com>
Subject: Re: [PATCH] Fix segmentation fault when headset disconnects during
	authorization
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 11, 2010 at 1:10 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi guys,
>
> This patch fix a segmentation fault when the headset disconnected
> during authorization, see gdb backtrace:
> http://pastebin.com/m1529c2dc
>
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

I thought this was already upstream, well anyway about the AVCTP I
just noticed that we are not dropping it the if uinput failed to load,
I guess we should don't we? Also the AVCTP should be queue in the list
of pending authorizations and then group with AVDTP authorization (if
exists) since both are very common to happen in sequence.

Regards,



-- 
Luiz Augusto von Dentz
Computer Engineer
