Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035D28C854
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jul 2026 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785045282; cv=none; b=Flwo3Z3OFtBUXNcNqIe9kmo11dRJzCDvmgZVJOcaneowWqtq9XmrFE47rtk1Qda/zZgE23+3JgXQSK9C7li0kGCppGb/lfoOT1XCmj1zuiYl32jk36t9DL3bvJltzkWfogW5KuqxH1wUxYTgtTKFi8bBc8uRJ453V0OA8itJk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785045282; c=relaxed/simple;
	bh=JUR61lMsOeNdf24yMOleCWIFEBHl2tuSPKCBc8SrrCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/7S9pxNkrgHaM8SVG8WxVlUndHCA13VKw3KT7/twJa2hU0T7h7y7qpQRLhBnXyv3MoEwS9eO8oxaSLqq2siAr3aaEm78TSGgnJ0YKBfUg15ZPmkA9RXHnyhSXVCVK5DtaVTe3eC4QNekjGo8lbGhG9pCOJGJ3KmR7VTPkEX1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=C6qupr1d; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="C6qupr1d"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce98cb8165so19691095ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785045278; x=1785650078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2mXcDhh8khgWaS8xBEZuV37vbK/EffZ6ZIEOU3bJCAE=;
        b=C6qupr1djxvHfxOQtL5il6LEaL84VmJ4xCK7AQaY5mI0e2Mvtw4RmW3xXNWHGQoYpc
         CFozjkkT1pAmXR3Mm5IdEEIDSivgWJ3VHfysfwfUhA68uPt03xAN6bfpk53061dWI1MM
         vG83zLmZqlPnNr/4Bj1uv/Lf8JFnPviTZIMb0magyF0FUWBxWQiS5QfDaUVaf9nvmV8r
         F9ZdTd/ktGLgagswztFnAbIyjncTVzBAXl7edakegcyJb/E/NiWYaLztAPRsC05OTd+R
         QnLdbeUEWXfloDenDeV/g1Z53c9oaqJtw6BPeFI/dsfG0CGTIYJWY7Jn5aPpadQN32Sm
         +zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785045278; x=1785650078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2mXcDhh8khgWaS8xBEZuV37vbK/EffZ6ZIEOU3bJCAE=;
        b=f+4JIfB2mjObS3KLJnc77wvzBwKsUqwieMHCOFJVTql0/FCBEW7h3S7r3mTFeb2lbR
         p++6+DFKWIL596rSo39J1ptP58+danLR1/hpKLYR1FNxsTUDeuOruhE+j20fI+UCvlyb
         bPTW/IfLp5ZJjZMkTEut8zA/sLnmSavYQxDu6pzWOJK+xIMhNdtQdES08bXBUKT/t+DG
         bbo586o2GGHfm56WSehevGaZg+6Amakip2cM3Js73xetoEtegZ24ZssuZZf2Jb+1765z
         kvAboUSrZOPV8b+xfYZ/ru3mKLmJTKf/BO1Fq+9179xVq1cdQsOgyLfA3VHsybHjTOj4
         sZQg==
X-Gm-Message-State: AOJu0YwVu9Z2L+X+Zm9yt5eXqOF/G5TSpTWTq/+MgfUcIvBV5aSH4Azp
	p4/vdq+1a6aUv1506EkNJ8mOIzEPcdTzF7kEVGh0Scw8gTY7MRTfnSuAr6v4u6rmQ+ni81LVBVq
	GA9yOKzc=
X-Gm-Gg: AR+sD12AeNaOshrsKoLsbXeHofJQScYhLjUAVWKzmHEODDfHASjvvdtR1QQPfn9UM8P
	76R5DboZcaYR4RUE6vb0vg7vc94LELWQGMehDL01S9VsUc82dGm8v7PfS9XyfQ7C0+qs4zNzS7d
	GlcR4MjBdoJ/qZnVkfSn76XzG1pv0Id/9exPyELPZZP0cQ/wxSBwehf6wxQkrghXg5qbqafCWAr
	W+UKqOJn+l7zuz2eKUjAMSX3/QTJriVnhf7n0NOy3ji/VyphkjggTlF0Y0dYPrpmuK8+hzXMngB
	Iccql5uPlCLRYxwYX2bFoHEOc5vHb6UL7I11ClqrmHjhzvedJgJM5Ydig0n3KqKJtlmw+OCmO4w
	m5vwAVNjzG5dQv8NhR7xW52cipa3SAL0GqS3Mpa5XkNKJEc3YgJFnmCOuoIwUv7nWlaDKTIZ410
	wrMLTuh7+GWPb4QG/HWsAxiYoHq4f9XtFuSY9QkgBzgSgg+INT667jmrFHed7O
X-Received: by 2002:a17:903:2f08:b0:2c9:c517:d08b with SMTP id d9443c01a7336-2cfdf45f0c5mr35503435ad.22.1785045278519;
        Sat, 25 Jul 2026 22:54:38 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c71sm12967045ad.73.2026.07.25.22.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 22:54:38 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: SCO: fix sco_conn double free on outgoing connect
Date: Sun, 26 Jul 2026 14:54:31 +0900
Message-ID: <20260726055431.42350-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn is refcounted with a kref that sco_conn_add() initialises to 1.
That single reference is the connection's association reference, owned
by the hcon and released when the link goes down.

The incoming attach path takes an extra reference for the socket before
__sco_chan_add(), but the outgoing path, sco_connect() -> sco_chan_add(),
does not.  An outgoing SCO socket is therefore attached while conn->ref
is still 1, and two unrelated teardown paths both release that one
reference: sco_chan_del(), reached from close(), and the !sk branch of
sco_conn_del(), reached from the sco_connect_cfm() / sco_disconn_cfm()
callbacks.

When an outgoing SCO setup fails while the socket is being closed, the
two race, starting from conn->ref == 1:

  1. sco_chan_del() clears conn->sk.
  2. sco_conn_del() takes a temporary reference (ref 2) and, seeing
     conn->sk already cleared, gets a NULL sk.
  3. sco_chan_del() puts the reference it believes it owns (ref 1).
  4. sco_conn_del() drops its temporary reference (ref 0) and the
     sco_conn is freed.
  5. sco_conn_del() takes the !sk branch and puts the freed object.

KASAN reports a slab-use-after-free of the kmalloc-128 sco_conn in
sco_chan_del(), followed by a refcount_t underflow.  Both operations are
reachable from an unprivileged AF_BLUETOOTH / BTPROTO_SCO socket doing
connect() and close().

Give the socket its own reference on the outgoing attach so that the two
teardown owners no longer contend for a single reference, and drop the
association reference in sco_conn_del()'s socket-kill path so that it is
released exactly once there as well, symmetrically with the existing !sk
branch.  sco_conn_ready() consequently has to take both references
itself, because sco_connect_cfm() puts the one from sco_conn_add() as
soon as sco_conn_ready() returns.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
Reported privately to the maintainers on 2026-07-10 with root-cause
analysis, a PoC, a KASAN log and this fix; posting to the list was
requested as the follow-up.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 net/bluetooth/sco.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c05f79b7aa31..3db6552de06c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -276,6 +276,9 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	sco_chan_del(sk, err);
 	release_sock(sk);
 	sock_put(sk);
+
+	/* Drop the association reference, as the !sk branch above does */
+	sco_conn_put(conn);
 }
 
 static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
@@ -296,10 +299,16 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	int err = 0;
 
 	sco_conn_lock(conn);
-	if (conn->sk || sco_pi(sk)->conn)
+	if (conn->sk || sco_pi(sk)->conn) {
 		err = -EBUSY;
-	else
+	} else {
+		/* Take the socket reference, which sco_chan_del() drops when
+		 * the socket detaches.  Without it the socket and the hcon
+		 * would share the single reference from sco_conn_add().
+		 */
+		sco_conn_hold(conn);
 		__sco_chan_add(conn, sk, parent);
+	}
 
 	sco_conn_unlock(conn);
 	return err;
@@ -1452,6 +1461,13 @@ static void sco_conn_ready(struct sco_conn *conn)
 		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
 		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
 
+		/* Two references are needed here: the socket one, dropped by
+		 * sco_chan_del(), and the association one, dropped by
+		 * sco_conn_del().  Unlike the outgoing path, the reference
+		 * from sco_conn_add() cannot serve as the latter, because
+		 * sco_connect_cfm() puts it as soon as this function returns.
+		 */
+		sco_conn_hold(conn);
 		sco_conn_hold(conn);
 		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
-- 
2.50.1 (Apple Git-155)

