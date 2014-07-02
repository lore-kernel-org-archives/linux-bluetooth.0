Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Introduce unconfigured controller state
Date: Wed,  2 Jul 2014 19:10:33 +0200
Message-Id: <1404321033-63920-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the new unconfigured controller state it is possible to provide a
fully functional HCI transport, but disable the higher level operations
that would normally happen. This way userspace can try to configure the
controller before releases the unconfigured state.

The internal state is represented by HCI_UNCONFIGURED. This replaces the
HCI_QUIRK_RAW_DEVICE quirk as internal state representation. This is now
a real state and drivers can use the quirk to actually trigger this
state. In the future this will allow a more fine grained switching from
unconfigured state to configured state for controller inititialization.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_core.c    | 43 ++++++++++++++++++++++++++-----------------
 net/bluetooth/hci_sock.c    |  8 ++++----
 net/bluetooth/mgmt.c        |  6 +++---
 4 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 66358af6b1fc..606a9b1466a3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -127,6 +127,7 @@ enum {
 	HCI_KEEP_DEBUG_KEYS,
 	HCI_USE_DEBUG_KEYS,
 	HCI_UNREGISTER,
+	HCI_UNCONFIGURED,
 	HCI_USER_CHANNEL,
 
 	HCI_LE_SCAN,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1fff3d890f41..395b014ad0e8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2116,7 +2116,7 @@ int hci_inquiry(void __user *arg)
 		goto done;
 	}
 
-	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -2261,7 +2261,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	}
 
 	if (!ret) {
-		if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks) &&
+		if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
 		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
 			ret = __hci_init(hdev);
 	}
@@ -2274,6 +2274,7 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		set_bit(HCI_UP, &hdev->flags);
 		hci_notify(hdev, HCI_DEV_UP);
 		if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
+		    !test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
 		    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) &&
 		    hdev->dev_type == HCI_BREDR) {
 			hci_dev_lock(hdev);
@@ -2317,7 +2318,7 @@ int hci_dev_open(__u16 dev)
 	if (!hdev)
 		return -ENODEV;
 
-	/* Devices that are marked for raw-only usage can only be powered
+	/* Devices that are marked as unconfigured can only be powered
 	 * up as user channel. Trying to bring them up as normal devices
 	 * will result into a failure. Only user channel operation is
 	 * possible.
@@ -2326,7 +2327,7 @@ int hci_dev_open(__u16 dev)
 	 * HCI_USER_CHANNEL will be set first before attempting to
 	 * open the device.
 	 */
-	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks) &&
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
 	    !test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
 		err = -EOPNOTSUPP;
 		goto done;
@@ -2401,8 +2402,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	/* Reset device */
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
-	if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks) &&
-	    !test_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
+	if (!test_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
+	    !test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
 	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_req_sync(hdev, hci_reset_req, 0, HCI_CMD_TIMEOUT);
@@ -2501,7 +2502,7 @@ int hci_dev_reset(__u16 dev)
 		goto done;
 	}
 
-	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
 		ret = -EOPNOTSUPP;
 		goto done;
 	}
@@ -2543,7 +2544,7 @@ int hci_dev_reset_stat(__u16 dev)
 		goto done;
 	}
 
-	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
 		ret = -EOPNOTSUPP;
 		goto done;
 	}
@@ -2573,7 +2574,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		goto done;
 	}
 
-	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
 		err = -EOPNOTSUPP;
 		goto done;
 	}
@@ -2791,6 +2792,7 @@ static void hci_power_on(struct work_struct *work)
 	 * valid, it is important to turn the device back off.
 	 */
 	if (test_bit(HCI_RFKILLED, &hdev->dev_flags) ||
+	    test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) ||
 	    (hdev->dev_type == HCI_BREDR &&
 	     !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
 	     !bacmp(&hdev->static_addr, BDADDR_ANY))) {
@@ -2802,7 +2804,15 @@ static void hci_power_on(struct work_struct *work)
 	}
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags)) {
-		if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+		/* For unconfigured devices, set the HCI_RAW flag
+		 * so that userspace can easily identify them.
+		 *
+		 * If the device is fully configured and ready for
+		 * operation, announce it via management interface.
+		 */
+		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+			set_bit(HCI_RAW, &hdev->flags);
+		else
 			mgmt_index_added(hdev);
 	}
 }
@@ -3974,12 +3984,11 @@ int hci_register_dev(struct hci_dev *hdev)
 	list_add(&hdev->list, &hci_dev_list);
 	write_unlock(&hci_dev_list_lock);
 
-	/* Devices that are marked for raw-only usage need to set
-	 * the HCI_RAW flag to indicate that only user channel is
-	 * supported.
+	/* Devices that are marked for raw-only usage are unconfigured
+	 * and should not be included in normal operation.
 	 */
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
-		set_bit(HCI_RAW, &hdev->flags);
+		set_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
 
 	hci_notify(hdev, HCI_DEV_REG);
 	hci_dev_hold(hdev);
@@ -4024,7 +4033,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
 	    !test_bit(HCI_SETUP, &hdev->dev_flags) &&
-	    !test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+	    !test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
 		hci_dev_unlock(hdev);
@@ -4788,7 +4797,7 @@ static inline int __get_blocks(struct hci_dev *hdev, struct sk_buff *skb)
 
 static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
 {
-	if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+	if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
@@ -4971,7 +4980,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 	if (!hci_conn_num(hdev, LE_LINK))
 		return;
 
-	if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+	if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
 		/* LE tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->le_cnt && hdev->le_pkts &&
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 54e4e8fd5d97..db9610323d4d 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -453,7 +453,7 @@ static int hci_sock_release(struct socket *sock)
 
 	if (hdev) {
 		if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
-			if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+			if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
 				mgmt_index_added(hdev);
 			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
 			hci_dev_close(hdev->id);
@@ -518,7 +518,7 @@ static int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
 	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags))
 		return -EBUSY;
 
-	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
 		return -EOPNOTSUPP;
 
 	if (hdev->dev_type != HCI_BREDR)
@@ -706,13 +706,13 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			goto done;
 		}
 
-		if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+		if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
 			mgmt_index_removed(hdev);
 
 		err = hci_dev_open(hdev->id);
 		if (err) {
 			clear_bit(HCI_USER_CHANNEL, &hdev->dev_flags);
-			if (!test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+			if (!test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
 				mgmt_index_added(hdev);
 			hci_dev_put(hdev);
 			goto done;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 50a0a3ec50b0..1ab98980054c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -353,7 +353,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_USER_CHANNEL, &d->dev_flags))
 			continue;
 
-		if (test_bit(HCI_QUIRK_RAW_DEVICE, &d->quirks))
+		if (test_bit(HCI_UNCONFIGURED, &d->dev_flags))
 			continue;
 
 		if (d->dev_type == HCI_BREDR) {
@@ -5317,8 +5317,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		}
 
 		if (test_bit(HCI_SETUP, &hdev->dev_flags) ||
-		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags) ||
-		    test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks)) {
+		    test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) ||
+		    test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
 			err = cmd_status(sk, index, opcode,
 					 MGMT_STATUS_INVALID_INDEX);
 			goto done;
-- 
1.9.3

