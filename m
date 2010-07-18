Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] Add BT3 AMP device support, by Atheros Linux BT3
 team.
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Dan Tian <Dan.Tian@Atheros.com>, linux-bluetooth@vger.kernel.org,
	Haijun Liu <Haijun.Liu@Atheros.com>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
In-Reply-To: <1279411461.2424.9.camel@localhost.localdomain>
References: <CDAFEDABF718A54BABD0DA5476695307CE881EC1@SHEXMB-01.global.atheros.com>
	 <1279411461.2424.9.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 17 Jul 2010 19:00:53 -0700
Message-ID: <1279418453.6282.93.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> I'll take this opportunity to ask whether this chip is actually being
> used in currently sold devices, because I'd quite like to add a BT3
> device (or 2) to my collection.

so in theory you can use a Bluetooth 2.1 controller and an AMP driven in
software by mac80211 and you get a Bluetooth 3.0 + HS system.

There are Bluetooth 3.0 controller (note the missing HS), but the
difference to 2.1 is only an extra HCI command and some unicast support.
Otherwise they are the same. For a 3.0 + HS system you need a WiFi
controller that can act as a AMP as well. So essentially you see two HCI
devices. One will be the BR/EDR the other the AMP.

Regards

Marcel


