Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555619F137
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183485; cv=none; b=mV1aHgjPczpDqEMQVMSqnfnt/Jt4ki0KjK4VV6apbLw8qXeUYrFq9AxQGs1htzsGkD53Bzq3JNSH6wT0KoSEPgMZv9jhOOW82/5uU6WoF1JtaLvfbllpiKXFz9afON7NCKRqf2NoLQA5hNwq0MEVZ5S6tDzhTfUDCOAOCnO+hlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183485; c=relaxed/simple;
	bh=3aOhmJHgCaY/LSxVTdZSZMJi/catvbsp4EmLRl7r3UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVo2uGRPWi3Uz7O1ibuCULt3jXBT9BkIn1YUzqMK1O7ghEf05Sd/QdrYC2vkVALA4leP11gqbnP9fSwG0fK/dEDPupYWeOn1MJlEh5vz7bW+ukeIOij8wnRItjPHgYUVrc3Mu+flwSvfd1T8kgHzO1OvyvOJFBs8+8guyo+a0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5qExKhz; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5qExKhz"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d71bcab6fso39136297b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756183483; x=1756788283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tX35IfGDf2Cq9C+jcMNrva8gDLrUi6aOQ/iQDuYCJk4=;
        b=U5qExKhzGK/W+OFaPKQfanq3bSYkQChzEAQHZf14SCnsq5qAZ2SSp0SvrEjv1hLiK7
         9l7DPmhhdnHZarv75+PvIB2ETWwwlaqLOUzHRs2dsWqcpLD0EFUPbvv9Nf5G+eUhVOl+
         qiyui+r5MQUaiscHOGs68UuCHu/l40jAsamfRfUIsutvlvVKWMvGFmzsIFEXIKBlXhoU
         QbnWy8V3OhhfZeydXSqcEqrkweuxfQdE4HArocEWyoG+SzaUctjLohwFRzUH2AfE9o4c
         fwDgU0g6mhLaG9lU/sjdJn5vNHZ2RLPv2Gt7Md9WTdi8oG5SJJluy/sLhzAdbhqHrCGu
         I6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756183483; x=1756788283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tX35IfGDf2Cq9C+jcMNrva8gDLrUi6aOQ/iQDuYCJk4=;
        b=D3hW/VnlQHoakyERRHBc+5DHaEO5BNYEUzMRMmvOLUUYWMxh1BGHxvaje5Zr4nz6TO
         U0PA+8ZAOoTRJLB/tq+oZPO8NQemLTUujV9zWsf06e7/NXGg4yJapITn6vlbUdcK0fd2
         O/kotIgSJfg4J2rsLQ7Ljr8ik0VYBdO9eWUjju4xRASrsWPbwx5fGgkZp+4vqTCSuU7X
         YDeoiGZT/wZsPeyvs3tQsBNY9DIliAw+Q7wdDnxAXy8MJp1J5ygCeEmVznJdNFA7Ir5F
         wozWOMyzXzDbLCIuOwlnmiG6CsFDanc2tWQpx+h5Fn0m0E9CiLRwFKfsnm2am6HbhvPP
         majQ==
X-Gm-Message-State: AOJu0Yzrvot7xGV/WnYaMO5GNXI7DQ2prn4I/vWwccSKOH56YhhD06Kv
	msfhZpFLQ98CCZ8TxFW2fMnNgr0ipILW3TYzq5AmMh60zyCxM6id7I4KddpZsBZfUlUBdq1A8Iv
	xatz6YbNQYXR6SFHy68aCBZ4jxSsPxCs=
X-Gm-Gg: ASbGncutCMg2rpQZC2rBjl1cWitdFxNBaryMWi6gc+IkQYiMD/XgCiqVt+qpe1b+yhz
	ABIJuyCO6QoGlKR37ULNKmBm1SXP8ZUV5a5sgyvhJ648XtVSBxcmCunittM43gGwl8uvsX+1GLa
	Kxk072t3uUmhVkuehkQB0BcD3tReu37NiF1wotBuUwzzuIE3WYL/Uzj/rjJvEtottBEEUIDdM01
	esrv12p
X-Google-Smtp-Source: AGHT+IFF4dp4d4Bn/X/QXnRw4xAaogEcaXewVPD1tZMJAC/ktdxz2iANWcOlpozUcAAO9NhJhirLbAWXOjfSdr0PsqI=
X-Received: by 2002:a05:690c:931c:20b0:71f:ed56:8afb with SMTP id
 00721157ae682-71fed56903cmr101823307b3.54.1756183483211; Mon, 25 Aug 2025
 21:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
 <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
 <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com>
 <CAGFh025kOatLYjLrBMzrFQQG0oQHZQ-4=U-d0Nky780HrrOPhw@mail.gmail.com> <CABBYNZKN3PwV4XPM3=7t_1-+=m1nAmEVcZ9UB0yfgks45vnOXg@mail.gmail.com>
In-Reply-To: <CABBYNZKN3PwV4XPM3=7t_1-+=m1nAmEVcZ9UB0yfgks45vnOXg@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Tue, 26 Aug 2025 06:44:32 +0200
X-Gm-Features: Ac12FXy9sVq6Pmz-xHy9874DVYsrlDcaSwgx2kuCK0EJVv2hjaK6KJOiblc_fBw
Message-ID: <CAGFh026t_ba4x48ZQqhKnBxkQC=uLF5O8vHx--c_fxJTS1b=pg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Could we solve this by doing:
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3595a8bad6bd..168b07041605 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1194,6 +1194,17 @@ static int btusb_recv_intr(struct btusb_data
> *data, void *buffer, int count)
>                 }
>
>                 if (!hci_skb_expect(skb)) {
> +                       /* Each chunk should correct to at least 1 or
> more events
> +                        * so if there are still bytes left that
> doesn't constitute a new
> +                         * event this is likely a bug in the controller.
> +                        */
> +                       if (count && count < HCI_EVENT_HDR_SIZE) {
> +                               bt_dev_warn(data->hdev,
> +                                           "Unexpected continuation: %d bytes",
> +                                           count);
> +                               count = 0;
> +                       }
> +

I've just verified that this patch brings the Barrot dongle to live on
Linux. Here is the output from dmesg:

> [   43.329852] usb 1-1.4: new full-speed USB device number 4 using dwc_otg
> [   43.446790] usb 1-1.4: New USB device found, idVendor=33fa, idProduct=0012, bcdDevice=88.91
> [   43.446813] usb 1-1.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> [   43.446821] usb 1-1.4: Product: UGREEN BT6.0 Adapter
> [   43.582024] Bluetooth: hci1: Unexpected continuation: 1 bytes
> [   43.703025] Bluetooth: hci1: Unexpected continuation: 1 bytes
> [   43.750141] Bluetooth: MGMT ver 1.23
