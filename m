Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74E34751E
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819620; cv=none; b=pqzWNRBaRZEP0Ga35S1CVHk7YvEzSpCir+kO7WrTA1Lhlf2fjAUroKZbsGj7Aowcp9b8EHctHAFqkhD8qBDTVkm6AuksMpsiIpQGCFnjIMTLpbHYcd0vnB11IFJbZul5N+PzXs2iviNwPOsWbJ2CJQQul9vdeKS+O62jjqkYrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819620; c=relaxed/simple;
	bh=yAjdB83FN3IFOEN20ILrTVy63n7zFcAyeg0cTILLgRE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=csYzWD/FrpBePsjcb2JjX+iWDynS2EkTGTyFS5x6MZCHpIrv+SKAUPPhxdfWABp5pzWLTEfYIuHaOjJCgjdkDnQxmx6KV5hroVq4mB01TXOhpD+QOKeC89YSmPqhJIeBYEk5tWy7bDvZf2O1mqWCB+YgCOHdrz52qEOJOycwzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9cbfQb4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9cbfQb4"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e501244f5so111057485a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782819618; x=1783424418; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yAjdB83FN3IFOEN20ILrTVy63n7zFcAyeg0cTILLgRE=;
        b=N9cbfQb4NGrM4UVlu7+z5ACWPhxaewXMVZKhA6N63nHQ9enXLGPY88rbLq/kHAAub8
         nXTz+3StdrNknI883F9y7mkKa+nUWtGhpjGhyGL28EV7Q+TsEM3P8CZGEw1EnVDARwk1
         QLutuZ35GKrBPz25ThkTe/RxGs8o691Y0fin6VyjoE17Mbt4gA4m9sWgi5q3J0GSg2cH
         AwldQQbKNo295TQCTazr/HU2JV1l4QYJtfOnpcMfZoCeyB/D574CU966ziOR/pb9Zg/a
         e9BbYhNISn1LUf4iWzEWbQ/WrUzEH5Lhe/eu1zZ+Yqxx6s/yxauOs6iZNJ81DnA/wbTb
         PzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782819618; x=1783424418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAjdB83FN3IFOEN20ILrTVy63n7zFcAyeg0cTILLgRE=;
        b=N8a8Ji33bR1xgERNNRE03ESgdVmUEm07MlPK2D1uQBGXx8yu0qs8PbzRkk5ub+iR2s
         kvTvUaZCOC93GLlPQe7255DGnudh12poWonuIX/wMAVlnJB9cCuHTrotxH6zfT0ftpcT
         4ieHnZTc4L+1F8yPki0TJf1UYM2FOsjwKbdzvxG0ag131EfIC1g6O+FfeCNqTAx+XICg
         +vferEHjMwYn5BVbofI5CugB2othbZJJG5FUGNAOGmYrg7lNCtjphAEQHG5JKIkKK8mz
         VmX7ozpd7xyAIadqdL9x5qKQkrA+LqGVkpljOU7vFLd1lCjYBWyIczDbNsqidwPdNIY/
         asvw==
X-Gm-Message-State: AOJu0YxnLPa+vI+7vWhfQSmBtDGwtX7Tymisu/aOwoPkOGIg3cU1CqUw
	olno7mWzg7M49BeDwAyTypGal6+EFZPRrMyxRY+W8G2vRWag9A+Rn2omFo2fgA==
X-Gm-Gg: AfdE7ck190XCK/0MNPlXz5MXaZnNnO5gL7BjAaMPfWtwEQYvpspW12+2HF7apWucrbn
	rpaCxpFQeduZOVPbrds3on63CFZK8GzRB0Tlrw/DvGHKBtS9sBalQNfmtTPr8ltxnbZjgMDLlGi
	ln/20iSS88Le8adUJjpdR3B8fvSibb26QNV3defeQLbxwquKV+QDMOfbf2EADTuRi4QRcr24cl5
	Udy9eRV2jvBIJLtCTM8Ha3QRj3R6Jm8XmJKBFolNd+wEmoNXIU8FGEbTAaRz8OHY9vW7Hx2rqpK
	KLKs3Ix/x/5sTXoYjRqMVtJYoR7rmCfOYWQT/KUPYvZsN69tj4us+n6tFjpNPRC5W/W1C++Rgup
	pwoFxHi5CKEha3/zBqLC4HvJ9Oveh4Dn0eoF6JM9hAjoGhHd/mvjak4W5d7vD1FN5WFYR5/TuY4
	vRUlqUSyQ7XW3sxRlMkLw/
X-Received: by 2002:a05:620a:3713:b0:92e:5936:f661 with SMTP id af79cd13be357-92e624632e1mr499776285a.4.1782819617982;
        Tue, 30 Jun 2026 04:40:17 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.153.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a27e64a9sm22312316d6.4.2026.06.30.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:40:17 -0700 (PDT)
Message-ID: <6a43ab21.3c73b6eb.18ca87.de51@mx.google.com>
Date: Tue, 30 Jun 2026 04:40:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0438628472941474351=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sherry.sun@oss.nxp.com
Subject: RE: Add PCIe M.2 Key E connector support for NXP i.MX boards
In-Reply-To: <20260630103139.3823329-2-sherry.sun@oss.nxp.com>
References: <20260630103139.3823329-2-sherry.sun@oss.nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0438628472941474351==
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


--===============0438628472941474351==--
