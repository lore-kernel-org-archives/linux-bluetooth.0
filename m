Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A462D29C8
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460962; cv=none; b=p0PGctJKOnGZq3SjPDXv+S6aqDkTa4NY5w8yWItzdyNfNYUO6FVWBGeoeJfUxqHwifSFWbsrMNPYBsOBN9r+6v/cyrl41zWNFvyaE7X7TipTs7RbUwF7iGfCXJj2Je58V5CLRO/mUu6s80/zVLo4S8h1AysyLmx0xThhDf5toAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460962; c=relaxed/simple;
	bh=ZIUWi9dvcoLnHPBax9+q/pSLqBUWF7Pfvg5A5+KMJl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIZ3sMKJk0zyzspf4kKgKyRJ+S3d+V+zXRT/ueBc2zZe3ZV/738u8xDXfRjpCSSHUZVNcQtV+/4dF2OtwJZoLTcsVuR/TNsQn+7GgrfPLahULSEQS3+O+1eH3PSDReY6vIdZytIU5MRqkW9b86M1ggGq5SEpvOvMltePhVOMS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLmDHOFV; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLmDHOFV"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6acb51944d6so214830eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 18:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785460959; x=1786065759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2bC2m+UA+ADWVx01F0KW8+8Fn1WRql8m2DlUCjKWoQ=;
        b=fLmDHOFVjFKRMH3P1VSra+MZK12Gej97wORbr9KC1rR85izpDpuJ9sbc8TQhuE2EIs
         3kPPYiQf+WJ28ZNrMNwj6l8DRNRI4k2eLfBp13oS/OJgiklUXRVsNQvSeKs/3zLLRlZ5
         LI0xWCC/J2axfSciLjf/1Codv7UQNsqUQctymkvstSWGHo1hd6E6bkyFUpt+bR8U9T/T
         wCGM0TX7w37oE8XkoZM4e/h07ND95UNfOGoI88YrxJw5kimqN6QGN9sUqWuysp65NHGw
         hfTY8imqz0LJBgEc/IrYrgBQw0b2l20OrSn08X2/RleKLn2ZdwnGLTrH9yZCWRitXNKX
         el1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785460959; x=1786065759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2bC2m+UA+ADWVx01F0KW8+8Fn1WRql8m2DlUCjKWoQ=;
        b=Rcv7VfBxvm9XPPcDIL0AeREqciBbEi+xkGu5TPmS/yRgYHxcignpXzCUCILT2/NTcC
         WhlRx/3zOh+k6DgC7I1VLGdyWVIu6E/W3+zatFd+g7HwIEQ6DtqjXy7movwgKqX7kxVR
         oBoLycICjVXDgBUS4oSQurD8t4+d0Lk/skbJZJrhfhBxquF5dqNL+Ncm/GiUKarjPwVD
         c3/oIMNpxeAC4u2vmLHxrAb5N9ADayI4GQ+sE0BmmJjNz5bTVQ8OOXJo2/vf/3XkFWUy
         iCxBIQXGNQJU/jzngV6nZaKbDwiLdnFXr+M7SojSRoLAU/6h7HwHXavi9PygdN6GQ7E6
         Eo8w==
X-Forwarded-Encrypted: i=1; AHgh+Rr/ORVSwZf+5CijJM7xlRWj9A4T0ST5uu7mOqH4RlzCHq7N4ShhhwyRrXyZwcRRzZxGQJnKhxAreD4SRrBtJR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLy7rp9i578xDMOHHCMIh/eFu2RTvLoCqgO2lcAfwyIDwojYuT
	aHv2uV2GtHEAmjxTbZM4PJR0Niyvuwdls24Zdg96oJvLUstSHjEENiOw
X-Gm-Gg: AR+sD13CvfenHy0oL5ACbbFZEjA8u5iH7mTlO7agsfWBYUCpdpcUGsmzh7FW8yk1O1P
	FOzuCTHnqGMHPYpl+y/POw19St4yKauA+8CN4OheaoiSbRqy82b4B3K2sVXXru4E5tk8Jz0mwPM
	rmWLbvnW2JzJ64g7k33yMa4pOTwVgX8eIchiZJuASCmNpfP3fla8IiZy6e5PkKOlpZtPXgC4Jpv
	wWb0ZiC9TNSZpX/DWcBnp/Xb5FFNmEx/iEdlw4247VAJVJaqjuJAJKEhyOPbwtAYKdgI1Fsqvjr
	gp4eIAZk3IkiiQPqW03sz7++WJIv1qR+bSOITR34VYNQmkimYlTo2iT7rt0TumwW3U3LjNEF9Pj
	8jXygP/daUakQlWhsK42O3olmwnO0pCRLAelBFrAkIr021wBTXSVSS4wzt6nGhaV7ZpJrAOlXOj
	jAXxHy31506A+tmG65SYszC5EF9NuJ+0PEhD076jqvIz9EUS45MPc6F5U=
X-Received: by 2002:a05:6820:4cc7:b0:6aa:e524:fd70 with SMTP id 006d021491bc7-6ae37dabfbbmr30249eaf.26.1785460958951;
        Thu, 30 Jul 2026 18:22:38 -0700 (PDT)
Received: from en1.. ([204.144.167.9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6acbc2e1273sm2668311eaf.7.2026.07.30.18.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 18:22:38 -0700 (PDT)
From: Amir Abudubai <amirabudubai@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amir Abudubai <amirabudubai@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_core: Queue out-of-order ACL packets
Date: Thu, 30 Jul 2026 20:22:04 -0500
Message-ID: <3ebd064b6e7a9d3d8d72f1da618765affbd30cd7.1785459643.git.amirabudubai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEzAHR-7LQak12o_Xt7QrvLHRw3GSLDgco6o7Fru-wVXyBW7mQ@mail.gmail.com>
References: <CAEzAHR-7LQak12o_Xt7QrvLHRw3GSLDgco6o7Fru-wVXyBW7mQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some USB adapters, the interrupt-IN endpoint can lag behind the
bulk-IN endpoint by multiple polling intervals. Early ACL data can
then arrive before the Connection Complete event establishes its
handle, causing packets to be dropped due to an unknown handle.

To resolve this, add a queue to hold ACL traffic received with an
unknown handle. Re-check queued packets after processing HCI events,
and drop packets if they remain unmatched when the 4 ms timeout expires.
Introduce HCI_QUIRK_OUT_OF_ORDER_ACL to restrict this behavior to
transports that set the quirk.

Add BT_HCIBTUSB_EARLY_ACL_HOLD to set the default behavior for USB
adapters, along with a force_early_acl_hold debugfs entry to control
it per adapter while the adapter is down.

This issue was observed and the fix verified on:
- 8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
- 7392:c611 Edimax Technology Co., Ltd Edimax Bluetooth Adapter

Assisted-by: OpenCode:openai/gpt-5.6-sol
Signed-off-by: Amir Abudubai <amirabudubai@gmail.com>
---
Hi Luiz,

I worked on finding a simpler fix that didn't require adding latency,
and this is what I got. I based it on Fluoride's fix for the same race
condition. The main difference is doing it in HCI core, which comes
out cleaner because all the logic for valid handles and timestamps is
already in place.

 drivers/bluetooth/Kconfig         |  12 ++++
 drivers/bluetooth/btusb.c         |  59 ++++++++++++++++
 include/net/bluetooth/bluetooth.h |   6 ++
 include/net/bluetooth/hci.h       |   9 +++
 include/net/bluetooth/hci_core.h  |   3 +
 net/bluetooth/hci_core.c          | 111 +++++++++++++++++++++++++++---
 net/bluetooth/hci_sync.c          |   6 ++
 net/bluetooth/l2cap_core.c        |   2 +-
 8 files changed, 199 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4e8c24d757e9..027762e0da3f 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -56,6 +56,18 @@ config BT_HCIBTUSB_POLL_SYNC
 	  Say Y here to enable USB poll_sync for Bluetooth USB devices by
 	  default.
 
+config BT_HCIBTUSB_EARLY_ACL_HOLD
+	bool "Enable USB early ACL packet hold by default"
+	depends on BT_HCIBTUSB
+	default n
+	help
+	  Hold ACL packets for a nominal 4 milliseconds when their connection
+	  handle has not been registered yet. This works around USB controllers
+	  whose event endpoint can lag behind their ACL data endpoint.
+
+	  The default can be overridden per adapter using the
+	  force_early_acl_hold debugfs entry while the adapter is down.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index be82bbbc1b5c..2752bfb89670 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -34,6 +34,8 @@ static bool disable_scofix;
 static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
 static bool enable_poll_sync = IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SYNC);
+static bool enable_early_acl_hold =
+	IS_ENABLED(CONFIG_BT_HCIBTUSB_EARLY_ACL_HOLD);
 static bool reset = true;
 
 static struct usb_driver btusb_driver;
@@ -3964,6 +3966,57 @@ static const struct file_operations force_poll_sync_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t force_early_acl_hold_read(struct file *file,
+					 char __user *user_buf, size_t count,
+					 loff_t *ppos)
+{
+	struct btusb_data *data = file->private_data;
+	char buf[3];
+
+	buf[0] = hci_dev_test_flag(data->hdev,
+				   HCI_OUT_OF_ORDER_ACL_ENABLED) ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t force_early_acl_hold_write(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct btusb_data *data = file->private_data;
+	bool enabled;
+	int err;
+
+	err = kstrtobool_from_user(user_buf, count, &enabled);
+	if (err)
+		return err;
+
+	/* Only allow changes while the adapter is down */
+	if (test_bit(HCI_UP, &data->hdev->flags))
+		return -EPERM;
+
+	if (hci_dev_test_flag(data->hdev, HCI_OUT_OF_ORDER_ACL_ENABLED) ==
+	    enabled)
+		return -EALREADY;
+
+	if (enabled)
+		hci_dev_set_flag(data->hdev, HCI_OUT_OF_ORDER_ACL_ENABLED);
+	else
+		hci_dev_clear_flag(data->hdev, HCI_OUT_OF_ORDER_ACL_ENABLED);
+
+	return count;
+}
+
+static const struct file_operations force_early_acl_hold_fops = {
+	.owner		= THIS_MODULE,
+	.open		= simple_open,
+	.read		= force_early_acl_hold_read,
+	.write		= force_early_acl_hold_write,
+	.llseek		= default_llseek,
+};
+
 #define BTUSB_HCI_DRV_OP_SUPPORTED_ALTSETTINGS \
 		hci_opcode_pack(HCI_DRV_OGF_DRIVER_SPECIFIC, 0x0000)
 #define BTUSB_HCI_DRV_SUPPORTED_ALTSETTINGS_SIZE	0
@@ -4460,6 +4513,10 @@ static int btusb_probe(struct usb_interface *intf,
 	if (enable_autosuspend)
 		usb_enable_autosuspend(data->udev);
 
+	hci_set_quirk(hdev, HCI_QUIRK_OUT_OF_ORDER_ACL);
+	if (enable_early_acl_hold)
+		hci_dev_set_flag(hdev, HCI_OUT_OF_ORDER_ACL_ENABLED);
+
 	data->poll_sync = enable_poll_sync;
 
 	err = hci_register_dev(hdev);
@@ -4470,6 +4527,8 @@ static int btusb_probe(struct usb_interface *intf,
 
 	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
 			    &force_poll_sync_fops);
+	debugfs_create_file("force_early_acl_hold", 0644, hdev->debugfs, data,
+			    &force_early_acl_hold_fops);
 
 	return 0;
 
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b624da5026f5..19fd03103dff 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -486,6 +486,10 @@ struct mgmt_ctrl {
 	u16 opcode;
 };
 
+struct hci_acl_ctrl {
+	unsigned long expires;
+};
+
 struct bt_skb_cb {
 	u8 pkt_type;
 	u8 force_active;
@@ -496,6 +500,7 @@ struct bt_skb_cb {
 	union {
 		struct l2cap_ctrl l2cap;
 		struct hci_ctrl hci;
+		struct hci_acl_ctrl hci_acl;
 		struct mgmt_ctrl mgmt;
 		struct scm_creds creds;
 	};
@@ -509,6 +514,7 @@ struct bt_skb_cb {
 #define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
 #define hci_skb_event(skb) bt_cb((skb))->hci.req_event
 #define hci_skb_sk(skb) bt_cb((skb))->hci.sk
+#define hci_skb_acl_expires(skb) bt_cb((skb))->hci_acl.expires
 
 static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
 {
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cd3520a29131..04b6bbc4c803 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -375,6 +375,14 @@ enum {
 	 */
 	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
 
+	/* When this quirk is set, ACL packets received before their connection
+	 * handle is registered may be queued briefly. This can happen on
+	 * transports with separate event and ACL data channels.
+	 *
+	 * This quirk must be set before hci_register_dev is called.
+	 */
+	HCI_QUIRK_OUT_OF_ORDER_ACL,
+
 	__HCI_NUM_QUIRKS,
 };
 
@@ -468,6 +476,7 @@ enum {
 	HCI_OFFLOAD_CODECS_ENABLED,
 	HCI_LE_SIMULTANEOUS_ROLES,
 	HCI_CMD_DRAIN_WORKQUEUE,
+	HCI_OUT_OF_ORDER_ACL_ENABLED,
 
 	HCI_MESH_EXPERIMENTAL,
 	HCI_MESH,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 01b938c4b24a..f23b1a11e4b2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -516,10 +516,12 @@ struct hci_dev {
 	struct work_struct	rx_work;
 	struct work_struct	cmd_work;
 	struct work_struct	tx_work;
+	struct delayed_work	unknown_acl_work;
 
 	struct delayed_work	le_scan_disable;
 
 	struct sk_buff_head	rx_q;
+	struct sk_buff_head	unknown_acl_q;
 	struct sk_buff_head	raw_q;
 	struct sk_buff_head	cmd_q;
 
@@ -873,6 +875,7 @@ extern struct mutex hci_cb_list_lock;
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
+/* The caller retains ownership of skb only when -ENOENT is returned. */
 int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle, struct sk_buff *skb,
 		       u16 flags);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d5adf882509..a6531926e0cd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -47,6 +47,7 @@
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
+static void hci_unknown_acl_work(struct work_struct *work);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -2511,6 +2512,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
 	INIT_WORK(&hdev->tx_work, hci_tx_work);
+	INIT_DELAYED_WORK(&hdev->unknown_acl_work, hci_unknown_acl_work);
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->error_reset, hci_error_reset);
 
@@ -2519,6 +2521,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
 	skb_queue_head_init(&hdev->rx_q);
+	skb_queue_head_init(&hdev->unknown_acl_q);
 	skb_queue_head_init(&hdev->cmd_q);
 	skb_queue_head_init(&hdev->raw_q);
 
@@ -2669,6 +2672,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	disable_work_sync(&hdev->rx_work);
 	disable_work_sync(&hdev->cmd_work);
 	disable_work_sync(&hdev->tx_work);
+	disable_delayed_work_sync(&hdev->unknown_acl_work);
 	disable_work_sync(&hdev->power_on);
 	disable_work_sync(&hdev->error_reset);
 	disable_delayed_work_sync(&hdev->cmd_timer);
@@ -3793,8 +3797,11 @@ static void hci_tx_work(struct work_struct *work)
 
 /* ----- HCI RX task (incoming data processing) ----- */
 
+#define HCI_UNKNOWN_ACL_TIMEOUT_MS 4
+
 /* ACL data packet */
-static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
+static int hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb,
+			      bool retry)
 {
 	struct hci_acl_hdr *hdr;
 	__u16 handle, flags;
@@ -3804,7 +3811,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!hdr) {
 		bt_dev_err(hdev, "ACL packet too small");
 		kfree_skb(skb);
-		return;
+		return -EINVAL;
 	}
 
 	handle = __le16_to_cpu(hdr->handle);
@@ -3814,15 +3821,93 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	bt_dev_dbg(hdev, "len %d handle 0x%4.4x flags 0x%4.4x", skb->len,
 		   handle, flags);
 
-	hdev->stat.acl_rx++;
+	if (!retry)
+		hdev->stat.acl_rx++;
 
 	err = l2cap_recv_acldata(hdev, handle, skb, flags);
-	if (err == -ENOENT)
-		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
-			   handle);
-	else if (err)
+	if (err == -ENOENT) {
+		skb_push(skb, sizeof(*hdr));
+		return err;
+	}
+
+	if (err)
 		bt_dev_dbg(hdev, "ACL packet recv for handle %d failed: %d",
 			   handle, err);
+
+	return err;
+}
+
+static bool hci_unknown_acl_expired(struct sk_buff *skb)
+{
+	return time_after_eq(jiffies, hci_skb_acl_expires(skb));
+}
+
+static u16 hci_unknown_acl_handle(struct sk_buff *skb)
+{
+	return hci_handle(le16_to_cpu(hci_acl_hdr(skb)->handle));
+}
+
+static void hci_drop_unknown_acl(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
+		   hci_unknown_acl_handle(skb));
+	kfree_skb(skb);
+}
+
+static void hci_queue_unknown_acl(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	bt_dev_warn_ratelimited(hdev,
+				"Queuing ACL packet for unknown connection handle %d",
+				hci_unknown_acl_handle(skb));
+	hci_skb_acl_expires(skb) =
+		jiffies + msecs_to_jiffies(HCI_UNKNOWN_ACL_TIMEOUT_MS);
+	skb_queue_tail(&hdev->unknown_acl_q, skb);
+	queue_delayed_work(hdev->workqueue, &hdev->unknown_acl_work,
+			   msecs_to_jiffies(HCI_UNKNOWN_ACL_TIMEOUT_MS));
+}
+
+static void hci_retry_unknown_acl(struct hci_dev *hdev)
+{
+	unsigned int count = skb_queue_len(&hdev->unknown_acl_q);
+	struct sk_buff *skb;
+	unsigned long delay;
+
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		cancel_delayed_work(&hdev->unknown_acl_work);
+		skb_queue_purge(&hdev->unknown_acl_q);
+		return;
+	}
+
+	while (count-- && (skb = skb_dequeue(&hdev->unknown_acl_q))) {
+		if (hci_acldata_packet(hdev, skb, true) != -ENOENT)
+			continue;
+
+		if (hci_unknown_acl_expired(skb)) {
+			hci_drop_unknown_acl(hdev, skb);
+			continue;
+		}
+
+		skb_queue_tail(&hdev->unknown_acl_q, skb);
+	}
+
+	if (skb_queue_empty(&hdev->unknown_acl_q)) {
+		cancel_delayed_work(&hdev->unknown_acl_work);
+		return;
+	}
+
+	skb = skb_peek(&hdev->unknown_acl_q);
+	delay = time_after(hci_skb_acl_expires(skb), jiffies) ?
+		hci_skb_acl_expires(skb) - jiffies : 0;
+	queue_delayed_work(hdev->workqueue, &hdev->unknown_acl_work,
+			   max_t(unsigned long, 1, delay));
+}
+
+static void hci_unknown_acl_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					   unknown_acl_work.work);
+
+	hci_retry_unknown_acl(hdev);
 }
 
 /* SCO data packet */
@@ -4039,11 +4124,21 @@ static void hci_rx_work(struct work_struct *work)
 		case HCI_EVENT_PKT:
 			BT_DBG("%s Event packet", hdev->name);
 			hci_event_packet(hdev, skb);
+			if (!skb_queue_empty(&hdev->unknown_acl_q))
+				hci_retry_unknown_acl(hdev);
 			break;
 
 		case HCI_ACLDATA_PKT:
 			BT_DBG("%s ACL data packet", hdev->name);
-			hci_acldata_packet(hdev, skb);
+			if (hci_acldata_packet(hdev, skb, false) == -ENOENT) {
+				if (hci_test_quirk(hdev,
+						   HCI_QUIRK_OUT_OF_ORDER_ACL) &&
+				    hci_dev_test_flag(hdev,
+						      HCI_OUT_OF_ORDER_ACL_ENABLED))
+					hci_queue_unknown_acl(hdev, skb);
+				else
+					hci_drop_unknown_acl(hdev, skb);
+			}
 			break;
 
 		case HCI_SCODATA_PKT:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 307fd47f8459..839f9fe91d20 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5396,9 +5396,11 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		 */
 		flush_work(&hdev->rx_work);
 		flush_work(&hdev->cmd_work);
+		cancel_delayed_work_sync(&hdev->unknown_acl_work);
 
 		skb_queue_purge(&hdev->cmd_q);
 		skb_queue_purge(&hdev->rx_q);
+		skb_queue_purge(&hdev->unknown_acl_q);
 
 		if (hdev->flush)
 			hdev->flush(hdev);
@@ -5503,6 +5505,8 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		cancel_delayed_work_sync(&hdev->cmd_timer);
+		cancel_delayed_work_sync(&hdev->unknown_acl_work);
+		skb_queue_purge(&hdev->unknown_acl_q);
 		hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 		return err;
 	}
@@ -5512,6 +5516,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	/* Flush RX and TX works */
 	flush_work(&hdev->tx_work);
 	flush_work(&hdev->rx_work);
+	cancel_delayed_work_sync(&hdev->unknown_acl_work);
 
 	if (hdev->discov_timeout > 0) {
 		hdev->discov_timeout = 0;
@@ -5582,6 +5587,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
+	skb_queue_purge(&hdev->unknown_acl_q);
 	skb_queue_purge(&hdev->cmd_q);
 	skb_queue_purge(&hdev->raw_q);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1156aba4e83c..a53179897054 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7799,7 +7799,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 	hcon = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!hcon) {
 		hci_dev_unlock(hdev);
-		kfree_skb(skb);
+		/* Leave ownership with HCI so it can retry the packet. */
 		return -ENOENT;
 	}
 

base-commit: 735a14a2a4426760c5ff41ef3db5543fececcb75
-- 
2.43.0
