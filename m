Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6017BD9;
	Thu, 31 Jul 2025 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924034; cv=none; b=E8gF5Nw0rswGYCjg9ffoimp4QHHlgfi4+NqwiBylIvF2R0Iu87p6u3UhI5JpoBx0/EqDypizqrB5sFsnbB6g3g32DIIi9wtm3O8CnhFG+qvxfFmvZ3XTuaJgmXhjSEEVOuOPuPqifntOJac4enz3kXvEJAdsdAu7JvdHtIeGQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924034; c=relaxed/simple;
	bh=uQZ2TkinihEE7f4FnyWXjFhyaModpjj42SkfhUQHim4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rKWMP1KG+YAnD9Y/+13ssOH9nVz8WkDS7sl/D1InETBOUX/rA02mksIdKItKTgJxwa8rh7QtCzS6fyzZ6YkVDyFNttQkLiCMUkpc3licuI5qZWHTGYmjcjJTGJ+LRDEJMSJVOzpCqZE0W2Nmw9si8I4MvjsQoLPURnWP/ldfKA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjZnkhNC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjZnkhNC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45622a1829eso1231655e9.1;
        Wed, 30 Jul 2025 18:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753924031; x=1754528831; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuT2LVa9fLR1pGvMOUNWaZ+NGAP76vcbuWZ1eRXnIAY=;
        b=KjZnkhNC3ePa3fgIYaUsVjG39oms3Sk/+BP0UuOqTiQ3zGk23gi+IafqUd8/jQXzUm
         8esVekPT3IZ36kSc1ymfeKRx8CsYbujnLiqPL55w5znd4RJYCl4V6KX2oDq7P+besM35
         dC5QVgTu00F6ujxk365oR7S3GDtGB6M+Mvy0yjPIN9dBqEp8KIjcbB9o4+kWYrx1zEz7
         gSIt9J6IlJE0k24YYbmxguYtOGXeD27A6QO/W8+YH9qqg4WmvF/+mCOmNrMq0q3zNH8a
         bAzdRN6XPPSo6IPx1H6NJFrkYlXmBei7kTg6v9trYuY04UasSWzWnMfbgCQBe+JG2pkQ
         kGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753924031; x=1754528831;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuT2LVa9fLR1pGvMOUNWaZ+NGAP76vcbuWZ1eRXnIAY=;
        b=f0lJOT0OfBm1HZANrOyYjBP6WGaihZT6u1s6f0O5szDVp1SaPw5NwHemR96c/6L3OS
         S5fuIRPb2xGhv8fJfZsM7MBIeU1sfwDi9jOXQExFBZIrln0Ig5aWP7BGKMvlgEEHPopZ
         AEX2tb7KLRPCapuYY6So1XBMiZmSfx5AGnocGAhII81I7j9LYARaYWBn7akNm2JSUNki
         v+9oHDO3l7Z8eY8dGWdKc3qyQbh8T7sVbvnSrYGJ4NTMQTXmGzm5gan0FC18PHxjRHX7
         Rc0pjl/3Fm9/BogUBXERisFKbib8qOqxm+ns9o0jT3EqzMXWZMlOIzp7tOD1a0ZnmD1/
         M7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCU4BD1lmU1oHBf3tEM7wbvGKOYOXJmYotnXCjs3dFyIjxyUJN+vlYFyXVI9tl6ivUYlxU+9PyegCq73oLqAgMI=@vger.kernel.org, AJvYcCVTX/XMm+TkK1dp2SVjh+b5FA+he6hgtVxBNJp9ZIM0yD9sVtIM9B1yLhXb9GgNXvK6sot3O+gpdPeJrptY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7MuV/DeZuqkDc9P/xOSfP9W/pmeg9Z14paD1hEG7dnK2RGmO
	ngSygJARo0q00CaBesuTPAKvPT0bmzGP0z9G7OGHC8Il0jwkGzw/60/i
X-Gm-Gg: ASbGncuyTqOF778CAYKHQoUzaODI5g5VwkLQiDeFDE4S5WUVuERpRHu1Ptyxw+oN+sh
	UR4K65z4lq0PpPg1PIKofYCPhVJQ5bNn90zT7XagURQBrOBeud8Kx28ITEqzFDgOexpdWavssGu
	ezd0YmfjvEebff1ZfuHQ7EPQbe39q9NjfiwNQMuxOdu2nH/fFeNygQjklaeQIlmPJU+hh9mkifc
	HVU8q9BxO1Im0jeSfxmfnRzWsEdIeI567HC1IgIkH2fcu/BWzVkmm/cx75zakZzPA297Nj5Dl0K
	Jd1b5ZKj/awupPhE3XssD394GFL6TXxXhR1NuukmRZYa0ii/MURO7Q8zbNEevT0f8SMn2rtdpRi
	f2+UGji4M1VA=
X-Google-Smtp-Source: AGHT+IG4IbJCF0W3UCi9QUXOrv6co+/9dRLrwLc8oQdmCNaZ9Y4QLoTnUEN1lyBZ8KzQEfJxbWYh2A==
X-Received: by 2002:a05:600c:4f0d:b0:455:ed0f:e8ec with SMTP id 5b1f17b1804b1-45892b9ce3emr59639325e9.9.1753924030930;
        Wed, 30 Jul 2025 18:07:10 -0700 (PDT)
Received: from pc ([165.51.119.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eba17sm43868745e9.24.2025.07.30.18.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 18:07:09 -0700 (PDT)
Date: Thu, 31 Jul 2025 02:07:07 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH V2] Bluetooth: bcm203x: Fix use-after-free and memory leak in
 device lifecycle
Message-ID: <aIrBu8VK8FgYm7bV@pc>
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
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
Changes in V2:
    - Add tag Fixes

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

