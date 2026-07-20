Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179E2D6E6C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784588361; cv=pass; b=UqZeGehOroBNsbcQfltQsGTiG5A45nA9c7yl6ikf697yiIxKc4BajRWTX0X0Jbpe2e9jO2s3fIJ5MVqAXnmV13JadtSM2W+J717WZpaNq9+9968tBjLcY3B83MECSQ+GV1dK26iXZivyhacXKL0ehI4bu2cN8WQQKkylQAozR/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784588361; c=relaxed/simple;
	bh=s99d4duwD7qIniQhTiTSvYs3skPiRFbVAFIOVhfQwJ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GfYMI79zujM8p7CzHBY/P71y9hJBrqJVKdVDhjDuRM35tS8sJUnlHfiylk+zCqYaEZjXhEr+8oMAQwPizNzPNF1eczmT1EwQf0Iny3h9KJPhqVDBmFlRas3hTYxx1Axl9Eb1/04TehFMekh0g/4ZKuaFFDEQumx3s1el6o77VXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTrhrrey; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTrhrrey"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-668432d50b0so2729922d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 15:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784588359; cv=none;
        d=google.com; s=arc-20260327;
        b=BbxERnEtzMZrJefhVSN3+O9NVryBaf2XuwTR5gpB1eTiB1p5tpIE0EwSGlu8zklHHv
         sNxj3oYwJ1ec2ez1rUKtJgLeA/kutiGxGCK67nmKMf/tVd/a+T+BPhog2DZXDxYN3kjw
         73I21H1TApZ2rP+3OBS5iDigWgkU+FXP10NfeP71pIOWJoSUrYLdZ3Xowtvd5620Elw1
         hjrq5lnnSJcga6c/Ykw+yBRW+q0RYo1cYql7QZ9YYvMqIpRVlF6/RoCSgh1MLSoMC9ci
         Tm9clNfoGRfYlReYRntKNST3dbBGFEXWpJdhTTsAFeV6IejxBWBVBLNvM6WdCVUHjW6M
         B+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iU27rY3xHYpKpmvJO6a2MUiFlMK5FNvMsAVYlYg9VGU=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=kgBOhgNIJ8rxHHZ3f4PHCeHEBlP/10xinzMZZstVvhwBwcug+0S00MDh6YXj1KeLC7
         gaE9EjsaGHCiEol//b9Nu2eCQ3Owfozss4Rhla5YbWTWn1sV1L8mKHPkifoxCmt9NU/s
         Tv43eoouTNEvtEZzrmDDavBV0/bQ2k0hHDiMlIxB71hx26tUy2J4DAmyL7BnUBVDGlh7
         52EyFy8fVqwW8AgnItjiqVVFY9UdTCFyxlQSvuuRqreq0S3Tckl4LoKWKzdNww/h1+Mh
         bw/8QGWorOzrLKlpLFy3NMb17D5uQwl5yMIye04jwdJU5AlMos0XvhyE+KxTmW0i4VIK
         Ay2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784588359; x=1785193159; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iU27rY3xHYpKpmvJO6a2MUiFlMK5FNvMsAVYlYg9VGU=;
        b=eTrhrreyENejKtwlUhSlqA5j2dih8YZw5XSQ+tApd258K7nRZZ0OrtFq/7ojOFL9C6
         o1MPL1yAB4SZNfrm1EgjIi0BxJln2Gt4a/hJfKGq3KsPfykEpXJhuZXnuRmkcneR8KKh
         vGmR+/Ehbl8+a4jEO9MMugujFHx+Sop9J84gdJxM2pHg31fXSlHCqTdlsR4GL091PPjS
         oEpYNYDMxUIC6ydcSW3tlirf4gertAtFHi+0x395gySNR7V0PK3OulCIDuPDeoONLXxm
         ZNMSArDAKvxZu6ie9xGkld//WQ3cJHL65A2TYsur3Ew4gUkCq9xbi3uKWH0VmUG9YpKy
         5tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784588359; x=1785193159;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iU27rY3xHYpKpmvJO6a2MUiFlMK5FNvMsAVYlYg9VGU=;
        b=Ua7tD6C/pLmEAxyNM6QKHJ10PP9//r7+kGywLDF0yMhF5eq+lsI0mxdxVuHGJYisSs
         67f6D6sowsM2wkbQgamBohlf1MshMBhcSQISOdYGsYxC69jG8aANwudtP2DDfzT1xSUy
         tXdvHuKjbcn+yK3BfS6AXnfBvJ/nE5E5Ldra0Kz5od/N1xaMVTVYvIAJIAzQGJu+SJeh
         thYbXPgy4s7hScJYN5DHhnD4tbPj/1+8A19bqAV82xgARwXuAmMG9NrDT4DORgmsc7/j
         /JpqrzUC6/9ddjCIRJV04FMhbflc5/4kCBuRhlzEKQ8a7n3Tcw1aLOPa0rikeWr0YLIq
         xkkQ==
X-Gm-Message-State: AOJu0Yzsp2I+PRrxm15qORllDdmGPgyigsBupX2993+mxhPWsp7JqU84
	Py+vaZsCl+Yrk6iYYHpkl0sHBH4u8tKgckgTvlohk6UjCdbpEeNK4KHteLByIWyd/AorBjtg3te
	vvtDX9SRAWpNPaHXpkdfmXhuUaGy7rW8qDaXnqdAuPw==
X-Gm-Gg: AR+sD12vQatb5mJEgOayX2Sbzss4q8hT3MnCNJnkmkr0+IT3ojRDb8JmRZn8xgHozLm
	gbGFeUvvzPlQ7IZTuuRWvRQRFde2LPA4PApHc+T5CDqdnc9uAgzf3ux7LLxbz3qOS6ufA496BdR
	8pIvtGER/3mCMBQZNX1whAwgi/ema516rl2pGrT6RYEn/tVJXyemU/syv4nhd7uolbF+4D2oVUo
	naSjoR/0CIbGY35PDga9CSk230SgZeVz/x4a/c0VFEwhE+HLGopC94kD72ypg==
X-Received: by 2002:a53:a14c:0:b0:667:a95b:59f2 with SMTP id
 956f58d0204a3-6683bd31a5bmr3013659d50.76.1784588359020; Mon, 20 Jul 2026
 15:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Alonso Briones <dev.alodani.es@gmail.com>
Date: Tue, 21 Jul 2026 00:59:09 +0200
X-Gm-Features: AUfX_mwImAxUMhrXyHzzw-cXmZBGvgo7j7i5z7XJCKHzLgjlH_59vtxjrWJQzwo
Message-ID: <CAGuFzEYb_3QM==DWM3p9OGH4AnVD15pw8OYh6kWE+RanT4d9Gg@mail.gmail.com>
Subject: Bluetooth: btusb: missing device ID 13d3:3626 (Realtek RTL8851BE, IMC
 Networks rebrand)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

My Bluetooth radio (part of a Realtek RTL8851BE wifi+BT combo module,
OEM-branded "IMC Networks") is not recognized by btusb's device table,
so the Realtek firmware never loads and the radio does not work at the
RF level at all (confirmed: neither scanning from the device nor being
scanned by other devices detects anything).

Device details (lsusb -v):

  idVendor           0x13d3 IMC Networks
  idProduct          0x3626 Bluetooth Radio
  bcdDevice            0.00
  iManufacturer           1 Realtek
  iProduct                2 Bluetooth Radio
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth

Kernel log on enumeration:

  usb 7-1: New USB device found, idVendor=13d3, idProduct=3626, bcdDevice= 0.00
  usb 7-1: Product: Bluetooth Radio
  usb 7-1: Manufacturer: Realtek

This looks like the same situation as 13d3:3600/13d3:3601 (RTL8851BE,
added in commit adding "Bluetooth: btusb: Add RTL8851BE device
0x13d3:0x3601"), just a different OEM USB ID for the same chip.

Would it be possible to add:

  { USB_DEVICE(0x13d3, 0x3626), .driver_info = BTUSB_REALTEK },

to the device table in drivers/bluetooth/btusb.c, next to the existing
0x13d3:0x3600/0x3601 entries?

Happy to test a patch if needed


Thanks,


Daniel
