Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH] Bluetooth: hci_ath: Add ath_vendor_cmd helper
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1508416150-26259-1-git-send-email-loic.poulain@linaro.org>
Date: Sun, 29 Oct 2017 14:09:47 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <EE4BE2B9-0548-4FBC-8F48-AB0DBFE14411@holtmann.org>
References: <1508416150-26259-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Introduce ath_vendor_cmd function which can be used to
> configure 'tags' and patch the firmware.
> 
> ATH vendor command has the following format:
> | OPCODE (u8) | INDEX (LE16) | DLEN (U8) | DATA (U8 * DLEN) |
> 
> BD address configuration tag is at index 0x0001.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> drivers/bluetooth/hci_ath.c | 49 +++++++++++++++++++++++++++++----------------
> 1 file changed, 32 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

