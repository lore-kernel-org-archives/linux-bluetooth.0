Return-Path: <cyrus@holtmann.org>
Message-ID: <4BF100A6.6070007@greffrath.com>
Date: Mon, 17 May 2010 10:39:02 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: Stefan Seyfried <stefan.seyfried@googlemail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Instantly fix non-UTF-8 local device names during device
 configuration phase
References: <4BE14458.1020908@greffrath.com> <4BE14819.4080903@greffrath.com> <20100505170202.3d6b1dcb@susi.home.s3e.de> <1273156964.25110.1.camel@vfrodo> <20100506150228.GA20880@jh-x301>
In-Reply-To: <20100506150228.GA20880@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 06.05.2010 17:03, schrieb Johan Hedberg:
> BlueZ will (or at least should) set the name for the adapter as follows:
>
> 1. If there's a name in /var/lib/bluetooth/... use that
> 2. Else if there's a name in main.conf use that
> 3. If all else fails set the name to "BlueZ"

Hm, IIRC it was set to $(hostname)-$(hci-id) last time I established a 
connection.

> So I fail to see why this patch is needed at all. It sounds like there's
> something else wrong in the initialization process which makes the
> initialzation fail if the adapter contains some invalid default name (we
> shouldn't as far as I see be trying to read the name at all from the
> adapter before we've written it ourselves from the host side). I.e. I
> suspect the patch might be just working around the real issue instead of
> fixing it.

Yes, obviously Bluez fails to set a reasonable device name if the 
initial device name isn't already valid. However, I believe Bluez 
shouldn't necessarily be expected to handle invalid device names, as 
they clearly violate the specs. Instead, if Bluez detects an invalid 
name, it should convert it into a valid name as soon in the 
initialization process as possible. This sounds just naturally to me 
and is exactly what my patch does.

Cheers,
Fabian
