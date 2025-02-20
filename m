Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C63214814
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088653; cv=none; b=huLX419xfkO37aIsobRbP3h6Z4eH1rI9TUdsyXm8IJ4I7rZrCMWio3/yKt4BUHg8v9ftBK4bkXTbKGaJPb8q3FvxaRaLkuzQ7n8cTxxC7eWSa0tGctGs4A721ZEC53OM0OyNrymqwtpW1C4rQCljrL+qEWRoCP1UpRjZvCJPsas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088653; c=relaxed/simple;
	bh=w2VFe+b515SNtn8iYU4tp/WTNRSgIP44ogk1z9iBXso=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c8n0g+7OBOLpl2Xf4R7r7dHzBwUFriBFFYTXeI5P+0AxuNjjK3+RrpheMJ478sV7lU4vz1WR0As8ls9Ms1h0DGEVCrxGx0pp74PAbgo2JCLT3dk1IQdUk6FjReeyLwBvBsr2x+6uiUv58yKTg+n7mrTJFqDF8dHVqX8CMwAoXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0TQf7PT; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0TQf7PT"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f8c58229f1so13494437b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 13:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740088649; x=1740693449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxdIpsQuH9Ers2l+YCE4Qzl2zhZPio97dbk66N84hdo=;
        b=C0TQf7PTGE2zoo7I6YgFgM/Lz+0F62J969V1DzndnnDZQhT4EhKlmAzCP7oABOTIcj
         aJd0cOvxs55DxVDwrjI70bc86kOaiPubF5XaeVarWq1E2H2KJM52D1C3WzM6CEDgoL3O
         bvZmP8hIFwm4fLoRzkDPdfTYuI5CWYngP0+KwK1X40Ixu1XxThI1IkvSa8E8WKKyWZ/p
         KnEzJIOyQGdX5DpYuNT8oTUEwNgGss520fImOJMARFkLVilaAQ8KJZa8h2MWvH3C+mOM
         q5g6BLSxch2Z4QvP3fLtBZIvD2GQN/2HUFICNe/PzD3mhH5aIoHHKyXq6bfQ7jRxEwit
         EGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740088649; x=1740693449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxdIpsQuH9Ers2l+YCE4Qzl2zhZPio97dbk66N84hdo=;
        b=Q0P8aypGbaFbdt/ZlVPs1DEG/dumS8VU5YSCPN1ev7RgBfb2QuO/XIO0Nk82N55AL2
         tj7crKF/HwtVUNPa3nzPUjtKIQp7AQsFvR2RhXSc4cDnly2KrljUkKBtSRqKe9wxuKqp
         dqb/wX/RaSaCmaEUyTesH+UnC4Eu1HbjT24ujxm8v+20hc4migQVkEHDxO9j9sRn5hXP
         5ck4ZjyBKjdu1x079bXIiy3uiWWa2EjZeYOiLeEnD7p4JcOLj6rxx6zP6igWharUBB2H
         Ia+fA7P/0gSIhq9I6v7gw1WCywjPWKBXhtXa9K0ymh0v8Hq4w3r/8G4lndqrVeqgLpir
         1Drw==
X-Gm-Message-State: AOJu0YwNI66L/qQ1aB9fOvvwmR3ZD3VcAWOgXIAF2nlqM4i3Un37PEFz
	0SKQfeHfiPEypFE+jidfvrQG8xoAh+/wYpulzPYLSnvf0wRS3oONWoODwL4U
X-Gm-Gg: ASbGnctTg6cxrvxWLLPk6Dv52j+X/ZRkyslj0WV81mbjrgvtCStPYuCSpxoNYHvYlbL
	Pg4aQMhXHbMqjilEX8zRyo8tw/MCRRIeydSTJy4rnfYxUaSMG9czpdpmsbOH2KlwDzrdgkkFrqt
	+xWvAkUVDmayNztBsgeoSre9sj9siLA7kCZiZ2M21AIWS0FUhvyCOakrQu8ncbu3Rtr4huYq4/Z
	xJf8fXrKwJ2i1odHevcnfx7qibhiwXCezYgHQC8VdHJn/O5+kcEW3fGyDZADrMDJE0yopny6/UX
	AiRjObTn0nSnZqSS44fBUf19Tz5phL+0L6aGghC7tqpBTVlY5SwWQMETqJ9DE5c=
X-Google-Smtp-Source: AGHT+IFfJuZYzaneuBR5S62I8g0v0g4xKtrI2aglKKtJ9BDIMDAYlZAj0PCIU/W04n3V43JTs57S4g==
X-Received: by 2002:a05:690c:6a0b:b0:6fb:5d74:959d with SMTP id 00721157ae682-6fbb78e24b0mr47939207b3.1.1740088649248;
        Thu, 20 Feb 2025 13:57:29 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb745ea173sm23754847b3.105.2025.02.20.13.57.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:57:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
Date: Thu, 20 Feb 2025 16:57:27 -0500
Message-ID: <20250220215727.2035833-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_core.c         | 15 +++++++++++++++
 net/bluetooth/hci_sync.c         | 23 +++++++++++++++++++++++
 4 files changed, 45 insertions(+)

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
index f756fac95488..6abe1115fa92 100644
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
index e7ec12437c8b..a0a14fb8a496 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3564,11 +3564,19 @@ static void hci_sched_sco(struct hci_dev *hdev)
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(hdev, skb);
 
+
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
+	if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+		hdev->sco_cnt = hdev->sco_pkts;
 }
 
 static void hci_sched_esco(struct hci_dev *hdev)
@@ -3588,11 +3596,18 @@ static void hci_sched_esco(struct hci_dev *hdev)
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
+	if (hci_dev_test_flag(hdev, HCI_SCO_FLOWCTL))
+		hdev->sco_cnt = hdev->sco_pkts;
 }
 
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dd770ef5ec36..42ee9c5e11ad 100644
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

