Return-Path: <cyrus@holtmann.org>
Subject: Re: Question about BlueZ licenses (LGPL and Apache)
From: Marcel Holtmann <marcel@holtmann.org>
To: Madhavi Manchala <madhavi.linux@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTimiBsL60-8w4MPoP=g8Fo_+U-SrSBTa9--aqEK4@mail.gmail.com>
References: <AANLkTimiBsL60-8w4MPoP=g8Fo_+U-SrSBTa9--aqEK4@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 07 Aug 2010 07:07:00 +0200
Message-ID: <1281157620.12579.157.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Madhavi,

> I am trying to implement a custom voice codec on the android bluetooth
> platform by linking it, into the A2DP module. I have heard different
> versions from different people regarding the licenses (like LGPL and
> Apache License). So, before starting my work, I would like to know if
> I would be forced to reveal my source code, once I implement my codec
> on BlueZ stack. Please let me know, so that I can choose my platform,
> before starting my work.

BlueZ (bluetoothd and libbluetooth) is licensed under GPL 2.0 license
and nothing else. It is pretty clear in the COPYING file. There are a
few source code files licensed under LGPL, but after linking the end
result is still GPL. If in doubt ask your lawyer since nobody here on
the mailing list can give you official legal advise.

Regards

Marcel


