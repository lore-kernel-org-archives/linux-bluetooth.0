Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: Bluez dual-mode support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <29A2697B0516A946B1023D5E798DFCF65B5C257D@mail-yang>
Date: Fri, 10 Oct 2014 17:40:54 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <39BD3B94-98FF-4BAC-BE5C-3FB50EEA676E@holtmann.org>
References: <29A2697B0516A946B1023D5E798DFCF65B5C257D@mail-yang>
To: "Boulais, Marc-Andre" <maboulais@rheinmetall.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marc,

> Does BlueZ support a "dual mode" where both Bluetooth "classic" and "low-energy" are enabled? I need to support classic and LE Bluetooth devices in my network.
> 
> Furthermore, is there an recent list of Bluetooth chipsets supported by BlueZ for Low Energy? any chipset recommendations would be greatly appreciated. 

yes, BlueZ 5.x fully supports dual-mode operation. Almost all recent chipsets should be supported. So any USB based Bluetooth controller should actually work out of the box.

Regards

Marcel

