Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F5C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1C760EBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhHDO3J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:29:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:6023 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238801AbhHDO24 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 10:28:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="201113448"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="201113448"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 07:28:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="668090950"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 04 Aug 2021 07:28:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B68C9B9; Wed,  4 Aug 2021 17:28:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 1/1] Bluetooth: hci_bcm: Fix kernel doc comments
Date:   Wed,  4 Aug 2021 17:28:37 +0300
Message-Id: <20210804142837.67820-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Kernel doc validator complains about few missed parameter descriptions.
Fill the gap by describing them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: sent separately of the initial series
 drivers/bluetooth/hci_bcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ed99fcde2523..fd0acadb9102 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -51,6 +51,7 @@
 /**
  * struct bcm_device_data - device specific data
  * @no_early_set_baudrate: Disallow set baudrate before driver setup()
+ * @drive_rts_on_open: drive RTS signal on ->open() when platform requires it
  */
 struct bcm_device_data {
 	bool	no_early_set_baudrate;
@@ -77,6 +78,8 @@ struct bcm_device_data {
  * @btlp: Apple ACPI method to toggle BT_WAKE pin ("Bluetooth Low Power")
  * @btpu: Apple ACPI method to drive BT_REG_ON pin high ("Bluetooth Power Up")
  * @btpd: Apple ACPI method to drive BT_REG_ON pin low ("Bluetooth Power Down")
+ * @gpio_count: internal counter for GPIO resources associated with ACPI device
+ * @gpio_int_idx: index in _CRS for GpioInt() resource
  * @txco_clk: external reference frequency clock used by Bluetooth device
  * @lpo_clk: external LPO clock used by Bluetooth device
  * @supplies: VBAT and VDDIO supplies used by Bluetooth device
@@ -88,10 +91,13 @@ struct bcm_device_data {
  *	set to 0 if @init_speed is already the preferred baudrate
  * @irq: interrupt triggered by HOST_WAKE_BT pin
  * @irq_active_low: whether @irq is active low
+ * @irq_acquired: flag to show if IRQ handler has been assigned
  * @hu: pointer to HCI UART controller struct,
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
  * @no_early_set_baudrate: don't set_baudrate before setup()
+ * @drive_rts_on_open: drive RTS signal on ->open() when platform requires it
+ * @pcm_int_params: keep the initial PCM configuration
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
-- 
2.30.2

