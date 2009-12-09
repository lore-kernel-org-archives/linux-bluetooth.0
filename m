Return-Path: <cyrus@holtmann.org>
Message-ID: <4B1F6B12.1060509@atheros.com>
Date: Wed, 9 Dec 2009 14:47:06 +0530
From: Bala Shanmugam <sbalashanmugam@atheros.com>
MIME-Version: 1.0
To: Julian Calaby <julian.calaby@gmail.com>
CC: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>,
	"mcgrof@bombadil.infradead.org" <mcgrof@bombadil.infradead.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Added compat-bluetooth to compat-wireless-2.6
References: <20091208073542.GC22204@atheros-laptop> <646765f40912081444t64d94ac3k9bcea8b5296a9591@mail.gmail.com>
In-Reply-To: <646765f40912081444t64d94ac3k9bcea8b5296a9591@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Yes Julian.  REAME has to be updated.
Will do that shortly.

Regards,
Bala.
Julian Calaby wrote:
> On Tue, Dec 8, 2009 at 18:35, Bala Shanmugam <sbalashanmugam@atheros.com> wrote:
>   
>> Added compat-bluetooth to compat-wireless-2.6
>>
>> Added new scripts to load and unload wireless
>> and bluetooth modules seperately.
>>
>> Compat is compiled as separate kernel module as
>> both wireless and bluetooth modules require it.
>>
>> Compat Bluetooth has support to compile latest bluetooth code
>> for kernel versions 2.6.27 to 2.6.31.
>>     
>
> Should all this new functionality be documented in the README document?
>
> Thanks,
>
> --
>
> Julian Calaby
>
> Email: julian.calaby@gmail.com
> .Plan: http://sites.google.com/site/juliancalaby/
> .
>
>   

