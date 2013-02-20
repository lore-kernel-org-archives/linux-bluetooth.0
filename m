Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: Bluez Mailing List <linux-bluetooth@vger.kernel.org>
Subject: Setting Link Level Security Mode
Date: Tue, 19 Feb 2013 22:09:44 -0500
Message-ID: <87r4kby93b.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We have a requirement to set Link Level Security mode 1. How can this be
done with the bluez stack?

The mgmt-api allows the following bit-mapped modes to be 
configured:

		1	Powered
		2	Connectable
		3	Fast Connectable
		4	Discoverable
		5	Pairable
		6	Link Level Security (Sec. mode 3)
		7	Secure Simple Pairing
		8	Basic Rate/Enhanced Data Rate
		9	High Speed
		10	Low Energy

Note that although you can set Link Level Security mode 3 on or off,
there is no general way to set the link level security mode, which
according to Huang's "Bluetooth Essentials for Programmer" (p.31)
consists of three different modes (mode 1, mode 2, and mode 3).
-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
