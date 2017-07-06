Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] bluetooth: btusb: Add support for BCM2045 HCI with
 vend:prod ids set to 0000:0000
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170706140845.11508-1-hdegoede@redhat.com>
Date: Thu, 6 Jul 2017 17:22:22 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <B5854943-47D2-494F-9D56-80226FE66F38@holtmann.org>
References: <20170706140845.11508-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> The GPD Pocket is shipping with a BCM2045 USB HCI with its vend:prod
> ids set to 0000:0000 and also has its interface class set to 255 (Vendor
> Specific Class).
> 
> Which, well sucks. Luckily it does advertise usable manufacturer and
> product strings, so this commit adds 0000:0000 to the usb_device_id
> table, with a special flag of BTUSB_BCM2045_0000_0000, if this flag
> is set btusb_probe will check the strings and if they don't match
> return -ENODEV.
> 
> This is not pretty, but it fixes bluetooth not working under Linux.

can you send around /sys/kernel/debug/usb/devices for this device.

Regards

Marcel

