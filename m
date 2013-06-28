Return-Path: <cyrus@holtmann.org>
From: =?ISO-8859-1?Q?=C0lex?= Fiestas <afiestas@kde.org>
To: linux-bluetooth@vger.kernel.org
Subject: Discoverable devices
Date: Fri, 28 Jun 2013 18:39:21 +0200
Message-ID: <1599920.hvBb11VtN9@monsterbad>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is there any way of knowing if a device that is ALREADY created is in 
Discoverable mode?

Calling startDiscvoer + monitor interfaceAdded/Remove works nice but that only 
works for devices that are newly discovered, not for those devices that are 
are already registered in the bus.

I read about org.bluez.Device1.Appearance  but it does not seem to have any 
value on any of my devices under any circumstance.

Am I missing something?

thanks !
