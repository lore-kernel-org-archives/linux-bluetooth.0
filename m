Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48672E77372
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Sep 2023 12:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjI3Mxq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Sep 2023 08:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjI3Mxp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Sep 2023 08:53:45 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93727F1
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Sep 2023 05:53:43 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RyRwj0ZTYzydx;
        Sat, 30 Sep 2023 15:53:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696078421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0wjHwVlU1if1y3UnlVFwCUKcy5xWVCk+uJEVHd1moE=;
        b=mi3yaSuU1hZHLRyF1nQaCrUfFyYIRc3BjGfqh+g3939tAtl7Sh5/jMYZLooPV9R48TW8vb
        lYF3vfLovsJpcC9h8+EZjyV5stXngTvzy77vncUU6fK7+ShLDsTom8cxwxsSZGIL9qcKwa
        3diGvS8oA/iscgirfwLpgsmeLalxF6k=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696078421; a=rsa-sha256; cv=none;
        b=ReDjfgfnCzWdTBkKWfg9mmQZOPrgGPeyHA9ER0p5zj266D7iUbB7skb+YEGAeWcCEQc6zV
        J6DxRhLOsfRnb/LSXVpczl7gdw2pPr0qsBp8yMhvlfO5xIgFCxq9/Xpmn25KGqWfdX08Jm
        p4WwfPQq01Yllg3OPbSFUC0lg8OZQRk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696078421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0wjHwVlU1if1y3UnlVFwCUKcy5xWVCk+uJEVHd1moE=;
        b=YrXN2sp0PU3k1AhWo8gxMiIC7JoCA6JRcReOAxNLCSBjM39xMlzZ+xqMZj/hnPUJS1esiQ
        SjQjupJaUnf2somGKGL/t/yrKGrkjq7LYqMdoN2FGkrCA7c1cu9TNqH0ITX5bArEI5VQZs
        KpxbFdvDWjrL518xcQ8RCX5a8XbIUJo=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>, syzkaller-bugs@googlegroups.com,
        syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com
Subject: [PATCH v2 2/2] Bluetooth: hci_conn: verify connection is to be aborted before doing it
Date:   Sat, 30 Sep 2023 15:53:33 +0300
Message-ID: <fd9c0f0eddb8a7d73e9797568dc3cf2bc9b8ad62.1696077070.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
References: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a race condition where a connection handle is reused, after
hci_abort_conn but before abort_conn_sync is processed in hci_sync. In
this case, hci_abort_conn_sync ends up working on the wrong connection,
which can have abort_reason==0, in which case hci_connect_cfm is called
with success status and then connection is deleted, which causes various
use-after-free.

Fix by checking abort_reason is nonzero before calling
hci_abort_conn_sync. If it's zero, then the connection is probably a
different one than we expected and should not be aborted.

Also fix some theoretical UAF / races, where something frees the conn
while hci_abort_conn_sync is working on it.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Reported-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/0000000000005ab984060371583e@google.com/
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: drop one probably not necessary WARN_ON

    Not sure how you'd hit this condition in real controller, but syzbot
    does end up calling hci_abort_conn_sync with reason == 0 which then
    causes havoc.

    This can be verified: with a patch that changes abort_conn_sync to

        2874	conn = hci_conn_hash_lookup_handle(hdev, handle);
        2875	if (!conn || WARN_ON(!conn->abort_reason))
        2876		return 0;

    https://syzkaller.appspot.com/text?tag=Patch&x=16eff740680000

    it hits that WARN_ON:

    https://syzkaller.appspot.com/x/log.txt?x=10affb97a80000

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

 net/bluetooth/hci_conn.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e62a5f368a51..22de82071e35 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2901,12 +2901,25 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn;
 	u16 handle = PTR_UINT(data);
+	u8 reason;
+	int err;
+
+	rcu_read_lock();
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn) {
+		reason = READ_ONCE(conn->abort_reason);
+		conn = reason ? hci_conn_get(conn) : NULL;
+	}
+
+	rcu_read_unlock();
+
 	if (!conn)
 		return 0;
 
-	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
+	err = hci_abort_conn_sync(hdev, conn, reason);
+	hci_conn_put(conn);
+	return err;
 }
 
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
@@ -2918,6 +2931,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 */
 	if (conn->abort_reason)
 		return 0;
+	if (WARN_ON(!reason))
+		reason = HCI_ERROR_UNSPECIFIED;
 
 	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
 
-- 
2.41.0

