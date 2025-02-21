Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B271EE028
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170963; cv=none; b=McFUz1mR39rSGDKnr2rOnoeek1FHXlLRMgNBBFuehjsrIFelGVwOZre881eIkdWLq9K0I0FgUewtE4jw7RTmRBj8z6+c9O9UkmFDkpEll6LABLTiTST6gIoFBcD/JTPn/n83Sb6HULTmeASe0mCh7CS/1K1I70msf13hJy+1kgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170963; c=relaxed/simple;
	bh=9DnQlynvFu5gLd06Osgo0IusFJ1+/FI3OBGStZv+bY4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XgX70U+d3OacD+YIvtupjac0A2MlYtaoNCNtJUlhSfFqHcxLrtNFE3jrVfrv7zYxtybOy+pES6QZREpG0Xq9lg9r2ZqH7ES+sc/kpkeDxUaZPYiUTl1v/feo1sYsKtbLvVoXDQjj49Ag4YJhH/+ia8ho4YZBiILoYGF+JWIajIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGxxdCL2; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGxxdCL2"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f4434b5305so22129507b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 12:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740170959; x=1740775759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9AmBfQI44WerTmsnl0Rh08N45dFPhdNNHQusqI5oVRQ=;
        b=nGxxdCL2TSfllkK9GZ2TpsOM/32S4H8LqBAidu3sGGa5tfiqImNK+V4OuFIfl4Uj2U
         4fUE4wpr77Pe8eZtpzDomqFAyOsmJBr2gcBWivvxChRhHCxpCigToU0dnWq1rxe7g7k+
         PjXotSxpt99MUrqaV8+cxBpFx1rFzIHPJwWILrzXo2ydb8kRbQ0PimfiQ7GobSVqaNg6
         4kKZtSArN+VGZEpnC9QoYB9g8tib0A8bU4E/4Ye4sTPDrS836ANGcA5ukTHJcaj+ddkR
         T68nuTkr77XmOo5jY0Anv0Y5VBWrRLaSNVvmfDmI1iK5FQUlIwSkde5Ts+FoRhy866vE
         rRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170959; x=1740775759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9AmBfQI44WerTmsnl0Rh08N45dFPhdNNHQusqI5oVRQ=;
        b=gkuuozmMgtXjGRuKfJF69c9hpbeKDbpKktVpV2vWd10tFRKwzHxgXj+LZaUjRRqGwj
         GDPmdzi1F934fXXJjkGP15EH1ZT7kf0tUr1ZMmTm5aAz8+ScZiHK4rUZXyRp/uVBJ+Ep
         KQYy43HH76MUtanJHnMClNNH9XHDsfZRlOsqkSRUCORT1Yu5vbBWCRh5qFoKTlRyrpEp
         9d9bJf+ZxYl2QbNXjI9xfcc+Dz9/aC6+koUzyI0D+C2wCKO1YCHbE8gDXUBJ/uNARAiG
         GPpatnfaU2kNF5qFYepB0KwvZfuZrTTXP1+LQIXLygcfsBEmLeoZ5/CdhIeG8a4U4CcE
         Z7Zw==
X-Gm-Message-State: AOJu0Yx14u1+vmZdh8v3O6gy8d2WfRl+Fb40kDj2IN2T8KJNdZ7NiTR9
	9uyuZSu2ULnbkChk6+6X3gp25/9TvhmAY0afO5mRTWjKffgZdWRZT1pZggxz
X-Gm-Gg: ASbGncunzPXadR45WQRBMIU48SIKudnuRsKqJjs5exP+ND4mRB4nc7/y1DSw72EE8io
	VwCkdOLdcnFqWl33AKvDwq6uaZuyYWC3oiz6pIqSteydxB3o0yLFXDfiOwYl+mJ/Mj4HOpITFWm
	K1U4it1YNQ+2h6cy/IH+zfzio8Xo79HOuCDDKNYiCwgfbDLI+yu9HK9OnQS7eSYhyRIWRWMfAD1
	kTYshNNU+fRjRdvicMPTu7hNkq5q9Ab614tIo/PcE0i1z5xtaAjcUe6Z4491QBW3ImusOsmzxOv
	jss1BDoINVKsTCDBENjlilpkXMfA+huwW7ztr9Ck4tpMJZwmNeHiETbB342MyP6Y1jqBCqZh8g=
	=
X-Google-Smtp-Source: AGHT+IE7dzgQsuCL5tVGWarZjps3bkGVAoDklsTdOKm96OFVf3tn8R/1E7Bm0ZudxhW8jUjp2RSfYQ==
X-Received: by 2002:a05:690c:6810:b0:6e3:37a7:8a98 with SMTP id 00721157ae682-6fbcc24420fmr46162617b3.14.1740170959087;
        Fri, 21 Feb 2025 12:49:19 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae10e0dcsm4951154276.53.2025.02.21.12.49.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:49:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Fri, 21 Feb 2025 15:49:16 -0500
Message-ID: <20250221204916.2217628-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables buffer flow control for SCO/eSCO
(see: Bluetooth Core 6.0 spec: 6.22. Synchronous Flow Control Enable),
recently this has caused the following problem and is actually a nice
addition for the likes of Socket TX complete:

< HCI Command: Read Buffer Size (0x04|0x0005) plen 0
> HCI Event: Command Complete (0x0e) plen 11
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 1021 ACL max packet: 5
        SCO MTU: 240  SCO max packet: 8
...
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
< SCO Data TX: Handle 257 flags 0x00 dlen 120
> HCI Event: Hardware Error (0x10) plen 1
        Code: 0x0a

Fixes: 7fedd3bb6b77 ("Bluetooth: Prioritize SCO traffic")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  6 ++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 28 ++++++++++++++++++++++++++++
 net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0d51970d809f..a6a375cf97f9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -432,6 +432,7 @@ enum {
 	HCI_WIDEBAND_SPEECH_ENABLED,
 	HCI_EVENT_FILTER_CONFIGURED,
 	HCI_PA_SYNC,
+	HCI_SCO_FLOWCTL,
 
 	HCI_DUT_MODE,
 	HCI_VENDOR_DIAG,
@@ -1528,6 +1529,11 @@ struct hci_rp_read_tx_power {
 	__s8     tx_power;
 } __packed;
 
+#define HCI_OP_WRITE_SYNC_FLOWCTL	0x0c2f
+struct hci_cp_write_sync_flowctl {
+	__u8     enable;
+} __packed;
+
 #define HCI_OP_READ_PAGE_SCAN_TYPE	0x0c46
 struct hci_rp_read_page_scan_type {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 05919848ea95..6247ae1802e5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1857,6 +1857,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_hold_capable(dev)      ((dev)->features[0][0] & LMP_HOLD)
 #define lmp_sniff_capable(dev)     ((dev)->features[0][0] & LMP_SNIFF)
 #define lmp_park_capable(dev)      ((dev)->features[0][1] & LMP_PARK)
+#define lmp_sco_capable(dev)       ((dev)->features[0][1] & LMP_SCO)
 #define lmp_inq_rssi_capable(dev)  ((dev)->features[0][3] & LMP_RSSI_INQ)
 #define lmp_esco_capable(dev)      ((dev)->features[0][3] & LMP_ESCO)
 #define lmp_bredr_capable(dev)     (!((dev)->features[0][4] & LMP_NO_BREDR))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e7ec12437c8b..18da9a466327 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3564,11 +3564,25 @@ static void hci_sched_sco(struct hci_dev *hdev)
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
+			hdev->sco_cnt--;
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
 		}
 	}
+
+	/* Restore sco_cnt if flow control has not been enabled as
+	 * HCI_EV_NUM_COMP_PKTS won't be generated.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
+		hdev->sco_cnt = hdev->sco_pkts;
+
+		/* As flow control is disabled force tx_work to run if there are
+		 * still packets left in the queue.
+		 */
+		if (!skb_queue_empty(&conn->data_q))
+			queue_work(hdev->workqueue, &hdev->tx_work);
+	}
 }
 
 static void hci_sched_esco(struct hci_dev *hdev)
@@ -3588,11 +3602,25 @@ static void hci_sched_esco(struct hci_dev *hdev)
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
+			hdev->sco_cnt--;
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
 		}
 	}
+
+	/* Restore sco_cnt if flow control has not been enabled as
+	 * HCI_EV_NUM_COMP_PKTS won't be generated.
+	 */
+	if (!hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL)) {
+		hdev->sco_cnt = hdev->sco_pkts;
+
+		/* As flow control is disabled force tx_work to run if there are
+		 * still packets left in the queue.
+		 */
+		if (!skb_queue_empty(&conn->data_q))
+			queue_work(hdev->workqueue, &hdev->tx_work);
+	}
 }
 
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a43749aebf76..727b6e3c1b7f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3766,6 +3766,27 @@ static int hci_write_ca_timeout_sync(struct hci_dev *hdev)
 				     sizeof(param), &param, HCI_CMD_TIMEOUT);
 }
 
+/* Enable SCO flow control if supported */
+static int hci_write_sync_flowctl_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_write_sync_flowctl cp;
+	int err;
+
+	/* Check if the controller supports SCO and HCI_OP_WRITE_SYNC_FLOWCTL */
+	if (!lmp_sco_capable(hdev) || !(hdev->commands[10] & BIT(4)))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = 0x01;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_WRITE_SYNC_FLOWCTL,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (!err)
+		hci_dev_set_flag(hdev, HCI_SCO_FLOWCTL);
+
+	return err;
+}
+
 /* BR Controller init stage 2 command sequence */
 static const struct hci_init_stage br_init2[] = {
 	/* HCI_OP_READ_BUFFER_SIZE */
@@ -3784,6 +3805,8 @@ static const struct hci_init_stage br_init2[] = {
 	HCI_INIT(hci_clear_event_filter_sync),
 	/* HCI_OP_WRITE_CA_TIMEOUT */
 	HCI_INIT(hci_write_ca_timeout_sync),
+	/* HCI_OP_WRITE_SYNC_FLOWCTL */
+	HCI_INIT(hci_write_sync_flowctl_sync),
 	{}
 };
 
-- 
2.48.1

