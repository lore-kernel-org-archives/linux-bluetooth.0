Received: from m.b4.vu (m.b4.vu [203.16.231.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507114AD3F;
	Thu, 27 Mar 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.16.231.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109237; cv=none; b=UNfo6P6kmRgBehcb0GAxfPiScO0y9RIXmGL4/WYrOgusWCkU6MfxyAzXXkDAvXvupW1dk5G9QaALKvwIUudyY44lpbEf5f8Ce63uoA8vstZSiubatfhK/Ekrsdl/zIOZ9JDCQqn2Pzb9sHP9y7lsxAYJiAdCmds0ym9SgY98vvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109237; c=relaxed/simple;
	bh=KBqRzFxZjlPZ7HMM65WlAH03VtW2sdQPYcQI9WbF0KM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RX4AOYn/19VJfoDF3kirAYZQ2m+SqoeaCPs/c5zdm2uCx1djIWiPiD1xOMtZ/Whxj3OsAsep/bAYZTavBzwOnG1AIXHPOtJ20txcymdLLdlpI5FKKSSN/fNwAn9E1IaHDAHpx/9xnE+KzBze0Obnkwty/6sg0Q6GRMkzWgdU5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu; spf=pass smtp.mailfrom=b4.vu; dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b=CtAB0Mul; arc=none smtp.client-ip=203.16.231.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=b4.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b4.vu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b4.vu header.i=@b4.vu header.b="CtAB0Mul"
Received: by m.b4.vu (Postfix, from userid 1000)
	id 1938F667609C; Fri, 28 Mar 2025 07:22:06 +1030 (ACDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.b4.vu 1938F667609C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b4.vu; s=m1;
	t=1743108726; bh=G1DceDLDtsDr6cUmc77dUlePG6aXGKxgdm7OsGqqrNo=;
	h=Date:From:To:Cc:Subject:From;
	b=CtAB0MulHxcjDFjF0gHMXbQcwPtCDgmQ1WUTWR4Jg8eYtrAvFTAypW3xvOqNVpd+N
	 v5plyA1pD3jmjkrf6cPAO88/9lfAOmzuGeGwXAqWQQH+WQsZY045q/0/QRitOo5UGp
	 MOY6r0GeIrp4VG7X1tJCiU18cWRdfd5nlWMzjZ8m4Lxw5e+JSeKbpSzYMsC9gRg1Gk
	 6sby0lrynsYT93WHSPLeerQuFwLpFj+aBCt5GaMs1IDuCR88nT5pM6deyraDEDEFst
	 9w+4tegUbsBtyuFF5vuMVz16SCQvWhq4EgGUi2S6gxjcFqpBmc+YyaDFZme6l21H/J
	 Cp4CaDh26x5Gg==
Date: Fri, 28 Mar 2025 07:22:06 +1030
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Benedikt Ziemons <ben@rs485.network>, pmenzel@molgen.mpg.de,
	tiwai@suse.de, geraldogabriel@gmail.com,
	regressions@lists.linux.dev, gregkh@linuxfoundation.org
Subject: [PATCH v2] Revert "Bluetooth: btusb: mediatek: reset the controller
 before downloading the fw"
Message-ID: <Z+W6dmZFfC7SBhza@m.b4.vu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit ccfc8948d7e4d93cab341a99774b24586717d89a.

The MediaTek Bluetooth controller reset that was added increases the
Bluetooth device setup time from ~200ms to ~20s and interferes with
other devices on the bus.

Three users (with Focusrite Scarlett 2nd Gen 6i6 and 3rd Gen Solo and
4i4 audio interfaces) reported that since 6.11 (which added this
commit) their audio interface fails to initialise if connected during
boot. Two of the users confirmed they have an MT7922.

Errors like this are observed in dmesg for the audio interface:

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
Changelog:

v1 -> v2:

- Updated commit message with additional information.
- No change to this patch's diff.
- Dropped alternate patch that only reverted for 0x7922.
- Chris, Sean, Hao agreed to reverting the change:
  https://lore.kernel.org/linux-bluetooth/2025031352-octopus-quadrant-f7ca@gregkh/T/#m0b31a9a8e87b9499e1ec3370c08f03e43bfb54bf

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


