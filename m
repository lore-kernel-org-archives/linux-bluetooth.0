Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] drivers/bluetooth/: Toshiba Qualcomm AR9565 (ath3k) bluetooth fix for C55-B-138 notebooks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1721217.JWeHGVIyOq@venture>
Date: Wed, 6 Aug 2014 12:54:34 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E8897994-E782-4CDC-ABDB-D30756B5033B@holtmann.org>
References: <1721217.JWeHGVIyOq@venture>
To: Vincent Elger Zwanenburg <vincentezw@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincent,

> From:  Vincent Elger Zwanenburg <vincentz@topmail.ie>
> Date:   Tue Aug 5 01:34:27 2014 +0100
> 
> Assign the BTUSB_ATH3012 driver to the Toshiba USB Vendor ID and Product ID combination in btusb.c and ath3k.c.

please include the output of /sys/kernel/debug/usb/devices here. We require this for all new ids that are added to the drivers.

Regards

Marcel

