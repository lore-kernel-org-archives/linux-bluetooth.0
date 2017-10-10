Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btbcm: Add support for MINIX Z83-4
 based devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a94aa782-fcc7-d0b4-683b-2df4319bc2b5@gmail.com>
Date: Tue, 10 Oct 2017 10:14:50 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, hdegoede@redhat.com,
        frederic.danis.oss@gmail.com
Message-Id: <540CB08E-3845-4B74-9643-7CB3A885D8A7@holtmann.org>
References: <a94aa782-fcc7-d0b4-683b-2df4319bc2b5@gmail.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices use an AP6255 chip
> for wifi and bluetooth. Bluetooth requires an ACPI device id of BCM2EA4
> with BCM4345 rev C0 firmware.
> 
> This patch defines the firmware subversion.
> 
> Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
> 
> ---
> drivers/bluetooth/btbcm.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

