Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744374;
	b=3zq4IR50JNzM7WF2ALdYKS+MQTwJiurfrphYn+pg3bAn0db9hFrt+mt4555QKOcBBKCk
	 wAMwEOLsXAPVDSbgaqbwUUcUOiOpry1akUnypjtJ4Q6CE/3E2RNBVwZ5ruEwmvRDwYPSZ
	 bg1fkWcEcrjKmrxKNHsGWC5VdDYzIr2or4JCS0RG9jbv7Qwj7xkVagaHA+Wu+VFzwPe4L
	 Rw8nOGzXi9DoBeWA9F28r3+X3PBgok/W8WPg5feF5waxGb41ALSoTUO0dGt0oikwC87u9
	 1/qMFRxko98teuh8LgPG18v2P199pya9PEL/ywe/CSjzmltHy+yVS20g209JcV8oGrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eak4ns6Vfalhrwe/bya5uzFh8oPUfeNavCQK7puxZdw=;
	b=CzcPPaNYajeDlRVCcLAyAwu1V5xUs56qNFmT99wgRiCNXI8kVaPH6zlIOmWNGSMcWAIU
	 iNTRF+asDGj0N/FF5WM/sr5c01kLJHSZAhrP4jHkZsDJ5GYAULUFlaV5kPY3z6TybZwK8
	 5FXbAoe1rc9tN9nFjweHuquKTSEsorCUYQm3Ui2S9Ulyszqk0EQWxpzVyG9hQ6wYDnjwt
	 s/5th777BLH1HTV1TtIj0fDdmdcXbKpksBVNTPWy8cdXq0HgR1sqnyVi4+L1+6/S6K69H
	 UK5UpOw2x4sdWAZgSaNw0/QQGkrKBTvNe8Jxno8HX4NV/UuThp6o376A9Qn5dPaDsdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4PbYrBs;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F2606A329
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A4F2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4PbYrBs
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so13510e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744373; x=1794349173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eak4ns6Vfalhrwe/bya5uzFh8oPUfeNavCQK7puxZdw=;
        b=P4PbYrBsSuKST1m58+Focj5KdfO1N5lG6KjCi/waP3SMAZuJmYlorfU8RLlv5657F3
         rGS1oYpcMJrymt66OU0SGGq62/uxS8asDCWynGyPMdJLhTzFx4JU9GCEBvVqFY/Yb40u
         GfVioeTWAHikeCx5uRssKHm6R8CU6voJLJ7eJ/wiDeijSFBIy1KLDx77eAqZhGT4nl5O
         Iplo2erOl1sg9hrjmcM3qaP1j5M5iYAXhs2YUyeE9KV/VridiJD0KhzAui9f6YIZiqwT
         moVfS5dYDPdMHjWSaa4sa1lx3WV3SseOmU4rJ+J6fRA+Nl1HtTUXcsdq0EJJ176ncWRb
         7IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744373; x=1794349173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eak4ns6Vfalhrwe/bya5uzFh8oPUfeNavCQK7puxZdw=;
        b=lKQ9/RxSyb+mlvfuHtFmHO4f/w4um11nx04JS/mUvKF0ftXtf+GIkUYRgWwSOrMCs8
         8czOeT8o/45/xKVbwSK0sraQCaS0S12eLx4PL/tnMLQa+krDRJFVQej4kymRoBKgYMGg
         uipIKQA4z7EV7vDDAimQNBa45+RrQkqxH3N8pjkbUMVZ4X6xHUX1zu0OPsAJFUWi1Gfn
         Oz/kJaZvFGullLyFLeM72AUtLFL/rAz0rYDFQs8v7gJvUjh+GsHIg54vRU5Y2eo0taWW
         OBAFo7QANegUzS6BU7F+BAC2mdQQ9lVwugENzAxmRNh91GDSiOYvHOBBojPbsesUZU2v
         uk6g==
X-Gm-Message-State: APuU4Z9jQOutHp2GEKjDs3tff1X0tA1LH5C1eppHuU7YAvFHinQZAILt
	MNhzaEG/o8bGfKGcr/ZNTEEr3Lxj2bTpQ2Y7guTmoKcD7g0uUAVacJZa0fFbCw==
X-Gm-Gg: AYBFou1jzZGIYsgIFlvszYiwaWBPmzaMQyJP/S8VnV/wjAbCfgXTU6rQ+DYnU/cVuCP
	RY9IU2SzNwGSnyuK8t0Xq+QmSkTTsOuIFh7ocIvxK6Qg9ayCol+oKxhPe2dumFtV4r2uXFzQFlb
	1qOROB1p6JXNooTIt0xBq2ZtQUYZkSVQ0YUrDCHTF7ZZheXC+CV/xl+ltAU7LjbyOx8G1FP/XC7
	/VIrVjjJMIEK4qdSvHZkej4kg3PWZf9Ft6+zzYKEI1v9Ew/CI3q31a8W/O5OzMfONFuUdzFmfft
	s6uVcAnGyVZgjthQBbHvP8uq4GaDFzQol0ifyUIFjfED7D6omII2Rn5MOVFP0KZDoKKbpyZZC+9
	/PUxy2817rSli0qKyoZ1aViF57OWfhtlil9btIv7d2VJO7B+7Pz12CsYRBqUeNfQul/zYTCjS9b
	dIaTBWyxIcztfPgdWcwL9AqJ0Tr/Kdo38OO3kIqXLC0Er86eIxYIYO03LZNS9PzYAOuwGhEqN7W
	c/UhJL/+UXsQtOy+52DZsYf3/L2wxz0KqgAsNPf3FOKVJ9K22jbb8cFCTZdOWV0izT9E/lfGe+v
	Xd7z0hGMh6oLv9eIvtpoYzNUTEVvrotnfu4jiy/DeqpSWbXDQ5uX27zLqaMcb7uVFOlRuQx9QlT
	7lotxsvDG8R2+OftaktxYpWOSOWbK5PCJ3oM8ZeBJVwegt9Szjoee9A8cmqNumybV/hAGJ9YPbf
	KPmYQ=
X-Received: by 2002:a05:6102:2c0f:b0:7cc:25bc:3b30 with SMTP id ada2fe7eead31-7d0726b97b9mr6037284137.21.1793744373230;
        Tue, 03 Nov 2026 14:19:33 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm306572137.11.2026.11.03.14.19.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:32 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 6/6] Bluetooth: Add EKS Opportunistic Encryption support
Date: Tue,  3 Nov 2026 17:19:21 -0500
Message-ID: <20261103221921.4071765-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221921.4071765-1-luiz.dentz@gmail.com>
References: <20261103221921.4071765-1-luiz.dentz@gmail.com>
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
 - An opportunistically encrypted link does not raise the security
   level, as it is not authenticated.
 - The feature can be turned off with the MGMT system configuration TLV
   0x0024; it is on by default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  5 ++
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_event.c        |  7 ++-
 net/bluetooth/hci_sync.c         | 92 +++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_config.c      |  5 ++
 net/bluetooth/smp.c              | 23 ++++++++
 net/bluetooth/smp.h              |  2 +
 9 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index af8a20682e31..bcd2f5aa1987 100644
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
index def547e1b7f1..fe43a968eabe 100644
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
@@ -2196,6 +2197,10 @@ static inline __u8 hci_conn_mic_len(struct hci_conn *conn)
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
index 4b5baee9ce11..5f74af68730b 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -200,3 +200,4 @@ int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_v2 *qos,
 
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
index be8b480e6ab7..4037ee6cf885 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3732,7 +3732,6 @@ static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt,
 
 	if (!status) {
 		if (encrypt) {
-			/* Encryption implies authentication */
 			set_bit(HCI_CONN_AUTH, conn->flags);
 			set_bit(HCI_CONN_ENCRYPT, conn->flags);
 			conn->sec_level = conn->pending_sec_level;
@@ -3881,6 +3880,10 @@ static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* EKS Opportunistic (eks_mode 0x02) provides no security change */
+	if (ev->eks_mode == 0x02)
+		goto unlock;
+
 	hci_change_encrypt(conn, ev->status, ev->mode, ev->key_size,
 			   ev->mic_len);
 
@@ -7867,6 +7870,8 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 			conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 			conn->le_rx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 		}
+
+		hci_le_eks_oppt_encrypt(conn);
 	}
 
 	if (conn->state == BT_CONFIG) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b2b1a553e7c2..b03c09466f8b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5053,9 +5053,18 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
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
@@ -8714,3 +8723,84 @@ int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
 	return hci_cmd_sync_queue_once(hdev, hci_le_enable_encrypt_sync, cp,
 				       le_enable_encrypt_complete);
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
+	/* Must support encrypt_v2 command */
+	if (!(hdev->commands[50] & BIT(4)))
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
+	cp->mic_len = conn->mic_len ? conn->mic_len : hdev->hdt_def_mic_len;
+	cp->encryption = 0x01; /* Opportunistic with EKS */
+
+	return hci_cmd_sync_queue_once(hdev, hci_le_eks_oppt_encrypt_sync, cp,
+				       le_enable_encrypt_complete);
+}
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index f5b37b0cd975..1b9b823355b4 100644
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
@@ -372,6 +374,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
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
index 0dc236cd4d1c..112100e790cd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2444,6 +2444,29 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
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

