Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4313C5544
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496376; cv=none; b=PNK75d+Uc2XHfdSP903k96j/UvDZZF6Z5+nj3Byos57Oo4Mh7gPh6hfGXcWcyFK0m2gnqfhJ4DMPNKKpjJIAsx1fi0CiMvbzox7jvTkGtqASyY7iF/hhCVNDD7MbLvsi2H/7ZWHcX9ioGVzfboOjqsbk7QSaxEMRzhwrUZdMGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496376; c=relaxed/simple;
	bh=I0cda1uHzh+TihKG3r5oFsdPyz80ZrAsXPTte9S9h50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHZGLOdI0J/VW3HEF0bFC+qLqRrmE/jjbJr776oS8GQ46B72wcX9MUV6Fpd39+NNBh7tk050dew6IUa+x5gRqtxpJ9QYPNRTHg9qz9SRKOdGHK1jnLPQ6GD/DmHD5PazDqbUrHCV/OucLBKuJnVa6aQmdexPeWgNbig9cPZUPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMwv0O+u; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMwv0O+u"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso12017765e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 03:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496374; x=1779101174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/qwpsJlrGzPxaIWkL3whbWWFUARjctPk3DKWRqohVs=;
        b=AMwv0O+u5YtI1xQdgouO1LGnhYkz8QxsUPpzyDPdkOt4l0ac+VzLL2aTP6qxp5sudK
         GOIZcgExFS/TUGjFvBNua88yu+xVcknXsx2FwLzcuKSRCTfrW2Rhqk/KuxmSFHI8yY7U
         PmMPGZDPCj8be6Z3KrLzFevjgoOvfCTBHGnGHBzrsxyQyRjyzsEUaYj3LxOe8V1PA9NN
         oIFHqWjbjvD7grISW7rHh0/erd13oi/FfnBNL1UQkOS0HdH9O+55tVqDUnd/LtYJCnZj
         uyIY3qGS12Z/ygnmzXOCbTYuHAIJIBupD2/dme9h65Rn6/6ZM9cNSRaQuG/FKgTT1kii
         Th2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496374; x=1779101174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/qwpsJlrGzPxaIWkL3whbWWFUARjctPk3DKWRqohVs=;
        b=lIdlzcfpyaOgZ77jTXFumEer/tZz25gB9D0qjGLg6vuL12XtczKew3WBM1aih4bayl
         d13vrOqdZlMU4vYZV9/Ok1SQ2ywNsgylj35j4VvOToVCMtcIQHRd+ChQr5nF++KC1lnX
         3A6lDO7VeNMMdcDRhMxMWUbZgxGtni/68IGwULGS7dY6eicQ1pdSIZ98aJ66x5F7l7/6
         RhBoZCk8kzLUr+gI/g7s1tF3/HxRsv+h9PEKpRjcXhVDFMndXEGdhEq/2F+bdPRXuZCU
         ijKBCv45O0xX9X53kStE6DxVb56QJztdn+1/x4q+aWZ0tOjHw+tRUxK/Kpma4endroF0
         OYdw==
X-Gm-Message-State: AOJu0YyJkHEwrlKKNDh/Oa0DVfOlZS3IQbZTdtBdi76sn3SSgdkZZn/z
	/wlWxXMzHFjOySlSvNhoF+BaV2sxSC4oc25Jvea9AScHm1DCWgx+QhUF
X-Gm-Gg: Acq92OEU5gOsQb34BfD58r9jKW6bxXKx4NsFfKdavq/Dis5nShgcIXglHriFMpAaYED
	O5Aipx7aIItbjOp8nK7Fjb4aO+e2k+3Wzx8cIPwRJJ/f9vZajuvm/EqAa5m6vpK8U13FXHVb+vx
	vnlbjonVji0yfBGRZU18kG09j29FRz7A+m+m7CmBHqIG51vn1wRfEM+qkDp36Isax+4XeKNoyPE
	l2e+3fNov8oGAKh7jaKrz3RlSFeE8dMr/NryU8meKKUfJel4E0RQT+lF2m438XoCVtHaueQM0EH
	FpkpICyQLRdDG/ppQzb7GA3zxYMBt0Ko4HGi4Jrt17Jw3YeGveUDbkt6tvcLbHq/qQqWmmRjyuu
	I6W5BC3i9kP0aWBGsdtmAmQKpoNLYgPEDGFj7klTN2+rFptOYf3KvHoR+ri8ObqwBMoWbQqkof/
	ibB+yP8HRc9/FZsTpo1Ymf0VzHnnbYdBqk
X-Received: by 2002:a05:600d:1:b0:48e:7f1c:8760 with SMTP id 5b1f17b1804b1-48e7f1c87bdmr73341375e9.27.1778496373326;
        Mon, 11 May 2026 03:46:13 -0700 (PDT)
Received: from nob-xt8664 ([109.202.240.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db09ccesm58533435e9.20.2026.05.11.03.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:46:12 -0700 (PDT)
From: Silviu Sandulache <silviu.sandulache@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Javier Tia <floss@jetm.me>
Subject: [PATCH] Bluetooth: btmtk: set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MT6639
Date: Mon, 11 May 2026 11:46:07 +0100
Message-ID: <20260511104607.382060-1-silviu.sandulache@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT6639 Bluetooth controller (the BT half of the MT7925/MT7927
WiFi 7 combo silicon shipped on motherboards such as the ASUS ProArt
X870E-CREATOR WIFI) advertises support for HCI Enhanced Setup Synchronous
Connection (opcode 0x043D) in its supported-commands bitmap, but rejects
the command at runtime.

This breaks HFP wideband-speech (mSBC): when a Bluetooth headset is
connected and the kernel attempts to set up an mSBC eSCO link, the
controller responds with an error and the kernel logs:

  Bluetooth: hciN: HCI Enhanced Setup Synchronous Connection command \
      is advertised, but not supported.

User-visible symptom: the headset microphone captures pure silence in
HFP mode, while A2DP playback works normally. This reproduces on every
MT6639-based machine seen so far.

A Bluetooth HCI trace captured on Windows on the same hardware (ASUS
X870E-CREATOR with the MediaTek WHQL driver, recorded via the ETW
BTHPORT provider during an HFP wideband recording session) shows that
the Windows driver works around the same firmware bug by issuing the
classic Setup Synchronous Connection command (opcode 0x0428) with
Transparent air-mode parameters. The classic command sets up an mSBC
eSCO link successfully, and the headset streams 16 kHz mono wideband
audio over it as expected.

HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN exists in the BR/EDR HCI core
for exactly this case: when set, hci_setup_sync_conn() falls back to
the classic Setup Synchronous Connection command with the same
parameters. Setting the quirk for MT6639 makes Linux do what Windows
does, restoring wideband HFP.

The change is scoped to dev_id == 0x6639 to keep it hardware-confirmed
on the chip where the bug has been reproduced and the Windows fallback
has been observed. Sibling MT79xx variants (MT7921 / MT7922 / MT7925 /
MT7961) exhibit the same dmesg signature in community bug reports; if
the same fallback proves correct for them, extending the quirk to
those chip IDs is straightforward follow-up.

Verification on an ASUS ProArt X870E-CREATOR WIFI:

  - Before patch: profile switch to headset-head-unit (mSBC) is
    accepted by PipeWire, but the kernel issues HCI_OP_ENHANCED_SETUP_
    SYNC_CONN (0x043D), the controller refuses it, no eSCO link is
    established, the mic captures pure silence.
  - After patch: the kernel issues HCI_OP_SETUP_SYNC_CONN (0x0428)
    with Air Coding Format = Transparent. The controller responds
    Synchronous Connect Complete: Status Success, Link type eSCO,
    Air mode Transparent. SCO data flows over the link.

Signed-off-by: Silviu Sandulache <silviu.sandulache@gmail.com>
---
 drivers/bluetooth/btmtk.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ab34f1d..4bd2e6c 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1417,6 +1417,19 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		hci_set_msft_opcode(hdev, 0xFD30);
 		hci_set_aosp_capable(hdev);
 
+		/* MT6639 firmware advertises the HCI Enhanced Setup
+		 * Synchronous Connection command (opcode 0x043D) in its
+		 * supported-commands bitmap, but actually rejects it at
+		 * runtime, breaking mSBC wideband HFP (the headset mic
+		 * captures pure silence). The Windows MediaTek driver
+		 * works around this by falling back to the classic Setup
+		 * Synchronous Connection command (opcode 0x0428); setting
+		 * this quirk makes the BR/EDR core do the same fallback.
+		 */
+		if (dev_id == 0x6639)
+			hci_set_quirk(hdev,
+				      HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN);
+
 		/* Clear BTMTK_FIRMWARE_DL_RETRY if setup successfully */
 		test_and_clear_bit(BTMTK_FIRMWARE_DL_RETRY, &btmtk_data->flags);
 
-- 
2.54.0

