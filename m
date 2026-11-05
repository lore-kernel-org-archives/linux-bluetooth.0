Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869080;
	b=bAKO+yJX6wrajKZ0VXcKTn6l7t77mrt1UBn6Xe6H2Ub5gbBq4JXjb18IxpE57EE1AeII
	 a4Wcade4CAuEFXJOwknNwaIrWWGsN1zfTLcSoqEAkerCIvWIqgK0+z9U8sXebr7BR+kst
	 bqqZZ3Diy/9az5FPuSPPe0ME/X/GUsxICVnAogzcfe1VikBCmHx03mNuAsIx/BDBnpvzU
	 eSm4wNNm/mLJOD7ZqKwEi2ush7/StwxYGNMhLUHbraH2Tdv8QZx4ADHY2sQW1zpz2Y6+V
	 skMnraHnYrE0DdIyWh7d1hty03z/slYhcbKySD0o6189rXt9dTYWiiB+PZ9X3LR+VlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869080;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hMNTWZfz4p5n06+nJ7NdOkZHvaD4/KYBnCjwlGfG3QQ=;
	b=NRKFOytipnN47APSE2I+jyvYH5kJVo5yOqs3McP4pvoxhiPYm1/Vo3pV2SHhtpmSYQT3
	 eOPijiy17xrB/K4TtYV28NI5nkPaiGLRCF16jgXlRW/LNMXD7nSjOjuL52ma/YHoIYwlz
	 zLxKMI79tAU0CtF7FF+sRfCXCX1/5fp+zBZmgNI9GV5A8E2AHziotYDJBLaR5c0TOTTEG
	 SFhJ7i7MaV6u6nob7LR/3av3lZx8whNFLSyCzci64vLSrRLdA6egpJUK7ru9UyWENzIOr
	 Ckx1072soQMdoH9r6mgn0UvmtShWXv4DGDYjt95MrvupVS+BDPkYATDATx/70ey1JLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=fdz0411M;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B569606A332;
	Thu,  5 Nov 2026 08:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B569606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=fdz0411M
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793869077;
	bh=ri1UkNBEvfpZDZBTSRBlThwrjdX6VbYzSJFmd0cJfaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdz0411MLiaweO7lpRu31yhWgUcXXRotr24OU2PlV8YtuBBrrAjRjftB2RiE0ioW6
	 5IhRmV34wn9h9UvXyaTDSAzpKsUZ7/g5iCGUSeBja6aX2baKVJLp5FAv/LdLPZtn6D
	 0hVb/NGSL7DSW4QVsGFHHFy2zDs7rKyQClrkZys/XGHuy9rxabVIDpSLHGLZc45VUM
	 aAmL5KtdrcB3ywCfVCwQkeg4uSX+JusSndEcysJrA8zggPBnO32yLF+rcoavLUn6Is
	 MqyJy+OC+v0lwPqf7ynNBiXI1vJ15g5ueTx9VgNeFsKzESdH1tjwmvg3GUey2Zmxfl
	 CGv0Ea0JSazDg==
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sven@kernel.org,
	j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Andre Eikmeyer <dev@deq.rocks>,
	Yossef Osman <Yossef.Osman@proton.me>,
	Aditya Garg <aditya.garg@linux.dev>
Subject: [PATCH v2 1/2] Bluetooth: btbcm: raise ACL priority on Apple Broadcom controllers
Date: Thu,  5 Nov 2026 09:57:49 +0100
Message-ID: <20261105085750.120392-2-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105085750.120392-1-dev@deq.rocks>
References: <20261105085750.120392-1-dev@deq.rocks>
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
index 065536d4ec7..60114561593 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -210,6 +210,77 @@ int btbcm_write_pcm_int_params(struct hci_dev *hdev,
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
index e70b9f3fd96..cf4f1455cf9 100644
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
@@ -680,10 +681,21 @@ static int bcm_setup(struct hci_uart *hu)
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
@@ -1086,8 +1098,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 
 	dev->name = dev_name(dev->dev);
 
-	if (x86_apple_machine && !bcm_apple_get_resources(dev))
+	if (x86_apple_machine && !bcm_apple_get_resources(dev)) {
+		dev->acl_priority = true;
 		return 0;
+	}
 
 	dev->txco_clk = bcm_get_txco(dev->dev);
 	if (IS_ERR(dev->txco_clk))
diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 66d49b47154..30fcadfae3f 100644
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

base-commit: 3f425f95ba3923d605f6a8b382e8fcdc59d479db
