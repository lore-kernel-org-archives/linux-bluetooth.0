Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597A3002A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 04:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782446790; cv=none; b=QmYAP5nMk6hyRUwhyM+EXAAN7HI/u6/paNqr1lmZpaVPZRokB3s9VPF12HVTgAfwi+VpI2aTZkgTWn7n1hWOGotkhIlOCBNePju+g0tB5dlRlzStHnL8ZY/GhxWcQ9FO7FP1fgt8P8ufjSrmXDmzrN7vCYwuBgG+C/ydv0drwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782446790; c=relaxed/simple;
	bh=cA6YGRIzWyShoKSELwZ8dbFwXtQbc9pdFlB7Mgivsl0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DVm60l91z/GIlwDuglhaxHpwN93hnfh+yhc358wQ7JmFhZa/WmbCTKFsgFcbaXaDt9Sn3EKlC+vZmLp/TH3xGtL1oE6zLW4+/4EAnxFmaiFfHFv0NXNMbToNCZA6b9w9WaFRV6/2pSbIOKDx+0m6yPWg64fEDsIIvYH9Tneo574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrWj1iyp; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrWj1iyp"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so1343559eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jun 2026 21:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782446788; x=1783051588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cA6YGRIzWyShoKSELwZ8dbFwXtQbc9pdFlB7Mgivsl0=;
        b=KrWj1iyp7ggTJ7MfyRwZEUHpo6ZwHvl283yLgRiPqUgOdNpmu354TfAqmQQhrXm+6h
         1wxpKI8W9zo0HD5Ha3JgYL44tnEgUrz4t1LrokrtRzEwGSDz96Oi/bIJXOytyLGO6yY8
         +IutMcqfc2o8Am3B9YdhMDq5mglel+p8kWqZjLKmWmZ6bKnbep4hqG6tOnuYHquKxZ0q
         lLM9Yy/Uxg6/pltBDCtblcfzmE5Zc6l+hGtO3VQb/fTKNRq2Npbxl02YJuwHv6Env83Y
         6j7vcqiVTW/E/kFvS3Ti5/Ma7CrNIWAYeyNaughCFgVYxbvo0eCEwVq6KmgEmk6jlYbH
         ybmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782446788; x=1783051588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA6YGRIzWyShoKSELwZ8dbFwXtQbc9pdFlB7Mgivsl0=;
        b=szn8lFpHwPjKv0FX3/1bN7IdSyDHjev7TT4CclCPKL7DZ5hx1X4ZsSJPRviG+o7CK0
         mK6uxv6fxiFMSxN8BLNcKVbTDR7XEvPbwBo+YRdfttpeP1scc9v4xOGwfIe8SzUQVwiy
         eThSX+kygL5JF6AIySwS0Vucd6gH+YXqs2UPag7uHzp9sSVJYZfF2yeWr+t++7zQ/qAf
         i4gGriCklSWJZLfxi2f9kjh726QElz5mXMKen+IrE+SWUazhLW/pNqGNRoTL4W4q2H2V
         lv/ZdjQKylBfHaRhkrgmCBBQfu7Svabx9FkP1znekGPxSv9bONdL/FQdx31QOIRExIJc
         spAw==
X-Gm-Message-State: AOJu0YzaH3X/+JUp4nj2kYLokMpLWMBXRMPuJQKewx4PJQCNcNepjW8j
	kpuVMboFO/1RV6cLBPbuaw63kbXRlBGd/X/ilh4Yyfs7oggfjiEHirsMC3wxIg==
X-Gm-Gg: AfdE7cllVJ4cqK+vxmdMwWUybjc7TqMnU5vw+uF+19D85LHgYCZlT9u+aUgaQKNLGb8
	0rFh1ziGICQ71Wl83CNLJuysr94YVKYzZLXE451f71fQuqmTOYbw8THwvwSPHckX1Ap/4aw8zqd
	va+n0+eA2XTCS8Lydxrzsk9fj8bp+Rz4+OkyWUkP5uiVG05vZ9iMKETGw3MjVA5akc75pF6wqH8
	GZG4+KWQ8Li30EBt0tloIhS4MyDhKcLPRTMKlbhpdGTkHEiyVURYSsRKgeHX38B/0frpQ7kuKZ+
	iQPOV2/Ym9DVevSEXj3vl/n0nTTYQENqjr2sGW2YvuoJJl36O7cbt3GGxobhncOZGzELOO84zPY
	OJRLpWabn6iZ8qJGx3vhcqUPYJ+NS9HZdQtuJYNYfxSwpoihrhEWlFIj2PehpPi4Zq4lZeeU7JF
	rqLwGM5pbjszoBoZrAYtguOA==
X-Received: by 2002:a05:7300:7b94:b0:30c:71d3:dc6d with SMTP id 5a478bee46e88-30c84df6433mr5926527eec.33.1782446787942;
        Thu, 25 Jun 2026 21:06:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.174.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c9d39e7besm2135639eec.26.2026.06.25.21.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 21:06:27 -0700 (PDT)
Message-ID: <6a3dfac3.eea6ab6e.167112.1fb8@mx.google.com>
Date: Thu, 25 Jun 2026 21:06:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7751741266378906887=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sherry.sun@oss.nxp.com
Subject: RE: Add PCIe M.2 Key E connector support for NXP i.MX boards
In-Reply-To: <20260626023126.2189931-2-sherry.sun@oss.nxp.com>
References: <20260626023126.2189931-2-sherry.sun@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7751741266378906887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/pci/controller/dwc/pci-imx6.c:1382
error: drivers/pci/controller/dwc/pci-imx6.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7751741266378906887==--
