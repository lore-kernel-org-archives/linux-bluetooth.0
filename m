Return-Path: <cyrus@holtmann.org>
From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	andrei.emeltchenko@intel.com,
	akarwar@marvell.com,
	bzhao@marvell.com,
	zonque@gmail.com,
	Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v3 0/2] Bluetooth: btmrvl: Fix concurrent FW download
Date: Mon, 22 Apr 2013 11:10:21 +0200
Message-Id: <1366621823-10411-1-git-send-email-andreas.fenkart@streamunlimited.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This is a resend.

Andreas Fenkart (2):
  Bluetooth: btmrvl: release lock while waiting for fw download
    complete.
  Bluetooth: btmrvl: report error if verify_fw_download times out.

 drivers/bluetooth/btmrvl_sdio.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

-- 
1.7.10.4
