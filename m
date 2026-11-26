Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679765;
	b=cbjFPgVgg9gvJNGwdehcAufbwjASWpncE4JAnMBS5Ug9L18TyaS/AK7U3/FLdiW2X4sF
	 ZXJN7lYP4W0OYrN27n0Q3nXHRz5ZZBIPxP9zeMW8FmYFJb6OOAwL6biNNY8pZPrrD60V+
	 YkTYBWJYA7HDkmQ1GktsmcPctysT7o9Z49sMak0CW3QTAxl5oUz58pqmTVqDnABg7FQQk
	 iGv90LHmN+LN22aAAdKKTrjs4wJsFnhWlE17XfZdRqZzrYWygA0E0SSOu18Tm6z0udshX
	 EeHZRNkIN+RWPeMfJwAZ0GdSCx19xkSmZ0GLS/VpC/wObWN3E4vESeZU4OpcEc0te/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0MJDhqAb9koNt1RgW5GuhBq8i/bxOmY78SeKm0Wu/0k=;
	b=is+6yeaL18fHKq/sNiThFysvhQEff5XuuydlrpqfZHcZxuQ5+ZEl1wyszQLvrdYH5rH7
	 ZqHIIeOamD6mXXANh95rLtW4rthk8o6U+P5/10dlZcELDHAGnJIe2nVRHtrjj6KHnnwi2
	 HhE87sNEskiSD2vUxOtGgcHOQ5pVaZVuVmFBBnmNqZVSsQeCzOdeFfs1IE/aVk02gaA5d
	 hi03WE/HtgByvOjfVcHNUQWT9tHOQOt8JkMbGz0GrpAPFbX/EHH0FQP9hQSj2L0arnkmn
	 m1PbDx0+Ar5bgjf1mLSATptD4w6glLewHGmD5bLgZQ/nSEzc5KMb2q2i+gXUmdaVdYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcdHZ6Q0;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD3606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 07:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73DD3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xcdHZ6Q0
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b413f6dda6so843626a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795679765; x=1796284565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MJDhqAb9koNt1RgW5GuhBq8i/bxOmY78SeKm0Wu/0k=;
        b=xcdHZ6Q0+9g45rmJitQGxeDxL0Quibj7eKZt5HuxDddOkMjN3/evd3mWznIbi/qwUW
         P/edBPSqSsyERsAjDvk6V7hqxZP8w4GH2Yr9qmJm+058OjG9Z02yGlgMzRHOgL8j+UUT
         uvXNFx/UGaH6y74nLeaPLCIYlo+SWElUk1HDrNb6ZKdE/sNNnSEd5/Lz+Wdu+PggjfFs
         3MR1ZvRIQKgcKTMHd0H2JtC1+ZAbF1HmQqYSkaxbehpDi6HGH4V8Yd4SlWMW/NmZciU0
         dDMNJd11l7+wW2ZN5Mz5ZKbagXjCRutuPRlLixpe9mNp0a8tE521SJk2u+aimawEhaRu
         xMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795679765; x=1796284565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MJDhqAb9koNt1RgW5GuhBq8i/bxOmY78SeKm0Wu/0k=;
        b=HafLx9kNNofFlTkuWvuBgOIKtfdxaokHm3M9x4lWBHN4hZ7a9XSwngGTdSedR/HlFR
         N22NeKEGA1yjdtLXMOhr7jCQcpqFRhwPmXwmjW4NOcg1pq45GZgl1tqnTrxV8f+mOHU4
         AMae5j5cYYTsleWFwHFkhe2qmU+X1jAE5SOiQQkW8klo6AYYuwKjp6Cx+t8w8NCC/S0N
         eK5z9mDcrbXu6/2CLS+QdmOCG+HOLkM0QqXkvnBDhIc+98BTVXJ2UV1B2G1Y9+R0BJcD
         Hqxua2K/9a+q7NMuZ6rDwrCtCUDEmOZZUenDEb2WZ8MQoiaDDVHqQDlYHyj1XLo1bghr
         lUxw==
X-Forwarded-Encrypted: i=1; AL+hErHe2M2e5CoHVmVi2jhmsoFsbA6XQ4isZkTKJE13ZgAlaEpWUad+KP04/c+n1ZucA8WA4knJ3qcucSc85LCH5a4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8r9hTU/5plSUS0sthu6dHN5F9ks95HYTd805jwtxM02xFcSYzp
	qJQFqpcaZ15+AML0LFAJpzH7PLj1p/VRbvb9fVZ1t1zU7jZT9F0ABTQM
X-Gm-Gg: AZFdTZc7Pa1OJddrhgsBDWrYgKuYcj7xq0kPP6hiYg4rpIh91ybZQFTEwokjJRj2g5H
	L8BIze4XRi2jh/S6HXBqe/RuyewGM5QN5EeyVRTCkwk442PXmyxp8KGvM3BeZmkzsWaHG4IamJt
	kiSqbsviSQujD/EiRKRiWytxocC9t0oGMbjo4Y58COHlWnR0eb4qR9KqYclUbtesJRUT+a1JadB
	Z5amk023feSAVBieV9Pdpkv8aVOkjsAIFuxQVvQQiushBet+dKE/1fsdGKeWHJkA/4TXCwiMiYp
	AO5jmaE69nvv1XNBOaeXtKIGn04LnNXpTYcBmVHRKERc8ViPVk5ZFohzviRHKAVO5k+sh3ylTmC
	bguqeH2eKjoBFDvShQRS4uaLl3ORiCMkf/SycD7XMGefTavUKAySaTmmmZE/f8U1NP+qsYl5yfz
	UP+y7xYfVpN+djzOd5NWXoCj+ocKpE1EOmQZ00Fb/QgNBwWDOAI2CjPZb7cc3UuCrnmpy7i0j9J
	bgqBV/7R7VXY9vJTQgSy+n1ZuCFtSSxSWD9L4TQlpAM81pNbowLmTeAyPArYeHgyWWEzciumJeJ
	+sfmf1gbZyB53aIgcL5qi7n4FPERmNt9Q0EhzYOhcOZFNm297Q==
X-Received: by 2002:a17:90b:498c:b0:3ac:73c7:9c07 with SMTP id 98e67ed59e1d1-3b41c55b914mr28943310a91.0.1795679764805;
        Wed, 25 Nov 2026 23:56:04 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm10690855a12.23.2026.11.25.23.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:56:04 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] Bluetooth: hci_core: lookup hci_conn on the ACL RX path
Date: Thu, 26 Nov 2026 07:55:53 +0000
Message-ID: <20261126075554.106-3-junzheyu1@gmail.com>
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
l2cap_conn before dropping hci_dev_lock. 6.6.y has
l2cap_conn_hold_unless_zero(). sco_conn and iso_conn have no kref, so
those paths are unchanged.

Cc: stable@vger.kernel.org # 6.6
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
Signed-off-by: Yu Junzhe <junzheyu1@gmail.com>

---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_core.c         | 25 ++++++++-----------------
 net/bluetooth/l2cap_core.c       | 23 ++++++++++++++++++-----
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 62804d98d..e0deaa54b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -837,7 +837,8 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 84d9a445e..a54d29bad 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3798,13 +3798,14 @@ static void hci_tx_work(struct work_struct *work)
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
@@ -3816,23 +3817,13 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
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
index 94fddc456..5b5a9e763 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7752,13 +7752,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
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
 
@@ -7766,12 +7777,13 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		conn = l2cap_conn_add(hcon);
 
 	conn = l2cap_conn_hold_unless_zero(conn);
+	hcon = NULL;
 
-	hci_dev_unlock(hcon->hdev);
+	hci_dev_unlock(hdev);
 
 	if (!conn) {
 		kfree_skb(skb);
-		return;
+		return -EINVAL;
 	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
@@ -7885,6 +7897,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 unlock:
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {

-- 
2.53.0
