Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679769;
	b=z682bxsye327X4x8sJ4myq2SU/fk5i2OebJZ4SQzxeFcOqAYFo3a3kvqDUObDA/S2VN8
	 hh2lIjJr4gVU3hKoQ/UMDZf3k4sPDNOaDbwcnCC3n8tU7wjPFT9qdFGnwMu1QE3OL97hj
	 u8xVSB6K784BBToTJT9yeKpe4Fa5mKPY+Mlvb6xQLr5HDBLFO1xeo+3y7YXKVT5NPt16W
	 oreuexozdUiwjSa1gCvX1IJJDj++qNHzUUaqmKXH7xAJ3ETF1Hf+Oio+edoPs1kfbuisb
	 4VhAeqyqv0FPwTJTGywSsyLpXERtppLssKi0YVhAofWe6dp49bpwbA0UcbV3FYWKeZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=N3Tx02Jp98cRkBGwMPHz68HqVRd2amYTzVID8QsJKng=;
	b=dR9FX+G846jMB201U3wvYzyaC2KMPfExtLF3puIQJFo3o333AyG+DcZAdlHEuXIlyUyx
	 8gcgHoVDuBYeStn0Oe1gcu+WRRkRqCLtSl/WFivhDw7LoHk851hvYMP2tiuqlSXuO8iTW
	 50D75q5VpnJw/bbagcShKUtzC6TVwlieU1bK31qGRZwXBhieql7IvSU2LL3enXQPlnNKV
	 FiWqiel0WCduU5asVpRUGhmWj5VFem8wdDV8gb9CB8aj+MRarEWwiEIQqtM+x9Vlh97jQ
	 VhY9EoJC50U3GcGI1Bq4gqXDSoJCuATpVWgO3zFh12sE16z9Ya/R6j3wj2fIqW5rFLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSWCa4xb;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC79606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 07:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BC79606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSWCa4xb
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b403511a3eso985259a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795679767; x=1796284567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3Tx02Jp98cRkBGwMPHz68HqVRd2amYTzVID8QsJKng=;
        b=LSWCa4xbEMFn/1XVUrL8aEGm6aPJ629ADCtFC6HBcfD9UboeWGV/xxFuW8i7ocUMSZ
         3vPMOOgdgZOARtD1Ouo+4ey4ylnH/TONCTG6ZZdJE3AIeGgQxvfabedsxonFpExlAx4n
         7NXfkRA86CXlMcEh2uUvmeJUfTrrNZ11oCiUhhCZpAsjnLsPMMrvdIk0R8aeBCTHCF/y
         1epXY2cb4J9/W3vX+BgopX6Z7BcIM5gkztXdkosHlyJhMKtb78T21Jb9B1HUH8eipG5d
         aqApnn6R8rvCYWj17lK8/RPTlwElruXknIjnqmuaSvOsmx+MNdMhv3L8bgZ2qMpyrktX
         witQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795679767; x=1796284567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N3Tx02Jp98cRkBGwMPHz68HqVRd2amYTzVID8QsJKng=;
        b=0Jzd/ZTyouiQCxTovpN7dPvfhxYHu723ThCYQeYIU49Az+1wvC4ucybwl+LGdLDwRw
         4TsiysSTPbtgnA0La6JVayy8PiUiN1jv8vzHT7nftloBc9Mfdtmli4cQNTTADaRKKPHA
         02J1gZSTNEufSGNmk1rNWxtDKNjyElCPe7iZ6AJAeKI8CVlWZfBwqB5MfMWdybSytPYS
         73ZfxX/KpQ4wXKVxWB6lcwn5DFDCNOMhLIfJCczTS4ChTSKrSGFEy7iTYCkHrmHXZcDC
         KJGsoEMfJznWzbN2jin2FE2vn15W3LbBZX241Z/mPnt0+vyt0+z4V8nS2xqMLFlGBPo6
         Ggyw==
X-Forwarded-Encrypted: i=1; AL+hErGRRtPRBlZt2dfXLsR3OGWbQ7o0BHXCzAdvjfeq1OcVgPPaepsssqSve/qwUs/AgMv2LpLQIVK0mla9yFTMdls=@vger.kernel.org
X-Gm-Message-State: APuU4Z/57gH82Cx4jB8sMx7YMt1WRjalshDY77eYM+tjuN5GCfnI6Xiw
	CWRMz/FuGOUKMxqykJ4FKVvMjfsmdZgEz7NsNbFPyFXmkcWfMcY8zfVG
X-Gm-Gg: AZFdTZdRRIjwz2fERLckwArgPIlnCjSlflpE68Q4IPuGuGQVVpwU99TkJxPXwjBNO7U
	1vTGNYJVPAVsKrr4bR0+vITqBjM6fhFVN/GgbH03jAYcHYqEKzSoHgFyigaxmj9Ltmmr77GvaeQ
	uLEZ1wopRqILajk8QYjYH9sItF8pGUgfyYpXRhjBUPEDIW4jHQcNknb4sY+cv3Xi6LKYwdupN0B
	Y+5ClOlkcHv1aWH/ESE4csWchNOFXUtte2VHTsCPuoacBFQHTg/6zQqefA7r55nDTwfc5m83Bx/
	whmmaYzpoD96LQq7lIQbUMA3SccUlDEPTFV+fa7IrOMM3BuUyU4G6iL8EdvrLHws0ZrnT7aKB72
	c3h/SsnqEhvd2+kc4d3CDlhMcw2Aeh0SDFp41B5KHsnpkliF+36GAWdAhPjqPCkxf8khvPe/V7X
	iWBS/WDXaExZST8NViVC5sYNRey/mFc3Pb0yCy2zCoGHWOrgWOztjOqskCo/aiRqPFcF0ca9WI+
	+BPzdmQuS5a0IBfXEreAU/sujbAdQ+9Cbf2n8rFTNUAcwVaUhFfz10T28INexauVgMsWVNhR2Cn
	0pLqwwkE6J/ULYu4HhRFhapJR5cC0yQ8a9pqc0959gCsFPtRiQ==
X-Received: by 2002:a05:6a20:9f08:b0:3ef:2f72:c7e5 with SMTP id adf61e73a8af0-4014ae6fe31mr34992104637.2.1795679767425;
        Wed, 25 Nov 2026 23:56:07 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm10690855a12.23.2026.11.25.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:56:07 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] Bluetooth: hci_core: lookup hci_conn on the ACL RX path
Date: Thu, 26 Nov 2026 07:55:54 +0000
Message-ID: <20261126075554.106-4-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126075554.106-1-junzheyu1@gmail.com>
References: <20261118123533.25-1-junzheyu1@gmail.com> <20261119035758.45-1-junzheyu1@gmail.com> <2026-11-19-1-daily-reply-0012@kernel.org>
 <20261126075554.106-1-junzheyu1@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 79a2d4678ba90bdba577dc3af88cc900d6dcd5ee upstream.

Move the hci_conn lookup into l2cap_recv_acldata() and hold the
l2cap_conn before dropping hci_dev_lock. 6.1.y has
l2cap_conn_hold_unless_zero(). sco_conn and iso_conn have no kref, so
those paths are unchanged.

Cc: stable@vger.kernel.org # 6.1
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
Signed-off-by: Yu Junzhe <junzheyu1@gmail.com>

---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_core.c         | 25 ++++++++-----------------
 net/bluetooth/l2cap_core.c       | 29 ++++++++++++++++++++++-------
 3 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f47a88d39..1a483be00 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -824,7 +824,8 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7ec3af3a4..580921ff4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3802,13 +3802,14 @@ static void hci_tx_work(struct work_struct *work)
 static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_acl_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ACL packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3820,23 +3821,13 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hdev->stat.acl_rx++;
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
-
-	if (conn) {
-		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
-
-		/* Send to upper protocol */
-		l2cap_recv_acldata(conn, skb, flags);
-		return;
-	} else {
+	err = l2cap_recv_acldata(hdev, handle, skb, flags);
+	if (err == -ENOENT)
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
 			   handle);
-	}
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "ACL packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 /* SCO data packet */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d7bb11931..a8a3afabe 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7908,13 +7908,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
 }
 EXPORT_SYMBOL(l2cap_conn_hold_unless_zero);
 
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
+		       struct sk_buff *skb, u16 flags)
 {
+	struct hci_conn *hcon;
 	struct l2cap_conn *conn;
 	int len;
 
-	/* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
-	hci_dev_lock(hcon->hdev);
+	/* Lock hdev for hci_conn, and race on l2cap_data vs. l2cap_conn_del */
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	hci_conn_enter_active_mode(hcon, BT_POWER_FORCE_ACTIVE_OFF);
 
 	conn = hcon->l2cap_data;
 
@@ -7922,11 +7933,14 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		conn = l2cap_conn_add(hcon);
 
 	conn = l2cap_conn_hold_unless_zero(conn);
+	hcon = NULL;
 
-	hci_dev_unlock(hcon->hdev);
+	hci_dev_unlock(hdev);
 
-	if (!conn)
-		goto drop;
+	if (!conn) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
 
@@ -7954,7 +7968,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (len == skb->len) {
 			/* Complete frame received */
 			l2cap_recv_frame(conn, skb);
-			return;
+			return 0;
 		}
 
 		BT_DBG("Start: total len %d, frag len %u", len, skb->len);
@@ -8020,6 +8034,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {

-- 
2.53.0
