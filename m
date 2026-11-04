Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817395;
	b=IRw/t0BDkWhDnk9QNE6DS8dDU0/0oyoPb6wb3GWVeXpXL0nn6azfj7FJZC5GYttndD2v
	 9DpwKZJ0C/J8hHPR35dMIXUCeSTby3oaBrex+cZVR4Xwp3PDnrI6HAuqkYBSLXSPnSDVa
	 VF6mgOZH+FgIS8BHrQxz6Lg0BShJW/K7YeomNOf+01z+7Z6uk7prJN58SpG4mytdTBDbX
	 +trmgxQZ9d9yBWwwsVAXEeryyPJ6zxjvAHdReiOXsiDLZaDB1wRHP329G9DxVn5AEUXPb
	 YfoYBrxIdL2k9dWD+LI2j8o2xkScMDvG5cJdWxD+MglCvXYASZ6rN1ssVBpvMvNFupQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n7CMQsT6sePx8VnNTz+/FrMLL41O0i87P5g6dRzW1pY=;
	b=h2KFZBuaEhvjeChC/Cu56a0jt4Nfi/Jk6PTVUmkt1o8Znl+HrK6vRQGX0q6JkexiSNEC
	 MXKl1J5tY5QCbE2TdyG8s3TLO2fTETPG0FLwc96NZNvuXeqs5OscXCKP0xrr1wD8EmzHT
	 z5oivEawHMFOLuKE4pbi6yySZOrRlTwMKeFK0JNh9SlsuebF72nTGOntW5pe5/xfi7G7N
	 ecYXBAjqgDDF4Zw0+NvJfKtuiEjb74GUFHkYN/ASKOcoR+GI6Fo2K0+WxV/92ACzf88Pq
	 rcOxCZAzBLdQt5APwk+bVUhtEmKrYSjWnCeL3sQz1LLmxIJrhIVOS62uRFhNuVlyssQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KydTrRaH;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B69606A32F
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B69606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KydTrRaH
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso642805137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817394; x=1794422194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n7CMQsT6sePx8VnNTz+/FrMLL41O0i87P5g6dRzW1pY=;
        b=KydTrRaHZIFXjPINnuFt2XGeYKe0w2PLjsrB+cL8vwt1e7yf2HU3tdmQbLtm4B/0pV
         JjkyQZpXLoIuIGzCUyGyw2VvCmVU1/iiybvvdlInf3BIFk0P3wCLI11dKgMk+sTHarJs
         n+mJxmJx8/ufQ2/KsSpW3iwnjLrCrEtEPC/uFupctTtbDnsXXd0NsGMy0GHd0Ha0JNNb
         VT8WgKy7F/1Dmygsa5Ay04WdweNk163D/31wWP+r2WLNQVb3cFZN4H86f/ak+ap/kSde
         iqk3mojwL9P+PJl5trcM8NBCtxFZY7X+StmpRu4hxZwQ26nn2B4TY1+wFuc6Fgn3khuN
         H1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817394; x=1794422194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n7CMQsT6sePx8VnNTz+/FrMLL41O0i87P5g6dRzW1pY=;
        b=lP1hki0+SsjAzRiwlyl2ju88bEdn/xAlS+s/wUJtbd9B5mVnOWcfRfJYjINdZhkvWs
         QscIMUrMKAzJO6bnmRseErU5ZTrNhWeEbh0UUwFQoJea3fd8i1eJjQm38ZvfmHnRBsHE
         XEsVvIO2l+FzH596BsMKahjPGp51p9lU9MYbdrweoXVWs/ORSQdGmg16DkyQPVFS4bFh
         +bkKjBOxCWxuy5PN0UwUDS2kdHdsqc+qlvrKSPI28+k474e8I3Y2lErxSS8IbqCvICtQ
         bOd+JYDv6QvNP+SwBSsu/ws3bLF2ucThQoGTam8fN/NE+usgFj2NQKOV3Gl/RkWWyBMk
         FA1g==
X-Gm-Message-State: APuU4Z9DGQzcyd2WIoMjdqZwTxe3oTC5geKfGd7P2NepIBYIeervdcAD
	9VHhuwVns7x7vXPLKh/e+8tHCwk3HJPUM7RdAfEBTCczJJHfaYqE1Bi+nKW/vw==
X-Gm-Gg: AYBFou2g+8eCtO2KdyFudOvs5bDJEaXAAkBhmPTgtggrhYMSnpOBlYtZANAjNgZ+PnS
	Dfeu5k5McYeGuZTJ7eTk1JWnX+UhZevOCKvGlCTwRNtNClVuk7ztn/4rKDWR9VHfOANl5Ho6oM2
	pMbKHsM0r8vTmNgSg7pgSJYhBKfiatLYxjFbuUKt09jQXiF9eaUQEdB0RVYXWej95QfjqXK9QUK
	xOPhnMCvXple0BzR7oh1rJXSlckPYb/vPAl/nKmysXKNmKy+L2McrK/oLLMx37VDdVXpUbm6nIX
	7klt6yowVwPdwYgrEFcnxq1QEl9qJjC6PyHk0yBQxUJhFZJMRMlr/tAxSr+9BmmwsL+INibTNKS
	G+7zW3pnx3IyC7mMfv4O5bYOmo9OyDOcsTSXs6nvnohrDwepEK/TgMb6vYKFLLItsRIHNqPeEYX
	L9t1vvLnMevU927n7dZaDit5sQK/6opHtlJhC4/fpQC2qpD9U+z6zm0Ot0FrTNPDywyqqLlzz6c
	E3CYYWLaeaeMBNKoG+YpoMkrGEieQKyGMOx7sbRC6P6wMemh39wsU6sPqurCfcJbnVX96De6ivy
	xPteK4EWGU1ju1nhZYAzNkCk/8RzwBSmWKKsPfk0A0fLlxbfmGjOb4I1RUXfieFzdKRIgb2hlzu
	T8mCtckQnmH07GynbyKNnisetJ+7rhRoxqIY1g1TFimhaEK7KOflta3MHicJ5G3VwuG3e9sT4Ll
	X99A3cO8rexM4kchibSqwOI+nh
X-Received: by 2002:a05:6102:5811:b0:7b4:879c:bb8d with SMTP id ada2fe7eead31-7d0727b10fdmr7221183137.37.1793817393958;
        Wed, 04 Nov 2026 10:36:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d9a9ca31sm2509812241.10.2026.11.04.10.36.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] Bluetooth: Add EKS Opportunistic Encryption support
Date: Wed,  4 Nov 2026 13:36:26 -0500
Message-ID: <20261104183626.838825-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104183626.838825-1-luiz.dentz@gmail.com>
References: <20261104183626.838825-1-luiz.dentz@gmail.com>
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
   sent, so it is skipped if the link is gone, already encrypted or SMP
   pairing has started in the meantime, since encrypting the link under
   SMP would break the pairing.
 - An opportunistically encrypted link is marked as encrypted, so a
   later pairing over it completes, but does not raise the security
   level, as it is not authenticated.
 - The feature can be turned off with the MGMT system configuration TLV
   0x0024; it is on by default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |   5 ++
 include/net/bluetooth/hci_sync.h |   1 +
 net/bluetooth/hci_core.c         |   1 +
 net/bluetooth/hci_event.c        |  12 ++++
 net/bluetooth/hci_sync.c         | 100 ++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_config.c      |   6 ++
 net/bluetooth/smp.c              |  23 +++++++
 net/bluetooth/smp.h              |   2 +
 9 files changed, 150 insertions(+), 1 deletion(-)

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
index d05ef2cd413f..4c9b147ab5f9 100644
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
@@ -2191,6 +2192,10 @@ static inline __u8 hci_conn_mic_len(struct hci_conn *conn)
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
index e4e220ed098b..b507c6dfe3cd 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -202,3 +202,4 @@ int hci_le_set_hdt_params_sync(struct hci_dev *hdev);
 
 int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
 			  __u8 ltk[16], __u8 key_size);
+int hci_le_eks_oppt_encrypt(struct hci_conn *conn);
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
index e10a1a27061a..159003571519 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3917,6 +3917,16 @@ static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* Opportunistic encryption (eks_mode 0x02) encrypts the link without
+	 * a key from pairing, so the host doesn't treat the link as encrypted:
+	 * the key size is 0, and with HCI_CONN_ENCRYPT set the key size check
+	 * would refuse every L2CAP channel.
+	 */
+	if (ev->eks_mode == 0x02) {
+		clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags);
+		goto unlock;
+	}
+
 	hci_change_encrypt(conn, ev->status, ev->mode, ev->mic_len);
 
 unlock:
@@ -7924,6 +7934,8 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 			conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 			conn->le_rx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 		}
+
+		hci_le_eks_oppt_encrypt(conn);
 	}
 
 	if (conn->state == BT_CONFIG) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ad150a79df4c..4cc81cddf2af 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5052,9 +5052,18 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
 			return err;
 	}
 
-	if (le_sci_capable(hdev))
+	if (le_sci_capable(hdev)) {
 		/* Shorter Connection Intervals (Host Support) */
 		err = hci_le_set_host_feature_sync(hdev, 73, 0x01);
+		if (err)
+			return err;
+	}
+
+	if (eks_capable(hdev))
+		/* Opportunistic Encryption (Host Support) */
+		err = hci_le_set_host_feature_sync(hdev, 90,
+						   (hdev->eks_oppt ? 0x01 :
+						    0x00));
 
 	return err;
 }
@@ -8734,3 +8743,92 @@ int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
 
 	return err;
 }
+
+/* The opportunistic encryption is queued when the connection is set up, so
+ * by the time it runs the connection may be gone, already encrypted or in
+ * the middle of SMP pairing. Starting it under pairing would encrypt the
+ * link while SMP is still exchanging PDUs and break the pairing, so check
+ * again right before sending the command and leave the link to SMP.
+ */
+static int hci_le_eks_oppt_encrypt_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_enable_encrypt_v2 *cp = data;
+	struct hci_conn *conn;
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, le16_to_cpu(cp->handle));
+	if (!conn || conn->state != BT_CONNECTED ||
+	    test_bit(HCI_CONN_ENCRYPT, conn->flags))
+		goto unlock;
+
+	lockdep_assert_held(&conn->hdev->lock);
+
+	if (smp_pairing_in_progress(conn)) {
+		bt_dev_dbg(hdev, "SMP in progress, skipping hcon %p", conn);
+		goto unlock;
+	}
+
+	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, conn->flags))
+		goto unlock;
+
+	bt_dev_dbg(hdev, "starting EKS opportunistic encryption hcon %p", conn);
+
+	hci_dev_unlock(hdev);
+
+	return hci_le_enable_encrypt_v2_sync(hdev, data);
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
+	    test_bit(HCI_CONN_ENCRYPT_PEND, conn->flags))
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
+	cp->mic_len = conn->req_mic_len ? conn->req_mic_len :
+					  hdev->hdt_def_mic_len;
+	cp->encryption = 0x01; /* Opportunistic with EKS */
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_eks_oppt_encrypt_sync, cp,
+				      le_enable_encrypt_complete);
+	if (err)
+		kfree(cp);
+
+	return err;
+}
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index f30cffa94fbf..f8e6b4fe0a6a 100644
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
@@ -221,6 +223,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001f:
 		case 0x0021:
 		case 0x0022:
+		case 0x0024:
 			exp_type_len = sizeof(u8);
 			break;
 		case 0x0020:
@@ -361,6 +364,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0023:
 			hdev->hdt_def_rates = TLV_GET_LE16(buffer);
 			break;
+		case 0x0024:
+			hdev->eks_oppt = !!TLV_GET_U8(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f2c6376adca6..15f8af3e0fc9 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2454,6 +2454,29 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
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

