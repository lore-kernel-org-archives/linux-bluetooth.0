Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA97482;
	Sat,  8 Mar 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.16.231.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741462378; cv=none; b=UZmFAHIrRFKEY572OP3LzgdaEd7RgqL5jNdyJAwDgaUpAIvnMoYJ6E4xtzIX4Ys1tSiAQKcSJr4P/mzzkQS24PYW/GVt9kk0Z0XfMDFUAim4qD6VM4AYeqD8AEnPJGnH+T3SjrcBmJv+HtdTHvG1YcO4TjQzLmQjUwvi3ZQ+oMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741462378; c=relaxed/simple;
	bh=emC6OB8lTXSoRRoCFOb3yZ+YVJ2JlAc3UP9xBHUtUzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GPCODppvXdWCPA+XcIn19jUlxyvio/fSWT6A0dKPMjX80AeMwEYE8AFu+Mu/YjRvsKq45eu/PywTyNvjOuFEp6z12XC4eXSpzEgWBLOw8w89V05TQvbvXvTiD006W3q0JwEiweAkFiTX3siMXSGkBlAXLY/dVVWH5jKf34vYJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu; spf=pass smtp.mailfrom=b4.vu; dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b=HzJIoshS; arc=none smtp.client-ip=203.16.231.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b4.vu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b="HzJIoshS"
Received: by m.b4.vu (Postfix, from userid 1000)
	id 785706664BC7; Sun,  9 Mar 2025 06:02:53 +1030 (ACDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu 785706664BC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1741462373; bh=H12oj0fN2bK16oG3tQmIiRFnDs/bH/Uh3CCjkbFh5O8=;
	h=Date:From:To:Cc:Subject:From;
	b=HzJIoshSflgRl33D6OLEJtEmTl/wjmp8sYNSr48UnJZP9aiikquxYeE+aHMSRMuNF
	 FkiLWZevMXxg9iQ36FjcxGCRc8AJiRwjFVlUGcFUm8Mg0udxGYT8IIxZ7Jkv80Mr9G
	 MMPe+yCQ+rIdnECQCmDD8HmzOmkKlcLL/eBP2dLHvCnDGdF2UXl7hTeGMwgexMkU3X
	 yJfVkVAni1aAp/ne5j7GPv9YRreGqFQFbuz96hWXx22t5ptwspvSheneROEBqBnYqP
	 PjFbv9njKhUwoZNC/wQ2paBnymD91t3Q2cEwKMrFAvlAkeLFgzzkRwI1f/95oQv4iK
	 k86kaFmIjrdhw==
Date: Sun, 9 Mar 2025 06:02:53 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Benedikt Ziemons <ben@rs485.network>
Subject: [PATCH 2/2] Bluetooth: btmtk: Remove resetting mt7922 before
 downloading the fw
Message-ID: <Z8ybZZ38RvJqYC2+@m.b4.vu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The MediaTek Bluetooth controller reset that was added in commit
ccfc8948d7e4 ("Bluetooth: btusb: mediatek: reset the controller before
downloading the fw") is causing Focusrite USB audio devices to fail to
initialise when connected during boot on kernels 6.11 and newer.

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
 drivers/bluetooth/btmtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 68846c5bd4f7..3b2d50fe3ec6 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1328,7 +1328,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7668:
 		fwname = FIRMWARE_MT7668;
 		break;
-	case 0x7922:
 	case 0x7925:
 		/* Reset the device to ensure it's in the initial state before
 		 * downloading the firmware to ensure.
@@ -1337,6 +1336,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
 			btmtk_usb_subsys_reset(hdev, dev_id);
 		fallthrough;
+	case 0x7922:
 	case 0x7961:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
--
2.45.0

