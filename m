Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] Bluetooth: ath3k: workaround the compatibility issue with xHCI controller
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422477027-8923-1-git-send-email-adam.lee@canonical.com>
Date: Thu, 29 Jan 2015 10:14:37 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <12502301-5C02-406E-9451-0114874E41D2@holtmann.org>
References: <1422477027-8923-1-git-send-email-adam.lee@canonical.com>
To: Adam Lee <adam.lee@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Adam,

> BugLink: https://bugs.launchpad.net/bugs/1400215
> 
> ath3k devices fail to load firmwares on xHCI buses, but work well on
> EHCI, this might be a compatibility issue between xHCI and ath3k chips.
> As my testing result, those chips will work on xHCI buses again with
> this patch.
> 
> This workaround is from Qualcomm, they also did some workarounds in
> Windows driver.
> 
> Signed-off-by: Adam Lee <adam.lee@canonical.com>
> ---
> drivers/bluetooth/ath3k.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

