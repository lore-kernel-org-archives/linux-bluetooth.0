Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAC364CD
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761812; cv=none; b=nhI9WWd6KjH1LLHMAeT0iX1Xvzps4688zoE9Vv9SVuj3veSone4wzjeiyJudPlpWhaKiabGDaNiG7qI5c4gMWv/gvT8wB6aok8iUJAErJT/IhnamKzJIiUf8wvNO8kExfNrLp0XyxMFvI79Q2NQqDngkip2lIJMdepQO+c7K08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761812; c=relaxed/simple;
	bh=FNuruXuaNEpeCSuGIPuNA69+xpLnzjCrgTxTbRrC370=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DldDoj+XqL80Em/DTYdByAn+CTFkP0Ye63cvvPVGKtFEWeYg1hC0uQuRUSnVs2vzzzz622lg9kKzDKE9A9vUWRfbMzDm2YnNOgcpUEn4J5/GNcFK3RwWT0Hm3s+qU3izhB4LLWpJp6VvU4eu30ru0TE6GsZfHJjHbZOewILojMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu615Svr; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu615Svr"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e69ae0ff44so69104a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710761809; x=1711366609; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FNuruXuaNEpeCSuGIPuNA69+xpLnzjCrgTxTbRrC370=;
        b=Eu615SvrMOslZkM+f1mZ1WpThV6EJmaqm3i+f56Ihz56X3gmuVrzoYOe8FK+AdUHZd
         0UgY1mbvg9P40RGMvPBiFwtXqHZRMPptFMhsesAILWsrrAUbCQY2XrB87m/DTpi6ZxJ5
         l1DjHO8x/MxhXWe/LGOCutiPABHNR1wpMin5yaIPzEXNxYLbQkrgn2qGB3v7iEKxlB78
         5yvsP4jLuC/YiR+NaPas4lkA999jz9KZ2sK9LSj52K4TjXpgiHDIaEjIsTE/FiixHtSZ
         9cINJ8LiXTyrqp7NQqhohZf++oFac1/KhnDxsusp17rm+DeTmPTBQtvnEVWFqT0STCKR
         LtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710761809; x=1711366609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNuruXuaNEpeCSuGIPuNA69+xpLnzjCrgTxTbRrC370=;
        b=ZyGM1hnR5U1c0Rb99g+wj87K/b3MVkHHaxB4N5G7vxcstIBp/B6bqJ5Xl4R5GCcQQb
         09LDRQWkUML+gBL8cfeccPadUMZRgTZoOCjATIbIwACvvaxuh7sOU8Fu5R4kWLqdGzve
         chqt9yMtWeBnMjI9BHKv896MlNKXIK5ViwelgrO7sfVmxwKQT3wm+nWp0w/XWWZAgTSv
         c5YCNkMy48LED8WvNIWAAca/ET5URMCoPhKM01FMLMdqoziV8tQKgfGJlVGUSby9WxoG
         dbfWSAtwP6SV0PG6eh6K8gCGRTxiskfrNRZdDxzQE7I9w8fOGGzojDRVerRVSiBSFvJ1
         DArg==
X-Gm-Message-State: AOJu0YwMwcUfw9zpW3A4gH8RZNrljdfCY+sVMBTHzKzp8V9+avCfOFpF
	O05apO1G/c2s5b0wf9E5Eg4lyAvZVOp325PBwlb8ufecNg1at2pKHQmQn5cp
X-Google-Smtp-Source: AGHT+IEwQWLqVLNbUySCkXb3I4adrxMCzMgNm42YP+T8naGZsjK2j8vhyTcHQOJFFU5x6h/QkbV2sg==
X-Received: by 2002:a05:6830:1555:b0:6e6:8916:da21 with SMTP id l21-20020a056830155500b006e68916da21mr4501235otp.30.1710761809553;
        Mon, 18 Mar 2024 04:36:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.161])
        by smtp.gmail.com with ESMTPSA id q4-20020ad45ca4000000b00690c77505bdsm5240151qvh.37.2024.03.18.04.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:36:49 -0700 (PDT)
Message-ID: <65f82751.d40a0220.f02c6.10cb@mx.google.com>
Date: Mon, 18 Mar 2024 04:36:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5008692449197814802=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: qca: fix device-address endianness
In-Reply-To: <20240318110855.31954-2-johan+linaro@kernel.org>
References: <20240318110855.31954-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5008692449197814802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:1904
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5008692449197814802==--
