Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 6/6] Bluetooth: Support LE-Only discovery procedure
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <20111117085904.GB415@aemeltch-MOBL1>
Date: Thu, 17 Nov 2011 13:40:58 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <96CBB208-52F5-4E32-B2F2-DA7959360D89@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org> <1321051824-5216-7-git-send-email-andre.guedes@openbossa.org> <20111114100806.GC13665@aemeltch-MOBL1> <95D6271C-626F-409E-B4AB-92F6C7E2AC15@openbossa.org> <20111117085904.GB415@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Nov 17, 2011, at 5:59 AM, Andrei Emeltchenko wrote:

> Hi Andre,
> 
> On Wed, Nov 16, 2011 at 05:36:38PM -0300, Andre Guedes wrote:
> 
> ...
> 
>>>> 
>>>> 	if (cp->enable == 0x01) {
>>> 
>>> Can we fix also magic number here and below?
>> 
>> I see your point here, but this is not a magic number, it is
>> just a true/false value.
> 
> If this true/false no need to compare with hex numbers why not
> 
> if(cp->enable) 
> 	...

Yes, sure, it could be done like that. I might do it in a later
patch so.

Thanks,

Andre
