Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] D-Bus interfaces
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076506369.2777.88.camel@pegasus>
References: <1076265358.2670.36.camel@pegasus>
	 <1076266267.14742.38.camel@akka.yeti.nocrew.org>
	 <1076267396.2670.58.camel@pegasus>
	 <1076275689.14742.93.camel@akka.yeti.nocrew.org>
	 <1076277250.6869.24.camel@pegasus>
	 <1076278554.14742.112.camel@akka.yeti.nocrew.org>
	 <1076279508.6869.54.camel@pegasus>
	 <1076280612.14742.147.camel@akka.yeti.nocrew.org>
	 <1076282343.6869.65.camel@pegasus>
	 <1076284317.14742.179.camel@akka.yeti.nocrew.org>
	 <1076287085.6869.70.camel@pegasus>
	 <1076311376.14742.202.camel@akka.yeti.nocrew.org>
	 <1076321200.6869.75.camel@pegasus>
	 <1076322129.5263.28.camel@kalkyl.roxen.com>
	 <1076323138.6869.93.camel@pegasus>
	 <1076493798.6281.19.camel@kalkyl.roxen.com>
	 <1076506369.2777.88.camel@pegasus>
Content-Type: text/plain
Message-Id: <1076508315.6281.131.camel@kalkyl.roxen.com>
Mime-Version: 1.0
Date: Wed, 11 Feb 2004 15:05:15 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

ons 2004-02-11 klockan 14.32 skrev Marcel Holtmann:
> These are not needed in the D-Bus interface. The first parameter of a
> D-Bus method will be "string device" and can be "hci0" or a BD_ADDR and
> this is enough to identify the device and open the needed socket.

Agreed. For configuration management, the difference in reference is 
very important:

When using "hci0", the setting will be permanently stored and used for
all devices that become "hci0". When using "00:00:00:00:00:00", the
device with that address will have that setting, regardless of the
interface (hci0, hci1 or otherwise). Configurations based on addresses
should have higher priority than those based on interfaces.

The applications will have to be careful on how to use the references,
unless we decide that configurations only will be stored on addresses
regardless of the type reference used by the application.

> The HCI don't defines anything on PIN or link key management, but a
> D-Bus interface should provide functions for it.

Agreed.

Fredrik
