Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393B1D6DA9
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786224247; cv=none; b=rYumusweEusCrCzGPtb0UJIM9YRTtFEFhgfR5hkoJ33pdKojLqaA96bzKs52fT4iurZVoeRvjtwbxvA5tlTZOy1U4Ue/wk+MBdvuBxKILbYwhHu/J9O7iG6W7r0IoHLOk8Z69JqlhTakGp2OX7agqPBbh2kebUg6uC1rJA2bfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786224247; c=relaxed/simple;
	bh=vRWtOx6HY0/uEGIIXPgrTN6ozOZvxHvcgzWjmrYMgAw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X6t71Y2Kytcj+vXduFtBSghmX5NgbzaqjKETqDLNXYwQRbEppQTyqF79UfMS2w0rYRgwBHY30LLicva0gRuSLL0usIacVOKNUaO7yXlhlCC1SrlQp/uTouAqF/zuROgiKqZq1Ulx6h04H7+/bKQJMRTQHEwXqoXEMVkM2LveWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/9BfGxG; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/9BfGxG"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6acc15016f1so406910eaf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786224245; x=1786829045; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3tJq3lyUxQSBxzlZkTbMZ0dLv4Bu/1zpKbVwXrL+398=;
        b=P/9BfGxGR1pIQ1tYXdeRAjjx0+DOGj3mSkpwH2lv6nnxjWb6P7PajqlnhwE4tInNOL
         DE8uvFtF24b3uNaLgSLXxI3+rPJVVzp/PtbVNawXCiY88gHm8FPaL2x/sdKrgWZ4NIlx
         sLz4/QpRs+MfPbDWwDQg33mCnqVQ4BpIhnSsydKCG5zWWjV6SoVJRLqyI3e6e6CJB1A0
         8etanRE0k4l7Gh0uFguc685xvmZzI1WV0Dq3NPOV7+JqQ9NZLfOaz99R0/57KDlz5rSZ
         Zo0cBGZ+8000dRCNvC4liXWsWeeviw3t1wzSpMgCM7iJJULCQXyclDNOP4qPvT7hYoWl
         pxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786224245; x=1786829045;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3tJq3lyUxQSBxzlZkTbMZ0dLv4Bu/1zpKbVwXrL+398=;
        b=hMctb6bZTQiZVE7R2PQgsfc/v4N2/LrbFPjA926pvHO2fEUZ2vr2RcTllrnBuFlPvy
         5rlYZAmVFLHeNfk1m4b+8XDBJdxdW3tRzECTjyRy1TuOoyKYY2sNAzYvDslpbQGKng/L
         I4RM5I5qOHIaTGBRHjAWrpM+nRS5TtjdcGkk3mnhPIfkiTWwxsGbwBcc3dxPbWU22jdA
         BT9xqQ8NarM2WeVNr7CoX5Nm9vIlb+TP9+GEBJyhw9qJjzL3A1hn7dQmV3SC+xFaetEt
         eQ22RJfN1nB68Ntwpr/3k3Ekga7WqLgzCPYYQhg48DfXV456SveQHzSKxuDdR8cBWcQe
         Y2Vg==
X-Gm-Message-State: AOJu0Yxsi75D26nbPRd9WYtrs1UmK6rhGzW4gBcEqE9ErA/SBzjhhvea
	ZDL+nBw4WJhBiGpbCtHwrXocdkrsaitAUy6Q1dqWsowGzFffJNVyLySnp/qRxw==
X-Gm-Gg: AR+sD10ChZ1fpF/9ToYteKu5Oam4FusE61XC9QRtf5lbgMp8DJ5tfAujJKDb7xuVaA/
	R75NlB3L9TD/+LNaqOWeG/eiHkS4n4hbIhhR5W8IZjDMQKtMGuOnCAVKojLvNkYcbHSuE95K2WS
	p9TTlgRQwVo59FAlEM2srcq1bv1x8fUsp0j0BjYRv5mekSAgikY9mjyhJDn6mkaPIQ7I2b5/eR+
	H0wDJInYkS7X4jm2sHNTgRsxwUNx/Rb75hq6Krlxefs4tGekCqiQkfD3NFZ30HUFUHHnRebUKcD
	dofC7BJcEhVyPTj8oe5JU4xLyylZ1Sr1Tu2To8a6hjE96DVrl68V3UXZmExYLY6uQIVGsCff8vP
	3xPqCR+cbGVlybFhnWoMoxuorLediwJ1yhnrW6dRkb3d1cRB3GiUyVcYuhXI2kVr7iVKoK3/pFO
	hscwAmXQtSUiY3mY0ED0ksh1jLhItNeUQ7rXD+BzkuAAKdJgvO6nEpirwNLQROdWjy4QjQYx6yU
	mMJeQ==
X-Received: by 2002:a05:6820:1891:b0:6a3:7341:f6ed with SMTP id 006d021491bc7-6ae96c10050mr17868891eaf.1.1786224244849;
        Sat, 08 Aug 2026 14:24:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.253.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1d77417sm4696203fac.12.2026.08.08.14.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 14:24:04 -0700 (PDT)
Message-ID: <6a779e74.3fea39c7.9eb32.23f8@mx.google.com>
Date: Sat, 08 Aug 2026 14:24:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1603130957459722653=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, z4pdyy@gmail.com
Subject: RE: [BlueZ,v2] client: Avoid scan prompt when discovery is already active
In-Reply-To: <20260808200806.134373-1-z4pdyy@gmail.com>
References: <20260808200806.134373-1-z4pdyy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1603130957459722653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142780

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      18.13 seconds
BluezMake                     PASS      657.32 seconds
CheckSmatch                   PASS      271.96 seconds
bluezmakeextell               PASS      94.34 seconds
IncrementalBuild              PASS      651.69 seconds
ScanBuild                     PASS      881.35 seconds



https://github.com/bluez/bluez/pull/2392

---
Regards,
Linux Bluetooth


--===============1603130957459722653==--
