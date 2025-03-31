Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4E41760
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410168; cv=none; b=Y4HOLOpmt7q3Y+9yk1m/iDNTvH0N739AQM83Whahp4NxCbB7J6pYV9UHcnx6zc3GJI6H7TY0617ZU/R3ESTzzY7gJnP8R8uB0AUYM1zS+xsTjhnaBM3puWMVm/fVvnb8FOx7cL7V8Ev7cIteQQpunzcE2hMKry7goju9uzNtJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410168; c=relaxed/simple;
	bh=Mhn9yKtm87ipdObZvgKYxUhE+zR0GVeV9H9Uos0pht8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PnIPfZ7wMzZzF0lzoWGfu+N6SdIFgt88z57r0af1rSpSLUYrvgavAULde6FjVvcXYqFSA50PQHapdx/BHl0DvzA4stC77TU5aix6LRUO9ZoQvOZwUo/5s2h5rtG647BHQPIBtkbGd9uwZQUNmcXfMBQroZDLFBwAIHC23yE++xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYayCFMc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYayCFMc"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225107fbdc7so75598785ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743410166; x=1744014966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MKeMpxUnr+//+9lo+N74iCSg/prnlHMe/OAFpG5wj60=;
        b=FYayCFMcRhTY5Ai2N+OdyDYyLOttZoWMdE4g1eEtGHdDNOOBmds68DF0OBgBsoA65f
         ph9fiEM5KPytm2tMMkBtUE7Fss0AgeKGPqT075NsYfh/Ou8GU5Qs+fhAP5jJLWygGdlz
         G5vXegR1v3mXY6KNCEAkIESpe6Ht9PKf5RpaMn2rAP1EuCBLnN101F5Nax1lnxo4M5je
         vOI9H1ZY9yJ6em+YW4mU9BaYV+Omeqq83tcrBG01f4BXI4pliETRpZ24w51geRunCXH6
         hyUw1/BffPEi1OcNZkdXyeoqsNfCtegTxwWaRHwIOgnXmr5J5uUUtiZIFa0fhOre1T1j
         nMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743410166; x=1744014966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MKeMpxUnr+//+9lo+N74iCSg/prnlHMe/OAFpG5wj60=;
        b=wzPghk+C+AuMExnzFAZIjnkJUrmJWL2vkeiZcYJdPIr7z+rFUc6EPrHibwwngjCTGR
         T/NwAG23lB504tbI9us0/1JhDf26NvgFFux7yBmMCQVzsQKxRyLdfH8E9t//W0LVudBv
         FkWGrvspEr0gf+nsT9eaAiegEFtHeWuCIQscNQpptrEDGjdhGuB/VziMhzde+bLBAlk3
         z6+SeNIkWUaUiRzoHLkGYF3KgYCXzqcyfaUppxbqe7KnxxuXQkSosyvL1zP9c4usf4YT
         6Q2BdFpuHrq5DrSbgotx5Yx4AOJQRoG8SMAXAlsfV+0emUDmGck6YdfKLOA80ieSeEH4
         Cdlg==
X-Forwarded-Encrypted: i=1; AJvYcCWFoQp1MVY63c7mSuD5uDFAFt9ZCVsxEi1M6i4yHTrDAmP3/vM12AJKfS4xp368n9Z8+ZR+9iXhpP5WUxCUROo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTo5XFpwG7etuslO3hLFP1hYqAoG7xAlMwQPlEaqKYPf+U8wfz
	sWOGi/fokPMiQr51FTnbLkdHC9AE6kPw55hGb3onkwsfYkzIyz52W8eteYek9GnQYyHFCT8z0XO
	X58ZxCA==
X-Google-Smtp-Source: AGHT+IEA44RU4N4ESkiu5d9YAa5ebPxUjvOFQ2Sa1DBOHp7f0Kicg0TVlqyWmK5zlTK19+ssiQoyH9P+cQJI
X-Received: from plbw11.prod.google.com ([2002:a17:902:d3cb:b0:223:5416:c809])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d548:b0:223:5ca1:3b0b
 with SMTP id d9443c01a7336-2292f9f1990mr139468345ad.40.1743410165825; Mon, 31
 Mar 2025 01:36:05 -0700 (PDT)
Date: Mon, 31 Mar 2025 16:33:01 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250331083523.1132457-1-chharry@google.com>
Subject: [PATCH] Bluetooth: btusb: Reset altsetting when no SCO connection
From: Hsin-chen Chuang <chharry@google.com>
To: luiz.dentz@gmail.com
Cc: Hsin-chen Chuang <chharry@chromium.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Although commit 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting
for HCI_USER_CHANNEL") has enabled the HCI_USER_CHANNEL user to send out
SCO data through USB Bluetooth chips, it's observed that with the patch
HFP is flaky on most of the existing USB Bluetooth controllers: Intel
chips sometimes send out no packet for Transparent codec; MTK chips may
generate SCO data with a wrong handle for CVSD codec; RTK could split
the data with a wrong packet size for Transparent codec.

To address the issue above btusb needs to reset the altsetting back to
zero when there is no active SCO connection, which is the same as the
BlueZ behavior, and another benefit is the bus doesn't need to reserve
bandwidth when no SCO connection.

This patch adds a fixed-size array in btusb_data which is used for
tracing the active SCO handles. When the controller is reset or any
tracing handle has disconnected, btusb adjusts the USB alternate setting
correspondingly for the Isoc endpoint.

The array size is configured by BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES.
If the size is set to zero, the auto set altsetting feature is disabled.

This patch is tested on ChromeOS devices. The USB Bluetooth models
(CVSD, TRANS alt3 and alt6) could pass the stress HFP test narrow band
speech and wide band speech.

Cc: chromeos-bluetooth-upstreaming@chromium.org
Fixes: 75ddcd5ad40e ("Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 drivers/bluetooth/Kconfig |  18 ++++--
 drivers/bluetooth/btusb.c | 116 ++++++++++++++++++++++++++++++--------
 2 files changed, 105 insertions(+), 29 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 7771edf54fb3..5c811af8d15f 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -56,17 +56,23 @@ config BT_HCIBTUSB_POLL_SYNC
 	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
 	  default.
 
-config BT_HCIBTUSB_AUTO_ISOC_ALT
-	bool "Automatically adjust alternate setting for Isoc endpoints"
+config BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES
+	int "Automatically adjust alternate setting for Isoc endpoints"
 	depends on BT_HCIBTUSB
-	default y if CHROME_PLATFORMS
+	default 2 if CHROME_PLATFORMS
+	default 0
 	help
-	  Say Y here to automatically adjusting the alternate setting for
-	  HCI_USER_CHANNEL whenever a SCO link is established.
+	  Say positive number here to automatically adjusting the alternate
+	  setting for HCI_USER_CHANNEL whenever a SCO link is established.
 
-	  When enabled, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE packets
+	  When positive, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE packets
 	  and configures isoc endpoint alternate setting automatically when
 	  HCI_USER_CHANNEL is in use.
+	  btusb traces at most the given number of SCO handles and intercepts
+	  the HCI_EV_DISCONN_COMPLETE and the HCI_EV_CMD_COMPLETE of
+	  HCI_OP_RESET packets. When the controller is reset, or all tracing
+	  handles are disconnected, btusb reset the isoc endpoint alternate
+	  setting to zero.
 
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5012b5ff92c8..31439d66cf0e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -34,7 +34,7 @@ static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
 static bool enable_poll_sync = IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC);
 static bool reset = true;
-static bool auto_isoc_alt = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT);
+static bool auto_isoc_alt = CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES > 0;
 
 static struct usb_driver btusb_driver;
 
@@ -907,6 +907,8 @@ struct btusb_data {
 	__u8 cmdreq;
 
 	unsigned int sco_num;
+	u16 sco_handles[CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES];
+
 	unsigned int air_mode;
 	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
@@ -1118,40 +1120,108 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
-static void btusb_sco_connected(struct btusb_data *data, struct sk_buff *skb)
+static void btusb_sco_changed(struct btusb_data *data, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *) skb->data;
-	struct hci_ev_sync_conn_complete *ev =
-		(void *) skb->data + sizeof(*hdr);
 	struct hci_dev *hdev = data->hdev;
-	unsigned int notify_air_mode;
 
-	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT)
-		return;
+	if (data->sco_num > CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES) {
+		bt_dev_warn(hdev, "Invalid sco_num to HCI_USER_CHANNEL");
+		data->sco_num = 0;
+	}
 
-	if (skb->len < sizeof(*hdr) || hdr->evt != HCI_EV_SYNC_CONN_COMPLETE)
+	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT || skb->len < sizeof(*hdr))
 		return;
 
-	if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
-		return;
+	switch (hdr->evt) {
+	case HCI_EV_CMD_COMPLETE: {
+		struct hci_ev_cmd_complete *ev =
+			(void *) skb->data + sizeof(*hdr);
+		struct hci_ev_status *rp =
+			(void *) skb->data + sizeof(*hdr) + sizeof(*ev);
+		u16 opcode;
+
+		if (skb->len != sizeof(*hdr) + sizeof(*ev) + sizeof(*rp))
+			return;
+
+		opcode = __le16_to_cpu(ev->opcode);
+
+		if (opcode != HCI_OP_RESET || rp->status)
+			return;
+
+		bt_dev_info(hdev, "Resetting SCO");
+		data->sco_num = 0;
+		data->air_mode = HCI_NOTIFY_DISABLE_SCO;
+		schedule_work(&data->work);
 
-	switch (ev->air_mode) {
-	case BT_CODEC_CVSD:
-		notify_air_mode = HCI_NOTIFY_ENABLE_SCO_CVSD;
 		break;
+	}
+	case HCI_EV_DISCONN_COMPLETE: {
+		struct hci_ev_disconn_complete *ev =
+			(void *) skb->data + sizeof(*hdr);
+		u16 handle;
+		int i;
+
+		if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
+			return;
+
+		handle = __le16_to_cpu(ev->handle);
+		for (i = 0; i < data->sco_num; i++) {
+			if (data->sco_handles[i] == handle)
+				break;
+		}
+
+		if (i == data->sco_num)
+			return;
+
+		bt_dev_info(hdev, "Disabling SCO");
+		data->sco_handles[i] = data->sco_handles[data->sco_num - 1];
+		data->sco_num--;
+		data->air_mode = HCI_NOTIFY_DISABLE_SCO;
+		schedule_work(&data->work);
 
-	case BT_CODEC_TRANSPARENT:
-		notify_air_mode = HCI_NOTIFY_ENABLE_SCO_TRANSP;
 		break;
+	}
+	case HCI_EV_SYNC_CONN_COMPLETE: {
+		struct hci_ev_sync_conn_complete *ev =
+			(void *) skb->data + sizeof(*hdr);
+		unsigned int notify_air_mode;
+		u16 handle;
 
+		if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
+			return;
+
+		switch (ev->air_mode) {
+		case BT_CODEC_CVSD:
+			notify_air_mode = HCI_NOTIFY_ENABLE_SCO_CVSD;
+			break;
+
+		case BT_CODEC_TRANSPARENT:
+			notify_air_mode = HCI_NOTIFY_ENABLE_SCO_TRANSP;
+			break;
+
+		default:
+			return;
+		}
+
+		handle = __le16_to_cpu(ev->handle);
+		if (data->sco_num
+		    == CONFIG_BT_HCIBTUSB_AUTO_ISOC_ALT_MAX_HANDLES) {
+			bt_dev_err(hdev, "Failed to add the new SCO handle");
+			return;
+		}
+
+		bt_dev_info(hdev, "Enabling SCO with air mode %u",
+			    ev->air_mode);
+		data->sco_handles[data->sco_num++] = handle;
+		data->air_mode = notify_air_mode;
+		schedule_work(&data->work);
+
+		break;
+	}
 	default:
-		return;
+		break;
 	}
-
-	bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode);
-	data->sco_num = 1;
-	data->air_mode = notify_air_mode;
-	schedule_work(&data->work);
 }
 
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
@@ -1161,9 +1231,9 @@ static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
-	/* Configure altsetting for HCI_USER_CHANNEL on SCO connected */
+	/* Configure altsetting for HCI_USER_CHANNEL on SCO changed */
 	if (auto_isoc_alt && hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
-		btusb_sco_connected(data, skb);
+		btusb_sco_changed(data, skb);
 
 	return data->recv_event(data->hdev, skb);
 }
-- 
2.49.0.472.ge94155a9ec-goog

