Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5657C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 19:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DCA2067B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 19:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncj3/0XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKKTzR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:55:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39852 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfKKTzR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 14:55:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id t26so552295wmi.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2019 11:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LDrTi5ReytH2RzFl9vllMt+W8+QsnULHo/EQvkib30=;
        b=Ncj3/0XKEt0aFdZbf7nxAqbL2i6zIexsrMnNaILD9uuzy6lpEF+KBRJMPWBSQBu75N
         ql6D+a7goWqgQ/Yzohb011iwTxPo3U+2RSXQxMjDFiHxynYU8DKF+/dkB266OmvXek/H
         5yRVQrP+WUxja2gSj/aiXRhy8/djMsgoeNAa00/e8Eme3DYjvn1uSB49Y/3Ad8gGpqED
         QIiSIV2GiKFhDbWukZv0QUA2uElSHoSrseyQCkphlTjtqnWjFwNeEIVSyi/uLKmXf3UZ
         GKRlzkRKLd0aRE+WkRLLVpNgEUW+roB5U6V2XDiu4FsSxZUCARUXeej0dUsHk32+DqIb
         2lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LDrTi5ReytH2RzFl9vllMt+W8+QsnULHo/EQvkib30=;
        b=a9BEXHKgiEOnB7icjD4oBizIns0ALsvgt+WWnDiTIGwONB5z31hIaEfAha96UPZaqr
         H0kpSlqhdsbrfpTi6RZ2fwBAtj6EKJvpVXmtYWwB7YdhguetYI5LT6WifPnf6QJ6OVzq
         HanyePC1o9ODnch8BY/ziwButKYcbu1XPvHVRlfTic0f1YzmW3g+ibsBuP2T5IsnaddE
         rvx4eaemwaG+6j5eGReVzWSbbns9BUi+i6Q/WDNWYwggQMVx/fCptvNU0RGV/ZXtrLPs
         CsVUyDx7pxIm1yJV36aFIGi3lD0+XOiorj6Du1nMaDXWx0W0leXW43FluStiJdfmjROi
         5yoQ==
X-Gm-Message-State: APjAAAVok+/pWTtOOTf2byRsebW1eMjD/DYixfu9St0E0iaL+z540O3b
        uic4l29vBiL7HCgJ9JtOB2C9mlZx
X-Google-Smtp-Source: APXvYqxoksi8T+3DnbkUqilu4FiS5xjx71fchyWldS8wWq5o0RFDfigeJHeHzRpoSdDqPua7A6Qmdw==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr572787wmk.85.1573502114570;
        Mon, 11 Nov 2019 11:55:14 -0800 (PST)
Received: from localhost.localdomain ([82.194.117.134])
        by smtp.gmail.com with ESMTPSA id r15sm35333186wrc.5.2019.11.11.11.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Nov 2019 11:55:14 -0800 (PST)
From:   Matthias Wauer <matthiaswauer@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Matthias Wauer (PRETTL)" <Matthias.Wauer@prettl-electronics.com>
Subject: [PATCH] bluetooth: set connection handle to invalid value when creating hci_conn
Date:   Mon, 11 Nov 2019 20:52:35 +0100
Message-Id: <20191111195235.85941-1-matthiaswauer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Matthias Wauer (PRETTL)" <Matthias.Wauer@prettl-electronics.com>

hci_conn_hash_lookup_handle can fail to find the correct hci_conn object
if the actual handle value is 0 and more than one hci_conn object is
around, for example when connection attempts are pending (also handle
value 0). On an external disconnection event this might free the wrong
object and not cleanup the sysfs entry on disconnection and lead to the
following when handle 0 is reused by the controller for a new connection.
Additionally the device will still be considered connected and connection
attempts are canceled.

Workqueue: hci0 hci_rx_work
[<80112334>] (unwind_backtrace) from [<8010d108>] (show_stack+0x20/0x24)
[<8010d108>] (show_stack) from [<809b8a44>] (dump_stack+0x80/0x94)
[<809b8a44>] (dump_stack) from [<8012faa4>] (__warn+0xec/0x114)
[<8012faa4>] (__warn) from [<8012fb14>] (warn_slowpath_fmt+0x48/0x50)
[<8012fb14>] (warn_slowpath_fmt) from [<802e2be0>] (sysfs_warn_dup+0x78/0x88)
[<802e2be0>] (sysfs_warn_dup) from [<802e2cd0>] (sysfs_create_dir_ns+0x8c/0x9c)
[<802e2cd0>] (sysfs_create_dir_ns) from [<809bd48c>] (kobject_add_internal+0xb8/0x328)
[<809bd48c>] (kobject_add_internal) from [<809bd8d4>] (kobject_add+0x50/0x98)
[<809bd8d4>] (kobject_add) from [<805ac308>] (device_add+0x114/0x5e4)
[<805ac308>] (device_add) from [<8095fbf0>] (hci_conn_add_sysfs+0x5c/0xb0)
[<8095fbf0>] (hci_conn_add_sysfs) from [<8094b6c4>] (hci_le_meta_evt+0xb9c/0x11b8)
[<8094b6c4>] (hci_le_meta_evt) from [<8094c510>] (hci_event_packet+0x830/0x2e60)
[<8094c510>] (hci_event_packet) from [<8093aaa4>] (hci_rx_work+0x1e0/0x3c0)
[<8093aaa4>] (hci_rx_work) from [<8014ab5c>] (process_one_work+0x1f8/0x590)
[<8014ab5c>] (process_one_work) from [<8014ba70>] (worker_thread+0x6c/0x588)
[<8014ba70>] (worker_thread) from [<801512b4>] (kthread+0x170/0x178)
[<801512b4>] (kthread) from [<80108f28>] (ret_from_fork+0x14/0x2c)
kobject_add_internal failed for hci0:0 with -EEXIST, don't try to register things with the same name in the same directory.

Signed-off-by: Matthias Wauer (PRETTL) <Matthias.Wauer@prettl-electronics.com>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_conn.c    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bc1e30dedde..9e5029f77e0c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -512,6 +512,8 @@ enum {
 /* The core spec defines 127 as the "not available" value */
 #define HCI_TX_POWER_INVALID	127
 #define HCI_RSSI_INVALID	127
+/* The core spec defines 0xfff as invalid reserved handle value */
+#define HCI_CONN_HANDLE_INVALID 0xFFF
 
 #define HCI_ROLE_MASTER		0x00
 #define HCI_ROLE_SLAVE		0x01
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ad5b0ac1f9ce..bb3022236e8d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -502,6 +502,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	if (!conn)
 		return NULL;
 
+	conn->handle = HCI_CONN_HANDLE_INVALID;
 	bacpy(&conn->dst, dst);
 	bacpy(&conn->src, &hdev->bdaddr);
 	conn->hdev  = hdev;
-- 
2.17.1

