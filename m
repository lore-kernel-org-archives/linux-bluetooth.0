Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785923;
	b=AjcLbim3khL0tVftDY1RzPLxpEjFiMs8wnNa4O1ksSonKwbMmgk/YSFG1ybAvsXrWBeg
	 1IGZ0jSeYzSxIprArIR+93zzfAjH+UsePKrWt+TSCwZsM/sqo2uRMFjCfymhDR1Clwg4h
	 9IStazXMC4pDUxDGc/xCS9TuVwOK7W+9M+xMkyIQbzlL6/qVr8/H7ESd/dskmzxZkD6yh
	 KatJq3fDIA45QTnYs8ZlVeEl5zuyYjua4gPiufUErftiIrfb1pTAhCXl5WjMiw97jWOA8
	 wrIYytuEXWwcao+sbyaAlIxtz4z4bQNNAnDgh1FB+jfFRkW0mURvsN21h2dvt0MDlVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785923;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EuIob5V9U10hB6iTNAiC/d0Z5n6c6oBePPnlN7Pncy8=;
	b=OQu4FjnyHlbqxJB5FINrqlNAlsu7lvcn2ACIRmSODMRDBxRTqfe7UHTfXE0cKYwRgqt/
	 mBv690RrM5F2Zuvxi8rAh6Kswie5Jo9rGLfGoTOkpdDkbC0IsLQ3CmHlbatYRD2EyKErI
	 ikY2WtWEdSKPak9dCiJaDkKmjQYlf2+T8kenlEpF3ZibHgfCUmty8DNY8GC+bcZ4BswCZ
	 gdiDsuDrRcf3bPK1mMCtUpnoRspew8HsEsEI6bwaqS5ilP5iSpZ843k+5orG2glNIQZnC
	 EFjmByF14sVeQGsp8tJbKk58OJlyEa2ZIsyxd5hzehDKlkt8BmkuVCgzKkU0ASqEO7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=JDlRC5Om;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7250E606A33B;
	Fri, 27 Nov 2026 13:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7250E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=JDlRC5Om
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1795785920;
	bh=TcBeTqLGTExh6I9MDQ76n82pUzUi9GtHBR4398Cq9mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDlRC5OmA7NjROGZoc80uQ9schmw770AHJ5teHGRBWuDWu4PEO/KD8RUeExlpSRId
	 BNwB9rn2wjQZzyWtfvDnPtY35dMGiPStsvoVWhH99gVA7S/pKQG8R/Cgos9kkdV+h6
	 PZlEP2tNys1XE/YpIMwCQY5Zxw8U5jGtkoJHyGBUVXp86+1KlosHRTti+cvmnKY1Vv
	 uVXOHH/vhmVH+0orJUKpxMLqiR/pvMDa+EdiFaNwZKtlxDXPwzC0e4lf8U1C3DpoAf
	 yg3FSPgeQx/ES9gFOzc2AUX6pxFVm3xq01pylFWLfokDfXJq7RxpLzqmVF+Hre9StO
	 trFs9XVzkcE4A==
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sasha Finkelstein <k@chaosmail.tech>,
	Myria Sarvay <myrialsarvay@gmail.com>,
	Andre Eikmeyer <dev@deq.rocks>,
	Yossef Osman <Yossef.Osman@proton.me>,
	Aditya Garg <aditya.garg@linux.dev>
Subject: [PATCH v3 1/2] Bluetooth: btbcm: raise ACL priority on Apple Broadcom controllers
Date: Fri, 27 Nov 2026 14:25:12 +0100
Message-ID: <20261127132513.262754-2-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127132513.262754-1-dev@deq.rocks>
References: <20261127132513.262754-1-dev@deq.rocks>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the MacBookPro15,1 (BCM4364B0 over UART) A2DP audio drops out as
soon as WLAN runs on 2.4 GHz with traffic. The host keeps the eight ACL
buffers of the controller filled, but the controller holds single ACL
packets for 160-200 ms, so the sink runs dry.

Sending the Broadcom vendor command 0xfc57 (HCI_BRCM_SET_ACL_PRIORITY,
handle and priority, as used by the Android Broadcom vendor library) with
priority high for the audio link stops the dropouts. Setting it back to
normal brings them back right away. The BCM4377 of the MacBookAir9,1
accepts the command as well.

Raise the priority for every BR/EDR ACL link once its Connection Complete
event arrives. This covers audio as well as HID links. hci_bcm does this
on Apple machines only, hci_bcm4377 always, since it only runs on Apple
machines. The PCIe driver receives events in hard interrupt context, so
the command is queued from a work item.

Tested-by: Yossef Osman <Yossef.Osman@proton.me>
Tested-by: Aditya Garg <aditya.garg@linux.dev>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/bluetooth/Kconfig       |  1 +
 drivers/bluetooth/btbcm.c       | 71 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h       |  7 ++++
 drivers/bluetooth/hci_bcm.c     | 18 ++++++++-
 drivers/bluetooth/hci_bcm4377.c |  3 ++
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index b18482b5677..3e2426abdff 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -318,6 +318,7 @@ config BT_HCIBCM4377
 	tristate "HCI BCM4377/4378/4387/4388 PCIe driver"
 	depends on PCI
 	select FW_LOADER
+	select BT_BCM
 	help
 	  Support for Broadcom BCM4377/4378/4387/4388 Bluetooth chipsets
 	  attached via PCIe. These are usually found in Apple machines.
diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 23887f4cde6..88fe93b5d39 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -215,6 +215,77 @@ int btbcm_write_pcm_int_params(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btbcm_write_pcm_int_params);
 
+#define BCM_SET_ACL_PRIORITY	0xfc57
+#define BCM_ACL_PRIORITY_HIGH	0x01
+
+struct bcm_set_acl_priority {
+	__le16	handle;
+	u8	priority;
+} __packed;
+
+struct btbcm_acl_priority_work {
+	struct work_struct	work;
+	struct hci_dev		*hdev;
+	u16			handle;
+};
+
+static int btbcm_set_acl_priority_sync(struct hci_dev *hdev, void *data)
+{
+	struct bcm_set_acl_priority cp;
+	int err;
+
+	cp.handle = cpu_to_le16(PTR_UINT(data));
+	cp.priority = BCM_ACL_PRIORITY_HIGH;
+
+	err = __hci_cmd_sync_status(hdev, BCM_SET_ACL_PRIORITY, sizeof(cp),
+				    &cp, HCI_CMD_TIMEOUT);
+	if (err)
+		bt_dev_warn(hdev, "BCM: setting ACL priority for handle 0x%4.4x failed (%d)",
+			    le16_to_cpu(cp.handle), err);
+	return err;
+}
+
+static void btbcm_acl_priority_work(struct work_struct *work)
+{
+	struct btbcm_acl_priority_work *w =
+		container_of(work, struct btbcm_acl_priority_work, work);
+
+	hci_cmd_sync_queue(w->hdev, btbcm_set_acl_priority_sync,
+			   UINT_PTR(w->handle), NULL);
+	hci_dev_put(w->hdev);
+	kfree(w);
+}
+
+/* Give every BR/EDR ACL link high priority in the controller as soon as it
+ * is connected. Without it the BCM4364 coexistence arbitration lets 2.4 GHz
+ * WLAN traffic delay ACL packets by up to 200 ms, which drops A2DP audio.
+ */
+void btbcm_set_acl_priority_on_connect(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *)skb->data;
+	struct hci_ev_conn_complete *ev;
+	struct btbcm_acl_priority_work *w;
+
+	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT ||
+	    skb->len < sizeof(*hdr) + sizeof(*ev) ||
+	    hdr->evt != HCI_EV_CONN_COMPLETE)
+		return;
+
+	ev = (void *)(skb->data + sizeof(*hdr));
+	if (ev->status || ev->link_type != ACL_LINK)
+		return;
+
+	w = kzalloc_obj(*w, GFP_ATOMIC);
+	if (!w)
+		return;
+
+	INIT_WORK(&w->work, btbcm_acl_priority_work);
+	w->hdev = hci_dev_hold(hdev);
+	w->handle = __le16_to_cpu(ev->handle);
+	queue_work(system_dfl_wq, &w->work);
+}
+EXPORT_SYMBOL_GPL(btbcm_set_acl_priority_on_connect);
+
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	const struct hci_command_hdr *cmd;
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index b4cb24231a2..a4d47b242e9 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -59,6 +59,8 @@ int btbcm_read_pcm_int_params(struct hci_dev *hdev,
 int btbcm_write_pcm_int_params(struct hci_dev *hdev,
 			       const struct bcm_set_pcm_int_params *params);
 
+void btbcm_set_acl_priority_on_connect(struct hci_dev *hdev, struct sk_buff *skb);
+
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
 
@@ -94,6 +96,11 @@ static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw
 	return -EOPNOTSUPP;
 }
 
+static inline void btbcm_set_acl_priority_on_connect(struct hci_dev *hdev,
+						     struct sk_buff *skb)
+{
+}
+
 static inline int btbcm_setup_patchram(struct hci_dev *hdev)
 {
 	return 0;
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1f62a8c2fb3..d2fbaf7cfbc 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -147,6 +147,7 @@ struct bcm_device {
 	bool			drive_rts_on_open;
 	bool			no_uart_clock_set;
 	bool			use_autobaud_mode;
+	bool			acl_priority;
 	u8			pcm_int_params[5];
 	u32			max_autobaud_speed;
 };
@@ -688,10 +689,21 @@ static int bcm_setup(struct hci_uart *hu)
 	.lsize = 0, \
 	.maxlen = BCM_TYPE52_SIZE
 
+static int bcm_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct bcm_data *bcm = hu->priv;
+
+	if (bcm->dev && bcm->dev->acl_priority)
+		btbcm_set_acl_priority_on_connect(hdev, skb);
+
+	return hci_recv_frame(hdev, skb);
+}
+
 static const struct h4_recv_pkt bcm_recv_pkts[] = {
 	{ H4_RECV_ACL,      .recv = hci_recv_frame },
 	{ H4_RECV_SCO,      .recv = hci_recv_frame },
-	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,    .recv = bcm_recv_event },
 	{ H4_RECV_ISO,      .recv = hci_recv_frame },
 	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
 	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
@@ -1094,8 +1106,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 
 	dev->name = dev_name(dev->dev);
 
-	if (x86_apple_machine && !bcm_apple_get_resources(dev))
+	if (x86_apple_machine && !bcm_apple_get_resources(dev)) {
+		dev->acl_priority = true;
 		return 0;
+	}
 
 	dev->txco_clk = bcm_get_txco(dev->dev);
 	if (IS_ERR(dev->txco_clk))
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 72a9f269e8b..7900e8ca2fb 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -22,6 +22,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "btbcm.h"
+
 enum bcm4377_chip {
 	BCM4377 = 0,
 	BCM4378,
@@ -689,6 +691,7 @@ static void bcm4377_handle_event(struct bcm4377_data *bcm4377,
 
 	memcpy(skb_put(skb, len), payload, len);
 	hci_skb_pkt_type(skb) = type;
+	btbcm_set_acl_priority_on_connect(bcm4377->hdev, skb);
 	hci_recv_frame(bcm4377->hdev, skb);
 
 out:
