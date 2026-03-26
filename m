Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BDE402447
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539317; cv=none; b=InifJxVYvXRNokUsZnBws+s/EnmvI7LeK3H3z/+SzVN5pNwXFHtif4/Y4V4t0xIGqlnwesr+w3/Km9cf4Od969nw1531uZgtemZEQMnbOBtPvV27WaIhCYCrUnOY0a/AanZMpziBkBLX9MI3y2an7RtXZLuBgQXexYDtRgt01TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539317; c=relaxed/simple;
	bh=BU3/bi8XXGEJ6aWfklsHKijjuQtx8U5F3JpSHaTAAFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9Pr+zB9LmxxpEBpQeiY2CNic5AnBlrCxkaMiJ+RU6mY0ffNAFTUtbtw6gWqdh5FYKv1QMP4pjYv5iUtHOqHJj6jGXxQio9WXWEmbDARteUYl5XODkeE2BbKyMGKzZFFRU5tMRazzAkes+Df2iJoxbDz879mSDIojPIFhL+rr3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFWT3iEK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFWT3iEK"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso547194a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774539313; x=1775144113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qO8m2hCpAjgFFeaqcLdz5CV6U4Vjw8+U1Z3T8Ed/CyQ=;
        b=hFWT3iEKBjrVwtCURuEEUsb91c0XlicaScn4kqkzVUhgWr8WdFpwOrThPu8a0DDB7V
         KS1pyxEn7yDUQqENvcmRR0rIU1ZUdlnMddTpGW9Gp6AovbK5f+AZhchSL2LyUpO+fbi6
         NNvhYoB5x+/iU8hdLHMWV2QIedhEFkWGr7vq+z1nHNf8FlntlU6hhUmuo5msLoDbWSzT
         viyFBOkJ9rDrpDn733618dkQN2yJFz1phKG385+k3tq6cqRICI1bniLZLvbKPJHgqoqV
         SYCAtKa5t+guDpXmk1ZjC3abOb7pGM9MSHZsTHPsUATBWR9PW/YTAXb6DLpGBd++eyeb
         QsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774539313; x=1775144113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO8m2hCpAjgFFeaqcLdz5CV6U4Vjw8+U1Z3T8Ed/CyQ=;
        b=ZVMgYryvZRTZ3BhMvHlIv3mOgFhl8p7CnJEO3VPrpuLdhgnJ3cJRauHWTx1BI8xV9K
         U0FxpPbt6QIgiORfIwg5/iyPKeFVAwm5dTiXEb7xzpPzpNRR3EdwZtc9xgFP03RXlU3q
         xnBcjRW4zVneZ3vofuCnkzK5k+yF6bXC3D5BxxTuc0DLiR/O/dOwmYPgA3hlL9OwwMUv
         8uxUYmtLUemMkapBXtZJ8+rt2C48oaheaBFgGORQze8wLlIc/bFEpJCxJPHMlc5ouBfN
         fbVUnatbj/fdb+8mentN+4G0ooRAQnksuI58DkLxSzpTToT138LL2QwFHJ0Qxuh1gAcb
         hK5w==
X-Gm-Message-State: AOJu0Yy12mkAeQvfmG03kjd11cdYfJN3MRMiHMGdL9BZ5ZYYdMePnDoF
	5VaPq1Yna1MAS6h5b55YDl9yTkjIB9klfdO+kJLMDrGSD1tXWGdBpCq9
X-Gm-Gg: ATEYQzwYgKvXPeXtr3460Kppi5rga2ADSwNVvAbvIT9qjD0Vsj63/X1XxTqZgKOLVxS
	vr0nqnitN3R03Tbi/2cR7FDK5T/qZd5qbEnLZCAd0h+wBb2aXJ95gKN3EuViapH9FHxFp/eE9rg
	bX08eB7EDdiVC2oG2atezYcVlrDGwLZEDR2+CgPAPKJRkbGXAKrgGGDq5oiEsxGFSzJ73Vd49Iz
	sdX3vBNG3iv4Itf4UNV4NOHh9+6oIpTHz1cSiYhYNthFN/ZEqgwvFFtg0eGGvAqVBnOmE/2rwLt
	FKh1QyY0+Du/BdTpasv2wG/nlYmhCXz6uGY3Nr43+MU6LdvEiQSybeWLKbZsA8K1Sf3imeulIAn
	z/nA2vmUH6e5UkkPHcLVIfLwgn8ibL/jZRCrDbgg/JaDtGhnW0HXTZmy1I174aGzmZXSjXlFt8t
	jgdD7bjr4xgq8fp7yvQw==
X-Received: by 2002:a17:903:41c2:b0:2b0:6d33:e7c0 with SMTP id d9443c01a7336-2b0b099c8f1mr88181905ad.1.1774539312646;
        Thu, 26 Mar 2026 08:35:12 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87ebf1sm33713045ad.44.2026.03.26.08.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:35:12 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH v2] Bluetooth: SCO: fix race conditions in sco_sock_connect()
Date: Thu, 26 Mar 2026 23:16:45 +0800
Message-Id: <20260326151645.27909-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_sock_connect() checks sk_state and sk_type without holding
the socket lock. Two concurrent connect() syscalls on the same
socket can both pass the check and enter sco_connect(), leading
to use-after-free.

The buggy scenario involves three participants and was confirmed
with additional logging instrumentation:

  Thread A (connect):    HCI disconnect:      Thread B (connect):

  sco_sock_connect(sk)                        sco_sock_connect(sk)
  sk_state==BT_OPEN                           sk_state==BT_OPEN
  (pass, no lock)                             (pass, no lock)
  sco_connect(sk):                            sco_connect(sk):
    hci_dev_lock                                hci_dev_lock
    hci_connect_sco                               <- blocked
      -> hcon1
    sco_conn_add->conn1
    lock_sock(sk)
    sco_chan_add:
      conn1->sk = sk
      sk->conn = conn1
    sk_state=BT_CONNECT
    release_sock
    hci_dev_unlock
                           hci_dev_lock
                           sco_conn_del:
                             lock_sock(sk)
                             sco_chan_del:
                               sk->conn=NULL
                               conn1->sk=NULL
                               sk_state=
                                 BT_CLOSED
                               SOCK_ZAPPED
                             release_sock
                           hci_dev_unlock
                                                  (unblocked)
                                                  hci_connect_sco
                                                    -> hcon2
                                                  sco_conn_add
                                                    -> conn2
                                                  lock_sock(sk)
                                                  sco_chan_add:
                                                    sk->conn=conn2
                                                  sk_state=
                                                    BT_CONNECT
                                                  // zombie sk!
                                                  release_sock
                                                  hci_dev_unlock

Thread B revives a BT_CLOSED + SOCK_ZAPPED socket back to
BT_CONNECT. Subsequent cleanup triggers double sock_put() and
use-after-free. Meanwhile conn1 is leaked as it was orphaned
when sco_conn_del() cleared the association.

Fix this by:
- Moving lock_sock() before the sk_state/sk_type checks in
  sco_sock_connect() to serialize concurrent connect attempts
- Fixing the sk_type != SOCK_SEQPACKET check to actually
  return the error instead of just assigning it
- Adding a state re-check in sco_connect() after lock_sock()
  to catch state changes during the window between the locks
- Adding sco_pi(sk)->conn check in sco_chan_add() to prevent
  double-attach of a socket to multiple connections
- Adding hci_conn_drop() on sco_chan_add failure to prevent
  HCI connection leaks

Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/sco.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e7db50165879..689788ad26a4 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -298,7 +298,7 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	int err = 0;
 
 	sco_conn_lock(conn);
-	if (conn->sk)
+	if (conn->sk || sco_pi(sk)->conn)
 		err = -EBUSY;
 	else
 		__sco_chan_add(conn, sk, parent);
@@ -353,9 +353,20 @@ static int sco_connect(struct sock *sk)
 
 	lock_sock(sk);
 
+	/* Recheck state after reacquiring the socket lock, as another
+	 * thread may have changed it (e.g., closed the socket).
+	 */
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		release_sock(sk);
+		hci_conn_drop(hcon);
+		err = -EBADFD;
+		goto unlock;
+	}
+
 	err = sco_chan_add(conn, sk, NULL);
 	if (err) {
 		release_sock(sk);
+		hci_conn_drop(hcon);
 		goto unlock;
 	}
 
@@ -652,13 +663,18 @@ static int sco_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
-	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND)
+	lock_sock(sk);
+
+	if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+		release_sock(sk);
 		return -EBADFD;
+	}
 
-	if (sk->sk_type != SOCK_SEQPACKET)
-		err = -EINVAL;
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		release_sock(sk);
+		return -EINVAL;
+	}
 
-	lock_sock(sk);
 	/* Set destination address and psm */
 	bacpy(&sco_pi(sk)->dst, &sa->sco_bdaddr);
 	release_sock(sk);
-- 
2.34.1

