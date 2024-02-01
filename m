Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201516087F
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804093; cv=none; b=mcgwYB4LxaJb+kdgJYtcakLCf/P8Zjt1J/gvO/rprLn7ANpazEL4pQuPt66O4gbNSe9cH7SZiTZOls8fQi6G7derN7P29tAErtqhXOxRhfwBtRwh/RuROi6iCI1rOGT06rojrzCY5CQywYBfbvFxJac75ig53QJ2yk417irM/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804093; c=relaxed/simple;
	bh=feYhqNGnu/4yElwLGEWJzAR+cBsf8aIYzwCwqxd630k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VaEIS5bl1olHUcYpUsgv88fFrSzci6tTj5zHL1/atuC1qzQDogco7UnY1Z0T0mNR9W11tFkq2WfYg8bpQ0gtPqXyDDeb4Rb1wSmoWBl18/KQ+ArqyaDhs+xx2mHZaTVhanql3pJ31HQqXewtj/tiQKckx/9jcADT0ESoVKRzJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXX2TwFp; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXX2TwFp"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783def87c8cso71458485a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 08:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706804091; x=1707408891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=feYhqNGnu/4yElwLGEWJzAR+cBsf8aIYzwCwqxd630k=;
        b=VXX2TwFpwDwuRnw7EZXVsCSzz3WAvPI62rKnxMe58pi4JmmdoMZ+APL5NJTiEhfB9r
         bRW6Swqr1WIMMVz+RWFba2aUHaBv4YIYqjxmUTNes5Wj2XF7D9BnidgAQecs4u6vGJbo
         JNnmJZqpmrOrnHqH9GeAprFoF9PWRAXcYPCmGQbdw4fINhcFHvaJlSbftuVS1yEw7b0z
         tSyZE+YZRs3Udgv7CLmfWVAc4Mn8y9vPfwW5Ud1x0JjaaO97OwhV6bRh3h6L7TcXVJfr
         KPjShAYyvoo2yq6m8os/CnTZ1JtNnChpDMdusIV9OZAGgDQFJUQdxR71dtTh4VHRjxub
         U5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804091; x=1707408891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feYhqNGnu/4yElwLGEWJzAR+cBsf8aIYzwCwqxd630k=;
        b=vEpAMeLUauoADO9IuDOy4zElrgbjVOydXIAY49/u3mevvIHxREImOrwgOn/oquOgYs
         F3P4Zr3G83veK6p30fz0EKcGRzhDJgzFPXq4kDTS/0yX290JKFsR3oQTNTDRj8CAwaaI
         miTy/sJJ85ORwC1wSUzoguBWx8Z4asGpJBUgUIKILhih0jyq2axtboFTV7u1ft8TLsrm
         u9J1yW2r8icbFMGdbIyg1vr4kyDzSBDg/NHTU41BcO6mW/aUJUMvUqnbTgnGbvPDVbqz
         Vp+KBTOTqTJURXM53TzKx0poACHzltvAj9Icl9KJ6SytvlcC8tKq5bzCCfNns8Bkqf+M
         67mg==
X-Gm-Message-State: AOJu0Yy971M4Eky92YhZB9STyC8y6wOH/I7fWQ/JTMWB9Ks6xvBtLZ9C
	Nr+z3RJXdFtwjHjlhX0XybOT9hS94AV0W0kMLEfB/fPLNBwyow6eTi2S7oJ+
X-Google-Smtp-Source: AGHT+IH+PEUuOj5aNcweT9rQMYEknmoKWSMeqcyrJs9IezW6UC7zULWe9atsHeihg9uvXMhfxnZbYQ==
X-Received: by 2002:a05:620a:1a1f:b0:783:9b9f:1adc with SMTP id bk31-20020a05620a1a1f00b007839b9f1adcmr3792748qkb.8.1706804090826;
        Thu, 01 Feb 2024 08:14:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUEueTOj9aqKxOndmDyRf4Zsc2i0fA9zu1zuen4LS/40ztbjF9YF8NsDVOX3W007l/iMccjkT2d9gTsFewT
Received: from [172.17.0.2] ([20.51.198.171])
        by smtp.gmail.com with ESMTPSA id z2-20020ae9c102000000b00783fb468e7bsm3750798qki.44.2024.02.01.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:14:50 -0800 (PST)
Message-ID: <65bbc37a.e90a0220.cf444.3052@mx.google.com>
Date: Thu, 01 Feb 2024 08:14:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2918868898922157687=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: power: sequencing: implement the subsystem and add first users
In-Reply-To: <20240201155532.49707-2-brgl@bgdev.pl>
References: <20240201155532.49707-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2918868898922157687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts:1303
error: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2918868898922157687==--
