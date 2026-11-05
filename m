Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904296;
	b=JOx1ZQyf/xuRnVJWkGUyZ2srRo4Em2MxjiNi7mMOapRmnDydWNvCxQu0ER33POwj91Pc
	 A2KkKgGbdbsVXa4J4HQb5bdzC2y+gO79tKbO5V5QdNKWbNRBI6W+5ONXhDsFjcklKDL3Z
	 YfraetWOnLvY8ySyDJYxIILQWA0HtUaBD84vq0UWLgSNUDQ+ytSxE4fG4gL3SlXhb1vqy
	 FH4Fs/EVd7PWrPjrN0ZpeaSlsn19uSRWFDjTMPuO8YwJIX1wPEBrIM/rTLeLJWozmkFKS
	 5JOmALUPdCC+0JM2DPCD9S0eog9vn0XzBWiyCYUYSaBUqm8nHct4OpuvBexMKizmlcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RqKiTKDpZyrMwySy6o9CpKSYRFgd7lxKSCFs06+v0wY=;
	b=wGJgfBZ0GiV6SMraUdhDp5WIR4l8CNR6OCrcoLsBeMpvSw/TRwHwxyxJJKWZbjYSRNhD
	 utJ90aZXNapHUWg3mxshpzlYKp9LPLIAgi360ogAXcmkjVWxVlZiTm1zjJ4jwKRSc5Qw9
	 aBy8NhhefETJ2N4c47ALQfZj1kxnbav2V0Slo//k5E1DGmRutQGRJaVtROvmSM91HUslE
	 Pr0JfAqP0NHAFlX3tpTPpIcnku+3aupDv0ndD7GtG2LKOMvxwnfPH5+MJhyM25HDjoW56
	 uJwklm3lLRh/JRNrqXauJ3yB1s+6BoR0Ig5qxx/ImmKHlzIy1Lk2iTh3oj2haT95SJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouqa0ikY;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4B606D804
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 18:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC4B606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouqa0ikY
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-99075306daaso1162020241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 10:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904295; x=1794509095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RqKiTKDpZyrMwySy6o9CpKSYRFgd7lxKSCFs06+v0wY=;
        b=ouqa0ikYVODx4/FFG8QS5YJ2lHqD7sn7lT0PrXKYWebjtOEaEKM0JxDBaeFXTyLwc2
         W3M5Zqx6jU/FrC5CiIdDylcwFLwX/9NpzjEEv9YRC/kx7fLxJn8xlYC4zOmvmFuCFxBM
         RUEzE9ZnbrxmtaGC1GMU3c3Jaz3SFXPj/A+b8VeTl6rMXhASN8BCNW2hpCfGBa8ZDR1c
         AnhnpDjkDxSqPQ8XgdfHnVfWhOjKpLx1Ktlgz13eJXNt2AbPO0Mg6w09j+ZsijqkwbPb
         byKZJmq/5s+djqaKjsyXrGkeRm6OWJbBg19Vtqcfs8ua/MmYDPL9uRCXuqZyggLtJcPq
         wjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904295; x=1794509095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RqKiTKDpZyrMwySy6o9CpKSYRFgd7lxKSCFs06+v0wY=;
        b=RuOCsSXrvVrHK2ZF3hJJWzV9GrSuLqB4fxXAwVS/CT/g4W2kplMRxdb8quP7LIOtvW
         HhwxbVQFOHeLFqBtvGovThTWN2Kf6kstdRRtdasqHN6Vum3a3sLgMAN1FwrHvDn+cQ0I
         Bm62o0imuxa6Aj9ngwKVTJq06meW70RL7KGUCJFPXcVgobpgpEWmVOwZP17kDT4sEkdt
         EBvJ+8uPM7F8ZULHAXIu9KO1HIkZxyhpyNWOJTv+YaByZeQ5aVkxqvSkcsPi0vmpsawC
         cs6go3644gJOlyCfOhaOWx9t2GOzy7QPxrNTAPSpaFhjXQdh4AURcpngfi9/HSdhZrYH
         cOGw==
X-Gm-Message-State: APuU4Z8AU1UkoIHwAkBazW/kYQRXCNzUhnA5AOXGs/+azGi/+aFndxrZ
	yfy7aY1kCY/lbiO6Zk22Pn4llVXxpAqRNIJUwvLzJMenPijTc7TEluSxWTcYZA==
X-Gm-Gg: AYBFou0cqkQyujxCp0Jthq5y61JUTk2MPFyj6sav8Q5pMALv1ffC4sB04qd/+bf26J9
	inbd8rqYFJKA87Rl/WkVhwYnC+mJIDLpKq0Vrqm/tx8XGiL3r2YtHSud5hp2bcGWJ9VOMOdcXu4
	uV4uoVFWrwDLrEAX873+INQCzL5tczqqIQFbLUWaGAQmc0LSNihvCBbWSMUXRYgx5bFH5jei5GA
	oVpaYaFw4mql7GLvxYvvPsa01wFX8bFHhrX73GQV+7lnScOC3I21p5tl3fWADYttdmMzQbfkqTJ
	nAe/KkD7c60K2EO0jvtj3BGzTDOH3u/afU0VYp3ZRhKFRwnfIBVZelBqm8AcwbzSFR6k1vk0Y3v
	ikjbI6JR5UvUaW6hFcBKld1mcfQ0ahD/nxBWeBM86GW81nE6ZYNjwgAmyIlEHKgvaL/V/hUc5p5
	o5GZiyltaGeKuvihfHiW9kBp66EyejxLFIW0F8SOQzgPmLTsi3BoQBW/aipP5uQO20nbJdojdBk
	nZDXPfNHW/ePzB+nkFWRDs4Loh/bljFcb6YMeDTOqoLAjya6x0Poq/HHUSKCAS61gGd05Hq4jWc
	rAoGxz7yvUz7qst2SpfdFOszdgUFhVVD+9DBaUt1NLFWAowJ0J/EeNkzOo5wb88NS5WwVUQndFa
	+COdBSXnOJ3a1+YfBdMOJc6iOBgVI5MphgJz6aiffCCOyLmkQnCYCToKUAXX9xQZAedvKCcdrJt
	mAbnk=
X-Received: by 2002:a05:6102:6f08:b0:7d1:cf05:f2fc with SMTP id ada2fe7eead31-7d2a164d1d6mr341531137.27.1793904294600;
        Thu, 05 Nov 2026 10:44:54 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99baea8aeb0sm12182241.9.2026.11.05.10.44.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:44:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/6] Bluetooth: Add initial support for EKS
Date: Thu,  5 Nov 2026 13:44:46 -0500
Message-ID: <20261105184449.2149626-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105184449.2149626-1-luiz.dentz@gmail.com>
References: <20261105184449.2149626-1-luiz.dentz@gmail.com>
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

Add support for Encryption Key Schedule (EKS) introduced in Bluetooth
7.0:

 - LE Enable Encryption v2, which replaces LE Start Encryption on EKS
   capable controllers and carries the MIC length to use on the LE HDT
   PHY. SMP now starts encryption through hci_le_enable_encrypt(),
   which picks the version the controller supports, outside of the RCU
   read-side section since queueing the command may sleep. If it can't
   be queued SMP fails the pairing or doesn't consider the encryption
   started. A Command Status error disconnects the link as it does for
   LE Start Encryption, and so does a command that fails without one,
   such as one that couldn't be sent. The command, which carries the
   key, is freed with kfree_sensitive().
 - Encryption Change v3 and Encryption Key Refresh Complete v2, enabled
   through Event Mask Page 2, which report the MIC length and whether
   the key schedule is in use. The encryption change and key refresh
   handling is moved to helpers shared by every version of the events.
 - eks_capable() for the Encryption Key Schedule feature bit.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  30 +++++
 include/net/bluetooth/hci_core.h |   4 +-
 include/net/bluetooth/hci_sync.h |   3 +
 net/bluetooth/hci_conn.c         |  18 ---
 net/bluetooth/hci_event.c        | 211 ++++++++++++++++++++++---------
 net/bluetooth/hci_sync.c         | 124 ++++++++++++++++++
 net/bluetooth/smp.c              |  67 +++++++---
 7 files changed, 362 insertions(+), 95 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e60686cf978d..778c234385ce 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2564,6 +2564,16 @@ struct hci_rp_le_read_def_data_len_v2 {
 	__le16	tx_time;
 } __packed;
 
+#define HCI_OP_LE_ENABLE_ENCRYPT_V2		0x20af
+struct hci_cp_le_enable_encrypt_v2 {
+	__le16  handle;
+	__le64  rand;
+	__le16  ediv;
+	__u8    ltk[16];
+	__u8    mic_len;
+	__u8    encryption;
+} __packed;
+
 #define HCI_OP_LE_READ_MAX_DATA_LEN_V2		0x20b0
 struct hci_cp_le_read_max_data_len_v2 {
 	__u8    phy;
@@ -3039,6 +3049,26 @@ struct hci_ev_sync_train_complete {
 
 #define HCI_EV_PERIPHERAL_PAGE_RESP_TIMEOUT	0x54
 
+#define HCI_EVT_KEY_REFRESH_COMPLETE_V2		0x5b
+struct hci_evt_key_refresh_complete_v2 {
+	__u8    status;
+	__le16  handle;
+	__u8    mic_len;
+	__u8    eks_mode;
+	__u8    eks_debug;
+} __packed;
+
+#define HCI_EVT_ENCRYPT_CHANGE_V3		0x5a
+struct hci_evt_encrypt_change_v3 {
+	__u8    status;
+	__le16  handle;
+	__u8    mode;
+	__u8    key_size;
+	__u8    mic_len;
+	__u8    eks_mode;
+	__u8    eks_debug;
+} __packed;
+
 #define HCI_EV_LE_CONN_COMPLETE		0x01
 struct hci_ev_le_conn_complete {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1158ec218e1a..7a4f87236854 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2178,6 +2178,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 	(le_feature(dev, 1, 2) & HCI_LE_HDT_7_5_TX_FEATURE)
 #define hdt_pf1_capable(dev) \
 	(le_feature(dev, 1, 2) & HCI_LE_HDT_PF_1)
+#define eks_capable(dev) \
+	(le_feature(dev, 1, 1) & HCI_LE_EKS_FEATURE)
 
 /* Channel sounding support */
 #define le_cs_capable(dev) \
@@ -2625,8 +2627,6 @@ void mgmt_conn_subrate_notify(struct hci_dev *hdev, struct hci_conn *conn,
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
-void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-		      __u8 ltk[16], __u8 key_size);
 
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index aa12250eca52..ab880384614a 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -197,3 +197,6 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys, u16 phy_opts);
 int hci_le_set_cig_params_sync(struct hci_dev *hdev, u8 cig_id);
 int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 			   u8 num_bis);
+
+int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
+			  __u8 ltk[16], __u8 key_size);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a853750d63f8..fb2eaa9815a0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -598,24 +598,6 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 	}
 }
 
-void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-		      __u8 ltk[16], __u8 key_size)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_cp_le_start_enc cp;
-
-	BT_DBG("hcon %p", conn);
-
-	memset(&cp, 0, sizeof(cp));
-
-	cp.handle = cpu_to_le16(conn->handle);
-	cp.rand = rand;
-	cp.ediv = ediv;
-	memcpy(cp.ltk, ltk, key_size);
-
-	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
-}
-
 /* Device _must_ be locked */
 void hci_sco_setup(struct hci_conn *conn, __u8 status)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f7297179e69c..557e8b25ae2c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3071,6 +3071,41 @@ static void hci_cs_le_start_enc(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cs_le_enable_encrypt_v2(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_enable_encrypt_v2 *cp;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	if (!status)
+		return;
+
+	hci_dev_lock(hdev);
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_ENABLE_ENCRYPT_V2);
+	if (!cp)
+		goto unlock;
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(cp->handle));
+	if (!conn)
+		goto unlock;
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags);
+
+	/* An opportunistic encryption that cannot be started just leaves
+	 * the link unencrypted, as it was.
+	 */
+	if (cp->encryption == 0x01 || conn->state != BT_CONNECTED)
+		goto unlock;
+
+	hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+	hci_conn_drop(conn);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
 {
 	struct hci_cp_switch_role *cp;
@@ -3725,22 +3760,12 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
-				   struct sk_buff *skb)
+static void hci_change_encrypt(struct hci_conn *conn, u8 status, u8 encrypt)
 {
-	struct hci_ev_encrypt_change *ev = data;
-	struct hci_conn *conn;
+	struct hci_dev *hdev = conn->hdev;
 
-	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (!conn)
-		goto unlock;
-
-	if (!ev->status) {
-		if (ev->encrypt) {
+	if (!status) {
+		if (encrypt) {
 			/* Encryption implies authentication */
 			set_bit(HCI_CONN_AUTH, conn->flags);
 			set_bit(HCI_CONN_ENCRYPT, conn->flags);
@@ -3750,7 +3775,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
 				set_bit(HCI_CONN_FIPS, conn->flags);
 
-			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
+			if ((conn->type == ACL_LINK && encrypt == 0x02) ||
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, conn->flags);
 
@@ -3781,7 +3806,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	/* We should disregard the current RPA and generate a new one
 	 * whenever the encryption procedure fails.
 	 */
-	if (ev->status && conn->type == LE_LINK) {
+	if (status && conn->type == LE_LINK) {
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		hci_adv_instances_set_rpa_expired(hdev, true);
 	}
@@ -3790,23 +3815,23 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 
 	/* Check link security requirements are met */
 	if (!hci_conn_check_link_mode(conn))
-		ev->status = HCI_ERROR_AUTH_FAILURE;
+		status = HCI_ERROR_AUTH_FAILURE;
 
-	if (ev->status && conn->state == BT_CONNECTED) {
-		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
+	if (status && conn->state == BT_CONNECTED) {
+		if (status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, conn->flags);
 
 		/* Notify upper layers so they can cleanup before
 		 * disconnecting.
 		 */
-		hci_encrypt_cfm(conn, ev->status);
+		hci_encrypt_cfm(conn, status);
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_drop(conn);
-		goto unlock;
+		return;
 	}
 
 	/* Try reading the encryption key size for encrypted ACL links */
-	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
+	if (!status && encrypt && conn->type == ACL_LINK) {
 		if (hci_read_enc_key_size(hdev, conn)) {
 			/* Could not even issue the key-size read: report the
 			 * security level now since hci_cc_read_enc_key_size()
@@ -3816,7 +3841,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			goto notify;
 		}
 
-		goto unlock;
+		return;
 	}
 
 	/* We skip the WRITE_AUTH_PAYLOAD_TIMEOUT for ATS2851 based controllers
@@ -3846,7 +3871,44 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	}
 
 notify:
-	hci_encrypt_cfm(conn, ev->status);
+	hci_encrypt_cfm(conn, status);
+}
+
+static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
+				   struct sk_buff *skb)
+{
+	struct hci_ev_encrypt_change *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	hci_change_encrypt(conn, ev->status, ev->encrypt);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void hci_encrypt_change_v3_evt(struct hci_dev *hdev, void *data,
+				      struct sk_buff *skb)
+{
+	struct hci_evt_encrypt_change_v3 *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
+		goto unlock;
+
+	hci_change_encrypt(conn, ev->status, ev->mode);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -4760,6 +4822,7 @@ static const struct hci_cs {
 	HCI_CS(HCI_OP_LE_CREATE_CONN, hci_cs_le_create_conn),
 	HCI_CS(HCI_OP_LE_READ_REMOTE_FEATURES, hci_cs_le_read_remote_features),
 	HCI_CS(HCI_OP_LE_START_ENC, hci_cs_le_start_enc),
+	HCI_CS(HCI_OP_LE_ENABLE_ENCRYPT_V2, hci_cs_le_enable_encrypt_v2),
 	HCI_CS(HCI_OP_LE_SET_PHY, hci_cs_le_set_phy),
 	HCI_CS(HCI_OP_LE_EXT_CREATE_CONN, hci_cs_le_ext_create_conn),
 	HCI_CS(HCI_OP_LE_CREATE_CIS, hci_cs_le_create_cis),
@@ -5555,6 +5618,46 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 	hci_dev_unlock(hdev);
 }
 
+static void hci_conn_refresh_key(struct hci_conn *conn, u8 status)
+{
+	/* For BR/EDR the necessary steps are taken through the
+	 * auth_complete event.
+	 */
+	if (conn->type != LE_LINK)
+		return;
+
+	if (!status) {
+		bool sec_level_changed =
+				conn->sec_level != conn->pending_sec_level;
+
+		conn->sec_level = conn->pending_sec_level;
+		if (sec_level_changed)
+			mgmt_security_level_changed(conn);
+	}
+
+	clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags);
+
+	if (status && conn->state == BT_CONNECTED) {
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		return;
+	}
+
+	if (conn->state == BT_CONFIG) {
+		if (!status)
+			conn->state = BT_CONNECTED;
+
+		hci_connect_cfm(conn, status);
+		hci_conn_drop(conn);
+	} else {
+		hci_auth_cfm(conn, status);
+
+		hci_conn_hold(conn);
+		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+		hci_conn_drop(conn);
+	}
+}
+
 static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 					 struct sk_buff *skb)
 {
@@ -5570,42 +5673,28 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 	if (!conn)
 		goto unlock;
 
-	/* For BR/EDR the necessary steps are taken through the
-	 * auth_complete event.
-	 */
-	if (conn->type != LE_LINK)
+	hci_conn_refresh_key(conn, ev->status);
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static void hci_key_refresh_complete_v2_evt(struct hci_dev *hdev, void *data,
+					    struct sk_buff *skb)
+{
+	struct hci_evt_key_refresh_complete_v2 *ev = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x handle 0x%4.4x", ev->status,
+		   __le16_to_cpu(ev->handle));
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (!conn)
 		goto unlock;
 
-	if (!ev->status) {
-		bool sec_level_changed =
-				conn->sec_level != conn->pending_sec_level;
-
-		conn->sec_level = conn->pending_sec_level;
-		if (sec_level_changed)
-			mgmt_security_level_changed(conn);
-	}
-
-	clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags);
-
-	if (ev->status && conn->state == BT_CONNECTED) {
-		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
-		hci_conn_drop(conn);
-		goto unlock;
-	}
-
-	if (conn->state == BT_CONFIG) {
-		if (!ev->status)
-			conn->state = BT_CONNECTED;
-
-		hci_connect_cfm(conn, ev->status);
-		hci_conn_drop(conn);
-	} else {
-		hci_auth_cfm(conn, ev->status);
-
-		hci_conn_hold(conn);
-		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-		hci_conn_drop(conn);
-	}
+	hci_conn_refresh_key(conn, ev->status);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -8408,6 +8497,12 @@ static const struct hci_ev {
 	/* [0x3e = HCI_EV_LE_META] */
 	HCI_EV_REQ_VL(HCI_EV_LE_META, hci_le_meta_evt,
 		      sizeof(struct hci_ev_le_meta), HCI_MAX_EVENT_PLEN),
+	/* [0xfb = HCI_EVT_LE_ENCRYPT_KEY_REFRESH_COMPLETE_V2] */
+	HCI_EV(HCI_EVT_KEY_REFRESH_COMPLETE_V2, hci_key_refresh_complete_v2_evt,
+	       sizeof(struct hci_evt_key_refresh_complete_v2)),
+	/* [0xfc = HCI_EVT_LE_ENCRYPT_CHANGE_V3 */
+	HCI_EV(HCI_EVT_ENCRYPT_CHANGE_V3, hci_encrypt_change_v3_evt,
+	       sizeof(struct hci_evt_encrypt_change_v3)),
 	/* [0xff = HCI_EV_VENDOR] */
 	HCI_EV_VL(HCI_EV_VENDOR, hci_vendor_evt, 0, HCI_MAX_EVENT_PLEN),
 };
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9e670c5acd48..dff5ee237b9f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5180,6 +5180,13 @@ static int hci_set_event_mask_page_2_sync(struct hci_dev *hdev)
 		changed = true;
 	}
 
+	if (eks_capable(hdev)) {
+		/* EKS events */
+		events[3] |= BIT(2);	/* Encrytion Change v3 */
+		events[3] |= BIT(3);	/* Encrytion Key Refresh Complete v2 */
+		changed = true;
+	}
+
 	/* Some Broadcom based controllers indicate support for Set Event
 	 * Mask Page 2 command, but then actually do not support it. Since
 	 * the default value is all bits set to zero, the command is only
@@ -8459,6 +8466,7 @@ static int hci_le_set_cig_params_v2_sync(struct hci_dev *hdev, u8 cig_id)
 			      qos->ucast.out.phys;
 		cis->c_rtn  = qos->ucast.out.rtn;
 		cis->p_rtn  = qos->ucast.in.rtn;
+		cis->mic_len = 0x02; /* Always prefer 128 bits? */
 
 		/* Use the rates of each direction, or all the HDT rates the
 		 * controller supports if none were set.
@@ -8607,3 +8615,119 @@ int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
+
+/* Both LE Start Encryption and LE Enable Encryption v2 start with the
+ * connection handle.
+ */
+static void le_enable_encrypt_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_cp_le_start_enc *cp = data;
+	struct hci_conn *conn;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	/* If the command failed without a Command Status, such as when it
+	 * could not be sent, nothing else clears the pending encryption, so
+	 * handle it as a Command Status error would.
+	 */
+	if (err) {
+		hci_dev_lock(hdev);
+
+		conn = hci_conn_hash_lookup_handle(hdev,
+						   le16_to_cpu(cp->handle));
+		if (conn &&
+		    test_and_clear_bit(HCI_CONN_ENCRYPT_PEND, conn->flags) &&
+		    conn->state == BT_CONNECTED) {
+			hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
+			hci_conn_drop(conn);
+		}
+
+		hci_dev_unlock(hdev);
+	}
+
+	/* The command carries the key */
+	kfree_sensitive(data);
+}
+
+static int hci_le_enable_encrypt_v2_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_enable_encrypt_v2 *cp = data;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_ENABLE_ENCRYPT_V2,
+				     sizeof(*cp), cp, HCI_CMD_TIMEOUT);
+}
+
+static int hci_le_enable_encrypt_v2(struct hci_conn *conn, __le16 ediv,
+				    __le64 rand, __u8 ltk[16], __u8 key_size)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_enable_encrypt_v2 *cp;
+	int err;
+
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
+	cp = kzalloc_obj(*cp);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->handle = cpu_to_le16(conn->handle);
+	cp->rand = rand;
+	cp->ediv = ediv;
+	cp->mic_len = 0x02; /* Always prefer 128 bits? */
+
+	/* The key is zero padded when shorter than 16 octets */
+	if (ltk) {
+		memcpy(cp->ltk, ltk, key_size);
+		cp->encryption = 0x00; /* Use LTK provided in LTK field */
+	} else {
+		cp->encryption = 0x01; /* Use opportunistic with EKS */
+	}
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_enable_encrypt_v2_sync, cp,
+				      le_enable_encrypt_complete);
+	if (err)
+		kfree_sensitive(cp);
+
+	return err;
+}
+
+static int hci_le_enable_encrypt_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_start_enc *cp = data;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_START_ENC,
+					sizeof(*cp), cp,
+					HCI_CMD_TIMEOUT);
+}
+
+int hci_le_enable_encrypt(struct hci_conn *conn, __le16 ediv, __le64 rand,
+			  __u8 ltk[16], __u8 key_size)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_le_start_enc *cp;
+	int err;
+
+	/* Check if EKS and HCI_OP_LE_ENABLE_ENCRYPT_V2 are supported */
+	if (eks_capable(hdev) && (hdev->commands[50] & BIT(4)))
+		return hci_le_enable_encrypt_v2(conn, ediv, rand, ltk,
+						key_size);
+
+	bt_dev_dbg(hdev, "hcon %p", conn);
+
+	/* The key is zero padded when shorter than 16 octets */
+	cp = kzalloc_obj(*cp);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->handle = cpu_to_le16(conn->handle);
+	cp->rand = rand;
+	cp->ediv = ediv;
+	memcpy(cp->ltk, ltk, key_size);
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_enable_encrypt_sync, cp,
+				      le_enable_encrypt_complete);
+	if (err)
+		kfree_sensitive(cp);
+
+	return err;
+}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b7015e37e1f1..140b9813998b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -987,7 +987,12 @@ static u8 smp_random(struct smp_chan *smp)
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags))
 			return SMP_UNSPECIFIED;
 
-		hci_le_start_enc(hcon, ediv, rand, stk, smp->enc_key_size);
+		if (hci_le_enable_encrypt(hcon, ediv, rand, stk,
+					  smp->enc_key_size)) {
+			clear_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags);
+			return SMP_UNSPECIFIED;
+		}
+
 		hcon->enc_key_size = smp->enc_key_size;
 		set_bit(HCI_CONN_STK_ENCRYPT, hcon->flags);
 	} else {
@@ -2209,30 +2214,46 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 {
 	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
-	bool ret = false;
+	u8 val[16], enc_size;
+	__le64 rand;
+	__le16 ediv;
 
 	rcu_read_lock();
 
 	key = hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type, hcon->role);
-	if (!key)
-		goto unlock;
+	if (!key || smp_ltk_sec_level(key) < sec_level) {
+		rcu_read_unlock();
+		return false;
+	}
 
-	if (smp_ltk_sec_level(key) < sec_level)
-		goto unlock;
+	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags)) {
+		rcu_read_unlock();
+		return true;
+	}
 
-	ret = true;
-	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags))
-		goto unlock;
+	/* Starting the encryption may sleep, so take a copy of the key and
+	 * leave the RCU read-side section first.
+	 */
+	memcpy(val, key->val, sizeof(val));
+	enc_size = key->enc_size;
+	rand = key->rand;
+	ediv = key->ediv;
 
-	hci_le_start_enc(hcon, key->ediv, key->rand, key->val, key->enc_size);
-	hcon->enc_key_size = key->enc_size;
+	rcu_read_unlock();
+
+	if (hci_le_enable_encrypt(hcon, ediv, rand, val, enc_size)) {
+		memzero_explicit(val, sizeof(val));
+		clear_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags);
+		return false;
+	}
+
+	hcon->enc_key_size = enc_size;
+	memzero_explicit(val, sizeof(val));
 
 	/* We never store STKs for initiator role, so clear this flag */
 	clear_bit(HCI_CONN_STK_ENCRYPT, hcon->flags);
 
-unlock:
-	rcu_read_unlock();
-	return ret;
+	return true;
 }
 
 bool smp_sufficient_security(struct hci_conn *hcon, u8 sec_level,
@@ -2924,13 +2945,25 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 		sc_dhkey_check(smp);
 	}
 
-	sc_add_ltk(smp);
-
 	if (test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
-		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
+		/* Mark the encryption pending, as smp_random() does, before
+		 * adding the LTK so it doesn't get started a second time with
+		 * it, and so a failure doesn't remove a previously stored key.
+		 */
+		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags))
+			return SMP_UNSPECIFIED;
+
+		if (hci_le_enable_encrypt(hcon, 0, 0, smp->tk,
+					  smp->enc_key_size)) {
+			clear_bit(HCI_CONN_ENCRYPT_PEND, hcon->flags);
+			return SMP_UNSPECIFIED;
+		}
+
 		hcon->enc_key_size = smp->enc_key_size;
 	}
 
+	sc_add_ltk(smp);
+
 	return 0;
 }
 
-- 
2.56.0

