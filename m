Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110822180151.GB21949@joana>
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>
	<1309309092.2208.25.camel@aeonflux>
	<CAHMBquWSLjzKKyM2xuMUakHeBb-FMLUWXLj2_Tz4Ye1MWj37qw@mail.gmail.com>
	<CAKT1EBfQaTSjQe6sZnC5Wx52iPmyo6SSfYD0Ci+_qb1Dbq32+g@mail.gmail.com>
	<4E3A5BFB.1050201@nokia.com>
	<4E425061.6080206@nokia.com>
	<1312984559.3373.122.camel@aeonflux>
	<4E4E592C.7060103@nokia.com>
	<20110822180151.GB21949@joana>
Date: Mon, 22 Aug 2011 15:40:53 -0300
Message-ID: <CAKT1EBfpB8DfOBgj=gwKTKGecmj-R-7gZ3zJm+8OQFekZPu7HQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Antti Julku <antti.julku@nokia.com>, ext Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com,
	ext Claudio Takahasi <claudio.takahasi@openbossa.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

On Mon, Aug 22, 2011 at 3:01 PM, Gustavo Padovan <padovan@profusion.mobi> w=
rote:
> Hi Antti,
>
> * Antti Julku <antti.julku@nokia.com> [2011-08-19 15:38:04 +0300]:
>
>>
>> Hi Marcel,
>>
>> On 08/10/2011 04:55 PM, ext Marcel Holtmann wrote:
>> >I recap, then fast connectable mode is something that is controlled by
>> >one or multiple profiles. So this is just really a on/off switch. And i=
f
>> >we support it then all profiles should just use the same settings for
>> >it. So far correct? Or do we need different values/parameters on a per
>> >profile basis?
>>
>> All profiles use same settings currently, probably no need to have
>> different configurations for profiles.
>>
>> >
>> >If I just assume the above, then we need a set of commands that can
>> >configure the settings of fast connectable mode. And that is done once
>> >when we start bluetoothd. After that it is really just toggle on and
>> >toggle off. And bluetoothd internally can keep a reference count for
>> >that.
>> >
>> >And then it makes sense to do the same for LE and BR/EDR. It is either
>> >on or off. Just the initial parameter set for LE is configured
>> >differently.
>>
>> So one command which switches fast connectable on/off for both BR
>> and LE? And two for configuration? =C2=A0Maybe something like this?
>>
>> Set Fast Connectable Command
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>
>> Command Code: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0001F
>> Controller Index: =C2=A0 =C2=A0 =C2=A0 <controller id>
>> Command Parameters: =C2=A0 =C2=A0 Enable (1 Octet)
>> Return Parameters: =C2=A0 =C2=A0 =C2=A0Status (1 octet)
>>
>> Configure BR Fast Connectable Mode Command
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Command Code: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00020
>> Controller Index: =C2=A0 =C2=A0 =C2=A0 <controller id>
>> Command Parameters: =C2=A0 =C2=A0 Page_scan_type (1 Octet)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Page_scan_interval (1 Octet)
>> Return Parameters: =C2=A0 =C2=A0 =C2=A0Status (1 octet)
>>
>> Configure LE Fast Connectable Mode Command
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Command Code: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00021
>> Controller Index: =C2=A0 =C2=A0 =C2=A0 <controller id>
>> Command Parameters: =C2=A0 =C2=A0 Adv_interval (1 Octet)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ...and maybe some other settings if needed
>> Return Parameters: =C2=A0 =C2=A0 =C2=A0Status (1 octet)
>
> Can't both command be merged into one? LE Advertisement could be a scan t=
ype.
> But this won't work if we need more settings for LE.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Gustavo
>

Another input: for GATT based profiles after the disconnection the
specs are recommending advertising interval values for fast
reconnection in the first 30 seconds and reduced power mode after 30
seconds.
Of course, there are some implementations that disable advertising
after some time.

At the moment, the incoming connection for dual mode device are not
allowed by the spec.

My opinion is: parameters could be omitted. BR/EDR and LE could use
hard-coded settings for on/off of each transport. Add BR/EDR or LE
specific parameter in the Management interface commands doesn't look a
suitable approach. A simple on/off command seems to be more flexible
for future changes.

BR,
Claudio.
