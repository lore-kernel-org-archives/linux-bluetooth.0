Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC283FD1;
	Thu, 31 Jul 2025 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753921259; cv=none; b=t984orUVvqjsQIxyl/KZTJ6wSZHxxyfLj19Y+oQHE7jE03ioianI9J2Tnsnl+hVIRoM4tKMSJhh3gdOxqqy3CJiKJNq9V8QaM1yIMB7Tau0EEN9RIbrigTLzd15kIWiC6bAfxg+rhQ5ncKkp0TE1K/Yov0hRvAZiFs2Ml3mxt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753921259; c=relaxed/simple;
	bh=mnJe/ZqMCdBskoh+QfkdLeZztDqAB5F2Izapbnzhgi8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cI9b30LZ8En+S2UwUwC7tmwWhpoufKjskZkxQWiTeFwLY+rlOT+QEM0S/gVCUX2Te8ehf70wHvcNon+kgxGs+SrI6ylWohBH4TrSnhoPS0P1p4wOI/KZoLVGzIqIM7tNqIakIOYL/iSFfmvDitSsMWInX63uYh1dooByJ5/ZEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCI25r4C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCI25r4C"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4563a57f947so6151565e9.1;
        Wed, 30 Jul 2025 17:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753921256; x=1754526056; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f15356qBvyOPIenpU7vIMNiQt+uU3YGMFE0MyhCHEtE=;
        b=GCI25r4CdPgGCZI9a3w/KwwlJOWL5RLxOmJTzkSLk28HcgWZpdqJhLZZWj9aaxgui2
         fjaxXZ82MUXA2jTQp0oFXR4fs9+6h5HTduz4wUktItqyfL9hE/2WzZUVKMo6fajGN18k
         WMDTLgtdW+WpOwbSRKBe4wGdh1oLg/gEezLZj1oQYdTjzHgfP+pDpEKFy+cvdkGCM13v
         taxKRhpUuCecu9hprf7841EBdBGLaxEfsJC3Mp/ZwzbIInOiH5LpJoxgJw6383m5xm3D
         uWwkogrLWGiWQ/VaxqWdKlnEacqU/bp71PuWP9Q3LTUdwa7rVtmFEPJY50wXzm5iHVYk
         Iizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753921256; x=1754526056;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f15356qBvyOPIenpU7vIMNiQt+uU3YGMFE0MyhCHEtE=;
        b=fDTa7E5iQjnBJ9wy9K8MNrgCbITakQGbzgRg7KFDxIwgqs0s80Ij4Q0t1A6UWJADvl
         IZyoPjMsoHpjOie5BdybBzYykW/BNeBbqDYNprFaU5+kglP+kLpehcnuTDEyPmehgvUk
         gQusdO2Kd+zwePvCuVp3MEDd8XCmE0IUjX9tt7dnZMywNpVEH4m+hgbK6sLjpmYBSgSs
         jStr4F5r9n6sEe48LO4l4EaNoV0EZUpl7aNjNaCtEiTDmbRwhq4NpeYtZKqWlP3gMLNO
         sWzcLCHJoLW6xF5BNO3HjtCPf9hbki0H6WgXkC0Jhg4gT6m9xdh7IOkOW7x2zHT0+B2a
         Qt4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFIHP4tJwz4Ps1VH89lLvoScQ3SPnq0Xaz7wC3uoqu4sPkXq0s0NZcTB5WGOmU4dqXS6J8JnFBCyLZ3WdMEFA=@vger.kernel.org, AJvYcCWlnXvrezi/KzdcRy2H9xPc0Q8hf6SEhFci8fPi1N2pk8T1qwVEtK6dlUt/CWrTH/+N+ZVz/WTtUI42gecF@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLct1JjZtqazTPcBawnUsUUaqymeq0RtzhH4r/HxFPKtxJtvO
	lAcQnbm/SHHD4+FT4MYCyVrfXeXqvNQ/uhbO+o5l1hZ2h6e6IKup12G2
X-Gm-Gg: ASbGncuZ52OvJU64/UD6XdwENAO6JfN9s9nCgdoyX/5JxpbKG3izL/hrv/BlOfXpt/m
	A+kd8z+xxzODsaN+qw8PHL3+yHP5PJHKp7CNt05lPLcAkXi3ZwSPIitO9m4Aa1kC3ek+RuPd0XP
	rXmvlzwxWR903RZGeVFDRTCzs8tMLOPO2nctUkMKm6ZYrdS4uQ/UGv9+v8Ogp2+x+p3C38RuydR
	XVeg/V3I+60rCQeOED08w0SwDabzxnHTHxsUKwPnWMcmjEMxSTGzAXYE82e1J2e7tspZHAopadW
	bS7+S+0kht97a+7+xv0lKw+gtCiHO1K97tQN8p9LiZu5lCQ+r0cd4BDI6H5JrVeb014rLW1cn3B
	ADp5val0e4Nc=
X-Google-Smtp-Source: AGHT+IHVoZ53kZhGknzAzxpKnlAaI0g5YTN2UZAHvLhB699x4MYuMrYDa8HuXYzfzxCCKTCwz8YpbA==
X-Received: by 2002:a05:6000:310f:b0:3b7:8646:eeb3 with SMTP id ffacd0b85a97d-3b79d4ae197mr70778f8f.15.1753921255916;
        Wed, 30 Jul 2025 17:20:55 -0700 (PDT)
Received: from pc ([165.51.119.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ca1sm514549f8f.48.2025.07.30.17.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 17:20:54 -0700 (PDT)
Date: Thu, 31 Jul 2025 01:20:44 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH V2] Bluetooth: bfusb: Fix use-after-free and memory leak in
 device lifecycle
Message-ID: <aIq23OWDy87D5qNv@pc>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The driver stores a reference to the `usb_device` structure (`udev`)
in its private data (`data->udev`), which can persist beyond the
immediate context of the `bfusb_probe()` function.

Without proper reference count management, this can lead to two issues:

1. A `use-after-free` scenario if `udev` is accessed after its main
   reference count drops to zero (e.g., if the device is disconnected
   and the `data` structure is still active).
2. A `memory leak` if `udev`'s reference count is not properly
   decremented during driver disconnect, preventing the `usb_device`
   object from being freed.

To correctly manage the `udev` lifetime, explicitly increment its
reference count with `usb_get_dev(udev)` when storing it in the
driver's private data. Correspondingly, decrement the reference count
with `usb_put_dev(data->udev)` in the `bfusb_disconnect()` callback.

This ensures `udev` remains valid while referenced by the driver's
private data and is properly released when no longer needed.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Fixes: 9c724357f432d ("[Bluetooth] Code cleanup of the drivers source code")
Cc: stable@vger.kernel.org
---
Changes in v2:
     -Add tags Fixes and Cc

 drivers/bluetooth/bfusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..f966bd8361b0 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -622,7 +622,7 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (!data)
 		return -ENOMEM;
 
-	data->udev = udev;
+	data->udev = usb_get_dev(udev);
 	data->bulk_in_ep    = bulk_in_ep->desc.bEndpointAddress;
 	data->bulk_out_ep   = bulk_out_ep->desc.bEndpointAddress;
 	data->bulk_pkt_size = le16_to_cpu(bulk_out_ep->desc.wMaxPacketSize);
@@ -701,6 +701,8 @@ static void bfusb_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 
+	usb_put_dev(data->udev);
+
 	bfusb_close(hdev);
 
 	hci_unregister_dev(hdev);
-- 
2.43.0

