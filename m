Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <marcel@holtmann.org>, <suraj@atheros.com>
CC: <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>, <joakim.xj.ceder@stericsson.com>
Date: Tue, 5 Oct 2010 13:45:15 +0300
Subject: RE: Sim Access profile server implementation
Message-ID: <99B09243E1A5DA4898CDD8B700111448097D01B371@EXMB04.eu.tieto.com>
References: <1285657515.12097.7.camel@atheros013-desktop>
 <1286265730.17473.29.camel@aeonflux>
In-Reply-To: <1286265730.17473.29.camel@aeonflux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, 

I understand you concerns about dbus reliability and I agree with you , but I guess we should find a compromise solution as ofono is not used widely in Linux mobile platforms nowadays.

I my view, combination of a bluez plugin for sap and a platform dependend sim driver is a reliable and most available solution so far. The SAP plugin implements BT SAP spec and require simple API (connect, disconnect, apdu, atr, status) which is implemented in SIM driver for a certain platform. This way it's relatively easy to support SAP in different platforms. Ofono can have its own driver as well.

What's you view on such design?
Can we also have a double solution one in ofono for ofono aware platforms and the second as a plugin for others? 

BTW, I already have this implemented and tested with real hardware (STEricsson). Bluez SAP works fine with Nokia 616 carkit :)

Regards,
/Waldek

>-----Original Message-----
>From: linux-bluetooth-owner@vger.kernel.org 
>[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of 
>Marcel Holtmann
>Sent: Tuesday, October 05, 2010 10:02 AM
>To: suraj
>Cc: linux-bluetooth@vger.kernel.org; Jothikumar Mothilal
>Subject: Re: Sim Access profile server implementation
>
>Hi Suraj,
>
>> Please find the Git tree for the Sim access profile server role 
>> implementation I have been working on at
>> 
>> git://gitorious.org/sap-server/sap-server.git
>> 
>> Not sure it could be directly used with Bluez. Nevertheless, it has 
>> the parser implementation of Bluetooth SAP packet. Someone could 
>> possibly reuse it in their implementation.
>
>have you actually tested this with real SAP server capable 
>hardware? I am still not convinced at all to push APDU over 
>D-Bus. First, there is potential security issue here and 
>second the latency that D-Bus introduces seems not be 
>acceptable. So what I am getting it, can this be actually used 
>in a product that seriously wants to support SAP server?
>
>Regards
>
>Marcel
>
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-bluetooth" in the body of a message to 
>majordomo@vger.kernel.org More majordomo info at  
>http://vger.kernel.org/majordomo-info.html
>