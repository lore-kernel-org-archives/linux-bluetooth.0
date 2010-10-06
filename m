Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <suraj@Atheros.com>
CC: <marcel@holtmann.org>, <Suraj.Sumangala@Atheros.com>,
	<linux-bluetooth@vger.kernel.org>, <Jothikumar.Mothilal@Atheros.com>,
	<joakim.xj.ceder@stericsson.com>, <arunkr.singh@stericsson.com>
Date: Wed, 6 Oct 2010 13:13:09 +0300
Subject: RE: Sim Access profile server implementation
Message-ID: <99B09243E1A5DA4898CDD8B700111448097D01B868@EXMB04.eu.tieto.com>
References: <1285657515.12097.7.camel@atheros013-desktop>
	 <1286265730.17473.29.camel@aeonflux>
	 <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com>
 <1286280767.17473.89.camel@aeonflux>
 <99B09243E1A5DA4898CDD8B700111448097D01B6CF@EXMB04.eu.tieto.com>
 <99B09243E1A5DA4898CDD8B700111448097D01B814@EXMB04.eu.tieto.com>
 <4A2A3D7B.60701@Atheros.com>
In-Reply-To: <4A2A3D7B.60701@Atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi suraj,=20

>Which part of this is the driver and which is the agent here?

sap-ste.c is a driver for u8500 platform. The agent is not involved in this=
 design.

>If I am not mistaken, you are sending the responses directly=20
>from code here, how can we extend this to another=20
>hardware/agent without source code change?

You are right. You can add a new driver that implements interfaces in sap.h=
 then configure with ./configure --enable-sap=3Dyes --with-sap=3DDRIVER
You don't have to modify the code, but you have to rebuild with your driver=
. Usually, there will be one driver per platform so it shoudl not be a prob=
lem.

>I don't see D-bus being used other than for set/get property.

We use D-bus only for enable/disable sap server. Data flow to sim is done o=
ver unix sockets (for u8500) as I have doubts to dbus reliability. However,=
 it's good option to do tests with dbus oriented design as discussed before=
.

>Correct me if my understanding is wrong.
>

Regards,
/Waldek=
