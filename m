Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347284864.3532.1.camel@sirocco.hadess.net>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	<20120907124559.GA16092@x220>
	<CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	<1347284864.3532.1.camel@sirocco.hadess.net>
Date: Mon, 10 Sep 2012 16:58:50 +0300
Message-ID: <CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: David Dillow <dave@thedillows.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Sep 10, 2012 at 4:47 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Em Mon, 2012-09-10 às 16:11 +0300, Luiz Augusto von Dentz escreveu:
>> Hi David, Bastien,
>>
>> So we are plannin to rid of the fakehid.c in favor of implementing it
>> properly inside the kernel similarly to what was done to wiimote, so
>> is there any obstacle for doing that?
>>
>> The kernel seems to already have some support for sixaxis in
>> drivers/hid/hid-sony.c, so I suppose the following would enable us to
>> use it:
>
> It won't. They're not the same hardware.

What hardware is that then? And why wouldn't the kernel be able to
support even if it is a different driver?

-- 
Luiz Augusto von Dentz
