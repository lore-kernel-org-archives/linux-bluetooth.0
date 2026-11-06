Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002269;
	b=I1UazhoAelzjUqk/0k/oMooZVoy0WELjMyY2DGvl7Om1+8FSgyHy3AXC/hbpWsRak/rd
	 JwzLS3uwUw/3jrq5w7RMIRJx7OB7LLFnxpv/Qzl2H+20Dx4x6i06f78t3zhXCzORrCAol
	 5bIATMOXpFPmt2DvyTsHLsViyTySrJrjZH5rSYRvdRHHUbfbZFZ3Qflj1WVgvWeXwrT9F
	 DvabviETjHXy1qhFKCjHKHuu4dZe1lMkGljKcU+AT9LrVPEPjfCAGgvNx/aLE+nchHICN
	 c/ydtLTXaRIK3coExZySbbSWb6xN7MsKrqpiQkCxqTJFdO6KTNROKo+fBUpWoWwNm9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S83qklXvYX43tN3xRJ60Ae7bwlGMnJo5ufvKoVhxcSk=;
	b=DgxyM5+MrhEUxoz00DU1hCUx9sje8WeW9YZ1q1oXYNo+jmxn/OLPxO05yqjHBe0cCHVs
	 WX2mkya4oLVIreRqlei7E3N+bGBLUtkZlxKSrQGy0qxp8e/vIg0cgKr3PukkJhj46d32v
	 pp1kgSZ3RV0a+GiGmqm2PTsLUtUxf4Ss2ZfgS28D6u2yullakF5kB/U4dnDPtG3DLIcDn
	 VWDx7QDHLozs+FIlMJhY86kzTLQuZO0QSWSAXxbFqbIj5nLrFlNxA+mhzm6a/cD7dPbp4
	 Q/fFd2xQtj60l8u1Lewn7GqL4VcI3COeVU6vJOleaRI3oA0xpypOQNkAvwi32vTswvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IIhOu0nd;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3D606EE94
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 21:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F3D606EE94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IIhOu0nd
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso80902e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 13:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794002268; x=1794607068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S83qklXvYX43tN3xRJ60Ae7bwlGMnJo5ufvKoVhxcSk=;
        b=IIhOu0ndDLLSK0kQxQsOcAATgJb1T9OFfsBa1t+6ztARc9/hgziIds9f7N+Qjlqb8Q
         d6uWeI7ZEUup/btRn88aVb1dG2/Fx2gTVUaEQ3WmjQOIpi8UXUSCx1LejXEIibkYGzqm
         GhELXb4FPyNMTmKyVgj7Hqc9nlCEYwojuu7mCWGyp7OoGgND8Cpy3Be7YrOcMKSN+2me
         1irwaLshsMYveXpnmj8NwQxg7gABlvpm4KWzbj3xVp9vkyYV4jqKjPpb7x6hxrf2qbY6
         4Pn/9Ymm4lyyAAu/atShbTskhQbV6AQ9xwAAGfiauzaBq1vKILimg9IUKVM9V4w3NecB
         GKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794002268; x=1794607068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S83qklXvYX43tN3xRJ60Ae7bwlGMnJo5ufvKoVhxcSk=;
        b=G3jTLd/nC2w0/6yw6ho9sUy30QpHAHdWWEfymarsapi43TIHLN4jtZCemid29WGIoJ
         IsjTsFTLvnPszhbM4SpDrwhjbZ/gZ/FJeP7NW55gg9vIDKKa6l1ucpPPW8kWMy73eHSP
         L4PpoOgxcj4rcLrUAaJaBR7raup/LSxfaX4p5qb6pci4z8hyfHZfkDQeca1sVij6rqJa
         LVMK+MCkhTdSjHg4g7zWWvAdPrBTp3lc3jti9fyoWx8iE185cc1VxAdTYhe/bS9jY1ei
         4Syrmf0NV0IgXDTC/usaDXKJV43YRH9MD+JlyIotHvH3iFXTHrGbX0iL5TNeD6eNAu2A
         1JhQ==
X-Gm-Message-State: APuU4Z8KvNRyJODSANKIe2HvXOTyPixmN/49/Ov8tKBpicRYckgg3frx
	ShMUTdoOJL5Qg0qkVVd//j3qBtxNUX4Ug9G6IW9Fva/Xjj7RWMXfIrJ6GVZvtw==
X-Gm-Gg: AYBFou0tEf6YZlqTj4Nbm+2rag4OEW/Nw7W3IwgHe/ud8qjI9llTrniL49Tit8vPaOA
	T5EhzLUbsUXlktmLRoBIbU2VD+8g5QjC6mkx29PvFXgqUGGBedGSdYOwt/306qVSVGMS4oDFwMh
	9YCST7atcZ1m0bTcaLnYbrFInf2UgKmQ9zEwwKDrBkUQnEImWhe1XxNyT1mGCX7eUkOdMiTsCmQ
	0fgzg13HKcQ8BogL525HRy44VhK04nt0A8Rat8nDVlxnZpjUSS353SCajZXKqqeGIab+zzajFJb
	MYLPbbqF5GsmeAn8uBymYLdFbpGmTWA2+UMQIvVDcRYqGXEeo3iSwzt7tuCu6NTcBHGpd4Yqa5P
	sJMswFRdT1rDCokz2/u5po6rkYAFo8UVlYcEp+TqNMrYSZ5XBOV+AmUNs/5RgnrnWrL3Vv8nlyZ
	5YT2x1pdXoESpFA5jxNNOGoZOwXwYFZMAG5s7+ehoYuPZs2xRXmKW/V6utA596nanXv28dQa7p+
	JTRr/nezngo4QJbkeJOX2C4Rbjb+bqylN8uhizy0J6B6yphJ2FHELj2mCxyvqbBxTwY07hNzJ4m
	lZG1hMyChoLypUa3W/UEV8SGgQDmHGPWuZDhZi8EgvzkvB3VvMKBXOLq1RAsstec9gk4YvSOyh6
	jYo/ktGqBEhH1mtSi/X4mFJ9ehJgfEYnKig0C61AGDKvwDeWuXtg2O2XnOnraNx5oANAC/PaAZG
	Yptt4=
X-Received: by 2002:a05:6122:1dac:b0:5ea:aedd:6077 with SMTP id 71dfb90a1353d-5ecd1b5db23mr97668e0c.5.1794002267589;
        Fri, 06 Nov 2026 13:57:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6103sm2542570e0c.6.2026.11.06.13.57.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:57:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 6/6] Bluetooth: Add EKS Opportunistic Encryption support
Date: Fri,  6 Nov 2026 16:57:38 -0500
Message-ID: <20261106215738.3562688-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106215738.3562688-1-luiz.dentz@gmail.com>
References: <20261106215738.3562688-1-luiz.dentz@gmail.com>
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
   unencrypted, as it was. Since opportunistic encryption can only be
   started on an unencrypted link, reporting it for a link with a key
   from pairing is a downgrade, which disconnects the link. A failure on
   an opportunistically encrypted link is handled as for any encrypted
   link, without the encryption flags it had.
 - SMP only distributes keys once a key from pairing encrypts the link,
   not on opportunistic encryption.
 - HCI_CONN_ENCRYPT_PEND is not used for opportunistic encryption, so
   it doesn't block SMP. Pairing over such a link completes: the Key
   Refresh Complete of its key clears HCI_CONN_OPP_ENCRYPT and is
   handled as Encryption Change is for an unencrypted link.
 - A Key Refresh Complete reporting opportunistic encryption, such as
   one changing the MIC length, keeps the link opportunistically
   encrypted. Opportunistic encryption can only be started on an
   unencrypted link, so on a link with a key from pairing it would be a
   downgrade, which disconnects the link.
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
 net/bluetooth/hci_event.c        | 127 ++++++++++++++++++++++++++-
 net/bluetooth/hci_sync.c         | 145 ++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_core.c       |   7 ++
 net/bluetooth/mgmt_config.c      |  26 ++++++
 net/bluetooth/smp.c              |  29 ++++++-
 net/bluetooth/smp.h              |   2 +
 10 files changed, 338 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5edde8a6cc2d..efb85c781e4e 100644
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
index e2a79ea5b6bc..967b89c31774 100644
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
@@ -2198,6 +2200,10 @@ static inline __u8 hci_conn_mic_len(struct hci_conn *conn)
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
index 3e6a0e9f66fc..c4f7f0e22ed0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3107,12 +3107,18 @@ static void hci_cs_le_enable_encrypt_v2(struct hci_dev *hdev, u8 status)
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
@@ -3943,6 +3949,74 @@ static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.24:
+	 *
+	 * When the Encryption_Type parameter is set to 0x01 (use
+	 * opportunistic encryption with Encryption Key Schedule), the
+	 * command shall be only used for unencrypted connections
+	 *
+	 * So on a link with a key from pairing it would be a downgrade.
+	 */
+	if (ev->eks_mode == 0x02 && test_bit(HCI_CONN_ENCRYPT, conn->flags) &&
+	    !test_bit(HCI_CONN_OPP_ENCRYPT, conn->flags)) {
+		bt_dev_err(hdev, "opportunistic encryption of hcon %p", conn);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		goto unlock;
+	}
+
+	if (ev->status || !ev->mode) {
+		if (test_and_clear_bit(HCI_CONN_OPP_ENCRYPT, conn->flags)) {
+			/* BLUETOOTH CORE SPECIFICATION Version 7.0 |
+			 * Vol 4, Part E, Section 7.7.8:
+			 *
+			 * When encryption is enabled for LE, the
+			 * Key_Schedule_Enabled parameter indicates whether
+			 * Encryption Key Schedule based encryption is used.
+			 *
+			 * So a failure doesn't report it, and one while
+			 * opportunistic encryption is being started is its
+			 * own: the link is just left unencrypted, as it was.
+			 */
+			if (!test_bit(HCI_CONN_ENCRYPT, conn->flags))
+				goto unlock;
+
+			/* Otherwise the opportunistic encryption is lost */
+			clear_bit(HCI_CONN_ENCRYPT, conn->flags);
+			clear_bit(HCI_CONN_AES_CCM, conn->flags);
+		}
+
+		/* Nothing to validate, so no key size */
+		hci_change_encrypt(conn, ev->status, ev->mode, 0x00,
+				   ev->mic_len);
+		goto unlock;
+	}
+
+	/* Opportunistic encryption (eks_mode 0x02), started by this side or
+	 * by the remote, encrypts the link without a key from pairing: it is
+	 * marked with HCI_CONN_OPP_ENCRYPT and has no key size.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 3, Part C,
+	 * Section 10.3.3:
+	 *
+	 * If opportunistic encryption is used to encrypt the link and
+	 * encryption is required, then the service request shall be
+	 * rejected with the error code "Insufficient Encryption".
+	 *
+	 * So it doesn't change the security level, which stays as if the
+	 * link were unencrypted.
+	 */
+	if (ev->eks_mode == 0x02) {
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
 	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
 	 * Section 7.7.8:
 	 *
@@ -5747,6 +5821,51 @@ static void hci_key_refresh_complete_v2_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.24:
+	 *
+	 * When the Encryption_Type parameter is set to 0x01 (use
+	 * opportunistic encryption with Encryption Key Schedule), the
+	 * command shall be only used for unencrypted connections
+	 * ...
+	 * The MIC length to be used for LE HDT PHY may be overridden by a
+	 * later HCI_Refresh_Encryption_Key command on the same connection.
+	 *
+	 * So a refresh reporting it, such as one changing the MIC length,
+	 * keeps the link opportunistically encrypted, and on a link with a
+	 * key from pairing it would be a downgrade.
+	 */
+	if (ev->eks_mode == 0x02 &&
+	    !test_bit(HCI_CONN_OPP_ENCRYPT, conn->flags)) {
+		bt_dev_err(hdev, "opportunistic key refresh of hcon %p", conn);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		goto unlock;
+	}
+
+	/* A failure is handled below like any other */
+	if (ev->eks_mode == 0x02 && !ev->status) {
+		conn->mic_len = ev->mic_len;
+		goto unlock;
+	}
+
+	/* The key from pairing replacing the opportunistic one encrypts the
+	 * link as Encryption Change does for an unencrypted link.
+	 */
+	if (test_and_clear_bit(HCI_CONN_OPP_ENCRYPT, conn->flags)) {
+		/* On failure the link is disconnected, so don't report it
+		 * as still encrypted with the opportunistic key meanwhile.
+		 */
+		if (ev->status) {
+			clear_bit(HCI_CONN_ENCRYPT, conn->flags);
+			clear_bit(HCI_CONN_AES_CCM, conn->flags);
+		}
+
+		/* LE, so no key size */
+		hci_change_encrypt(conn, ev->status, ev->status ? 0x00 : 0x01,
+				   0x00, ev->mic_len);
+		goto unlock;
+	}
+
 	/* The key refresh may change the MIC length */
 	if (!ev->status)
 		conn->mic_len = ev->mic_len;
@@ -7982,6 +8101,8 @@ static void hci_le_read_all_remote_features_evt(struct hci_dev *hdev,
 			conn->le_tx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 			conn->le_rx_def_phys &= ~HCI_LE_SET_PHY_HDT;
 		}
+
+		hci_le_eks_oppt_encrypt(conn);
 	}
 
 	if (conn->state == BT_CONFIG) {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1810a8a48344..0a574e17426e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5043,6 +5043,16 @@ static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
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
@@ -5063,11 +5073,14 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
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
@@ -8699,6 +8712,13 @@ static void le_enable_encrypt_failed(struct hci_dev *hdev, __le16 handle)
 	hci_conn_put(conn);
 }
 
+static int hci_le_enable_encrypt_v2_send(struct hci_dev *hdev,
+					 struct hci_cp_le_enable_encrypt_v2 *cp)
+{
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_ENABLE_ENCRYPT_V2,
+				     sizeof(*cp), cp, HCI_CMD_TIMEOUT);
+}
+
 static int hci_le_enable_encrypt_v2_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_enable_encrypt_v2 *cp = data;
@@ -8718,8 +8738,7 @@ static int hci_le_enable_encrypt_v2_sync(struct hci_dev *hdev, void *data)
 
 	hci_dev_unlock(hdev);
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_ENABLE_ENCRYPT_V2,
-				    sizeof(*cp), cp, HCI_CMD_TIMEOUT);
+	err = hci_le_enable_encrypt_v2_send(hdev, cp);
 	if (err)
 		le_enable_encrypt_failed(hdev, cp->handle);
 
@@ -8802,3 +8821,121 @@ int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
 
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
+	/* conn->hdev is hdev, whose lock is held */
+	lockdep_assert_held(&conn->hdev->lock);
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
+	/* Sent without the failure handling of encryption started by SMP,
+	 * which isn't pending for it and must not be disconnected for it.
+	 */
+	err = hci_le_enable_encrypt_v2_send(hdev, cp);
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
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.24: "This command shall only be used when the local
+	 * device's role is Central."
+	 */
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
index d3b4153ee58e..783aada1edc2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1583,6 +1583,12 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 	 * This check might also be called for unencrypted connections
 	 * that have no key size requirements. Ensure that the link is
 	 * actually encrypted before enforcing a key size.
+	 *
+	 * Opportunistic encryption has no key from pairing, so there is no
+	 * key size to enforce. The security level stays as if the link were
+	 * unencrypted, see hci_encrypt_change_v3_evt(), so a channel
+	 * requiring more still needs pairing, which then replaces the
+	 * opportunistic key.
 	 */
 	int min_key_size = hcon->hdev->min_enc_key_size;
 
@@ -1591,6 +1597,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
 		min_key_size = 16;
 
 	return (!test_bit(HCI_CONN_ENCRYPT, hcon->flags) ||
+		test_bit(HCI_CONN_OPP_ENCRYPT, hcon->flags) ||
 		hcon->enc_key_size >= min_key_size);
 }
 
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index f30cffa94fbf..c4e9c5abda31 100644
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
@@ -151,6 +153,22 @@ static int set_hdt_params_sync(struct hci_dev *hdev, void *data)
 	return hci_le_set_hdt_params_sync(hdev);
 }
 
+static int set_eks_oppt_sync(struct hci_dev *hdev, void *data)
+{
+	int err;
+
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.115: LE Set Host Feature fails with Command Disallowed
+	 * (0x0C) when "The Controller has a connection to another device."
+	 */
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
@@ -159,6 +177,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 	u8 old_mic_len = hdev->hdt_def_mic_len;
 	u8 old_format = hdev->hdt_def_format;
 	u16 old_rates = hdev->hdt_def_rates;
+	bool old_eks_oppt = hdev->eks_oppt;
 
 	if (buffer_left < sizeof(struct mgmt_tlv)) {
 		return mgmt_cmd_status(sk, hdev->id,
@@ -221,6 +240,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001f:
 		case 0x0021:
 		case 0x0022:
+		case 0x0024:
 			exp_type_len = sizeof(u8);
 			break;
 		case 0x0020:
@@ -361,6 +381,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0023:
 			hdev->hdt_def_rates = TLV_GET_LE16(buffer);
 			break;
+		case 0x0024:
+			hdev->eks_oppt = !!TLV_GET_U8(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
@@ -377,6 +400,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 	     hdev->hdt_def_rates != old_rates))
 		hci_cmd_sync_queue(hdev, set_hdt_params_sync, NULL, NULL);
 
+	if (test_bit(HCI_UP, &hdev->flags) && hdev->eks_oppt != old_eks_oppt)
+		hci_cmd_sync_queue(hdev, set_eks_oppt_sync, NULL, NULL);
+
 	return mgmt_cmd_complete(sk, hdev->id,
 				 MGMT_OP_SET_DEF_SYSTEM_CONFIG, 0, NULL, 0);
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 140b9813998b..b35093dfa40b 100644
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
@@ -3195,7 +3218,11 @@ static void smp_resume_cb(struct l2cap_chan *chan)
 	if (!smp)
 		return;
 
-	if (!test_bit(HCI_CONN_ENCRYPT, hcon->flags))
+	/* Opportunistic encryption doesn't use a key from pairing, so keys
+	 * are only distributed once the pairing encrypts the link.
+	 */
+	if (!test_bit(HCI_CONN_ENCRYPT, hcon->flags) ||
+	    test_bit(HCI_CONN_OPP_ENCRYPT, hcon->flags))
 		return;
 
 	cancel_delayed_work(&smp->security_timer);
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

