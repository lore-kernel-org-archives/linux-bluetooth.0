Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683991;
	b=Vfa6PYZnW1m5h3T2oosI9gt25hA049k370/1SsBr1n4/O+cD3jJ7uoNWswWwq/+93wVk
	 rMV70PTmVcd5yFij91lVkkrP7sYftN1AGjhqMCsaSSXmt9KlGXyjqUt9i/39wBRhY2MYc
	 qtT23UOPbkaTJ5yzoYuQvdQcgK+QeZWou3kV5OMUSNFmIKBB8RjaRNJ9CAI+R8K1ZUqyT
	 +s9UqQgznJdmdWuu1aM9XfhrX4lUV5p3oRxgD+s0Eyx2icL4X2zf6k8tWkgWN6U62pfDx
	 3NXbUAXNPMTTj1bEjLOZYqmQ0bT+lhGlwbDe3CIsqh/N/8yXPZVuAmpsh90VfS9Sbnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wzTbFXKmm6R2N1E9To5wB7Kof+uvTpAYeSabTuNnZ5Q=;
	b=TWztNV5iS+OeDI8jOinxJTPNYV00Ucxx3CdxzGE4eAjedf96Fb/jqy7MId9dT6g+EqXn
	 OVkTdwiNecY42coK2Vy9tIC25TMaK8mCrGilr+aaOnzbO3KSOou2abkJ5bRZFebAllMeS
	 tdsfgyv9HRye4xSNtOOU9TZz0JSmq5Xll5rgRLxMr7cGTBDeK7jbCJXxy1KvoBPIy/5ZN
	 bljMH4sGUXU9+awmMv5WhYM2gy/FJUjBOdo8EQe5YsY3Vc0MkuxhDMVd1t9M6hD2kive5
	 uNKKj2piZrRWVyatGHvB2ALb5pXs8ysmmEcY0ghDxcndhYHXRK9oCUFqzunG7IN88Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EMVHEfuU;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B22606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B22606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EMVHEfuU
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9908e3cd939so20241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792683990; x=1793288790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wzTbFXKmm6R2N1E9To5wB7Kof+uvTpAYeSabTuNnZ5Q=;
        b=EMVHEfuUjOCoe1EAMiUXziHNYYKDYvyJDE80GfzoBlq/sEbPXshvALCNLwW7dUcGKx
         iy+uqDuOOEk66LzCCcHFu2NLeBZnbc3F3BRFve4JN3JVIaHe1QWmnGJf+SHBZ9NCQXUe
         GWKpKzJIJERkOB8DejrXhKkQsnFcMXdaV5VpUG374/LOWeo3OIIueoM8YI3PT5CboxgW
         XCrBU/B3uAghBHcZ8kqIhCNcg9yghpqZNlulNRCJy+6N5wu2bmAMBaOmwdVitceKCAw1
         sYYYdR9iQ166D4tVAyUBXXR5NnOQSu+cG8nt3475dgaaF5BtLfE6aqwGNKO7Mzvp/n28
         L9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683990; x=1793288790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wzTbFXKmm6R2N1E9To5wB7Kof+uvTpAYeSabTuNnZ5Q=;
        b=Jq+nZPloqwZuuu15K4PazSm1UbGFlcQT/G2nEiKgsr9jPfZU4AdqRowjf4drmlmQnU
         PMwYXffgJoMXpK1BRSp527ZI9dpUiNwPfeMQgmjGCntrsX9ovFd2qwQlaRzf06Ql6vTY
         DSyELczt1KpnzEUpPepgccZTRdIpZZrAQmHh8kR1Sq312taNSm3wUN8A4fp3bxHey8FA
         7hG/7xqrwtPvMK7b/o7ZWfPlFiWrjgdxFjR1eCIJj+GrgC+CqQcImn4dBFJ3YvVeqEj8
         wFBsiu1zEiTe19wjD+r8nBH+xZSzG86tWNBWQ1MuvHFenMAqhOxXj9o27jzcKV4w+C8p
         oboQ==
X-Gm-Message-State: AFq9FYKZj1Uj1JBg3CpiAgkwPnuBZdn+115jBKmtXRg6MJ+blaERcHLU
	jf8EqHJskmBDtVYBPFWpbYLsbVN/yGDGr1byZ9uGmaNKyue7ZzXD13QH3+sdBHiwwqo=
X-Gm-Gg: AYBFou0IpwfbN3U67KHQxO98/u16daf11wuRtyl6vbGrWsLaQuQETIkOTkJAJ0qIhwJ
	OaVNq7JmGjwnbu7N3J6ssaqj+bbPIiFOxSloKHeK0PjQol3z+4vq8CqdVDJ/SlScj/NeKT7uKcD
	cdLm0p3qCBC3IzQBhCnS4VzJhmGsm7xR8PHitzjThum+qRG5yfkGfWvdFVGi6s8Ziy57I+4bk35
	dOsostKp+f+ezhz0lNXNYxCe5fQpc1pe5BJ7iWW8G17/p2X2yqLxqw/UxeIV8H14gkeQRYK9GI5
	EF2eB3PxM9+OF0Ui3X79QhgeJUiInaiG10h+pxIZQ3iY30mYUSxGImjKqOPs7TpIXSyH5TMKTZp
	bJa2JwDzRgD1iW+Vph30oHK8PZpBnssKW3YXNhq9BZKyIhcL08soizd3fTe9QlK6r6aw+MVb1za
	Fxl1g18rkWZDyVZAotzZTrFElhU0mOBwtkWc5o95OYw//zJQfgbvv+Db1khaoMKFR4+Ag+/kWY3
	I2NA8UXXHKV1SBIv5ucvPxOicvvvYQfEvYnnI9b+9IeL+t1T1Hew7vJHgCIFe9HInfJi9IeZAHr
	EDRhniyjXJSx5rZpM/G48QuT+Kv8Tc73lb6izoVKHdqROw==
X-Received: by 2002:a05:6102:c46:b0:7c3:9b0c:a75 with SMTP id ada2fe7eead31-7cc925e72damr1777921137.12.1792683989567;
        Thu, 22 Oct 2026 08:46:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ccc2203b79sm11697137.11.2026.10.22.08.46.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:46:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Hold incoming data until encryption key size is known
Date: Thu, 22 Oct 2026 11:46:21 -0400
Message-ID: <20261022154621.3958803-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154621.3958803-1-luiz.dentz@gmail.com>
References: <20261022154621.3958803-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Once encryption is enabled on an ACL link, the encryption key size is
read from the controller, using hdev->min_enc_key_size in the meantime.
Data received before the reply is processed with that key size, so a
peer starting SMP over BR/EDR right after encryption, which it may do,
gets its Pairing Request rejected with "Encryption Key Size" whenever
the pending security level is FIPS, as that requires a 16 octet key:

  > HCI Event: Encryption Change (0x08) plen 4
  > ACL Data RX: Handle 1 flags 0x02 dlen 11
        BR/EDR SMP: Pairing Request (0x01) len 6
  @ MGMT Event: Authentication Failed (0x0011) plen 8
        Status: Authentication Failed (0x05)
  < HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
  > HCI Event: Command Complete (0x0e) plen 7
        Key size: 16
  < ACL Data TX: Handle 1 flags 0x00 dlen 6
        BR/EDR SMP: Pairing Failed (0x05) len 1
        Reason: Encryption key size (0x06)

Mark the connection with HCI_CONN_ENC_KEY_SIZE_PEND while the key size
is read and hold incoming L2CAP data back in pending_rx meanwhile,
processing it once the reply is handled.

Found with mgmt-tester "Pairing Acceptor - SMP over BR/EDR 2" under User
Mode Linux time travel, where the emulated peer always replies before
the key size is read.

Fixes: e3f6a257a73d ("Bluetooth: Use actual encryption key size for SMP over BR/EDR")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 12 +++++++++++-
 net/bluetooth/l2cap_core.c       | 16 ++++++++++++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8f32c860d492..f6fa6a327e11 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1017,6 +1017,7 @@ enum {
 	HCI_CONN_CREATE_PA_SYNC,
 	HCI_CONN_PA_SYNC,
 	HCI_CONN_PA_SYNC_FAILED,
+	HCI_CONN_ENC_KEY_SIZE_PEND,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 56ad10ab96e3..565668d8d7cc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -724,6 +724,8 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 		goto done;
 	}
 
+	clear_bit(HCI_CONN_ENC_KEY_SIZE_PEND, &conn->flags);
+
 	/* While unexpected, the read_enc_key_size command may fail. The most
 	 * secure approach is to then assume the key size is 0 to force a
 	 * disconnection.
@@ -3190,6 +3192,7 @@ static int hci_read_enc_key_size(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	struct hci_cp_read_enc_key_size cp;
 	u8 *key_enc_size = hci_conn_key_enc_size(conn);
+	int err;
 
 	if (!read_key_size_capable(hdev)) {
 		conn->enc_key_size = HCI_LINK_KEY_SIZE;
@@ -3211,7 +3214,14 @@ static int hci_read_enc_key_size(struct hci_dev *hdev, struct hci_conn *conn)
 	else
 		conn->enc_key_size = hdev->min_enc_key_size;
 
-	return hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
+	/* L2CAP holds incoming data back until the key size is known */
+	set_bit(HCI_CONN_ENC_KEY_SIZE_PEND, &conn->flags);
+
+	err = hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
+	if (err)
+		clear_bit(HCI_CONN_ENC_KEY_SIZE_PEND, &conn->flags);
+
+	return err;
 }
 
 static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4dd56e0074fd..361ed3ebe19e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7389,7 +7389,11 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	u16 cid, len;
 	__le16 psm;
 
-	if (hcon->state != BT_CONNECTED) {
+	/* Also hold data back while the encryption key size is read, as
+	 * the security of the link, e.g. for SMP over BR/EDR, depends on it.
+	 */
+	if (hcon->state != BT_CONNECTED ||
+	    test_bit(HCI_CONN_ENC_KEY_SIZE_PEND, &hcon->flags)) {
 		BT_DBG("queueing pending rx skb");
 		skb_queue_tail(&conn->pending_rx, skb);
 		return;
@@ -7452,7 +7456,11 @@ static void process_pending_rx(struct work_struct *work)
 
 	mutex_lock(&conn->lock);
 
-	while ((skb = skb_dequeue(&conn->pending_rx)))
+	/* l2cap_recv_frame() would queue it all again while the encryption
+	 * key size is read, l2cap_security_cfm() schedules this once known.
+	 */
+	while (!test_bit(HCI_CONN_ENC_KEY_SIZE_PEND, &conn->hcon->flags) &&
+	       (skb = skb_dequeue(&conn->pending_rx)))
 		l2cap_recv_frame(conn, skb);
 
 	mutex_unlock(&conn->lock);
@@ -8041,6 +8049,10 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	}
 
 	mutex_unlock(&conn->lock);
+
+	/* Process data held back while the encryption key size was read */
+	if (!skb_queue_empty(&conn->pending_rx))
+		queue_work(hcon->hdev->workqueue, &conn->pending_rx_work);
 }
 
 /* Append fragment into frame respecting the maximum len of rx_skb */
-- 
2.56.0

