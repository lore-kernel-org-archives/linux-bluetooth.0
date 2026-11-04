Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830412;
	b=WKB8sDARvgSLTh/vFpsXc5gX55cz/TPfmTwkxrBYOoDCfSPLJQE4bwskSXRcYYcws0Z+
	 AppHlX2Tvq/cmZbu3ah/UNBxtqCv0fHyz5/o9alWslMk9jBbwe9p+Jrx7XxTuUudyJh3b
	 zkxPr4+JTrazgoctol5OA6fpE1xsXN/4w6FeMeifk7WjBZvjERefoMyiWxEtrwuoPQHUG
	 b/54RN4V5SWf59qZYFrV/mRwndNXaPijiVhHmVbwaDnDmkc3iJDNWYuAAfGeZOSjtvbB4
	 +QwbvPvbx/BXI7eIZZTTOrwzf7yaGxGWVGVpITDtgHykEVlFd2Uc4ER6XtmFQ5n5nXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fwAksvzSOmBVFge0EIZYJKky3Vzm7cm3SsV08t4XTFA=;
	b=GKVCMw0ySZPx+4CZ2T80WeKGUNjS5O1Cx+fb0CFwDmBhfNE6KP+1ljN2S8FA8SIorkAv
	 BOS7l+Fxqrd153UclWy3MY7atN4WX+7Eczxy1ky26NuaacHF5G2YGFXVS6Juh965oP+3w
	 BuDZiovfQCoFrWjBJj5uPI2g/at1fw9+P4oj6T6gnUZEPYCMVTRNae5vHJPsaW43M4s3+
	 918waFH/A7+/xsKP+F1sbVcQ4FNQ+XhCW/pmsnHg1PaDMofRltyoZZisySZXWtjUgTv/x
	 MzqK2BsENYK4GCIzfngluFMQfCbCqP3uf0xmLEIv6CrFnVje6kLvUhZ7qdYKZZnBXUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Af4GFavO;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BA6070334
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A90BA6070334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Af4GFavO
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99071945aa7so644443241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830411; x=1794435211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fwAksvzSOmBVFge0EIZYJKky3Vzm7cm3SsV08t4XTFA=;
        b=Af4GFavOTmi7Cwo5ReDCwmD5dG66XEjxLK7rafKeJcxGkht4xaAnIBugFW0gPmHpvN
         ZjcwiFTfEmk321Yh6CC95OQsd+Vbedn7DMc6GqtL7Dwkrc3gSHuyQIenFp0TUyqjvzc3
         6IGlA+IJ7uD+EAYr5aH5Y6UUWhXA22lL8nTIgISpN5SxBmizdFbpXN0Yb5U+8ZDcf8LL
         9tfNZZMd7ujZjAB/fdbizDJUhCVkc8T6PiSKc5PKj+/9Qsu9iWmIvA3+VY07E+q5rjGq
         dPm8gW4C39lyK/ROymWUpW7VkC+0DRtaFv3966gAVCaikK5HbXpy4KGwWuoH4OFiba4N
         jXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830411; x=1794435211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fwAksvzSOmBVFge0EIZYJKky3Vzm7cm3SsV08t4XTFA=;
        b=p2Yht65yjvNX7uZxTPtSAlUeuQSphz555crR1qPUE3XhwDttSFB7/zb1ejcujA7Xv7
         FB7sLX2eihfX2VrxtFao25+fCqdPjyD4JKT82Py0FsTDR619HscvArCNKn/s7GwMk9ZR
         uafZck7WhsCqIyHCKhuZlvrQoLhAMESPzamXlP33vCVuUTkjxo6wHduXNdaqVX3D1KEi
         lib/njGsYVDXjlMO9R6PUdN+e5ZDNGDItkc584t2cQMk11YtcoccDFahncbWyEVZedli
         igFbrpk1tTfNjikGvK4Yw9taobbRX7PAfVXMn2TCuvLs3xpkATlUBL8Qr6AJzPCG/KTP
         6uIw==
X-Gm-Message-State: APuU4Z+rJwTqoMo7a9xpx0Ocw8r0ZGbBDliBy/sY/oZ0XKpj67pDOfl9
	Ofik5HyX3tJiWJYDDHp8ufVYPgD4uHAsyfxsoCGKSrLrOFkiOi5jIW5R3RZ0zQ==
X-Gm-Gg: AYBFou0Qn+Uf7KupGgr4+b62u6Ly6YIXZzmzJug7HTx0KtuOgMoALfhX6xY0D8RWW5r
	036zxN/ykQ6cG9JTx6+/Rk5P2hE948ZCiQNnn/xmrGhpIwB8XNtHuhJzdtqjs/lmH5FK0g7ierh
	a0DOdCTXpY2MbLsHdnCHgxZFvNwBt32p7P7bGolemhSwSrB6FgtrimXnl0V4Z/t6AiKtRq7VLRG
	NntwiCxRx96lzUh6iDLqAq8ZefTLCi6qPjwbGco6WA7MwtxqA+MP9tbtV17ho4bY2liqu3Jyibc
	Z/TBjWczDoVvNZOe4NeZxUqMF77HE7E40lJEV67RqyPQly8aRq68MS4sMc65QjFlVN1DHgQTNum
	15GGd0enWwdxDJJylZv5Yid+gPHTaWK7U8bRDsWs2rsKeOoVrmoUHZ1Ew627cpUqYhluk44a4mW
	ZEuM+iT0R9pFVufYRwm6Y7TLwugwV/vByZ8jhZjz/zxtU1upP3VdplM6pHSLwPd6LyjO+Ljf5GZ
	30gxcSDzfgMaWnW5cuA6yaAjo23JrSvTxDrRkv2/4mvJ+x0vExTSpYcyvOjF4Ek0Ws0Z7lhNXMJ
	ydX7DTjPEIvaRhVCxLfIvOjQGfERlZ9PGtYeICvVSbpDu6fj88dGqlpfGmAr68HtKWhR/5eoDLW
	AippFioee7vQzo9hJkbWWPiPoSaChGwwMdFWqvIblOEusmDSwmhWLi4X4lrV+HfJk8qpV1PpDXh
	gXfpQ=
X-Received: by 2002:a05:6102:3711:b0:7c1:f386:1b7a with SMTP id ada2fe7eead31-7d072cb03f1mr7577791137.27.1793830410343;
        Wed, 04 Nov 2026 14:13:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm2934001241.12.2026.11.04.14.13.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:13:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/6] Bluetooth: Add EKS Opportunistic Encryption support
Date: Wed,  4 Nov 2026 17:13:21 -0500
Message-ID: <20261104221321.1200529-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104221321.1200529-1-luiz.dentz@gmail.com>
References: <20261104221321.1200529-1-luiz.dentz@gmail.com>
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

Add support for opportunistic encryption with Encryption Key Schedule,
which encrypts a link without pairing when both devices support it:

 - The Opportunistic Encryption (Host Support) feature bit (Link Layer
   feature bit 90) is set with LE Set Host Feature during
   initialization, and eks_oppt_capable() checks the remote supports it.
 - When the remote features are read as Central and there is no LTK for
   the peer, LE Enable Encryption v2 is sent with Encryption set to
   opportunistic. The checks are repeated right before the command is
   sent, so it is skipped if the link is gone, already encrypted, has
   SMP encryption pending or SMP pairing has started in the meantime,
   and the MIC length is taken at that point so the one requested by
   L2CAP is used.
 - The new HCI_CONN_OPP_ENCRYPT flag marks the request in flight and,
   once Encryption Change v3 reports it, an opportunistically encrypted
   link, which is also marked as encrypted with AES-CCM. It doesn't
   raise the security level, as it is not authenticated, and since it
   has no key from pairing the L2CAP key size check is skipped for it.
   A failure, or a command that cannot be sent, just leaves the link
   unencrypted, as it was.
 - HCI_CONN_ENCRYPT_PEND is not used for opportunistic encryption, so
   it doesn't block SMP. Pairing over such a link completes and its key
   replaces the opportunistic one with Key Refresh Complete, which then
   clears HCI_CONN_OPP_ENCRYPT.
 - The feature can be turned off with the MGMT system configuration TLV
   0x0024; it is on by default. Changing it while the controller is up
   updates the feature bit, which the controller only allows when there
   are no connections.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |   6 ++
 include/net/bluetooth/hci_sync.h |   2 +
 net/bluetooth/hci_core.c         |   1 +
 net/bluetooth/hci_event.c        |  49 ++++++++++--
 net/bluetooth/hci_sync.c         | 126 ++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_core.c       |   6 ++
 net/bluetooth/mgmt_config.c      |  23 ++++++
 net/bluetooth/smp.c              |  23 ++++++
 net/bluetooth/smp.h              |   2 +
 10 files changed, 232 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3bda65f6998b..8c77a3eab739 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -668,6 +668,7 @@ enum {
 #define HCI_LE_HDT_7_5_TX_FEATURE	BIT(1)
 #define HCI_LE_HDT_PF_1			BIT(2)
 #define HCI_LE_HDT_LQF_FEATURE		BIT(3)
+#define HCI_LE_OPPORTUNISTIC_ENC	BIT(2)	/* Byte 3 */
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d05ef2cd413f..dd0306da0d66 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -436,6 +436,7 @@ struct hci_dev {
 	__u8		hdt_def_mic_len;
 	__u8		hdt_def_format;
 	__u16		hdt_def_rates;
+	bool		eks_oppt;
 	__u8		le_max_key_size;
 	__u8		le_min_key_size;
 	__u16		discov_interleaved_timeout;
@@ -707,6 +708,7 @@ enum {
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_FLUSH_KEY,
 	HCI_CONN_ENCRYPT,
+	HCI_CONN_OPP_ENCRYPT,
 	HCI_CONN_AUTH,
 	HCI_CONN_SECURE,
 	HCI_CONN_FIPS,
@@ -2191,6 +2193,10 @@ static inline __u8 hci_conn_mic_len(struct hci_conn *conn)
 #define eks_capable(dev) \
 	(le_feature(dev, 1, 1) & HCI_LE_EKS_FEATURE)
 
+#define eks_oppt_capable(dev) \
+	(eks_capable(dev) && \
+	 (le_feature(dev, 1, 3) & HCI_LE_OPPORTUNISTIC_ENC))
+
 /* Channel sounding support */
 #define le_cs_capable(dev) \
 	((dev)->le_features[5] & HCI_LE_CS)
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index e4e220ed098b..966106b4a0fe 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -202,3 +202,5 @@ int hci_le_set_hdt_params_sync(struct hci_dev *hdev);
 
 int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
 			  __u8 ltk[16], __u8 key_size);
+int hci_le_eks_oppt_encrypt(struct hci_conn *conn);
+int hci_le_set_eks_oppt_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a4014bbcdfc2..06e676eed468 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2578,6 +2578,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->hdt_def_mic_len = 0x02;	/* 128-bit */
 	hdev->hdt_def_format = 0x00;	/* No preference */
 	hdev->hdt_def_rates = 0x001f;	/* All defined HDT rates */
+	hdev->eks_oppt = true;		/* Opportunistic encryption enabled */
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
 	hdev->def_le_autoconnect_timeout = HCI_LE_CONN_TIMEOUT;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e826809f8c75..5ce240f2f52e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3091,12 +3091,18 @@ static void hci_cs_le_enable_encrypt_v2(struct hci_dev *hdev, u8 status)
 	if (!conn)
 		goto unlock;
 
-	clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags);
-
 	/* An opportunistic encryption that cannot be started just leaves
 	 * the link unencrypted, as it was.
 	 */
-	if (cp->encryption == 0x01 || conn->state != BT_CONNECTED)
+	if (cp->encryption == 0x01) {
+		if (!test_bit(HCI_CONN_ENCRYPT, conn->flags))
+			clear_bit(HCI_CONN_OPP_ENCRYPT, conn->flags);
+		goto unlock;
+	}
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags);
+
+	if (conn->state != BT_CONNECTED)
 		goto unlock;
 
 	hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
@@ -3917,6 +3923,30 @@ static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* Opportunistic encryption (eks_mode 0x02), started by this side or
+	 * by the remote, encrypts the link without a key from pairing: it is
+	 * marked with HCI_CONN_OPP_ENCRYPT, has no key size, and doesn't
+	 * change the security level as it is not authenticated. If it could
+	 * not be started the link is just left unencrypted, as it was.
+	 */
+	if (ev->eks_mode == 0x02 ||
+	    (test_bit(HCI_CONN_OPP_ENCRYPT, conn->flags) &&
+	     !test_bit(HCI_CONN_ENCRYPT, conn->flags))) {
+		if (ev->status || !ev->mode) {
+			clear_bit(HCI_CONN_OPP_ENCRYPT, conn->flags);
+			goto unlock;
+		}
+
+		set_bit(HCI_CONN_OPP_ENCRYPT, conn->flags);
+		set_bit(HCI_CONN_ENCRYPT, conn->flags);
+		set_bit(HCI_CONN_AES_CCM, conn->flags);
+		conn->mic_len = ev->mic_len;
+		goto unlock;
+	}
+
+	/* Encryption with a key from pairing replaces the opportunistic one */
+	clear_bit(HCI_CONN_OPP_ENCRYPT, conn->flags);
+
 	hci_change_encrypt(conn, ev->status, ev->mode, ev->mic_len);
 
 unlock:
@@ -5703,10 +5733,17 @@ static void hci_key_refresh_complete_v2_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	/* The key refresh may change the MIC length */
-	if (!ev->status)
+	if (!ev->status) {
+		/* The key refresh may change the MIC length */
 		conn->mic_len = ev->mic_len;
 
+		/* The key from pairing replaces the opportunistic one, which
+		 * makes the link encrypted as with Encryption Change.
+		 */
+		if (test_and_clear_bit(HCI_CONN_OPP_ENCRYPT, conn->flags))
+			set_bit(HCI_CONN_AUTH, conn->flags);
+	}
+
 	hci_conn_refresh_key(conn, ev->status);
 
 unlock:
@@ -7932,6 +7969,8 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 			conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 			conn->le_rx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 		}
+
+		hci_le_eks_oppt_encrypt(conn);
 	}
 
 	if (conn->state == BT_CONFIG) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9d9f5b47331c..bdc1ba5b5d87 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5036,6 +5036,16 @@ static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
 /* Set Host Features, each feature needs to be sent separately since
  * HCI_OP_LE_SET_HOST_FEATURE doesn't support setting all of them at once.
  */
+int hci_le_set_eks_oppt_sync(struct hci_dev *hdev)
+{
+	if (!eks_capable(hdev))
+		return 0;
+
+	/* Opportunistic Encryption (Host Support) */
+	return hci_le_set_host_feature_sync(hdev, 90,
+					    hdev->eks_oppt ? 0x01 : 0x00);
+}
+
 static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 {
 	int err = 0;
@@ -5056,11 +5066,14 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 			return err;
 	}
 
-	if (le_sci_capable(hdev))
+	if (le_sci_capable(hdev)) {
 		/* Shorter Connection Intervals (Host Support) */
 		err = hci_le_set_host_feature_sync(hdev, 73, 0x01);
+		if (err)
+			return err;
+	}
 
-	return err;
+	return hci_le_set_eks_oppt_sync(hdev);
 }
 
 /* LE Controller init stage 3 command sequence */
@@ -8738,3 +8751,112 @@ int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
 
 	return err;
 }
+
+/* The opportunistic encryption is queued when the connection is set up, so
+ * by the time it runs the connection may be gone, already encrypted, have
+ * SMP encryption pending or SMP pairing in progress, so check again right
+ * before sending the command and leave the link to SMP in those cases.
+ *
+ * HCI_CONN_OPP_ENCRYPT, without HCI_CONN_ENCRYPT, marks the request in
+ * flight. HCI_CONN_ENCRYPT_PEND is not used for it, so SMP is not blocked
+ * by it: SMP pairing over a link being encrypted works, and the encryption
+ * started by SMP afterwards replaces the opportunistic key.
+ */
+static int hci_le_eks_oppt_encrypt_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_enable_encrypt_v2 *cp = data;
+	struct hci_conn *conn;
+	int err;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, le16_to_cpu(cp->handle));
+	if (!conn || conn->state != BT_CONNECTED ||
+	    test_bit(HCI_CONN_ENCRYPT, conn->flags) ||
+	    test_bit(HCI_CONN_ENCRYPT_PEND, conn->flags))
+		goto unlock;
+
+	if (smp_pairing_in_progress(conn)) {
+		bt_dev_dbg(hdev, "SMP in progress, skipping hcon %p", conn);
+		goto unlock;
+	}
+
+	if (test_and_set_bit(HCI_CONN_OPP_ENCRYPT, conn->flags))
+		goto unlock;
+
+	/* Use the MIC length requested by now, or the default one if unset */
+	cp->mic_len = conn->req_mic_len ? conn->req_mic_len :
+					  hdev->hdt_def_mic_len;
+
+	bt_dev_dbg(hdev, "starting EKS opportunistic encryption hcon %p", conn);
+
+	hci_dev_unlock(hdev);
+
+	err = hci_le_enable_encrypt_v2_sync(hdev, data);
+	if (!err)
+		return 0;
+
+	/* No result will come for a command that was not sent or failed */
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, le16_to_cpu(cp->handle));
+	if (conn && !test_bit(HCI_CONN_ENCRYPT, conn->flags))
+		clear_bit(HCI_CONN_OPP_ENCRYPT, conn->flags);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+
+unlock:
+	hci_dev_unlock(hdev);
+	return 0;
+}
+
+int hci_le_eks_oppt_encrypt(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_enable_encrypt_v2 *cp;
+	int err;
+
+	/* Only central initiates encryption */
+	if (conn->role != HCI_ROLE_MASTER)
+		return -EINVAL;
+
+	/* Check hdev config */
+	if (!hdev->eks_oppt)
+		return -EOPNOTSUPP;
+
+	/* Remote must support opportunistic encryption */
+	if (!eks_oppt_capable(conn))
+		return -EOPNOTSUPP;
+
+	/* Must support EKS and the encrypt_v2 command */
+	if (!eks_capable(hdev) || !(hdev->commands[50] & BIT(4)))
+		return -EOPNOTSUPP;
+
+	/* Don't encrypt if already encrypted or pending */
+	if (test_bit(HCI_CONN_ENCRYPT, conn->flags) ||
+	    test_bit(HCI_CONN_ENCRYPT_PEND, conn->flags) ||
+	    test_bit(HCI_CONN_OPP_ENCRYPT, conn->flags))
+		return -EALREADY;
+
+	/* Skip if we have an LTK for this peer (use normal encryption) */
+	if (hci_find_ltk(hdev, &conn->dst, conn->dst_type, conn->role))
+		return -EEXIST;
+
+	bt_dev_dbg(hdev, "queueing EKS opportunistic encryption hcon %p", conn);
+
+	cp = kzalloc_obj(*cp);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->handle = cpu_to_le16(conn->handle);
+	cp->encryption = 0x01; /* Opportunistic with EKS */
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_eks_oppt_encrypt_sync, cp,
+				      le_enable_encrypt_complete);
+	if (err)
+		kfree(cp);
+
+	return err;
+}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b19dd027adc3..3b2db6cb8f95 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1583,6 +1583,11 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 	 * This check might also be called for unencrypted connections
 	 * that have no key size requirements. Ensure that the link is
 	 * actually encrypted before enforcing a key size.
+	 *
+	 * Opportunistic encryption has no key from pairing, so there is no
+	 * key size to enforce. The security level stays as if the link were
+	 * unencrypted, so a channel requiring more still needs pairing,
+	 * which then replaces the opportunistic key.
 	 */
 	int min_key_size = hcon->hdev->min_enc_key_size;
 
@@ -1591,6 +1596,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 		min_key_size = 16;
 
 	return (!test_bit(HCI_CONN_ENCRYPT, hcon->flags) ||
+		test_bit(HCI_CONN_OPP_ENCRYPT, hcon->flags) ||
 		hcon->enc_key_size >= min_key_size);
 }
 
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index f30cffa94fbf..4fa6d93638c4 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -94,6 +94,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U8(hdt_def_mic_len);
 		HDEV_PARAM_U8(hdt_def_format);
 		HDEV_PARAM_U16(hdt_def_rates);
+		HDEV_PARAM_U8(eks_oppt);
 	} __packed rp = {
 		TLV_SET_U16(0x0000, def_page_scan_type),
 		TLV_SET_U16(0x0001, def_page_scan_int),
@@ -131,6 +132,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		TLV_SET_U8(0x0021, hdt_def_mic_len),
 		TLV_SET_U8(0x0022, hdt_def_format),
 		TLV_SET_U16(0x0023, hdt_def_rates),
+		TLV_SET_U8(0x0024, eks_oppt),
 	};
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -151,6 +153,19 @@ static int set_hdt_params_sync(struct hci_dev *hdev, void *data)
 	return hci_le_set_hdt_params_sync(hdev);
 }
 
+static int set_eks_oppt_sync(struct hci_dev *hdev, void *data)
+{
+	int err;
+
+	/* The controller doesn't allow it while there are connections */
+	err = hci_le_set_eks_oppt_sync(hdev);
+	if (err)
+		bt_dev_warn(hdev, "unable to set opportunistic encryption: %d",
+			    err);
+
+	return err;
+}
+
 int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 data_len)
 {
@@ -159,6 +174,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 	u8 old_mic_len = hdev->hdt_def_mic_len;
 	u8 old_format = hdev->hdt_def_format;
 	u16 old_rates = hdev->hdt_def_rates;
+	bool old_eks_oppt = hdev->eks_oppt;
 
 	if (buffer_left < sizeof(struct mgmt_tlv)) {
 		return mgmt_cmd_status(sk, hdev->id,
@@ -221,6 +237,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001f:
 		case 0x0021:
 		case 0x0022:
+		case 0x0024:
 			exp_type_len = sizeof(u8);
 			break;
 		case 0x0020:
@@ -361,6 +378,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0023:
 			hdev->hdt_def_rates = TLV_GET_LE16(buffer);
 			break;
+		case 0x0024:
+			hdev->eks_oppt = !!TLV_GET_U8(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
@@ -377,6 +397,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 	     hdev->hdt_def_rates != old_rates))
 		hci_cmd_sync_queue(hdev, set_hdt_params_sync, NULL, NULL);
 
+	if (test_bit(HCI_UP, &hdev->flags) && hdev->eks_oppt != old_eks_oppt)
+		hci_cmd_sync_queue(hdev, set_eks_oppt_sync, NULL, NULL);
+
 	return mgmt_cmd_complete(sk, hdev->id,
 				 MGMT_OP_SET_DEF_SYSTEM_CONFIG, 0, NULL, 0);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index dce5ad7b3b6b..f7c2027cd4bd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2464,6 +2464,29 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	return ret;
 }
 
+bool smp_pairing_in_progress(struct hci_conn *hcon)
+{
+	struct l2cap_conn *conn;
+	struct l2cap_chan *chan;
+	bool pending;
+
+	lockdep_assert_held(&hcon->hdev->lock);
+
+	conn = hcon->l2cap_data;
+	if (!conn)
+		return false;
+
+	chan = conn->smp;
+	if (!chan)
+		return false;
+
+	l2cap_chan_lock(chan);
+	pending = !!chan->data;
+	l2cap_chan_unlock(chan);
+
+	return pending;
+}
+
 int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				  u8 addr_type)
 {
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index c86c46389007..0537762e2775 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -185,6 +185,8 @@ int smp_cancel_and_remove_pairing(struct hci_dev *hdev, bdaddr_t *bdaddr,
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
 			     enum smp_key_pref key_pref);
 int smp_conn_security(struct hci_conn *hcon, __u8 sec_level);
+bool smp_pairing_in_progress(struct hci_conn *hcon)
+	__must_hold(&hcon->hdev->lock);
 int smp_user_confirm_reply(struct hci_conn *conn, u16 mgmt_op, __le32 passkey)
 	__must_hold(&conn->hdev->lock);
 
-- 
2.56.0

