Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372938F938
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131820; cv=none; b=CjCwLt2yNbeWqAxClbldyrbdqiKx0mlk9d6fVOACVKcoqJvHCUCUShMeSyNO9S6mge8Dj1w/4auA7PuQ2xDMjMZm1vBO7A1lVZTOvTn3D1IRWDz/9iSsWqYhq/J1SRc1X9ISUc+52/EHz/heMBa0SFv2nOzt1QVh3OU7o5VgMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131820; c=relaxed/simple;
	bh=fYIOa6Tue2lluTfvHlRgt+jGYttIYquN6+8CWsQy1Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MW+eyYFED/pF/fyMJpEMeZPy718I6kPJlAtIMUR9pg3N5m03cpzWSB+U2TCbEefqFD6TGtsBLaWJjxv+hfSWxCvtdyvNr3F/yXV3cMsaCcGzuofs+mAzhl63Wdd1QZbd9dbO//BU2PRM9K4zVbwf1m2/Hf/wDjKAjkjnfc8a5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eecr62V+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eecr62V+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48909558b3aso28612625e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131818; x=1779736618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc/hts0c28L22tJBwE771eD6DY13i32oinXp0zC7iRw=;
        b=Eecr62V+jwd2vWumCyo8h/BLEzFEA41rCAQ9EG9XO0avQTZg4HutiWzbrqsbyaMOEI
         Y07c64U9K56puhDN0UOq5HWYRaceXtbK0zJp7Q6smGoHetywEMapSNvGgy5kMrfds4xM
         EIGK877S5ZkzKZQBLtSAqOymeFS+tXKECpB98msY6SPx8p6kz/Id2+A/HKNxIY/lOHW4
         5ypWqVvV+a0YROZiuS95bTnlsFl6jiceWqS3QosKFSSfQlsVq4T/VTPtPlcGu+GecMrQ
         YnjMvXOLfQLL5Q2asZkOqTtA5oAvY07drGMcTd4OJP9OGlVy+M08Rv4PYl5CG433YKrE
         0U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131818; x=1779736618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc/hts0c28L22tJBwE771eD6DY13i32oinXp0zC7iRw=;
        b=kJgoNdQZhnO5VIfaHAFCuxKepLW/BcIPdss/FpxYAPD/BPPj2B8lv1w4y4FWrFKApP
         zJkyMWEgITNeVqYQy6VUq0zeEKIZM31MzsojIrANr9mrXEcqRxQ2tP7vFIlxz5gOWwMq
         C0CtpOr8P06DwXodUHPnP+5exx1i8KqnpQgHR4WDS8jFI8n4L9SZnva7/mmecUmsUtZ4
         uEumn6rbOdH3+/xYXJO6XzidzQiYBMC20z+2GXGIrvhlsugqbtPtgr4QorUJ4bmtHqiF
         vDS+lSAL90vxubQAmzRud4vydo446+kVvrxHP+pZPxCKqsrDqPwaMahffIn9AMgr/ZoQ
         tt/Q==
X-Gm-Message-State: AOJu0YzmVmnDy+nmirlOt/pb1WksNKtvHnznkMsk4IwpJMz99TKjf+bF
	5Hs+MiWqQNCsLKO9D3CykidIO3Fvs10kDa2cRh7AbihT1tDQicUuTWo5
X-Gm-Gg: Acq92OFniAnUuGtlUGDlytnHrUrU4F9xjKjmSyngi4s4IzAokUcRIKs7shplr+tWxvH
	h36OTlhClbX4WWq3RTc5sQKsxKIjke5bDJmUGafb70rpJHBnpHX+6m7sxOUkbJypQaSzTZ3Z96R
	/tYkC7crAL4TC+et2l/LbS5JR7//v7cHeydeOpmr0l/GUWc0wntsGwjqzqapwh2Sa2yv24xDcix
	ZuuqHwG/YUG/x2L8HyB+bBItpgbe9asVnvnL7819OXPwno9U/KSuFCXk9YP2eZX3HhdpM1MY42a
	WjvcXAUoruKnCjcHIf6P2qp1n/04b1YC77UlIw05BbLGLdRgy14s6qwhekIOIB1obYuP4SxUVy8
	u+wYCRpZwFLhhVtozrdmSxkDRcLd9rGDoVhG3ooGKhLxGqAV/98dtuU1C/1kp1ADpgfkBYHHa/Y
	zKWnaTwPccw410QyUq0pdyuyxa
X-Received: by 2002:a05:600c:c116:b0:48f:e230:2a22 with SMTP id 5b1f17b1804b1-48fe6632e84mr205014675e9.33.1779131817579;
        Mon, 18 May 2026 12:16:57 -0700 (PDT)
Received: from fujitsu.lan ([2a02:768:672f:8a2e:372d:a4e6:7128:39df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6aff4sm88552745e9.25.2026.05.18.12.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:16:56 -0700 (PDT)
From: Jaroslav Srba <jarys.cz@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jarys.cz@gmail.com
Subject: [PATCH] Bluetooth: btusb: Add Realtek RTL8852BE BT 0x04c5/0x1670 (Fujitsu)
Date: Mon, 18 May 2026 21:16:54 +0200
Message-ID: <20260518191654.615129-1-jarys.cz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Fujitsu LIFEBOOK E5512A ships with a Realtek RTL8852BE combo chip
whose Bluetooth half is exposed as a Fujitsu-rebranded USB device
0x04c5/0x1670. Without this entry in quirks_table, btusb binds via the
generic Bluetooth class match but never sets the BTUSB_REALTEK quirk,
so btrtl_setup_realtek() is never called and the rtl8852bu firmware
patch is never loaded. As a result HCI works (hci0 UP RUNNING), but
RF reception is non-functional: inquiry and LE scan find nothing and
pairing is impossible.

Other Fujitsu OEM rebrands of Realtek chips are already in quirks_table
(0x04c5/0x165c, 0x04c5/0x1675, 0x04c5/0x161f). Add 0x04c5/0x1670 in
the same "Realtek 8852BE Bluetooth devices" block, alongside 0x04c5/0x165c.

USB descriptors of the device:

    Bus 001 Device 004: ID 04c5:1670 Fujitsu, Ltd Bluetooth Radio
      bDeviceClass          224 Wireless
      bDeviceSubClass         1 Radio Frequency
      bDeviceProtocol         1 Bluetooth
      iManufacturer           1 Realtek
      iProduct                2 Bluetooth Radio

Tested on Fujitsu LIFEBOOK E5512A (Ryzen 7 PRO 5875U, Ubuntu 25.10,
kernel 6.17.0-29-generic). After the patch:

  Bluetooth: hci0: RTL: examining hci_ver=0b hci_rev=000b lmp_ver=0b lmp_subver=8852
  Bluetooth: hci0: RTL: rom_version status=0 version=1
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_fw.bin
  Bluetooth: hci0: RTL: loading rtl_bt/rtl8852bu_config.bin
  Bluetooth: hci0: RTL: fw version 0x098b154b
  Bluetooth: hci0: AOSP extensions version v1.00

Scanning, pairing and A2DP audio playback to BT headphones all work
after the firmware patch is loaded.

Signed-off-by: Jaroslav Srba <jarys.cz@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f5fce93d..93fcc02e0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -543,6 +543,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04c5, 0x165c), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04c5, 0x1670), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x04ca, 0x4006), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cb8, 0xc549), .driver_info = BTUSB_REALTEK |
-- 
2.51.0

