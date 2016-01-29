Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] bluetooth: core: use managed version of led_trigger_register in LED trigger
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <56A67B8D.2010501@gmail.com>
Date: Fri, 29 Jan 2016 12:10:25 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <34592224-4DBF-4D39-8433-78CC356063E1@holtmann.org>
References: <56A67B8D.2010501@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Heiner,

> Recently a managed version of led_trigger_register was introduced.
> Using devm_led_trigger_register allows to simplify the LED trigger code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> net/bluetooth/hci_core.c | 2 --
> net/bluetooth/leds.c     | 8 +-------
> net/bluetooth/leds.h     | 2 --
> 3 files changed, 1 insertion(+), 11 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

