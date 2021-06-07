Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E9CC47082
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD806023D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFGSnl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGSnl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 14:43:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C4C061766
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jun 2021 11:41:43 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y11so6374500pgp.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jun 2021 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IgO3P6uxtms8q0bieG/FxoM5uXnSbqtGxF7Q5v3/AY=;
        b=qnoZFUs7Lww9XBa+nDvQWkN633G0vfLxQ0JknlVoZcWcYeKK41Ywkd+t/IlhvNTPz3
         jkmXofkodnoywPkRVdLR7tuLP0c55Qy1G4JhTMGlbi9B6ZLeGG++OOWjqoo2gpzSCNJF
         nrQ3DfYpPy9vo7qEKatnzFzkpb5JLjTi4ycIW602xJzsX8afyDj4YT/ggGBEkif4DqKL
         1SSD4HEYeZcZL+HKP6P4KsnEx8MKAPK0vpfd2qmSEjU9EcN3uu3WZf+D6Xc+dsm2OB9p
         WMVLBVWJ16n9ChcpD5Rk17cKHNVkBMjS/9vf3e5MCbUZGReN1xuPOscqdRXMNcXXNmy5
         8Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7IgO3P6uxtms8q0bieG/FxoM5uXnSbqtGxF7Q5v3/AY=;
        b=LCInMPrcm4CQl3lTdcnSBiYlarKXZoAco9TYOQ+gMV3+W15fBdImgF/rl7vg2HWF8Z
         XFqWUQcz9oWGGkvm5x2rZCo8bOHFIG23l5axprwy44DpIWZ4M2m0oLfk+YztwPlm1IqJ
         UjPgTTUrLQr4Eg9l4KLQB7SY743mpzKG7Xfm+M/tWGDHV+73Oej1qPGOVs7n4aE+dv11
         7+JJk33XdGv0aQuz8o3Ox613Ul+PJeGLf60yd0usq0/S3RybgoMsaV4y4YlXlgPsjN4w
         rhc5MV75tFYuBSTtGLqGN8Fqm/CaDtTEx6OR8gjJh3a163jCXgj6wRqmCY1YpJftS08I
         u+0w==
X-Gm-Message-State: AOAM531ZCTMYius+DEsnkcmfM4e4CgB2WwYmA9YhWboFQZat04Jwm2tS
        176sRIU9t4Of/9u9H7QS7tlTBasNtJo=
X-Google-Smtp-Source: ABdhPJwAuWeOcFUHGhsX+qFcI2OepuZuCNc4KisdLbHJJjjK0fz/W1wtPGutuBdJgVbxtze3G4sXdw==
X-Received: by 2002:aa7:96e3:0:b029:2ec:e8a1:3d66 with SMTP id i3-20020aa796e30000b02902ece8a13d66mr11670123pfq.79.1623091302423;
        Mon, 07 Jun 2021 11:41:42 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u13sm9435241pga.64.2021.06.07.11.41.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:41:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] btdev: Check advertising/scanning states when changing White List
Date:   Mon,  7 Jun 2021 11:41:32 -0700
Message-Id: <20210607184134.2664349-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

White List cannot be changed when advertising/scanning:

• any advertising filter policy uses the White List and advertising is
enabled,
• the scanning filter policy uses the White List and scanning is
enabled, or
• the initiator filter policy uses the White List and an
HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
command is outstanding.
---
 emulator/btdev.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ad5bb8d92..bfee0ed7b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -150,11 +150,13 @@ struct btdev {
 	uint8_t  le_adv_own_addr;
 	uint8_t  le_adv_direct_addr_type;
 	uint8_t  le_adv_direct_addr[6];
+	uint8_t  le_adv_filter_policy;
 	uint8_t  le_scan_data[31];
 	uint8_t  le_scan_data_len;
 	uint8_t  le_scan_enable;
 	uint8_t  le_scan_type;
 	uint8_t  le_scan_own_addr_type;
+	uint8_t  le_scan_filter_policy;
 	uint8_t  le_filter_dup;
 	uint8_t  le_adv_enable;
 	uint8_t  le_periodic_adv_enable;
@@ -3002,6 +3004,7 @@ static int cmd_set_adv_params(struct btdev *dev, const void *data, uint8_t len)
 	dev->le_adv_own_addr = cmd->own_addr_type;
 	dev->le_adv_direct_addr_type = cmd->direct_addr_type;
 	memcpy(dev->le_adv_direct_addr, cmd->direct_addr, 6);
+	dev->le_adv_filter_policy = cmd->filter_policy;
 
 	status = BT_HCI_ERR_SUCCESS;
 
@@ -3223,6 +3226,7 @@ static int cmd_set_scan_params(struct btdev *dev, const void *data, uint8_t len)
 	status = BT_HCI_ERR_SUCCESS;
 	dev->le_scan_type = cmd->type;
 	dev->le_scan_own_addr_type = cmd->own_addr_type;
+	dev->le_scan_filter_policy = cmd->filter_policy;
 
 done:
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_SCAN_PARAMETERS, &status,
@@ -3396,10 +3400,45 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static bool wl_can_change(struct btdev *dev)
+{
+	 /* filter policy uses the White List and advertising is enable. */
+	if (dev->le_adv_enable && dev->le_adv_filter_policy)
+		return false;
+
+	/* scanning filter policy uses the White List and scanning is enabled */
+	if (dev->le_scan_enable) {
+		switch (dev->le_scan_filter_policy) {
+		case 0x00:
+			return true;
+		case 0x01:
+			return false;
+		case 0x02:
+			return true;
+		case 0x03:
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int cmd_wl_clear(struct btdev *dev, const void *data, uint8_t len)
 {
 	uint8_t status;
 
+	/* This command shall not be used when:
+	 * • any advertising filter policy uses the White List and advertising
+	 * is enabled,
+	 * • the scanning filter policy uses the White List and scanning is
+	 * enabled, or
+	 * • the initiator filter policy uses the White List and an
+	 * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
+	 * command is outstanding.
+	 */
+	if (!wl_can_change(dev))
+		return -EPERM;
+
 	wl_clear(dev);
 
 	status = BT_HCI_ERR_SUCCESS;
@@ -3425,6 +3464,18 @@ static int cmd_add_wl(struct btdev *dev, const void *data, uint8_t len)
 	bool exists = false;
 	int i, pos = -1;
 
+	/* This command shall not be used when:
+	 * • any advertising filter policy uses the White List and advertising
+	 * is enabled,
+	 * • the scanning filter policy uses the White List and scanning is
+	 * enabled, or
+	 * • the initiator filter policy uses the White List and an
+	 * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
+	 * command is outstanding.
+	 */
+	if (!wl_can_change(dev))
+		return -EPERM;
+
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
@@ -3464,6 +3515,18 @@ static int cmd_remove_wl(struct btdev *dev, const void *data, uint8_t len)
 	int i;
 	char addr[18];
 
+	/* This command shall not be used when:
+	 * • any advertising filter policy uses the White List and advertising
+	 * is enabled,
+	 * • the scanning filter policy uses the White List and scanning is
+	 * enabled, or
+	 * • the initiator filter policy uses the White List and an
+	 * HCI_LE_Create_Connection or HCI_LE_Extended_Create_Connection
+	 * command is outstanding.
+	 */
+	if (!wl_can_change(dev))
+		return -EPERM;
+
 	/* Valid range for address type is 0x00 to 0x01 */
 	if (cmd->addr_type > 0x01)
 		return -EINVAL;
@@ -4120,6 +4183,7 @@ static int cmd_set_ext_adv_params(struct btdev *dev, const void *data,
 	dev->le_adv_own_addr = cmd->own_addr_type;
 	dev->le_adv_direct_addr_type = cmd->peer_addr_type;
 	memcpy(dev->le_adv_direct_addr, cmd->peer_addr, 6);
+	dev->le_adv_filter_policy = cmd->filter_policy;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
 	rsp.tx_power = 0;
@@ -4380,6 +4444,7 @@ static int cmd_set_ext_scan_params(struct btdev *dev, const void *data,
 		 */
 		dev->le_scan_type = scan->type;
 		dev->le_scan_own_addr_type = cmd->own_addr_type;
+		dev->le_scan_filter_policy = cmd->filter_policy;
 	}
 
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS, &status,
@@ -5761,6 +5826,9 @@ static const struct btdev_cmd *default_cmd(struct btdev *btdev, uint16_t opcode,
 		case -EINVAL:
 			status = BT_HCI_ERR_INVALID_PARAMETERS;
 			goto failed;
+		case -EPERM:
+			status = BT_HCI_ERR_COMMAND_DISALLOWED;
+			goto failed;
 		default:
 			status = BT_HCI_ERR_UNSPECIFIED_ERROR;
 			goto failed;
-- 
2.31.1

