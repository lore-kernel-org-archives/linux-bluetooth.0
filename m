Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: Multiple BLE connections to one GATT-Server
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5440E4BE.3020303@gmx.com>
Date: Fri, 17 Oct 2014 13:45:16 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9210860D-F9EC-4606-8310-9E1DA92351A5@holtmann.org>
References: <5440E4BE.3020303@gmx.com>
To: "T. Bolten" <t.bolten@gmx.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I'm new in the area of Bluetooth-programming and I hope this is the right place for my question. A web search at the usual web portals was not very helpful due to contradictory statements and I'm "lost" in the Bluetooth Core specification.
> 
> Basically my question related to Bluetooth Low Energy is the following:
> 
> Is it technically possible to connect multiple BLE GATT Clients (in my case smartphones, called in the bluetooth terminology central/master device?) to one BLE GATT Server (in my case a Linux box with Bluez, called in the bluetooth terminology slave or peripheral device?)?
> 
> 
> The basic idea here is that several different smartphones should simultaneously read (read-only, not write) some self-defined service characteristics to inform the clients about some kind of progress or event state. These progress-information is unfortunately to large to be included in the advertisement package.
> 
> 
> I have already an implementation that advertises a service with some self defined characteristics but I can connect to this GATT service only with one smartphone - then the advertising stops and I'm unable to connect to this service with an other device.

this is a hardware specific detail. BlueZ will support as many connection in peripheral role as the hardware supports. Some might have single connections in peripheral, but others might all multiple. You need to test this and see if the hardware is working correctly for your use cases.

Regards

Marcel

