Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB28332EDE;
	Sun,  9 Aug 2026 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307455; cv=none; b=Z4SWeuIPerpGaKYRbE8i4uOHZ/2wmKQ1FDGr7/+H25TRQ0obc2Hd0G9bHfR8fPtFu3HYXKxdO9RXdgjTe9bEX1h573mbAghaFXfMaXrwtaCEu/Q6/UnWX79IHPBX9RoNoXsLVxHEfESokCXHIrJA9Q7+lxsGlZD0OItOPEftoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307455; c=relaxed/simple;
	bh=i4nVUF3RXwu3UWbYxvk9uZ23EqHuzy6Obd0zFIVvk5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s9buqathzPJOLgI0qRiOzK8nq+gUMMyObanfc95LDMoLe2b5YEi/ITF1DjuybRK7loRA83vz+jEx0QCXx2NqrAoMXdAz4gxziZJCQlUyyNglPuQUB2AOzflhpVAVOKPmHmvuVWI0ARVmZaIGQqUuLyYEMKc794l7FtxgYci71Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPDd0HLL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPDd0HLL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ACA1C2BCB9;
	Sun,  9 Aug 2026 20:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786307455;
	bh=i4nVUF3RXwu3UWbYxvk9uZ23EqHuzy6Obd0zFIVvk5M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OPDd0HLLaMJxL7OZH2UBmOLYOCsV+UtJMRzKJPt2KQW5kSmweTXGlvoDk0pn5d0Ic
	 EbbF+kYHz3PFF4EiJC1qEH7Dq58P9qd4nK/BxhE9m+3xSMM1XJvWl6zn+Ejj/zzIXl
	 U7rsSxqDG2W7kTEVPz4Xz9bef17+Kc7HNmPeKjHEb2FnlLpmCO+W0N6dpVpkrzA0jg
	 Uwl2bQA9Na+ZjcRs5KCOMC0j/yreOuD3ujMLuCMU5SIC98DtvwohBfeZzsKI1csRr7
	 DcJ7M1kd7mOV7LSvK39cqd/uuA4jBDz/degEX9B8YDnRIy7IbFIS7hCCBxVgtvPtnQ
	 X/v3EbrD2z/ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E69C5AD55;
	Sun,  9 Aug 2026 20:30:55 +0000 (UTC)
From: Richard Nunley via B4 Relay <devnull+richard.w.nunley.gmail.com@kernel.org>
Date: Sun, 09 Aug 2026 15:30:50 -0500
Subject: [PATCH] Bluetooth: btusb: Add Realtek RTL8821CE device 13d3:3558
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-master-v1-1-c62bc61debdd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM2wpAQBSF4VfRvjY1iPAqcjHGwlYOzUZK3t3g8
 qt/rYsEjiFUBhc5HCy8zB5RGJAdzNxDcetNsY4znetCTUY2OGVgm7xIYLskJR+vDh2f31FV/5a
 9GWG3d033/QBDa/m7agAAAA==
X-Change-ID: 20260809-master-aecb893ecf35
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Richard Nunley <richard.w.nunley@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786307454; l=1415;
 i=richard.w.nunley@gmail.com; s=20260809; h=from:subject:message-id;
 bh=wLOaL/YgYl4wu8uYH7L47uT9+N/zEs5F96wJ8v2JHdQ=;
 b=t+NFz1yRiPyBNzMMOkM4oSU1aPF+IkaaUpaC+ZLrI0sI1dIhD97/qyhmj0oDpKbazt9tBk9Li
 tKlTwTRfY0PDaYQUJeMHo43LIE5/vHkljyNnNMG4Aqu1X0CShp2tKEr
X-Developer-Key: i=richard.w.nunley@gmail.com; a=ed25519;
 pk=r+PiBAjnHd6R1vmsv4bP95gslouemyN27nQXIWcK3YQ=
X-Endpoint-Received: by B4 Relay for richard.w.nunley@gmail.com/20260809
 with auth_id=930
X-Original-From: Richard Nunley <richard.w.nunley@gmail.com>
Reply-To: richard.w.nunley@gmail.com

From: Richard Nunley <richard.w.nunley@gmail.com>

The IMC Networks Bluetooth controller with USB ID 13d3:3558 uses an
RTL8821CE. Without BTUSB_REALTEK, btusb uses generic initialization and
does not load the controller firmware. BLE connections then fail before
pairing with HCI error 0x3e.

Add the device ID to the RTL8821CE table. This enables loading
rtl_bt/rtl8821c_fw.bin and rtl_bt/rtl8821c_config.bin, after which a
BLE HID keyboard pairs successfully.

Signed-off-by: Richard Nunley <richard.w.nunley@gmail.com>
---
Tested on a CachyOS 7.1.6 kernel with BlueZ 5.87 and a Corsair K65
Plus BLE keyboard.
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index be82bbbc1..2bae85b00 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -509,6 +509,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3533), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3558), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8822CE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb00c), .driver_info = BTUSB_REALTEK |

---
base-commit: 43a556b2fd43f2df6dded59c2e26560a27874c24
change-id: 20260809-master-aecb893ecf35

Best regards,
--  
Richard Nunley <richard.w.nunley@gmail.com>


