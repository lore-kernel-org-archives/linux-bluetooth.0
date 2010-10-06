Return-Path: <cyrus@holtmann.org>
Message-ID: <4CAC6E61.20708@Atheros.com>
Date: Wed, 6 Oct 2010 18:11:05 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: "Waldemar.Rymarkiewicz@tieto.com" <Waldemar.Rymarkiewicz@tieto.com>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>, "joakim.xj.ceder@stericsson.com"
	<joakim.xj.ceder@stericsson.com>, "arunkr.singh@stericsson.com"
	<arunkr.singh@stericsson.com>
Subject: Re: Sim Access profile server implementation
References: <1285657515.12097.7.camel@atheros013-desktop>	 <1286265730.17473.29.camel@aeonflux>	 <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com> <1286280767.17473.89.camel@aeonflux> <99B09243E1A5DA4898CDD8B700111448097D01B6CF@EXMB04.eu.tieto.com> <99B09243E1A5DA4898CDD8B700111448097D01B814@EXMB04.eu.tieto.com> <4A2A3D7B.60701@Atheros.com> <99B09243E1A5DA4898CDD8B700111448097D01B868@EXMB04.eu.tieto.com>
In-Reply-To: <99B09243E1A5DA4898CDD8B700111448097D01B868@EXMB04.eu.tieto.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On 10/6/2010 3:43 PM, Waldemar.Rymarkiewicz@tieto.com wrote:
> Hi suraj,
>
>> Which part of this is the driver and which is the agent here?
>
> sap-ste.c is a driver for u8500 platform. The agent is not involved in this design.
>
>> If I am not mistaken, you are sending the responses directly
>>from code here, how can we extend this to another
>> hardware/agent without source code change?
>
> You are right. You can add a new driver that implements interfaces in sap.h then configure with ./configure --enable-sap=yes --with-sap=DRIVER
> You don't have to modify the code, but you have to rebuild with your driver. Usually, there will be one driver per platform so it shoudl not be a problem.
>
>> I don't see D-bus being used other than for set/get property.
>
> We use D-bus only for enable/disable sap server. Data flow to sim is done over unix sockets (for u8500) as I have doubts to dbus reliability. However, it's good option to do tests with dbus oriented design as discussed before.

So basically your implementation does not use d-bus for basic SAP 
operations and the SIM access driver is compiled as part of bluetoothd 
right?

>
>> Correct me if my understanding is wrong.
>>
>
> Regards,
> /Waldek

Regards
Suraj
