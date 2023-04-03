Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C845FC76188
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 21:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjDCV17 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjDCV16 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 17:27:58 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58912AC
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 14:27:56 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x8so22148798qvr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680557275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilYwJJ0lhNQsFS7oyUwP3FvStNQhr++4sKn4Ps9PEAs=;
        b=ASFnd/sjUDrSAmZW7U+XSAIY3Mo5DgYtn3jAs40vvAj10EDoGxAgt/lCNJX7/3Eo+Y
         4tEL9fbLXPjfBa+m4CeF5k8ggMpagFh/N3IG11SBUeXh9TQDyw7pnIepoMXMw8y4vfxF
         B9+bQoTuuPQbEYvydgSMws/Z5XoJrgIHltJZ2yYMmi/3IDV5N5AesCMur86sZrGVaohQ
         AlKJTyJOwWanD52Rtkh6iiFpSxS+zgzV45e2OhAsTYipbaxwLnu8ixh0BoEpo0/0nKwq
         MQ+vvI0jQGQMl+PXxwncPzlC7D83IqrwVskCNHS9dQfXXqs/6b4VgXvdjZEHFVKL5GiF
         ydag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680557275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilYwJJ0lhNQsFS7oyUwP3FvStNQhr++4sKn4Ps9PEAs=;
        b=OSR2kPoZUWMLDjP6qv8JZ/d/EsnWQr+j1mfz8uQET2wb3jtKpAgTAVjHHRFPkLQIOr
         U5eJdicP3TIF2nchK6L0YPJ+sN85Pi20cQSLlJNEPx6fGyC9CInwW++TYRtocS9fOkcE
         RplVscana/G+aCPhGO2RoimkOi/YTpTVsJmdtOl4e+qptCxVVX6otRDQC3e04NGHcBFx
         0O7hphnW/Q8xbII/nAkaNi06uKP3azt5twJ064NvFNouNJmx1SY14dx71tjJh2fPIWuq
         Dpg53QHjvEQsIC4+PBzNyY+R/gw2r02SpTagf1k1PHwvNt3h9xkMeyv02xsL5//pQNQT
         7n1A==
X-Gm-Message-State: AAQBX9eKkj8ZgJvaWdaxFlcfCsgLNwd9tVPxh6IzrT8w+76vdVz5tvDx
        XfScTn9NQgLudkujIymy6pGYIQXI5iw=
X-Google-Smtp-Source: AKy350bwYIaJwoC2lIEx9gAMPcT3uDFAfow2EpfiLVehIMoa8xAbuEgT39jpKij7YSPAAowFdTkDHg==
X-Received: by 2002:a05:6214:29ce:b0:5c2:29f1:d677 with SMTP id gh14-20020a05621429ce00b005c229f1d677mr248664qvb.23.1680557274777;
        Mon, 03 Apr 2023 14:27:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id lw6-20020a05621457c600b005dd8b934595sm2930664qvb.45.2023.04.03.14.27.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 14:27:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: Fix possible UAF
Date:   Mon,  3 Apr 2023 14:27:52 -0700
Message-Id: <20230403212752.2005496-1-luiz.dentz@gmail.com>
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

