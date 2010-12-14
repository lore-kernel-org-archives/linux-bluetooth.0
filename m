Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>
Date: Tue, 14 Dec 2010 17:16:03 +0200
Subject: RE: [PATCH 1/4] Sim Access Profile API
Message-ID: <99B09243E1A5DA4898CDD8B7001114480BDAF72E92@EXMB04.eu.tieto.com>
References: <1291299261-26016-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20101202151938.GA32133@vigoh>
 <99B09243E1A5DA4898CDD8B7001114480BDADF2149@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114480BDADF2149@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


I see no more comments on this API. Does it mean it's fine.

/Waldek

>-----Original Message-----
>From: linux-bluetooth-owner@vger.kernel.org=20
>[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of=20
>Waldemar.Rymarkiewicz@tieto.com
>Sent: Thursday, December 02, 2010 4:23 PM
>To: padovan@profusion.mobi
>Cc: linux-bluetooth@vger.kernel.org; marcel@holtmann.org;=20
>johan.hedberg@gmail.com
>Subject: RE: [PATCH 1/4] Sim Access Profile API
>
>Hi Gustavo,
>
>>-----Original Message-----
>>From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of=20
>>Gustavo F. Padovan
>>Sent: Thursday, December 02, 2010 4:20 PM
>>To: Rymarkiewicz Waldemar
>>Cc: linux-bluetooth@vger.kernel.org; Marcel Holtmann; Johan Hedberg
>>Subject: Re: [PATCH 1/4] Sim Access Profile API
>>
>>Hi Waldemar,
>>
>>* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
>>[2010-12-02 15:14:21 +0100]:
>>
>>> New API for Sim Access Profile.
>>> ---
>>>  Makefile.am     |    2 +-
>>>  doc/sap-api.txt |   34 ++++++++++++++++++++++++++++++++++
>>>  2 files changed, 35 insertions(+), 1 deletions(-)  create
>>mode 100644
>>> doc/sap-api.txt
>>>=20
>>> diff --git a/Makefile.am b/Makefile.am index 5f96975..97345a3 100644
>>> --- a/Makefile.am
>>> +++ b/Makefile.am
>>> @@ -354,7 +354,7 @@ EXTRA_DIST +=3D doc/manager-api.txt \
>>>  		doc/service-api.txt doc/agent-api.txt
>>doc/attribute-api.txt \
>>>  		doc/serial-api.txt doc/network-api.txt \
>>>  		doc/input-api.txt doc/audio-api.txt
>>doc/control-api.txt \
>>> -		doc/hfp-api.txt doc/assigned-numbers.txt
>>> +		doc/hfp-api.txt doc/assigned-numbers.txt doc/sap-api.txt
>>
>>Leave assigned-numbers.txt in the end.
>> =20
>>>  AM_YFLAGS =3D -d
>>> =20
>>> diff --git a/doc/sap-api.txt b/doc/sap-api.txt new file mode 100644=20
>>> index 0000000..b8b7253
>>> --- /dev/null
>>> +++ b/doc/sap-api.txt
>>> @@ -0,0 +1,34 @@
>>> +BlueZ D-Bus Sim Access Profile API description
>>> +***********************************
>>> +
>>> +Copyright (C) 2010 ST-Ericsson SA
>>> +
>>> +
>>> +Sim Access Profile hierarchy
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>> +
>>> +Service		org.bluez
>>> +Interface	org.bluez.SimAccess
>>> +Object path	[variable prefix]/{hci0,hci1,...}
>>> +
>>> +Methods		void Disconnect()
>>> +
>>> +			Disconnects SAP client from the server.
>>> +
>>> +			Possible errors: org.bluez.Error.Failed
>>
>>Don't you need a Connect() method?
>
>It'a a server, not a client.  We will never initialize a connection.
>
>Thanks,
>/Waldek
>--
>To unsubscribe from this list: send the line "unsubscribe=20
>linux-bluetooth" in the body of a message to=20
>majordomo@vger.kernel.org More majordomo info at =20
>http://vger.kernel.org/majordomo-info.html
>=
