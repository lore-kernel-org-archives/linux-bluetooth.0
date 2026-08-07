Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460E3D524E
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090296; cv=none; b=TUUCyH5s/CY0xVgPOXefDG3BM4oMgLdPprfyxsicYHk5lLryzzCUxpwfqQu6U+INDP6x6RwWCspnu1aK39ai9u04FtNWarzHyLSX9fhe/uLXRlpKBr232ujB2n+VwWjGNe7OxlqPcpJq5IH1+ZhH0E6lFz3qo9Z4GfPTZDYCzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090296; c=relaxed/simple;
	bh=Dv7WnhteWOXWmtmGZViqHSC818bo6d90ItqbueelxDk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a+Taw4E0p9zxexgFLlJQBvC1scOn2mXrwew0X3hmb/hpQcO89wNymYrKSbhkefyE78E4hqROy2PxMbiyow/DNahe7bX9cbEqEOEs3p5GAGkJolSqiuC988jYiAFYuqHJSp3ypc43TSrOmEOn8zm6X9yFlsSF9s4aggv5kBZltsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMdWGkre; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMdWGkre"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc891373e0so38000775ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090288; x=1786695088; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dv7WnhteWOXWmtmGZViqHSC818bo6d90ItqbueelxDk=;
        b=dMdWGkreCx0mMc2klPyMPWjXyLanL/epecmLXYJCMYX+rGICRwtP7pdf5ZEDlqzMUR
         uldY0QXZE4IK80Cveohnnlch4NmFSUckQyunYGwQfii0hPx/5n130aTT/PHwPcHgezzD
         atKAXe0L+ZovSzCQ1cegr1AINvlzQ5qV8acZeuEfFksK96NdYh6Xl+q4n6gdTQ7/5QA+
         Qk8EWLiuOUwq8yeRIfzHE9OKZnGzc8AakuUIOtrnY1QuEYmzDsNOrWsa/PW5p8JcAX3H
         AnAAIax5Bxh0hKAWPs/b8+NLv1P8MzPRGXfWo7pEjj3skbCsHQAKN5FNoZtU707Wcy+I
         IHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090288; x=1786695088;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dv7WnhteWOXWmtmGZViqHSC818bo6d90ItqbueelxDk=;
        b=M+d0JMLLt5mGZ5rDX0DHJCENVeIluPxblkpNZcRzbXaKz4mkURglDaQ/TkoyFIYdj2
         /qjZ0Lp/RkB9sHnLbkYGzTMFbqBj8sg/oDaD2beNz+Mtqqe3vMN6tRYk1LSdndybRBrI
         Rgcn94uc2pi4NBaAZ764sgwBNwUl8g6B2LyO4oCwjKmUJPP6jcZmKYoqUtCSmpwk3tCu
         M1/pxnPvxv0eqdBk4lDGXS2vRddBQ0ztYFxAYLH5M1hNiHrv3OslDHatD5NPlqfmpTuL
         T1KCbaA6/6b+COilRPSs4Tb+ajgm6qn7NpFIITx4ySbykW8lxCxLKGNhPa/kY96SgLbZ
         4eCQ==
X-Gm-Message-State: AOJu0Yy/u4o44JLoY7gnH4NVZJAZQyO8eWZzI7bghnwdWnorwiDqtizW
	Ow5CfK6gLkeKFNwlXCL8KVlcVAb6fsoUpGjtVRZpeJkQUXFDplk7mwlO12o+x4Rn
X-Gm-Gg: AR+sD10Vt5ScuOmDNSlUHk0GCELQcHms5iAy0Io4VU0LDGTT2+gKA0TbNysIEsFYQMe
	BfowX/8QoR2Fwnvv+z5OD0RJbdy+DBZibyKFeRlg+WxQsWUDrsABLjhkJrP3SD/h3ONTkqo4/35
	4OqWrSYi3E484jGTD3SRzPRRkBXyf9uQKlasMV0n/AZAvBUXNDLCAkaeFCKWOncy7Lla4DtQkpH
	SC60ezcpjDg6HS9naZj0UC2E78JRx/GTmAsbyT2yOAAcgy3Ihws4I9qxt/TY1c8G3I6jE9e4ell
	Z8Z2EV6L4n8/TAiPyLh9ceh0KT1Eey0fDGXRX6MUltnN6vkzWqbm3IBInuzwj+gXVbMFp4K3OQf
	ts5L8qviOEfdjQFd4gN2JPWQeDBhO4LoFIrnIzyMJQbg9vYGJQQbPLcTjk7QHYxxOcauukhWE1s
	SArF0sSlAvoYidFfLYGM+MnwHtEj3INaqbjMgdlJpTmCTEopfnmaorNwivHoKynC8s9nW6Cxcmw
	mg9WaRtQw==
X-Received: by 2002:a05:6a21:6112:b0:3b4:e4f6:4f15 with SMTP id adf61e73a8af0-3cb85e9922cmr25645795637.5.1786090288280;
        Fri, 07 Aug 2026 01:11:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.224.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88473sm4355880eec.17.2026.08.07.01.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:11:27 -0700 (PDT)
Message-ID: <6a75932f.881e6cae.4accd.5c26@mx.google.com>
Date: Fri, 07 Aug 2026 01:11:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1330576160286890155=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, baul.lee@xbow.com
Subject: RE: Bluetooth: MGMT: fix use-after-free of struct mgmt_mesh_tx
In-Reply-To: <20260807070916.85771-2-baul.lee@xbow.com>
References: <20260807070916.85771-2-baul.lee@xbow.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1330576160286890155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt.c:2429
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1330576160286890155==--
