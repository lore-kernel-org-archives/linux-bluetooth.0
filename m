Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: 
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <9BC883E0D59F6B4DBD525D460025714B08AE336F@deessmx03.dees.eberspaecher.com>
Date: Mon, 10 Feb 2014 10:35:24 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <BE8107B5-0F83-47C5-ADC6-345CFD24BE21@holtmann.org>
References: <9BC883E0D59F6B4DBD525D460025714B08AE336F@deessmx03.dees.eberspaecher.com>
To: "Viswanatham, RaviTeja"
	<RaviTeja.Viswanatham.EDUCATION@eberspaecher.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

> I am working on Ubuntu 12.04 with a Bluetooth 3.0 +HS + wifi combo USB dongle. 
> 
> I want to reach a data transfer speed of up to 24 Mbit/s. 
> 
> My Questions:
> Does Bluez support high speed data transfer rates up to 24 Mbit/s (Bluetooth 3.0+HS) ? 
> 
> If it does, is there any user configuration involved to achieve that? What other requirements need to be met?
> Does, Bluetooth enables AMP function to communicate 802.11n channel to support high speed or it has to be configure with any other drivers? 
> 
> I am new to Linux a detail explanation would be really appreciated. Thank you in advance for your support.

we do support Bluetooth HS operation. However your WiFi device needs to be exposed as AMP Controller. Most WiFi hardware needs a special driver to expose itself as AMP Controller. There is no generic driver for mac80211 subsystem in the kernel.

Regards

Marcel

