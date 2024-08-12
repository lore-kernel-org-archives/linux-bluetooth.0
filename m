Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C490F4D112
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475076; cv=none; b=NDafOydEllvH91/NEHTK6wqS2VoCL3HIX0o0YHuIlDd1ALXkb6ee5LGAlnDr5u7Q+6W14DD/qKKeY4vp6rDgbU2+nslZPvaV92N8zlpKNG3p5GDEbJEQZ37ti6OG5zgOxd9NhQ/jvi8iHHoFPhNvcOEF8sy32vetU6I4nxsAUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475076; c=relaxed/simple;
	bh=HhwhME3yWKSZ3K1FZ5aIvwXw8AOeSe23qTRpkiag6Fw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pBz8gdnUoe9cgfgU5eNpdyS/Qjk6XKcz4O1IVcAyvX4PUlnArP4SFus6Y/IsDe7rBlWPegxuF6VkA7TpKjGZEqIhpgLkwvEOB71z4d0q4Qj2/IXKHsA6Sw7UaYhpwrmnyfIVYwnB36ZYeXWDHzZryDiyddQonPjdMByR9uWruhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkJfvtZU; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkJfvtZU"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5da6865312eso158809eaf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723475073; x=1724079873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPTHGxzjMyEA6HyUd4RPblLCJnq+LlaQRRcaTlB3AOA=;
        b=FkJfvtZULtLI3egQkuv2tW9C/lgMxW5Nq+qmv6tHDtJRl3vBYqSgiVJc2j4hulG0wG
         0DlrgyfdBEYd1GosOaiLV80aftQ511UmvWHpv5FHN+aHa34Tb7GNkl9GwOuIbZO3f6E9
         8r/9FGf3pxYLKYJBih8ihzfovXNRGmUOYY4HRXRC8HqO2uGUeKfcEKaBjkHim7WCA7p4
         0qZzPIcPnlXGEmO3irT9EJ4fuGCtWtOmPBXtbQmSVn40VNM1FkFa/U7hY8JtdM5PwHS6
         SVEBmwjK6W2t2pyQGiMWD80P0KFCU4QdOYlt4hbp8e3IGiTfjjBPfqG+HEbiBkVKS8xi
         42aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723475073; x=1724079873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPTHGxzjMyEA6HyUd4RPblLCJnq+LlaQRRcaTlB3AOA=;
        b=p+zRnwEmudl7DuA3sCBurru3GEfjMUmHwD1DyAuPc4Wps/WVaxLGZrUQO43QYDICK2
         sjnmnbBWUw31Y3welXyE+qpazIwISF12LZeYilIznAgQRHrIc9hV2E+rS8NoumyS1UJs
         DQzumHPxLkKRPJyjHCYaLxFnkbpgFyKEUq38mWvOug+3Ot9so5rxSfzufvU31s0hlR6q
         1HhJm1f6kJMjSYxD1yOrL1VhVJPywrTmITaQDf0sE0qtZCN92apWy5XN7ZBhtbBs+E0Y
         MZd09+/42I5NwBgchwMlFDYOvZ+3S6/q0jgDR9FOl9SgIn6jer7VKxEJJnJSVrR2tyM6
         koAA==
X-Gm-Message-State: AOJu0YwIIn4mARkmhJs9AEFacO5yGMPMtu3ZHHhJRzFwbLd2+04PRr2a
	ohTBJze6cDmcD9pijfx67SIewM2wmS5/slyTbqby1yFVEVuFg1KEaIENfg==
X-Google-Smtp-Source: AGHT+IFm2FvuYKa56E6L371etjD3q8anZ5fZqGNuN1aP1oRZG231QD6DDpxz/U0ONfIm9O4JTtMuEg==
X-Received: by 2002:a05:6358:339a:b0:1aa:bad6:2ba7 with SMTP id e5c5f4694b2df-1b19d2f4ab2mr82201855d.25.1723475072647;
        Mon, 12 Aug 2024 08:04:32 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-841367a9da9sm731951241.32.2024.08.12.08.04.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:04:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
Date: Mon, 12 Aug 2024 11:04:28 -0400
Message-ID: <20240812150430.283752-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This inverts the LE State quirk so by default we assume the controllers
would report valid states rather than invalid which is how quirks
normally behave, also this would result in HCI command failing it the LE
States are really broken thus exposing the controllers that are really
broken in this respect.

Link: https://github.com/bluez/bluez/issues/584
Fixes: 220915857e29 ("Bluetooth: Adding driver and quirk defs for multi-role LE")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel.c      | 10 ----------
 drivers/bluetooth/btintel_pcie.c |  3 ---
 drivers/bluetooth/btmtksdio.c    |  3 ---
 drivers/bluetooth/btrtl.c        |  1 -
 drivers/bluetooth/btusb.c        |  4 ++--
 drivers/bluetooth/hci_qca.c      |  4 ++--
 drivers/bluetooth/hci_vhci.c     |  2 --
 include/net/bluetooth/hci.h      | 17 ++++++++++-------
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_event.c        |  2 +-
 10 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index cef74fd1271d..1ccbb5157515 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3069,9 +3069,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 					       INTEL_ROM_LEGACY_NO_WBS_SUPPORT))
 				set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 					&hdev->quirks);
-			if (ver.hw_variant == 0x08 && ver.fw_variant == 0x22)
-				set_bit(HCI_QUIRK_VALID_LE_STATES,
-					&hdev->quirks);
 
 			err = btintel_legacy_rom_setup(hdev, &ver);
 			break;
@@ -3080,7 +3077,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		case 0x12:      /* ThP */
 		case 0x13:      /* HrP */
 		case 0x14:      /* CcP */
-			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 			fallthrough;
 		case 0x0c:	/* WsP */
 			/* Apply the device specific HCI quirks
@@ -3172,9 +3168,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		/* These variants don't seem to support LE Coded PHY */
 		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
 
-		/* Set Valid LE States quirk */
-		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
-
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev, ver.hw_variant);
 
@@ -3200,9 +3193,6 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-		/* Apply LE States quirk from solar onwards */
-		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
-
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
 					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 8f855410c2c5..d255bdf777b4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1196,9 +1196,6 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		 */
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-		/* Apply LE States quirk from solar onwards */
-		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
-
 		/* Setup MSFT Extension support */
 		btintel_set_msft_opcode(hdev,
 					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 39d6898497a4..497e4c87f5be 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1148,9 +1148,6 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 			}
 		}
 
-		/* Valid LE States quirk for MediaTek 7921 */
-		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
-
 		break;
 	case 0x7663:
 	case 0x7668:
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index f2f37143c454..fd7991ea7672 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1287,7 +1287,6 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852C:
 	case CHIP_ID_8851B:
 	case CHIP_ID_8852BT:
-		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
 		/* RTL8852C needs to transmit mSBC data continuously without
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 47ae6f4eab0b..d3514def9828 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3959,8 +3959,8 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
-	if (id->driver_info & BTUSB_VALID_LE_STATES)
-		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+	if (!(id->driver_info & BTUSB_VALID_LE_STATES))
+		set_bit(HCI_QUIRK_BROKEN_LE_STATES, &hdev->quirks);
 
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 45adc1560d94..4b1ad7ea5b95 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2474,8 +2474,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 				&hdev->quirks);
 
-		if (data->capabilities & QCA_CAP_VALID_LE_STATES)
-			set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		if (!(data->capabilities & QCA_CAP_VALID_LE_STATES))
+			set_bit(HCI_QUIRK_BROKEN_LE_STATES, &hdev->quirks);
 	}
 
 	return 0;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index c4046f8f1985..43e9ac5a3324 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -425,8 +425,6 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (opcode & 0x80)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
-	set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
-
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ace5d210af38..bab1e3d7452a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -206,14 +206,17 @@ enum {
 	 */
 	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
 
-	/* When this quirk is set, the controller has validated that
-	 * LE states reported through the HCI_LE_READ_SUPPORTED_STATES are
-	 * valid.  This mechanism is necessary as many controllers have
-	 * been seen has having trouble initiating a connectable
-	 * advertisement despite the state combination being reported as
-	 * supported.
+	/* When this quirk is set, the LE states reported through the
+	 * HCI_LE_READ_SUPPORTED_STATES are invalid/broken.
+	 *
+	 * This mechanism is necessary as many controllers have been seen has
+	 * having trouble initiating a connectable advertisement despite the
+	 * state combination being reported as supported.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
 	 */
-	HCI_QUIRK_VALID_LE_STATES,
+	HCI_QUIRK_BROKEN_LE_STATES,
 
 	/* When this quirk is set, then erroneous data reporting
 	 * is ignored. This is mainly due to the fact that the HCI
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 31020891fc68..e449dba698f3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -825,7 +825,7 @@ extern struct mutex hci_cb_list_lock;
 	} while (0)
 
 #define hci_dev_le_state_simultaneous(hdev) \
-	(test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) && \
+	(!test_bit(HCI_QUIRK_BROKEN_LE_STATES, &hdev->quirks) && \
 	 (hdev->le_states[4] & 0x08) &&	/* Central */ \
 	 (hdev->le_states[4] & 0x40) &&	/* Peripheral */ \
 	 (hdev->le_states[3] & 0x10))	/* Simultaneous */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d0c118c47f6c..1c82dcdf6e8f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5920,7 +5920,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	 * while we have an existing one in peripheral role.
 	 */
 	if (hdev->conn_hash.le_num_peripheral > 0 &&
-	    (!test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) ||
+	    (test_bit(HCI_QUIRK_BROKEN_LE_STATES, &hdev->quirks) ||
 	     !(hdev->le_states[3] & 0x10)))
 		return NULL;
 
-- 
2.46.0

