Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Keep runtime resumed on packet
 reception
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5aaa16ce.CK8bS3NwS1NCw4vD%rhowell@uwyo.edu>
Date: Thu, 15 Mar 2018 19:33:44 +0100
Cc: Johan Hedberg <johann.hedberg@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org
Message-Id: <E0093EFA-6C1A-44D2-B2A9-9DEA4CACCEC9@holtmann.org>
References: <5aaa16ce.CK8bS3NwS1NCw4vD%rhowell@uwyo.edu>
To: "Robert R. Howell" <rhowell@uwyo.edu>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Robert,

> Commit 43fff7683468 ("Bluetooth: hci_bcm: Streamline runtime PM code")
> broke runtime PM on Baytrail machines such as the ASUS T100 and perhaps
> other devices because the call to pm_request_resume() became a no-op
> if the device was already runtime resumed.  The purpose of the code it
> replaced appears to have been to keep the device awake for another
> 5 seconds on receipt of a full packet.  Reinstate that behavior.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198953
> Fixes: 43fff7683468 ("Bluetooth: hci_bcm: Streamline runtime PM code")
> Signed-off-by: Robert R. Howell <rhowell@uwyo.edu>
> ---
> drivers/bluetooth/hci_bcm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

the decision was to revert that commit and rather work out something better later. So I am doing the revert.

Regards

Marcel

