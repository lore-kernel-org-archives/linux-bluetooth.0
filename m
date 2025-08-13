Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386D42F069E
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119732; cv=none; b=ccTn2Y4DXTm9/om+GP/0+r+sJ3wfFYwu6Rju8mOfZRjfwuXfkU+njmewHfU7sGU0TIiaspHUzi4QDnCDHw68VtgitebpS765svhIu9AQGuPcH3DcmJcRXF5jD8eSHRwT3Rw9QK9+62PLRGLepBrTeBaSzs+6r3JElXN8Gsc918I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119732; c=relaxed/simple;
	bh=E58SImKJe1O2mG5COBGySvPMhEhbyA9cmbgnA9eVx9A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GT3a02QTTNG95q42cs9N3pCk7RxApRhzRJL99dQHRm2nFJy4qRruwFgPC4M1JJFG2x/SHKROlBBeIkBdqt0jT5l/1Egq8nwW18oCpfgk3Miq6KmcBX3LzSN3rJ/GGA3+tFPc9xNWjRcux3tvNGUXd8Dn2OU7YdHAzMt/Xp5cBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP+ROty1; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP+ROty1"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-890190b1aabso150684241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755119730; x=1755724530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOJRNVNh9sfJ6Z2nIb8io52DeJcn6T5blLCpE4GT4pQ=;
        b=eP+ROty11qEVgGnL/Ij/wgDWKWIUIuWOt672j3O5m75KPoQxzwUR7SSkD7+ZE7ZmEj
         NFkbULPm/YW3/CMnk7eRK068i+b/WHj93DfT8udDVtUlJ6eJvrz534VGtkj2aEgmWPcd
         5GaSYJsUp1GUyAHPX6GZnWDEqbz3rw1rpaHwVd/lR7YgrVv7GekT3LZs96tUVGgQ1uBH
         FgiwVH4o/G7Q6NDq8pr7N41zVoUh1ryzRFjotlD8cSjCXfne/mOrN70fIoTKB28Lp09D
         xZx5UmPz2tEPqnQlScorGhuZgF805L1qDWsEqcQ79pI8thBNI1nFMficCCZ2aBlOK/wr
         /zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119730; x=1755724530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOJRNVNh9sfJ6Z2nIb8io52DeJcn6T5blLCpE4GT4pQ=;
        b=XjtTW2R+FMKWwLj4ES2jxD3JiyFXJdiEvS+jEtNF0M87/zVdFVD59ZtvoCwo06HOQv
         yhqnI34dUZfFL+zLZaJ25MEnU9AZc0CysWQdh5tye03oyXIz1on3VzEG049qne1JIoZD
         62KU89DI+HCsvCgAfkW2vlC9XUmzH+H0AbIc6fR9/s0//wjrOvWkuYS6OpTbJVHsK20s
         /sBGPyNOjJyiW94klc473JgDK7TlN5E0t6aSBjACWORicitHHcuCmIbjy4kc3Gun9rHU
         RmII3c+8DEmFbEH9s4aLEISQF8Mj+oUWzNaZYvl+Z1/0njYSkryGB4GCRekCzLieDmaj
         jnpA==
X-Gm-Message-State: AOJu0Yx975XnTfck/ILEkX3s9H1f3f6vOB3htjPFjQx2HN0RbU3k6Hpj
	3UUiOjdkox6a1tMU38MkxEex1Q5EvmzmmhImDczNvxHo2KVvO2057XpJv8oQ5g==
X-Gm-Gg: ASbGncu+uVnXreJIKBETWiAE6/M7lL1U3jYaXM9YZgFGyvNkWnha+OarTBpVQBtzRhE
	IlI11ojXoE4ZhcTM/cTRw5GI5E35KbQsHXBjCiV+Y8qPs7fH9RVZvSroKKdZTViVuxs1ztkfOQZ
	UB+X3eyWKo8IoGPHJvwdYAP8QS0i95GSxOLs2SNPMwydtMHhD1yZ8Sicg7nVUvDj/y3UK7Wjj6p
	NKXkTUzsVCTe2C9mE8Lz++28PytYHavbGFs7rWTw4B3w4IHUEIrOd0noiATY8HRLERF7nmL2D/M
	kWeW3EtQqiA/PmS8auTYJrOkcQ4Qp3aNpsD/xAdAl8lOF6KKExlVC393PDHeNVV+VWxqauUCEdJ
	Uhbw7rh/XSCBbhnxR0rYzoYh4cg1Qfa9TiJmiv1WbYq6eo9WaTlj4aSLoDZa42qcDJKth0+rkFm
	8UR9QkKUgVJQ==
X-Google-Smtp-Source: AGHT+IEIkE+/cCbrrcpDrYJXL54M7duWl9jK2/xBBpPggwHp8yPJ/CE38gJz+l81eJFEp0lmFvIOAA==
X-Received: by 2002:a05:6102:578e:b0:4ec:c548:ee2a with SMTP id ada2fe7eead31-50fe9a7417amr303333137.17.1755119729494;
        Wed, 13 Aug 2025 14:15:29 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507dcae5200sm2458422137.0.2025.08.13.14.15.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:15:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/5] Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
Date: Wed, 13 Aug 2025 17:15:10 -0400
Message-ID: <20250813211511.90866-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813211511.90866-1-luiz.dentz@gmail.com>
References: <20250813211511.90866-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This aligns the usage of socket sk_sndtimeo as conn_timeout when
initiating a connection and then use it when scheduling the
resulting HCI command, similar to what has been done in bf98feea5b65
("Bluetooth: hci_conn: Always use sk_timeo as conn_timeout").

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 10 ++++++----
 net/bluetooth/hci_conn.c         | 20 ++++++++++++--------
 net/bluetooth/iso.c              | 16 ++++++++++------
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bb30bde6f0e8..b060a6a76456 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1546,16 +1546,18 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting, struct bt_codec *codec,
 				 u16 timeout);
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos);
+			      __u8 dst_type, struct bt_iso_qos *qos,
+			      u16 timeout);
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 			      struct bt_iso_qos *qos,
-			      __u8 base_len, __u8 *base);
+			      __u8 base_len, __u8 *base, u16 timeout);
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos);
+				 __u8 dst_type, struct bt_iso_qos *qos,
+				 u16 timeout);
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, __u8 sid,
 				 struct bt_iso_qos *qos,
-				 __u8 data_len, __u8 *data);
+				 __u8 data_len, __u8 *data, u16 timeout);
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
 int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d2f0c3c0f0ae..05f97a17142e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1533,7 +1533,7 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				    __u8 sid, struct bt_iso_qos *qos,
-				    __u8 base_len, __u8 *base)
+				    __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
 	int err;
@@ -1575,6 +1575,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 
 	conn->state = BT_CONNECT;
 	conn->sid = sid;
+	conn->conn_timeout = timeout;
 
 	hci_conn_hold(conn);
 	return conn;
@@ -1915,7 +1916,8 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 }
 
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos)
+			      __u8 dst_type, struct bt_iso_qos *qos,
+			      u16 timeout)
 {
 	struct hci_conn *cis;
 
@@ -1930,6 +1932,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		cis->dst_type = dst_type;
 		cis->iso_qos.ucast.cig = BT_ISO_QOS_CIG_UNSET;
 		cis->iso_qos.ucast.cis = BT_ISO_QOS_CIS_UNSET;
+		cis->conn_timeout = timeout;
 	}
 
 	if (cis->state == BT_CONNECTED)
@@ -2169,7 +2172,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 			      struct bt_iso_qos *qos,
-			      __u8 base_len, __u8 *base)
+			      __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
 	struct hci_conn *parent;
@@ -2190,7 +2193,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 						   base, base_len);
 
 	/* We need hci_conn object using the BDADDR_ANY as dst */
-	conn = hci_add_bis(hdev, dst, sid, qos, base_len, eir);
+	conn = hci_add_bis(hdev, dst, sid, qos, base_len, eir, timeout);
 	if (IS_ERR(conn))
 		return conn;
 
@@ -2243,13 +2246,13 @@ static void bis_mark_per_adv(struct hci_conn *conn, void *data)
 struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 dst_type, __u8 sid,
 				 struct bt_iso_qos *qos,
-				 __u8 base_len, __u8 *base)
+				 __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
 	int err;
 	struct iso_list_data data;
 
-	conn = hci_bind_bis(hdev, dst, sid, qos, base_len, base);
+	conn = hci_bind_bis(hdev, dst, sid, qos, base_len, base, timeout);
 	if (IS_ERR(conn))
 		return conn;
 
@@ -2292,7 +2295,8 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos)
+				 __u8 dst_type, struct bt_iso_qos *qos,
+				 u16 timeout)
 {
 	struct hci_conn *le;
 	struct hci_conn *cis;
@@ -2316,7 +2320,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 	hci_iso_qos_setup(hdev, le, &qos->ucast.in,
 			  le->le_rx_phy ? le->le_rx_phy : hdev->le_rx_def_phys);
 
-	cis = hci_bind_cis(hdev, dst, dst_type, qos);
+	cis = hci_bind_cis(hdev, dst, dst_type, qos, timeout);
 	if (IS_ERR(cis)) {
 		hci_conn_drop(le);
 		return cis;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index dff3fc4917d6..672987e845d0 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -91,8 +91,8 @@ static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
 				 iso_sock_match_t match, void *data);
 
 /* ---- ISO timers ---- */
-#define ISO_CONN_TIMEOUT	(HZ * 40)
-#define ISO_DISCONN_TIMEOUT	(HZ * 2)
+#define ISO_CONN_TIMEOUT	secs_to_jiffies(20)
+#define ISO_DISCONN_TIMEOUT	secs_to_jiffies(2)
 
 static void iso_conn_free(struct kref *ref)
 {
@@ -367,7 +367,8 @@ static int iso_connect_bis(struct sock *sk)
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_bis(hdev, &iso_pi(sk)->dst, iso_pi(sk)->bc_sid,
 				    &iso_pi(sk)->qos, iso_pi(sk)->base_len,
-				    iso_pi(sk)->base);
+				    iso_pi(sk)->base,
+				    READ_ONCE(sk->sk_sndtimeo));
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
@@ -376,7 +377,8 @@ static int iso_connect_bis(struct sock *sk)
 		hcon = hci_connect_bis(hdev, &iso_pi(sk)->dst,
 				       le_addr_type(iso_pi(sk)->dst_type),
 				       iso_pi(sk)->bc_sid, &iso_pi(sk)->qos,
-				       iso_pi(sk)->base_len, iso_pi(sk)->base);
+				       iso_pi(sk)->base_len, iso_pi(sk)->base,
+				       READ_ONCE(sk->sk_sndtimeo));
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
@@ -469,7 +471,8 @@ static int iso_connect_cis(struct sock *sk)
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,
 				    le_addr_type(iso_pi(sk)->dst_type),
-				    &iso_pi(sk)->qos);
+				    &iso_pi(sk)->qos,
+				    READ_ONCE(sk->sk_sndtimeo));
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
@@ -477,7 +480,8 @@ static int iso_connect_cis(struct sock *sk)
 	} else {
 		hcon = hci_connect_cis(hdev, &iso_pi(sk)->dst,
 				       le_addr_type(iso_pi(sk)->dst_type),
-				       &iso_pi(sk)->qos);
+				       &iso_pi(sk)->qos,
+				       READ_ONCE(sk->sk_sndtimeo));
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto unlock;
-- 
2.50.1

