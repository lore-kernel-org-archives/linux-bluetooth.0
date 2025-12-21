Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0CB640
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Dec 2025 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766276098; cv=none; b=qEVi/w1D6ViVECbGsrGqKiaNLu7iT8h/UGalZlJul9SzODQXoO0t2TTK6J1l7pTi6+CMTIuzuxBax4ovZG8VO+UjB317NvUE2kfYk8XDPKixAQeykUzIBYVzTsWmuD7o5rPCExSLM79gXRgBgo/bm+4F7AGlQbEl3ySD+ECZOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766276098; c=relaxed/simple;
	bh=r+l2i9QVCy+Xd8F4yQ1kEF7SUd9DgjdfDKKODLMmWL8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MUyc00+nrbkAThNCVQmcC7T/J9riz5RpdgKCJsNrCmXEdFgNmoj7i/ecy7qjvvYwU+ouqA/6rcIulWaeOLjOuVMSb3KJpyes7PNgEL0IGnPZXPezBcRZtgOzNUAJoXWiZ4pUj9aX3AaLXiKUZZ3ldmu4fpNfx6ZTiPHFpT6NMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg1NEQzR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg1NEQzR"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b9728a353so37192231fa.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 16:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766276094; x=1766880894; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZgpQaY4/4Rd1FjjknojeYFDlAbTdF7Hlp4DwNYIMQs=;
        b=Cg1NEQzRe22Ii+gEEEp/AfkeAqYftKy0XAC7bmZT6sDCb5R79YEf0h0OYhJU3VyrRz
         5Ovyn+HWBjWIU85RoEfQ0MRk7We9AFhFK9xGd+uvWxl4Kj4oMTZ8EiM5lA2r3pP0P8Zb
         hz6yQuvBPpo2tG/W7bWt5rvrahfBf4szMwQLpyBw7eBx/eouskmRBjx79dlYLF2XL6Hw
         5JY2m6c49S/0IXuyDXPbFUWJ4mkwV7XlqLaZFrE5MPw9W0Utobq3Fy4OCKGmZbKxWlrG
         /TBnkEvSpu0KDzfVV21yGXckV/LnSMZQDDfvnh2DY8izAcGipOBA2LK4n0yV4vuzddYD
         dpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766276094; x=1766880894;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZgpQaY4/4Rd1FjjknojeYFDlAbTdF7Hlp4DwNYIMQs=;
        b=n6OZIDg/Llp+edXv3eLKUkXvoVUSursTuZmHp32Pp9JSyjdwQgsOIfIOQ/Ev9d1MPH
         lvC/9h23bbki6oiShsmq5TSrnV0EL2q77Wz8OMvg+MBrGEnxbxn9jAUdHKa+q+w2Dd1H
         +0sLddWC3Tb2EuYyRT8hKT1Z2cM+qV1y/g8d9y/qPxj8fPL5hc09x3jGH22kybMDuWMK
         qiKgvAIt1A9tV/0s0IVQvSqCy1b87obffYN/YeEn2/dFCOCntfKPAJvsxuqy2Qk7fez/
         dlRDCZl1AQ55cLVDFEV7d6aA+L9CjJ18pk+UnijTAAnX71pgNc9tRkRvnOXbL1NuoHrG
         ziug==
X-Gm-Message-State: AOJu0Yyl6R1jtVTFsDj6O/y1QNK9BDmBjk6Nl5lk0xi0FfmF1iO0Nk5X
	JNAn4AqAvuR9cpwKOej4AghGjEVCGbjzuVY8PxuQ5wQml+CqAKurmn1FJyfIB/B9K2J1Sv+73VV
	nIOmH3qtw5uFdNWEOTnv0yMc0qBV4kyuBk7t7
X-Gm-Gg: AY/fxX6CMgjOSs9FCFLu5fWiECg7ZaL5WAMzQlgh5tHTMbfrYatj5XEmTuJc3s50cS3
	1QB15aDRpUrhd9K00svFtKVJ21gYOS4Xb4q8yF2251ESoH8lPo0Imh2eR7YMtLoLZvENQ7zp8Oz
	Q1iySIIrJFC65oJMF7CQwP6B73X+C2UTpg2fhDEoZUsJuk2ZxeJqV+5PDXIeIATVKyYlq05tShx
	b7Daj4lPhaf1LQhpfsfHyjorfgOyxmE70dmwgaD2VboDwNhN+9IQjQSvS6U7XZBBGmDN2BpeVSk
	rg4/xtKqWj6GNV47Anc3zeibgjnc
X-Google-Smtp-Source: AGHT+IFdzsprruqEBmuW9esmIHNlmHL3k3/P47EGFXN10H/TD4IMWr14Pcl9iUJEOWeskrHtJd51+TdauGC9yPuWBBY=
X-Received: by 2002:a05:651c:1b14:b0:37a:4c29:3aaa with SMTP id
 38308e7fff4ca-3812158e057mr21195521fa.12.1766276094424; Sat, 20 Dec 2025
 16:14:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ltklionel l4961 <ltklionel@gmail.com>
Date: Sat, 20 Dec 2025 18:14:18 -0600
X-Gm-Features: AQt7F2q5OUeFp2WnuW3tjwdTfFVAjP7oJOw6n3xrExHvfDs2A6-d168fdnWxnx4
Message-ID: <CAAm4C2sryqbJJZnm37oFNUnQ3X+wLO2RiYPdsn8ruP2axzFo+w@mail.gmail.com>
Subject: [REPORT] Missing ID 0489:e112 (Realtek RTL8852BE) in btusb
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to report a missing ID for the Realtek RTL8852BE
Bluetooth controller found on the ASUS Prime Z790-V AX motherboard.

The device fails to load firmware with the generic driver, but works
correctly when the BTUSB_REALTEK quirk is applied.

I have tested this on Kernel 6.18.2 by compiling a patched btusb
module, and I confirmed that the device scans and connects to
peripherals successfully.

Device Info:
ID: 0489:e112
Product: Foxconn / Hon Hai Wireless_Device
Chip: Realtek RTL8852BE

Proposed change to drivers/bluetooth/btusb.c:

    { USB_DEVICE(0x0489, 0xe112), .driver_info = BTUSB_REALTEK |
                                                 BTUSB_WIDEBAND_SPEECH },

lsusb output:
Bus 001 Device 007: ID 0489:e112 Foxconn / Hon Hai Bluetooth Radio

Thanks,
Luke Kaiser
