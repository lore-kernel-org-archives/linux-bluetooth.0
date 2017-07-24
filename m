Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Security modes simulation with hciconfig
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANdxJyrU9Ak-h8G8k0cErMknfNt9AnR-T3jEgBt3S5fgWCtu2g@mail.gmail.com>
Date: Mon, 24 Jul 2017 18:56:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E08ED650-3681-4E94-8DD7-786B18905BA2@holtmann.org>
References: <CANdxJyrU9Ak-h8G8k0cErMknfNt9AnR-T3jEgBt3S5fgWCtu2g@mail.gmail.com>
To: Alvin Lovi <alvinlovi80@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alvin,

> i'm trying to simulate bluetooth devices able to support PIN
> pairing/Security mode 1.
> I've tried the following commands
> 
> hciconfig hci0 sspmode 0
> hciconfig hci0 noauth
> hciconfig hci0 noencrypt
> 
> I thought the above commands were enough but i see this packet after
> the pin pairing
> 
> host-->controller    "Sent Set Connection Encryption
> (0x13)"-Encryption Enable: Link Level Encryption is ON (0x01)
> 
> This command should not be sent due to noencrypt/noauth options: is it
> true or not?

use btmgmt tool and not try to inject commands via hciconfig.

Regards

Marcel


