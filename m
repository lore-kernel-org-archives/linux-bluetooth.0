Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB21DC99E;
	Sat,  8 Mar 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.16.231.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741462366; cv=none; b=ioJ8M7v467QktOOdEXUqpA3TdR4c9j2bE0x55myf76uIIzPGsdauWWZSL/F+NJPYkNNdTBCwmEqpLosUYchKHUcEHmx5cczhn7kj+RDdRfbYGBC6KkW0oaNSzITm3JTaCLbZpeEiabkYwqOPvcL8clMF0EoWLq3UxEFl7YvOOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741462366; c=relaxed/simple;
	bh=3n4Gx0k4wvJdU3ldrwBd9uwvsIO6uc7ywXM/gJ1w3vw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GP3DYZ5LHpr5/wXyP1NjRuA0ANBzJq5sM8ZQhpZDeCXb5+V+Cy0jRyoxR8oJrhX4yC+f2lhOaavYNzycTxlba2wjqdcDoV1gjPa9V5Dn4BsLmyiuIEyeykdPPdIJgadWnD8KUoXAsBgj6bbEbYoE8ES1PRMh6+MdYnsKtVWzxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu; spf=pass smtp.mailfrom=b4.vu; dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b=qn82shWK; arc=none smtp.client-ip=203.16.231.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b4.vu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b="qn82shWK"
Received: by m.b4.vu (Postfix, from userid 1000)
	id 6B63F6668A63; Sun,  9 Mar 2025 06:02:39 +1030 (ACDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu 6B63F6668A63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1741462359; bh=UEh1amhXjYUH2yT7shpS4PzlgsIWQ03wZXpMr1EMP5Q=;
	h=Date:From:To:Cc:Subject:From;
	b=qn82shWKQH8gjGklxTLiESWXGfBHKS0Bdt4HxIm7TwQ/UgiARe2a4vR99Eh4C2hIm
	 gvdZEYmXXzkHUzJy/36SSlDgJriq54Sry4ccNzXHVpoowmD98MS8FOen5YZgGHamMI
	 I9vpgVCiWaUuuTcmqtuxNoXtGWqT2gjys3IwqHXgk0foLFiTbokf1b7aAPlcf7Wqfr
	 UhMx03leIez+cz0YY4Rb8MfGcQMY8nFOckFACqgmr1MsRPiNeMgJv67uyV94wtYbO9
	 kVIiD2Cqle7xliqv06ru377H+r+ODLbSUrOtZeG/gByFH5sF0Z1LhpEIQylGQp6Wdz
	 44M+jrxUWCE0A==
Date: Sun, 9 Mar 2025 06:02:39 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Benedikt Ziemons <ben@rs485.network>
Subject: [PATCH 1/2] Revert "Bluetooth: btusb: mediatek: reset the controller
 before downloading the fw"
Message-ID: <Z8ybV04CVUfVAykH@m.b4.vu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit ccfc8948d7e4d93cab341a99774b24586717d89a.

The MediaTek Bluetooth controller reset that was added is causing
Focusrite USB audio devices to fail to initialise when connected
during boot on kernels 6.11 and newer.

The issue was reported by three users, with Scarlett 2nd Gen 6i6 and
3rd Gen Solo and 4i4 audio interfaces. Two of the reporters confirmed
they have an MT7922.

The issue causes the interface to not work when connected at boot
time, with errors like this observed in dmesg:

  usb 3-4: parse_audio_format_rates_v2v3(): unable to find clock source (clock -110)
  usb 3-4: uac_clock_source_is_valid(): cannot get clock validity for id 41
  usb 3-4: clock source 41 is not valid, cannot use

The problem only occurs when both devices and kernel modules are
present and loaded during system boot, so it can be worked around by
connecting the audio interface after booting.

Fixes: ccfc8948d7e4 ("Bluetooth: btusb: mediatek: reset the controller before downloading the fw")
Closes: https://github.com/geoffreybennett/linux-fcp/issues/24
Bisected-by: Benedikt Ziemons <ben@rs485.network>
Tested-by: Benedikt Ziemons <ben@rs485.network>
Cc: stable@vger.kernel.org
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
---
 drivers/bluetooth/btmtk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 68846c5bd4f7..4390fd571dbd 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1330,13 +1330,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		break;
 	case 0x7922:
 	case 0x7925:
-		/* Reset the device to ensure it's in the initial state before
-		 * downloading the firmware to ensure.
-		 */
-
-		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
-			btmtk_usb_subsys_reset(hdev, dev_id);
-		fallthrough;
 	case 0x7961:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
@@ -1345,12 +1338,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 						btmtk_usb_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
-			clear_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
 			return err;
 		}

-		set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
-
 		/* It's Device EndPoint Reset Option Register */
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
 					      MTK_EP_RST_IN_OUT_OPT);
--
2.45.0

