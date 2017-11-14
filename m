Return-Path: <jaganathx.kanakkassery@intel.com>
From: "Kanakkassery, JaganathX" <jaganathx.kanakkassery@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>, Jaganath Kanakkassery
	<jaganath.k.os@gmail.com>
CC: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH 3/3] doc/mgmt-api: Add advertising phys support to flags
Date: Tue, 14 Nov 2017 12:27:37 +0000
Message-ID: <65A6897373DD1D478DA815A9759D0E0A6661D0AF@BGSMSX108.gar.corp.intel.com>
References: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1510655538-12883-5-git-send-email-jaganathx.kanakkassery@intel.com>
 <45F5B873-D619-4EDB-89F9-BA14447AA7F6@holtmann.org>
In-Reply-To: <45F5B873-D619-4EDB-89F9-BA14447AA7F6@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>Hi Jaganath,

>> Technically it is possible to advertise on LE Coded in Primary and LE=20
>> 1M/2M in secondary, but that is not added in the interface since=20
>> advertising in Coded means that scanners are expected to be in long=20
>> range and then advertising in other phys in secondary does not make=20
> >sense.
> >---
>> doc/mgmt-api.txt | 12 ++++++++++++
> >1 file changed, 12 insertions(+)
>>=20
> >diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt index=20
>> 25739cc..fe1c0a5 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -2613,6 +2613,8 @@ Add Advertising Command
> >		4	Add TX Power field to Adv_Data
>> 		5	Add Appearance field to Scan_Rsp
>> 		6	Add Local Name in Scan_Rsp
>> +		7 	Advertise in Coded PHY
>> +		8	Advertise in 2M PHY
>>=20
>> 	When the connectable flag is set, then the controller will use
>> 	undirected connectable advertising. The value of the connectable @@=20
>> -2640,6 +2642,16 @@ Add Advertising Command
> >	supported to provide less air traffic for devices implementing
> >	broadcaster role.
> >
> >+	Advertising PHY flags should be used only if the controller
>> +	supports the corresponding phy which can be retrieved using
>> +	Get Supported Phys command otherwise Invalid Parameter would
>> +	be returned. If none of the flags are set and if controller
>
>this has nothing to do with supported PHYs command. We have supported flag=
s here and for advertising we need to treat this >independent.

Ok...i missed that, so Read Advertising Features Command also needs to be u=
pdated with new flags

> +	supports extended advertising then 1M would be used for both
> +	Primary and Secondary channel. If 2M is set then 1M
> +	would be selected for primary and 2M for secondary channel.
> +	If Coded is set then it would be used for both primary
> +	and secondary channels.
> +
>
>I think it might be more important that we use it like this:

>	7  Secondary Channel with LE 1M
>	8  Secondary Channel with LE 2M
>	9  Secondary Channel with LE Coded
>
>Specifying either of the three bits will result in extended advertising to=
 be used. If not of them are set, then legacy advertising is used.

If I understood you correctly, you are suggesting to use legacy and extende=
d
advertising together (If in one Add adv none of them are set and in another
if atleast one of them is set). But I think it is not allowed by the spec.

As per spec, legacy and extended advertising commands cannot be used in
one power on session.=20

I was thinking of using extended advertising always if controller supports
so that it will by-pass the current multi adv by host and enables controlle=
r
to rotate the instances?=20
I think it has some power saving advantage since
host does not need to be awake to rotate the adv instances.

>Combining them will result into multiple advertising sets to be created. I=
f you specify all 3, then we actually required 3 advertising sets >to be pr=
ogrammed.

Thanks,
Jaganath
