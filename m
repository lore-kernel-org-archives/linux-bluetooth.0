Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5B23E347
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186148; cv=none; b=XTBt3sxCBKXCfMajbBluBsyFMyzuhG4l2Mafjsu+MNiQ+JNrh2F8kcieIIGxoPe6ocGR3NpBQ5KzMasPd7PHDl8C2dnRGEAj2HzvVMb3uSMOT49o17cg4Hy07lgj2VWP54WzRf6QobbwL/hTugrSyiKzv1+PrRan0mA6MOm5sFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186148; c=relaxed/simple;
	bh=nmJBqqrMUhna8gH7yq6B/DK6VVMLwArNn0KURkhxZ8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzzSQ3/ptTm7F5GW00vhjGVOKf8w6mWhC0srqRh3TDBgYbNpdcY0i5sB2eK3TSCKq53qD3c0T7PwVYpnrdWaC5fBXqxNPk6FFDs6ytY9KodAR0hJh6+4Y+KHeSc5BTkpbtjDmUrkCXimMJH5lWXmAmBY3zTX29BInuc7TijKwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC33wlXP; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC33wlXP"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b17378b74so435600e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186144; x=1755790944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EW+qIXFO40F6CXy4zPpsNBbJwCf0Y5H4WKkRiATQjlw=;
        b=XC33wlXPoMw9p4G2W/vafFdA50M4SLc4BB33KVuZQrghQjv8lCcbDTidCIdBv8Q1OE
         AI0KFw/ZG6HaJNLs+i9RPgm7MXGf82Eb9+iw20N6ggu+1K6u/ICPcP+E4ggLpevE/18M
         0yLT7qizandVAJQ3W9uhfvr0sht6usOhly8XzO9e/kTfm+MKLUumXf4uTW/DbuX2Cnmb
         MaRukWL1NTcOsfHqynVUq2rpAEVeihskZxXgsqkhV6g5M0V/PINNv3sL1kyt240mzF+E
         g0FOZX5PzYHcE6V+Dlc2LvAvqpGF+1ZviOsuXYvoE5nR+OrUBOSnWeMAdhFKTRmSpcca
         OyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186144; x=1755790944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW+qIXFO40F6CXy4zPpsNBbJwCf0Y5H4WKkRiATQjlw=;
        b=lz0ZXk7WbvsMoAou8QnaTuD66ft6BvOGyGirjNIq3EH+7PLXfnOVgGPmE6eEAK1KvU
         n0RkFDEHv+EFt0gO5XQ8POx3mLjxORkNpnRDZIJAD93+3E/7eDgu3IuJdVuVDjVJkUup
         2JeBrMOuAzuHVA9lZT8Fzl4hbmww46dccZ6x1eBJgj0eBzUHAFB4cLTll1wkoyj4pGWp
         YZqYYkRELV31qPbVatgULZ0Yf3odhfDBu5UXVP9u0NhJQas36YObf2c/sQw9i+J49eN4
         QtcnsstYvGxXCTAaGuNlBtXzfgCyTx8PN73bCK58velPV1HTiZGuxBX+A/KmRA8aL7bz
         nI6A==
X-Gm-Message-State: AOJu0YyCA+pzaRq0ZO+G0v4Ca0HiiZOha15ahGcRdM5huPfcWV2PeSUI
	91ZhaFIHxgeHr6zqWYxdiH+HULPRCjyfVUe8yLVzQYeWOtk5J3JHgdwetB9q1/3W
X-Gm-Gg: ASbGnctFZy1I8F7y/XUNbBHdySGiYNMlF1Zz64kucGvCC4huottqVyEUCouwvI9PSUM
	l60HYiApGBIqESVLq3zEHGBYP0bTKKr3lzWVbKKamfJ3bfWlsv3pvwAVvAGMNoWscilSZVLdXJb
	jg9Bk5VI047KW+/cJoJbUtWB9rZ1YtA+w3/pwkGTHxt4tgojUUdfEhBUCpA6TyEr837oibn/UiL
	/iEcG6t64gArZGwNgGcIGhRRgJvEpCZri3HVmJToThc7OHRCWDQQc4MMnJ3qJ3KKZ8D6td67nYj
	hRAqVdsRMZg909JICwZSVkvt7KmwaUn2lIgp/zUjrGVxLs3p/6BVxGIXhF7nDgWHcB9VECjZ3YO
	99fPLurogiRH1Db+Mo+8UQ40lr+LgcG/f+oPO3ZdMdSIrQp/FFDjO93f0aNrd8PTP
X-Google-Smtp-Source: AGHT+IFl1P1nqYhRPyedZBw3jebvjtFo0Q5Gx9wEm9yz9/AgosUR618nwdOab6He3kGbppg2WXjhWA==
X-Received: by 2002:a05:6122:1e12:b0:539:1291:b03 with SMTP id 71dfb90a1353d-53b189af7d3mr1453495e0c.5.1755186144388;
        Thu, 14 Aug 2025 08:42:24 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b01ae76asm4723431e0c.8.2025.08.14.08.42.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 08:42:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/5] Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
Date: Thu, 14 Aug 2025 11:42:07 -0400
Message-ID: <20250814154208.8433-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814154208.8433-1-luiz.dentz@gmail.com>
References: <20250814154208.8433-1-luiz.dentz@gmail.com>
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
index 89dc0429de77..71a718a89fd5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1536,7 +1536,7 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 /* This function requires the caller holds hdev->lock */
 static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				    __u8 sid, struct bt_iso_qos *qos,
-				    __u8 base_len, __u8 *base)
+				    __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
 	int err;
@@ -1578,6 +1578,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev *hdev, bdaddr_t *dst,
 
 	conn->state = BT_CONNECT;
 	conn->sid = sid;
+	conn->conn_timeout = timeout;
 
 	hci_conn_hold(conn);
 	return conn;
@@ -1918,7 +1919,8 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 }
 
 struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
-			      __u8 dst_type, struct bt_iso_qos *qos)
+			      __u8 dst_type, struct bt_iso_qos *qos,
+			      u16 timeout)
 {
 	struct hci_conn *cis;
 
@@ -1933,6 +1935,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		cis->dst_type = dst_type;
 		cis->iso_qos.ucast.cig = BT_ISO_QOS_CIG_UNSET;
 		cis->iso_qos.ucast.cis = BT_ISO_QOS_CIS_UNSET;
+		cis->conn_timeout = timeout;
 	}
 
 	if (cis->state == BT_CONNECTED)
@@ -2172,7 +2175,7 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 			      struct bt_iso_qos *qos,
-			      __u8 base_len, __u8 *base)
+			      __u8 base_len, __u8 *base, u16 timeout)
 {
 	struct hci_conn *conn;
 	struct hci_conn *parent;
@@ -2193,7 +2196,7 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
 						   base, base_len);
 
 	/* We need hci_conn object using the BDADDR_ANY as dst */
-	conn = hci_add_bis(hdev, dst, sid, qos, base_len, eir);
+	conn = hci_add_bis(hdev, dst, sid, qos, base_len, eir, timeout);
 	if (IS_ERR(conn))
 		return conn;
 
@@ -2246,13 +2249,13 @@ static void bis_mark_per_adv(struct hci_conn *conn, void *data)
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
 
@@ -2295,7 +2298,8 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
-				 __u8 dst_type, struct bt_iso_qos *qos)
+				 __u8 dst_type, struct bt_iso_qos *qos,
+				 u16 timeout)
 {
 	struct hci_conn *le;
 	struct hci_conn *cis;
@@ -2319,7 +2323,7 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
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

