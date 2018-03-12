Return-Path: <elfring@users.sourceforge.net>
To: linux-bluetooth@vger.kernel.org, Johan Hedberg <johan.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/5] Bluetooth/btmrvl_sdio: Adjustments for three function
 implementations
Message-ID: <8d050f76-aed1-7b6b-8778-a78aef34d4ea@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:30:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 12:10:24 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Use common error handling code in btmrvl_sdio_register_dev()
  Delete an unnecessary variable initialisation in btmrvl_sdio_register_dev()
  One check less in btmrvl_sdio_card_to_host() after error detection
  Delete an unnecessary variable initialisation in btmrvl_sdio_card_to_host()
  Use common error handling code in btmrvl_sdio_download_fw_w_helper()

 drivers/bluetooth/btmrvl_sdio.c | 102 ++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 56 deletions(-)

-- 
2.16.2
