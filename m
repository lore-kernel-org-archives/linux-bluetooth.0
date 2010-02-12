Return-Path: <cyrus@holtmann.org>
Subject: Re: Coordinating development for Bluetooth 3.0 between 802.11 and
 BT trees
From: Marcel Holtmann <marcel@holtmann.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: "Luis R. Rodriguez" <lrodriguez@atheros.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Dan Tian <Dan.Tian@atheros.com>,
	Kevin Hayes <kevin@atheros.com>
In-Reply-To: <20100212183309.GB4983@tuxdriver.com>
References: <43e72e891002111210l55d6a802pc5a1384e3535c845@mail.gmail.com>
	 <20100212183309.GB4983@tuxdriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Feb 2010 20:16:37 +0100
Message-ID: <1266002197.21559.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

> In any case, I was under the impression that at least the initial
> parts of the 802.11 AMP implementation could happen independently
> from any bluetooth stack changes...?

yes, we should be able to test the AMP pieces without a Bluetooth stack
implementing the AMP manager. Especially since there will be FullMAC
WiFi devices that implement the AMP inside firmware.

Regards

Marcel


