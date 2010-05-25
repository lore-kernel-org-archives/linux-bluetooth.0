Return-Path: <cyrus@holtmann.org>
Message-ID: <4BFBC919.8030604@greffrath.com>
Date: Tue, 25 May 2010 14:56:57 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: WRT non-UTF-8 device names
References: <1274432516.4068.29.camel@vfrodo> <1274791119.27274.17718.camel@localhost.localdomain>
In-Reply-To: <1274791119.27274.17718.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 25.05.2010 14:38, schrieb Bastien Nocera:
> The output of "locale" as root would probably help.

Here you are:
$ su -c locale
LANG=de_DE.UTF-8
LC_CTYPE="de_DE.UTF-8"
LC_NUMERIC="de_DE.UTF-8"
LC_TIME="de_DE.UTF-8"
LC_COLLATE="de_DE.UTF-8"
LC_MONETARY="de_DE.UTF-8"
LC_MESSAGES="de_DE.UTF-8"
LC_PAPER="de_DE.UTF-8"
LC_NAME="de_DE.UTF-8"
LC_ADDRESS="de_DE.UTF-8"
LC_TELEPHONE="de_DE.UTF-8"
LC_MEASUREMENT="de_DE.UTF-8"
LC_IDENTIFICATION="de_DE.UTF-8"
LC_ALL=

> My guess is that we make assumptions as to a user entry being valid
> UTF-8 somewhere, when it could be non-UTF-8.
>
> As for your problem, I don't think we want to allow non-UTF-8 device
> names anyhow. They're not valid spec.

Sure, that's why my patch converts the device name to valid UTF-8 as 
soon as it is possible to detect that it is actually non-UTF-8. 
However, it may be right that this approach only fixes the symptoms 
and does not cure the illness. But my knowledge of the Bluez code is 
not deep enough to track down the real issue on my own.

Thanks for your reply anyway,
Fabian
