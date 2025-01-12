Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C91B6CFA
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736690675; cv=none; b=EUqCK600vapbXFFUB9l4drqJbZfNdaBuwgDMoy5UZ8SNj1VPLABQXZcc3ndSAHpXmJFHourRvpUvdA5APgX2FLc8uFmknpWvJnljqu4QuG3A2/4c4B56DkyNH+rkMp7mTXVAeOhQ3OSnMhEYt85fcgzG6wXEiOaCcvr+L1NMV4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736690675; c=relaxed/simple;
	bh=0Q5NOpe2+EIK8Q971dnGDVgqH6WmHFEBuKYMJPpPzzs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=vGqqrK7sPhon5ZSDR7gwmZqQodqMqPqx2ITYpRb7hkl4GV+c1NdQfW+L/mC5Benn4NoPUU+lKgydRxFhtDINbWq64KPERPCH7/D9NNTQOQ13306o9+siL+j9LXoA8j6Z8UaU7G9zSEJ6DkyfSQeSE6Jp0Juy3p607TqpTb5KCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hip0CXeB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hip0CXeB"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so32363331fa.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jan 2025 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736690672; x=1737295472; darn=vger.kernel.org;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI5iHQaM0zdpmn0OOy9kpXt/MBewUfSJGyE7tGnfDKs=;
        b=Hip0CXeBadOGl/+qV3q/ejEIEGBTJW5op+J/bdrkckQRTR3GhypuNyUdkLmHmGpstF
         FcHIrA1iPbxJChxHrl6gT8QLSGlw6LRCfGlfN974mLara30bii8WIubAGhlfp7TAK0n2
         J1i0yxBK2XBOhgcD825SwHBaVHmfybrEPEhec5SiCpSOYNGofwG/9bwd9LonHhaiN/AD
         Rad2l3TPD9hzwvmhjCLYOYm9BuUnCJGhRvMdkGgPiDbD1BInIJXOVurOUEq2Gjhi0os6
         VGauoj0HQC/YZlFbtHM55s73jUSorKUvMU3yRO+vhZZ2oceD2AYg6MBv05x68RNpZo6H
         hQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736690672; x=1737295472;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YI5iHQaM0zdpmn0OOy9kpXt/MBewUfSJGyE7tGnfDKs=;
        b=Vc8FFLhetKtHWR1M6kI5kLO1GUbtcdFEthMS3DonMwpa61x8i5Mt68hwOKjG98R7Tu
         5i58c8X9oG70ynDm3ZwaMBxgZi5l+0NqIVdx+wMv/SahRDS82DLG9KvMvV8PwhCenfOa
         TsFBaR4tvCRut+H20NkCl0o2Z53UrKefGDh3h+Bbwb+QNqMUlxfZ+VwBmb1COGuwR/vO
         0GSiD2fGPydX6dAmql2NHfWFjan7tkk9i+9LoHAFsGhsb+01qIMWbSYIZrVDDkiF86K4
         +FzbImkjev3K+YoU9ILHt3fy2F/CdiPVGTzre8xvLn5P21drrexfdgJlJIj/+OL4B988
         cN3g==
X-Gm-Message-State: AOJu0YyD8F+DhZczZBGm2ogajPAjGi6/KFcZXe60rDTJLMbHC9QUwNdT
	PNjXg5cd2x1U+NFcwtlMYE2kmH7sJShJPTCxkqSEzSF6qnkj1JBuU9xkFBry
X-Gm-Gg: ASbGncueNivjNuQcxXz+HMdIqr1yAja0u+lw4vnEXW/iJpTdpjP39hj5TTTBcxMkSdL
	36OPuBG/KinFQnaoOv6wAWCn+qTnC7Q8dfxosWAbbmULXG782z3iDUkhOPa+lmp2aCQ+WKwWVWn
	qW/y9T1RTlpnpHU8/8NNk3BBCUDQ/VUu2Uk1YJJ2qr0tMeaVrNNMXE4OeVr9RHNVFqJU2aNe1Fv
	WKHZ+BuFjfRtqXmK6z1EjcO26a5ax2K++MlGGv3qya8uUkOzYeuwl28v1hG+GjgMXKbSJYnBd62
	g1o=
X-Google-Smtp-Source: AGHT+IEGtr3o649rk0OrkTQa62S/hMjq8SoHrys8K/u9o1DUgJCzBplf7aI9wg46ngHEwhd6B7zH+w==
X-Received: by 2002:a2e:a99f:0:b0:304:68e5:eabf with SMTP id 38308e7fff4ca-305f458651dmr57239601fa.23.1736690671474;
        Sun, 12 Jan 2025 06:04:31 -0800 (PST)
Received: from [192.168.0.107] ([88.135.113.190])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-305ff0cedbasm11438311fa.37.2025.01.12.06.04.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 06:04:27 -0800 (PST)
Message-ID: <19a00133-5613-41ac-b014-1e85ef33a7dc@gmail.com>
Date: Sun, 12 Jan 2025 17:04:25 +0300
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
Content-Type: text/plain; charset=UTF-8; format=flowed
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
+ case 0x7902:
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
+ /* MediaTek MT7902 Bluetooth devices */
+ { USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
+ BTUSB_WIDEBAND_SPEECH },
+
/* MediaTek MT7922 Bluetooth devices */
{ USB_DEVICE(0x13d3, 0x3585), .driver_info = BTUSB_MEDIATEK |
BTUSB_WIDEBAND_SPEECH },

-- 
2.47.1

