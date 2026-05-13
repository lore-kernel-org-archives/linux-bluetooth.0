Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61984A13A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693560; cv=none; b=baWPcXW/Ti1eK1pMdjvsipGt9WbLULCMhkNrxkgWHJ8Srvytb87HC1EsRUwn43WIs3aBUXTRzbykrpJMEXwwzt/OwIl5MfOsj5Qm+O7P1ZVX38cJdwLVM6OIDEd/c0WTj9SM18h/nPqKkqv/m5W2h3aqDOLQ0xBgS37RvH5oaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693560; c=relaxed/simple;
	bh=hxBruqmX/PFZwUQSLsTiWPbK8dPDpVeanCvgZ7F/3XM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I7Qjd80ecVoogItVRVroAB1ZoDb5A5V8NtfBr5pfQB0We4ZhOT5eW5AUbibqgZwM3HJNJbRehWNd20k5761hnEYI3HZSTDJF6/FYRtDMA0yCCKFQn2Iav7EzEusCcdfJoM5i3TEwMCr4pWae818ZqU55oZ+ckt1E00LMOMfBvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNceT3vu; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNceT3vu"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6312bdd281eso5195500137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778693557; x=1779298357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ7laawPb8qExNu/Eu1uYo2I2wgRofP6w+WsymHre2M=;
        b=RNceT3vupiXxbFfGsJV4gWjJL4u7T24ksKMV31ldEPTIrD1kXKe/eXFDpzOY2yINYw
         zGhymWp6rf/IU3Tqugl1nFXX62wH6kjdFGQPoSTECwqwko1EjL4ouQgiCqKaAJOONnj+
         eNWtm65w0GUrhwkNjPSjnyke5Abn/g06HnDsgxahakT55taI8OA8I9QpgmAnsKiYZv2U
         +tVr7+qlJsYFplLaUwAedqXMqMlxrPRsmue03VM7U3qcnDo4mQZz6cNvDsEPcX/LKwsM
         mnBc+zuCH6tue8XiZyW/nMiTUpWDa41mKbFfcN7eGeV8Ip9km54hW51s6Nkvm23su+Y9
         qu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693557; x=1779298357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJ7laawPb8qExNu/Eu1uYo2I2wgRofP6w+WsymHre2M=;
        b=i3R0Hb2t8Ipb2BYYTM2SgBNgW0E0t+7Lf7LIZwKLJR/Ug1W43hl7oSdyAocyf4z5sM
         MnwTgrXuKhql78BiJtO1W3Gc6YAJBzZSqlrRDDZrK2BGaf0pOOAVM4eKrmIiJ8k2nxuy
         m6bA/iYM0DkDC0G13B+qf1s0vmuHI40fFMzXK3JgmoNVea+CcRsMiJwLjqfqN0tGgAyQ
         urPxsmvMz+IeHBffhjVLV5joiggeIe5LniHnYhypwi2YnITXDbMImDUk6zbgyuWLgcud
         Ml8IBgYLPxJ5e4hun+1v2EqqZGhWge2VNYXo4WZmN0qDqjNIwK4jw7KYYq/pEDwHO/eM
         4rFg==
X-Gm-Message-State: AOJu0YxFtFLvxn5pLyodgVtitaM9v3ZRvXbaZtpYb24IHiLzTm7pqMbq
	qult2Ttqi8JYlaQbgYuIBKvJ6CAV7lFhPj+tg998CFVKooU67+nEqauCGJSirAFj
X-Gm-Gg: Acq92OHljQYfIch52gZ08NBa8z4s10i49XwdhxXUVqJ26leR7l5waxGveHlmfLpCWQY
	nUrzi/Pygq7y7emUu1p/yqR31aUrzXWdEaCz65NCMRalurhaHPuaz/Zq+VRB1I6GT77HJfD32ip
	ZkC9r+pEt/Rhv43dGtSEa0Kvrf8mD5y1wWP9fkVekdk/qc1SyDjPDWJ/u8312+7pRUssjN+ie1y
	LRFYJFhhStcYcAmUpez1WCMDjGEpI5tOkNoxfmMZw98rb8z9BWLguO5FdrYpXLggpycimMBu7cq
	0mT9vRNMGbxe5Fk7eyJqDWqvNzQFUOfICKFGwyItzFpxWwtnP4K6xGMJYMxoBhPqB8ohXfOCUGg
	9pHPBZ+tPMBsj/oYZvRNboFYnhkX+BpYR//cTT9YaXjQxPw4BfSkpmW85zHLVjA2ROiMScyRumW
	HtHqHU5/g+Nn1W70SYlLVQij34WkWPFTkvgBP1WTKyCLW7ZjdwJWHotoXgV9wmcw+cKlVRUKsok
	W6Mon1eTzaqK6beBA==
X-Received: by 2002:a67:e7c9:0:b0:631:9366:da89 with SMTP id ada2fe7eead31-638b566e4e7mr280314137.8.1778693557352;
        Wed, 13 May 2026 10:32:37 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fa89e10dfsm111269241.4.2026.05.13.10.32.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:32:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
Date: Wed, 13 May 2026 13:32:27 -0400
Message-ID: <20260513173228.1220717-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If dcid is received for an already-assigned destination CID the spec
requires that both channels to be discarded, but calling l2cap_chan_del
may invalidate the tmp cursor created by list_for_each_entry_safe and in
fact it is the wrong procedure as the chan->dcid may be assigned
previously it really needs to be disconnected using
l2cap_send_disconn_req otherwise the remote peer would have no idea that
it shall consider to be disconnected.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fdccd62ccca8..4c68ee5cec7e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5242,7 +5242,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
 	struct hci_conn *hcon = conn->hcon;
 	u16 mtu, mps, credits, result;
-	struct l2cap_chan *chan, *tmp;
+	struct l2cap_chan *chan, *tmp, *orig = NULL;
 	int err = 0, sec_level;
 	int i = 0;
 
@@ -5262,7 +5262,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		u16 dcid;
 
-		if (chan->ident != cmd->ident ||
+		if (orig == chan || chan->ident != cmd->ident ||
 		    chan->mode != L2CAP_MODE_EXT_FLOWCTL ||
 		    chan->state == BT_CONNECTED)
 			continue;
@@ -5281,8 +5281,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 
 		BT_DBG("dcid[%d] 0x%4.4x", i, dcid);
 
+		orig = __l2cap_get_chan_by_dcid(conn, dcid);
+
 		/* Check if dcid is already in use */
-		if (dcid && __l2cap_get_chan_by_dcid(conn, dcid)) {
+		if (dcid && orig) {
 			/* If a device receives a
 			 * L2CAP_CREDIT_BASED_CONNECTION_RSP packet with an
 			 * already-assigned Destination CID, then both the
@@ -5291,10 +5293,13 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			 */
 			l2cap_chan_del(chan, ECONNREFUSED);
 			l2cap_chan_unlock(chan);
-			chan = __l2cap_get_chan_by_dcid(conn, dcid);
-			l2cap_chan_lock(chan);
-			l2cap_chan_del(chan, ECONNRESET);
-			l2cap_chan_unlock(chan);
+			l2cap_chan_lock(orig);
+			/* Disconnect the original channel as it may be
+			 * considered connected since dcid has already been
+			 * assigned.
+			 */
+			l2cap_chan_close(orig, ECONNRESET);
+			l2cap_chan_unlock(orig);
 			continue;
 		}
 
-- 
2.53.0

