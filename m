Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C982C7618E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Apr 2023 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjDUSrW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Apr 2023 14:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjDUSrV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Apr 2023 14:47:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C018F
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 11:47:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a677dffb37so22875715ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Apr 2023 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682102838; x=1684694838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=izoRkC16/KySVcSzhXp3bgMKpZvRpqxftGBChlEO7HU=;
        b=so6+mTCI3ADIP94ycyLxVFpCK8o4iw2Hdz/wy1u88zc8TtlFGttRP2cMxYJwAY+Oiu
         vv2MDp/6M8r0dw9b2yjBte50mmIhwKON1UAPSGZ12MRaCPj3B2GTsUIVJH4UnCn05Zc3
         gDGybArqCHKzftDnqFZex1rktsTCr8Ng0MHTeT9SkkikbXcFg6zZdIV0glDguLQFq+dS
         SVbDXaNxCQJLLTYViz90QbbE54ERqcWnWCgCMq6K2RXJ4ZOEfo+jFo64J9E6+1mc6qw3
         m6JMIvNZw6cth+ovgqO4ovpCL2XTwbojfiU9oPUiI2Sw373Rg8QJW0u4SLdjEXRpIc8/
         2sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682102838; x=1684694838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izoRkC16/KySVcSzhXp3bgMKpZvRpqxftGBChlEO7HU=;
        b=XIY38jBEMBqt8e+gZGrWriVVT2jVz6ITALR56F2nYiBKz6c0B3qFHghgwnsnDYo5cZ
         5IlEOb32ogRYJNLocG6xNoqx2uRY/pzTswFcMLV+O4rYv4FSAZybkuIvD40Kk3xX39S+
         Z2VeB3N0Nstr0voVjRbFXIrC9E+Y314ZGLgwm1Ieu9Zklkvj1MENncTNsWdGPVPLnq4j
         czCx0pTSe7xLqpzoNtRqB7Nn5KlPfu4T72rHpjTWB59PHI6EaVN9Q59PHmQaa/S1s8i9
         kBQuV0yXUQ56TZ0dNjb7O2gEKLhX1vOe8FzYTo378PJ98fWEcKFz7I0dZ4jrC/ssXbFw
         6i3A==
X-Gm-Message-State: AAQBX9c/cTwI/zvOaFPvRGoGsWgCgQhltZ1qUrwjN0avKFEcwYll0nb8
        qHuqAtr3c9ngofakDqngjiFSYqY4wc8=
X-Google-Smtp-Source: AKy350Z/ouYhbA24iJfTXEZx1+wU7rGNdnvzbqZeKAZPdbHpEVh1niBkGpSPbjIMGB7HZYUkoh2anw==
X-Received: by 2002:a17:902:82c7:b0:19e:61cc:6793 with SMTP id u7-20020a17090282c700b0019e61cc6793mr5448157plz.48.1682102838045;
        Fri, 21 Apr 2023 11:47:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id iy11-20020a170903130b00b0019f27fd7cecsm3026410plb.197.2023.04.21.11.47.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:47:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running
Date:   Fri, 21 Apr 2023 11:47:16 -0700
Message-Id: <20230421184716.2846319-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure hci_cmd_sync_queue only queue new work if HCI_RUNNING
has been set otherwise there is a risk of commands being sent while
turning off.

Because hci_cmd_sync_queue can no longer queue work while HCI_RUNNING is
not set it cannot be used to power on adapters so instead
hci_cmd_sync_submit is introduced which bypass the HCI_RUNNING check, so
it behaves like the old implementation.

Link: https://lore.kernel.org/all/CAB4PzUpDMvdc8j2MdeSAy1KkAE-D3woprCwAdYWeOc-3v3c9Sw@mail.gmail.com/
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  2 ++
 net/bluetooth/hci_sync.c         | 25 +++++++++++++++++++++++--
 net/bluetooth/mgmt.c             | 12 ++++++++----
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index f61b249787fc..2495be4d8b82 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -41,6 +41,8 @@ void hci_cmd_sync_clear(struct hci_dev *hdev);
 void hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
 void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
 
+int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 771aaa808967..647a8ce54062 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -684,8 +684,12 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 }
 EXPORT_SYMBOL(hci_cmd_sync_cancel);
 
-int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
-		       void *data, hci_cmd_sync_work_destroy_t destroy)
+/* Submit HCI command to be run in as cmd_sync_work:
+ *
+ * - hdev must _not_ be unregistered
+ */
+int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	struct hci_cmd_sync_work_entry *entry;
 
@@ -708,6 +712,23 @@ int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 
 	return 0;
 }
+EXPORT_SYMBOL(hci_cmd_sync_submit);
+
+/* Queue HCI command:
+ *
+ * - hdev must be running
+ */
+int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+		       void *data, hci_cmd_sync_work_destroy_t destroy)
+{
+	/* Only queue command if hdev is running which means it had been opened
+	 * and is either on init phase or is already up.
+	 */
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return -ENETDOWN;
+
+	return hci_cmd_sync_submit(hdev, func, data, destroy);
+}
 EXPORT_SYMBOL(hci_cmd_sync_queue);
 
 int hci_update_eir_sync(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 13c745876b39..f7b2d0971f24 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1400,11 +1400,15 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	/* Cancel potentially blocking sync operation before power off */
-	if (cp->val == 0x00)
+	if (cp->val == 0x00) {
 		__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
-
-	err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
-				 mgmt_set_powered_complete);
+		err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
+					 mgmt_set_powered_complete);
+	} else {
+		/* Use hci_cmd_sync_submit since hdev might not be running */
+		err = hci_cmd_sync_submit(hdev, set_powered_sync, cmd,
+					  mgmt_set_powered_complete);
+	}
 
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
2.39.2

