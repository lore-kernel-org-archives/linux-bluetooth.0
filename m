Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4E466B0D
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738602; cv=none; b=RHD59rdkldz6BeS0uqjIDCLnmRKDgaORChbx6z7ZB56oZt48KohAdhzKogwXG8ehPwTGHRr3I1U9aygqXMdaKLcPxgCCZKFbIF59MBtHL0+zH6tT3+qS4+khakc2xxqknvODtBY2NRyNmZ3HfMgVCN7HDSplW0jEiS8rRZojkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738602; c=relaxed/simple;
	bh=mgUDNlCZD5vecOEufE5C6TD8cSRwV3XLqxPrj5hIeGg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bc+WuLSGDAHAlCX8rlSSpt5k6ssRrbDzQCQq+o6BH6fwOKPF7j/BvZrQwq8Cz93GlQvaZddb6fnfPafd/cU8sPos6eg+nczHOSFWBzFisW05ZQ0tD/ZLMHve6C0x1OVuwu4puQS9TDnfjVssH/Ci04Nqx/LcukwaPwBARQTttbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKbdQEcn; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKbdQEcn"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9061a795d76so98776426d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784738588; x=1785343388; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mgUDNlCZD5vecOEufE5C6TD8cSRwV3XLqxPrj5hIeGg=;
        b=EKbdQEcnfA6rFwfNWG5QZCMS2vEoI0jItqQnLkiEevyumRbSI7hUijOtl1hLyCcMUO
         R4KBArkR+9R0dJgKz6VEqdmI66f2p4590mL/To5Eef8F1EXzJ5B8v06yHLofzGTLA72z
         eBchyBlF8Vk4xmSC0C7BGXQZndK45tY7AEM4Ajxc6xT9qfLn668twKtI7VnmPOs8Sa7o
         0kvp/CiOqHsVc1JNqWHFy3CrqqqdQ+YqJfrIBQemZ1SdaenPogoBpAziiwIMPpvEwdUs
         uzaGyMaIftdJ5wwZn4mH1Z7cdoMHsmQd1ZM0GNnwlpkpUHHEeh80XQNsmBuKbwV34E0J
         RWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738588; x=1785343388;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mgUDNlCZD5vecOEufE5C6TD8cSRwV3XLqxPrj5hIeGg=;
        b=HlQ/mTTDhmzZulbLDdhe6ujUQfF5GAx78iCT3VMZFW45jT1n+VGYrPttIgwmYk2vhx
         AJn7s9H5tSJ4CeAKMFpuYD9J1sZYrGcq/uRI1VcPxSHGUbMBMZQan5lS+W1GsubElwYb
         AuMkUbcpRkw5E9uCbx6zF749alaa4Ppktast8O5Y5tpfaBqNFXf2VS657rwAw/Aw25zW
         vx957qg/SzNSq84aiv5iaghA2Ccikb7BtRs5xk8nDAlzNvjnssIBcEPoLfkRQF9zt/V2
         1i+Bh3I9RpZQQuvSMBOC4UcV4LDv4/K0XZCXBya0vXauJJcR5Tg9QtUkmIhJAmxtTK6L
         WOjA==
X-Gm-Message-State: AOJu0Yyh4c09lkOGosxNSpkYARdQ9jitlEe09v7ZAbhBG379e7JP6iby
	IGDE5/SaG7WNMpoQBsDYgA/JPDo6qECsjaCvzzQy87bCE32J2DVrhcTf7YycEg==
X-Gm-Gg: AR+sD13RTBKrIfmTpOrM3BMNDHsJNGJaPeY2AhEOPeXrcpDVxoN/WRebKSlMUoHJ6SN
	uUW7eGumvgzMR4GVYYgqEqR0sBtUlc3xr5fUyuLwRPfMbDI4Mm0SyJj1d3waAGWX0W5cPcvncv0
	kMq02SM9UClv8xH3Vg8z6+9+I1TL7LKoq05lZBClt8/bMRitsh1Tu1n9FKZYX6yp6MApI+V8fos
	AtFklJNQn7KrIusvr84zM7zdpp5tOvGz1gWwqLvxMpRPykFfNBqmNd+WVWNk+TWlvJINYKBoeU3
	KQNbrNAcNC8EpbS2l6wH0xDX9omQQ5uzMtP1rEqvGmakrloNmCYqTYvHd4GBhWGzsArj1FpzaZg
	LnUDVJ/FBhH4gtXNQs/dIMNVQxXyWDPSLLgh7akZj2P1bI6lUDh9iFLoBnPA6s1HpCm9QsMiork
	QLN2Iebm/skdQAAakBfvoc
X-Received: by 2002:a05:620a:6287:b0:92e:44be:bbd2 with SMTP id af79cd13be357-930b3e6fa07mr2374143885a.9.1784738587707;
        Wed, 22 Jul 2026 09:43:07 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.176.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f687aceasm204565585a.8.2026.07.22.09.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:43:06 -0700 (PDT)
Message-ID: <6a60f31a.1fd19957.28a4f.de7e@mx.google.com>
Date: Wed, 22 Jul 2026 09:43:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8906607326569971594=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: Add generic support for vendor HCI frames
In-Reply-To: <20260722-support_vendor_hci-v2-1-132b506460a4@oss.qualcomm.com>
References: <20260722-support_vendor_hci-v2-1-132b506460a4@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8906607326569971594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:4057
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8906607326569971594==--
