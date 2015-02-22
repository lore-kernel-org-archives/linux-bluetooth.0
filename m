Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1832240.mNuY6LIF5L@moneypit>
Date: Sun, 22 Feb 2015 12:53:06 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A863E4B8-1461-4680-A8CE-40FDDB04858B@holtmann.org>
References: <1832240.mNuY6LIF5L@moneypit>
To: "Gregory M. Turner" <gmt@be-evil.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gregory,

> From b222223a4410587ea21b20841581f22614432b77 Mon Sep 17 00:00:00 2001
> From: "Gregory M. Turner" <gmt@be-evil.net>
> Date: Sun, 22 Feb 2015 10:54:06 -0800
> Subject: [PATCH] bluetooth/l2cap: silence framedrop kmsg noise
> 
> For years, my logs have often looked like this:
> 
>    # dmesg | wc -lc ; \
>      dmesg | grep -v \
>          'Bluetooth: Unexpected continuation frame (len 0)' \
>          | wc -lc
>      32769 2096857
>         85    5081
> 
> Google suggests I'm not alone in this.  AFAICT, it means:
> 
>    "Hey, kernel, here.  I was trying to talk to some gizmo by way
>    of your tiny $2.50 USB dongle broadcasting a 2.4Ghz near-field
>    RF protocol.  Inexplicably, there was some sort of RFI or
>    dropout!  I'm deeply offended, and taking it personally.  I'll
>    remind you again a few microseconds if the problem continues."
> 
> Surely this is causing more harm than benefit; silence the kmsg
> unless the frame is nonempty.

can you send a btmon trace for this and be more specific which devices are these. There seems to be something really off going on here.

Regards

Marcel

