Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Jun 2013 14:40:07 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: =?iso-8859-1?Q?=C0lex?= Fiestas <afiestas@kde.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Discoverable devices
Message-ID: <20130628174007.GA2735@samus.indt.org>
References: <1599920.hvBb11VtN9@monsterbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1599920.hvBb11VtN9@monsterbad>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Àlex,

On 18:39 Fri 28 Jun, Àlex Fiestas wrote:
> Is there any way of knowing if a device that is ALREADY created is in 
> Discoverable mode?

The first thing that comes to mind is listening for changes in the RSSI
property, i.e. monitor the org.freedesktop.DBus.Properties.PropertiesChanged
as well.

> 
> Calling startDiscvoer + monitor interfaceAdded/Remove works nice but that only 
> works for devices that are newly discovered, not for those devices that are 
> are already registered in the bus.
> 
> I read about org.bluez.Device1.Appearance  but it does not seem to have any 
> value on any of my devices under any circumstance.

Appearance is only present for Low Energy devices.

> 
> Am I missing something?
> 
> thanks !
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
