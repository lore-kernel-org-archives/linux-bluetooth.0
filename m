Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594E24BD1F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752955; cv=none; b=CMoOwh77n/Cjt1/oh3B5kA4vmas6D3BlklEbUVrv5ioIKkQxMhAfMQckQy8mFFtX4abVzTveUHuL9vV5uHzfcAWZIuCUFzhaEHB6CMCwaE2j2UY2uNmoYb1PZIziUsI2F0Ve77Fc0iyVVbKBrTudylKyobUPbkrrcQPr0nWtiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752955; c=relaxed/simple;
	bh=RCIyqpFgCFMTTNVlbiQM66DsO++IHAAaB+GlzVJdI7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm9IB+itYH8NnVB5uoFBQ9j3GxwU3sYvICDODZ3dYTwctqEIoBPdpTVkA+ixxKbmCRAynBOFJzMIHus/xCwS1ZhbrDT0zFQquSa35G52SGCk7gcY9hDPQ/LaLWIPPnFHT0zaFOrQjKPlo/M3kN0pp5Knr3eVgFrVmY3647yO3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Tjuapke4; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Tjuapke4"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id 247A365C16
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 17:50:24 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:4946:0:640:90b4:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 1358360998;
	Tue, 20 May 2025 17:50:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FoOZXD1LnGk0-U51HdifQ;
	Tue, 20 May 2025 17:50:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1747752615; bh=YyPId1S0RcxSj8MQhyCtFBb4sJqLYlnSCSNR4ExflHM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Tjuapke4Op3j5lClx7Zyy6MDZx5BR9bltkhT7CrnuG/agG2wLK8k/7ojwvbeUTK/Q
	 y5SbiUtqTuWP8UsGg6ymQaPrDpaztlTi3Y36833BFTifj9qSIOu2fU9f02nrDiwk/d
	 1Tjxh0Pwneebeaq0Ct/EG7O5UvSbqD5jBm+yvTsk=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH RFC] Bluetooth: use RCU-protected list to process mgmt commands
Date: Tue, 20 May 2025 17:49:35 +0300
Message-ID: <20250520144935.595774-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CABBYNZLJGwmPSe9Me+OLpr8WLGOenRrwJt_JxVmWfPO_X1YWJg@mail.gmail.com>
References: <CABBYNZLJGwmPSe9Me+OLpr8WLGOenRrwJt_JxVmWfPO_X1YWJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An overall idea is that 'mgmt_pending' of 'struct hci_dev' may be altered
only in 'mgmt_pending_add()' under 'mgmt_lock' protection, where processed
commands are removed each time when the new command is added. All other
users of 'mgmt_pending' (except 'mgmt_pending_cleanup()' where no
concurrent accesses are expected) are read-side critical sections running
under 'rcu_read_lock()'. (I'm also trying to fix socket UAFs observed when
running this code, and most likely these fixes should go to the separate
patch).

Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci_core.h  |  1 +
 net/bluetooth/hci_core.c          |  6 +--
 net/bluetooth/mgmt.c              | 65 ++++++++++++++++++++++---------
 net/bluetooth/mgmt_util.c         | 55 ++++++++++++++++++++------
 net/bluetooth/mgmt_util.h         |  3 ++
 6 files changed, 96 insertions(+), 35 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bbefde319f95..cee6be23acc8 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -655,6 +655,7 @@ static inline bool iso_enabled(void)
 int mgmt_init(void);
 void mgmt_exit(void);
 void mgmt_cleanup(struct sock *sk);
+void mgmt_pending_cleanup(struct hci_dev *hdev);
 
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 54bfeeaa0995..2fb586c6d684 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -546,6 +546,7 @@ struct hci_dev {
 
 	struct list_head	mesh_pending;
 	struct list_head	mgmt_pending;
+	struct mutex		mgmt_lock;
 	struct list_head	reject_list;
 	struct list_head	accept_list;
 	struct list_head	uuids;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5eb0600bbd03..0172ec45f2df 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2492,6 +2492,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 
 	INIT_LIST_HEAD(&hdev->mesh_pending);
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
+	mutex_init(&hdev->mgmt_lock);
 	INIT_LIST_HEAD(&hdev->reject_list);
 	INIT_LIST_HEAD(&hdev->accept_list);
 	INIT_LIST_HEAD(&hdev->uuids);
@@ -2685,10 +2686,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		hci_dev_unlock(hdev);
 	}
 
-	/* mgmt_index_removed should take care of emptying the
-	 * pending list */
-	BUG_ON(!list_empty(&hdev->mgmt_pending));
-
+	mgmt_pending_cleanup(hdev);
 	hci_sock_dev_event(hdev, HCI_DEV_UNREG);
 
 	if (hdev->rfkill) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 46b22708dfbd..e2eccc44076d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1444,25 +1444,30 @@ struct cmd_lookup {
 static void settings_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
 	struct cmd_lookup *match = data;
+	struct sock *sk = cmd->sk;
 
-	send_settings_rsp(cmd->sk, cmd->opcode, match->hdev);
-
-	list_del(&cmd->list);
+	sock_hold(sk);
 
-	if (match->sk == NULL) {
-		match->sk = cmd->sk;
-		sock_hold(match->sk);
-	}
+	send_settings_rsp(sk, cmd->opcode, match->hdev);
+	mgmt_pending_remove(cmd);
 
-	mgmt_pending_free(cmd);
+	if (match->sk == NULL)
+		match->sk = sk;
+	else
+		sock_put(sk);
 }
 
 static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
+	struct sock *sk = cmd->sk;
 	u8 *status = data;
 
+	sock_hold(sk);
+
 	mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode, *status);
 	mgmt_pending_remove(cmd);
+
+	sock_put(sk);
 }
 
 static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
@@ -2598,18 +2603,25 @@ static int mgmt_hci_cmd_sync(struct sock *sk, struct hci_dev *hdev,
 static bool pending_eir_or_class(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
+	bool found = false;
+
+	rcu_read_lock();
 
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+	list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list) {
+		if (atomic_read(&cmd->deleted))
+		    continue;
 		switch (cmd->opcode) {
 		case MGMT_OP_ADD_UUID:
 		case MGMT_OP_REMOVE_UUID:
 		case MGMT_OP_SET_DEV_CLASS:
 		case MGMT_OP_SET_POWERED:
-			return true;
+			found = true;
+			break;
 		}
 	}
 
-	return false;
+	rcu_read_unlock();
+	return found;
 }
 
 static const u8 bluetooth_base_uuid[] = {
@@ -3401,19 +3413,23 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 static struct mgmt_pending_cmd *find_pairing(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *tmp, *cmd = NULL;
 
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (cmd->opcode != MGMT_OP_PAIR_DEVICE)
-			continue;
+	rcu_read_lock();
 
-		if (cmd->user_data != conn)
+	list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
+		if (atomic_read(&tmp->deleted))
 			continue;
-
-		return cmd;
+		if (tmp->opcode != MGMT_OP_PAIR_DEVICE)
+			continue;
+		if (tmp->user_data != conn)
+			continue;
+		cmd = tmp;
+		break;
 	}
 
-	return NULL;
+	rcu_read_unlock();
+	return cmd;
 }
 
 static int pairing_complete(struct mgmt_pending_cmd *cmd, u8 status)
@@ -10476,3 +10492,14 @@ void mgmt_cleanup(struct sock *sk)
 
 	read_unlock(&hci_dev_list_lock);
 }
+
+void mgmt_pending_cleanup(struct hci_dev *hdev)
+{
+	struct mgmt_pending_cmd *cmd, *tmp;
+
+	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
+		BUG_ON(atomic_read(&cmd->deleted) == 0);
+		list_del_rcu(&cmd->list);
+		mgmt_pending_free(cmd);
+	}
+}
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 3713ff490c65..3442bd37fa52 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -217,30 +217,45 @@ int mgmt_cmd_complete(struct sock *sk, u16 index, u16 cmd, u8 status,
 struct mgmt_pending_cmd *mgmt_pending_find(unsigned short channel, u16 opcode,
 					   struct hci_dev *hdev)
 {
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *tmp, *cmd = NULL;
+
+	rcu_read_lock();
 
-	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
-		if (hci_sock_get_channel(cmd->sk) != channel)
+	list_for_each_entry_rcu(tmp, &hdev->mgmt_pending, list) {
+		if (atomic_read(&tmp->deleted))
 			continue;
-		if (cmd->opcode == opcode)
-			return cmd;
+		if (hci_sock_get_channel(tmp->sk) != channel)
+			continue;
+		if (tmp->opcode == opcode) {
+			cmd = tmp;
+			break;
+		}
 	}
 
-	return NULL;
+	rcu_read_unlock();
+	return cmd;
 }
 
 void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
 			  void (*cb)(struct mgmt_pending_cmd *cmd, void *data),
 			  void *data)
 {
-	struct mgmt_pending_cmd *cmd, *tmp;
+	struct mgmt_pending_cmd *cmd;
 
-	list_for_each_entry_safe(cmd, tmp, &hdev->mgmt_pending, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(cmd, &hdev->mgmt_pending, list) {
+		if (atomic_read(&cmd->deleted))
+			continue;
 		if (opcode > 0 && cmd->opcode != opcode)
 			continue;
 
+		rcu_read_unlock();
 		cb(cmd, data);
+		rcu_read_lock();
 	}
+
+	rcu_read_unlock();
 }
 
 struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
@@ -270,17 +285,34 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 	return cmd;
 }
 
+static void mgmt_pending_delayed_free(struct rcu_head *rcu)
+{
+	struct mgmt_pending_cmd *cmd =
+		container_of(rcu, struct mgmt_pending_cmd, head);
+	kfree(cmd->param);
+	kfree(cmd);
+}
+
 struct mgmt_pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 					  struct hci_dev *hdev,
 					  void *data, u16 len)
 {
-	struct mgmt_pending_cmd *cmd;
+	struct mgmt_pending_cmd *cmd, *old, *tmp;
 
 	cmd = mgmt_pending_new(sk, opcode, hdev, data, len);
 	if (!cmd)
 		return NULL;
 
-	list_add_tail(&cmd->list, &hdev->mgmt_pending);
+	mutex_lock(&hdev->mgmt_lock);
+	list_for_each_entry_safe(old, tmp, &hdev->mgmt_pending, list)
+		if (atomic_read(&old->deleted)) {
+			list_del_rcu(&old->list);
+			sock_put(old->sk);
+			call_rcu(&old->head, mgmt_pending_delayed_free);
+		}
+
+	list_add_tail_rcu(&cmd->list, &hdev->mgmt_pending);
+	mutex_unlock(&hdev->mgmt_lock);
 
 	return cmd;
 }
@@ -294,8 +326,7 @@ void mgmt_pending_free(struct mgmt_pending_cmd *cmd)
 
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 {
-	list_del(&cmd->list);
-	mgmt_pending_free(cmd);
+	atomic_set(&cmd->deleted, 1);
 }
 
 void mgmt_mesh_foreach(struct hci_dev *hdev,
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index f2ba994ab1d8..5e681bc74220 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -32,6 +32,8 @@ struct mgmt_mesh_tx {
 
 struct mgmt_pending_cmd {
 	struct list_head list;
+	struct rcu_head head;
+	atomic_t deleted;
 	u16 opcode;
 	int index;
 	void *param;
@@ -65,6 +67,7 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 					  void *data, u16 len);
 void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
+void mgmt_pending_cleanup(struct hci_dev *hdev);
 void mgmt_mesh_foreach(struct hci_dev *hdev,
 		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
 		       void *data, struct sock *sk);
-- 
2.49.0

