Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFC18C1F
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191287; cv=none; b=n7E77FQqjhxp0O+GetnwSjLPdNgpWJjhLQahS/ByiFKIJUuO8v/qcGbyGIhmTOrL9ifpAJJgp54cxxCC91OnVcM1YIL337SKoINoiAOgGGrTWUyWfzJfgcP7nGvLfFvwhdrHzbrGmzkfP6IctPVnOWpREBGbJq9zREbu9d1uUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191287; c=relaxed/simple;
	bh=YdMKyVdSiiLkBAmabCWoluzebVBHXHNu/1SySTliHAk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TeCxh5sOReAz7oquIkwXTmpj1++LvLha2CEgVSaS5VbO5FJ85PO96ypJoTHgtECM/eS6LIF+hxsN8DmMlLV3wwMNEmxO91/BT1/1zaswndeinRjDXJoLFC31usVSky5mgSzrmLRBqD0K2zZpAPVM0MbGzt+Ry2P1uw7QrUr3rTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtWETWtQ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtWETWtQ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b136c28c46so1137459eaf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787191285; x=1787796085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YdMKyVdSiiLkBAmabCWoluzebVBHXHNu/1SySTliHAk=;
        b=JtWETWtQE8Ay/xe21IpDc/AHYLHSwdThd5PO7fZ2gY9VGKtUiyKZle/xl6fmmVwxKJ
         PtynumTRR850ekYkSX+qAT3/WCtOxA7pJ/K6dARknVjGybdHRtv643GYRYVLE0OLK6wM
         uZSOww2k+WMX+qyoEvk/bjIC5TdmsiANL6YuroC8H9bokZfcJki1VGqyZilyed9ezMYA
         ha13rn2WmFcXxym++y4CyZmd0GJPJkpUfEhNK42IRhx1L0d375jBzkp9Iu69XSBBbdF/
         V23uQ6IYW1JuClDuecoOCFhimyfjurPbAhR+u2P7/MgNls4a7jRzvG1twnvnuwt2a6Y5
         3A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787191285; x=1787796085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YdMKyVdSiiLkBAmabCWoluzebVBHXHNu/1SySTliHAk=;
        b=LpYsthGImhEhbatxZeZif9Nr7N7GV5atYkrbCSr0HmcfLtprwcm6PcTXH1/fnevnxr
         Rt6+/xS1Eptwx/GLbRFmm9ePL7TsLX1HFSjAOjXNDmKz30+kCXqgaFWBbe7GTLQyZURo
         L7E5MGWThZkpE5dzGgkhW5eQP+P9xp9fmGp8e3aPkUt4YArUebVve/wv/8qd9XKsQvh8
         EV1/5jwH1YbAVQseWovzb0knwXQKgFmMqdt94IfN9oelwZrN+9OHnB+duOQmHkW9nYiz
         8uliZr5X5U5Mk3i9uwJKQve67gfc2yvzeIBneRY0bjBI/PvAuCGO5+PrKVNpvzInqRhj
         biTA==
X-Gm-Message-State: AOJu0YzxFc9SmcmQ1iih1CtSVh/MijTHHdG6BTh3KdITHF/X2wxm/r2A
	CIgEGaN1EmPKDf/WbYkUWGgZVej/aCQUrJ1oMp90MV0D3GK+M6WyjeQr6RLgcWgVicw=
X-Gm-Gg: AR+sD13dzHjGUyXIqy/4+qOG9Nwq6fHrDTktyJZlKgYjcfVk8rcHX1rBZIzcmV49Afk
	s4XpMwQ2CtFaNYLdFbdzfwpQr6KgkuC/nyjnwW7BRjx9p9txVa0jXfSQlHoRg2C1jqKK369MRDh
	L113ycksatzene1admv76RxF1s/1xkU15psGsIJBA0zP6yikDtj6sMtLLQVMtrniUPMnqqLdd9L
	LxheNy0/ng6Xtz/bu6D2k6SdTvAsphW3YfAiezeDkP2MvJslSRsM7AQoZJou4e256vwDO1GVInn
	2FI+/n9v2/eyHRS6bGRI8Xkcc3BkWwwPyCfyHu0RC5JE93VSyN0JAQAJeAipmlaCv1CPEZ5BvtK
	XEf4Y+rd10j9we7AFG3Rlqmteq1eQAwCtY6LrlhUScazMXszIcs1g8sNnl5HBymaUZ0INtzhoaj
	nEYvxH9V4GJKWCl3UnKBA+wkWkf0YtCLNsH/tZrZDZBypOeGxfGQjtjfgD5CDhN06MpEXd
X-Received: by 2002:a05:6820:1ca2:b0:6ac:b1ae:6ce3 with SMTP id 006d021491bc7-6b13c69056emr7163618eaf.32.1787191285399;
        Wed, 19 Aug 2026 19:01:25 -0700 (PDT)
Received: from [172.17.0.2] ([158.23.146.216])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b13cf065d3sm3646984eaf.12.2026.08.19.19.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:01:24 -0700 (PDT)
Message-ID: <6a865ff4.26e5e084.2ac59a.962e@mx.google.com>
Date: Wed, 19 Aug 2026 19:01:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8147626780572871633=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, daniel@makrotopia.org
Subject: RE: device_schedule_reprobe(): core helper and conversions
In-Reply-To: <08dc37c0d20896f5dc899a53c857935e91c6740f.1787185594.git.daniel@makrotopia.org>
References: <08dc37c0d20896f5dc899a53c857935e91c6740f.1787185594.git.daniel@makrotopia.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8147626780572871633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2657
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8147626780572871633==--
