Return-Path: <cyrus@holtmann.org>
Message-ID: <4BE18B3D.5020507@greffrath.com>
Date: Wed, 05 May 2010 17:14:05 +0200
From: Fabian Greffrath <fabian@greffrath.com>
MIME-Version: 1.0
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Detect invalid (i.e. non-UTF-8) device names and fix them during
 initialization phase
References: <4BE14458.1020908@greffrath.com>	<4BE14819.4080903@greffrath.com> <20100505170202.3d6b1dcb@susi.home.s3e.de>
In-Reply-To: <20100505170202.3d6b1dcb@susi.home.s3e.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 05.05.2010 17:02, schrieb Stefan Seyfried:
> I have one questions about the code from a cursory look (hint:
> sending the patch inline would help commenting on it)

Alright, I'll know for the next time.

> * where does the 249 in "char name[249];" come from? Is it from the BT
>    spec? Or from somewhere else? A comment in the code might help. (If this
>    is a number from the spec that is used all over the same code file and
>    explained elsewhere, this question is obviously moot)

I took this part of the patch over from tools/hciconfig.c:433 and 
indeed I think the fact that a device name may be up to 248 characters 
long is part of the BT spec: 
<http://www.palowireless.com/infotooth/tutorial/k1_gap.asp#Bluetooth%20Parameter%20Representation>

> Then it would probably good if you could send the patch against current
> git (even if it still applies cleanly) and in a format that "git am" can
> process directly. That makes it very easy for the maintainers to apply the
> code and in the same run makes sure you get proper attribution for your
> contribution ;)

Thanks again. I'd like to get some more feedback for the current patch 
and will then repost it in the desired format.

BTW, I'll be on vacation from May 7th to 14th, so please excuse if I 
reply with some days delay.
