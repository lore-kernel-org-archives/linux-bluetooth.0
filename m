Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FE93A0F6-15DB-4F0D-BF59-B719C497E4F3@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Oleg Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <49200DE9.4080606@kaa.org.ua>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: BCM2045B2
Date: Mon, 24 Nov 2008 03:53:40 +0100
References: <49200DE9.4080606@kaa.org.ua>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oleg,

> Asus P535 details on http://www.kaa.org.ua/asus-p535/hardware.html
> Bluetooth chip BCM2045B2 connected to the pxa internal usb host.
>
> I think this chip need firmware, because it is can only search
> How I can upload firmware to the this chip?

no, the chip needs a HCI Reset call. Load btusb with reset=1. And send  
the output of /proc/bus/usb/devices for this dongle.

Regards

Marcel

