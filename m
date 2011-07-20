Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1311156825.21109.204.camel@aeonflux>
References: <CAJx1FMOaDBWHGP8+-FkKVD_pTKC7n8NYm8fAdDGHzRwZw8ikyA@mail.gmail.com>
	<1311156825.21109.204.camel@aeonflux>
Date: Wed, 20 Jul 2011 19:53:24 +0900
Message-ID: <CAJx1FMP0DL=wJzNW5Qaxw8RhOtmPjgeL2pxekNL_7eEKoVYa-g@mail.gmail.com>
Subject: Re: Question about bluez audio plug-in license
From: "Chanyeol,Park" <chanyeol.park@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz-von@nokia.com
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

2011/7/20 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
>> I have a question about bluez audio plug-in license. Is it possible to u=
se
>> bluez audio plug-in as LGPL? About half year ago I saw bluez and pulseau=
dio
>> introduced =93a2dp-codecs.h=94. As far as I understand bluez audio plug-=
in
>> license could be LGPL. However the header file license is GPL.
>>
>> and I think even if we use MediaEndpoint with dbus, we need to include
>> =93a2dp-codec.h=94.
>>
>> If you know, could you explain this?
>
> the specific file a2dp-codec.h can be easily licensed under LGPL. Same
> as with rth.h. Both file are clearly an oversight on our part. Code that
> is shared between PA and BlueZ should be LGPL license. For the SBC
> encoder/decoder and IPC parts we have done that right. So yes, we can
> just re-license these two header files.

Where could I find "rth.h"? Will you change license of "a2dp-codec.h"?

>
> However for the whole audio plugin, no that is GPL only.
>
> Regards
>
> Marcel
>
>
>

Regards

Chanyeol Park
