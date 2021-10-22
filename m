Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 22:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18ADA60E05
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 22:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhJVW37 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Oct 2021 18:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbhJVW36 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Oct 2021 18:29:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E4C061764
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 15:27:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i1so3686011plr.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 15:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZI0QpHBx22DTTymHPcUoFhx4Zy1Gb38J6QqU2uNq7Q8=;
        b=SlCBo1olBfMqKBvQafCjt/z6xTyiR2Bz4J5doiCdhRMpkTPj+eGlh4AkuiVnj1ilD1
         8Xw/U8r4fbF4gZqa54Fc7miW2ISP/r2fFuUe5AJHeqCRHgK4YVzFy+h6ujzjqyMXOGXy
         NooRC3opLtISDXtdWO+BSkxdRxd8Fmz0S4qOqeQWKAGhsfmVDiJWzVSfO70r/OkzO1oN
         OOB+tiYM22mB73RyZZzK1T2Rr5T5adhAvr+zmEdBP4mLL2yOXBk+XSY4MmyUSSqd78C7
         ehdE8Y5q1IrbtPi2t2UyNu313+RY3cuRocv5T80vpFVKlWJWntvUun0IfdWKshkb9itU
         0COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZI0QpHBx22DTTymHPcUoFhx4Zy1Gb38J6QqU2uNq7Q8=;
        b=QsHgZZvDF8kmV9omu8T1DfbrS1MN/RGPvgHU3kJMhOIMeU9RG77Z/xkx5bTJNlYm11
         380OwM8NubSWQeylfATr8TsvejGovOwruPocvHGPCGxhIbVCJ0CKqic0iRfvikYeLA7a
         S/4yr2g1fjBynH21U6wRFPKDB8JeC+XwduZH0HOgyrPMIVgyCSLrzEpQpn2kwp74YhOu
         +3dv9mkBEFlJ1cW7LxJ3Ekk9fwGXnLB6CjjbJgMxnUO6BL3Upvk4yNAbit0zdj3nFdMy
         h+9xgRzpyQSAEQ3q04JVuyUDeSjLF7Lv/fipug4gtoGm7CK1I27H+hvCjcXjapHrEPGv
         Apbg==
X-Gm-Message-State: AOAM530nQtr/5NE0SEtsWHyDz7kTwoOtjrDEHOXzsXgh5u6DO/TTW5XR
        yLXoJUkduVIqSzu9gvBOvz2TS1EaqJo=
X-Google-Smtp-Source: ABdhPJwxvay/s/lSCVNaA9mSdjmCVLapf39tdHOvqZ5elHJep2cfOVeqCk9UfJTgaZrnOTwyHZAQtQ==
X-Received: by 2002:a17:903:1207:b0:138:e2f9:6c98 with SMTP id l7-20020a170903120700b00138e2f96c98mr2725889plh.11.1634941658667;
        Fri, 22 Oct 2021 15:27:38 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3sm10779380pfr.98.2021.10.22.15.27.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:27:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] btdev: Fix using the callback return as command complete
Date:   Fri, 22 Oct 2021 15:27:37 -0700
Message-Id: <20211022222737.807013-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Command callback can only be used when generating a command status as
command complete can carry more than just the status.
---
 emulator/btdev.c | 120 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 36 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e129b5cda..7b311f347 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3677,12 +3677,16 @@ static int cmd_add_al(struct btdev *dev, const void *data, uint8_t len)
 	 * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
 	 * command is outstanding.
 	 */
-	if (!al_can_change(dev))
-		return -EPERM;
+	if (!al_can_change(dev)) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
 
 	/* Valid range for address type is 0x00 to 0x01 */
-	if (cmd->addr_type > 0x01)
-		return -EINVAL;
+	if (cmd->addr_type > 0x01) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
 	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
@@ -3694,18 +3698,25 @@ static int cmd_add_al(struct btdev *dev, const void *data, uint8_t len)
 			pos = i;
 	}
 
-	if (exists)
-		return -EALREADY;
+	/* If the device is already in the Filter Accept List, the Controller
+	 * should not add the device to the Filter Accept List again and should
+	 * return success.
+	 */
+	if (exists) {
+		status = BT_HCI_ERR_SUCCESS;
+		goto done;
+	}
 
 	if (pos < 0) {
-		cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
-					BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST);
-		return 0;
+		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
 	}
 
 	al_add(&dev->le_al[pos], cmd->addr_type, (bdaddr_t *)&cmd->addr);
 
 	status = BT_HCI_ERR_SUCCESS;
+
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
 						&status, sizeof(status));
 
@@ -3728,12 +3739,16 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 	 * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
 	 * command is outstanding.
 	 */
-	if (!al_can_change(dev))
-		return -EPERM;
+	if (!al_can_change(dev)) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
 
 	/* Valid range for address type is 0x00 to 0x01 */
-	if (cmd->addr_type > 0x01)
-		return -EINVAL;
+	if (cmd->addr_type > 0x01) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
 	for (i = 0; i < dev->le_al_len; i++) {
 		struct btdev_al *al = &dev->le_al[i];
@@ -3750,10 +3765,14 @@ static int cmd_remove_al(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == dev->le_al_len)
-		return -EINVAL;
+	if (i == dev->le_al_len) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
 	status = BT_HCI_ERR_SUCCESS;
+
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
 						&status, sizeof(status));
 
@@ -3774,12 +3793,16 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
 	 * or HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
 	 */
-	if (dev->le_adv_enable || dev->le_scan_enable)
-		return -EPERM;
+	if (dev->le_adv_enable || dev->le_scan_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
 
 	/* Valid range for address type is 0x00 to 0x01 */
-	if (cmd->addr_type > 0x01)
-		return -EINVAL;
+	if (cmd->addr_type > 0x01) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
 	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
@@ -3791,13 +3814,18 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 			pos = i;
 	}
 
-	if (exists)
-		return -EALREADY;
+	/* If an entry already exists in the resolving list with the same four
+	 * parameter values, the Controller shall either reject the command or
+	 * not add the device to the resolving list again and return success.
+	 */
+	if (exists) {
+		status = BT_HCI_ERR_SUCCESS;
+		goto done;
+	}
 
 	if (pos < 0) {
-		cmd_status(dev, BT_HCI_ERR_MEM_CAPACITY_EXCEEDED,
-					BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST);
-		return 0;
+		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
 	}
 
 	dev->le_rl[pos].type = cmd->addr_type;
@@ -3806,6 +3834,8 @@ static int cmd_add_rl(struct btdev *dev, const void *data, uint8_t len)
 	memcpy(dev->le_rl[pos].local_irk, cmd->local_irk, 16);
 
 	status = BT_HCI_ERR_SUCCESS;
+
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST,
 						&status, sizeof(status));
 
@@ -3825,12 +3855,16 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
 	 * or HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
 	 */
-	if (dev->le_adv_enable || dev->le_scan_enable)
-		return -EPERM;
+	if (dev->le_adv_enable || dev->le_scan_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
 
 	/* Valid range for address type is 0x00 to 0x01 */
-	if (cmd->addr_type > 0x01)
-		return -EINVAL;
+	if (cmd->addr_type > 0x01) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
 	for (i = 0; i < dev->le_rl_len; i++) {
 		struct btdev_rl *rl = &dev->le_rl[i];
@@ -3841,10 +3875,14 @@ static int cmd_remove_rl(struct btdev *dev, const void *data, uint8_t len)
 		}
 	}
 
-	if (i == dev->le_rl_len)
-		return -EINVAL;
+	if (i == dev->le_rl_len) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
 	status = BT_HCI_ERR_SUCCESS;
+
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
 						&status, sizeof(status));
 
@@ -3862,12 +3900,16 @@ static int cmd_clear_rl(struct btdev *dev, const void *data, uint8_t len)
 	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
 	 * or HCI_LE_Periodic_Advertising_Create_Sync command is outstanding.
 	 */
-	if (dev->le_adv_enable || dev->le_scan_enable)
-		return -EPERM;
+	if (dev->le_adv_enable || dev->le_scan_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
 
 	rl_clear(dev);
 
 	status = BT_HCI_ERR_SUCCESS;
+
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_CLEAR_RESOLV_LIST,
 						&status, sizeof(status));
 
@@ -3894,12 +3936,15 @@ static int cmd_read_peer_rl_addr(struct btdev *dev, const void *data,
 	struct bt_hci_rsp_le_read_peer_resolv_addr rsp;
 
 	/* Valid range for address type is 0x00 to 0x01 */
-	if (cmd->addr_type > 0x01)
-		return -EINVAL;
+	if (cmd->addr_type > 0x01) {
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
 	rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 	memset(rsp.addr, 0, 6);
 
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_PEER_RESOLV_ADDR,
 							&rsp, sizeof(rsp));
 
@@ -3913,12 +3958,15 @@ static int cmd_read_local_rl_addr(struct btdev *dev, const void *data,
 	struct bt_hci_rsp_le_read_local_resolv_addr rsp;
 
 	/* Valid range for address type is 0x00 to 0x01 */
-	if (cmd->addr_type > 0x01)
-		return -EINVAL;
+	if (cmd->addr_type > 0x01) {
+		rsp.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
 
 	rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 	memset(rsp.addr, 0, 6);
 
+done:
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR,
 							&rsp, sizeof(rsp));
 
-- 
2.31.1

