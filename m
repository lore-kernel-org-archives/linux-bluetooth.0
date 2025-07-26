Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9DC28682;
	Sat, 26 Jul 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753511041; cv=none; b=T33efJo/QZQaq6g6rbIIHrFP/QoaS0ijPRSaION0agkF1YKwmb/kuPmVpGbKy7sR3yLkW5yQTgdZXcQtWy85HvbKjjuLe2pBHjPM/It3eoeDaZ5nB/D8brE4IKwqJ40JWQG5rozXcXpJGlmh111/7W+cDc+vI/yS9UP17x8hb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753511041; c=relaxed/simple;
	bh=8HGBJh2fOy7mUjNT+E3FXAWPDZTyZPZgOpbOFNukRJo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HAM8vZ7apNNBHfvbjyPC3fLuO4qZy4ayebplLnRv1b4IFUfiAliW08Ze4r/4a37bXw6hKQ6/qgRcFbByfvFjwI8DvI8XWOLx0EFH2E+V2uZsVrmwtPRb0+iQ7SYbY+f5i3IoTOBIkEao3Wvm4qnNZXY8yK+HyDe5bu8BulpipJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NICC+kFd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NICC+kFd"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aef575ad59eso458674666b.2;
        Fri, 25 Jul 2025 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753511038; x=1754115838; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPVm5NLm56NonamVjgy6whoRUACE4vVGhgqS5thfviI=;
        b=NICC+kFdAJPz8f5SL5Np5xdmv2bavZZJjtfa3Xt1WxXNlbhYgW9DL9kabXytzJZRkO
         YWL9/QT3g/2pnD903lPu/zWoCOSa1Bjqoug6YxJQW2mKl++s1pcp178GvAwDR6YYrvNR
         gEr/BWKkrBk47xweCkRYv4JZwoLBj+v5x2zG4eGXKVQnWbvBwRRCtkM9c6w/W0Exe1CA
         CI1wx5ELYZzVdinKRItFuiv+gbr23hdufzAMMrXRc5Fm3rA0+Hn+rIEZAI4ImqIpeJ29
         6tbYFdiznwm+1C2cpv6ng4NHv5h5SMdoGOu9ru8zMOm19H2mDWbMhpyavZ1yiIenydoK
         zSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753511038; x=1754115838;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPVm5NLm56NonamVjgy6whoRUACE4vVGhgqS5thfviI=;
        b=a7I17HPw7puZDUg976CEM889uKkkE0dcqLJChST1NxKM1moK1jE81++F7cFV2Voq3q
         TTbEoUGW6+Ogu2kgjrTuTk/B8VmSqUp9VhDP7Tu3V0WzJSwa5EgUTkn9m89JrEqpzXH1
         aSKQnSECybHQ5kn/xJvlV15n1k0De5r0+ZFzYhWXBipYv7CMPR4+iRjalQjEK/n57llx
         Y3bMNI0jU2kYBORTk6lwRPK3AtqsJLtByE/msMg0ThdWJ3xMLZRkyJAnBOpDmcM+f6Oh
         HhagsG/8x4oD0032siTdc8QAkeTAQNttHzFZb4GoTAdFGmxhaEY5ExyUWmHFMPdPNFXX
         Nwyw==
X-Forwarded-Encrypted: i=1; AJvYcCUdD8g0rYL5EvomJsBjtTL6fVQKJP61TcaW+n25grRz+txwMbhU/Je39XvU0tDT3f0t2QAT4907EHkhlAr6@vger.kernel.org, AJvYcCXnSY1+RnaVnHYfSpA4Cqz3/qFtTYXIJGQEiq7OEs84mMrblduD32RDF2dfzCpn73ttuBAvQTq3yihWhNrGZZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3M9sK5xoAIIe/fX5wAyGuClioRan7/RFIvnXScA0zs7IeBj+2
	Eip5uzFF/ICQY+YibQ+EhztZ3dObapMmb9vc4X83kkJ5S4CVBSXSHTpN
X-Gm-Gg: ASbGncsBkv/92/d57LpjXOVac2rZNKkkSpVob0/jRKDJcaQT1j/tpF1Mccf0uNFPHsz
	crF8HzdXYxKFpOCaih6XL8y7GhsCrHoL2qrb0JEELDk78ngR74O/DswU/PPB2vrdZO5uVLs+TYo
	Tq5av11kHMWNJNhIoPDPqZxxV/X+Aa9A4JTqzTNQbcV+pJlldyAJdRQO304m/UftyEYRysGBMEt
	ONOFGGHz3B4AoCKtVCvwaI9flOtxsthh5MizN4SakQOvH4IOXxX1rZKNGXW1a+z/Q6Us9mC9ZM7
	2uQUzPvIO9NNGdWpiMEj1d+FIm8gzWW5PwCKl4n5gCuKlfDvUteuQtXgAmgwRh7Errq/mfemQau
	8QqhfPFDGe1jAOQ==
X-Google-Smtp-Source: AGHT+IEnQ7GX0usG6ax0EaSDJmScjZos41J8+3gStjKKu/ap9bemGhAwlhJ2FWwMcBmzsC4DGqHymw==
X-Received: by 2002:a17:906:f5a3:b0:ae3:74be:4998 with SMTP id a640c23a62f3a-af61b0042b0mr519293966b.11.1753511037768;
        Fri, 25 Jul 2025 23:23:57 -0700 (PDT)
Received: from pc ([196.235.231.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a63121sm98136166b.67.2025.07.25.23.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 23:23:57 -0700 (PDT)
Date: Sat, 26 Jul 2025 07:23:54 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] Bluetooth: bcm203x: Fix use-after-free and memory leak in
 device lifecycle
Message-ID: <aIR0ekNXjuLs6IWa@pc>
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
immediate context of the `bcm203x_probe()` function.

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
with `usb_put_dev(data->udev)` in the `bcm203x_disconnect()` callback.

This ensures `udev` remains valid while referenced by the driver's
private data and is properly released when no longer needed.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/bluetooth/bcm203x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
index c738ad0408cb..c91eaba33905 100644
--- a/drivers/bluetooth/bcm203x.c
+++ b/drivers/bluetooth/bcm203x.c
@@ -165,7 +165,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
 	if (!data)
 		return -ENOMEM;
 
-	data->udev  = udev;
+	data->udev  = usb_get_dev(udev);
 	data->state = BCM203X_LOAD_MINIDRV;
 
 	data->urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -243,6 +243,8 @@ static void bcm203x_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 
+	usb_put_dev(data->udev);
+
 	usb_free_urb(data->urb);
 	kfree(data->fw_data);
 	kfree(data->buffer);
-- 
2.43.0

