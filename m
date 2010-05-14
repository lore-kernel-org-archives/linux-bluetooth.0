Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTilU5uaxHh0bxD5v3ZDbU1peyZXRR8RyYD_Viouh@mail.gmail.com>
References: <AANLkTilU5uaxHh0bxD5v3ZDbU1peyZXRR8RyYD_Viouh@mail.gmail.com>
Date: Fri, 14 May 2010 16:55:00 -0700
Message-ID: <AANLkTilxq-2DLLWt8uEz0IK11dt75Q_sXPP9-ch2oZPW@mail.gmail.com>
Subject: Re: Bluetooth not working with linphone
From: Grant <emailgrant@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> My bluetooth headset used to work in the voip client twinkle.
> Unfortunately twinkle has been removed from Gentoo's package tree so I
> can't test it to see if it's still working.  It works via 'aplay
> -Dbluetooth file.wav' but I can't get it to work in the voip client
> linphone at all, although others report their's working.
>
> # cat /etc/asound.conf
> pcm.bluetooth {
>        type bluetooth
>        device 00:11:22:33:44:55
>        profile "auto"
> }
>
> Does anyone know how I can troubleshoot this?  I'm on bluez-4.64.
>
> - Grant

The bluetooth headset still works with skype so it's not a bluetooth
issue.  Any suggestions for getting it working with linphone though?

- Grant
