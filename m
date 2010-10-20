Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <suraj@Atheros.com>
CC: <linux-bluetooth@vger.kernel.org>, <marcel@holtmann.org>,
	<Suraj.Sumangala@Atheros.com>, <johan.hedberg@gmail.com>,
	<joakim.xj.ceder@stericsson.com>, <arunkr.singh@stericsson.com>
Date: Wed, 20 Oct 2010 11:47:13 +0300
Subject: RE: [PATCH 1/1] Add Sim Access Plugin
Message-ID: <99B09243E1A5DA4898CDD8B700111448097D1DCFD3@EXMB04.eu.tieto.com>
References: <1287561308-18611-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1287561308-18611-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <4CBEAA45.4010702@Atheros.com>
In-Reply-To: <4CBEAA45.4010702@Atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

>>   create mode 100644 sap/sap-ste.c
>I am assuming that this is the ST specific plugin. May be you=20
>can just keep the dummy plugin only so that someone can use=20
>that as a reference.

In fact, you are right. Will remove this for the time being.=20

>>   create mode 100644 sap/sap.h
>>   create mode 100644 sap/server.c
>>   create mode 100644 sap/server.h
>
>I guess it would be better if you can split this into multiple=20
>patches so that it would be easier to review.

Ok.=20

Regards,
/Waldek
