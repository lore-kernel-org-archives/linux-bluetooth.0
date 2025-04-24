Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D3E27C879
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509505; cv=none; b=ShAplTC9zD8m0b4X6xHzcS02wFTFYpjARvifCKOzlMGjrtV3PWAN7Hu38EOXkVTm9Qpn8CNdVgHuzqRiV6/7SPLIi/9Q4RBk1sbfGBSsYUdogjJLLVgwwRiei9t+/J9UElj67tZzqNCEQM45j7mLKEHG+qcmSKINsLzCIulI4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509505; c=relaxed/simple;
	bh=Q8XEQ0MV2m2lofoNCKJUjf5+gvnpRo9wOuKckRn/Ze4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GAYHHvUr3utYysrC2oTkWVK0BCIqiuaWPytCJVEfIsQqW/nI9vmQ+fHIZ/nFheLhcv1kkPm6jY+fs/VRBxyLx0MSSeFKe7PBnZSP0XhxauyQiozb6YxPqHOcimxYFHtHklMr3wVzHWlV7m9Cm4u2tJlReKLenxAovli3n7zyrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvsrus1v; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvsrus1v"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476977848c4so14758861cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509502; x=1746114302; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8XEQ0MV2m2lofoNCKJUjf5+gvnpRo9wOuKckRn/Ze4=;
        b=Qvsrus1v2fd4NY8Omdsr3j3zdJcpfuhfU6J+HGZ/qRYbLN6H0R3En1HClsHgJCnZOS
         Nu7EqD0wBZQ+Kiu7LPwRBf8J5kQ12OEdeF5fJxvzctdTpmNCg6EQSZLOPS0bBluvmDDf
         uBB3Yc/AIuOIvK7qM54Dn3n2GMrZ3QyFDBcOyoad89RqepQl5ZcEPGHwsZkt58lBD50d
         4t0CbLatjUofecllQQyzwbPwoemhe5TjLbfQfycEp0nIB8wNEeaq0DXZNXjOThoDmOHW
         5vr8NNMMGRF1WFhImWfyplRxwDZOmDjCBw5r/Il7ZAjEymhLBguywcUIKPQ75XPEtMs4
         THSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509502; x=1746114302;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8XEQ0MV2m2lofoNCKJUjf5+gvnpRo9wOuKckRn/Ze4=;
        b=YjodpZP88LfUPQY8ZljJnVa9UYbiG8dlbay6pnEUN6k1BeO//VkMWFqTTIUSlUx7L1
         ZlmKgiTxE5xGBTMAIc83MukOMVEdphAq5ePxI92CMUT3qJXDyPQWRIZIic47RUgBSJxg
         cmZHg1AYXJd0Xjt6n/+xsSZtsgs1fsfUJGgv7timRGr6oBJtYs/paT7Z1GtMpHyIy0qB
         IBb7x8qi+ySy6m4Ggu8Y8Wv+mcbXp2y0a8v1ChKnXwjfrwteY2phtzDO7pNnxl+eee3X
         FNWRfXGuVeJmt8gYOUhGgW2N946KnDvI+co4LebB8lzMV/vcCgxiS/Oz7xVuqKvy8lJg
         Z5cQ==
X-Gm-Message-State: AOJu0YxStgiyreeeqR008OK5eOl/glJlma1LOEqmLB5O3MbA3nABtws2
	4IkCAW5bHpSJa1wLtwyKdfR90DSUSX7iHDNkZi1HlwXJtm3gg1XL7VXkug==
X-Gm-Gg: ASbGnculiQye1UxLou/K/uG++2tmaZZammZXuCsZohnTn3Vk4KxRjzvMYi3v+TyDws3
	N9CDa2Fuf1MtVtLQBrgaNM4SN+PcsDo3r4KUFZ6gwvGojFbgK/ZWUsem1a96IOAyZNqgDPL+wOA
	OMXK2D8g57htrqe7gghVvQnrYll2oSRhwPGryyTmzkjYcEp9eX+9CYxyFEHxTaTpgrJFKGptnyJ
	xGEQli3cqT7O2OY5jNPf8nMNDDCZ4uUzEF2bJZJLvcCdl82TG2BqFTVHxN8GhJ/gtmXZIFpwtpR
	/qNma95F9Qo3NoNP4g/WgdAGhtidXF7CQAZ8C3xMesB7HTWf2g==
X-Google-Smtp-Source: AGHT+IFhZdjhDoQ9Vcb+R4A5S71Wme14vjsH5GpPlJ6UnxSPrxaXjrqcDBN+RkFKd/ka1mihh1fhfQ==
X-Received: by 2002:ac8:598d:0:b0:476:9017:bbf1 with SMTP id d75a77b69052e-47fbbc44333mr2926381cf.46.1745509502417;
        Thu, 24 Apr 2025 08:45:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f0d21a2sm13215771cf.27.2025.04.24.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:45:02 -0700 (PDT)
Message-ID: <680a5c7e.050a0220.33c83b.664a@mx.google.com>
Date: Thu, 24 Apr 2025 08:45:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5921054072865396655=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] btmon: Decode Broadcast Name
In-Reply-To: <20250421210602.746957-1-luiz.dentz@gmail.com>
References: <20250421210602.746957-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5921054072865396655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: monitor/packet.c:3213
error: monitor/packet.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5921054072865396655==--
