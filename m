Return-Path: <cyrus@holtmann.org>
Message-ID: <4CAB1E17.3060406@Atheros.com>
Date: Tue, 5 Oct 2010 18:16:15 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Waldemar.Rymarkiewicz@tieto.com" <Waldemar.Rymarkiewicz@tieto.com>, Suraj
 Sumangala <Suraj.Sumangala@Atheros.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, Jothikumar Mothilal
	<Jothikumar.Mothilal@Atheros.com>, "joakim.xj.ceder@stericsson.com"
	<joakim.xj.ceder@stericsson.com>
Subject: Re: Sim Access profile server implementation
References: <1285657515.12097.7.camel@atheros013-desktop>	 <1286265730.17473.29.camel@aeonflux>	 <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com> <1286280767.17473.89.camel@aeonflux>
In-Reply-To: <1286280767.17473.89.camel@aeonflux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

On 10/5/2010 5:42 PM, Marcel Holtmann wrote:
> Hi Waldemar,
>
> please no top posting on this mailing list.
>
>> I understand you concerns about dbus reliability and I agree with you , but I guess we should find a compromise solution as ofono is not used widely in Linux mobile platforms nowadays.
>>
>> I my view, combination of a bluez plugin for sap and a platform dependend sim driver is a reliable and most available solution so far. The SAP plugin implements BT SAP spec and require simple API (connect, disconnect, apdu, atr, status) which is implemented in SIM driver for a certain platform. This way it's relatively easy to support SAP in different platforms. Ofono can have its own driver as well.
>>
>> What's you view on such design?
>> Can we also have a double solution one in ofono for ofono aware platforms and the second as a plugin for others?
>
> I am fine with starting this in BlueZ and see how far we get. And yes,
> plugin based is a must from my point of view. It is most likely similar
> to our different telephony drivers for Handsfree support.
>
> We will move strongly in the direction of oFono being the main telephony
> stack. So I do care mostly that this work in conjunction with oFono.
> Everything else is just a nice benefit if it doesn't clutter the
> overhaul implementation and requires pointless abstraction everywhere.
>
>> BTW, I already have this implemented and tested with real hardware (STEricsson). Bluez SAP works fine with Nokia 616 carkit :)
>
> Can you share that code with us. And also hardware if you. We are still
> having hard time to find proper hardware to test this on.
>
> Regards
>
> Marcel
>
>

Do let me know if you had to make some changes in the SAP implementation 
for it to work.

It will be great if you can share the code in that case. I can update my 
implementation accordingly.

Regards
Suraj
