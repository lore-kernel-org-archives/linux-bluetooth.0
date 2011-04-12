Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1302605974.2572.258.camel@aeonflux>
References: <anderson.briglia@openbossa.org>
	<1302567158-18617-2-git-send-email-anderson.briglia@openbossa.org>
	<1302581196.2572.249.camel@aeonflux>
	<BANLkTinoW_bjCw=DwS2pMg-eM06Yq3MXLg@mail.gmail.com>
	<1302605974.2572.258.camel@aeonflux>
Date: Tue, 12 Apr 2011 07:46:49 -0400
Message-ID: <BANLkTinOJGPTfQwjTi7mXEWHWKAd0aX6Zw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MTU configuration for LE links
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Briglia <anderson.briglia@openbossa.org>, linux-bluetooth@vger.kernel.org,
	ville.tervo@nokia.com, johan.hedberg@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Apr 12, 2011 at 6:59 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>> One thing to consider is that there are a couple of MTU checks along
>> the L2CAP code. The issue which originated this patch is code such as:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check outgoing MTU */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len > pi->omtu) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EMSGSIZE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> We understood that just letting omtu/imtu values on kernel reflect the
>> current connection MTU settings was the cleanest solution. What do you
>> propose? Bypassing these checks for LE?
>
> this does not look clean to me. And we might have an internal MTU
> variable as part of L2CAP, but the way how it gets set and thus its
> semantic differs clearly between BR/EDR and LE. So shoehorning an
> existing socket option this is clearly a bad idea.

Sure. What to do then if:

1) LE links have MTU (omtu specifically) hard-coded to 23 on kernel.
2) the kernel rejects sending data longer than omtu.

(this is the current situation)

This clearly needs some fix on kernel side, otherwise we can't send
PDUs longer than the LE default MTU (23), *even* if the peer device
supports a bigger MTU.

Suggestions are welcome regarding how to best approach this, without
affecting current BR/EDR MTU semantics.

Regards,
--=20
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
