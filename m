Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <johan.hedberg@gmail.com>
Date: Mon, 2 May 2011 10:26:18 +0300
Subject: RE: [PATCH 1/2] Add secure param to Mgmt PIN Code Request Event
Message-ID: <99B09243E1A5DA4898CDD8B70011144816F29AF32A@EXMB04.eu.tieto.com>
References: <1303987847-6878-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1304189166.15916.98.camel@aeonflux>
In-Reply-To: <1304189166.15916.98.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,=20

>> @@ -482,6 +482,7 @@ PIN Code Request Event
>>  Event Code		0x000E
>>  Controller Index:	<controller id>
>>  Event Parameters	Address (6 Octets)
>> +			Secure (1 Octet)
>
>we do need to document possible values and their meanings. Is=20
>this a boolean or is this suppose to indicate the PIN code length?

It's boolean. =09
Do you mean something like this?

Event Code		0x000E
Controller Index:	<controller id>
Event Parameters	Address (6 Octets)
			Secure (1 Octet)

		Secure: 0x01  16 digit PIN code required
			0x00  16 digit PIN code not required

Thanks,
Waldek =
