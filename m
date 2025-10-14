Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD522222B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760405612; cv=none; b=eYZr84BCfkmNy5Pc4MX1ZtcdrtFnq3nG1rOVydtfYKgKHMru6jL2tJ9AQ4ujbCd2Wy4kOtzLH/Ts2QnvEYEooq0DDLBq+fil5/v1vsn4PGGJytXNQlABJJgLq3TLoOcG2NeU5NqrLx/BT2UwDFcQ7xOOEjq9KxQ4ltw6nm45yCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760405612; c=relaxed/simple;
	bh=fDuyCYx+IWupCmRBLccUNiN3cp4J0MuEx6a2Dsd1lf4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uafJLL09ZNiZtCCcyLsuJQz4f/1Bnz0T7TdeWi1DXZv8aI68Vgq7JQBBMKrKKCD/8n8eNUNYE3hN9RdUJw9oUjw61RMIF1KMdsNn5vX1TQbma+kDc/id3PewsUnY9VO34TtLP7AT/T3vzCA70YhwveX8byfxjHpa7qiqW27pXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a28UpV9l; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a28UpV9l"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-54aa0792200so3477134e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 18:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760405609; x=1761010409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smfxOL0ww2kC3fI+VeVYxF106RCpMk7ax+gbCfvMTz0=;
        b=a28UpV9lb00Z1NWecgVUmgx05LLL28eYyTxCUnMxtzDVyWZ1+QW42mw3VdCETaAZNb
         mOSu6vtOr+Pd6fJPpcA9wJ378vOY59ytz4afbPlP43nclmpxWlFNQzSEROCOg4z6GTyO
         6gcMjUi1UvwwUzkTAz8tcCAXUxO/WiaiFoKLYeZPyl0ZdMyK/mKV80qDX8mk9/RbobXh
         RDZQQTNrTN0Jbcvxu6dc1WXZH045xnEpy/W4y2ve4cA2c0GK9VRwJ8x8aDoH3ZF1rRcq
         QtzWis0XyXcd7f8SytjvBWGvAo4JYnq93Q0oy3lfMMriSYSoGcLVeMwL49X9XJj01Znh
         I0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760405609; x=1761010409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smfxOL0ww2kC3fI+VeVYxF106RCpMk7ax+gbCfvMTz0=;
        b=j6GcprA2w8ul1qIaytA4kwAid7lS1AgKWMlREVNGuHqzQKrRA/ev1A/TwIjwwlyz6c
         IAMu93atW3VIBSS7kjwHPBcrnmUAS2NtqT3qx117/YPoPhVQ7p0cuHwfzHBYRMpRTdUF
         rxY2QnTJ1PK67EE++pqWOTOt24cP6f7SqdToLoj/igjvur59c0NHuxRcnMYFkcGLuikB
         taTv48ArRWTfX9NSseaPrKql2CfzH5Us3vknM1QX5GT4I91t2C91KE/X8GvaU9UArYzN
         9j6EcYYhA76yLLgNOA3xlhWObY1SwaQnjKyzqur/2zAqDfJodqtIWH/oKYTMX3yRYcpO
         kd3w==
X-Gm-Message-State: AOJu0YwcScIeTh4DwV4Muj1Cm/TwDBkMfNO+iWbc7xCMPoEsrMBA13cU
	ljPhBQktciTF3tqmhHf0t4YTs97zFlyvNpF+RwU+n2uvjIzc09SdA6rxLove2O/j
X-Gm-Gg: ASbGncvFoK57l/She9JfOZB4T+GCsemAU39jSZlNRchmG4hGhZkoHeXQrHl7CceXZqn
	YF8egEGh7cw6LVxgmAz0TWGFxPRbIcUYFPH4XuMn4vFD4ct+hCd8nGVD+vfhyJIBrhTOIh+HcwG
	CnZa7AnK/9Ta/+A6Xzc0/Q1Vt+OXmBpfuzJpQSBLG4oke0H7iFGizLFMRuNVCuPFi8gLDykYZGP
	I6xRYBfaRnH7WMPetgv0Lu0FBzLgk2rhLBqVNb9GItb7RTOoMNCJGP0KMKingQUt9vxw3m/iEF7
	kJlip/EnnrnkLAGtWY3AngFbegLNXeR2TN3ucSgjEb0l8N+TUwa5WZx94bGAFU/RjBX/eYomieG
	tmusog7oDo2ZRKHfUUP5oBgllblVG0N5LlM7N+Wa7q7OJ/baeUkvxWRRoODDIyqeN22Z42wf+zW
	S3TKuYZCg/F4n5LXTGMN4=
X-Google-Smtp-Source: AGHT+IGSHmtI/kpSoAzYCz49DrxI4c0POt5MHNU0ofyzGLxkTqehwFK5JqZ8+/XnFnOItFR8IIIueQ==
X-Received: by 2002:a05:6102:5e84:b0:5d4:1e69:fdbe with SMTP id ada2fe7eead31-5d5e21d6a6emr8701817137.3.1760405608648;
        Mon, 13 Oct 2025 18:33:28 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc7126c7sm3985806137.5.2025.10.13.18.33.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:33:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 5/8] Bluetooth: ISO: Attempt to resolve broadcast address
Date: Mon, 13 Oct 2025 21:33:05 -0400
Message-ID: <20251014013308.174151-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014013308.174151-1-luiz.dentz@gmail.com>
References: <20251014013308.174151-1-luiz.dentz@gmail.com>
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
index 302ed6b99cf2..bef3136f575f 100644
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
@@ -2012,6 +2029,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_ev_le_per_adv_report *ev3 = NULL;
 	struct hci_conn *hcon;
+	struct hci_dev *hdev;
 
 	BT_DBG("conn %p", conn);
 
@@ -2022,13 +2040,15 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -2036,12 +2056,12 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -2049,7 +2069,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 			ev2 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
 			if (ev2)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_sid, ev2);
@@ -2057,7 +2077,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 			ev3 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PER_ADV_REPORT);
 			if (ev3)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_sync_handle_pa_report,
@@ -2065,7 +2085,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		if (!parent)
-			parent = iso_get_sock(&hcon->src, BDADDR_ANY,
+			parent = iso_get_sock(hdev, &hcon->src, BDADDR_ANY,
 					      BT_LISTEN, NULL, NULL);
 
 		if (!parent)
@@ -2202,7 +2222,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
 		if (sk && !ev1->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
@@ -2214,7 +2234,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev1a = hci_recv_event_data(hdev, HCI_EV_LE_PAST_RECEIVED);
 	if (ev1a) {
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid_past, ev1a);
 		if (sk && !ev1a->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1a->sync_handle);
@@ -2227,7 +2247,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
 		/* Check if BIGInfo report has already been handled */
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECTED,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_CONNECTED,
 				  iso_match_sync_handle, ev2);
 		if (sk) {
 			sock_put(sk);
@@ -2236,10 +2256,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
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
@@ -2278,7 +2298,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		u8 *base;
 		struct hci_conn *hcon;
 
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sync_handle_pa_report, ev3);
 		if (!sk)
 			goto done;
@@ -2328,7 +2348,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			hcon->le_per_adv_data_len = 0;
 		}
 	} else {
-		sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, BDADDR_ANY,
 				  BT_LISTEN, NULL, NULL);
 	}
 
-- 
2.51.0

