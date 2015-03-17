Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY176-W3225225E7B048E9761125FD3030@phx.gbl>
From: Ssagarr Patil <hugarsagar@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: bluez5 pairing devices
Date: Tue, 17 Mar 2015 21:35:20 +0530
In-Reply-To: <94A95B77-D50A-4B0E-9038-424B14DFF965@holtmann.org>
References: 
 <BAY176-W679B1127159C091585D3AD3030@phx.gbl>,<94A95B77-D50A-4B0E-9038-424B14DFF965@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel=2C=0A=
=0A=
Thanks for the response.=0A=
=0A=
>> I am very new to bluetooth=2C so sorry for a novice query.=0A=
>>=0A=
>> 1: I am using 2.6.37 Linux kernel=2C can bluez5 stack be used on this or=
 should I use bluez4 ?=0A=
>> 2: With bluez5 I am able to scan devices and also see the device on othe=
r device but I am not able to pair them=0A=
>> Is there some sort of deamon required to pair them ?=0A=
>=0A=
> BlueZ 5 requires a Bluetooth subsystem with management API support. So at=
 least kernel 3.4 or you have to use Linux backports to at least bring the =
Bluetooth subsystem to your 2.6.37 kernel. And I have heard of success from=
 people doing that=2C but I have not personally done that.=0A=
>=0A=
Probably that would take me more time in back porting. In case of 2.6.37 wh=
at version of bluez4 would be best ?=0A=
=0A=
Regards=2C=0A=
Sagar=0A=
 		 	   		  =
