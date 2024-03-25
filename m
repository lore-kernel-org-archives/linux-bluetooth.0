Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABBF54906
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373877; cv=none; b=gHWU7Hj8kiUBv5ywtX2KLKvPYtyN/iB0N7B2uDilAoLau/H6XO+eGbMMtTeoIlUAY4Crp8h1qJbqS+K9tdu0/yv07sPONi2fnQQjitAdtdK2r8NtmtCJ9YSOL4H0VHUen/+q7b6t85J2SIM1gYr0FT8k10cgQtZjyCex376+ifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373877; c=relaxed/simple;
	bh=CDNGfVeq5SJIA0y/Xt4Cxp2HYN+YdkHK88iQ4BVQuuQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FQlfnRltj5tOU5mveCMTMDYuynRk1aL549HcgLNxyJz9W83MdnzDyBLEuCW8iqBwJ+qN6Y8F6IlprAmOqG6+xgIr1wE0+MnlXCvBEnXqHzNvyq3EUVQH4yfPJ7/Hiw46e82P9OYmbAuDDS332/x2Q/qhnBLfUm3Sg0KwfwBZib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jnfvj4QK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnfvj4QK"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ea838bf357so1975428b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711373875; x=1711978675; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CDNGfVeq5SJIA0y/Xt4Cxp2HYN+YdkHK88iQ4BVQuuQ=;
        b=Jnfvj4QKHQcLsG439lT118+K8+5Htw5xXJ8Y8CDH8w4Oc1VhPU/5yOTuyLGfs2jh6g
         /X+dcDmqBNMP6af00ghBeKXNjGfsecfknh/bU2NEQ8lzlKgkJZq5aYhTvFzb6TBwonug
         1JKMdm5TSgLCbsgRW+5UrknfvLv5WDVNno5gYfJKqPtI/NdjMjIzJuAcLJAb0PJmAKtO
         wyd7W/8ZnCTiLAeZ3NC77B25CV6UNRsjOKMKXcRaiIxA8U5IxQoYNVzHncC6VZwjuiYX
         MSApVO9SWrePI2zh2d8yxYzg9y9CXPpAHR0pf/r5k7Ni2qZqLJ5+aoirHXlf6syDpB8o
         oUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373875; x=1711978675;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDNGfVeq5SJIA0y/Xt4Cxp2HYN+YdkHK88iQ4BVQuuQ=;
        b=YPsWz6xqjK9tITKNhA8G/HwBxNcmyH9LgrQBcUVpStpuATaIFDVFh21l1euzNVMd1I
         FCzeVlRa/2xRxyIx5epu7M19t9caKM6nbqnjdBBZSXJQ6OG2Q66+4jwjP9yx+nedjAAR
         l8VJOkvPdp8d1VnRGD4IV4yyh5Rf7sN+VclXefbFU9qlahuzEQwqk01CPn1S4CS1AbKI
         dvp7xiwiGVsgi/yfHEaJqGXdcKElEqO5egXidHiyE1FeRX+R6NVXpvD5AGZk0kePSCt8
         wNhC/urBfYktweX8uUYPEGzLCDJZ9s1qOVzdcHCZlRZvUNj0tPBxDFO1cQSb7KdDca4+
         gBgA==
X-Gm-Message-State: AOJu0Yy7YVI+e/XFX7IyN8ABZ42uMIPp+6lcPESd02c84w6PseGIvhQs
	gl9DPN/MPtZ9x4mOP4NxQc4jFNe7/oJi6jM3yoguh0fVy44YYczBzad3w67O
X-Google-Smtp-Source: AGHT+IGW4qf5nUqXd5mS2n8cWvcXB3RL6AjTCw/eeH2vjHw2UDRhxRydrieLaB3zd0uM+Y9sqmi70A==
X-Received: by 2002:a05:6a00:2da7:b0:6ea:6ffa:7f0b with SMTP id fb39-20020a056a002da700b006ea6ffa7f0bmr8384678pfb.7.1711373874935;
        Mon, 25 Mar 2024 06:37:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.46.96])
        by smtp.gmail.com with ESMTPSA id 26-20020a630a1a000000b005c6e8fa9f24sm5808787pgk.49.2024.03.25.06.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:37:54 -0700 (PDT)
Message-ID: <66017e32.630a0220.24c2a.f795@mx.google.com>
Date: Mon, 25 Mar 2024 06:37:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8592923718604185801=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: power: sequencing: implement the subsystem and add first users
In-Reply-To: <20240325131624.26023-2-brgl@bgdev.pl>
References: <20240325131624.26023-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8592923718604185801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sm8650-qrd.dts:203
error: arch/arm64/boot/dts/qcom/sm8650-qrd.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8592923718604185801==--
