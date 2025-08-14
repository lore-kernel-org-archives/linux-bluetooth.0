Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E92DC34B
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188709; cv=none; b=GjZ6HW8I+8qkMo8dOIDAe21LqtOLaK0eWhgRcyKV67UXmy7rTfki79FGh2lrfdKic+i6jAQ1nYkUfMh//W6XsIviYL9GiIFstvAAqSJNjMVEWTo7IuuzbY1NFxSxnP9FV4v5kHnnOkwsCWtO1VU60inrMslBjOQAMqbQCyhvrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188709; c=relaxed/simple;
	bh=rdry0+Qs6whtJc9avWF7dhsRtLWQjqUm6PQDSoqSPxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7GmGB7q6VPpEgfYeGh0mSZxwGwhYF2bDkxhiPR4e4hAoqKxPtBbtwM0LmJ2bdoQapYXAKFU6TtNmNTYfFJY0NQ1YqwWspvgOdu/XdKHRSzzd8KQEzSJRQUk5S25US8yL8EAYZQDBjTxs6oVRqkVBL6tRYLHZ6X/552RrbD37AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOQEJ6/l; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOQEJ6/l"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53b1718837dso499001e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755188706; x=1755793506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/J5H0ywUYAiOwDebo4aUvGjNpGbonXZ7ebjBvebhtOc=;
        b=fOQEJ6/lz89hGHOwUmgVi8zmHBYh6g8yLMs4VbPddM6vU5BB8I2z3ahBKrQDZWjMfO
         JMVWOcBfeI8vUxVrwNnGOPCMMx/cEtGVc3NtFQWDbtX9NeqSyixfG2zLftfbzvLl4lRu
         rQg8VyHs8/CDuhSWW/gRhBHQdU5wxJrnYRGeP7Av+Iq/eo9UsbIiUu3YFr22CkmyH1Wb
         1UeQ+QixyEEEZXweL5zn3x5svSFwHNfj0pFn9lWwLDfl8IX0MEfbwfFj+5B77nungpuu
         Cu9t05thRwI5hYtJNKnQ7DdLu4phDMfeDkUF1y1L8kCsudWYdBPFEZ+8YEzBGLdT+uWn
         MHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188706; x=1755793506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J5H0ywUYAiOwDebo4aUvGjNpGbonXZ7ebjBvebhtOc=;
        b=jVCDjsbDCIZw8WYfFTGPtzTo2OB22s6Kh4Z4sCVI7LRbCSgbLGFKZx4M/PODlsCzhY
         xQtWYRX08rFvo02HWgQI3t10hZYW2jK4QsTIpJL5H/KIouKszcCZDSLW/PdAZb4ScWe8
         Z0pn5NkBAaTprvWYP+E8ntF5hMdjPXAtBxn7oUYm09CImGUR5fzreSGeqSn2BZBLqZk2
         gRjaMwuYH+hghY8zBEsPOB2Wibf7u8cN41XyDbWCkqOE4/tWJv8r+R5gWoN+L1R7jgZU
         vunN/IYViyMLzqGEzXdSwDcnjLpM/OEhIzVtBYb3JMPVdgV8yYNeC6IwrVI7lQ8kqECI
         KlPg==
X-Gm-Message-State: AOJu0Yx3yrQMaVXGzGWOrAb5gE2UUy2RgqMGbfc8EdmSHqAcvM2U1gkl
	foVaYerWvKQNuaszT2HcxsQ9V1T2cH5BzSVViKXOV8I6XWVLzArgTSOWCtpsjrz8
X-Gm-Gg: ASbGnctJ9kXD454lM05/lVDgHgfHHgRgWmNOwLsWEd/l6dUcE7JSsD1hNLHnH4jS5j3
	lexFxpXQbFXZzgfdXOr5YvRWX8e0Nu/eevrn4wX9NiJYUrcP3Kf3/LCScgqTOVesXNeBke4709A
	B6qESa3TbDWSEfPEUX+5ZMPoGwFEfCPWZxLv4rLBnxp1PZE1zNR6pzNtc5UBriUQjz7SjlE4dkY
	7QSjMO/KqDlvoQBgPd27I0KIV5I+2Y+2B6NQmtthxy7iqm3BwTzImBpSed4aU7orFkEBNlpv2XU
	DM4pQBzv9GUOoXeVtKfjTRRI6ED64P15UnBS8OmOviis/SpmC1RUtWOr1RwksbGZZqtVU0DtqT7
	soO2RSYd9NNWL1cLhRyA5g6QlUSL+v0V5vn98Xutp+E1gdmH4DrhOQdSOv+lBkulk
X-Google-Smtp-Source: AGHT+IGNYZgI36eMBviXLHzKFgrHXQycsHRhN4cUnMZnciqBu//jSZpVVy4zmwTFE36k4fFAZKdk7A==
X-Received: by 2002:a05:6102:d8e:b0:4e6:4e64:baeb with SMTP id ada2fe7eead31-50feadba179mr1724401137.17.1755188705604;
        Thu, 14 Aug 2025 09:25:05 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e57924cb0sm969037241.8.2025.08.14.09.25.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:25:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 5/6] Bluetooth: ISO: Use sk_sndtimeo as conn_timeout
Date: Thu, 14 Aug 2025 12:24:47 -0400
Message-ID: <20250814162448.124616-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814162448.124616-1-luiz.dentz@gmail.com>
References: <20250814162448.124616-1-luiz.dentz@gmail.com>
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
index 6906af7a8f24..c7b0a5f5cf9b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1566,16 +1566,18 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
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
index 3ba0d0bee48e..d33fa77e401a 100644
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
index ac6e83313b9b..5c68c0ea7d97 100644
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

