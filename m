Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5573B27C5
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071451; cv=none; b=WNtn9HCEU4iDu0wzsW/BVx48oRG/bzHljB9QLtcv0oa3/RguMCjmsW612sgZv+EOodz+mTDnXfIoU+A49ZJVj0+3uunuLkio/9Nauixb4u2p0Td4NEbqqFzCyIc5SqeONGRiyQgqyqkNoTkkcs8GbaLl0BNvE7dpWzGrg1TBo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071451; c=relaxed/simple;
	bh=2DDPsX3OgGqTTeeFsHygz31PYHq3LPPF6DwORwPyIss=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PU7zA/mIN4/URtIZYTKx8SvK3MAKryR1JcO+PHLFrwbRiOsQfhXIL7phb+6VRJAMI6Q2dIRNzB4tmUXqhVFvXwfW4TPzQ/+ANOqXWaiTJuGp7ggBj2yUAQSbx2dIacR98nQiz1TUHkGi+bnl2LwR7LdLZ6m8ib/DExNYt7RAMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuskPv15; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuskPv15"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b9d265355so298177a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783071449; x=1783676249; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2DDPsX3OgGqTTeeFsHygz31PYHq3LPPF6DwORwPyIss=;
        b=QuskPv15A8qavGP1h4poKOCpMdMEKc6AxtZ3rgS9nVyE3VeruL9HNGc3LiGnq+s9Cj
         567PnwPqmdruQtH8FrrZN0Vd9PsjQS743vlzoFpZK9slnG0dLfJlc96uF/OlWdD3oRHh
         LRG54E2txyFJxxJ8xme9ZfoK31TLpMPHrZTBDEvMCMib1Jy5FkfhIODTuFnn7UPyIFCy
         ai4bivFO4uY3so78og37F7ewJOWLlBhnaF8K3l5eJcIzfJCRELutON8oXiAA6bBBq4SY
         u33v8fpq4zyT3cI7dM4Q/7ROMh3o4etK+WRRbcUHtftspmrpKtX2BbHzY12kgOA7VIz7
         HrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783071449; x=1783676249;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2DDPsX3OgGqTTeeFsHygz31PYHq3LPPF6DwORwPyIss=;
        b=qe/hYG34vWCjrA5O2U6x5/u9rA58lVuYnInlTQpST7qhvWSKs10I9DcROkWABl6eB0
         A4U7vdb5QNUsxEfleSL/JmwlO6bpgZCInL3a/VlGxAZo81y+BtGU1qSi+jxTNacpqhv6
         QlKiA/EtCypUl7r1sXotXxpxr+OB0OmiBMIsa9tDDGwbGu3ayAOrsQecrwIEgutMtxav
         3CiV2X0yjk//SVdiT4jDPFYE8g+JJqKFmGyrtW1/3rgWYb8WofFHr78ez22uPvdcNV1N
         J8TJejBOw4PpSbeE4rhmxsqkqWVIsGQ0KGMiHdMc/QKHnFjqNQpzEBJvlJENp6CD6QpK
         cp2A==
X-Gm-Message-State: AOJu0YzTPUrHwcneMtRvf1EsCdx6GHIOjFscC2XW1i1lX6dEx0kenMwz
	KFnoaVkqW8+89s4CpUaEuYZm6oOQr9b4Si/7D/EPigzgT3dMYUQVx9BbhxEh+g==
X-Gm-Gg: AfdE7cm57sE1hPmIk6x9yoeXb1HPjaa+a6iwA2kQbfuh6rvAS+Vf8yrx2yHWqhvz/m3
	V0UibF0cSp4nGuaL+WsMoa8PKbXGe2z3kGC0ax0LLx88lGKibjnOH0BczEz91HGCoLxlGNQfXfY
	S6tg97DhCpD6shIuU9RobW5f017jEnRS2+HyC4hDCRS0sbPeddzgL57Ll9LIla71uLu/SPpLkQP
	mfoWNzZckR1TiN6BEfY7f1jU3oZJDUcZ4bahTVnRVG209ZXZcFJKRSVpiq4zUMB82mXuWy5rKxt
	xqD4UUAzmyON90z7Qi/hr+4Au1ZT7YlJZZi5nC43t3H8104HVPDxNLnmZVSm9WihVvCdrbK3vuT
	P+yLiI0ZVbtaO2BOkUDO3CSpEgrXHnBLawMAy2eAvw2HSUh9c0TAbThaEDpSf/wB/CULjP07O0U
	iyBHivtHQ4nJi1gZkB3m0=
X-Received: by 2002:a17:90a:e7d0:b0:37f:f8c5:93c9 with SMTP id 98e67ed59e1d1-380ba829f80mr9530326a91.10.1783071449444;
        Fri, 03 Jul 2026 02:37:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.75.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd221bsm19387280eec.22.2026.07.03.02.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 02:37:28 -0700 (PDT)
Message-ID: <6a4782d8.cbc3f03a.3be201.4702@mx.google.com>
Date: Fri, 03 Jul 2026 02:37:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8502332631805265444=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, winter91@foxmail.com
Subject: RE: Bluetooth: btusb: fix USB interface release on probe error path
In-Reply-To: <tencent_A0AEA018EC865AB4DC9D2A43D1E5B71DE905@qq.com>
References: <tencent_A0AEA018EC865AB4DC9D2A43D1E5B71DE905@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8502332631805265444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:4407
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8502332631805265444==--
