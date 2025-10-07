Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190A1CF96
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848594; cv=none; b=tGsp914oDs2xJi+UkjoDBufkgdCDs6O5O6boRFUdFXNNUXaqHy9Lu1pHtaHc3fKxz0yxVpsCOYZzBehseLLixlfC3h3eg3z5fVV/iLJXM5uiAQqVe46myDaoH8BSsHIU3PFEFAyLkm7Ye5Obx9jLlTjs3aillF0OtPjEg19Htkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848594; c=relaxed/simple;
	bh=rxmLxYBSPEquvgD1yTuUu9zVLsvt02rIY2rqHBXTVHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqA1INDuyE3dfPQaxX8DBAirJW3C+lk+LUt+UQ/vSWJGR7P/hAVoNIc2aV1PhSxNRIYHuk5i0Z8rmLk9JYuSeKEcDc8qIyUxMdz/3Vqvt9OxXznEi0beKbnStV0BYJVRot68bezFdpmNPqvHS1ZGWtr/MuOpTVOvELvWEwoWL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHgIz31P; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHgIz31P"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54a80b26f88so2462835e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759848591; x=1760453391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKnoWh6BYCQ9tOyfjv/tkYKUuXlQmomm00kWmj4R2PM=;
        b=NHgIz31PN5CgrUnFf8iouvuQmcPAK6bfYqNZIco2/J8UHacpFyehL95DBYY9jdhTSK
         2fQIjXKpHIVXuHhSJWOs94QVEbAVnGMT5J9rUSpGkhqPOwfAZaMgZ95XZRL+EOmcCEKq
         kov+FCpkE+/ZlY20EtlaFmZcbjmN39h74jVXRf4PpmopomRbYS8o6XV0je8rNXDnEn5s
         PpJaOQ+z2U0pUtK8o5yZpZrwK0YtWw6Zn0Sus46Iz2pOQilA4KNmnYzLrZgcf4eg7utU
         joI+YKqnK+MJYhR5nMkfdtsINSrYoYmaTi6Ee2STSs+ghOPpo53EkH4p5RsgmwEgPS9g
         fllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759848591; x=1760453391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKnoWh6BYCQ9tOyfjv/tkYKUuXlQmomm00kWmj4R2PM=;
        b=fxVaev14E7rsukR+ojqLRq0cteB8wzvUVuZjNEedBOkB7UKL3FLg9hm/oICLU3I6O8
         legyWDEdi7MR/PDVEgDlX6ytV+vxVEqsxknvfpIG0KVlPTOe6lRzvns01l1E87Q+VUMr
         slxq1OYLqPdkAuvziscqoBgfigRB35WQZT4n0ST+i2wvXDOWKJgi8eLUPMTP63RpU730
         W2hRfCsiTpSgS0NUtgVON70HPOW7i0xDMa/F4OsDoX2ino6i02evyJ0GyMK1jGZLSwSj
         LPysXenTTdAUOnVsGzeZMpjjKrptTL5ng89kOiTL4uOL7VdMhDm81woUEr856DKKK4od
         OPvg==
X-Gm-Message-State: AOJu0YzCz9o0acBhrarOR7L57OZikiz0M/hpCO47H9fD/9dB3YrMohEX
	hKHRMcrz23x+fMkP6q2nXXcfS0IUiAWq1ieKhGss+3AafMfE6MDioheetsp93w==
X-Gm-Gg: ASbGncsRY4koLMGiVg7pc+SHfXiT8EHHXVcgLHvzQ86G4iy6LIvV0woDXUGQ7/RfCpO
	sLLQEN7UxJMkxANgYYcFNO5CuRnOiwuHu9xg5QFM+R+bn1OsoGhfsShfqKPAPdFptHf1ORwesiK
	M1qLufNcMyQiqo3GHWdsn4VFxVhzBwwiB/7GDSgfntEPmwUgzkS30Rd5Mv7o57t5fC/Okd0HBVJ
	tBI7438mACBMaBuVy/pFSESkZEWlvhadjmWv12aiEQ7K6Q6rTZg+JJSJEW1FBYgocHccieOAY38
	vZFdXeafH1WNZcsx5cOTNsDEOoaHTns+FAclb9kddrDlW9WfO8d7dRRUlqCPx4ZsjQ8Au/WZEAC
	5VYaoyQjJA0FYQ8/cs0W1k7LZHv/9uwHhC867Z/XDJdOv2pdfCWRwpmiZHdqekjm80enJwvjTMt
	bsDHdnjqUXt4kA8m5Ds+/PY09h
X-Google-Smtp-Source: AGHT+IFEsTr9QPGEQer0TU68RCNDHZssD8lIAGiDaRlj6OKz5aiS3Vlbxjv+8Cy/xw7UZ3BiTbLhug==
X-Received: by 2002:a05:6122:32c5:b0:54a:92f1:f9e4 with SMTP id 71dfb90a1353d-5524ea0edb6mr5618095e0c.9.1759848591118;
        Tue, 07 Oct 2025 07:49:51 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce64af0sm3731864e0c.8.2025.10.07.07.49.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:49:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/7] Bluetooth: ISO: Attempt to resolve broadcast address
Date: Tue,  7 Oct 2025 10:49:28 -0400
Message-ID: <20251007144930.1378274-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007144930.1378274-1-luiz.dentz@gmail.com>
References: <20251007144930.1378274-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Broadcasters maybe using RPAs which can change over time and not
matching the address used as destination in the socket, so this
attempts to resolve the addresses then match with the socket
address, in case that uses an indentity address, or then match the
IRKs if both broadcaster and socket are using RPAs.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 58 ++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d4c8772152bd..83cda8dad4d8 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -87,8 +87,8 @@ static void iso_sock_disconn(struct sock *sk);
 
 typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
 
-static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
-				 enum bt_sock_state state,
+static struct sock *iso_get_sock(struct hci_dev *hdev, bdaddr_t *src,
+				 bdaddr_t *dst, enum bt_sock_state state,
 				 iso_sock_match_t match, void *data);
 
 /* ---- ISO timers ---- */
@@ -638,8 +638,8 @@ static struct sock *__iso_get_sock_listen_by_sid(bdaddr_t *ba, bdaddr_t *bc,
  * match func data - pass -1 to ignore
  * Returns closest match.
  */
-static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
-				 enum bt_sock_state state,
+static struct sock *iso_get_sock(struct hci_dev *hdev, bdaddr_t *src,
+				 bdaddr_t *dst, enum bt_sock_state state,
 				 iso_sock_match_t match, void *data)
 {
 	struct sock *sk = NULL, *sk1 = NULL;
@@ -651,8 +651,25 @@ static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
 			continue;
 
 		/* Match Broadcast destination */
-		if (bacmp(dst, BDADDR_ANY) && bacmp(&iso_pi(sk)->dst, dst))
-			continue;
+		if (bacmp(dst, BDADDR_ANY) && bacmp(&iso_pi(sk)->dst, dst)) {
+			struct smp_irk *irk1, *irk2;
+
+			/* Check if destination is an RPA that we can resolve */
+			irk1 = hci_find_irk_by_rpa(hdev, dst);
+			if (!irk1)
+				continue;
+
+			/* Match with identity address */
+			if (bacmp(&iso_pi(sk)->dst, &irk1->bdaddr)) {
+				/* Check if socket destination address is also
+				 * an RPA and if the IRK matches.
+				 */
+				irk2 = hci_find_irk_by_rpa(hdev,
+							   &iso_pi(sk)->dst);
+				if (!irk2 || irk1 != irk2)
+					continue;
+			}
+		}
 
 		/* Use Match function if provided */
 		if (match && !match(sk, data))
@@ -1992,6 +2009,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_ev_le_per_adv_report *ev3 = NULL;
 	struct hci_conn *hcon;
+	struct hci_dev *hdev;
 
 	BT_DBG("conn %p", conn);
 
@@ -2002,13 +2020,15 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (!hcon)
 			return;
 
+		hdev = hcon->hdev;
+
 		if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags)) {
 			/* A BIS slave hcon is notified to the ISO layer
 			 * after the Command Complete for the LE Setup
 			 * ISO Data Path command is received. Get the
 			 * parent socket that matches the hcon BIG handle.
 			 */
-			parent = iso_get_sock(&hcon->src, &hcon->dst,
+			parent = iso_get_sock(hdev, &hcon->src, &hcon->dst,
 					      BT_LISTEN, iso_match_big_hcon,
 					      hcon);
 		} else if (test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
@@ -2016,12 +2036,12 @@ static void iso_conn_ready(struct iso_conn *conn)
 						 HCI_EVT_LE_BIG_SYNC_ESTABLISHED);
 
 			/* Get reference to PA sync parent socket, if it exists */
-			parent = iso_get_sock(&hcon->src, &hcon->dst,
+			parent = iso_get_sock(hdev, &hcon->src, &hcon->dst,
 					      BT_LISTEN,
 					      iso_match_pa_sync_flag,
 					      NULL);
 			if (!parent && ev)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_big, ev);
@@ -2029,7 +2049,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 			ev2 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
 			if (ev2)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_sid, ev2);
@@ -2037,7 +2057,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 			ev3 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PER_ADV_REPORT);
 			if (ev3)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_sync_handle_pa_report,
@@ -2045,7 +2065,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		if (!parent)
-			parent = iso_get_sock(&hcon->src, BDADDR_ANY,
+			parent = iso_get_sock(hdev, &hcon->src, BDADDR_ANY,
 					      BT_LISTEN, NULL, NULL);
 
 		if (!parent)
@@ -2182,7 +2202,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
 		if (sk && !ev1->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
@@ -2194,7 +2214,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev1a = hci_recv_event_data(hdev, HCI_EV_LE_PAST_RECEIVED);
 	if (ev1a) {
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid_past, ev1a);
 		if (sk && !ev1a->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1a->sync_handle);
@@ -2207,7 +2227,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
 		/* Check if BIGInfo report has already been handled */
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECTED,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_CONNECTED,
 				  iso_match_sync_handle, ev2);
 		if (sk) {
 			sock_put(sk);
@@ -2216,10 +2236,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		}
 
 		/* Try to get PA sync socket, if it exists */
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECT2,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_CONNECT2,
 				  iso_match_sync_handle, ev2);
 		if (!sk)
-			sk = iso_get_sock(&hdev->bdaddr, bdaddr,
+			sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr,
 					  BT_LISTEN,
 					  iso_match_sync_handle,
 					  ev2);
@@ -2258,7 +2278,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		u8 *base;
 		struct hci_conn *hcon;
 
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sync_handle_pa_report, ev3);
 		if (!sk)
 			goto done;
@@ -2308,7 +2328,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			hcon->le_per_adv_data_len = 0;
 		}
 	} else {
-		sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, BDADDR_ANY,
 				  BT_LISTEN, NULL, NULL);
 	}
 
-- 
2.51.0

