Return-Path: <cyrus@holtmann.org>
Message-ID: <5440E4BE.3020303@gmx.com>
Date: Fri, 17 Oct 2014 11:43:26 +0200
From: "T. Bolten" <t.bolten@gmx.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Multiple BLE connections to one GATT-Server
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm new in the area of Bluetooth-programming and I hope this is the 
right place for my question. A web search at the usual web portals was 
not very helpful due to contradictory statements and I'm "lost" in the 
Bluetooth Core specification.

Basically my question related to Bluetooth Low Energy is the following:

Is it technically possible to connect multiple BLE GATT Clients (in my 
case smartphones, called in the bluetooth terminology central/master 
device?) to one BLE GATT Server (in my case a Linux box with Bluez, 
called in the bluetooth terminology slave or peripheral device?)?


The basic idea here is that several different smartphones should 
simultaneously read (read-only, not write) some self-defined service 
characteristics to inform the clients about some kind of progress or 
event state. These progress-information is unfortunately to large to be 
included in the advertisement package.


I have already an implementation that advertises a service with some 
self defined characteristics but I can connect to this GATT service only 
with one smartphone - then the advertising stops and I'm unable to 
connect to this service with an other device.

After reading a lot of web posts I'm unsure if my idea can work or it is 
already "broken by design"?

I am grateful for any suggestion.

Greetings
T. Bolten
