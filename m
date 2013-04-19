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
Subject: [PATCH 0/2] Bluetooth: btmrvl: Fix concurrent FW download 
Date: Fri, 19 Apr 2013 10:07:05 +0200
Message-Id: <1366358828-1241-1-git-send-email-andreas.fenkart@streamunlimited.com>
In-Reply-To: <1366301890-14100-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <1366301890-14100-1-git-send-email-andreas.fenkart@streamunlimited.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes known bug, when mwifiex / btmrvl are competing for downloading the FW.

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137985.html

Andreas Fenkart (2):
  Bluetooth: btmrv: release lock while waiting for fw download
    complete.
  Bluetooth: btmrvl: report error if verify_fw_download times out.

 drivers/bluetooth/btmrvl_sdio.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

-- 
1.7.10.4
