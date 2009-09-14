Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <e0ab60670909141117t697926f6gf309b1f24052162b@mail.gmail.com>
References: <5d223510909040942u7ee2ae0ds96e1321b1fab24b9@mail.gmail.com>
	 <e0ab60670909141117t697926f6gf309b1f24052162b@mail.gmail.com>
Date: Mon, 14 Sep 2009 14:47:53 -0600
Message-ID: <d89ddf300909141347s27d3437ft7d93c9dd16e89bfe@mail.gmail.com>
Subject: Re: choppy audio on ARM
From: Brad Midgley <bmidgley@gmail.com>
To: Douglas Lopes Pereira <douglaslopespereira@gmail.com>
Cc: Rafael Seste <rseste@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Douglas

> - Connecting bluetooth dongle over USB Hub:
>
> usb 1-1: new high speed USB device using orion-ehci and address 19
> usb 1-1: configuration #1 chosen from 1 choice
> hub 1-1:1.0: USB hub found
> hub 1-1:1.0: 4 ports detected
> usb 1-1.3: new full speed USB device using orion-ehci and address 20
> usb 1-1.3: configuration #1 chosen from 1 choice
>
> - Connecting bluetooth directly on Sheeva Plug:
>
> usb 1-1: new full speed USB device using orion-ehci and address 14
> usb 1-1: configuration #1 chosen from 1 choice

"lsusb" in both cases should shed more light on the topology and where
full speed links creep in.

-- 
Brad Midgley
