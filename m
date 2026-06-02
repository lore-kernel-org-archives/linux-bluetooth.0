Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FD3E0C42
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408465; cv=none; b=tiBAP0WEwOGhNpbgu1deqYLJ+wqikevLzmGL99ZKgvbYj+MJCjbDt8smQgVQyBh2YqbQo3GkDiVWYaJ3/lEyQTLA+AQXnrrh9DIC6E8ffQdzT43lWYZSwraRKipKQgVcBJDtebAiAhdSD0iLmmldz5DzAuoHAC+tPNK5Yil8Bh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408465; c=relaxed/simple;
	bh=ixpUHHMtrVre0AzOGkOcFwMc7aZk+bUwemFP4TsHEI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TGcci0C7vv6YGLdkU8jTUMdKCF9md78ReiKJJhpLV+Rn5XNCVu5H4ygFRYLWPoWknJQ8nya3G0FzTKayDKfeN7UujtKkfsWMpP9iEF+divIdX3eJ07mcRmiL5e8fY/X8odNO1TRM1Q7+kHpmYx77Ge3E1Ecp7idqTaQKzB/eW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8w+4ss6; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8w+4ss6"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so929356a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780408464; x=1781013264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaDeqEV2ge4jh8h3+7rCJkTVa06u+A93+CRatPad5DU=;
        b=R8w+4ss63jFpy+lm5lph7rJoUPhSbzZc8YKR7ezkmFqQvgR1BkOo2yPiMa1pu81HY2
         PpzGj0FamggAYDHRIBfNvzjuePN87ANQEPJtX77ij5Fa618YIb2OmI8MSAyie/sIEtwE
         iGruK7oNC1j96e+6LvBnVRyKfPW5zsHZMQpaUmz2+0t/N1uMDjh+C5Qd+9lactNn5jpB
         AWaHWK8XyuDfhRTR+E7mlJT46SpWkVenWPr3D5NQDmu6M3KDs1/boLNgYwM2Y73RN5L1
         me/faaIi62NSZ58/bpDX/lwlQfbp5/ngwbSS83hc/Z4sU4TFr7ke48fE7C+f9I5kiWIB
         UVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780408464; x=1781013264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaDeqEV2ge4jh8h3+7rCJkTVa06u+A93+CRatPad5DU=;
        b=IH0l3QENujgy/IEq0HGeqQJRvSSQBD3x5VRpXsto6B36QhcF40EK3kD+HHiCUECNlb
         PwSvKF0MjUF4xpDfbBwZb9BtOPc+70OwrSzVJ5d01WgMHODcn+NG/N0ipym+qFRqEu4t
         vof1INQ+DzHo/gmuBWLQEUztah44QnsJPili7siQnyVvScA9RZjgVQoaOGes6QbbFtix
         2I9ebrPTB0Dv/3YYB6BbrniQ3esQZi72TfJ+X9RKm46TTwg3U5uaOnnR8QCiFvV4+GFc
         KNDRpvt3E4vvzo1L6xpTBtkBaJGn/YTFkxg0DZy050/QvXmmHS5DleAE/6tf00db6xOw
         1SDQ==
X-Gm-Message-State: AOJu0Yzs3fweBJRRUutwPB3JGVC1YNuaTwMNFZnDf7fvw40VTld9xiAO
	A7tbNYtgaAgemZUQ2Xvlr7cNqKuLKhHGAceL/JFQuIQ55t9PjWllmWMhJ7+4gIizMzJL2g==
X-Gm-Gg: Acq92OHrDBCi+VKY3QvNFSLb0rletlH/eXpMcE+2c+FsM4W6YJ6Bx8Xs2LbYA3r1CGD
	2JkdN+6fL7s7uyCOu3jGsVJmEAVN5Df/YbToOwec29NK/DRurmBVK0IG+xM5L6zv7m1DjJKZ7F0
	LrRzKGq7i5S4uUlO+eCfa6EM0K0KjssczYyVHkNfZQ+H9KDWwDyJt8NjOtDn4m0ZtbC7lw4oAjr
	wzqoul1vNY131PGh2mTJHquWZHxwKqXO1COS+DCop9U9BJcTPOEZCIscM1F4CsgzNDLFP3ejcWr
	uIclzYTGzMRKHgAwi+nHKptRMiQcqWDDN1x2kR1Cjg4eHdfYAbGDEPjEc9bYGSE7PzOybAykh7t
	ci4+3HgRWtq0axQCjNvDbjh0QioH2Qfaq8duMjnBBdiPA9dJbu8QDP0RdKRFqEotwmRoxgk+daV
	1k7wdf+YMZ5nd2RHGWEUNXmJIcSnfq0lLJTZdBImKro+FFsnlYflhnDD6Vlf/gICD+Pa+QdShYj
	ikRGtyt
X-Received: by 2002:a05:6a21:3942:b0:39f:9eb3:1d09 with SMTP id adf61e73a8af0-3b4281db6bbmr19034215637.37.1780408463684;
        Tue, 02 Jun 2026 06:54:23 -0700 (PDT)
Received: from CrisStation.ubt.com ([103.220.9.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214d018fcsm12559138b3a.60.2026.06.02.06.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:54:23 -0700 (PDT)
From: Cris <cxs1494089474@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Cris <cxs1494089474@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add support for TP-Link TL-UB250
Date: Tue,  2 Jun 2026 21:54:19 +0800
Message-Id: <20260602135419.3092500-1-cxs1494089474@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 2357:0607 for TP-Link TL-UB250.

This is a Realtek RTL8761BUV based Bluetooth adapter.

Without this entry the device is picked up by the generic Bluetooth USB
class match and exposes hci0, but the Realtek setup path is not used and
rtl8761bu firmware/config are not loaded.

The controller reports Realtek Semiconductor Corporation as the
manufacturer and LMP subversion 0x8761. With this entry added, btusb
loads rtl_bt/rtl8761bu_fw.bin and rtl_bt/rtl8761bu_config.bin
successfully.

Use the same flags as the existing TP-Link 2357:0604 entry.

Cc: stable@vger.kernel.org
Signed-off-by: Cris <cxs1494089474@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3aef21d4c..3cbb3c22e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -831,6 +831,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2357, 0x0604), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2357, 0x0607), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0b05, 0x190e), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
-- 
2.34.1

