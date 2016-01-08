Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v4] bluetooth: core: add LED trigger for indicating HCI is powered up
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <568FFFEA.9060303@gmail.com>
Date: Fri, 8 Jan 2016 14:14:31 -0800
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <79E55D00-154E-48F1-B0E2-AF7EC9D496DD@holtmann.org>
References: <568FFFEA.9060303@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Heiner,

> Add support for LED triggers to the bluetooth core and add kernel config
> symbol BT_LEDS for it.
> For now one trigger for indicating "HCI is powered up" is supported.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - completely rewrote the code to be as generic as possible and minimize
>  the changes to struct hci_dev
> - make the details of the LED triggers opaque to struct hci_dev
> - avoid using ifdef CONFIG_BT_LEDS in hci_core.h
> - start with the radio trigger only
> - factor out the generic basic led trigger code to facilitate adding
>  further basic LED triggers
> - fix indentation in Kconfig
> - rename led.[ch] to leds.[ch]
> v3:
> - use term power instead of radio
> - rename hci_led_ to hci_leds_
> - remove the counter
> - use IS_ENABLED for checking the config option
> v4:
> - rework commit message
> - shorten static function names
> - remove empty line at end of file
> ---
> include/net/bluetooth/hci_core.h |  3 ++
> net/bluetooth/Kconfig            |  9 +++++
> net/bluetooth/Makefile           |  1 +
> net/bluetooth/hci_core.c         |  8 ++++
> net/bluetooth/leds.c             | 80 ++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/leds.h             | 18 +++++++++
> 6 files changed, 119 insertions(+)
> create mode 100644 net/bluetooth/leds.c
> create mode 100644 net/bluetooth/leds.h

patch has been applied to bluetooth-next tree.

Regards

Marcel

