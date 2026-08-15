Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7D1DE8BF
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786787502; cv=none; b=Pe37iDGBQTu6EK5w16IGRViaCJA8ujQU1MLEorPE/q/8Q5se3cpQC61AdXp3gEMhumtRx5GSVMuLWK/ciYrQaZ/Z/iaUgDA8ynneF8L3ZoBaWFcUYrvoSkZpnz5p1i0NqIAKe3DFnJcdFXy84swvBJ2SyFS9ZFj5cDQKJpFSlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786787502; c=relaxed/simple;
	bh=HLueuBtAriStIrexLjFU6S4aa6nY+n84Y2UBYA4Z5ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gugOr0AhPyepSljEqKZp4AfoSDND+NH6btV8hJEqfPm17TSdNlzsiCTAsUvnSBCDbYn9zNBhu+17ylNTeNEvracJhwJfxE4rg3pNdeyItsNCTDdbQ7V1QO5skqO4WTMULTL1SULoxhVjpk6JY6LRVLclTuVi5qNHyuWPQQvlFxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo2lwY0z; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo2lwY0z"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so1998024e87.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786787499; x=1787392299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VS29wHLoMbOJ8QVq/qwtq6OMCDxtBgCbAQfOcU9+Ep8=;
        b=Oo2lwY0zsQWXDppSnMNojVY+uBdNjSWYiIpqUokLBePBj+6nUcHciPOAExhqOyCwrT
         PFTNY0YifQP+U62hP7wwd810MHNBc6I6A4hG2YhrlFWlcZzLalp6FX9q08f+bxeaHsR/
         Z9nWLq4t4BwALEWgS4lz/x1klx+MJh3whJUvYLhSCHJws1ZVEYzIw3F9D3lUukLrzNqm
         gGnOpdwPJ+aGWnx55CXLUJGhTaD058lVKKLGCxn+vJSGywKNHLxVz3q8ZzhkpsGZ8DI/
         HvO0xol+XR4pQeENbIS9HZfXwcVJ5eUZHcZeCX/9IEzEWk+zCek9qJkYjDHP0JeRGo21
         qfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786787499; x=1787392299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VS29wHLoMbOJ8QVq/qwtq6OMCDxtBgCbAQfOcU9+Ep8=;
        b=jOk37Y5HheZUQnG1CFmgEnUc/vNPAXkrq1TFlDavIlOTfvT5Qn+s9jVlvT2sYi4g5q
         UIBS6V5vxlkXa+9f7A7+fzDPSMGkqxSvmvzSHwJqKbs+59wrRiSh+r0DfHLesdpH0px6
         JysDxZvW4FGJn/ebxKOKJTDMOMViUp+wDBuMUN8dI8VFshTJG/4DKIVoczbuX22LC9V6
         NnQicGrJBy/9HABY9HI0ykBpcNR4FwvoSfdyizPPDZt0AArjROSPuyYSiACUiFDKrKyk
         NGOhyWW5Gy5YUAEJTFm6FpiqbuRjpVuF4E3rPYEg9EHelKu/cZSFkzDiUekx7X6Pnw7Z
         Vuiw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4BArFchif0qwXw+/5P60rMEL166gsx7HHaPUMoDrK6EOIhBszoIXjhz8uBo/i7xgrw8Z+LnKMqeSTgLg0Plg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhopbWMyyqxak5tPmAiBJ1L/vy5pRNY/9O/3Ubb2PwcEvu7nMJ
	VM8HYWgyzSIyKj11AM92ofbPTNi82w0aI0LYc1bygXtMNRLFWiIdwjSN
X-Gm-Gg: AR+sD12pRqYSHJKogLHw6aAStZnX/dWyb7x0FtzJZU2PZoOAq4cSjzdYdzJcVIWcfS5
	KivMMjtpDVFzGQS8ofcMu37wsP3SekAIEoCov6tLvIsokJ9WuKGyZafVotEd6KmDon+i1pQSc/E
	eZSCcLMVG0z5VvjKmgS/qDm/BiXDQkNX1dDSoiF8ro2Pbz0PTWBf4bkQuUpADSI2/HxYKJhfJFU
	o46hFCbPQD2i62mvVa7ivnhV3qM5Dq8na3dd/9nrBs5aAUq5lYDrtkbSG/pCfKeGLnLMG4VYoQa
	XdQM8uVpnV3DYS3QT8HQ8yQY7A7ynOAk6bo3HhHQxifFn8Xs8i+lSh+oS0vlsl+DP8RCUoUZtob
	M36Ka98OV0rn2piuHkMGyciJILjfQ+cUFuMjqslVUlXSJD2lQU7fGPGe/3POpx8Bf7KAX8n5RFp
	PGGk2LpVWirOUgHusWizxrwJVzftjJ008ePhCey2AF0v5Wzy/YSmk5u1HVf/54zMwqUKOLC1eo6
	kdatIsVWOi2
X-Received: by 2002:a05:6512:3b2a:b0:5b0:cf2:1bfd with SMTP id 2adb3069b0e04-5b4591942admr1674215e87.52.1786787498884;
        Sat, 15 Aug 2026 02:51:38 -0700 (PDT)
Received: from localhost.localdomain ([188.162.14.60])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458bff3desm1069294e87.62.2026.08.15.02.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 02:51:38 -0700 (PDT)
From: Andrew Bille <andrewbille@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Daniel Drake <drake@endlessm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btusb: treat 0bda:0002 rev 7558 as a generic HCI device
Date: Sat, 15 Aug 2026 16:51:27 +0700
Message-ID: <20260815095127.29624-1-andrewbille@gmail.com>
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
Changes in v3:
- Rebase onto the current bluetooth-next tree.
- Preserve the updated BTUSB_IGNORE bit test from upstream.
- No functional changes.

Changes in v2:
- Restrict the quirk to the observed bcdDevice revision 0x7558.
- Log when generic HCI handling is forced.
- Add the Quanta JW6H platform and USB descriptor information.
- Document that no external firmware is required.
- Document the possible conflict with other 0bda:0002 devices.

 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2bae85b0016c..a95e482a501b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -67,6 +67,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
+#define BTUSB_FORCE_GENERIC		BIT(29)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -619,6 +620,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Device reporting itself as "CSR BS8510" */
+	{ USB_DEVICE_VER(0x0bda, 0x0002, 0x7558, 0x7558),
+	  .driver_info = BTUSB_FORCE_GENERIC },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -4122,6 +4127,9 @@ static int btusb_probe(struct usb_interface *intf,
 			id = match;
 	}
 
+	if (id->driver_info & BTUSB_FORCE_GENERIC)
+		dev_info(&intf->dev, "using generic HCI handling\n");
+
 	if (id->driver_info & BTUSB_IGNORE)
 		return -ENODEV;
 
-- 
2.47.3

