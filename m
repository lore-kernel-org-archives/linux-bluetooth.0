Received: from mail-10697.protonmail.ch (mail-10697.protonmail.ch [79.135.106.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AB3955CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702512; cv=none; b=pQZVOV5w4VMW5gLR7ptc19ryr5Rmk19ANoCVT8pD9snieC94E4V0fbLXQqgiAQ58W4BwZiIDx9Br9aKqroyX1jWzOe2Y3DtZQhTshe45cgUPKGxuWXGCJSxJo9dWeCXYxRKTrEVX/uh8frmekeG7alGxUTdDMXsCC+X2xf4X/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702512; c=relaxed/simple;
	bh=Pj3AG/9JIvFDNJds717+fDTqq4eqQSLqYechCtxaWnw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fSA3K+35iBk7OkiCBYijbMGNZbCUpug5eFQqinrzmcx5YSozwQ3vyKKE+KVeVWEHCzbTmo6z9Fqz2A67TIv290y+esteGGrvShNNmloFv0oVX+8sGjFlI21i3RTi0y+1JFQjkgWMaE79JQ1apeQSkLimqHBUqhwHxZ5r/8H3Ua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QzLtsHXH; arc=none smtp.client-ip=79.135.106.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QzLtsHXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1778702500; x=1778961700;
	bh=Yw495LepnvOKmMOOGBp/ThEn19AYJPoxoaghP72vtvQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QzLtsHXHoK3dwECH/Gfp9IazJixn0JDJcJE1MGqNsJKytBJDltKIdAXcd4xkjD5wp
	 5N9gVQzxOdVVzejPDLyrRS378a/OPCn3fxFZFsQ8RPdg8oSamxEkGSwvHZ7Oh4B4SA
	 SNMCvGo2qqdS0sTG5A6nAcxI5K5J3vaVqo2hhUPoqgAmmcgVnbAEvEuXpjYmIRmrym
	 vJ0kBIHZvW7QEJgZeG88TpKQHw8lGj3dFTYm5V3GIVuEEt7xhyjsdtJawdKoFfY7e7
	 g/4VqTOhppYzPXR7zoYAtVN+nfwP2f1i2odhgIxfJRSkIQ1LUZIxhyf9xkC7KoLaDn
	 I/i+gtCTon0mA==
Date: Wed, 13 May 2026 20:01:36 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: makro-kernel <makro-kernel@proton.me>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: always reload QCA firmware regardless of chip-reported statu
Message-ID: <aD_Lix2EVXOHmbZ4L1CunlWiLqfiKlU_1_FcVh4CBuIgud4kmE_544xjW2zFKsmh4pNAo9yIQ7q8_GZ4YcmgAXPp8LgW9rfWKqnu06WSjgk=@proton.me>
Feedback-ID: 197359692:user:proton
X-Pm-Message-ID: 03b5eeb040ecf01a49191ab348bfff6c2c3e77f4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

btusb_setup_qca() currently skips rampatch and NVM downloads when the
chip reports QCA_PATCH_UPDATED and QCA_SYSCFG_UPDATED bits set in its
status byte. The intent is to avoid redundant firmware uploads when the
chip is already in the expected state.

However, some QCA chips (notably the WCN785x family, rebadged by Foxconn
as USB 0489:e10a in MSI X870/B850 motherboards) retain firmware state
across reboots in on-die NVM. When a previous OS (e.g. Windows) or an
older driver has loaded a different firmware build, the chip happily
reports PATCH_UPDATED|SYSCFG_UPDATED to QCA_CHECK_STATUS, and btusb
trusts it -- leaving the chip running stale or incompatible firmware.

The user-visible symptom is severe: pairing works, BR/EDR connections
work, AVDTP signaling completes (Discover/GetCaps/SetConfig/Open all
succeed), but the subsequent AVDTP Acquire fails with
org.bluez.Error.Failed and A2DP audio cannot stream. The chip also
emits at startup:

    Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command
                     is advertised, but not supported.

which is a hint that the running firmware is not the rampatch-fixed
version btusb assumes.

Diagnosed on Foxconn 0489:e10a (Qualcomm WCN785x 2.0, ROM 0x00190200)
against a Bose QC Ultra 2 HP headset on an MSI MAG X870E TOMAHAWK WIFI
board: QCA_CHECK_STATUS returned 0xe0 on every probe (after a Windows
install had been wiped), and both firmware loads were skipped, leaving
the chip on Windows-era firmware build 0x8567 instead of Linux's
expected build 0x6254. With the guard removed, btusb downloads the
correct rampatch and NVM, and audio works end-to-end.

The redundant upload on a "truly already-patched" chip costs only a few
hundred milliseconds during enumeration and is the same cost paid by
the equivalent Windows driver path, which is known to always re-flash
firmware on every boot regardless of chip status.

Reported-by: Makro <makro-kernel@proton.me>
Signed-off-by: Makro <makro-kernel@proton.me>
---
 drivers/bluetooth/btusb.c | 45 ++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3afbad667..65c4f0fec 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3646,7 +3646,6 @@ static int btusb_setup_qca(struct hci_dev *hdev)
        const struct qca_device_info *info =3D NULL;
        struct qca_version ver;
        u32 ver_rom;
-       u8 status;
        int i, err;
=20
        err =3D btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION, &ve=
r,
@@ -3672,17 +3671,25 @@ static int btusb_setup_qca(struct hci_dev *hdev)
                return -ENODEV;
        }
=20
-       err =3D btusb_qca_send_vendor_req(udev, QCA_CHECK_STATUS, &status,
-                                       sizeof(status));
+       /*
+        * Some QCA chips (notably WCN785x family rebadged by Foxconn as
+        * USB 0489:e10a in MSI X870/B850 motherboards) retain firmware
+        * state across reboots in on-die NVM. After a previous OS or
+        * driver version has loaded firmware, QCA_CHECK_STATUS reports
+        * PATCH_UPDATED|SYSCFG_UPDATED even though the running firmware
+        * may be incompatible with what bluez/btusb expect. Trusting the
+        * status flags then leaves the chip on stale firmware, breaking
+        * AVDTP transport setup (Acquire returns Failed; A2DP audio
+        * cannot stream).
+        *
+        * Always re-apply the rampatch and NVM to guarantee a known-good
+        * firmware state on every probe. The cost is a few hundred
+        * milliseconds of firmware upload during enumeration.
+        */
+       err =3D btusb_setup_qca_load_rampatch(hdev, &ver, info);
        if (err < 0)
                return err;
=20
-       if (!(status & QCA_PATCH_UPDATED)) {
-               err =3D btusb_setup_qca_load_rampatch(hdev, &ver, info);
-               if (err < 0)
-                       return err;
-       }
-
        err =3D btusb_qca_send_vendor_req(udev, QCA_GET_TARGET_VERSION, &ve=
r,
                                        sizeof(ver));
        if (err < 0)
@@ -3691,18 +3698,16 @@ static int btusb_setup_qca(struct hci_dev *hdev)
        btdata->qca_dump.fw_version =3D le32_to_cpu(ver.patch_version);
        btdata->qca_dump.controller_id =3D le32_to_cpu(ver.rom_version);
=20
-       if (!(status & QCA_SYSCFG_UPDATED)) {
-               err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
-               if (err < 0)
-                       return err;
+       err =3D btusb_setup_qca_load_nvm(hdev, &ver, info);
+       if (err < 0)
+               return err;
=20
-               /* WCN6855 2.1 and later will reset to apply firmware downl=
oaded here, so
-                * wait ~100ms for reset Done then go ahead, otherwise, it =
maybe
-                * cause potential enable failure.
-                */
-               if (info->rom_version >=3D 0x00130201)
-                       msleep(QCA_BT_RESET_WAIT_MS);
-       }
+       /* WCN6855 2.1 and later will reset to apply firmware downloaded he=
re, so
+        * wait ~100ms for reset Done then go ahead, otherwise, it maybe
+        * cause potential enable failure.
+        */
+       if (info->rom_version >=3D 0x00130201)
+               msleep(QCA_BT_RESET_WAIT_MS);
=20
        /* Mark HCI_OP_ENHANCED_SETUP_SYNC_CONN as broken as it doesn't see=
m to
         * work with the likes of HSP/HFP mSBC.
--=20
2.54.0
