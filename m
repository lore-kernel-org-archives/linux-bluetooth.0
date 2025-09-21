Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C83275861
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482101; cv=pass; b=OTLmYoHb4tnKeeDUgtvHncAes22RtMAc9mddLyZ8uA8BOApA5uy3tfAbNIp3r1KaydfXiibi7U8IKQU6HDdzuPeIqIdxKJsYj43W9HoCRpHokZais+UsZW69L2nZ3ReZun/bsGy9feimxTMCkcggGcOndrIFrJFwrecK2YiLwQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482101; c=relaxed/simple;
	bh=bcLn6uPIVCKoS+8bfu51DHd9vxd6rkNpcYOq0Z6fgjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxJQojAH/IcSHGW/Vljq1V319OYOOljFfuzI/1mLiCR45JYHl08jJWozrQ/tyQfq+8DABKMdGzHetlVOpqqzBGd+Ge25KkR6bNNBl8amj6vYpSaI/k0helktbfRbfqwjwKdT/N49/TRIs0G/7dzhDSrEDLc6+su2BVEoEuRl+Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qKgoWEW3; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qKgoWEW3"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCF69Ygz10HF;
	Sun, 21 Sep 2025 22:14:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxIO4EE5MKQr7VfAwYdgYQVc5o14h8geczIZAXSJXIc=;
	b=qKgoWEW3FqRolfrMLiUDkyZdLLbEXr3XEikBoljoa8cxGO/hBqADn1G+EuHWvoVb0cKUrg
	OCE920lYL5pVsNd8A45A6xR5XEUF0TgcFCUo2dPw4mLqzFpgV41Pvpi5pfd0zzdklYc1ur
	sq2jKzokxoiItonbRBwqi0CdfbOKKkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxIO4EE5MKQr7VfAwYdgYQVc5o14h8geczIZAXSJXIc=;
	b=D837+vcz3VorpWorBGrwk8/gdCsgAo+P0Oq0iJgx7u737lXL+qTsqORLdK14s1nCpQU7p3
	hQiwlRg/nN7h4VVmrc3A4rw447sutTjbLpkYCiyiUNC6XV5eBJtBYU4n8xj+8s62kYv2Us
	Cr4THyIi1MmV0dWzBASFoX0yCmlob4k=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482089; a=rsa-sha256; cv=none;
	b=wL5NCHaejnPvNLNEiyVl66qzYYsNum9QeQyTTlC/psGXUGMCqQ6oWZWtFLYw/wBE00bc6x
	ljCbAOvQGNwiWCv3CwBPR7M/osGnRkpeiYn/onCoMv1IXP6S1ZnSKNkubgzpyY758d1jq6
	kPov33xQjvIhOx9pMERZIabvDpHwXQA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 14/24] Bluetooth: hci_core: hold hdev lock in packet TX scheduler
Date: Sun, 21 Sep 2025 22:14:29 +0300
Message-ID: <b1e3b301a21f3b8a6690ee65013c1fd4e8688058.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn* shall be dereferenced only if holding appropriate lock.

Have packet schedulers hold hdev lock while sending packets for conns.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_core.c | 50 ++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3418d7b964a1..f106586cc5a3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3428,9 +3428,8 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 	/* We don't have to lock device here. Connections are always
 	 * added and removed with TX task disabled. */
 
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
+	list_for_each_entry_rcu(c, &h->list, list,
+				lockdep_is_held(&hdev->lock)) {
 		if (c->type != type ||
 		    skb_queue_empty(&c->data_q))
 			continue;
@@ -3453,8 +3452,6 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 			break;
 	}
 
-	rcu_read_unlock();
-
 	hci_quote_sent(conn, num, quote);
 
 	BT_DBG("conn %p quote %d", conn, *quote);
@@ -3468,18 +3465,15 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 
 	bt_dev_err(hdev, "link tx timeout");
 
-	hci_dev_lock(hdev);
-
 	/* Kill stalled connections */
-	list_for_each_entry(c, &h->list, list) {
+	list_for_each_entry_rcu(c, &h->list, list,
+				lockdep_is_held(&hdev->lock)) {
 		if (c->type == type && c->sent) {
 			bt_dev_err(hdev, "killing stalled connection %pMR",
 				   &c->dst);
 			hci_disconnect(c, HCI_ERROR_REMOTE_USER_TERM);
 		}
 	}
-
-	hci_dev_unlock(hdev);
 }
 
 static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
@@ -3493,9 +3487,8 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 
 	BT_DBG("%s", hdev->name);
 
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(conn, &h->list, list) {
+	list_for_each_entry_rcu(conn, &h->list, list,
+				lockdep_is_held(&hdev->lock)) {
 		struct hci_chan *tmp;
 
 		if (conn->type != type)
@@ -3534,8 +3527,6 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 			break;
 	}
 
-	rcu_read_unlock();
-
 	if (!chan)
 		return NULL;
 
@@ -3632,7 +3623,7 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt, u8 type)
 }
 
 /* Schedule SCO */
-static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
+static void __hci_sched_sco(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
@@ -3673,6 +3664,13 @@ static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
 		queue_work(hdev->workqueue, &hdev->tx_work);
 }
 
+static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
+{
+	hci_dev_lock(hdev);
+	__hci_sched_sco(hdev, type);
+	hci_dev_unlock(hdev);
+}
+
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
 {
 	unsigned int cnt = hdev->acl_cnt;
@@ -3680,6 +3678,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int quote;
 
+	hci_dev_lock(hdev);
+
 	__check_timeout(hdev, cnt, ACL_LINK);
 
 	while (hdev->acl_cnt &&
@@ -3706,11 +3706,13 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev, SCO_LINK);
-			hci_sched_sco(hdev, ESCO_LINK);
+			__hci_sched_sco(hdev, SCO_LINK);
+			__hci_sched_sco(hdev, ESCO_LINK);
 		}
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (cnt != hdev->acl_cnt)
 		hci_prio_recalculate(hdev, ACL_LINK);
 }
@@ -3739,6 +3741,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 
 	cnt = hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
 
+	hci_dev_lock(hdev);
+
 	__check_timeout(hdev, *cnt, LE_LINK);
 
 	tmp = *cnt;
@@ -3762,11 +3766,13 @@ static void hci_sched_le(struct hci_dev *hdev)
 			chan->conn->sent++;
 
 			/* Send pending SCO packets right away */
-			hci_sched_sco(hdev, SCO_LINK);
-			hci_sched_sco(hdev, ESCO_LINK);
+			__hci_sched_sco(hdev, SCO_LINK);
+			__hci_sched_sco(hdev, ESCO_LINK);
 		}
 	}
 
+	hci_dev_unlock(hdev);
+
 	if (*cnt != tmp)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
@@ -3785,6 +3791,8 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 
 	cnt = &hdev->iso_cnt;
 
+	hci_dev_lock(hdev);
+
 	__check_timeout(hdev, *cnt, type);
 
 	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
@@ -3800,6 +3808,8 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 			(*cnt)--;
 		}
 	}
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_tx_work(struct work_struct *work)
-- 
2.51.0

