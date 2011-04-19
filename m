Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1302736838.2572.262.camel@aeonflux>
References: <anderson.briglia@openbossa.org> <1302567158-18617-2-git-send-email-anderson.briglia@openbossa.org>
 <1302581196.2572.249.camel@aeonflux> <BANLkTinoW_bjCw=DwS2pMg-eM06Yq3MXLg@mail.gmail.com>
 <1302605974.2572.258.camel@aeonflux> <BANLkTinOJGPTfQwjTi7mXEWHWKAd0aX6Zw@mail.gmail.com>
 <1302736838.2572.262.camel@aeonflux>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Tue, 19 Apr 2011 17:50:27 -0400
Message-ID: <BANLkTimez87G5-PnbDr8JPOuY7OU8+M25Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MTU configuration for LE links
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>, linux-bluetooth@vger.kernel.org,
	ville.tervo@nokia.com, johan.hedberg@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Apr 13, 2011 at 7:20 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Anderson,
>
>> >> One thing to consider is that there are a couple of MTU checks along
>> >> the L2CAP code. The issue which originated this patch is code such as=
:
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check outgoing MTU */
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len > pi->omtu) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EMSGSIZE;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> >>
>> >> We understood that just letting omtu/imtu values on kernel reflect th=
e
>> >> current connection MTU settings was the cleanest solution. What do yo=
u
>> >> propose? Bypassing these checks for LE?
>> >
>> > this does not look clean to me. And we might have an internal MTU
>> > variable as part of L2CAP, but the way how it gets set and thus its
>> > semantic differs clearly between BR/EDR and LE. So shoehorning an
>> > existing socket option this is clearly a bad idea.
>>
>> Sure. What to do then if:
>>
>> 1) LE links have MTU (omtu specifically) hard-coded to 23 on kernel.
>> 2) the kernel rejects sending data longer than omtu.
>>
>> (this is the current situation)
>>
>> This clearly needs some fix on kernel side, otherwise we can't send
>> PDUs longer than the LE default MTU (23), *even* if the peer device
>> supports a bigger MTU.
>
> I agree with that. Userspace needs to be able to change the kernel MTU
> if a different one gets negotiated. That is not the problem. The problem
> is trying to shoehorn this into an existing (and already declared
> legacy) socket option.
>
>> Suggestions are welcome regarding how to best approach this, without
>> affecting current BR/EDR MTU semantics.
>
> We need to have a socket option that allows us the dynamically change
> the MTU of a L2CAP link. And right now this option will only be valid if
> the link is actually an LE link.

Ok, so we have some options IMHO:

a) Do not add a new option in struct l2cap_options because it will
still be hijacking.

b) Add a new option for LE OMTU in struct l2cap_conninfo. Is it valid?

c) Add a new struct (l2cap_le_options ?) and add a omtu field there.

The problem in c) is that we will have to implement significant
modifications in userspace and the code should be redundant: we will
have two options to represent the same value.

Regards,

Anderson Briglia

>
> Regards
>
> Marcel
>
>
>



--=20
INdT - Instituto Nokia de tecnologia
+55 2126 1122
http://techblog.briglia.net
