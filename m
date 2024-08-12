Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3364B5AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474445; cv=none; b=DRwWn0Ujq6vOc3gu5NGzoEjwBSZKSjYWyCmGxkc6IMP8t0OHhB4n+XueT6da/SL/0oVfpGSxOsgsXmhEJU1tNgtwWF3sPxlgXgQ57M53H+YKqofkrHAJfPU3dLeB6Uy+HNZsPvvnsH6yudfx4WTGl95j1BGpuCEqQm3g77GyrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474445; c=relaxed/simple;
	bh=HhwhME3yWKSZ3K1FZ5aIvwXw8AOeSe23qTRpkiag6Fw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WQ+SDPiJFHbV/xXKn6qEPcqRSVPb0ODrIR4lVsx8j+PeBeEhF0bWeKjAa/Vetc54C5KblerhEDQc/iFum12xDUYvbWMDKWK5BaYpp516SLeakXb88fGwooX4maqIQjvRV89IsSG2zpQ8Npp0j1yq03nNLtS02A8/sL7gxDT2Ywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkKWjQAl; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkKWjQAl"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4929fa64542so1694125137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723474442; x=1724079242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KPTHGxzjMyEA6HyUd4RPblLCJnq+LlaQRRcaTlB3AOA=;
        b=FkKWjQAljcwyIM92Jsc+LNacgQP+n51rUAdEvYXTVHM7/W7494FUf165EjuijW+nf8
         GI2CYC3heFURIHeShvvWk3jlb47gtopUNCRbTSSOABdtySi9ixnYY2E3K7L7yg2SDWRg
         yhxXvw6trVhLBLqPDX392ESn38TaYcm5IC0Dnp46qfk8wURDfsHreYLDvqplblXurAFH
         Of9yP6IRQ2GRyU+kkY5pHgjTnSPsr+HQLn6Zj1ob5GgIayIQWY6NyOZGROjhTJXCkXL+
         SCXKLt+NUZp2B7YDl50JAhiQUm+8Vsjeeqn3Tj9cUDGfZGvGMW/e+DaCkL9UlC4X0bxn
         T+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474442; x=1724079242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPTHGxzjMyEA6HyUd4RPblLCJnq+LlaQRRcaTlB3AOA=;
        b=OyWZkI3TuGmlajS89Vs6yMgOcODMpLCy8Jh6KZtir6yPhdmIcau+NpnbsU5JBEkpru
         SnPseRcZTUbGiZNAvW+HC6Alx0f0unOFv/5uDX/Ii5syzq+4W3JB6d/Ccm3bEdvyqLbl
         mzhIWtXwVtnPI3KOpOr9T0NUQPpyVQfuI1gxlHMmEiyGAd01LQ6b2CMSa/T/3FE6bDmn
         ozUXVPeumBtg8HDMvV7PsiOu47LLPXsGDEniKBaI0wVXOnSTJ9OB3bweP+oiGeQHnH3e
         XSky9bB2cDE5+pOSrVJapOtGtJq7p6jgEvj/oxUwHU1DtgOdCEg7KU7jrEPrkbubwoEp
         dVNA==
X-Gm-Message-State: AOJu0Yy6Iuo+2iiWWdKyNNw9uJuQR8DVOmVUKydfKd2JHKUa3dZhgnsT
	eMcGkO/y9Huf+oBdyLE9PajIZmF1qqet/BCHRjNAn+kaSlM+fXW6XpGAig==
X-Google-Smtp-Source: AGHT+IHdE+BVUrhLcJfaJRlbXphJLmHuHJmUAihN7LDr4USySFFSyHZ69bn60LI4wtNcqy/yQDV+Ng==
X-Received: by 2002:a05:6102:3ed1:b0:493:c803:815 with SMTP id ada2fe7eead31-4974395b948mr877566137.1.1723474441447;
        Mon, 12 Aug 2024 07:54:01 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-841366c9710sm745259241.16.2024.08.12.07.53.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:54:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
Date: Mon, 12 Aug 2024 10:53:59 -0400
Message-ID: <20240812145359.272554-1-luiz.dentz@gmail.com>
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

