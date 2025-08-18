Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEA17A318
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550084; cv=none; b=CvNHInPx1GgSxZmXYJ2XF0CKDnrC1Xvg1UIKf2yM6KlY28etUZ98FPqVzaiRAJpveXoQ0W3N95jGydiRpJlsQwvOQv3z0OkX8GkeXCzCIK+XHuQd4gEuk7Wn0aGoPrbq0oHO/wfuZgAttQvba+5JwoAvjR397MFmJTKh/cnpkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550084; c=relaxed/simple;
	bh=+UNqwN0lvhnLZer+2kwcBWdRqX4zit29/j7Fl65OJ6A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OrjXXps7trUwiJFrmUucZIuEynYkGEsGVzlL8YS2u72jAfypGAvtPyv3eIThQH+dqEJo14C91o0plmeoOdHNWaWMVcz5jGNwkBR9in3xGsuo0F14eYnPKYP1JT6XqKyIeU8uzQDw3qQv52xJ07TGeBUSnYm/MsLHmHZ5tpWODBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvlU9yNS; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvlU9yNS"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53b17534eeeso1658192e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Aug 2025 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755550081; x=1756154881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sj+x3WkUhhPY4Gv9zZbBpJ39x1Qv7FoUsuGV2IEyBrU=;
        b=bvlU9yNSF74tztAiZ7HGJMtmracaM3bAmx5Z4kXzJC5t06FzOqoq/9r6MPvygMDzSd
         L0qCcXXbQ2/jJ/WMLaRIyvvB5lTsK14tnzL1tAcH6CfD0XyKRkRH9vzKv78YKcl0N0BZ
         tdYUF3kVuZFELt+PbMUEU1S9bCLK0UVuyKJycSKrceTv2VmudqlIcSGPcred7gNUaaeI
         v1EVMUlDVpiHVSn3JF/YuAmSNf/geDcG0KFYqiNrNuX+Ny+PVOsVGu58uCvIBDvPViRm
         iNIUk3HMiobOzaWcB6JMK3GCEaZYZnkk8g4f9klBtmDU9FI2iOU6hbCFx/x+iMgRStak
         jZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550081; x=1756154881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sj+x3WkUhhPY4Gv9zZbBpJ39x1Qv7FoUsuGV2IEyBrU=;
        b=kNDCLjG9gkvq9ApkoC3qNEW9fsaqcbWYRC2dR5aR3ylstXFqEPB3FPGiMTqnugydP2
         yv9xDY9l/YONLyuGl1ftxKuzRGfDHr3o4QF6osRkaxvTyyFWgb7hDig+VfyHeNhgq549
         WyuYbp1JjjA36upEi5cRudV95LX1+iSjH0X0mzKiUvmEPbvx+ivmqZlwmam+if1iDVRS
         ZhT3uz35TzrRnLNNaGhAVwZL/uuDsXpZZL/0oRtcpRfz82tw+44OiH8sSiRRzlks1K5Y
         UMXichmmLpKTMvn+cgxMmiRwzclZ3PcFhFZzSONXcjHdvI69k/AVL+cia+I9RPRgkHco
         p5sg==
X-Gm-Message-State: AOJu0YwLoeQDdPZ1Dyg30JB7b/WJxDGjGWAI7CMhs14L1ST8uTd88Qdo
	fk2KAWIV36zj3zLJuCmixltpz/YlnTmQF/2uFVG4X7r36GNWgTHbbVsyfkJ4ebTY
X-Gm-Gg: ASbGnct42AZDr43VqpHNLClHxSZZ2G70CGTjhcOrMyUZtUnM3JojT0YOLnELLzIFHmj
	4ZIc/sZXcaKbGarnR65fwFYewgj836lZADF6tWtxLvBsU1XYylge70F6FHaq6KWgjgCbdfowId0
	Js24Mm3xv0SwxZ4Ky/e1lFL4SS00173ndFLWkcNOs7OieAgX0acXBSCL+p7Acyr1WBbNS/NCV9K
	5vETw+fMVydYqyWXaq2wPmm1tjcv4Mo4sIrYvlFSW6CSkE+UHOmJPorrHSpoRXcX4JmApTNXkl9
	SVWHuvpqEAg7azqt2ZQZPMqo6WBVSXKiHSaF857BktXTnBWpWpVLt0BBypEnjo8nJ6kozb11isb
	hVZS4CI73w1EKqsZk6okTDM7wRQ30GObgT7Ly04DiGhmj0eEXwDXDBMa3c4+cjgsHd+bI+ECBpU
	g=
X-Google-Smtp-Source: AGHT+IHl01M7jzWAUaLHiVA87dL6axZCRZDJLGeGHhTe2DAYcap4e3bNqtyZgzIueHA2pbdFKI6gUw==
X-Received: by 2002:a05:6122:da3:b0:530:5996:63a2 with SMTP id 71dfb90a1353d-53b5d2fb7b4mr71990e0c.7.1755550080571;
        Mon, 18 Aug 2025 13:48:00 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd553casm2101079e0c.2.2025.08.18.13.47.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:47:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/8] Bluetooth: hci_core: Convert instances of BT_DBG to bt_dev_dbg
Date: Mon, 18 Aug 2025 16:47:46 -0400
Message-ID: <20250818204753.1203949-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This converts instances of BT_DBG to bt_dev_dbg when logging to a
specific hci_dev this is preferable since it does prints the name by
default.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 134 +++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4cf4bb1187dc..f91ead01f261 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -68,7 +68,7 @@ static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
 {
 	struct hci_dev *hdev = NULL, *d;
 
-	BT_DBG("%d", index);
+	bt_dev_dbg(hdev, "%d", index);
 
 	if (index < 0)
 		return NULL;
@@ -168,7 +168,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	BT_DBG("cache %p, %pMR", cache, bdaddr);
+	bt_dev_dbg(hdev, "cache %p, %pMR", cache, bdaddr);
 
 	list_for_each_entry(e, &cache->all, all) {
 		if (!bacmp(&e->data.bdaddr, bdaddr))
@@ -184,7 +184,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	BT_DBG("cache %p, %pMR", cache, bdaddr);
+	bt_dev_dbg(hdev, "cache %p, %pMR", cache, bdaddr);
 
 	list_for_each_entry(e, &cache->unknown, list) {
 		if (!bacmp(&e->data.bdaddr, bdaddr))
@@ -201,7 +201,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup_resolve(struct hci_dev *hdev,
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	BT_DBG("cache %p bdaddr %pMR state %d", cache, bdaddr, state);
+	bt_dev_dbg(hdev, "cache %p bdaddr %pMR state %d", cache, bdaddr, state);
 
 	list_for_each_entry(e, &cache->resolve, list) {
 		if (!bacmp(bdaddr, BDADDR_ANY) && e->name_state == state)
@@ -239,7 +239,7 @@ u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 	struct inquiry_entry *ie;
 	u32 flags = 0;
 
-	BT_DBG("cache %p, %pMR", cache, &data->bdaddr);
+	bt_dev_dbg(hdev, "cache %p, %pMR", cache, &data->bdaddr);
 
 	hci_remove_remote_oob_data(hdev, &data->bdaddr, BDADDR_BREDR);
 
@@ -318,7 +318,7 @@ static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 		copied++;
 	}
 
-	BT_DBG("cache %p, copied %d", cache, copied);
+	bt_dev_dbg(hdev, "cache %p, copied %d", cache, copied);
 	return copied;
 }
 
@@ -402,7 +402,7 @@ int hci_inquiry(void __user *arg)
 	ir.num_rsp = inquiry_cache_dump(hdev, max_rsp, buf);
 	hci_dev_unlock(hdev);
 
-	BT_DBG("num_rsp %d", ir.num_rsp);
+	bt_dev_dbg(hdev, "num_rsp %d", ir.num_rsp);
 
 	if (!copy_to_user(ptr, &ir, sizeof(ir))) {
 		ptr += sizeof(ir);
@@ -423,7 +423,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 {
 	int ret = 0;
 
-	BT_DBG("%s %p", hdev->name, hdev);
+	bt_dev_dbg(hdev, "%s %p", hdev->name, hdev);
 
 	hci_req_sync_lock(hdev);
 
@@ -494,7 +494,7 @@ int hci_dev_do_close(struct hci_dev *hdev)
 {
 	int err;
 
-	BT_DBG("%s %p", hdev->name, hdev);
+	bt_dev_dbg(hdev, "%s %p", hdev->name, hdev);
 
 	hci_req_sync_lock(hdev);
 
@@ -534,7 +534,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 {
 	int ret;
 
-	BT_DBG("%s %p", hdev->name, hdev);
+	bt_dev_dbg(hdev, "%s %p", hdev->name, hdev);
 
 	hci_req_sync_lock(hdev);
 
@@ -644,7 +644,7 @@ static void hci_update_passive_scan_state(struct hci_dev *hdev, u8 scan)
 {
 	bool conn_changed, discov_changed;
 
-	BT_DBG("%s scan 0x%02x", hdev->name, scan);
+	bt_dev_dbg(hdev, "%s scan 0x%02x", hdev->name, scan);
 
 	if ((scan & SCAN_PAGE))
 		conn_changed = !hci_dev_test_and_set_flag(hdev,
@@ -888,7 +888,7 @@ static int hci_dev_do_poweroff(struct hci_dev *hdev)
 {
 	int err;
 
-	BT_DBG("%s %p", hdev->name, hdev);
+	bt_dev_dbg(hdev, "%s %p", hdev->name, hdev);
 
 	hci_req_sync_lock(hdev);
 
@@ -904,7 +904,7 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 	struct hci_dev *hdev = data;
 	int err;
 
-	BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
+	bt_dev_dbg(hdev, "%p name %s blocked %d", hdev, hdev->name, blocked);
 
 	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
 		return -EBUSY;
@@ -945,7 +945,7 @@ static void hci_power_on(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev, power_on);
 	int err;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "%s", hdev->name);
 
 	if (test_bit(HCI_UP, &hdev->flags) &&
 	    hci_dev_test_flag(hdev, HCI_MGMT) &&
@@ -1014,7 +1014,7 @@ static void hci_power_off(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    power_off.work);
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "%s", hdev->name);
 
 	hci_dev_do_close(hdev);
 }
@@ -1024,7 +1024,7 @@ static void hci_error_reset(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
 
 	hci_dev_hold(hdev);
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "%s", hdev->name);
 
 	if (hdev->hw_error)
 		hdev->hw_error(hdev, hdev->hw_error_code);
@@ -1291,7 +1291,7 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 		list_add_rcu(&key->list, &hdev->link_keys);
 	}
 
-	BT_DBG("%s key for %pMR type %u", hdev->name, bdaddr, type);
+	bt_dev_dbg(hdev, "%s key for %pMR type %u", hdev->name, bdaddr, type);
 
 	/* Some buggy controller combinations generate a changed
 	 * combination key for legacy pairing even when there's no
@@ -1379,7 +1379,7 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	if (!key)
 		return -ENOENT;
 
-	BT_DBG("%s removing %pMR", hdev->name, bdaddr);
+	bt_dev_dbg(hdev, "%s removing %pMR", hdev->name, bdaddr);
 
 	list_del_rcu(&key->list);
 	kfree_rcu(key, rcu);
@@ -1396,7 +1396,7 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type)
 		if (bacmp(bdaddr, &k->bdaddr) || k->bdaddr_type != bdaddr_type)
 			continue;
 
-		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
+		bt_dev_dbg(hdev, "%s removing %pMR", hdev->name, bdaddr);
 
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
@@ -1414,7 +1414,7 @@ void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
 		if (bacmp(bdaddr, &k->bdaddr) || k->addr_type != addr_type)
 			continue;
 
-		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
+		bt_dev_dbg(hdev, "%s removing %pMR", hdev->name, bdaddr);
 
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
@@ -1523,7 +1523,7 @@ int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	if (!data)
 		return -ENOENT;
 
-	BT_DBG("%s removing %pMR (%u)", hdev->name, bdaddr, bdaddr_type);
+	bt_dev_dbg(hdev, "removing %pMR (%u)", bdaddr, bdaddr_type);
 
 	list_del(&data->list);
 	kfree(data);
@@ -1582,7 +1582,7 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			data->present = 0x01;
 	}
 
-	BT_DBG("%s for %pMR", hdev->name, bdaddr);
+	bt_dev_dbg(hdev, "for %pMR", bdaddr);
 
 	return 0;
 }
@@ -1639,7 +1639,7 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
 	if (!adv_instance)
 		return -ENOENT;
 
-	BT_DBG("%s removing %dMR", hdev->name, instance);
+	bt_dev_dbg(hdev, "removing %dMR", instance);
 
 	if (hdev->cur_adv_instance == instance) {
 		if (hdev->adv_instance_timeout) {
@@ -1759,7 +1759,7 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 
 	INIT_DELAYED_WORK(&adv->rpa_expired_cb, adv_instance_rpa_expired);
 
-	BT_DBG("%s for %dMR", hdev->name, instance);
+	bt_dev_dbg(hdev, "for %dMR", instance);
 
 	return adv;
 }
@@ -2293,7 +2293,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 	params->supervision_timeout = hdev->le_supv_timeout;
 	params->auto_connect = HCI_AUTO_CONN_DISABLED;
 
-	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+	bt_dev_dbg(hdev, "addr %pMR (type %u)", addr, addr_type);
 
 	return params;
 }
@@ -2324,7 +2324,7 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 
 	hci_update_passive_scan(hdev);
 
-	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+	bt_dev_dbg(hdev, "addr %pMR (type %u)", addr, addr_type);
 }
 
 /* This function requires the caller holds hdev->lock */
@@ -2347,7 +2347,7 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
 		hci_conn_params_free(params);
 	}
 
-	BT_DBG("All LE disabled connection parameters were removed");
+	bt_dev_dbg(hdev, "All LE disabled connection parameters were removed");
 }
 
 /* This function requires the caller holds hdev->lock */
@@ -2358,7 +2358,7 @@ static void hci_conn_params_clear_all(struct hci_dev *hdev)
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list)
 		hci_conn_params_free(params);
 
-	BT_DBG("All LE connection parameters were removed");
+	bt_dev_dbg(hdev, "All LE connection parameters were removed");
 }
 
 /* Copy the Identity Address of the controller.
@@ -2599,7 +2599,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	hdev->name = dev_name(&hdev->dev);
 	hdev->id = id;
 
-	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
+	bt_dev_dbg(hdev, "bus %d", hdev->bus);
 
 	hdev->workqueue = alloc_ordered_workqueue("%s", WQ_HIGHPRI, hdev->name);
 	if (!hdev->workqueue) {
@@ -2689,7 +2689,7 @@ EXPORT_SYMBOL(hci_register_dev);
 /* Unregister HCI device */
 void hci_unregister_dev(struct hci_dev *hdev)
 {
-	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
+	bt_dev_dbg(hdev, "bus %d", hdev->bus);
 
 	mutex_lock(&hdev->unregister_lock);
 	hci_dev_set_flag(hdev, HCI_UNREGISTER);
@@ -3039,8 +3039,8 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int err;
 
-	BT_DBG("%s type %d len %d", hdev->name, hci_skb_pkt_type(skb),
-	       skb->len);
+	bt_dev_dbg(hdev, "skb %p type %d len %d", skb, hci_skb_pkt_type(skb),
+		   skb->len);
 
 	/* Time stamp */
 	__net_timestamp(skb);
@@ -3093,7 +3093,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 {
 	struct sk_buff *skb;
 
-	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
+	bt_dev_dbg(hdev, "opcode 0x%4.4x plen %d", opcode, plen);
 
 	skb = hci_cmd_sync_alloc(hdev, opcode, plen, param, NULL);
 	if (!skb) {
@@ -3234,12 +3234,12 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 	list = skb_shinfo(skb)->frag_list;
 	if (!list) {
 		/* Non fragmented */
-		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
+		bt_dev_dbg(hdev, "nonfrag skb %p len %d", skb, skb->len);
 
 		skb_queue_tail(queue, skb);
 	} else {
 		/* Fragmented */
-		BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
+		bt_dev_dbg(hdev, "frag %p len %d", skb, skb->len);
 
 		skb_shinfo(skb)->frag_list = NULL;
 
@@ -3260,7 +3260,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 			hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
 			hci_add_acl_hdr(skb, conn->handle, flags);
 
-			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
+			bt_dev_dbg(hdev, "frag %p len %d", skb, skb->len);
 
 			__skb_queue_tail(queue, skb);
 		} while (list);
@@ -3273,7 +3273,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
 {
 	struct hci_dev *hdev = chan->conn->hdev;
 
-	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
+	bt_dev_dbg(hdev, "chan %p skb %p flags 0x%4.4x", chan, skb, flags);
 
 	hci_queue_acl(chan, &chan->data_q, skb, flags);
 
@@ -3286,7 +3286,7 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_sco_hdr hdr;
 
-	BT_DBG("%s len %d", hdev->name, skb->len);
+	bt_dev_dbg(hdev, "hcon %p skb %p len %d", conn, skb, skb->len);
 
 	hdr.handle = cpu_to_le16(conn->handle);
 	hdr.dlen   = skb->len;
@@ -3333,12 +3333,12 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 
 	if (!list) {
 		/* Non fragmented */
-		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
+		bt_dev_dbg(hdev, "nonfrag skb %p len %d", skb, skb->len);
 
 		skb_queue_tail(queue, skb);
 	} else {
 		/* Fragmented */
-		BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
+		bt_dev_dbg(hdev, "frag %p len %d", skb, skb->len);
 
 		skb_shinfo(skb)->frag_list = NULL;
 
@@ -3352,7 +3352,7 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 						   0x00);
 			hci_add_iso_hdr(skb, conn->handle, flags);
 
-			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
+			bt_dev_dbg(hdev, "frag %p len %d", skb, skb->len);
 
 			__skb_queue_tail(queue, skb);
 		} while (list);
@@ -3363,7 +3363,7 @@ void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb)
 {
 	struct hci_dev *hdev = conn->hdev;
 
-	BT_DBG("%s len %d", hdev->name, skb->len);
+	bt_dev_dbg(hdev, "hcon %p skb %p len %d", conn, skb, skb->len);
 
 	hci_queue_iso(conn, &conn->data_q, skb);
 
@@ -3445,7 +3445,7 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 
 	hci_quote_sent(conn, num, quote);
 
-	BT_DBG("conn %p quote %d", conn, *quote);
+	bt_dev_dbg(hdev, "hcon %p quote %d", conn, *quote);
 	return conn;
 }
 
@@ -3479,7 +3479,7 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 	struct hci_conn *conn;
 	int conn_num = 0;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	rcu_read_lock();
 
@@ -3529,7 +3529,7 @@ static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 
 	hci_quote_sent(chan->conn, num, quote);
 
-	BT_DBG("chan %p quote %d", chan, *quote);
+	bt_dev_dbg(hdev, "chan %p quote %d", chan, *quote);
 	return chan;
 }
 
@@ -3539,7 +3539,7 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 	struct hci_conn *conn;
 	int num = 0;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	rcu_read_lock();
 
@@ -3571,8 +3571,8 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 
 			skb->priority = HCI_PRIO_MAX - 1;
 
-			BT_DBG("chan %p skb %p promoted to %d", chan, skb,
-			       skb->priority);
+			bt_dev_dbg(hdev, "chan %p skb %p promoted to %d", chan,
+				   skb, skb->priority);
 		}
 
 		if (hci_conn_num(hdev, type) == num)
@@ -3642,7 +3642,7 @@ static void hci_sched_sco(struct hci_dev *hdev, __u8 type)
 
 	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
+			bt_dev_dbg(hdev, "skb %p len %d", skb, skb->len);
 			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
@@ -3674,8 +3674,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
-			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
-			       skb->len, skb->priority);
+			bt_dev_dbg(hdev, "chan %p skb %p len %d priority %u",
+				   chan, skb, skb->len, skb->priority);
 
 			/* Stop if priority has changed */
 			if (skb->priority < priority)
@@ -3705,7 +3705,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 
 static void hci_sched_acl(struct hci_dev *hdev)
 {
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	/* No ACL link over BR/EDR controller */
 	if (!hci_conn_num(hdev, ACL_LINK))
@@ -3720,7 +3720,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int quote, *cnt, tmp;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
@@ -3733,8 +3733,8 @@ static void hci_sched_le(struct hci_dev *hdev)
 	while (*cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
-			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
-			       skb->len, skb->priority);
+			bt_dev_dbg(hdev, "chan %p skb %p len %d priority %u",
+				   chan, skb, skb->len, skb->priority);
 
 			/* Stop if priority has changed */
 			if (skb->priority < priority)
@@ -3766,7 +3766,7 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 	struct sk_buff *skb;
 	int quote, *cnt;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "type %u", type);
 
 	if (!hci_conn_num(hdev, type))
 		return;
@@ -3777,7 +3777,7 @@ static void hci_sched_iso(struct hci_dev *hdev, __u8 type)
 
 	while (*cnt && (conn = hci_low_sent(hdev, type, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
+			bt_dev_dbg(hdev, "skb %p len %d", skb, skb->len);
 
 			hci_send_conn_frame(hdev, conn, skb);
 			hdev->iso_last_tx = jiffies;
@@ -3795,8 +3795,8 @@ static void hci_tx_work(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev, tx_work);
 	struct sk_buff *skb;
 
-	BT_DBG("%s acl %d sco %d le %d iso %d", hdev->name, hdev->acl_cnt,
-	       hdev->sco_cnt, hdev->le_cnt, hdev->iso_cnt);
+	bt_dev_dbg(hdev, "acl %d sco %d le %d iso %d", hdev->acl_cnt,
+		   hdev->sco_cnt, hdev->le_cnt, hdev->iso_cnt);
 
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Schedule queues and send stuff to HCI driver */
@@ -3974,7 +3974,7 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	BT_DBG("opcode 0x%04x status 0x%02x", opcode, status);
+	bt_dev_dbg(hdev, "opcode 0x%04x status 0x%02x", opcode, status);
 
 	/* If the completed command doesn't match the last one that was
 	 * sent we need to do special handling of it.
@@ -4039,7 +4039,7 @@ static void hci_rx_work(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev, rx_work);
 	struct sk_buff *skb;
 
-	BT_DBG("%s", hdev->name);
+	bt_dev_dbg(hdev, "");
 
 	/* The kcov_remote functions used for collecting packet parsing
 	 * coverage information from this background thread and associate
@@ -4083,22 +4083,22 @@ static void hci_rx_work(struct work_struct *work)
 		/* Process frame */
 		switch (hci_skb_pkt_type(skb)) {
 		case HCI_EVENT_PKT:
-			BT_DBG("%s Event packet", hdev->name);
+			bt_dev_dbg(hdev, "Event packet");
 			hci_event_packet(hdev, skb);
 			break;
 
 		case HCI_ACLDATA_PKT:
-			BT_DBG("%s ACL data packet", hdev->name);
+			bt_dev_dbg(hdev, "ACL data packet");
 			hci_acldata_packet(hdev, skb);
 			break;
 
 		case HCI_SCODATA_PKT:
-			BT_DBG("%s SCO data packet", hdev->name);
+			bt_dev_dbg(hdev, "SCO data packet");
 			hci_scodata_packet(hdev, skb);
 			break;
 
 		case HCI_ISODATA_PKT:
-			BT_DBG("%s ISO data packet", hdev->name);
+			bt_dev_dbg(hdev, "ISO data packet");
 			hci_isodata_packet(hdev, skb);
 			break;
 
@@ -4145,8 +4145,8 @@ static void hci_cmd_work(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
 	struct sk_buff *skb;
 
-	BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
-	       atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
+	bt_dev_dbg(hdev, "cmd_cnt %d cmd queued %d",
+		   atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
 
 	/* Send queued commands */
 	if (atomic_read(&hdev->cmd_cnt)) {
-- 
2.50.1

