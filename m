Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00F33E1
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505691; cv=none; b=mUY5xY8dl8i4M5fZ3429F1RdiDKDxohryPVDUPPZE6L3xhfwv5YpeqiJCxNAYACeY/rMZWiLHvS85JcsgwjLGdXUyKPAAL7jVZVgglegbHsQ8Q71KnDCuZZ9YBpeR/YCMTHb5L7kF9G5j8yROwhlLW/KE7NCvFPzxjuAwH9hhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505691; c=relaxed/simple;
	bh=zGtgDUR9VtMROpK0ZX1uqDneIt4+fLOC8foI051up3Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2fu+OaYpfq6EMonxvA+HpIgByoEyT/Ta1NIyREMjj8y68WlC7/f1/Hzdvt8TIDaLvoQL6n90E+WqS+LCw08SYiWqYG1I6kWLvRZPu9z3Vq3xuUwq3X/Ks7HXS47NbjZdDGVVYpaa+ym12Xd6cuZHQdKJA33fewaj9SGOX3IZts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk1dbkP1; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk1dbkP1"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-580144a31b0so1175313137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Oct 2025 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759505687; x=1760110487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szqXrn6YauNNOurr49C9R4j3WxW+HMXarXBRz6qG8j4=;
        b=Dk1dbkP1VxPYwnjm3uxgwYd3GM4bkmyV3Lb79PPoiR+ZrD9aCrO7EIj2WTzj/2xazo
         DDtAECDcaoeSmMOa7Er9bScNoYVTSewu3Y6DpNmsr1aHu3LOhvC7n9AhXfOivzHEFzNw
         RO3KQsW99SO+6w2sVCV6VixEHVnSmYONzB7cwOhXs3PBoF5VOMhJZXpZEZkbR8ufA9cS
         tiI8dbIhoW/W/fXTozXMOIu+iKyPrMpiKOeG4grR98zahiOqaVR4EVaFDC6Upe5Pndwc
         gMhzEoNUMUUC/wwJRKAfGg5bNeuW/ENs2fVfLHpcXS2z/yIlBwwfUlcZQX+j02RfL9hw
         tL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759505687; x=1760110487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szqXrn6YauNNOurr49C9R4j3WxW+HMXarXBRz6qG8j4=;
        b=Dpt6RlwZyVZaGO6NtwBnSDmDRLJv14XELah3HjiWgIeJzKnexlf4xF9CgRIBYlPd76
         KbKmjcHAp6v0tzMr9OYiwsjOq4QIxS9qBeZB2YSzpUaIXFRRd6Acq3aS0TmboYwivjWE
         WbFv0E9hejSuJZhaoJnMscPklZph9VbIi2S+aERuuXZawy6XnTi4+2/xJ8qQQfzk/MyC
         wq1XprSVv1lnynM1aSavXXZtBE+lhKxVjF8ruRfYdiWVzjpAduUcZHjhJMiNU1Y+kKTY
         dy+x7M9zUb+JObYdQdDn/3y8h/GCGjNWM3NsQ82RWYaQVe+TLVgaIdPwvrNboTCLmD5C
         MwSA==
X-Gm-Message-State: AOJu0YxW8p3d7oAEaUQRaNYsDhhLrbhSfwXbFlJ6qWkgRyLtlFo6RGzl
	4A/m+SM0tmbnOF7JCdgYZm35WOOBo4hPqMNLSRUgvFG/aIMNbqvMIBDMEonJTSiS
X-Gm-Gg: ASbGncv2EsRkr+lOonjiepuBrxzZgwDfUnU2JRLqH9/BDUxwXvJwWjnV1qOBEAs/YI/
	74z7DckaC/Q59Vrcb6SaxkcAXnGq5ebIY9OyGt/oMI0u135IpDFcC9zsasB2vJPlksslr8eMhn+
	FxmaP4f5ldkN7hJiQc9R0AdhhFFPCxBH6GRWLUZlvsVibeT3/kT+XYUi4JJaSMAn3WattmacRfH
	mFaRfTOYnRU1lLKTWO3YwjG6fOM9gvPr+UbcgGQGNJ7KJ/ZJLAuoVGJDEEy2ZGb4BTwG7tyh6Xd
	Uz2lqrl473yJF+eo0sCPQew0XvXOoKlrpE5J/ZTUfH1lUIJQItR6nFdNRd2TbqULz5prkHSVRF6
	C4/BeXuD3TFipgTrPp7f4YglvnCY/JPUah7Jho4Xko77MWGR9O+6VtsPTBgGQfySGDqzPeLDfXp
	+YNZfL8+V5XZmIhw==
X-Google-Smtp-Source: AGHT+IElqN/TgojVRH4NLRBvb2Am45moUecQL/66S0QwK6tjPFjdl75uR7MedbeP8qfFU4ijhuj1Dw==
X-Received: by 2002:a05:6102:3749:b0:59c:5e29:dd8d with SMTP id ada2fe7eead31-5d41d144e9cmr1328230137.28.1759505686644;
        Fri, 03 Oct 2025 08:34:46 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb67dec87sm994090241.11.2025.10.03.08.34.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:34:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 5/5] Bluetooth: ISO: Attempt to resolve broadcast address
Date: Fri,  3 Oct 2025 11:34:24 -0400
Message-ID: <20251003153424.470938-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003153424.470938-1-luiz.dentz@gmail.com>
References: <20251003153424.470938-1-luiz.dentz@gmail.com>
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
index 318b5b914cc4..2b1e034d1b7d 100644
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
@@ -1976,6 +1993,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_ev_le_per_adv_report *ev3 = NULL;
 	struct hci_conn *hcon;
+	struct hci_dev *hdev;
 
 	BT_DBG("conn %p", conn);
 
@@ -1986,13 +2004,15 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -2000,12 +2020,12 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -2013,7 +2033,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 			ev2 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
 			if (ev2)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_sid, ev2);
@@ -2021,7 +2041,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 			ev3 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PER_ADV_REPORT);
 			if (ev3)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_sync_handle_pa_report,
@@ -2029,7 +2049,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		if (!parent)
-			parent = iso_get_sock(&hcon->src, BDADDR_ANY,
+			parent = iso_get_sock(hdev, &hcon->src, BDADDR_ANY,
 					      BT_LISTEN, NULL, NULL);
 
 		if (!parent)
@@ -2166,7 +2186,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
 		if (sk && !ev1->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
@@ -2178,7 +2198,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev1a = hci_recv_event_data(hdev, HCI_EV_LE_PAST_RECEIVED);
 	if (ev1a) {
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid_past, ev1a);
 		if (sk && !ev1a->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1a->sync_handle);
@@ -2191,7 +2211,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
 		/* Check if BIGInfo report has already been handled */
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECTED,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_CONNECTED,
 				  iso_match_sync_handle, ev2);
 		if (sk) {
 			sock_put(sk);
@@ -2200,10 +2220,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
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
@@ -2242,7 +2262,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		u8 *base;
 		struct hci_conn *hcon;
 
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sync_handle_pa_report, ev3);
 		if (!sk)
 			goto done;
@@ -2292,7 +2312,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			hcon->le_per_adv_data_len = 0;
 		}
 	} else {
-		sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, BDADDR_ANY,
 				  BT_LISTEN, NULL, NULL);
 	}
 
-- 
2.51.0

