Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B651D5AD8
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676470; cv=none; b=F2NmvrSvN6xl7qm05xUdX/+gu8gAKFhYiaSn48X35+F27nS7bw3nqBQjUKverIHOe1gguvAVtQfyKoZVC6zGyM3hYm5FTIWlMF3Xb0Vtb1WV+PNdpFWthls3w/U3alo3tD+r1rTCOA//QMBy0BtmMxRVAW/q7A0eLpcvfRHHMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676470; c=relaxed/simple;
	bh=Mr065aLwDPpMSXCkDJTHsX4MEpWPWczv3U763+DNdoQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RpXyBVH8uLa05K2YXoaI18gq7jp0/3YnEok0lsbUgu00KekVg0jvFoFdfBj8gq9ei8ypyJnvF9+pTAY4Q4mZ+N1fiAPpsXHgyXbqjkhdkP6SqssYi1kI8FniloMF5KiB4OkEbPaZk8F3CiCGL7IR1z4taMm1nMpE2dlIl3CrtS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTdh0MwG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTdh0MwG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2210121ac27so23081985ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740676468; x=1741281268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/2doYlt7bdzob5FlYQ016oVEDcO5UET56vlV29hWHmI=;
        b=DTdh0MwGLHjrVkppqF/Qz+w7YimlbWOePcp4QiQP75dIi1p6x39AKzqE08ZIUgCMXT
         JlxcvflbRK1rYu131NUESDc2bfibofz/kdAViut9FAyJ2f2iZvPIB+MGPraMg2Wb8TA8
         JC4bGSMkoMpIUBymJtFWNL/hU+c6orfq61N2zbxrOXF27S3axv50ohA0X023Wa79erw7
         XPLjHaSoTVX5yLXBmX/llypW4610YD1/FJahiTcGCdZMI19FkwRFA2KemkiwA396mnZm
         awYsGjksuixt8wTAe/LDmNe5yGNMe37iJZK7TUWAjXbxm9/Ku9OuDklGOtFANUzYiDta
         iPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676468; x=1741281268;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2doYlt7bdzob5FlYQ016oVEDcO5UET56vlV29hWHmI=;
        b=OZSfX2hJgn40x3QmS2OugYkE+t/yX6O33xLUIroLALaDxRbc+DrnONqB2/jH21cYq0
         V5YbwEVJIAh3RwcMTZBxNIHzoGR7nrHRUh1RVbQncqSUD00q4xSflOKU6de8b5LqrNjd
         POVGbKos2QlZV0CF4FqtMyDTqorRyq8x/G/sidVEhUBDJdIM6jeIuV9KLkD1ngrsWzAa
         Y6PZr70i7PmVqEfG7EgiRMDGM8ftmlE4gNTNhd4vdeyR3lBhVz/FT8GMnU5pJtvW4Q0c
         3mlet+xMV7XrSg2c+fIf5b67sNdc5p07+Pix2QNbsqOCbpb/gB9EHzE9SnveMjwOcBrC
         saZg==
X-Gm-Message-State: AOJu0Yww1LGdSJ4rNBrv/AuEBClBlll4b/CL4gPopbIaj/0+pa9vLSqd
	gP41/Zp+/3CdxXrCt/bK24sSnTK8afRZLhnJtsslAjxtDxPlUV2+3+aaxX7nUS66wIKkGfZKUPa
	5CLbtSqUG7177yMOxUCrQV/pUiv6b2/sLBM54FzNHBftRgLT1ZBcp/eVfVrSKfECWqox/SIDOZS
	lrlkvmXkLhIGuiIaSc2MtJ1m7q7+kzUT92BiTfCkySxuWn/nFHng==
X-Google-Smtp-Source: AGHT+IEwv6PJSeFsIMmL862DeYroyv7Jeis8fMjb6uMUYkKB3jKARQbyNLzawIVamN5xRdF2vx6HN6J/jvUL
X-Received: from pfgt7.prod.google.com ([2002:a05:6a00:1387:b0:730:7d23:bc34])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:986:b0:730:8a0a:9f06
 with SMTP id d2e1a72fcca58-734ac419af8mr295236b3a.16.1740676468192; Thu, 27
 Feb 2025 09:14:28 -0800 (PST)
Date: Fri, 28 Feb 2025 01:14:10 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227171417.4023415-1-chharry@google.com>
Subject: [PATCH v3] Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org, pmenzel@molgen.mpg.de
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Automatically configure the altsetting for HCI_USER_CHANNEL when a SCO
is connected.

The motivation is to enable the HCI_USER_CHANNEL user to send out SCO
data through USB Bluetooth chips, which is mainly used for bidirectional
audio transfer (voice call). This was not capable because:

- Per Bluetooth Core Spec v5, Vol 4, Part B, 2.1, the corresponding
  alternate setting should be set based on the air mode in order to
  transfer SCO data, but
- The Linux Bluetooth HCI_USER_CHANNEL exposes the Bluetooth Host
  Controller Interface to the user space, which is something above the
  USB layer. The user space is not able to configure the USB alt while
  keeping the channel open.

This patch intercepts the HCI_EV_SYNC_CONN_COMPLETE packets in btusb,
extracts the air mode, and configures the alt setting in btusb.

This patch is tested on ChromeOS devices. The USB Bluetooth models
(CVSD, TRANS alt3 and alt6) could work without a customized kernel.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v3:
- Remove module parameter
- Set Kconfig to default y if CHROME_PLATFORMS

Changes in v2:
- Give up tracking the SCO handles. Only configure the altsetting when
  SCO connected.
- Put the change behind Kconfig/module parameter

 drivers/bluetooth/Kconfig | 11 ++++++++++
 drivers/bluetooth/btusb.c | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4ab32abf0f48..cdf7a5caa5c8 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
 	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
 	  default.
 
+config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
+	bool "Auto set isoc_altsetting for HCI_USER_CHANNEL when SCO connected"
+	depends on BT_HCIBTUSB
+	default y if CHROME_PLATFORMS
+	help
+	  Say Y here to enable auto set isoc_altsetting for HCI_USER_CHANNEL
+	  when SCO connected
+
+	  When enabled, btusb intercepts the HCI_EV_SYNC_CONN_COMPLETE packets
+	  and configures isoc_altsetting automatically for HCI_USER_CHANNEL.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de3fa725d210..2642d2ca885f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -34,6 +34,8 @@ static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
 static bool enable_poll_sync = IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC);
 static bool reset = true;
+static bool auto_set_isoc_alt =
+	IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
 
 static struct usb_driver btusb_driver;
 
@@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
+static void btusb_sco_connected(struct btusb_data *data, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *) skb->data;
+	struct hci_ev_sync_conn_complete *ev =
+		(void *) skb->data + sizeof(*hdr);
+	struct hci_dev *hdev = data->hdev;
+	unsigned int notify_air_mode;
+
+	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT)
+		return;
+
+	if (skb->len < sizeof(*hdr) || hdr->evt != HCI_EV_SYNC_CONN_COMPLETE)
+		return;
+
+	if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
+		return;
+
+	switch (ev->air_mode) {
+	case BT_CODEC_CVSD:
+		notify_air_mode = HCI_NOTIFY_ENABLE_SCO_CVSD;
+		break;
+
+	case BT_CODEC_TRANSPARENT:
+		notify_air_mode = HCI_NOTIFY_ENABLE_SCO_TRANSP;
+		break;
+
+	default:
+		return;
+	}
+
+	bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode);
+	data->sco_num = 1;
+	data->air_mode = notify_air_mode;
+	schedule_work(&data->work);
+}
+
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 {
 	if (data->intr_interval) {
@@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
+	/* Configure altsetting for HCI_USER_CHANNEL on SCO connected */
+	if (auto_set_isoc_alt &&
+	    hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
+		btusb_sco_connected(data, skb);
+
 	return data->recv_event(data->hdev, skb);
 }
 
-- 
2.48.1.658.g4767266eb4-goog

