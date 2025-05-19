Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3562459F1
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678964; cv=none; b=mnDaOi0NmIOUWKJeLT4svwtJ3PSkd4P8nQEdWMmssp4PJ/yEvc/l04JU8leCk1rOXR3sE+cXxdEgwtISh/60BgagFQFbZ1oIItyNkRX3x9Y+rtsZjIpnND19Ei0Im+blKsb4AmisO8ta4LoBG283+Mg84zLgTFlJ0JLcxGUb4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678964; c=relaxed/simple;
	bh=kRmTpG/q2TUbsS+rKcCiQUmRfBQo9W0yX8W8UHH0AnI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fur/kbZzsDCYMOqCcP7EzVfkAHrI2LBs7XEYqKAXoviDiAKWqWpy6ObQ1xT44a3zSsFRi5Er8RGs8dHcpnpr4vnNigg6dPw43P4mje7/e/lcAmbstDCSAWojZxvR5vTkQcBLhh2UZhXHu699uLOp+nscN8BbAPZlyRkTk10yGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjVF/RCc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjVF/RCc"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4766cb762b6so53741911cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678962; x=1748283762; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kRmTpG/q2TUbsS+rKcCiQUmRfBQo9W0yX8W8UHH0AnI=;
        b=KjVF/RCcF8A+iWUKnAId7P7RY193l2B3zPoRVlSQgdekj2XhSgHK+bdh3RGDYY+wIS
         o/yx7amgAIg2+mDzQ27srFNqeNHCGGCwWReF3BAGT1OKVFDrYpynSJkqNBbSc3CYzJnv
         Vg1VAczmIzzl9YPkh2FRcuJkw9YBeLdWTy9/shGimaVhOxhvN07QIEjFkZqd4RpWBv23
         7JLjHSVKUQ/OZ8qVAaExbmdCVFNDHrDekBkk3sUlCIhxFR13LQpzZrYPeJ7m/RsFbKaK
         mU5vRSMRvFz0H3DUIrwi8TVL7f721xUw/Lk6ArpmTHZeZeetw9myaisz3Qb2C8z5oJtS
         P6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678962; x=1748283762;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRmTpG/q2TUbsS+rKcCiQUmRfBQo9W0yX8W8UHH0AnI=;
        b=vC2Nqg+q8VtEuZEjFqo3bB8G1fNTk+dypFdb2ynaPJqY49trLiefQ4owCdwPtYKfbd
         cxcm33vq/fyo5GE51464aAvdzuTjuHfpN7XyRrBnnGyPFIIbVUYdPyLCMgOfNm1vicSj
         UDBj5yxSaySWZC3+dDPuLRRLSFOsGMUFawhxFZQleS7h2347ugyVbUoOcBZfEVNV9aIX
         7zAGOyjdeyXMFcY7GkstptC2Dknx5/aroUfxIDk54ZaLWFl5gZqB070lNm/TTDlqI0kx
         pwGgmkxCLWIFGk5gy4Lcr3IQoiMWifzuxUsGQTIWxcrACdep7Sut1LK4GpyObHNdTa6h
         qllQ==
X-Gm-Message-State: AOJu0YwFNzqLzjtCF3WDbx/u9p/IChvfLL4qO6QD05oCe49HOms9T+V5
	ipgHya42j5K9mI9+eJZWeiAlLDZJJQVgub466+z0OPCqHtgcgmRCR9JcPzAT2Q==
X-Gm-Gg: ASbGncuDtZMSZ37O47akYhFNmq0myPi8fZh5l1NF6PREw9cfeTEjlQTO9hW4bV1N8Ma
	aZId79S0s+vSmXi+C30sUVXAeuRuprJIAecZ4rOIqrSXM/fHjti0eiUWVUWxlfevQAbp0f3pItO
	AU3bLX3MKmzV7LVJ4cS6M25nQm+y2gCyhVLWlOzJop5qVXjW1p8rqjV7IYIQgeqTO7J1XiET8i4
	wTFgzlbbT8aILJLR7ANzXH2pm/5XsKgjdzqU4Z7MOYa20OJanJu7WlD3q6PC3EsRdiWmVsOL34F
	dJSzjzlTwJYycRNCeWpYAPSHeEbE88w7ATWgZz816GkXp+GgoYxb13X5lg==
X-Google-Smtp-Source: AGHT+IGNFZBnvd33ybpSfNiA2/ktuYKcRWIByqey0+wVUbP/h682B0BXoxzO2XPkfqqrEom7wPt8Pw==
X-Received: by 2002:a05:622a:22a9:b0:494:89e1:cb7e with SMTP id d75a77b69052e-494ae461441mr186767571cf.6.1747678961638;
        Mon, 19 May 2025 11:22:41 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.173.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b08abb97sm59991316d6.35.2025.05.19.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:22:41 -0700 (PDT)
Message-ID: <682b76f1.0c0a0220.167276.9a7e@mx.google.com>
Date: Mon, 19 May 2025 11:22:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5231755800424434069=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mokshraj20@gmail.com
Subject: RE: Bluetooth (btusb): Add quirk for Realtek USB device (0x13d3:0x3601) for proper detection and connection
In-Reply-To: <CAJRNte7O33P24v5o9C3K=tpwtP_h2Ohg2arYguF=C6-4Ga8pRA@mail.gmail.com>
References: <CAJRNte7O33P24v5o9C3K=tpwtP_h2Ohg2arYguF=C6-4Ga8pRA@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5231755800424434069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:555
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5231755800424434069==--
