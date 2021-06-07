Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC55CC47094
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 18:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C242F61139
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 18:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhFGSor (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:44:47 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:54847 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhFGSor (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 14:44:47 -0400
Received: by mail-pj1-f48.google.com with SMTP id g24so10411024pji.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jun 2021 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YCOhDTGAO3dSYHWp1brg94HHn7mstrbL0puqB4KiTKo=;
        b=RhEPhO5pivo/hhkiMUs9vDT2RVi2Agcj0N7B6snMeNjij5g59v9trXpj/bJ+s48fgT
         RDiH/opdG2XEK3PDa4IH4YS9gJUR0uMxgFCTzDZ2LJWjS+7XAVtPs7bW9UwB0j0Fu4x4
         bSdUSJOLozONBoXa1aokjsinKt7FHtQs/roUV1lnc5F/oNfSg9c/4YrF0iDWccUbFXjv
         GrAcr7DBhxc4njPGaGXH1Lf7mdo3Ki2qOSdbS/VeNIs2ss8cbhUy+DUw1zplc8ryzVHq
         3sw027WtIca0BWtquvlrF1JCht6OIJ7f9xaH736Au575e50j5zsDNSnJOvhkafLbQyh0
         1n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCOhDTGAO3dSYHWp1brg94HHn7mstrbL0puqB4KiTKo=;
        b=djHMEeiJt2+AEfiG/ht4wfgrDhoSrfOdbKXInV+H3hz7TIkHDbjQZWr8H8IHMICnWJ
         sBbTwDyCS6GYRyEvmIZxeqvXsrLjUQKNAR7lb5sbA0chW8NoI5DsxocnJmtDyKe7W34/
         h4KtJRywc1RefgfIYxOaABqtSDmE8iRr+F2rfqFkrEubof2XMmKb3m94JGfjE/BAi+Gw
         oLrhaS9ubkO77VTQJSNkq+EY1T1OOFqxCQOCDJR/t6cOy9tUty8KsvbuSbXZQZi2nv09
         CC0MKTmB4dn9nCOq1oEXg2AnngAOHwN3G4l93tCewzj0l1aibuswnlsFhVG49kabB1AE
         RRYw==
X-Gm-Message-State: AOAM532Tx9eJbZUrhAb4m58QyoinnDRZ8C6HSHryZcfqM8ATOWQG01WD
        15zbt4HW9ZZDMbdUB/n1Gqf5KF8pI1w=
X-Google-Smtp-Source: ABdhPJxJkDmSFmRwNqgSkpWURl/a+PqZrD8YQnqCpU6EKLhYoEnNZyjMpwXo+amB9gGjHYTospZQzA==
X-Received: by 2002:a17:90b:803:: with SMTP id bk3mr522959pjb.224.1623091303128;
        Mon, 07 Jun 2021 11:41:43 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u13sm9435241pga.64.2021.06.07.11.41.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:41:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] btdev: Check advertising/scanning states when changing Resolving List
Date:   Mon,  7 Jun 2021 11:41:33 -0700
Message-Id: <20210607184134.2664349-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607184134.2664349-1-luiz.dentz@gmail.com>
References: <20210607184134.2664349-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Resolving List cannot be changed when advertising/scanning:

• Advertising (other than periodic advertising) is enabled,
• Scanning is enabled, or
• an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection, or
HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
---
 emulator/btdev.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index bfee0ed7b..eba9f57f9 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3566,6 +3566,16 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	bool exists = false;
 	int i, pos = -1;
 
+	/* This command shall not be used when address resolution is enabled in
+	 * the Controller and:
+	 * • Advertising (other than periodic advertising) is enabled,
+	 * • Scanning is enabled, or
+	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
+	 * or HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
+	 */
+	if (dev->le_adv_enable || dev->le_scan_enable)
+		return -EPERM;
+
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
@@ -3607,6 +3617,16 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 	uint8_t status;
 	int i;
 
+	/* This command shall not be used when address resolution is enabled in
+	 * the Controller and:
+	 * • Advertising (other than periodic advertising) is enabled,
+	 * • Scanning is enabled, or
+	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
+	 * or HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
+	 */
+	if (dev->le_adv_enable || dev->le_scan_enable)
+		return -EPERM;
+
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
@@ -3634,6 +3654,16 @@ static int cmd_clear_rl(struct btdev *dev, const void *data, uint8_t len)
 {
 	uint8_t status;
 
+	/* This command shall not be used when address resolution is enabled in
+	 * the Controller and:
+	 * • Advertising (other than periodic advertising) is enabled,
+	 * • Scanning is enabled, or
+	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
+	 * or HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
+	 */
+	if (dev->le_adv_enable || dev->le_scan_enable)
+		return -EPERM;
+
 	rl_clear(dev);
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3699,6 +3729,16 @@ static int cmd_set_rl_enable(struct btdev *dev, const void *data, uint8_t len)
 	const struct bt_hci_cmd_le_set_resolv_enable *cmd = data;
 	uint8_t status;
 
+	/* This command shall not be used when address resolution is enabled in
+	 * the Controller and:
+	 * • Advertising (other than periodic advertising) is enabled,
+	 * • Scanning is enabled, or
+	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
+	 * or HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
+	 */
+	if (dev->le_adv_enable || dev->le_scan_enable)
+		return -EPERM;
+
 	/* Valid range for address resolution enable is 0x00 to 0x01 */
 	if (cmd->enable > 0x01)
 		return -EINVAL;
-- 
2.31.1

