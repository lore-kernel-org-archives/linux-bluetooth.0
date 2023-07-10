Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33531EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 16:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGJQsp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGJQso (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 12:48:44 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1B1F2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 09:48:31 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4R091L0GVhz49Q0S;
        Mon, 10 Jul 2023 19:48:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1689007702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0drjbMnIOweBAIQt+MBPd7WklNyY2x1W1lj5DIqv/i0=;
        b=byvHedoi0AlLwKY5fJEkiId4DdyLKuijD2DyzgdxRacJ0rbtNLcAmp2/noSfbE6oy6VBUU
        Pzy2mYrmGYMdJvn2L1CrIyp4j7UwoLP+XjSWZYVNV/opjmWEyWynRJe2sFeb5i2pyPs5Q0
        v8H/9xIpHVUlGVpJL0EgTvjwoctdgZBrCfINdaizSFC68wZLBSZLKe78Q/W/MGHRRFY1Fx
        vGjvcZh9xGDOwzgy4zVaGpgHFa3ijYo+t4soYdpEVh/mMYv4k0qjhYNgytBTMbi0EpY3DL
        0okLWaiT/2+jlFU4c1uzDR0sT1q8WtSDR/W3b7HVszMqbD5qASSfDRmcj7HCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1689007702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0drjbMnIOweBAIQt+MBPd7WklNyY2x1W1lj5DIqv/i0=;
        b=igD4GjywT+3pKJOXfuO+40LwG9QVPcwp4wZn7eQk3jr9mSHcEwmXJFyb1Vzfzk8u8r8FY7
        Bm8b+ig6CQ1FF/AbboZlLDyfGNyi+02/rzHF1VbuyJdKKJuYLb8cMYfGTuhlyDFeg6tOoA
        o5SyssRzPo5BjzeeYwAcJD6CPFZTPH4sMxXY2yVH9GW8/tRSvemWCtZ/37wCjkWpcGmDkD
        01WtpxvPtbqwXKwIBbKB1A5JiN/I0/F2XnDKVNvSy6PsUdqm3fNVOF9fA8jDm/iN4dyNUt
        06IP8fHNl4AyZ3WdR4aJBMCGSddgUwX6J0pxesHIXZzkkj9z1OFkmgKnB0CCXg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1689007702; a=rsa-sha256;
        cv=none;
        b=bRPz8+nSxlfJ7T4I6u2Yttn0JIGtY+6sEFGMnRs5hrZmeiO3dWqzVo1fL1ImClNOXFULvT
        3ZDhLQt7B9qqajerIalcoNByDUpSk27qGAbxIZZ+fGXN8nZ9KHtfHjr+3OWqmzxbSSLu8f
        JuPMfmnVAAnKlGn5xmYBUb289RKiM5Jw9MhN8RBfDNnAs4pQG/HkU+9NsQ5UGrWNU5W5y5
        A4LysGYTAVseqPJ0kUwd1kc69WBCzqr9gPp6kH0lOovoNJF+srpAdgc4EqATDB549+uS8m
        +WkAi7yRxGYh53LibvfyGQAjiLYag6ehCuMTyyuSst4mak+H0N0RJir7Vch46w==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>, pobrn@protonmail.com
Subject: [PATCH] Bluetooth: SCO: fix sco_conn related locking and validity issues
Date:   Mon, 10 Jul 2023 19:48:19 +0300
Message-ID: <490b5c6a0e13047fd1bea42d3184b46623adc359.1689003801.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Operations that check/update sk_state and access conn should hold
lock_sock, otherwise they can race.

The order of taking locks is hci_dev_lock > lock_sock > sco_conn_lock,
which is how it is in connect/disconnect_cfm -> sco_conn_del ->
sco_chan_del.

Fix locking in sco_connect to take lock_sock around updating sk_state
and conn.

sco_conn_del must not occur during sco_connect, as it frees the
sco_conn. Hold hdev->lock longer to prevent that.

sco_conn_add shall return sco_conn with valid hcon. Make it so also when
reusing an old SCO connection waiting for disconnect timeout (see
__sco_sock_close where conn->hcon is set to NULL).

This should not reintroduce the issue fixed in the earlier
commit 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking
dependency on sco_connect_cfm"), the relevant fix of releasing lock_sock
in sco_sock_connect before acquiring hdev->lock is retained.

These changes mirror similar fixes earlier in ISO sockets.

Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Possibly related:
    
    https://lore.kernel.org/linux-bluetooth/00000000000036b9590600095d33@google.com/
    https://lore.kernel.org/linux-bluetooth/HwByr9Ffw_HVVE5pnMu6CTIrQjKwBJpJcSskM0xOP0S-4XiIdmGFTLYAcgKJsOkrxt62je88hFJ1vkHzYtCgwsEATe0KFq3E4YX8LeN5Fdo=@protonmail.com/

 net/bluetooth/sco.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index bbf7072f5e80..ec6dce488a40 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -126,8 +126,11 @@ static struct sco_conn *sco_conn_add(struct hci_conn *hcon)
 	struct hci_dev *hdev = hcon->hdev;
 	struct sco_conn *conn = hcon->sco_data;
 
-	if (conn)
+	if (conn) {
+		if (!conn->hcon)
+			conn->hcon = hcon;
 		return conn;
+	}
 
 	conn = kzalloc(sizeof(struct sco_conn), GFP_KERNEL);
 	if (!conn)
@@ -268,21 +271,21 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	conn = sco_conn_add(hcon);
 	if (!conn) {
 		hci_conn_drop(hcon);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto unlock;
 	}
 
-	err = sco_chan_add(conn, sk, NULL);
-	if (err)
-		return err;
-
 	lock_sock(sk);
 
+	err = sco_chan_add(conn, sk, NULL);
+	if (err) {
+		release_sock(sk);
+		goto unlock;
+	}
+
 	/* Update source addr of the socket */
 	bacpy(&sco_pi(sk)->src, &hcon->src);
 
@@ -296,8 +299,6 @@ static int sco_connect(struct sock *sk)
 
 	release_sock(sk);
 
-	return err;
-
 unlock:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
-- 
2.41.0

