Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EA9400D.2000100@srdc.com.tr>
References: <4EA90C20.4080009@srdc.com.tr>
	<CACLukz+zzWckuWPAPo1kru5MLqUES_jMn48fkaHAQf2-KHAOmQ@mail.gmail.com>
	<4EA9400D.2000100@srdc.com.tr>
Date: Thu, 27 Oct 2011 17:01:16 +0100
Message-ID: <CACLukzLnWDM2pB9+-mgT1Uf4wPv5dqt8BcY_=R10-s5Y+UgAhw@mail.gmail.com>
Subject: Re: Compiling BlueZ Thermometer Example
From: Santiago Carot <sancane@gmail.com>
To: =?ISO-8859-9?Q?Ali=FEan_YILMAZ?= <alisan@srdc.com.tr>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-9
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Alisan,

2011/10/27 Aliþan YILMAZ <alisan@srdc.com.tr>:
> Hello Santi,
> Thanks for your quick response. Actually, we want to develope a health
> device application that gets measurements from a Continua-Certified blood
> pressure device using HDP.
> I thought, it could be very helpful to look at that thermometer example, am
> I wrong?
>

That code is just a plugin to manage thermometers. Health Thermometer
Profiles is placed on top of GATT so you will need neither HDP nor
MCAP. Onn the contrary, if your device is only using HDP this plugin
is unusefull for you.

> Also, if you share patches with us, we want to help you by testing and
> developing the measurement plugins.
>

Of course, I don't have any problem to share my repo. I'll move it to
a public repo in next days if you are still interested.

> By the way, after executing bluetoothd, there were not any thermometer HDP
> service in the running bluetooth services list. Does the problem occur due
> to the codes or wrong installation?
>

I insist again, HTP profile is not related with HDP :-)

When you pair your HDP device, the bluetooth daemon will load a proper
driver to manage that device using the HDP D-Bus interface, you can
see more info about HDP interface under doc folder. This interface
enables you to create/destroy health channels and send 11073-20601
APDUs.

Regards.
