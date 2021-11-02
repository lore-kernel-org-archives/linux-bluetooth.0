Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC3CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 05:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3EB60F70
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Nov 2021 05:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhKBFwa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Nov 2021 01:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBFw2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Nov 2021 01:52:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F98C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 22:49:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t21so14283426plr.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwQq8DK/IihAc0GEYkL4N4lIvsDCiGDVQs+nB9fwibo=;
        b=Lz9UEgp/dHif4+nnriWPv/UC3BAIrH8bSZfC58WbFc5OOOXx2lEh00pgXIzdBmxpLI
         nQ+JaPLItPLek8n9NbSeoODrmsI1vV4cnhgYlkv5R69IT86jthf3NhFwohXVLBAW+xTX
         630+fWkEfNo+QIMzmkbsJdPBXNgNgcG7gvpWHMURdHm6bayGgiy6kwfYSJpbBI91H6Bq
         pYAYsZzmvbIhBGpl1fOGE3Sq4yixlB2h/5LWms3tix3oMikcAuSItXgI3CfgtLlg6GAp
         613A8NMWMfcZgQaSvRG0hOGOFRlhPzWsSCucB5qjC3OxaiPhxeLe1imYok0cdgr3aYKv
         1FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HwQq8DK/IihAc0GEYkL4N4lIvsDCiGDVQs+nB9fwibo=;
        b=xsIyK5f8c3Dr621EZLKTIWw5M0wDAQDNhyp8ltzfDKE3D/KJxmVrRdLOMMDGkRfPmt
         nG5dxE+ecOMj5DuJ4gy+GNwNtLAX12mJ48wIsgh6iMu3+trWNj3GtXDWwkTHLFW5yxRe
         yusFw296ZFZ7mQn03sSJWlUC+LFSRjw921lzlVFWx0CkxVfLePWOM5fxoIP6VRelQCu8
         zR5rjcVNa15Mbw+DqSTPPnZREsHQsCBWd5L2Hw39X+179ax3gGnd409Npu4hrfx1Hm2x
         ENohEY5HEbKbumqvSgGqymVYOTo3+VJJ3s+2Kp+ZfgHec2BQw6zyIWrnrXLDUjnKGW7A
         iO3g==
X-Gm-Message-State: AOAM531f2JC9FY13qtFYCqzcOsrePR7JLcs2UX11XoWGZBCIAIgLqraf
        qW1qh2GLf7O7SXBKebf+ff5SN5UPkrQ=
X-Google-Smtp-Source: ABdhPJxSDSCz1NTEZorsvKTfWYRPTQsurCSnSO6esCpHprYRTK/bNWV5DfKC9jkAszkz//pgNLuMFA==
X-Received: by 2002:a17:902:ab53:b0:141:7167:1c4f with SMTP id ij19-20020a170902ab5300b0014171671c4fmr29483276plb.30.1635832193429;
        Mon, 01 Nov 2021 22:49:53 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t7sm1212428pjs.45.2021.11.01.22.49.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 22:49:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] btdev: Add support for LE Set Privacy mode
Date:   Mon,  1 Nov 2021 22:49:51 -0700
Message-Id: <20211102054952.2898328-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for LE Set Privacy mode which is required when using
Device Privacy mode:

< HCI Command: LE Set Priva.. (0x08|0x004e) plen 8
        Peer Identity address type: Public (0x00)
        Peer Identity address: BC:9A:78:56:34:12 (OUI BC-9A-78)
        Privacy Mode: Use Device Privacy (0x01)
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Privacy Mode (0x08|0x004e) ncmd 1
---
 emulator/btdev.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7b311f347..50de186be 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -72,6 +72,7 @@ struct btdev_al {
 struct btdev_rl {
 	uint8_t type;
 	bdaddr_t addr;
+	uint8_t mode;
 	uint8_t peer_irk[16];
 	uint8_t local_irk[16];
 };
@@ -5336,6 +5337,48 @@ static int cmd_read_tx_power(struct btdev *dev, const void *data, uint8_t len)
 	return 0;
 }
 
+static int cmd_set_privacy_mode(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_priv_mode *cmd = data;
+	const struct btdev_rl *rl;
+	uint8_t status;
+
+	/* This command shall not be used when address resolution is enabled in
+	 * the Controller and:
+	 * • Advertising (other than periodic advertising) is enabled,
+	 * • Scanning is enabled, or
+	 * • an HCI_LE_Create_Connection, HCI_LE_Extended_Create_Connection,
+	 * or HCI_LE_Periodic_Advertising_Create_Sync command is pending.
+	 */
+	if (dev->le_rl_enable || dev->le_adv_enable || dev->le_scan_enable) {
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		goto done;
+	}
+
+	/* If the device is not on the resolving list, the Controller shall
+	 * return the error code Unknown Connection Identifier (0x02).
+	 */
+	rl = rl_find(dev, cmd->peer_id_addr_type, cmd->peer_id_addr);
+	if (!rl) {
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		goto done;
+	}
+
+	if (cmd->priv_mode > 0x01) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	((struct btdev_rl *)rl)->mode = cmd->priv_mode;
+	status = BT_HCI_ERR_SUCCESS;
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_PRIV_MODE, &status, sizeof(status));
+
+	return 0;
+}
+
 #define CMD_LE_50 \
 	CMD(BT_HCI_CMD_LE_SET_DEFAULT_PHY, cmd_set_default_phy,	NULL), \
 	CMD(BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR, cmd_set_adv_rand_addr, NULL), \
@@ -5372,7 +5415,8 @@ static int cmd_read_tx_power(struct btdev *dev, const void *data, uint8_t len)
 	CMD(BT_HCI_CMD_LE_CLEAR_PERIODIC_ADV_LIST, cmd_per_adv_clear, NULL), \
 	CMD(BT_HCI_CMD_LE_READ_PERIODIC_ADV_LIST_SIZE, \
 					cmd_read_per_adv_list_size, NULL), \
-	CMD(BT_HCI_CMD_LE_READ_TX_POWER, cmd_read_tx_power, NULL)
+	CMD(BT_HCI_CMD_LE_READ_TX_POWER, cmd_read_tx_power, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_PRIV_MODE, cmd_set_privacy_mode, NULL)
 
 static const struct btdev_cmd cmd_le_5_0[] = {
 	CMD_COMMON_ALL,
-- 
2.31.1

