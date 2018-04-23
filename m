Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 1/6] Bluetooth: btbcm: Stop using upper nibble of rev to
 chose between uart/USB paths
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180420124407.19712-1-hdegoede@redhat.com>
Date: Mon, 23 Apr 2018 19:58:45 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Message-Id: <008777D7-1215-4874-AD1E-882FE7562B0E@holtmann.org>
References: <20180420124407.19712-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> btbcm_setup_patchram() was using the upper nibble of the revision code to
> determine if we are dealing with an uart or USB connected bcm-bt device,
> but just as btbcm_initialize() has started accepting 1 and 2 as uart
> connected devices, I've now encountered an USB connected device (0a5c:216c)
> which has 0 in the upper nibble. So it seems that the upper nibble is not
> really a reliable indicator of the bus type.
> 
> Instead check hdev->bus which does give us a reliable indication. This
> fixes the patchram code trying to load the patchram by the fallback BCM.hcd
> filename, now it correctly requests BCM43142A0-0a5c-216c.hcd.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btbcm.c | 15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

