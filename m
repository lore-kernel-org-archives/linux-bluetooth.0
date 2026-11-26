Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679763;
	b=Le50iMAwgFX8oex//jHYWf+odCO8aizbeE/FkfzJ92v0R7p8LdK+CDdCe+Rn76mxFMpx
	 7L8v08p7Ukxr8cya8ZE8MKwyO+n/Apk96ibTXjIV19o+h32PM9cWAWpAbHIrKphnnEH29
	 u+K9EfOwxJ+hbO4DnGkHwCoyE7Aw7dLhnTE/E6UclnvNeiO0MRZtQWiJA0SoeOHqLbhHY
	 HYiOkmQGwS4VVu7cE20XxRWi/4Ff8v02+cqE7TkRDiuFR/Z5aTkn7B0Wob8qygmC8VC5E
	 eOXR/IWUDMpSLAaseWryWst5l9u+BQYhmhbywACRGbS+0p+XZBZCiCQ29pVtIvTbCGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uGv/LgKfEeFUP7Ppdmh49v4/8KqCylcah3LCXsjqiUA=;
	b=RtE2IXAHRThj77Py4etFGX8s1fFjHkaGyW2sjAlXh1Mrm8zwy4t9W3/5ZxnE+2hSflOv
	 62z8TwEb5XYbEODubciDFwA06unGfDNchsFbpVRBDDHBgHlkIPV5xYvaJ4wteY5Rc3zxj
	 NG7GDsEaGGZhdd6Cm8EJ/N3efL/YYQcOQYTT4oGOv+kq5yLU/I/v9+Yi8Q/YMSpePFrTT
	 EVH+ajUQA7m7/kVPxdnLNmVyfnQ+RqCWTEN5nTU1jtcaIUQ1iFXTsUgAYzn8K+zp3zxek
	 xZoRgLIGExr8ySZNDWe6Ft8B/UwIcxT1N2XUXMYJAHbVl+7ZHeWm2x3Qp4W3ZJvYM8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HyW1+rfq;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD7606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 07:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DD7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HyW1+rfq
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b51284667cso67922a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795679762; x=1796284562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGv/LgKfEeFUP7Ppdmh49v4/8KqCylcah3LCXsjqiUA=;
        b=HyW1+rfqIwU8jzKGo31B7a4awqN8AFNKCf0oYBO/WIgrTMzOTQxNLF/BQZXkD8ImQ4
         rW+dAUmEUXw0DDKmReOfJZ/8N7E95/M8Yt2mdmcQyWbFelz94ZS80GjjcXgqRENWB5QB
         8B76wRBIGGvhNFONfZMPDALxhrYi7OwCbEx5qul+nfaKjS/PistZ1frcH4EZO47FGs8q
         MOHRzIQ/PO8TdMdYCTCKtGiUKKHFGFr1oOeu4BgQLNdqznhZTDeMrNw0SNrcTMnZkX5e
         dH1OrJjJ8OQxdpmqj0avOwLEEaMo9IuSEP0pU1Z2sSjnkyP7TvtAsU5t4jJLa/HzRSlC
         fxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795679762; x=1796284562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uGv/LgKfEeFUP7Ppdmh49v4/8KqCylcah3LCXsjqiUA=;
        b=l9UZ/dsLY+vu9bR7sGmKdAJi1xevW3w/Wlqkc1W30XC4lP8MkQ/tQy4xgBvpDCIFOU
         ys2oOzzqrHKjMae8meXs4K7mS1jg33vVWiTKbdAmWxnrpr9VY4QoA7J/oOXuM6C2Oz7a
         ikBGqy5pQgAytp8Bc2IgAU+g51Dw+YxZgt1L956x3f00plJK1n3bBbHSfiWk/Efz+gOm
         qTAjFVxDuVJi+u2txx5RPR8Sc+lqbY2GBvpTi+SncXZgQo8YGtjhuvEOfzvzUq3FFHLk
         1x5Zhmhh+zuAqSHAfbwYqlkmz9VMkUzZbWEls4t3ReXaUCG11hfHgPTWKwOkYp2J1M+F
         ykgA==
X-Forwarded-Encrypted: i=1; AL+hErH4RRTeGJKGqj0Ch+ifYpGnrEPXitgCRDhwlyaZDBvbozXu6b33uoVsN+WvA4LVDkmt0j2UCT4fxmDC1Ies5fg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JgMfhczpFwbQUfWJNr0b2lDdo5qQMLHkTxSlPF4yhuvig7vbk
	Eso7nGjKSso5R/PXo+//AY3ZzgChI6OjHhLp1D8qsOSOD0yaJ0ZJYYVP1uCkxthS
X-Gm-Gg: AZFdTZfiIklHE0vViGL8Ib6jXQpmpL+xsyHGRAqFK7UUygdK97GKhV8zcnTPSJ16zdR
	xpncOz408njnIamVwpgt3qprzR0dfLZGIrt/niGUj/hu0w+m132ZTMe8o1b4CJsEl44dAAHKFmQ
	MgL0F38lxJqFSM0YG+3Mf9iA09zVtzIhRkfRzF/cGjcyK//q9n5+Tg53485KDWdJ8BI+ds4s9Ge
	DcbuYFu4fjIfO1P5ZzaNF0aPo8o7QctmJzAXGQRGDwOZh4Ass74lQwBVUcOLnyiqc0JrKZYSQ17
	gaj7K6RjwL01eCLhAJGemLvoY3EgzbmTAvuN/Y3dQpyAoloh1VqwDmIm5A49QGhkB30vz67Hy9z
	vCaaOERqUYxksm5rNDNg5WIuTqmzcxdQqB6akQInMzNT4WihR7ofLNw0cc8xIzkBFh1rwbdwL6Q
	r4nlC9y5rVoDAENUUkx1FMoask2P4fwM85H6xnWgEl6inJrsavAcTaSPD076c0hfpOg6aci3xBk
	W7b7MQB8WD08OFzV8VmwDDp5AY2xn9b0jE4M3xOsvUNjPL3Bjqv0Pp+lQjIzJdjvWX576tSIxBe
	Y1KeYHwH5NzMWPlx51Y/vHCXzWABCReHgXP63fLef0ltKPxaabs=
X-Received: by 2002:a17:90b:2e48:b0:3a8:9db2:a59 with SMTP id 98e67ed59e1d1-3b41c556e6fmr32172575a91.0.1795679762112;
        Wed, 25 Nov 2026 23:56:02 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm10690855a12.23.2026.11.25.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:56:01 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] Bluetooth: hci_core: lookup hci_conn on the ACL and ISO RX paths
Date: Thu, 26 Nov 2026 07:55:52 +0000
Message-ID: <20261126075554.106-2-junzheyu1@gmail.com>
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

Move the hci_conn lookup into l2cap_recv_acldata() and iso_recv() and
hold the protocol object before dropping hci_dev_lock. 6.12.y already
has l2cap_conn_hold_unless_zero() and iso_conn_hold_unless_zero().
sco_conn has no kref on this tree, so the SCO path is unchanged.

Cc: stable@vger.kernel.org # 6.12
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")
Signed-off-by: Yu Junzhe <junzheyu1@gmail.com>

---
 include/net/bluetooth/hci_core.h | 11 +++++----
 net/bluetooth/hci_core.c         | 49 +++++++++++++---------------------------
 net/bluetooth/iso.c              | 30 ++++++++++++++++++++----
 net/bluetooth/l2cap_core.c       | 23 +++++++++++++++----
 4 files changed, 66 insertions(+), 47 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f846865db..22ac4870a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -843,7 +843,8 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
-void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
+		       u16 flags);
 
 #if IS_ENABLED(CONFIG_BT_BREDR)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
@@ -862,16 +863,18 @@ static inline void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 
 #if IS_ENABLED(CONFIG_BT_LE)
 int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
+int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags);
 #else
 static inline int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  __u8 *flags)
 {
 	return 0;
 }
-static inline void iso_recv(struct hci_conn *hcon, struct sk_buff *skb,
-			    u16 flags)
+static inline int iso_recv(struct hci_dev *hdev, u16 handle,
+			   struct sk_buff *skb, u16 flags)
 {
+	kfree_skb(skb);
+	return -ENOENT;
 }
 #endif
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3a713084f..fe2900960 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3865,13 +3865,14 @@ static void hci_tx_work(struct work_struct *work)
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
@@ -3883,23 +3884,13 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
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
@@ -3940,13 +3931,14 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_iso_hdr *hdr;
-	struct hci_conn *conn;
 	__u16 handle, flags;
+	int err;
 
 	hdr = skb_pull_data(skb, sizeof(*hdr));
 	if (!hdr) {
 		bt_dev_err(hdev, "ISO packet too small");
-		goto drop;
+		kfree_skb(skb);
+		return;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3956,22 +3948,13 @@ static void hci_isodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
 		   handle, flags);
 
-	hci_dev_lock(hdev);
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
-
-	if (!conn) {
+	err = iso_recv(hdev, handle, skb, flags);
+	if (err == -ENOENT)
 		bt_dev_err(hdev, "ISO packet for unknown connection handle %d",
 			   handle);
-		goto drop;
-	}
-
-	/* Send to upper protocol */
-	iso_recv(conn, skb, flags);
-	return;
-
-drop:
-	kfree_skb(skb);
+	else if (err)
+		bt_dev_dbg(hdev, "ISO packet recv for handle %d failed: %d",
+			   handle, err);
 }
 
 static bool hci_req_is_complete(struct hci_dev *hdev)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2733cc8b8..4e3584266 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2424,13 +2424,30 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 	iso_conn_del(hcon, bt_to_errno(reason));
 }
 
-void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
+int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 {
-	struct iso_conn *conn = hcon->iso_data;
+	struct hci_conn *hcon;
+	struct iso_conn *conn;
 	__u16 pb, ts, len;
 
-	if (!conn)
-		goto drop;
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!hcon) {
+		hci_dev_unlock(hdev);
+		kfree_skb(skb);
+		return -ENOENT;
+	}
+
+	conn = iso_conn_hold_unless_zero(hcon->iso_data);
+	hcon = NULL;
+
+	hci_dev_unlock(hdev);
+
+	if (!conn) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	pb     = hci_iso_flags_pb(flags);
 	ts     = hci_iso_flags_ts(flags);
@@ -2480,7 +2497,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			/* Complete frame received */
 			hci_skb_pkt_status(skb) = flags & 0x03;
 			iso_recv_frame(conn, skb);
-			return;
+			goto done;
 		}
 
 		if (pb == ISO_SINGLE) {
@@ -2556,6 +2573,9 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 drop:
 	kfree_skb(skb);
+done:
+	iso_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb iso_cb = {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bab8caf18..e7915e847 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7895,13 +7895,24 @@ struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
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
 
@@ -7909,12 +7920,13 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
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
@@ -8028,6 +8040,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 unlock:
 	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
+	return 0;
 }
 
 static struct hci_cb l2cap_cb = {

-- 
2.53.0
