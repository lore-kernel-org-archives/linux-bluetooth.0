Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC1946C;
	Sat, 26 Jul 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753512175; cv=none; b=peuLI4wvBqtshZHb0glgSras1DaKJ8LFbSpFL04QV/4AP2XzuNR4joOy0YHKvps93trmWkNW+6V5Bh9pxGmDmM1UT48RZ62znXsH8amler5qwzxU+h8+Q0EQ/3S/DlU+WRjz4ZwT7d9t1XIoEnRvJsEoWriSI5qLNSDRsRjpAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753512175; c=relaxed/simple;
	bh=5FH8xI1GIaz1NOgjVK8PvGN2aIJaB4w7gjVjzKfGS7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cv9R/SJtvQzVR7hGmDjO/+kHTG0GZxbTmnu7IpTNegbhkqqgTNx+Cuy2kCY6E2do6nA7NsyY/aCXvuE86nN1//xo/hhMGtyj7eK7yafMKf+UQdGQ3FF5Ib5WAjXIF++UgtWNR33ZkLE5DMySaB0PsautufH+SNjZawRMprN33LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/GRR5mq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/GRR5mq"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae36e88a5daso541467466b.1;
        Fri, 25 Jul 2025 23:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753512172; x=1754116972; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sf+RFVjVW7g/THlJXQutzuyc8DkWsC+6Pz9QGXxxkew=;
        b=M/GRR5mqTGpxACyhp1tT66kCld3qGi7XaPtzZVYbWOSDd0bFXD0+qqtky+EgMaBOMb
         9j8nY5aHc/LbyY9SWRLpdkZvPZSF2HEddHqlqyGWb+eDOf5ZtoC0JyN0EdhOEECthSlJ
         x80rAvxD7VZBs3+rdHU/WIvtv79fokdkhBT6w5YT+MNCcPp5FLiT2gKIHul50glKDFvt
         rT0D1dQ0Kyw/RP94KHc1uOtnEEqWur/nkW2R37332hwON5vWEuAXNtJC6OTOCROP1Jzt
         39JK8O5YvAKP3Nz7DdsPOn45SnyuINNDbUGlFpjo4z5cWi9bFw/u90Zv7tYxTDozyovi
         kEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753512172; x=1754116972;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf+RFVjVW7g/THlJXQutzuyc8DkWsC+6Pz9QGXxxkew=;
        b=J87IahkH74nM0lTMErD1KTQeeOrYEbkAG6gRik249hqLz3Y4By7d8HrhNoZnnqUhtt
         o/dtVicNeWVkXkpwN3ymMZpOHEepTXTz1/tDZygqWllyS4HCd6GIdfh3wL9ZJC6NTXu+
         ggGMH+0FbV0fJFJGKhF4hhTJrOgzFPDaZj7UMXXVSPbuAwRrnZ1R3pyfPK1TmRPOLoUI
         CXo+m2AyHeyGk1y/jaV4P0bNKRSrAXwr0ZajZ0m2F5hHMN2EQPS3yfz1RwebQ79Ie1no
         wlfJGy2XgsmTL7aVnPDNS23cl55SVBC1rdzF5i2ddrXCduFBegddaGBgx1yj0KT9EBiW
         hkew==
X-Forwarded-Encrypted: i=1; AJvYcCUWvOX2F9/FM48fxXIGBnBKgs5dcXEbCRmgUc/5VcgFNJt3gvZJtI6yXeRmH/nRqeddXKLIAz8q4/oowmpv2UE=@vger.kernel.org, AJvYcCXjieB36iaWxa+tZ0nWxzU208D56Fl3kiRpZ69GjtlcpxhYJ32qEFIfZtmZcc2TQVU6dHGUic5AUo8etDyF@vger.kernel.org
X-Gm-Message-State: AOJu0YwGx+WuD6WAyuKV/KOQaa4rUAclOx+kpt+z2LAEPqBtZnVgnRKW
	VUvTveI/SHkkVeW8d1fSwgDb5QpO1CF7pivVU5uXXag1mqA1KPZXLf3pR3imLw==
X-Gm-Gg: ASbGncvzyl23xxhMejZanN0/W2rRrtsFl3jhYWlD+mXL98kfB+6md0hwnq/2nGUCeB/
	PFsFVCDGGdAHiZKDVcN/4kw5U2ER9GuqmG8bsmYUlJ1367N0kd2VMeh5AtKmO1HBr5YBBpr6+wL
	atAt9SD8pHa/4ZahTPt2/88VnkPsJqQ3abAdUUsxzPksCVX+k23po5n3mzcLV4kH5lXIebPV+XX
	82o4PtVeotB6FYfyAJGoGlqwWz0wFPSWe6UjooGH9ww8WWPA1EI+KXtzlgyiQaHCViZCM3cvnUa
	HaoY2T0zdT8Dx9yCzDB32WkceqiV9U3JJtD8r1BRsKtgZlWfOY9cr13+HT22z+Rtpc63HxxZJ5V
	UsB7npj0/98N070B7TEbsy4qT
X-Google-Smtp-Source: AGHT+IGaIlWHQlUz3LLjKujd3+N/s9ZZt/nFiDoOsjVwrTJiV7DjqmpTjrkps9xI9Yj9najZn3QQog==
X-Received: by 2002:a17:907:2d94:b0:ae3:b85f:6eef with SMTP id a640c23a62f3a-af6191f02b4mr548249366b.42.1753512172226;
        Fri, 25 Jul 2025 23:42:52 -0700 (PDT)
Received: from pc ([196.235.231.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635860122sm101557866b.8.2025.07.25.23.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 23:42:51 -0700 (PDT)
Date: Sat, 26 Jul 2025 07:42:49 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] Bluetooth: bfusb: Fix use-after-free and memory leak in
 device lifecycle
Message-ID: <aIR46cMM38E8iJqC@pc>
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
---
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

