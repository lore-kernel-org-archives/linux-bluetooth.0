Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9346A5FB
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838447; cv=none; b=i14y8zoIeqsITbEin5oBvvx8Pd7T81iFFjDx+ona5AYRY9R3IS5fCheyMRW/SahIwfx2aZyE94wGxrwYTPLyKFwOytGskuaLcFRWlBO5pXdJTohxIZJW21C/J4blxi1Rj3eMJiekAttQWVcE9ON5Kv8PCI2HiinXQPeZcg6oO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838447; c=relaxed/simple;
	bh=pEY1tlm2JunTiZsRZlUPBXdcPDKiTLsdX9Pyw9E939k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOlY0hzfjhJVc5ridiIQSm5iZP33A8PNxfQMA8elT2gm1mgdSZjqFdsIo56MWKCRvthl1Xa/xGdLqOEJTxhaxvl2vFhxWHEtsKYEhBMJe0+J8P0fDY1e/5OyfspfSaAGnUqWcsMwMu+UwGQQFvupQJV6AVthEsZWN5ChEafYiCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=M8rxUpma; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="M8rxUpma"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso19680395e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838439; x=1786443239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NcTpInKpblUR31mB+9WSUA9DelM3/WgRwBt5+BUoCRw=;
        b=M8rxUpmaiU6sibILhVDLcV2XaP55vWdTXR9t/W4fqhvZ68fFlPwHGvBW3rQf6bZXHR
         4jwoNOH/sUqwOArYaX2MU+2qfLfaJDuPsJqeHhVPsoD5H7Jvu1vAHL/C0P7VVzoiIjGS
         zp/YdkOcWJTSE6W3kIAKcd6hsHBblBHJuzrln1/665gnbWlusCWlbi8hb5yHI0PxVpdx
         uknTg1ZtR9gp443Jp1RyyQ88ZT4aCXelSaR3Y5PjZNsEO8tNtNMMA68cy4ao85MssIp9
         ckzWt4AT4XF4m9bVjuDqWcZyi/Zyreaf6ube8yvXgOxohNERjX4iT+DfTq4H2ormJuh/
         nmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838439; x=1786443239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcTpInKpblUR31mB+9WSUA9DelM3/WgRwBt5+BUoCRw=;
        b=UwRuAzaHEKUVZEWKJV6o/iZq0pItKR7GW+9ktQMpJxUp8UU9rzBKuktdkwRJg51HH7
         IXNrCA4GyWt/no2P1hf2Cy9aYwDDofz65uIQ8ZhYPdZtZfAFU3gzBZElmdwVR6iBg6QV
         85aM5vxrDSiSKAshR2ewGWuONfJpnXzamp1z3Fans0WOfnhzclmSc2VwajTafdYqfcRH
         7X/L6SAsmopIBzN8L0xqdvC/xVf2K5GaIRCdw+kNESi6Vsyci0jkvYr9oFwQFeF0nyr0
         BY177KA4qZ1V12fRNsDXer6DJ2q2n/o+021iwpvdY50Bi95E6WodaKiEMmvb9krTFgj8
         NfwQ==
X-Gm-Message-State: AOJu0YxIn8Vb7Nqi7qkmygcCTeaK7qdMbCZMO2bMIBBy6bXyDSBlBK1W
	7g8ZcrCwYKi5BPzOhMG7VhTlYanno5gmMPRU8Bmvv7138zbulxLnRDKaHdKUZDxUTzXelZijYpp
	37QSOwIc8
X-Gm-Gg: AR+sD11oV+sLbGvapHq+odjSt06vG8Gn5K0YXYjAyFIxC9fPmxc9Sy9KQ7iVeJanDTJ
	As+EWFitBVHI4c3l6lBkc9Ti0+5b1lqFieMQ7WT7WL6NXRlno5xsX2q4YXYxHckUCs5WcGZeuYS
	w63B45pNL9Q5zKt6tlBtitrY5D+yiLkL0JI1SoL3CiLs8nTmrsWLrVHNuxoZgGdFsW7RJ3cEKby
	G4/mZe8RUD58v6fQhhm5cSTbYwXy6JtmFcL6usOcpHaHcvMrffScY25F7JTlKvR/6+BWZB3kfXb
	7kh865TaRfRMQJZK1XK+eP0sysilz2CWiapjCJaURh6IZr7TawamqSIsfZT9GXHwh1zL1PkfPCr
	z87orTQQbnQQCL+BdqGJ/N1CjllrVqU9F12p4Kc4W7QKbBvnYVxfHc9JjHB6viQoQbd1TNt/Hdd
	MVaW56AXXFidd4HBKXem4odj47uBsLIrE27DBFn38tUUXZof8ywkwnT4CzI63ctctV2F1pHcEzh
	F6Rn6eJSVDVkJmd8WK/XEPVXgzY7NhX
X-Received: by 2002:a05:600c:1548:b0:498:ff3:71ed with SMTP id 5b1f17b1804b1-4980ff372a8mr286502575e9.17.1785838437885;
        Tue, 04 Aug 2026 03:13:57 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2ff6sm71600725e9.1.2026.08.04.03.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:13:57 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: clear remote wake on idle Intel ACPI paths
Date: Tue,  4 Aug 2026 11:13:56 +0100
Message-ID: <48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6953217d9f44 ("usb: core: allow ACPI-managed hard-wired
ports to power off") allows internal USB devices on ACPI-managed
hard-wired ports to use the existing runtime power-off path. For Intel
combined USB Bluetooth controllers, btusb still keeps runtime remote wake
enabled for as long as the adapter is open, which prevents the USB PM
core from dropping the last child reference and powering the port off
while idle.

Only keep runtime remote wake enabled while the controller is expected to
signal activity on its own: initialization, outstanding HCI commands,
established links, discovery, LE scan, LE advertising, BR/EDR page or
inquiry scan, diagnostic modes, DUT mode, quality reports, or Intel
devcoredump collection. When those are idle, clear needs_remote_wakeup so
autosuspend can power-manage the port and a later host-initiated command
can resume the device again.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/bluetooth/btusb.c         | 917 +++++++++++++++++++++++++++++-
 include/net/bluetooth/bluetooth.h |   1 +
 include/net/bluetooth/hci.h       |   4 +
 net/bluetooth/hci_debugfs.c       |  20 +-
 net/bluetooth/hci_sock.c          |   5 +
 net/bluetooth/hci_sync.c          |   2 +
 net/bluetooth/mgmt.c              |  15 +-
 7 files changed, 940 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8f7ed469cac6..a69f63c87b27 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -957,6 +957,18 @@ struct qca_dump_info {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_REMOTE_WAKEUP_ACTIVE	18
+#define BTUSB_REMOTE_WAKEUP_COREDUMP	19
+
+#define BTUSB_REMOTE_WAKEUP_RETRY	msecs_to_jiffies(100)
+
+struct btusb_raw_vendor_cmd {
+	struct list_head list;
+	struct sk_buff *skb;
+	unsigned long expires;
+	u16 opcode;
+	bool submitted;
+};
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -969,9 +981,25 @@ struct btusb_data {
 	unsigned long flags;
 
 	bool poll_sync;
+	bool intel_idle_power_manageable;
+	int (*setup)(struct hci_dev *hdev);
+	int (*set_diag)(struct hci_dev *hdev, bool enable);
+	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
+	void (*coredump)(struct hci_dev *hdev);
+	void (*coredump_notify)(struct hci_dev *hdev, int state);
 	int intr_interval;
 	struct work_struct  work;
 	struct work_struct  waker;
+	struct delayed_work remote_wakeup;
+	struct delayed_work remote_wakeup_retry;
+	struct delayed_work coredump_remote_wakeup;
+	struct delayed_work raw_vendor_cmd_timeout;
+	unsigned long coredump_remote_wakeup_expires;
+	struct list_head raw_vendor_cmds;
+	unsigned int raw_vendor_cmd_count;
+	unsigned int raw_vendor_cmd_submitted;
+	/* Protects remote wake update scheduling against close/remove. */
+	spinlock_t remote_wakeup_lock;
 	struct delayed_work rx_work;
 
 	struct sk_buff_head acl_q;
@@ -1026,6 +1054,16 @@ struct btusb_data {
 	struct qca_dump_info qca_dump;
 };
 
+static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data);
+static bool btusb_raw_vendor_cmd_pending(struct btusb_data *data);
+static void btusb_raw_vendor_cmd_done(struct btusb_data *data, u16 opcode);
+static bool btusb_event_completes_raw_vendor_cmd(struct sk_buff *skb,
+						 u16 *opcode);
+static void btusb_raw_vendor_cmd_free_list(struct list_head *cmds);
+static void btusb_remote_wakeup_set_active(struct btusb_data *data,
+					   bool active);
+static void btusb_queue_remote_wakeup_update(struct btusb_data *data);
+
 static void btusb_reset(struct hci_dev *hdev)
 {
 	struct btusb_data *data;
@@ -1237,12 +1275,26 @@ static inline void btusb_free_frags(struct btusb_data *data)
 
 static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb)
 {
+	bool raw_vendor_cmd_done;
+	u16 raw_vendor_opcode;
+	int err;
+
 	if (data->intr_interval) {
 		/* Trigger dequeue immediately if an event is received */
 		schedule_delayed_work(&data->rx_work, 0);
 	}
 
-	return data->recv_event(data->hdev, skb);
+	raw_vendor_cmd_done = btusb_event_completes_raw_vendor_cmd(skb,
+								   &raw_vendor_opcode);
+
+	err = data->recv_event(data->hdev, skb);
+	if (!err) {
+		if (raw_vendor_cmd_done)
+			btusb_raw_vendor_cmd_done(data, raw_vendor_opcode);
+		btusb_queue_remote_wakeup_update(data);
+	}
+
+	return err;
 }
 
 static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
@@ -2010,7 +2062,10 @@ static int btusb_open(struct hci_dev *hdev)
 			goto setup_fail;
 	}
 
-	data->intf->needs_remote_wakeup = 1;
+	data->intf->needs_remote_wakeup =
+		btusb_needs_runtime_remote_wakeup(data);
+	if (data->intel_idle_power_manageable)
+		btusb_remote_wakeup_set_active(data, true);
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
@@ -2039,6 +2094,7 @@ static int btusb_open(struct hci_dev *hdev)
 
 failed:
 	clear_bit(BTUSB_INTR_RUNNING, &data->flags);
+	btusb_remote_wakeup_set_active(data, false);
 setup_fail:
 	usb_autopm_put_interface(data->intf);
 	return err;
@@ -2053,6 +2109,657 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->ctrl_anchor);
 }
 
+static bool btusb_needs_runtime_remote_wakeup(struct btusb_data *data)
+{
+	struct hci_dev *hdev = data->hdev;
+
+	if (!data->intel_idle_power_manageable)
+		return true;
+
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
+		return true;
+
+	/*
+	 * HCI_CMD_PENDING only covers synchronous requests. cmd_cnt reaches
+	 * zero while any accepted HCI command is awaiting Command Complete or
+	 * Command Status.
+	 */
+	if (!atomic_read(&hdev->cmd_cnt) ||
+	    hci_dev_test_flag(hdev, HCI_CMD_PENDING) ||
+	    test_bit(HCI_INIT, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_VENDOR_DIAG) ||
+	    hci_dev_test_flag(hdev, HCI_QUALITY_REPORT) ||
+	    hci_dev_test_flag(hdev, HCI_DUT_MODE))
+		return true;
+
+	if (test_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags))
+		return true;
+
+	if (btusb_raw_vendor_cmd_pending(data))
+		return true;
+
+	if (hci_conn_count(hdev))
+		return true;
+
+	if (hdev->discovery.state == DISCOVERY_FINDING ||
+	    hdev->discovery.state == DISCOVERY_RESOLVING)
+		return true;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+	    hci_dev_test_flag(hdev, HCI_LE_ADV) ||
+	    hci_dev_test_flag(hdev, HCI_LE_PER_ADV) ||
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    test_bit(HCI_PSCAN, &hdev->flags) ||
+	    test_bit(HCI_ISCAN, &hdev->flags) ||
+	    test_bit(HCI_INQUIRY, &hdev->flags) ||
+	    hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
+		return true;
+
+	return false;
+}
+
+static void btusb_remote_wakeup_set_active(struct btusb_data *data, bool active)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	if (active)
+		set_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags);
+	else
+		clear_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+}
+
+static bool btusb_remote_wakeup_active(struct btusb_data *data)
+{
+	unsigned long flags;
+	bool active;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	active = test_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags) &&
+		 !hci_dev_test_flag(data->hdev, HCI_CMD_DRAIN_WORKQUEUE);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	return active;
+}
+
+static bool btusb_queue_remote_wakeup_work(struct btusb_data *data)
+{
+	unsigned long flags;
+	bool active;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	active = test_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags) &&
+		 !hci_dev_test_flag(data->hdev, HCI_CMD_DRAIN_WORKQUEUE);
+	if (active)
+		mod_delayed_work(data->hdev->workqueue, &data->remote_wakeup, 0);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	return active;
+}
+
+static bool btusb_queue_remote_wakeup_retry(struct btusb_data *data)
+{
+	unsigned long flags;
+	bool active;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	active = test_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags) &&
+		 !hci_dev_test_flag(data->hdev, HCI_CMD_DRAIN_WORKQUEUE);
+	if (active)
+		mod_delayed_work(system_freezable_wq, &data->remote_wakeup_retry,
+				 BTUSB_REMOTE_WAKEUP_RETRY);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	return active;
+}
+
+static bool btusb_remote_wakeup_pm_retryable(int err)
+{
+	return err == -EACCES || err == -EAGAIN || err == -EBUSY;
+}
+
+static void btusb_remote_wakeup_work(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data,
+					       remote_wakeup.work);
+	int err;
+
+	if (!btusb_remote_wakeup_active(data))
+		return;
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0) {
+		if (btusb_remote_wakeup_pm_retryable(err))
+			btusb_queue_remote_wakeup_retry(data);
+		return;
+	}
+
+	if (btusb_remote_wakeup_active(data))
+		data->intf->needs_remote_wakeup =
+			btusb_needs_runtime_remote_wakeup(data);
+
+	usb_autopm_put_interface(data->intf);
+}
+
+static void btusb_remote_wakeup_retry_work(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data,
+					       remote_wakeup_retry.work);
+
+	btusb_queue_remote_wakeup_work(data);
+}
+
+static void btusb_queue_remote_wakeup_update(struct btusb_data *data)
+{
+	btusb_queue_remote_wakeup_work(data);
+}
+
+static bool btusb_raw_vendor_cmd_pending(struct btusb_data *data)
+{
+	unsigned long flags;
+	bool pending;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	pending = data->raw_vendor_cmd_submitted;
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	return pending;
+}
+
+static bool btusb_skb_raw_vendor_cmd_opcode(struct sk_buff *skb, u16 *opcode)
+{
+	struct hci_command_hdr *cmd;
+	u16 cmd_opcode;
+
+	if (hci_skb_pkt_type(skb) != HCI_COMMAND_PKT ||
+	    !(bt_cb(skb)->hci.req_flags & HCI_REQ_RAW) ||
+	    skb->len < HCI_COMMAND_HDR_SIZE)
+		return false;
+
+	cmd = (void *)skb->data;
+	cmd_opcode = le16_to_cpu(cmd->opcode);
+
+	if (hci_opcode_ogf(cmd_opcode) != 0x3f)
+		return false;
+
+	*opcode = cmd_opcode;
+
+	return true;
+}
+
+static void btusb_raw_vendor_cmd_add(struct btusb_data *data,
+				     struct btusb_raw_vendor_cmd *cmd)
+{
+	unsigned long flags;
+
+	if (!data->intel_idle_power_manageable)
+		return;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	list_add_tail(&cmd->list, &data->raw_vendor_cmds);
+	data->raw_vendor_cmd_count++;
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+}
+
+static void btusb_raw_vendor_cmd_schedule_locked(struct btusb_data *data)
+{
+	struct btusb_raw_vendor_cmd *cmd;
+	unsigned long expires = 0;
+
+	if (!data->raw_vendor_cmd_submitted)
+		return;
+
+	list_for_each_entry(cmd, &data->raw_vendor_cmds, list) {
+		if (!cmd->submitted)
+			continue;
+
+		if (!expires || time_before(cmd->expires, expires))
+			expires = cmd->expires;
+	}
+
+	if (expires)
+		mod_delayed_work(system_wq, &data->raw_vendor_cmd_timeout,
+				 time_after(expires, jiffies) ?
+				 expires - jiffies : 0);
+}
+
+static void btusb_raw_vendor_cmd_remove_locked(struct btusb_data *data,
+					       struct btusb_raw_vendor_cmd *cmd,
+					       struct list_head *cmds,
+					       bool *queue)
+{
+	list_move_tail(&cmd->list, cmds);
+	data->raw_vendor_cmd_count--;
+
+	if (!cmd->submitted)
+		return;
+
+	data->raw_vendor_cmd_submitted--;
+	*queue = true;
+}
+
+static bool btusb_raw_vendor_cmd_submitted(struct btusb_data *data,
+					   struct btusb_raw_vendor_cmd *cmd)
+{
+	struct btusb_raw_vendor_cmd *iter;
+	unsigned long flags;
+	bool arm = false;
+
+	if (!data->intel_idle_power_manageable || !cmd)
+		return false;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	list_for_each_entry(iter, &data->raw_vendor_cmds, list) {
+		if (iter != cmd || iter->submitted)
+			continue;
+
+		iter->submitted = true;
+		iter->expires = jiffies + HCI_CMD_TIMEOUT;
+		data->raw_vendor_cmd_submitted++;
+		arm = true;
+		break;
+	}
+
+	if (arm)
+		btusb_raw_vendor_cmd_schedule_locked(data);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	return arm;
+}
+
+static struct btusb_raw_vendor_cmd *
+btusb_raw_vendor_cmd_submitted_by_skb(struct btusb_data *data,
+				      struct sk_buff *skb)
+{
+	struct btusb_raw_vendor_cmd *cmd, *submitted = NULL;
+	unsigned long flags;
+
+	if (!data->intel_idle_power_manageable)
+		return NULL;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	list_for_each_entry(cmd, &data->raw_vendor_cmds, list) {
+		if (cmd->skb != skb || cmd->submitted)
+			continue;
+
+		cmd->submitted = true;
+		cmd->expires = jiffies + HCI_CMD_TIMEOUT;
+		data->raw_vendor_cmd_submitted++;
+		submitted = cmd;
+		break;
+	}
+
+	if (submitted)
+		btusb_raw_vendor_cmd_schedule_locked(data);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	return submitted;
+}
+
+static void btusb_raw_vendor_cmd_cancel(struct btusb_data *data,
+					struct btusb_raw_vendor_cmd *cmd)
+{
+	LIST_HEAD(cmds);
+	struct btusb_raw_vendor_cmd *iter, *tmp;
+	unsigned long flags;
+	bool queue = false;
+
+	if (!data->intel_idle_power_manageable || !cmd)
+		return;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	list_for_each_entry_safe(iter, tmp, &data->raw_vendor_cmds, list) {
+		if (iter != cmd)
+			continue;
+
+		btusb_raw_vendor_cmd_remove_locked(data, iter, &cmds, &queue);
+		break;
+	}
+	btusb_raw_vendor_cmd_schedule_locked(data);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	btusb_raw_vendor_cmd_free_list(&cmds);
+
+	if (queue)
+		btusb_queue_remote_wakeup_update(data);
+}
+
+static void btusb_raw_vendor_cmd_cancel_unsubmitted(struct btusb_data *data,
+						    struct sk_buff *skb)
+{
+	struct btusb_raw_vendor_cmd *cmd, *tmp;
+	LIST_HEAD(cmds);
+	unsigned long flags;
+	bool queue = false;
+
+	if (!data->intel_idle_power_manageable)
+		return;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	list_for_each_entry_safe(cmd, tmp, &data->raw_vendor_cmds, list) {
+		if (cmd->skb != skb || cmd->submitted)
+			continue;
+
+		btusb_raw_vendor_cmd_remove_locked(data, cmd, &cmds, &queue);
+		break;
+	}
+	btusb_raw_vendor_cmd_schedule_locked(data);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	btusb_raw_vendor_cmd_free_list(&cmds);
+
+	if (queue)
+		btusb_queue_remote_wakeup_update(data);
+}
+
+static void btusb_raw_vendor_cmd_free_list(struct list_head *cmds)
+{
+	struct btusb_raw_vendor_cmd *cmd, *tmp;
+
+	list_for_each_entry_safe(cmd, tmp, cmds, list) {
+		list_del(&cmd->list);
+		kfree(cmd);
+	}
+}
+
+static void btusb_raw_vendor_cmd_done(struct btusb_data *data, u16 opcode)
+{
+	struct btusb_raw_vendor_cmd *cmd, *tmp;
+	LIST_HEAD(cmds);
+	unsigned long flags;
+	bool queue = false;
+
+	if (!data->intel_idle_power_manageable)
+		return;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	list_for_each_entry_safe(cmd, tmp, &data->raw_vendor_cmds, list) {
+		if (!cmd->submitted || cmd->opcode != opcode)
+			continue;
+
+		btusb_raw_vendor_cmd_remove_locked(data, cmd, &cmds, &queue);
+		break;
+	}
+	btusb_raw_vendor_cmd_schedule_locked(data);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	btusb_raw_vendor_cmd_free_list(&cmds);
+
+	if (queue)
+		btusb_queue_remote_wakeup_update(data);
+}
+
+static void btusb_raw_vendor_cmd_clear(struct btusb_data *data)
+{
+	LIST_HEAD(cmds);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	list_splice_init(&data->raw_vendor_cmds, &cmds);
+	data->raw_vendor_cmd_count = 0;
+	data->raw_vendor_cmd_submitted = 0;
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	btusb_raw_vendor_cmd_free_list(&cmds);
+}
+
+static void btusb_raw_vendor_cmd_timeout_work(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data,
+					       raw_vendor_cmd_timeout.work);
+	LIST_HEAD(cmds);
+	struct btusb_raw_vendor_cmd *cmd, *tmp;
+	unsigned long flags;
+	bool queue = false;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	list_for_each_entry_safe(cmd, tmp, &data->raw_vendor_cmds, list) {
+		if (!cmd->submitted || time_before(jiffies, cmd->expires))
+			continue;
+
+		btusb_raw_vendor_cmd_remove_locked(data, cmd, &cmds, &queue);
+	}
+	btusb_raw_vendor_cmd_schedule_locked(data);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	btusb_raw_vendor_cmd_free_list(&cmds);
+
+	if (queue)
+		btusb_queue_remote_wakeup_update(data);
+}
+
+static bool btusb_event_completes_raw_vendor_cmd(struct sk_buff *skb,
+						 u16 *opcode)
+{
+	struct hci_event_hdr *hdr;
+	u16 event_opcode;
+
+	if (skb->len < HCI_EVENT_HDR_SIZE)
+		return false;
+
+	hdr = (void *)skb->data;
+	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
+		struct hci_ev_cmd_complete *ev;
+
+		if (skb->len < HCI_EVENT_HDR_SIZE + sizeof(*ev))
+			return false;
+
+		ev = (void *)(skb->data + HCI_EVENT_HDR_SIZE);
+		event_opcode = le16_to_cpu(ev->opcode);
+	} else if (hdr->evt == HCI_EV_CMD_STATUS) {
+		struct hci_ev_cmd_status *ev;
+
+		if (skb->len < HCI_EVENT_HDR_SIZE + sizeof(*ev))
+			return false;
+
+		ev = (void *)(skb->data + HCI_EVENT_HDR_SIZE);
+		event_opcode = le16_to_cpu(ev->opcode);
+		if (!ev->status)
+			return false;
+	} else {
+		return false;
+	}
+
+	if (hci_opcode_ogf(event_opcode) != 0x3f)
+		return false;
+
+	*opcode = event_opcode;
+
+	return true;
+}
+
+static int btusb_hold_remote_wakeup(struct btusb_data *data)
+{
+	int err;
+
+	if (!data->intel_idle_power_manageable)
+		return 0;
+
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return err;
+
+	data->intf->needs_remote_wakeup = true;
+
+	return 0;
+}
+
+static void btusb_put_remote_wakeup(struct btusb_data *data)
+{
+	if (data->intel_idle_power_manageable)
+		usb_autopm_put_interface(data->intf);
+}
+
+static void btusb_free_tx_urb(struct urb *urb)
+{
+	kfree(urb->setup_packet);
+	usb_free_urb(urb);
+}
+
+static void btusb_coredump_remote_wakeup_clear(struct btusb_data *data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	data->coredump_remote_wakeup_expires = 0;
+	clear_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags);
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+}
+
+static void btusb_coredump_remote_wakeup_work(struct work_struct *work)
+{
+	struct btusb_data *data = container_of(work, struct btusb_data,
+					       coredump_remote_wakeup.work);
+	unsigned long flags;
+	bool queue = false;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	if (time_after_eq(jiffies, data->coredump_remote_wakeup_expires)) {
+		data->coredump_remote_wakeup_expires = 0;
+		clear_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags);
+		queue = true;
+	}
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	if (queue)
+		btusb_queue_remote_wakeup_update(data);
+}
+
+static void btusb_coredump_remote_wakeup_set(struct btusb_data *data,
+					     bool active)
+{
+	unsigned long flags;
+	int err;
+	bool queue = false;
+
+	spin_lock_irqsave(&data->remote_wakeup_lock, flags);
+	if (active && test_bit(BTUSB_REMOTE_WAKEUP_ACTIVE, &data->flags) &&
+	    !hci_dev_test_flag(data->hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
+		data->coredump_remote_wakeup_expires =
+			jiffies + DEVCOREDUMP_TIMEOUT;
+		set_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags);
+		mod_delayed_work(system_wq, &data->coredump_remote_wakeup,
+				 DEVCOREDUMP_TIMEOUT);
+		queue = true;
+	} else {
+		data->coredump_remote_wakeup_expires = 0;
+		clear_bit(BTUSB_REMOTE_WAKEUP_COREDUMP, &data->flags);
+	}
+	spin_unlock_irqrestore(&data->remote_wakeup_lock, flags);
+
+	if (queue) {
+		err = btusb_hold_remote_wakeup(data);
+		if (!err)
+			btusb_put_remote_wakeup(data);
+	}
+
+	btusb_queue_remote_wakeup_update(data);
+}
+
+static void btusb_intel_coredump_notify(struct hci_dev *hdev, int state)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	if (data->coredump_notify)
+		data->coredump_notify(hdev, state);
+
+	if (state == HCI_DEVCOREDUMP_ACTIVE)
+		btusb_coredump_remote_wakeup_set(data, true);
+	else
+		btusb_coredump_remote_wakeup_set(data, false);
+}
+
+static void btusb_intel_coredump(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	btusb_coredump_remote_wakeup_set(data, true);
+
+	if (data->coredump)
+		data->coredump(hdev);
+}
+
+static int btusb_intel_set_diag(struct hci_dev *hdev, bool enable)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	if (enable) {
+		hci_dev_set_flag(hdev, HCI_VENDOR_DIAG);
+		btusb_queue_remote_wakeup_update(data);
+	}
+
+	err = data->set_diag(hdev, enable);
+	if (err) {
+		if (enable) {
+			hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
+			btusb_queue_remote_wakeup_update(data);
+		}
+		return err;
+	}
+
+	if (!enable) {
+		hci_dev_clear_flag(hdev, HCI_VENDOR_DIAG);
+		btusb_queue_remote_wakeup_update(data);
+	}
+
+	return 0;
+}
+
+static int btusb_intel_set_quality_report(struct hci_dev *hdev, bool enable)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	if (enable) {
+		hci_dev_set_flag(hdev, HCI_QUALITY_REPORT);
+		btusb_queue_remote_wakeup_update(data);
+	}
+
+	err = data->set_quality_report(hdev, enable);
+	if (err) {
+		if (enable) {
+			hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+			btusb_queue_remote_wakeup_update(data);
+		}
+		return err;
+	}
+
+	if (!enable) {
+		hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);
+		btusb_queue_remote_wakeup_update(data);
+	}
+
+	return 0;
+}
+
+static int btusb_intel_setup(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	int err;
+
+	err = data->setup(hdev);
+	if (err)
+		return err;
+
+	if (hdev->set_quality_report &&
+	    hdev->set_quality_report != btusb_intel_set_quality_report) {
+		data->set_quality_report = hdev->set_quality_report;
+		hdev->set_quality_report = btusb_intel_set_quality_report;
+	}
+
+	if (hdev->dump.coredump &&
+	    hdev->dump.coredump != btusb_intel_coredump) {
+		data->coredump = hdev->dump.coredump;
+		data->coredump_notify = hdev->dump.notify_change;
+		hdev->dump.coredump = btusb_intel_coredump;
+		hdev->dump.notify_change = btusb_intel_coredump_notify;
+	}
+
+	return 0;
+}
+
 static int btusb_close(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2063,6 +2770,13 @@ static int btusb_close(struct hci_dev *hdev)
 	cancel_delayed_work(&data->rx_work);
 	cancel_work_sync(&data->work);
 	cancel_work_sync(&data->waker);
+	btusb_remote_wakeup_set_active(data, false);
+	cancel_delayed_work_sync(&data->coredump_remote_wakeup);
+	btusb_coredump_remote_wakeup_clear(data);
+	cancel_delayed_work_sync(&data->raw_vendor_cmd_timeout);
+	btusb_raw_vendor_cmd_clear(data);
+	cancel_delayed_work_sync(&data->remote_wakeup_retry);
+	cancel_delayed_work_sync(&data->remote_wakeup);
 
 	skb_queue_purge(&data->acl_q);
 
@@ -2218,7 +2932,16 @@ static int submit_tx_urb(struct hci_dev *hdev, struct urb *urb)
 	return err;
 }
 
-static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
+static void btusb_defer_tx_urb(struct btusb_data *data, struct urb *urb)
+{
+	usb_anchor_urb(urb, &data->deferred);
+	schedule_work(&data->waker);
+
+	usb_free_urb(urb);
+}
+
+static bool btusb_defer_tx_urb_if_suspending(struct hci_dev *hdev,
+					     struct urb *urb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	unsigned long flags;
@@ -2226,20 +2949,121 @@ static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
 
 	spin_lock_irqsave(&data->txlock, flags);
 	suspending = test_bit(BTUSB_SUSPENDING, &data->flags);
+	spin_unlock_irqrestore(&data->txlock, flags);
+
 	if (!suspending)
+		return false;
+
+	btusb_defer_tx_urb(data, urb);
+
+	return true;
+}
+
+static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->txlock, flags);
+	if (!test_bit(BTUSB_SUSPENDING, &data->flags)) {
 		data->tx_in_flight++;
+		spin_unlock_irqrestore(&data->txlock, flags);
+
+		return submit_tx_urb(hdev, urb);
+	}
 	spin_unlock_irqrestore(&data->txlock, flags);
 
-	if (!suspending)
+	btusb_defer_tx_urb(data, urb);
+
+	return 0;
+}
+
+static int btusb_raw_vendor_cmd_prepare(struct btusb_data *data,
+					struct sk_buff *skb,
+					struct btusb_raw_vendor_cmd **cmd)
+{
+	u16 opcode;
+
+	*cmd = NULL;
+
+	if (!data->intel_idle_power_manageable ||
+	    !btusb_skb_raw_vendor_cmd_opcode(skb, &opcode))
+		return 0;
+
+	*cmd = kzalloc(sizeof(**cmd), GFP_KERNEL);
+	if (!*cmd)
+		return -ENOMEM;
+
+	(*cmd)->skb = skb;
+	(*cmd)->opcode = opcode;
+	btusb_raw_vendor_cmd_add(data, *cmd);
+
+	return 0;
+}
+
+static int submit_or_queue_cmd_urb(struct hci_dev *hdev, struct urb *urb,
+				   struct btusb_raw_vendor_cmd *raw_vendor_cmd)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data->txlock, flags);
+	if (!test_bit(BTUSB_SUSPENDING, &data->flags)) {
+		data->tx_in_flight++;
+		btusb_raw_vendor_cmd_submitted(data, raw_vendor_cmd);
+		spin_unlock_irqrestore(&data->txlock, flags);
+
 		return submit_tx_urb(hdev, urb);
+	}
+	spin_unlock_irqrestore(&data->txlock, flags);
 
-	usb_anchor_urb(urb, &data->deferred);
-	schedule_work(&data->waker);
+	btusb_defer_tx_urb(data, urb);
 
-	usb_free_urb(urb);
 	return 0;
 }
 
+static int btusb_submit_cmd_urb(struct hci_dev *hdev, struct urb *urb,
+				struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btusb_raw_vendor_cmd *raw_vendor_cmd;
+	int err;
+
+	err = btusb_raw_vendor_cmd_prepare(data, skb, &raw_vendor_cmd);
+	if (err < 0) {
+		btusb_free_tx_urb(urb);
+		return err;
+	}
+
+	hdev->stat.cmd_tx++;
+	if (btusb_defer_tx_urb_if_suspending(hdev, urb)) {
+		btusb_queue_remote_wakeup_update(data);
+		return 0;
+	}
+
+	err = btusb_hold_remote_wakeup(data);
+	if (err < 0) {
+		if (err == -EACCES &&
+		    btusb_defer_tx_urb_if_suspending(hdev, urb)) {
+			btusb_queue_remote_wakeup_update(data);
+			return 0;
+		}
+
+		if (raw_vendor_cmd)
+			btusb_raw_vendor_cmd_cancel(data, raw_vendor_cmd);
+		btusb_free_tx_urb(urb);
+		return err;
+	}
+
+	err = submit_or_queue_cmd_urb(hdev, urb, raw_vendor_cmd);
+	btusb_put_remote_wakeup(data);
+	if (err < 0 && raw_vendor_cmd)
+		btusb_raw_vendor_cmd_cancel(data, raw_vendor_cmd);
+	btusb_queue_remote_wakeup_update(data);
+
+	return err;
+}
+
 static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct urb *urb;
@@ -2252,8 +3076,7 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		if (IS_ERR(urb))
 			return PTR_ERR(urb);
 
-		hdev->stat.cmd_tx++;
-		return submit_or_queue_tx_urb(hdev, urb);
+		return btusb_submit_cmd_urb(hdev, urb, skb);
 
 	case HCI_ACLDATA_PKT:
 		urb = alloc_bulk_urb(hdev, skb);
@@ -2286,13 +3109,26 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
+static bool btusb_notify_is_sco(unsigned int evt)
+{
+	return evt == HCI_NOTIFY_ENABLE_SCO_CVSD ||
+	       evt == HCI_NOTIFY_ENABLE_SCO_TRANSP ||
+	       evt == HCI_NOTIFY_DISABLE_SCO;
+}
+
 static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
 	BT_DBG("%s evt %d", hdev->name, evt);
 
-	if (hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
+	if (evt == HCI_NOTIFY_CONN_ADD || evt == HCI_NOTIFY_CONN_DEL ||
+	    evt == HCI_NOTIFY_DUT_MODE || evt == HCI_NOTIFY_INIT_DONE ||
+	    evt == HCI_NOTIFY_ADV_STATE || evt == HCI_NOTIFY_USER_CHANNEL)
+		btusb_queue_remote_wakeup_update(data);
+
+	if (btusb_notify_is_sco(evt) &&
+	    hci_conn_num(hdev, SCO_LINK) != data->sco_num) {
 		data->sco_num = hci_conn_num(hdev, SCO_LINK);
 		data->air_mode = evt;
 		schedule_work(&data->work);
@@ -2727,16 +3563,15 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 			 */
 			if (opcode == BTINTEL_HCI_OP_RESET)
 				inject_cmd_complete(hdev, opcode);
-		} else {
-			urb = alloc_ctrl_urb(hdev, skb);
-		}
-		if (IS_ERR(urb))
-			return PTR_ERR(urb);
+			} else {
+				urb = alloc_ctrl_urb(hdev, skb);
+			}
+			if (IS_ERR(urb))
+				return PTR_ERR(urb);
 
-		hdev->stat.cmd_tx++;
-		return submit_or_queue_tx_urb(hdev, urb);
+			return btusb_submit_cmd_urb(hdev, urb, skb);
 
-	case HCI_ACLDATA_PKT:
+		case HCI_ACLDATA_PKT:
 		urb = alloc_bulk_urb(hdev, skb);
 		if (IS_ERR(urb))
 			return PTR_ERR(urb);
@@ -4137,6 +4972,15 @@ static int btusb_probe(struct usb_interface *intf,
 
 	INIT_WORK(&data->work, btusb_work);
 	INIT_WORK(&data->waker, btusb_waker);
+	INIT_DELAYED_WORK(&data->remote_wakeup, btusb_remote_wakeup_work);
+	INIT_DELAYED_WORK(&data->remote_wakeup_retry,
+			  btusb_remote_wakeup_retry_work);
+	INIT_DELAYED_WORK(&data->coredump_remote_wakeup,
+			  btusb_coredump_remote_wakeup_work);
+	INIT_DELAYED_WORK(&data->raw_vendor_cmd_timeout,
+			  btusb_raw_vendor_cmd_timeout_work);
+	INIT_LIST_HEAD(&data->raw_vendor_cmds);
+	spin_lock_init(&data->remote_wakeup_lock);
 	INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
 
 	skb_queue_head_init(&data->acl_q);
@@ -4158,6 +5002,12 @@ static int btusb_probe(struct usb_interface *intf,
 	data->recv_bulk = btusb_recv_bulk;
 
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
+		data->intel_idle_power_manageable =
+			IS_ENABLED(CONFIG_ACPI) &&
+			data->udev->parent && data->udev->portnum &&
+			usb_acpi_power_manageable(data->udev->parent,
+						  data->udev->portnum - 1);
+
 		/* Allocate extra space for Intel device */
 		priv_size += sizeof(struct btintel_data);
 
@@ -4253,6 +5103,11 @@ static int btusb_probe(struct usb_interface *intf,
 		if (err)
 			goto err_kill_tx_urbs;
 
+		data->set_diag = hdev->set_diag;
+		hdev->set_diag = btusb_intel_set_diag;
+		data->setup = hdev->setup;
+		hdev->setup = btusb_intel_setup;
+
 		/* Transport specific configuration */
 		hdev->send = btusb_send_frame_intel;
 		hdev->reset = btusb_intel_reset;
@@ -4499,7 +5354,14 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->disconnect)
 		data->disconnect(hdev);
 
+	btusb_remote_wakeup_set_active(data, false);
+	cancel_delayed_work_sync(&data->remote_wakeup_retry);
+	cancel_delayed_work_sync(&data->remote_wakeup);
 	hci_unregister_dev(hdev);
+	cancel_delayed_work_sync(&data->coredump_remote_wakeup);
+	btusb_coredump_remote_wakeup_clear(data);
+	cancel_delayed_work_sync(&data->raw_vendor_cmd_timeout);
+	btusb_raw_vendor_cmd_clear(data);
 
 	if (data->oob_wake_irq) {
 		device_init_wakeup(&data->udev->dev, false);
@@ -4587,19 +5449,27 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
-static void play_deferred(struct btusb_data *data)
+static bool play_deferred(struct btusb_data *data)
 {
+	struct btusb_raw_vendor_cmd *raw_vendor_cmd;
 	struct urb *urb;
+	bool queue = false;
 	int err;
 
 	while ((urb = usb_get_from_anchor(&data->deferred))) {
+		struct sk_buff *skb = urb->context;
+
 		usb_anchor_urb(urb, &data->tx_anchor);
+		raw_vendor_cmd = btusb_raw_vendor_cmd_submitted_by_skb(data, skb);
+		if (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT)
+			queue = true;
 
 		err = usb_submit_urb(urb, GFP_ATOMIC);
 		if (err < 0) {
 			if (err != -EPERM && err != -ENODEV)
 				BT_ERR("%s urb %p submission failed (%d)",
 				       data->hdev->name, urb, -err);
+			btusb_raw_vendor_cmd_cancel(data, raw_vendor_cmd);
 			kfree(urb->setup_packet);
 			usb_unanchor_urb(urb);
 			usb_free_urb(urb);
@@ -4612,15 +5482,19 @@ static void play_deferred(struct btusb_data *data)
 
 	/* Cleanup the rest deferred urbs. */
 	while ((urb = usb_get_from_anchor(&data->deferred))) {
+		btusb_raw_vendor_cmd_cancel_unsubmitted(data, urb->context);
 		kfree(urb->setup_packet);
 		usb_free_urb(urb);
 	}
+
+	return queue;
 }
 
 static int btusb_resume(struct usb_interface *intf)
 {
 	struct btusb_data *data = usb_get_intfdata(intf);
 	struct hci_dev *hdev = data->hdev;
+	bool queue_remote_wakeup;
 	int err = 0;
 
 	BT_DBG("intf %p", intf);
@@ -4666,14 +5540,17 @@ static int btusb_resume(struct usb_interface *intf)
 		data->resume(hdev);
 
 	spin_lock_irq(&data->txlock);
-	play_deferred(data);
+	queue_remote_wakeup = play_deferred(data);
 	clear_bit(BTUSB_SUSPENDING, &data->flags);
 	spin_unlock_irq(&data->txlock);
+	if (queue_remote_wakeup)
+		btusb_queue_remote_wakeup_update(data);
 	schedule_work(&data->work);
 
 	return 0;
 
 failed:
+	btusb_raw_vendor_cmd_clear(data);
 	usb_scuttle_anchored_urbs(&data->deferred);
 done:
 	spin_lock_irq(&data->txlock);
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index b624da5026f5..166e49c11f73 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -469,6 +469,7 @@ int hci_ethtool_ts_info(unsigned int index, int sk_proto,
 
 #define HCI_REQ_START	BIT(0)
 #define HCI_REQ_SKB	BIT(1)
+#define HCI_REQ_RAW	BIT(2)
 
 struct hci_ctrl {
 	struct sock *sk;
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 50f0eef71fb1..b1a2b8bc301a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -52,6 +52,10 @@
 #define HCI_NOTIFY_ENABLE_SCO_CVSD	4
 #define HCI_NOTIFY_ENABLE_SCO_TRANSP	5
 #define HCI_NOTIFY_DISABLE_SCO		6
+#define HCI_NOTIFY_DUT_MODE		7
+#define HCI_NOTIFY_INIT_DONE		8
+#define HCI_NOTIFY_ADV_STATE		9
+#define HCI_NOTIFY_USER_CHANNEL		10
 
 /* HCI bus types */
 #define HCI_VIRTUAL	0
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 0635e4641db4..c8d8b173097b 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -1299,6 +1299,12 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	if (enable == hci_dev_test_flag(hdev, HCI_DUT_MODE))
 		return -EALREADY;
 
+	if (enable) {
+		hci_dev_set_flag(hdev, HCI_DUT_MODE);
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_DUT_MODE);
+	}
+
 	hci_req_sync_lock(hdev);
 	if (enable)
 		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
@@ -1308,12 +1314,22 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 				     HCI_CMD_TIMEOUT);
 	hci_req_sync_unlock(hdev);
 
-	if (IS_ERR(skb))
+	if (IS_ERR(skb)) {
+		if (enable) {
+			hci_dev_clear_flag(hdev, HCI_DUT_MODE);
+			if (hdev->notify)
+				hdev->notify(hdev, HCI_NOTIFY_DUT_MODE);
+		}
 		return PTR_ERR(skb);
+	}
 
 	kfree_skb(skb);
 
-	hci_dev_change_flag(hdev, HCI_DUT_MODE);
+	if (!enable) {
+		hci_dev_clear_flag(hdev, HCI_DUT_MODE);
+		if (hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_DUT_MODE);
+	}
 
 	return count;
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..03b4676869e6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1190,6 +1190,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 	struct sock *sk = sock->sk;
 	struct hci_dev *hdev = NULL;
 	struct sk_buff *skb;
+	bool notify_user_channel = false;
 	int len, err = 0;
 
 	BT_DBG("sock %p sk %p", sock, sk);
@@ -1324,6 +1325,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 				 * is still active.
 				 */
 				err = 0;
+				notify_user_channel = true;
 			} else {
 				hci_dev_clear_flag(hdev, HCI_USER_CHANNEL);
 				mgmt_index_added(hdev);
@@ -1364,6 +1366,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 		}
 
 		atomic_inc(&hdev->promisc);
+		if (notify_user_channel && hdev->notify)
+			hdev->notify(hdev, HCI_NOTIFY_USER_CHANNEL);
 		break;
 
 	case HCI_CHANNEL_MONITOR:
@@ -1894,6 +1898,7 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		hci_skb_opcode(skb) = opcode;
 
 		if (ogf == 0x3f) {
+			bt_cb(skb)->hci.req_flags |= HCI_REQ_RAW;
 			skb_queue_tail(&hdev->raw_q, skb);
 			queue_work(hdev->workqueue, &hdev->tx_work);
 		} else {
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c0b1fc293b49..87199342621b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5212,6 +5212,8 @@ static int hci_dev_init_sync(struct hci_dev *hdev)
 	}
 
 	clear_bit(HCI_INIT, &hdev->flags);
+	if (hdev->notify)
+		hdev->notify(hdev, HCI_NOTIFY_INIT_DONE);
 
 	return ret;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1db10e0f617f..5b652998e60e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2579,6 +2579,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	enabled = lmp_host_le_capable(hdev);
 
 	if (!hdev_is_powered(hdev) || val == enabled) {
+		bool advertising_changed = false;
 		bool changed = false;
 
 		if (val != hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
@@ -2588,6 +2589,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 		if (!val && hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
 			hci_dev_clear_flag(hdev, HCI_ADVERTISING);
+			advertising_changed = true;
 			changed = true;
 		}
 
@@ -2595,8 +2597,11 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		if (err < 0)
 			goto unlock;
 
-		if (changed)
+		if (changed) {
+			if (advertising_changed && hdev->notify)
+				hdev->notify(hdev, HCI_NOTIFY_ADV_STATE);
 			err = new_settings(hdev, sk);
+		}
 
 		goto unlock;
 	}
@@ -6459,6 +6464,9 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 	else
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
+	if (hdev->notify)
+		hdev->notify(hdev, HCI_NOTIFY_ADV_STATE);
+
 	settings_rsp(cmd, &match);
 	mgmt_pending_free(cmd);
 
@@ -6593,8 +6601,11 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (err < 0)
 			goto unlock;
 
-		if (changed)
+		if (changed) {
+			if (hdev->notify)
+				hdev->notify(hdev, HCI_NOTIFY_ADV_STATE);
 			err = new_settings(hdev, sk);
+		}
 
 		goto unlock;
 	}
