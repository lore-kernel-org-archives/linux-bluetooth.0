Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Add ACPI HIDs found in Windows .inf
 files and DSTDs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180321125318.4542-1-hdegoede@redhat.com>
Date: Fri, 23 Mar 2018 21:52:49 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <A3A14CAF-32B2-47A4-8740-C2FF8F7D7D0B@holtmann.org>
References: <20180321125318.4542-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Now that we need just an ACPI HID in the table, and the driver auto-
> configures itself otherwise, we can easily add a bunch of known ACPI HIDs.
> 
> This avoids having to add these 1 by 1 as devices with one are encountered
> by users.
> 
> This commit may seem as if it simply adds all IDs between BCM2E00-BCM2EAC,
> but that is not true, all these IDs were found in actual .inf files and
> the range is not entirely continuous, the following IDs are not added:
> BCM2E6A, BCM2E6C, BCM2E8F and BCM2E91 because I did not see these in any
> .inf files. As for the large amount of IDs this seems to be caused by
> Broadcom using a separate ID for every bluetooth module using their
> chips. E.g. BCM2EA6 seems to be specifically for the Raspberry Pi 3.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 141 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 141 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

