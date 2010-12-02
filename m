Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>, <marcel@holtmann.org>,
	<johan.hedberg@gmail.com>
Date: Thu, 2 Dec 2010 17:23:19 +0200
Subject: RE: [PATCH 1/4] Sim Access Profile API
Message-ID: <99B09243E1A5DA4898CDD8B7001114480BDADF2149@EXMB04.eu.tieto.com>
References: <1291299261-26016-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20101202151938.GA32133@vigoh>
In-Reply-To: <20101202151938.GA32133@vigoh>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>-----Original Message-----
>From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf=20
>Of Gustavo F. Padovan
>Sent: Thursday, December 02, 2010 4:20 PM
>To: Rymarkiewicz Waldemar
>Cc: linux-bluetooth@vger.kernel.org; Marcel Holtmann; Johan Hedberg
>Subject: Re: [PATCH 1/4] Sim Access Profile API
>
>Hi Waldemar,
>
>* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>=20
>[2010-12-02 15:14:21 +0100]:
>
>> New API for Sim Access Profile.
>> ---
>>  Makefile.am     |    2 +-
>>  doc/sap-api.txt |   34 ++++++++++++++++++++++++++++++++++
>>  2 files changed, 35 insertions(+), 1 deletions(-)  create=20
>mode 100644=20
>> doc/sap-api.txt
>>=20
>> diff --git a/Makefile.am b/Makefile.am index 5f96975..97345a3 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -354,7 +354,7 @@ EXTRA_DIST +=3D doc/manager-api.txt \
>>  		doc/service-api.txt doc/agent-api.txt=20
>doc/attribute-api.txt \
>>  		doc/serial-api.txt doc/network-api.txt \
>>  		doc/input-api.txt doc/audio-api.txt=20
>doc/control-api.txt \
>> -		doc/hfp-api.txt doc/assigned-numbers.txt
>> +		doc/hfp-api.txt doc/assigned-numbers.txt doc/sap-api.txt
>
>Leave assigned-numbers.txt in the end.
> =20
>>  AM_YFLAGS =3D -d
>> =20
>> diff --git a/doc/sap-api.txt b/doc/sap-api.txt new file mode 100644=20
>> index 0000000..b8b7253
>> --- /dev/null
>> +++ b/doc/sap-api.txt
>> @@ -0,0 +1,34 @@
>> +BlueZ D-Bus Sim Access Profile API description
>> +***********************************
>> +
>> +Copyright (C) 2010 ST-Ericsson SA
>> +
>> +
>> +Sim Access Profile hierarchy
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> +
>> +Service		org.bluez
>> +Interface	org.bluez.SimAccess
>> +Object path	[variable prefix]/{hci0,hci1,...}
>> +
>> +Methods		void Disconnect()
>> +
>> +			Disconnects SAP client from the server.
>> +
>> +			Possible errors: org.bluez.Error.Failed
>
>Don't you need a Connect() method?

It'a a server, not a client.  We will never initialize a connection.

Thanks,
/Waldek
