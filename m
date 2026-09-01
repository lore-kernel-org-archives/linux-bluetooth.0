Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F4477E20;
	Tue,  1 Sep 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788286783; cv=pass; b=WmMOTaHFvUTGk96PkB315NKOKSSTF5SEaBgZjdhmhHvdVbh/BeLZgQkjlI4dNV38E8ZfOZ/PjB//ymajXxmxqJ01YIUnFn4UgDshyiIBdzQnukWhR9XWleUTzY7RbSfuZTgicM1g0Nu0NQwutykH+EKbmCxau++tfpP/6Ur4skg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788286783; c=relaxed/simple;
	bh=t1Dzz2WhW5oxxyqwH4iMxhXQgtf03s0pp89vbKifBsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HTR2nWOX0TvCOaB2Zeay5t4pjCQJ2ky/lMXqdqkmbfUPEUhq65NsPUw8wprqCrAvqjrSY6dWVH342obh4N30g0xp4gy5gYa7tw4sB5wqTcAS4kGW/VgX6HB+4WEh9zU1JBjfgMgCIFtjyIosqCRRvyB2soKhZXRWqqOmjIaZSQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=e2ZhGK9N; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="e2ZhGK9N"
ARC-Seal: i=1; a=rsa-sha256; t=1788286768; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=USb3jODCBA8EzpNeFDTXt2QMSj2eX0bvUx2KeBJ2JnHPffDC4ZS9v3eRaK4MDJC829XdcWAXib+ciqp0mtLHmEOrZxccPkGDnODnQ6umv6dwe386TsJcZqH1xFeBz/qZm5MJ8r47zs1MgBoGDhcjsNLxIPaj3Nry/Dpbh7SEbfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788286768; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uZ2uRcgPfud4hk5s1LTXcwJq61fP1H5EqgQJ2HryKic=; 
	b=g7YDL2Qd0jBtTnsa/fkQs7p2c+iLm+Bm6Vn1EVwNiwAY5ERgokT7yeX5Xr+4TuSsL/a8gVHGcbjMfzy0YZiSvsawmJhk9Zgbaj30mNuqAMNRVzRg3YHuo9aLj1cp6Vm/pfDyQjcvyC5hHZKRdZOeB1ofVZmwLpThKoTuNHn8M4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788286768;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=uZ2uRcgPfud4hk5s1LTXcwJq61fP1H5EqgQJ2HryKic=;
	b=e2ZhGK9NXPC5tAzpWpEAlWgB0+sZCKSP2leGoN4Qkn4VF2S0Qxxtwzs8JHdSrBx4
	2A0FOggvqErSX95F8NWc1hwo6i+B+1RyHRg1urFTIp1Z13UpbKKVVOh0Y4JjF8jxXm1
	x5ru+E7jJb2RYXcnZNkq+UCgk7dn4eYleY9+JIAiUSrSfWRLHBdKL2n+WCD52b90T4M
	ScdWsA4cLWRlcPZNXcM68ZFAzA1wfmRrW21lbuMQSgGdTjiuc4VCKpgg48Rr2TwejPo
	Zb/+D8Tq3yC0RC0q2Z5LgZl4UIEiK0IyTVLDmMI8hi/8h2chpzPInAK/WTHMoNS61dO
	DmY6FfQQQg==
Received: by mx.zohomail.com with SMTPS id 1788286767462479.40721919787177;
	Tue, 1 Sep 2026 11:19:27 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Wed, 02 Sep 2026 02:19:18 +0800
Subject: [PATCH v3] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-btmtk-ryzen-remote-wakeup-v3-1-8a733d0edd7c@rong.moe>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0K6tqYM0Ior72FclDJoNbSkLSgS7
 m7Bha7IrF7y572JeHQaPTkmE3E4aK+tiZDtEqJu0lyR6joygYxV8qBKWoU2PKgb32iow9YGpE/
 5wL6jrChkzgQ/ADYk/ncOG/1a3efLl31f3VGFRbgsbtoH68Y1PqTLjgADzjhsdYaUxquhSRUir
 wFOzprrvrVIlswAP5Fg6ZYIokhwIZUomcjFv2ie5w9qhQb7HAEAAA==
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
 Rafael Passos <rafael@rcpassos.me>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-1f2f7
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
Tested-by: Rafael Passos <rafael@rcpassos.me>
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v3:
- Resubmit due to v2 being archived
- Update tags
- Link to v2: https://patch.msgid.link/20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe

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
index c0ed51567ed4..9589caff925d 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1374,16 +1374,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
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
index d70a3e7a13f5..95f4640c60e4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
  */
 
+#include <linux/cpufeature.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/usb.h>
@@ -980,6 +981,7 @@ struct btqca_data {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_WAKEUP_BROKEN	18
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -2969,10 +2971,25 @@ static int btusb_send_frame_mtk(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -2989,7 +3006,40 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
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
@@ -4565,11 +4615,26 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
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
base-commit: 786262be6048deab760f68c8acc2c85607165894
change-id: 230ba8c9-btmtk-ryzen-remote-wakeup-055a407682ef

Thanks,
Rong

