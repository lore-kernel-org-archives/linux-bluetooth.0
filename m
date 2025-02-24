Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFB19D897
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740364011; cv=none; b=kFmcwp9l9XO80fCPvAl+TSowUFy9jteRYlAZtgqxiqAFdF5HsqpejdEj4qahXcmg3y0njfhBe6znGwoAr1UpmDqMu6AvGRDf7AJecKa+tq3ZSw4qY5mQN5B9jU79LFcT5B5VcdtQMwVB6/85ORmaPMzU6dNwpMyP0G1C93GX7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740364011; c=relaxed/simple;
	bh=r3dI7WiEKrFqvpwa8Xutcga0Pq3D9iRGQ2iWtyXOVYM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dixl9P8Be+fYcGf7ghzh/HuIMlOZl1HSQ1+zXUwcjp23ItimjckqXjIPuTOGzFsz2Rzz+n8NTNVj4eaq6bXQttk/ZsVGm/NkUQi67VbsdTvuLHaLMmXWIPKyqD/DgG9o53KCwUqhRakW9GuKIn0MpB4MhJYuHwCEkJm4NyJlhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=39Ac9zHp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="39Ac9zHp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22114b800f0so3795835ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2025 18:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740364008; x=1740968808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LhuIV3j7oQrzKR61zcRCUAWXcpdxwySje2S75gCH1tg=;
        b=39Ac9zHpnAvwe/EUiw18MjzUCVHBH8XbGmx9dKlT+abcfCl6PryiyQgpDWM689rQku
         GFwGwIM+R4UTXcQSFXdd1NEstAyejHy1/XfT6JvE+sgTfJbPkwUP9iAMOMAjT4H8OXqr
         KCEZ+7M1TWZ+MN+k3/It4eFwqZp0Gi4gD6oifTmqE4aUxP+N3G+O3cCgn/KKyG8ILU+S
         aBsOXPY2tMq6bFeAIpkujfKcakYLt34D7PUkQ5T89oQX1jalZgTo5PPgHxKyalMchmS3
         vCwS+Noe4p2KgRnkeb4kNRdSnaQqzrREy3C1N5Z0YXJjyU3UBklPNCKtqoav1JF/2WHg
         yHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740364008; x=1740968808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhuIV3j7oQrzKR61zcRCUAWXcpdxwySje2S75gCH1tg=;
        b=Thk2Ux/j2hN/+Y5aFeI4wSTaisDuMqHFsrsvqGNndc86LHHWEABKO1vYvw5p69joL8
         BJ9kgpvlc9NV3cIduwTf7FkQTj25oM6YjWFsnxlmezElgZ4tVuGYN3nS+WmshH7GI4nJ
         b3pbUCPXoy6XHUMAPugku9+6zZflB6ThS/Sa7VIsYQF9YYsDiwiZutgQPqP9iVmBctBv
         Ex0UsXTyY73mu42+zVUEYUoHV8XRY98hJL4j4Y9cyiJyy2qxzMWGTcbwW5xP7TGxf2RY
         bxet8DIJbnzU6XfzWhHgMfHd3TqWdiwmhECALSI8opb6qSFuvGimYjwIf2kdLVkQl0Ed
         f+EA==
X-Gm-Message-State: AOJu0Yy8q2yIoxQ7v0aJqrJoiLE3JxD5IdU+GVrxZmCmXTPxXwYwvqGD
	REbWbA6ucjEy+vb6w0g6WqPx50I6rTxFLzRdvr6iTpX0rvZRbt8X2dL4KB1rzLanSkhj1kScehx
	uwvGJyHIpVZZ6sbABRD0w0dOCZP/QxuY16NsrKlP3Y4C1Y2eXWUsHP1h4Q0rrJ2nf8BdvX5W4fh
	iv2pym1e+UH4cwgDNFt2d9t192YZDYit0vTKgfo2GKImjr52ujRQ==
X-Google-Smtp-Source: AGHT+IFZnn3FBdzh9D5B9RxsJfGUyqMzvkNo7PGV4SVPFh2QI3ZjakDkbKiu4nAUhfLmmp/1KDcEqC4BYEw2
X-Received: from plblc12.prod.google.com ([2002:a17:902:fa8c:b0:215:5322:d126])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cc:b0:21f:1202:f2f5
 with SMTP id d9443c01a7336-2219ff3353bmr161316925ad.8.1740364007568; Sun, 23
 Feb 2025 18:26:47 -0800 (PST)
Date: Mon, 24 Feb 2025 10:24:28 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224022447.1141413-1-chharry@google.com>
Subject: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

Automatically configure the altsetting for USER_CHANNEL when a SCO is
connected or disconnected. This adds support for the USER_CHANNEL to
transfer SCO data over USB transport.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

 drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++-------
 1 file changed, 186 insertions(+), 38 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de3fa725d210..dfb0918dfe98 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -854,6 +854,11 @@ struct qca_dump_info {
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
 
+struct sco_handle_list {
+	struct list_head list;
+	u16 handle;
+};
+
 struct btusb_data {
 	struct hci_dev       *hdev;
 	struct usb_device    *udev;
@@ -920,6 +925,9 @@ struct btusb_data {
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 
 	struct qca_dump_info qca_dump;
+
+	/* Records the exsiting SCO handles for HCI_USER_CHANNEL */
+	struct list_head sco_handle_list;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -1113,6 +1121,131 @@ static inline void btusb_free_frags(struct btusb_data *data)
 	spin_unlock_irqrestore(&data->rxlock, flags);
 }
 
+static void btusb_sco_handle_list_clear(struct list_head *list)
+{
+	struct sco_handle_list *entry, *n;
+
+	list_for_each_entry_safe(entry, n, list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
+static struct sco_handle_list *btusb_sco_handle_list_find(
+	struct list_head *list,
+	u16 handle)
+{
+	struct sco_handle_list *entry;
+
+	list_for_each_entry(entry, list, list)
+		if (entry->handle == handle)
+			return entry;
+
+	return NULL;
+}
+
+static int btusb_sco_handle_list_add(struct list_head *list, u16 handle)
+{
+	struct sco_handle_list *entry;
+
+	if (btusb_sco_handle_list_find(list, handle))
+		return -EEXIST;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->handle = handle;
+	list_add(&entry->list, list);
+
+	return 0;
+}
+
+static int btusb_sco_handle_list_del(struct list_head *list, u16 handle)
+{
+	struct sco_handle_list *entry;
+
+	entry = btusb_sco_handle_list_find(list, handle);
+	if (!entry)
+		return -ENOENT;
+
+	list_del(&entry->list);
+	kfree(entry);
+
+	return 0;
+}
+
+static void btusb_sco_conn_change(struct btusb_data *data, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *) skb->data;
+	struct hci_dev *hdev = data->hdev;
+
+	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT || skb->len < sizeof(*hdr))
+		return;
+
+	switch (hdr->evt) {
+	case HCI_EV_DISCONN_COMPLETE: {
+		struct hci_ev_disconn_complete *ev =
+			(void *) skb->data + sizeof(*hdr);
+		u16 handle;
+
+		if (skb->len != sizeof(*hdr) + sizeof(*ev) || ev->status)
+			return;
+
+		handle = __le16_to_cpu(ev->handle);
+		if (btusb_sco_handle_list_del(&data->sco_handle_list,
+					      handle) < 0)
+			return;
+
+		bt_dev_info(hdev, "disabling SCO");
+		data->sco_num--;
+		data->air_mode = HCI_NOTIFY_DISABLE_SCO;
+		schedule_work(&data->work);
+
+		break;
+	}
+	case HCI_EV_SYNC_CONN_COMPLETE: {
+		struct hci_ev_sync_conn_complete *ev =
+			(void *) skb->data + sizeof(*hdr);
+		unsigned int notify_air_mode;
+		u16 handle;
+
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
+		if (btusb_sco_handle_list_add(&data->sco_handle_list,
+					      handle) < 0) {
+			bt_dev_err(hdev, "failed to add the new SCO handle");
+			return;
+		}
+
+		bt_dev_info(hdev, "enabling SCO with air mode %u",
+			    ev->air_mode);
+		data->sco_num++;
+		data->air_mode = notify_air_mode;
+		schedule_work(&data->work);
+
+		break;
+	}
+	default:
+		break;
+	}
+}
+
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 {
 	if (data->intr_interval) {
@@ -1120,6 +1253,10 @@ static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
+	/* Configure altsetting for HCI_USER_CHANNEL on SCO dis/connected */
+	if (hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
+		btusb_sco_conn_change(data, skb);
+
 	return data->recv_event(data->hdev, skb);
 }
 
@@ -1919,44 +2056,6 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->ctrl_anchor);
 }
 
-static int btusb_close(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	cancel_delayed_work(&data->rx_work);
-	cancel_work_sync(&data->work);
-	cancel_work_sync(&data->waker);
-
-	skb_queue_purge(&data->acl_q);
-
-	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
-	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
-	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
-	clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
-
-	btusb_stop_traffic(data);
-	btusb_free_frags(data);
-
-	err = usb_autopm_get_interface(data->intf);
-	if (err < 0)
-		goto failed;
-
-	data->intf->needs_remote_wakeup = 0;
-
-	/* Enable remote wake up for auto-suspend */
-	if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
-		data->intf->needs_remote_wakeup = 1;
-
-	usb_autopm_put_interface(data->intf);
-
-failed:
-	usb_scuttle_anchored_urbs(&data->deferred);
-	return 0;
-}
-
 static int btusb_flush(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2327,6 +2426,51 @@ static void btusb_work(struct work_struct *work)
 	}
 }
 
+static int btusb_close(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		btusb_sco_handle_list_clear(&data->sco_handle_list);
+		data->sco_num = 0;
+		if (data->isoc_altsetting != 0)
+			btusb_switch_alt_setting(hdev, 0);
+	}
+
+	cancel_delayed_work(&data->rx_work);
+	cancel_work_sync(&data->work);
+	cancel_work_sync(&data->waker);
+
+	skb_queue_purge(&data->acl_q);
+
+	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
+	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
+	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
+	clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
+
+	btusb_stop_traffic(data);
+	btusb_free_frags(data);
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		goto failed;
+
+	data->intf->needs_remote_wakeup = 0;
+
+	/* Enable remote wake up for auto-suspend */
+	if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
+		data->intf->needs_remote_wakeup = 1;
+
+	usb_autopm_put_interface(data->intf);
+
+failed:
+	usb_scuttle_anchored_urbs(&data->deferred);
+	return 0;
+}
+
 static void btusb_waker(struct work_struct *work)
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, waker);
@@ -3782,6 +3926,8 @@ static int btusb_probe(struct usb_interface *intf,
 	data->udev = interface_to_usbdev(intf);
 	data->intf = intf;
 
+	INIT_LIST_HEAD(&data->sco_handle_list);
+
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
 	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
@@ -4117,6 +4263,8 @@ static void btusb_disconnect(struct usb_interface *intf)
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
+	btusb_sco_handle_list_clear(&data->sco_handle_list);
+
 	if (data->isoc) {
 		device_remove_file(&intf->dev, &dev_attr_isoc_alt);
 		usb_set_intfdata(data->isoc, NULL);
-- 
2.48.1.601.g30ceb7b040-goog

