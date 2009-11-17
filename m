Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1258491418.2003.37.camel@violet>
References: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
	 <1258286232.3299.27.camel@violet>
	 <c6e9632c0911170853g5ef4061cr75c42c71a1a87b7d@mail.gmail.com>
	 <1258491418.2003.37.camel@violet>
Date: Tue, 17 Nov 2009 22:18:59 +0100
Message-ID: <c6e9632c0911171318l1b60fa85h55b3e6083777d516@mail.gmail.com>
Subject: Re: Getting/setting Inquiry trasmit power level unsolved
From: Natale Vinto <ebballon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
I'm sorry I didn't even know  the meaning of top-posting before this
email, I just answered using gmail.

> # hciconfig hci0 inqtpl
> hci0:   Type: USB
>        BD Address: 00:19:DB:xx:xx:xx ACL MTU: 310:10 SCO MTU: 64:8
>        Inquiry transmit power level: 4
>
> # hcidump -X -V
> < HCI Command: Read Inquiry Response Transmit Power Level (0x03|0x0058) plen 0
>> HCI Event: Command Complete (0x0e) plen 5
>    Read Inquiry Response Transmit Power Level (0x03|0x0058) ncmd 1
>    status 0x00 level 4
>
> Looks all good to me and works perfectly fine with the CSR dongle, I
> tested this with.
>
So I'll try only with CSR dongles, thank you for useful informations.

Best Regards


-- 
Natale Vinto
http://www.hictech.com
http://bluesman.gotext.org
