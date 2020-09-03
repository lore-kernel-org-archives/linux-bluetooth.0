Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBA7C433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 18:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B1B2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 18:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgICSs6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:48:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:63136 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgICSsy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Sep 2020 14:48:54 -0400
IronPort-SDR: G7Y5XBluCA/hm+mqBLsNsIBP+DtII0b4kM/Lt7wU2EJVEhQEQta4HWgIv3/1V2u7qC13RU63rj
 lkS5OeVWsj4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="175694214"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="175694214"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 11:48:53 -0700
IronPort-SDR: DMaS1KQ6rL7UZZnHjyRqP4fak2kr+mHgcGlxhj4ny2Rfp4aIRJlqwP0JGYZ1noXfjzOzGIwez6
 6eIYJKBTlh8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="302317754"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 03 Sep 2020 11:48:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2B957182; Thu,  3 Sep 2020 21:48:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] Bluetooth: hci_intel: switch to list_for_each_entry()
Date:   Thu,  3 Sep 2020 21:48:49 +0300
Message-Id: <20200903184850.53055-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
References: <20200903184850.53055-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is no need to have list_for_each() followed by list_entry()
when we simply may use list_for_each_entry() directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/hci_intel.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 50e4fc6813c2..b20a40fab83e 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -288,7 +288,7 @@ static irqreturn_t intel_irq(int irq, void *dev_id)
 
 static int intel_set_power(struct hci_uart *hu, bool powered)
 {
-	struct list_head *p;
+	struct intel_device *idev;
 	int err = -ENODEV;
 
 	if (!hu->tty->dev)
@@ -296,10 +296,7 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 
 	mutex_lock(&intel_device_list_lock);
 
-	list_for_each(p, &intel_device_list) {
-		struct intel_device *idev = list_entry(p, struct intel_device,
-						       list);
-
+	list_for_each_entry(idev, &intel_device_list, list) {
 		/* tty device and pdev device should share the same parent
 		 * which is the UART port.
 		 */
@@ -362,19 +359,16 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 
 static void intel_busy_work(struct work_struct *work)
 {
-	struct list_head *p;
 	struct intel_data *intel = container_of(work, struct intel_data,
 						busy_work);
+	struct intel_device *idev;
 
 	if (!intel->hu->tty->dev)
 		return;
 
 	/* Link is busy, delay the suspend */
 	mutex_lock(&intel_device_list_lock);
-	list_for_each(p, &intel_device_list) {
-		struct intel_device *idev = list_entry(p, struct intel_device,
-						       list);
-
+	list_for_each_entry(idev, &intel_device_list, list) {
 		if (intel->hu->tty->dev->parent == idev->pdev->dev.parent) {
 			pm_runtime_get(&idev->pdev->dev);
 			pm_runtime_mark_last_busy(&idev->pdev->dev);
@@ -533,7 +527,7 @@ static int intel_setup(struct hci_uart *hu)
 	struct sk_buff *skb;
 	struct intel_version ver;
 	struct intel_boot_params params;
-	struct list_head *p;
+	struct intel_device *idev;
 	const struct firmware *fw;
 	char fwname[64];
 	u32 boot_param;
@@ -833,13 +827,11 @@ static int intel_setup(struct hci_uart *hu)
 	 * until further LPM TX notification.
 	 */
 	mutex_lock(&intel_device_list_lock);
-	list_for_each(p, &intel_device_list) {
-		struct intel_device *dev = list_entry(p, struct intel_device,
-						      list);
+	list_for_each_entry(idev, &intel_device_list, list) {
 		if (!hu->tty->dev)
 			break;
-		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
-			if (device_may_wakeup(&dev->pdev->dev)) {
+		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
+			if (device_may_wakeup(&idev->pdev->dev)) {
 				set_bit(STATE_LPM_ENABLED, &intel->flags);
 				set_bit(STATE_TX_ACTIVE, &intel->flags);
 			}
@@ -993,7 +985,7 @@ static int intel_recv(struct hci_uart *hu, const void *data, int count)
 static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 {
 	struct intel_data *intel = hu->priv;
-	struct list_head *p;
+	struct intel_device *idev;
 
 	BT_DBG("hu %p skb %p", hu, skb);
 
@@ -1004,10 +996,7 @@ static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	 * completed before enqueuing any packet.
 	 */
 	mutex_lock(&intel_device_list_lock);
-	list_for_each(p, &intel_device_list) {
-		struct intel_device *idev = list_entry(p, struct intel_device,
-						       list);
-
+	list_for_each_entry(idev, &intel_device_list, list) {
 		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
 			pm_runtime_get_sync(&idev->pdev->dev);
 			pm_runtime_mark_last_busy(&idev->pdev->dev);
-- 
2.28.0

