Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B0038F230
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783736; cv=none; b=FpqBarNSxBfZl7P4bMJcDMtiJQXZ9FDVp1b7/SPzbFlZzrJArnqp8tY1fgWkiMWhx60kS5vHfwzNF/FHyHSfAVh5rVvlnEq7b0VjZLQ7FFV03HxgxAU2V7M3Cu14XPSSf8aEO/ooyaRG3530iXfDqbbvRP9HFSLL9b9qRocEHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783736; c=relaxed/simple;
	bh=N2WuJXqW6W2AwNf3O0dCKGdwD6LJugwsonsXif9nwPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnttvSPvwH4Yry/PnDDuBY8KPadACTaFsUW9cyM5gGjxvunNku5ZbePXRTy/WLN5JMJknh2Va6dM8x1ch56s2Q0E4dKi9xQzGJKKsGaZwjZvjZrQkwDJrT7dcALN/t311j5sd+FOmgBpQUqJaNjj+0HM9FGbC7my/tEiXlRIJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y22V6AY4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y22V6AY4"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c74722e27so24428471fa.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 01:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786783733; x=1787388533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WHmCee2oMCSUH1ICyIg6euX+e+Fy9mQg4Kq6rXynRE=;
        b=Y22V6AY4UbbUhYNHLlezm2aarmIkGZHGC7GFubm/K5vrWWwBacyMxK5Z5+NFB3m4QB
         Arc/niYqA2XWWqHG/t2/nBNO+UeRdozL6KWlx5Zy907+68ZvwTzGp/VF650qF/XdvF+U
         VRKOUOpjPtr8zgyJ5jOA0ihTaeam40pfEExHse9i71jCbuq6H2C97cP0UJfELg5wjGuR
         8IcmTVlIPToxwBzWYEJgAWmzQMFJcWEH1QzNG4t10a4UW8QEYGEcbMbJecesOi5nJs4G
         NJdM27rW+TmS/dOyIrBeekcMHF45z9DvWmvrjIl9W+bPmfNCNkWlx4OXnKqzVV6a3O1n
         zS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786783733; x=1787388533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WHmCee2oMCSUH1ICyIg6euX+e+Fy9mQg4Kq6rXynRE=;
        b=nC7g4DM8sAA5K77H5plj73uaORdEhFPVs3aC/K7peGC6rwGAWMEiBhkM1RrME9etjj
         40ncMJs1iFnl+0tZCQfbrOCe1Lh+VwyzBaurQu3pa2Ntpo5SR/T7iTUiDsSYuilpLUZL
         23IDHMCZs6oHAsGbk3wsmOQIe8Z5Nno/WLus7a6FoaiFveqF/PY2Dagvag/RiAya6TBN
         k7DEsfu3zuhDhAR+88sflkyYnLSjBL4YXpWASTlgGTP2VmSihoPQx/SjaP3TTTjhLbaT
         SX8pXQFPv8HXJcU/q2Da9C1BysB9XrkrCHWj/fptGOSY0Y92KPATizYwqghII4wJ2nz/
         dA7g==
X-Forwarded-Encrypted: i=1; AHgh+RoNHp09t72PYnbbj62/pzBH+KC9mA8uGHL4Yo2veZQ7WjuCmAvi7xHFvWrXdJmzYr3yNkXrS9pbZAPlUkY2Y2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzxV9bQ0lqmelhLdvUN9hASNf0OXxwKuzyTkGR73woUUYO/fNy
	2Ig/ObafanKLgF6kP7z0dGmyfnFl+oyxzAVmiQ3uR8gCRbwQO9L2fHhb
X-Gm-Gg: AR+sD12ZKp7ZGKRKG7S1/z8xnt2ybv6twAYeOSprGNwdz/TxqRofF7sTPyB9O5j4Qit
	aeLX5BziYKnlFax7d2NodhCs5dgmM9LwZnDFdWvc6ZkHzbnSKtuIPdRvxpps2Nrwr3emMhKy4kJ
	bFumaOTXlaKjunViSFCl3K7RFOBfb5BUyf3T8VEpzm9I67gdjWS2YE1+oHQmIsKBgY88QaaWp+l
	Y21ItXzeoSrKtqkBPWps6q08SJEoatBM+2j9Vbw6aALOQxwySFwuLZ+NHdd7Ddm9r3SQrWiYKuE
	1XoSBHnhdfhHaU2b1aDgb+keEs/u/sAB9dImE0ofrTO8TI1kJdyQLXf4s+tN3/eongjjv4Th3Wv
	x56sdGjmNuT6vmopqhZ9A65Q9TmjgUQ03KrGS4NHgz/FEoTJWmgnR72j7smZpROegC4rfyvQm1+
	H/lf1ZRy5PFrROmxT6SQVzOtDp9mAeZxNQBUmfWpmi6Ai9YFDlSlinULh/sAUjU7YroBmEwx6e7
	g==
X-Received: by 2002:a2e:bc1d:0:b0:3a1:11ff:c30e with SMTP id 38308e7fff4ca-3a11b95fd1bmr26046371fa.4.1786783733013;
        Sat, 15 Aug 2026 01:48:53 -0700 (PDT)
Received: from localhost.localdomain ([188.162.14.60])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a130cd8e3asm10490801fa.25.2026.08.15.01.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 01:48:52 -0700 (PDT)
From: Andrew Bille <andrewbille@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Daniel Drake <drake@endlessm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btusb: treat 0bda:0002 rev 7558 as a generic HCI device
Date: Sat, 15 Aug 2026 15:48:38 +0700
Message-ID: <20260815084838.27092-1-andrewbille@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal Bluetooth controller of a Quanta JW6H laptop reports
itself as "CSR BS8510" and exposes a standard Bluetooth USB interface.

Relevant /sys/kernel/debug/usb/devices output is:

    D:  Ver= 2.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
    P:  Vendor=0bda ProdID=0002 Rev=75.58
    S:  Product=CSR BS8510
    I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

The device currently matches the vendor-wide Realtek quirk and is
therefore initialized through btrtl. It does not respond to the
Realtek-specific register access and initialization fails with:

    Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)

No Bluetooth controller is then available to userspace.

No external firmware is required when the device is handled through
the generic HCI path.

It is not known whether other devices using USB ID 0bda:0002 are
genuine Realtek controllers. Limit the exception to the observed
bcdDevice revision 0x7558 and log when generic HCI handling is forced,
so other revisions continue to use the existing Realtek path.

With this change the controller registers successfully. Scanning,
pairing and A2DP audio have been tested successfully.

Fixes: a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support")
Cc: stable@vger.kernel.org
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Assisted-by: ChatGPT:GPT-5.6-Sol
Signed-off-by: Andrew Bille <andrewbille@gmail.com>
---
Changes in v2:
- Restrict the quirk to the observed bcdDevice revision 0x7558.
- Log when generic HCI handling is forced.
- Add the Quanta JW6H platform and USB descriptor information.
- Document that no external firmware is required.
- Document the possible conflict with other 0bda:0002 devices.

 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 184e95c1625e..bf94722fdedb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -67,6 +67,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
+#define BTUSB_FORCE_GENERIC		BIT(29)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -615,6 +616,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Device reporting itself as "CSR BS8510" */
+	{ USB_DEVICE_VER(0x0bda, 0x0002, 0x7558, 0x7558),
+	  .driver_info = BTUSB_FORCE_GENERIC },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -4089,6 +4094,9 @@ static int btusb_probe(struct usb_interface *intf,
 			id = match;
 	}
 
+	if (id->driver_info & BTUSB_FORCE_GENERIC)
+		dev_info(&intf->dev, "using generic HCI handling\n");
+
 	if (id->driver_info == BTUSB_IGNORE)
 		return -ENODEV;
 
-- 
2.47.3

