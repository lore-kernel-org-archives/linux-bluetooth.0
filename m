Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1271085759.6731.6348.camel@localhost.localdomain>
References: <1270898546.5646.28.camel@localhost.localdomain>
	 <l2r2a9506371004100717p500f6b4o48e8a6d2dfb8f0c5@mail.gmail.com>
	 <1271085759.6731.6348.camel@localhost.localdomain>
Date: Wed, 14 Apr 2010 10:19:53 +0300
Message-ID: <p2q2d5a2c101004140019w21c6e680s47159a70d9f0bac7@mail.gmail.com>
Subject: Re: obexd-0.22 causes gnome-bluetooth sendto dialog to stop closing
	when operation ends
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	pacho@condmat1.ciencias.uniovi.es, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 12, 2010 at 6:22 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Sat, 2010-04-10 at 11:17 -0300, Vinicius Gomes wrote:
>> Hi Pacho,
>>
>> 2010/4/10 Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>:
>> > Hello
>> >
>> > This is a regression over obexd-0.21. After updating to 0.22,
>> > gnome-bluetooth sendto dialog no longer closes when operation finishes,
>> > even if file is already properly sent.
>> >
>>
>> We noticed this regression as well. Luiz already has a fix for this,
>> it was just not integrated yet.
>>
>> In case you want to take a look and perhaps help test it, the fix is here[1].
>
> Except that the patch is absolutely huge, and doesn't apply cleanly on
> 0.22 either.

For those wanting to have a quick fix for 0.22 you can revert
d57bffe46b71e17a640c11b389dd6da95f933729, which cause the extra
reference to be hold. In the meantime I will be doing some cleanups to
session code and moving the transfer logic to a separate file those
changes will probably be only available in 0.23.

-- 
Luiz Augusto von Dentz
Computer Engineer
