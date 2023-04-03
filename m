Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BA7C76188
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 22:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjDCWoT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjDCWoR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 18:44:17 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901101BF2
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 15:44:16 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t19so29912317qta.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vsK69wzVhuNdd6vq7tGbnxcDG+R5rQe6zySZ3dYu+nc=;
        b=jE20Z6xo1oQoWNjNVGPeSVQQUl1T6AiUU5yVScXB5+EVewx8hJ5O9H+GHVQt+yP1iq
         rFJnOc14h3aVx9pXLGX8spDpFRAgjycIWspvVd3Dxl0AQ7Pbzx8F+Mo/HCmpEwqlcJs7
         VrG/IgFyPINohIHyqJJCnoDR3LWkLWDTdqcdaIwz0iNRf/GO6zv/KItfZikOlFBRZX9o
         LEkMujxOIaL6u4hypFoQTda4Jv7s8ddndVo51WJBOEPTheo290a5Dp0xcWUjDabLLiW3
         BKehVM5KhLq0d1C49EHm/MZqm8500LimPt7/YZAGz5a4IEA5sJMsRR1rqtrywQ1894+I
         TXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsK69wzVhuNdd6vq7tGbnxcDG+R5rQe6zySZ3dYu+nc=;
        b=3lsCvCfU0Wn7cha2MZcYHfwtyiKrWINR4QXP1v4kXsyFd0BLpQeajmrZwd9FiPI8Gj
         FQYd/BU+GZFMS/GCZllN75Qwc6B6CrtJP+O7gbtsklsQxElpEPa6hagHw0yvSbEU574S
         XB+tH42e69HxpB59UzTSsgTbuyO+yq4pBSs3X+S/EOSNVyrUhj4bOyBSu8xSiqMx6Uh3
         Kn4u2NryuARmZ6lEvs4DCgHLDcfkk9CKMynx093VJ4syk8z6AWB2PGhC4hdo5GSxz49A
         tvMxZXpD0CROfBmqwBGiyo4fUk4w5KVPPD664wDHyMO3XXuJoC4AcDLUmWCwc7k9IIZX
         E8HQ==
X-Gm-Message-State: AAQBX9cO6doVNvPk+F0Njs0bFI71s7EBVotEx26kJg/ltSFadWocP1VY
        JYl5qgT7GimN/ann8+oG/lbnA5H/3BI=
X-Google-Smtp-Source: AKy350ZsYAueso3DV9M886YM7pVaqOBHYyIx3hBAvyoNoIAJ6bsSaSA4Xa3havtCmjeu35n8CSjkmg==
X-Received: by 2002:ac8:5ac8:0:b0:3e6:3b1d:f922 with SMTP id d8-20020ac85ac8000000b003e63b1df922mr197455qtd.50.1680561855213;
        Mon, 03 Apr 2023 15:44:15 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id z18-20020a376512000000b0074283b87a4esm3131282qkb.90.2023.04.03.15.44.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:44:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_conn: Fix possible UAF
Date:   Mon,  3 Apr 2023 15:44:12 -0700
Message-Id: <20230403224412.2021594-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following trace:

==================================================================
BUG: KASAN: slab-use-after-free in hci_conn_del+0xba/0x3a0
Write of size 8 at addr ffff88800208e9c8 by task iso-tester/31

CPU: 0 PID: 31 Comm: iso-tester Not tainted 6.3.0-rc2-g991aa4a69a47
 #4716
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc36
04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x1d/0x70
 print_report+0xce/0x610
 ? __virt_addr_valid+0xd4/0x150
 ? hci_conn_del+0xba/0x3a0
 kasan_report+0xdd/0x110
 ? hci_conn_del+0xba/0x3a0
 hci_conn_del+0xba/0x3a0
 hci_conn_hash_flush+0xf2/0x120
 hci_dev_close_sync+0x388/0x920
 hci_unregister_dev+0x122/0x260
 vhci_release+0x4f/0x90
 __fput+0x102/0x430
 task_work_run+0xf1/0x160
 ? __pfx_task_work_run+0x10/0x10
 ? mark_held_locks+0x24/0x90
 exit_to_user_mode_prepare+0x170/0x180
 syscall_exit_to_user_mode+0x19/0x50
 do_syscall_64+0x4e/0x90
 entry_SYSCALL_64_after_hwframe+0x70/0xda

Fixes: 0f00cd322d22 ("Bluetooth: Free potentially unfreed SCO connection")
Link: https://syzkaller.appspot.com/bug?extid=8bb72f86fc823817bc5d
Cc: <stable@vger.kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe8d54f8f04f..5672b4924572 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1069,6 +1069,17 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return conn;
 }
 
+static bool hci_conn_unlink(struct hci_conn *conn)
+{
+	if (!conn->link)
+		return false;
+
+	conn->link->link = NULL;
+	conn->link = NULL;
+
+	return true;
+}
+
 int hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -1080,15 +1091,16 @@ int hci_conn_del(struct hci_conn *conn)
 	cancel_delayed_work_sync(&conn->idle_work);
 
 	if (conn->type == ACL_LINK) {
-		struct hci_conn *sco = conn->link;
-		if (sco) {
-			sco->link = NULL;
+		struct hci_conn *link = conn->link;
+
+		if (link) {
+			hci_conn_unlink(conn);
 			/* Due to race, SCO connection might be not established
 			 * yet at this point. Delete it now, otherwise it is
 			 * possible for it to be stuck and can't be deleted.
 			 */
-			if (sco->handle == HCI_CONN_HANDLE_UNSET)
-				hci_conn_del(sco);
+			if (link->handle == HCI_CONN_HANDLE_UNSET)
+				hci_conn_del(link);
 		}
 
 		/* Unacked frames */
@@ -1104,7 +1116,7 @@ int hci_conn_del(struct hci_conn *conn)
 		struct hci_conn *acl = conn->link;
 
 		if (acl) {
-			acl->link = NULL;
+			hci_conn_unlink(conn);
 			hci_conn_drop(acl);
 		}
 
@@ -2444,6 +2456,12 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 		c->state = BT_CLOSED;
 
 		hci_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
+
+		/* Unlink before deleting otherwise it is possible that
+		 * hci_conn_del removes the link which may cause the list to
+		 * contain items already freed.
+		 */
+		hci_conn_unlink(c);
 		hci_conn_del(c);
 	}
 }
-- 
2.39.2

