Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Revert "Bluetooth: btusb: Fix quirk for Atheros
 1525/QCA6174"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180426121819.23327-1-hdegoede@redhat.com>
Date: Thu, 26 Apr 2018 14:22:01 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>
Message-Id: <85CF4178-2D2E-49D6-8837-EBD36623DFEE@holtmann.org>
References: <20180426121819.23327-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Commit f44cb4b19ed4 ("Bluetooth: btusb: Fix quirk for Atheros
> 1525/QCA6174") is causing bluetooth to no longer work for several
> people, see: https://bugzilla.redhat.com/show_bug.cgi?id=1568911
> 
> So lets revert it for now and try to find another solution for
> devices which need the modified quirk.
> 
> Cc: stable@vger.kernel.org
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

