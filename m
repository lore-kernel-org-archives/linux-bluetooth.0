Return-Path: <cyrus@holtmann.org>
Message-ID: <1329467683.28848.128.camel@aeonflux>
Subject: Re: ath3k: asus bluetooth dongle won't work
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Vikram Kandukuri <vkandukuri@atheros.com>,
	"Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
	linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:34:43 +0100
In-Reply-To: <20120216173504.2571de22@s6510.linuxnetplumber.net>
References: <20120216173504.2571de22@s6510.linuxnetplumber.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stephen,

> Running on Debian Wheezy (3.2.0-1-amd64), my new Asus bluetooth
> dongle didn't work. Made sure and get the correct firmware, but
> the driver does not load it correctly.
> 
> [    8.364186] Bluetooth: Can't change to loading configuration err
> [    8.364263] ath3k: probe of 2-4.3:1.0 failed with error -110
> [    8.364300] usbcore: registered new interface driver ath3k
> 
> 
> This is from a cold (power off) boot, but it happens repeatedly.
> 
> Any idea what could be wrong?
> 
> lsusb
> Bus 002 Device 005: ID 0cf3:3000 Atheros Communications, Inc. AR3011 Bluetooth (no firmware)

you need to ask Atheros for details, but maybe just the firmware file is
missing.

Regards

Marcel


