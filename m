Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778CE386C20
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711404; cv=none; b=baxGx+rr0haYX9rSqaskJPPg/dNI/l1MVd55zX/j/vUHGRHXky52O5lM+xXskWjMh3tSfRVmr6kqeSgZXqsEVuE69iKvlOqdVm6BnUYtOvB9Bun0ctD6ESk64DNSrcB3xVkm4SxvCT2TTLMPSwn7Hw3s80yiECq0AIJ+YSveGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711404; c=relaxed/simple;
	bh=zj4V2VW6oS46SSjH++Kt9DNkJi5utDtzWBoNI65MOEU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VErVZkAFar4p8GmPQhEnxeNqtUzwIWmC1K43cY0d3KQJtpKu9CZAjsRZyrIgn3jG2Dak/358ZuMBHyYVrABsSVUeBOE8lRYN1pXPIft6D+Tdn3NstozWkkl/rVoEpOfu4Uk51gfMoBvEOzmFmphIoLhjMFBH4JuvOnSMkJ4sGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sROu2dmN; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sROu2dmN"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f0d6853360so10679816d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783711401; x=1784316201; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RDOXiVrL5DTG4JNMJS3KmbWV/drpIdnuXnDZgvBonsI=;
        b=sROu2dmNKeYSHxvzE6LHHxy5t9AFD8PnWowjNXnMK6aQSGYPfRP0zQewvSU0wCCeEr
         blU6APhnTwYJHoNX9WvtJ1vWl+b+FhbeJvRYsI1bDuiUyiJUzB95BmolIKe7KjD9taxZ
         umP/R7ftYtd1PaMwXjhbbFeLLsXuqqP6x7S9yBi146d8kVW4N/0dJXE/U0eD+Wb5i4nG
         6yv/cTAHo90NB+7Xt4DRnkgVOuZzREW+NMQRresD498sUyU9yftzA6HLmhtb9V24rKoY
         U8UvVfSHyYxzJcjtDBrWMtJazSjC9Tf0nJ15OqcLD2DjCpSvOD9HAm7LZbjD2k15vakZ
         yhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711401; x=1784316201;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RDOXiVrL5DTG4JNMJS3KmbWV/drpIdnuXnDZgvBonsI=;
        b=nNG0mF7nPP2iKk3tTmTJbTv44ochzzuQf7vzTkZEWssrFtfcKTWaEY/IdcboX1DvwA
         vZLG1IKV3Tc8zhhiavi2qSASX0ar2hYww2IyItPXee0Jmez8k+RiTZuM7Y5ySdMX90EA
         RKvSBCr4qMYdSYOriS87A4n5Ae6HZm3rmhtBb/GFPKoETUhbhIPAptXJUBSF4IzYqnDC
         YNyksGgKN0Q4UmYdGJ7Vc1R0rULrCb7z9dILL0HzFmGZFWQoYTjxfqVQxStFw2yqQvwi
         w9Lxs4cC6LQCZLnQaEBHAEle8vkQmRnM3peSGLVFQjSq0eJPMZsetaYNElvGs3bLZ5K/
         +GYw==
X-Gm-Message-State: AOJu0YzZn3xbPqInC/wO1H1zXGm2UXNUDl0YHC7XCwM9NVZDULbbbDyC
	ijUGpT77EfCtGH2KrLcUUqS5f8eWM1TuETHenV5Cv6R5KWzJ2tJgk6upV/1TGw==
X-Gm-Gg: AfdE7cmYexd3KgV0JlVaRT/tJoiKHw5Seico3tZ5F6X6/R46b2JkcZO9b1CiMxTvXIG
	tLsSQ9KxvRP46cDJ7Q5OGWp1iBEYJh394cpiYH2sgHkcohqp/JMJxJeYZHY5CzwUXlAW/AXeC/Y
	UOPJDhbAViY7CQy9c55Jm/sBdhqh1gjdbCbotu2XUUKplcq455zAJtqfq4bxdLlhVr/Qr23B1Hh
	o9NhgtEJSquMG84U+rpnb5KEE7AmZ/3Um9IvyI6iuGgjAek2+JCO1N4HaFImy6Rf0Rd6lRRrMl6
	lt9SZ8hb+03NtL+XtpqdumIeufDvac48bhzDj1xGXy+s3rmLiE6SmVIWEwvqBYSk07R3pB/OZwQ
	jyPTmzsozr0NQEa9mLj4/4jwFN1BixUBk3PUoopAU96IEN/uzCSXZDyp4PijRN0YYhZOsoV9qas
	2HXa6JdbbA+DKMf2I8KUQ=
X-Received: by 2002:a05:6214:21c2:b0:8ef:ec2c:6b70 with SMTP id 6a1803df08f44-9040226e2acmr4826346d6.53.1783711401003;
        Fri, 10 Jul 2026 12:23:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.116.72.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm48125656d6.30.2026.07.10.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:23:20 -0700 (PDT)
Message-ID: <6a5146a8.a374d419.cd3a8.02dc@mx.google.com>
Date: Fri, 10 Jul 2026 12:23:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6225410186341473022=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: btrtl: validate firmware patch bounds
In-Reply-To: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
References: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6225410186341473022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125523

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.55 seconds
CheckAllWarning               PASS      29.52 seconds
CheckSparse                   PASS      27.83 seconds
BuildKernel32                 PASS      26.25 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      508.77 seconds
IncrementalBuild              PASS      26.24 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/423

---
Regards,
Linux Bluetooth


--===============6225410186341473022==--
