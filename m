Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298AA18CBFE
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693045; cv=none; b=pgAhb7ktZqBr9YinAE4wnboKF4P0VB8AZlBRqASoEpKN4B8xM7X+XIwFAu0yWyq/SdXf8RDUnSF2oPZBFFZjNV+GISXMWRp7Qmn9FBoCNId/YA9RDFLZdwKpPkbh4IsuOnoEpkojg4CInZKQoNxcTrK4BlGs4YlYT4l9jReCSuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693045; c=relaxed/simple;
	bh=nQQapfktQYLljHbX61Ql6CQtQqS3paGI1YvCNvBK0hE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=TJJnaidej1hhtY6XcmK+imQpoZH9u5OTZeCljFnejEJhXy5M8tfBP5UcrPBP2iAhaW14IvIn6dIxnEJsXRvEIrosKuAprbZT9n6fyRo/NmNFYPy7Q7FtnylpxH5yLaFhXPrrDLZ16rBlzlQJtG9giCLuNa99t9w2Lv4WuSh4Rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XextEsR6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XextEsR6"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e399e3310so3681664e87.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 06:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736693042; x=1737297842; darn=vger.kernel.org;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNT6fOXn4s0tAcK6URbb9jn2SS6yKt+CB7rFkfFxoEY=;
        b=XextEsR6wApM5r9Cw3BuKmlWLPxwzvvRSgHOfNJmHO0W+y6Gp1mAI5oe2NWTgxFPcE
         ohxHWifYqaG6oFIWIHk3NRIqGh7IPjzmmh5uvXOqXUongU8JD8zQyKD9C5AcTpVEjiyO
         D04kbCTy5IEnk6SWiEqsqf/iRqhBJSzU2nXR39PMnZH586Axv/MyTwyLdJGytCkB+TlN
         GYmh9XxgpWo0B96/jUanqDSk0pAysz9NvoxxF+bNrV0EJxHAvHFCOeESx8jMk2g8m3if
         3TJEMrkvpj4OgkGBPCwn2P6gNvZ9Lu9DJSsi3DMle1uLX4XGml5U5GS85OZ08MSKegGD
         rXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736693042; x=1737297842;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xNT6fOXn4s0tAcK6URbb9jn2SS6yKt+CB7rFkfFxoEY=;
        b=ohqAjRzr04ChxxcktFbITE6AN9NoNk6ZvXHnqe+t6t0+A7qFlDFf9y0ofOeJL9Apei
         Rx8DrX82q8y9LWGDv6UX6PeSmpwkWSw0lgoaa2g+QyI4uoYZPVeXMTfJj6T/lRjF1wtU
         RgTvKNPNm7+jzLLDmIY8tSjpULDcvpuD5zVd7Pw3Iib9Krhl4cJTZ0Z8pSEF79g86Woh
         DP9HXVzDe/XrQ+XBZZSudMs5G9d4Qts22Uw1lVjxig8U5thB1N2Uy609W+clo/ndt1uh
         rhHiRbExwmdj3iOgPr83frbfxoAZzmyGCEOdFz4StIJxhPm4wH7z4FrolBPFRUV6OHc8
         GvJA==
X-Gm-Message-State: AOJu0Ywjq8rapb3I/o3S4bDEqkzPe5b4DMpiedYrCT0xPd9Zr5ku5PkI
	tRrnAs3bTm042hvDsR06j/zuiJjXFLvAV0jggiPenoyrQvEPVTbbG4/eG502
X-Gm-Gg: ASbGncs/pk7gmrThu0fuCj7fIXXsfA/YZTxjbMnss9VJM84p+l2FtaaNvgkGgd/F/Et
	igYeLyHJyRebspAwWZya7m40/S1pN9G7SYgWpI7+uZTqtp8PAaqjKtWvvoeVa1m41LVXU4Y93Vt
	jFLKOmIDaA4fcm2ByEGhHIdZz1zn71NWdBXm5uIY/LV5YIT4KIfecMrbmKm+A4loMwQLFyrv2pr
	3zBuHTrhpxgSlosK79GP3vaDdZT1lh5HMiTlpUUOv0fgGhpsXFVRfaPyl8H2CCe+8g2L3s8kk+P
	pYM=
X-Google-Smtp-Source: AGHT+IGoKCQhx3kjXyOAvxt+eqsrRz6BJ76w+hP/Gy8A2gUUGllC6FX0spC5czgDVVYH/xj2affEdA==
X-Received: by 2002:a05:6512:10c3:b0:540:20bd:739e with SMTP id 2adb3069b0e04-542845b6358mr5469114e87.18.1736693041444;
        Sun, 12 Jan 2025 06:44:01 -0800 (PST)
Received: from [192.168.0.107] ([88.135.113.190])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428be49964sm1090850e87.38.2025.01.12.06.43.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 06:43:59 -0800 (PST)
Message-ID: <8caab2a9-12ef-425b-a26d-d4b3481475ba@gmail.com>
Date: Sun, 12 Jan 2025 17:43:57 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>
Subject: [PATCH] Support of Mediatek 0x7902 Bluetooth on ASUS Vivobook 16
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This commit add support of Mediatek 7902 bluetooth. The firmware file
from original driver BT_RAM_CODE_MT7902_1_1_hdr.bin was required for
runtime.

Tested on ASUS Vivobook 16

Signed-off-by: stanislav.malishevskiy <stanislav.malishevskiy@gmail.com>
---
 drivers/bluetooth/btmtk.c | 1 +
 drivers/bluetooth/btusb.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 85e99641eaae..ad2bdaab5bbb 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1328,6 +1328,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 	case 0x7668:
 		fwname = FIRMWARE_MT7668;
 		break;
+	case 0x7902:
 	case 0x7922:
 	case 0x7961:
 	case 0x7925:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0c85c981a833..c92d2d88f01d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -601,6 +601,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3606), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* MediaTek MT7902 Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* MediaTek MT7922 Bluetooth devices */
 	{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH },
-- 
2.47.1

