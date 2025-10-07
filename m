Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6C3A1D2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876342; cv=none; b=YfRu04LWfEYRasrmORlGnx3ngQ/bzP9K7jkZlLS4kyl/e4I4daKZ8xJbBg0FKMRqVTGwp+sqkEPVWQfoec/08y3JNqEYHhSHObpiT3GdItaF8P5Nxel+qm5u8Gf5NUJ0+yMsUJXwBmPmzCNFUMFPwmwCnn2SjCusRRa8SUFgQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876342; c=relaxed/simple;
	bh=RLNLboCKaia0PLpXXFpjChV7/X5PEa4hIcx3rJ++Cb4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot1IZwkUVyAE8cKxHxuKPP62o80+e+Y+eK9y2G5W4hJTNpEm9/nT6pXjjODwi8/0zcn3ly8ph26WiS9fqo7gS7045rcoEBvQw+1vuojV11IwCIQAPdnleGY0Q7pvJLyBdzeb+Yywqnz3qQpNB1Ky+yZdVDCVe7MrZcaStCmqzV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD/omAcM; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD/omAcM"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-583a520bd81so3266703137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759876339; x=1760481139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Zpd8y9YX2ZnTTlE+gGk2mUU4S5UVziYMcD43NLCnT8=;
        b=cD/omAcME+JzZDk0VHiBDehX6fhhF81E8m/VDDYp4AAdbUN7w/OkqTQUhufm448PsV
         RYkaZascW+ng026dWZVlvOUj6lhfuf/J7K3YWvLFeYeKYNnns8SDETe2ygUhiqA51DYM
         cvTWOoHaz4MQJbzUH/Ft7YSxZEHjH+JeJgkJtMtqeKdGmMBlc+zqZ/PcnThofdSdn6ix
         9ET6ovtjHrBx60IM8/zC6sePc7+Ty32u2qGQtXA6CBtEsBHkAsyFRkh3wWbbUVQBd5H+
         qoX/ymVNfS7kwDRubr/DX6aYwc951Kb32ELE/rOh4TdVaj7SIHpjtB7bYnDzq9pm7lIl
         2RxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876339; x=1760481139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Zpd8y9YX2ZnTTlE+gGk2mUU4S5UVziYMcD43NLCnT8=;
        b=AvRgYNhcFMDJzmIaT32UMdNSXWsT3DdZf8QtRr6GAwajLTgduvE8gqt7WuXHIo5tZX
         4oU+j2htIp4uzjVmlBl5UboWThGhiaICwLJUAdrx76uba1NsYxf3t523yLJMNJnZ5jii
         xRY6GQt4wD39VY7Luvn3liVeVvLSIsnGsQoWERKs2DT1xOoNU9Gz7+Vaoe/TjCSoy7PD
         jbFhTP6g2NMHlK6jqKehH7ZpkpnHByN9sjF8GnDklCZWSrIHUGVLnu/Y3cShYS3iEj8t
         /ijbpjnknZrtgzHFW5ayjdcVrR2euw2l0+BXz6PUjBxiAlI/Y1PT21eEOsWEuaYmLsdu
         nkMQ==
X-Gm-Message-State: AOJu0YywpnPDhxuurH5eybJ0DfLsKcV+vQyzYLXhKVFux5WHFJyPOc8Z
	QKwsQ9rTAdFc2DeyVl1E33CalU7iWjCNcR0tevLcxnKvn0y5scXH307BkWe0T2+S
X-Gm-Gg: ASbGncuXu6RKwrzV90d+Uh41ltTAHRvAIklI1qrx3onJ9x4tISM+esym8juhy626oAT
	FABLQHprA/43hIOiSLzc+dagmEqN58IqLvPLhioZuZagSxTf38lTgg4/qU9Wf0uGnPfO327ehMU
	ytp1Awhigezzyo/uqgL04VmZDfwqq1oSTUBICfXD1jIb4Cwtd2ceveEDHqiPPnVIZRMzMsPe/cU
	ZIJNoDYTx8Ar0BAMqPMP3blnv3rW+fMxNmfOxp1mLGKj5BwEnWnIi8JcC86qIKVxotwAOl7Utu4
	GWOxYRIP1HvwfkwEikUtwT25qkxRherGwtL1jcaLnKtnBL+opkEsUl9EhJ9HA3bPj0HiXZ49K33
	UyKYUwShi3YJNI9WENDZx2a4HSsk8cUE+w5V9+32kirpT3jFeVoxiHwtGNt8LNKXuQUg4uAibbt
	M79ARARE8kWaF5MQ==
X-Google-Smtp-Source: AGHT+IFL9YVO37KG8uYGHC1QeKnhGVh9J5OnOuv+vzK/BcCjkvrTSJWU5B4v1pp4tnBDebGkTndFhg==
X-Received: by 2002:a05:6102:5a90:b0:520:a44f:3dd6 with SMTP id ada2fe7eead31-5d5e224eb70mr556938137.8.1759876338648;
        Tue, 07 Oct 2025 15:32:18 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-92eb4da21c3sm3859567241.7.2025.10.07.15.32.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:32:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/8] Bluetooth: ISO: Attempt to resolve broadcast address
Date: Tue,  7 Oct 2025 18:31:52 -0400
Message-ID: <20251007223155.1539954-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007223155.1539954-1-luiz.dentz@gmail.com>
References: <20251007223155.1539954-1-luiz.dentz@gmail.com>
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
index 7cafb0bdb636..3283139b3e7b 100644
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
@@ -2005,6 +2022,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
 	struct hci_ev_le_per_adv_report *ev3 = NULL;
 	struct hci_conn *hcon;
+	struct hci_dev *hdev;
 
 	BT_DBG("conn %p", conn);
 
@@ -2015,13 +2033,15 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -2029,12 +2049,12 @@ static void iso_conn_ready(struct iso_conn *conn)
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
@@ -2042,7 +2062,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 			ev2 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
 			if (ev2)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_sid, ev2);
@@ -2050,7 +2070,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 			ev3 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PER_ADV_REPORT);
 			if (ev3)
-				parent = iso_get_sock(&hcon->src,
+				parent = iso_get_sock(hdev, &hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
 						      iso_match_sync_handle_pa_report,
@@ -2058,7 +2078,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		if (!parent)
-			parent = iso_get_sock(&hcon->src, BDADDR_ANY,
+			parent = iso_get_sock(hdev, &hcon->src, BDADDR_ANY,
 					      BT_LISTEN, NULL, NULL);
 
 		if (!parent)
@@ -2195,7 +2215,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid, ev1);
 		if (sk && !ev1->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
@@ -2207,7 +2227,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev1a = hci_recv_event_data(hdev, HCI_EV_LE_PAST_RECEIVED);
 	if (ev1a) {
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sid_past, ev1a);
 		if (sk && !ev1a->status) {
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1a->sync_handle);
@@ -2220,7 +2240,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
 		/* Check if BIGInfo report has already been handled */
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECTED,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_CONNECTED,
 				  iso_match_sync_handle, ev2);
 		if (sk) {
 			sock_put(sk);
@@ -2229,10 +2249,10 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
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
@@ -2271,7 +2291,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		u8 *base;
 		struct hci_conn *hcon;
 
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, bdaddr, BT_LISTEN,
 				  iso_match_sync_handle_pa_report, ev3);
 		if (!sk)
 			goto done;
@@ -2321,7 +2341,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			hcon->le_per_adv_data_len = 0;
 		}
 	} else {
-		sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
+		sk = iso_get_sock(hdev, &hdev->bdaddr, BDADDR_ANY,
 				  BT_LISTEN, NULL, NULL);
 	}
 
-- 
2.51.0

