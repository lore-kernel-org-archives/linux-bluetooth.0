Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F62048094D;
	Wed,  1 Jul 2026 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920617; cv=pass; b=VDn/vL32wVP07FlYxkFTF7VDUDxEf1T07OTbFGg9bfOl5q6L1DaYtguJjEGnRQZ5PmXmrC3lX97YWPVMqO0ZGB4SVK7cR8MAOsCFNqMnkR2hLn7WjqpZsCu+vwSjg+iqOmFgUwFS5umq+/rNbnkLg31F0TpxN/Z4GHltI9QlTIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920617; c=relaxed/simple;
	bh=7imuOciDb0dFRHW8TUEDIHVwOsK5Sqh1OZJCZ4elSOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h3cc0LBYdzYlzh1wOgTkyofkfFxVSQVJuoUV79vuCjR8lma+TK3j8xqMwxMs941B6nFSguh9SL5dc9Fdscve2yC/kpvm4t8B7yf1/+TDq7mhEo0kElgDDfvkWH3KqOFfIxA8onm9rUuYG8p+YIxpkEVFZXkT4vNYqY9GRgmnChg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=k672as8Z; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="k672as8Z"
ARC-Seal: i=1; a=rsa-sha256; t=1782920602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PWHGRl0We6CfLfeRgYfzoXt4kT+PDzCl2uJ1tCrDQCAEHShlZHiZfEHVsFYXukScOCdcPruQAZbTgbKoKq0ItC3g4jnc7leuxNZRtvuRX2kcBraNShe1DBK/Kj6nJb6zxGXqCQNKd8ZlmXBFnKx+cXwt2T9lT1tCdnko8mswHEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782920602; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CjtH+gvFipcSElG9iXILesjI+9ZYCWXgy5kfAQ818JA=; 
	b=K1bwu4qBnytfCS09f8RtHGy9ebsDNG9U5Um0dTe1BCk0DyNAP3ZkSXsGVAuOBF549oj+/rgWY8vHju/AQGcmYU92LsbSxYQ+uO7u1a5wx33RmmcvfDGcxZuMRgCkvRbbs/lWfyKtomCaM1EESd+yU2VzXU++BKbs4lgKJiqr0Fg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782920602;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=CjtH+gvFipcSElG9iXILesjI+9ZYCWXgy5kfAQ818JA=;
	b=k672as8ZyK1M1fYHgcUA31/IC7p5GA8bHh7IwThyoOUrz9FPgG1xG0TTts+rPGep
	LUHp+MW2Y9JnzZIFGGDD0MbgaRV+NFnfCwqwOpcudeH6X9nKy/u1I83tOX81iIbTFk1
	rQF68T8CtGKVsbp8mzt3MI+LmubLXNEc+yfLu2bb2dc/G0AArtHBVabQKGUX/NTOUHa
	wgem2L4s36fODQD++LCqGRZZS6dCv7HiW5Xr795n6AaIlVOpjBJQyvTbQtuAJd5EdM2
	38HXUd/FZ1e2jLSJK3pzOp8vvDw9pdi6GQIjjCnfDWQzOZlPo1S0ZAJvyMQ+iMI9Cmc
	UyzTOyWxyA==
Received: by mx.zohomail.com with SMTPS id 1782920599802249.0084802929165;
	Wed, 1 Jul 2026 08:43:19 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Wed, 01 Jul 2026 23:43:01 +0800
Subject: [PATCH v2] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
X-B4-Tracking: v=1; b=H4sIAIQ1RWoC/32NQQ6CMBREr0L+2prylYquvIdhUcoHKqElbUGRc
 HcL7s2sXjIzbwFPTpOHW7KAo0l7bU0EPCSgWmkaYrqKDHjipczVlZWhDx1z84cMc9TbQOwlOxo
 HxrNMnvlF5Eg1xP3gqNbv/ftR/NiP5ZNU2A63Rqt9sG7e5VO69QA5Ci7wn2dKWUyFdaqIRIV4d
 9Y0x94SFOu6fgFHHKxc0wAAAA==
X-Change-ID: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 =?utf-8?q?Chris_Lu_=28=E9=99=B8=E7=A8=9A=E6=B3=93=29?= <Chris.Lu@mediatek.com>, 
 =?utf-8?q?Will-CY_Lee_=28=E6=9D=8E=E6=94=BF=E7=A9=8E=29?= <Will-CY.Lee@mediatek.com>, 
 =?utf-8?q?SS_Wu_=28=E5=B7=AB=E6=86=B2=E6=AC=A3=29?= <ss.wu@mediatek.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-d5d98
X-ZohoMailClient: External

It is reported that a remote wakeup could cause MT7922/MT7925's btusb
interface completely unresponsive. Resetting the xHCI root hub doesn't
help at all, and recovering from such a state needs a power cycle.

All reports seen to be relevant to Ryzen-based laptops. These NICs are
usually used as OEM components thanks to some sort of reference designs.
Their popularity on other platforms is unclear. While there is still a
chance that the quirk may exist on other platforms, be cautious and only
apply the quirk to direct children of Ryzen platforms's root hubs for
the time being. In most cases the root hub is on the SoC or PCH, which
needs the quirk. Unfortunately, this can't distinguish root hubs on PCIe
add-in cards. Such roughness should be acceptable, as PCIe USB
controller add-in cards are less commonly used nowadays. On the other
hand, applying the quirk doesn't hurt any functionalities either, as the
device can still be used as a wakeup source if desired. Theoretically,
we could retrieve the root hub's PCI vendor ID with some hierarchy
magic, but that's too intrusive...

Meanwhile, though device_set_wakeup_capable(false) is the correct fix
for other NICs with fake remote wakeup capabilities, doing so for
MT7922/MT7925 effectively prevents it from being used as wakeup
sources as per userspace requests. Hence, return -EBUSY on runtime
suspend to prevent the interface from being autosuspended while it's
still opened, which has the same effect as
device_set_wakeup_capable(false), since disabling remote wakeup simply
causes the USB core to gate runtime autosuspend as well due to
needs_remote_wakeup == 1. The interface can be safely autosuspended as
long as remote wakeup is disabled, i.e., after closing the HCI device.

Specifically, the interface may still take the advantage of remote
wakeup in order to wake up the system from sleep if userspace has
enabled it as a wakeup source.

Fixes: e31d761628ad ("Bluetooth: btmtk: Disable remote wakeup for MT7922/MT7925")
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Only apply the quirk to to direct children of Ryzen platforms's root
  hubs
  - Theoretically, we could retrieve the root hub's PCI vendor ID with
    some hierarchy magic to further limit the range down to only root
    hubs on the SoC or PCH, but that's too intrusive -- the hierarchy
    magic really made me nervous once I saw what I have wrote, so I gave
    it up
- Link to v1: https://patch.msgid.link/20260629-btmtk-ryzen-remote-wakeup-v1-1-1d2f1cee6d22@rong.moe
---
 drivers/bluetooth/btmtk.c | 10 -------
 drivers/bluetooth/btusb.c | 73 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 02a96342e964..4614434dd57b 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1381,16 +1381,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		break;
 	case 0x7922:
 	case 0x7925:
-		/*
-		 * A remote wakeup could cause the device completely unresponsive, and
-		 * recovering from such a state needs a power cycle.
-		 *
-		 * Since the remote wakeup capability is super broken, just disable it
-		 * to get rid of the troubles. The device can still be autosuspended
-		 * when the bluetooth interface is closed.
-		 */
-		device_set_wakeup_capable(&btmtk_data->udev->dev, false);
-		fallthrough;
 	case 0x7961:
 	case 0x7902:
 	case 0x6639:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 08c0a99a62c5..eef6e3b43bf9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
  */
 
+#include <linux/cpufeature.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/usb.h>
@@ -957,6 +958,7 @@ struct qca_dump_info {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_WAKEUP_BROKEN	18
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -2936,10 +2938,25 @@ static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 }
 
+static inline bool platform_is_ryzen(void)
+{
+#ifdef CONFIG_X86
+	return boot_cpu_has(X86_FEATURE_ZEN);
+#else
+	return false;
+#endif
+}
+
+static inline bool is_direct_child_of_root_hub(struct usb_device *udev)
+{
+	return udev->parent == udev->bus->root_hub;
+}
+
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	int err;
 
 	/* MediaTek WMT vendor cmd requiring below USB resources to
 	 * complete the handshake.
@@ -2956,7 +2973,40 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		btusb_mtk_claim_iso_intf(data);
 	}
 
-	return btmtk_usb_setup(hdev);
+	err = btmtk_usb_setup(hdev);
+	if (err)
+		return err;
+
+	switch (btmtk_data->dev_id) {
+	case 0x7922:
+	case 0x7925:
+		/*
+		 * All reports seen to be relevant to Ryzen-based laptops. These
+		 * NICs are usually used as OEM components thanks to some sort
+		 * of reference designs.
+		 *
+		 * Their popularity on other platforms is unclear. While there
+		 * is still a chance that the quirk may exist on other
+		 * platforms, be cautious and only apply the quirk to direct
+		 * children of Ryzen platforms's root hubs for the time being.
+		 *
+		 * In most cases the root hub is on the SoC or PCH, which needs
+		 * the quirk. Unfortunately, this can't distinguish root hubs on
+		 * PCIe add-in cards. Such roughness should be acceptable, as
+		 * PCIe USB controller add-in cards are less commonly used
+		 * nowadays. On the other hand, applying the quirk doesn't hurt
+		 * any functionalities either, as the device can still be used
+		 * as a wakeup source if desired.
+		 *
+		 * Theoretically, we could retrieve the root hub's PCI vendor ID
+		 * with some hierarchy magic, but that's too intrusive...
+		 */
+		if (platform_is_ryzen() && is_direct_child_of_root_hub(data->udev))
+			set_bit(BTUSB_WAKEUP_BROKEN, &data->flags);
+		break;
+	}
+
+	return 0;
 }
 
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
@@ -4532,11 +4582,26 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 	BT_DBG("intf %p", intf);
 
-	/* Don't auto-suspend if there are connections or discovery in
-	 * progress; external suspend calls shall never fail.
+	/*
+	 * It is reported that remote wakeup events could sometimes cause some
+	 * adapters completely unresponsive. Resetting the xHCI root hub doesn't
+	 * help at all, and recovering from such a state needs a power cycle.
+	 * Since disabling remote wakeup simply causes the USB core to gate
+	 * runtime autosuspend as well due to needs_remote_wakeup == 1, let's do
+	 * this ourselves to make our life easier. The interface can be safely
+	 * autosuspended as long as remote wakeup is disabled, i.e., after
+	 * closing the HCI device.
+	 *
+	 * Don't auto-suspend if there are connections or discovery in progress.
+	 *
+	 * External suspend calls shall never fail. Specifically, a device with
+	 * broken remote wakeup may still take the advantage of remote wakeup in
+	 * order to wake up the system from sleep if userspace has enabled it as
+	 * a wakeup source.
 	 */
 	if (PMSG_IS_AUTO(message) &&
-	    (hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
+	    ((test_bit(BTUSB_WAKEUP_BROKEN, &data->flags) && data->intf->needs_remote_wakeup) ||
+	     hci_conn_count(data->hdev) || hci_discovery_active(data->hdev)))
 		return -EBUSY;
 
 	if (data->suspend_count++)

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef

Thanks,
Rong

