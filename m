Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 28 Dec 2015 10:18:22 +0100
From: Antonio Ospite <ao2@ao2.it>
To: Martin =?ISO-8859-1?Q?Kj=E6r_J=F8rgensen?= <mkj@gotu.dk>
Cc: linux-bluetooth@vger.kernel.org,
	Frank Praznik <frank.praznik@gmail.com>
Subject: Re: DS4 issues
Message-Id: <20151228101822.03253569407ac9dfe4ea15be@ao2.it>
In-Reply-To: <20151221144607.GA18773@mkjlap.gotu.dk>
References: <20151221144607.GA18773@mkjlap.gotu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 21 Dec 2015 15:46:07 +0100
Martin Kjær Jørgensen <mkj@gotu.dk> wrote:

> Is there any "full" support for a Sony DualShock 4 in the bluez/kernel
> stack?
>

CC-ing Frank as he is the author of the DS4 hid kernel driver.

> The one I own works perfectly when using USB cable.
> 
> When using bluetooth it gets recognized as a somewhat generic
> Bluetooth Wireless Controller. Pairing it up with my system seems to
> work as it creates a joystick device (/dev/input/js0) but when testing
> it with jstest, only the touchpad on the DS4 triggers two of the
> axis. None of the buttons or sticks reacts in jstest.
> Pairing it with the usual bluetoothctl makes the DS4 LED dimmed blue
> light.
> 
> I know of the ds4drv project and have used it to connect my DS4, but
> it seems a big buggy and I was hoping it was or will be merged into
> bluez/kernel, making it superfluous.
> 
> Using the DS4 makes the LED brighter than using ordinary bluetoothctl,
> perhaps because ds4drv knows how to intruct the LED.
> Even if my DS4 is almost next to my bluetooth radio device, the ds4drv
> reports "Signal strength low (29/40/38) reports"
> Testing with jstest seems to trigger all buttons and axises. The
> touchpad itself as a button triggers, but touching the pad doesnt trigger
> anything.
> In some games the digital keys on the left doesnt get recognized, even
> if they get triggered by jstest and other programs like Steam
> recognizes them.
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
