Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F44154BE2
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740372764; cv=none; b=Gzd1LJARE1f6heUA4yfTGCeqa5P6MuTGPO3yYEGQFvLSUIuuc86mW1nQJnkP5Pry6oPEpOYrPHoCxF6pktrS5htZfI0826bZTXK7bgQkDXJi4YCCaAXZeHG+zUPdvZh1daylV98N7k7RMkSxzanupnJtJICkW5ynNQCvklk/SVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740372764; c=relaxed/simple;
	bh=4ewO9GEAjU8VymksNh1HeanRKAMGYkmUN6+pCWUNP5c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V+0pFoSiGHi2TfhkkkbK26Tv+VhCjI1gCb0sq+TYzZ/VUxmLPK6aeVCfleT2LY57YA8rX9yXfKE8hdXRKvgw35849XDGRGCc4jdJ8N4q548w6ac3nLm+k2bzgCRx6a9mOfi8di6TCJ5/YuJSe8L59SwL+mvVH6XzKqnzFa+LZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3axEW/J; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3axEW/J"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5fcebf94261so4949438eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2025 20:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740372762; x=1740977562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PmxTTK1F7dSErgDaLhSxA9yRMfDUTL/Vj39jUnWN9Sk=;
        b=b3axEW/JLFdgMvZkjU57GTIXKLp0dMN6Jt5dCrBW+IyxCWIwWCBzzBLmh6bBkDNEUP
         bkg6n2JCrcX4Bw+yToRTWdWWC3AZeQo9BQxJOXMfzcjfrNSVmeEG6PLgHbM/VEh6Kcv3
         tYcUNStXEwlk8FfXXXEDhfQmO+qDDojFw3KPgWArxXjuoc1NJ6qMrl8olQjM/4LpYqKX
         YK3kUATljU9Luhp2/YZlVaRPMJUovbam9sc+DCOy5zf5HAcGZC0MuIsiKKRJ6ZaxEZVD
         +RxnOtCb8UNNLYp/MEI2XAgTWkpiNN6O3EUQ7gQIAL9IVIF5AMGL97mRfPSQndAqckCP
         Kv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740372762; x=1740977562;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmxTTK1F7dSErgDaLhSxA9yRMfDUTL/Vj39jUnWN9Sk=;
        b=MnR1q+ilYjJH81z+51WCyGtuS22hD5dsOvRrkhXzMX/wBeRD8YRoyR5ZgWit8T2rYC
         ZL2XIHZ6gZafL80Y7Tr/liuvCSrL0j4ZEIvMLCAmiHaWbDXavMAukgzJdJrsArZlw7Yh
         +Prpf/k+E0RycO6flmg866YR2smoXQmhxAh7/6vZO+ZKk02vbk017OJzZryco2bU1NdQ
         2hKLPLlKXgNNhsaPE2gooc8xQUgcWykjz8OTPNzGjrfvFnNP5NQ1WiMbFaCIkQCXueG7
         KA/MUZdRx80Ol/eSnCDPLKCLsnxiF+m3BUnwLIfV8JWphntNW++HiYUBc5hOg9yYmzXy
         9VzQ==
X-Gm-Message-State: AOJu0Yw4Md03ah5rq3tIXa4Mq/BsMut2TNdSEkzsIE+Lb+TVCctOBckF
	2NhIB4+UbHOjzg9TKUoKrx95L+pwUMLYu56cUD/4MuDfpFaolX3iC8odoj9QvHT3dTBFii+TB6t
	n7waoa2DJLetJq/yQLVqEuZGHaNOUoSLp+Tii7q261fmJELZ5tCW9WAAK3vdal1adBNXo745gEv
	GNUQZe9dzN9xuEMzWRV7GgqJpEhlxLjbofCj/QGFsdaZaozbprnQ==
X-Google-Smtp-Source: AGHT+IHmiOE0rAabspT91c1Y+/mjCGIXjpQkKoKVT/U9XhPTUxj9X7kqSP/lBPacNY3NrXMdIjF2QpPcv5Z3
X-Received: from oachu5.prod.google.com ([2002:a05:6871:5285:b0:2bc:6ba1:58a4])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:8311:b0:288:18a0:e169
 with SMTP id 586e51a60fabf-2bd50d8a806mr9211022fac.19.1740372762058; Sun, 23
 Feb 2025 20:52:42 -0800 (PST)
Date: Mon, 24 Feb 2025 12:52:32 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224045237.1290971-1-chharry@google.com>
Subject: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Automatically configure the altsetting for USER_CHANNEL when a SCO is
connected. This adds support for the USER_CHANNEL to transfer SCO data
over USB transport.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

Changes in v2:
- Give up tracking the SCO handles. Only configure the altsetting when
  SCO connected.
- Put the change behind Kconfig/module parameter

 drivers/bluetooth/Kconfig | 11 ++++++++++
 drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4ab32abf0f48..7c497f878732 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
 	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
 	  default.
 
+config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
+	bool "Auto set isoc_altsetting for USER_CHANNEL when SCO connected"
+	depends on BT_HCIBTUSB
+	default n
+	help
+	  Say Y here to enable auto set isoc_altsetting for USER_CHANNEL
+	  when SCO connected
+
+	  This can be overridden by passing btusb.auto_set_isoc_alt=[y|n]
+	  on the kernel commandline.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de3fa725d210..af93d757911b 100644
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
 
@@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
+module_param(auto_set_isoc_alt, bool, 0644);
+MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altsetting for USER_CHANNEL when SCO connected");
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Generic Bluetooth USB driver ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
2.48.1.601.g30ceb7b040-goog

