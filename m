Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: btusb: Only check needs_reset_resume DMI table
 for QCA rome chipsets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180427092643.27140-1-hdegoede@redhat.com>
Date: Mon, 30 Apr 2018 10:52:44 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        stable@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Message-Id: <13C8A106-99C4-467C-B949-D314B224587C@holtmann.org>
References: <20180427092643.27140-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Jeremy Cline correctly points out in rhbz#1514836 that a device where the
> QCA rome chipset needs the USB_QUIRK_RESET_RESUME quirk, may also ship
> with a different wifi/bt chipset in some configurations.
> 
> If that is the case then we are needlessly penalizing those other chipsets
> with a reset-resume quirk, typically causing 0.4W extra power use because
> this disables runtime-pm.
> 
> This commit moves the DMI table check to a btusb_check_needs_reset_resume()
> helper (so that we can easily also call it for other chipsets) and calls
> this new helper only for QCA_ROME chipsets for now.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> Cc: stable@vger.kernel.org
> Cc: Jeremy Cline <jcline@redhat.com>
> Suggested-by: Jeremy Cline <jcline@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

