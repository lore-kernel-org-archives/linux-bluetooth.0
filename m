Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4830C71134
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Aug 2023 19:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjHYTCB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Aug 2023 15:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjHYTBs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Aug 2023 15:01:48 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CF42126
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Aug 2023 12:01:46 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RXTnz2x0Zz49Py8;
        Fri, 25 Aug 2023 22:01:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1692990103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=szivpkiy0+fqgxf9UGt6Ued2wS4ikd17ZVTkrD74h5E=;
        b=jLpy9HZbaq71dPeAGBXwFuKkoY109LIIMexRwSV34kYciEoBSWEliXay710wdA0E8Xv143
        2y/qbPQcyIQKforvzSdYPFI1E42Rey2vLX93ua++da/GX3cQWlRDtmqx2sbW/Kjnd0p8z2
        ajACMhLJjBmS9R/TYeLyhrTLvLdPN6Q7QxZw5YHrzFN8qqFCejo2PU6ambAN2+2GIB+5Ok
        dIWtKW90n/2uz+Aba2ycieSjhK0pTUWdAsNzdNFRJJADwRQAoxnfZuDawCRK47FGiufk7t
        IPETojNyhFvXZmdIjQ9r//OmKOsS1fK5zwcj30067dtaffttKogyJS59oAFUTA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1692990103; a=rsa-sha256;
        cv=none;
        b=qSySVDoOnWcX69J2TtJ2zWvMaEg963LxOXJtA+0/KvgFl7X5P2zW9aYPr8ZiUzCDa6H+Z5
        MwGm/QdA+Di2NlRdSlXM6/mk8ZPH/9qLZAe6+LSe1Vb+gI+80QvjqedyiyjicBp30ZDjIz
        H+gw++w6DL480gwwGy6FDChYOcU49FCP3o22KyNHCwExChgx3z7HzFjVU4/UeX9RwRNqJG
        YQ/h6sv89nC/9uqlkilSn7lNh8HZR259rMXDg1YroFoqCRLe329go92OyTiIoV5UzWcirj
        w50t2TedFf9tExNKorGe0CbY0h84aLLHciTKhOqWIVNYaygJ9RlnbVN5gdx5MA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1692990103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=szivpkiy0+fqgxf9UGt6Ued2wS4ikd17ZVTkrD74h5E=;
        b=hgtEPGFbEBqR0gBTSXprA88TQ8Q3HrGQCLqLEDs74nv/lAwmRsbbBxDyjfuct9jA8SikbO
        eyr8Mb4CvGyXJxZzFasw989DhOWEzcxFs+xtnJ0c0AYbL36YR3vPUKKe0ZuFUplPK9GbDM
        /32iuDKCpHPkc4nTVeV8APP2cbfZ4G357Umi53sRiM5moU5rw0ybK1rQ+H9UC9qdaGFZti
        xOelnUbc/7jmcUr97GD4/s0dZD9J2ZaY87+2/7V6bnO3msZF4l3YjnYN7Ojmby727qaHzY
        UoSt2Vl1oQo3w2GBaz7T6O7eiHqc+U0OtLKzxDRn2CDFum2AmTvjjt6Dxxfw2g==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>,
        syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: hci_conn: verify connection is to be aborted before doing it
Date:   Fri, 25 Aug 2023 22:01:40 +0300
Message-ID: <8d413750f5749773c033245a593394933b77372e.1692986355.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a race condition where a connection handle is reused, after
hci_abort_conn but before abort_conn_sync is processed in hci_sync. In
this case, hci_abort_conn_sync ends up calling hci_connect_cfm with
success status and then delete the connection, which causes
use-after-free.

Fix by checking abort_reason before calling hci_abort_conn_sync.

Also fix some theoretical UAF / races, where something frees the conn
while hci_abort_conn_sync is working on it.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Reported-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/0000000000005ab984060371583e@google.com/
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
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
 net/bluetooth/hci_sync.c |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d5057cef30a..8622eddb946a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2886,12 +2886,25 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
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
@@ -2903,6 +2916,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 */
 	if (conn->abort_reason)
 		return 0;
+	if (WARN_ON(!reason))
+		reason = HCI_ERROR_UNSPECIFIED;
 
 	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9b93653c6197..a93096c5cbfd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5375,6 +5375,8 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	u16 handle = conn->handle;
 	struct hci_conn *c;
 
+	WARN_ON(!reason);
+
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
-- 
2.41.0

