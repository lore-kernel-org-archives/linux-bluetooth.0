Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBCDC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 17:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjE1Rje (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 13:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1Rje (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 13:39:34 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00FDC
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 10:39:21 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 66EE2240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 19:39:19 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QTm9y6f1vz6tm4;
        Sun, 28 May 2023 19:39:18 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/4] btdev: check LE Create CIS error conditions
Date:   Sun, 28 May 2023 17:39:15 +0000
Message-Id: <8846153ed22812ecf49ac33c994b97650018f2d6.1685283364.git.pav@iki.fi>
In-Reply-To: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
References: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Check LE Create CIS input parameter are valid and return correct status
codes (Core v5.3 Vol 4 Part E Sec. 7.8.99).

On current bluetooth-next kernel, this results to

ISO AC 6(i) - Success                                Failed
ISO AC 7(i) - Success                                Failed
ISO AC 8(i) - Success                                Failed
ISO AC 9(i) - Success                                Failed
ISO AC 11(i) - Success                               Failed

as in these tests the kernel is sending new Create CIS commands before
it has seen all events from the previous, which is not allowed:

< HCI Command: LE Create Co.. (0x08|0x0064) plen 9  #129 [hci0]
        Number of CIS: 2
        CIS Handle: 257
        ACL Handle: 42
        CIS Handle: 258
        ACL Handle: 42
> HCI Event: Command Status (0x0f) plen 4           #130 [hci0]
      LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 29           #131 [hci0]
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 257
        ...
< HCI Command: LE Setup Is.. (0x08|0x006e) plen 13  #132 [hci0]
        ...
> HCI Event: Command Complete (0x0e) plen 6         #133 [hci0]
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        ...
< HCI Command: LE Create Co.. (0x08|0x0064) plen 5  #134 [hci0]
        Number of CIS: 1
        CIS Handle: 258
        ACL Handle: 42
> HCI Event: Command Status (0x0f) plen 4           #135 [hci0]
      LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
        Status: ACL Connection Already Exists (0x0b)
> HCI Event: LE Meta Event (0x3e) plen 29           #136 [hci0]
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 258
        ...

The emulator uses Already Exists error code here, not Command
Disallowed, since the Established events are logically generated
immediately after the first status event, even though the kernel hasn't
yet processed them.
---
 emulator/btdev.c | 38 ++++++++++++++++++++++++++++++++++++++
 monitor/bt.h     |  1 +
 2 files changed, 39 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 98d7af99e..08506c66e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5903,6 +5903,38 @@ static int cmd_set_cig_params_test(struct btdev *dev, const void *data,
 
 static int cmd_create_cis(struct btdev *dev, const void *data, uint8_t len)
 {
+	const struct bt_hci_cmd_le_create_cis *cmd = data;
+	int i, j;
+
+	for (i = 0; i < cmd->num_cis; i++) {
+		const struct bt_hci_cis *cis = &cmd->cis[i];
+		struct btdev_conn *acl;
+		struct btdev_conn *iso;
+		int cig_idx, cis_idx;
+
+		/* Check for errors (Core v5.3 Vol 4 Part E Sec. 7.8.99) */
+		for (j = 0; j < i; j++)
+			if (cis->cis_handle == cmd->cis[j].cis_handle)
+				return -EINVAL;
+
+		cig_idx = parse_cis_handle(le16_to_cpu(cis->cis_handle),
+								&cis_idx);
+		if (cig_idx < 0)
+			return -ENOENT;
+		if (cis_idx >= dev->le_cig[cig_idx].params.num_cis)
+			return -ENOENT;
+
+		acl = queue_find(dev->conns, match_handle,
+				 UINT_TO_PTR(le16_to_cpu(cis->acl_handle)));
+		if (!acl)
+			return -ENOENT;
+
+		iso = queue_find(dev->conns, match_handle,
+				 UINT_TO_PTR(le16_to_cpu(cis->cis_handle)));
+		if (iso)
+			return -EEXIST;
+	}
+
 	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_CREATE_CIS);
 
 	return 0;
@@ -7142,6 +7174,12 @@ static const struct btdev_cmd *run_cmd(struct btdev *btdev,
 	case -EPERM:
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
 		break;
+	case -EEXIST:
+		status = BT_HCI_ERR_CONN_ALREADY_EXISTS;
+		break;
+	case -ENOENT:
+		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		break;
 	default:
 		status = BT_HCI_ERR_UNSPECIFIED_ERROR;
 		break;
diff --git a/monitor/bt.h b/monitor/bt.h
index b99ada0b2..37fcdaeaa 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3713,6 +3713,7 @@ struct bt_hci_evt_le_big_info_adv_report {
 #define BT_HCI_ERR_AUTH_FAILURE			0x05
 #define BT_HCI_ERR_PIN_OR_KEY_MISSING		0x06
 #define BT_HCI_ERR_MEM_CAPACITY_EXCEEDED	0x07
+#define BT_HCI_ERR_CONN_ALREADY_EXISTS		0x0b
 #define BT_HCI_ERR_COMMAND_DISALLOWED		0x0c
 #define BT_HCI_ERR_UNSUPPORTED_FEATURE		0x11
 #define BT_HCI_ERR_INVALID_PARAMETERS		0x12
-- 
2.40.1

