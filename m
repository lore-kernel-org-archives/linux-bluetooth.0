Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA52F872
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142364; cv=none; b=GmnpmItbx+V56KG8zPcNPnhWf9L0hT1AG00X2REiiDJm/H8yYsWSjAyPqJPz2p/9ov1zNjz1AjV2/oJDK3GsPfJZgJfUoSNOjJ17nsVZWmNU+pn96V2Cij5tC9k4zQJn/EssgkAjEQMEvooFqclQaMvH80Q2XGXtm713qkeehRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142364; c=relaxed/simple;
	bh=XtSvLz48AlarhVsMcWwP/ESMeB8tfsu32hZHIOfFuVw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fzfJaH09rXVU6tb/3bGIma6WAmr0JgzipdUlXUK3zTol/tbiLvyuXNahlD64oJEHcyDQ9YHdtAy1UrgAdAf1qMjj/deMFG1MyIpcIeGK61Qr+yo00KyKnj+HvZEvxZAmfIL8PgH8aIUuLygdP2emXIjFJA1CSsTFNaYH87gslzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOxYU3IM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOxYU3IM"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92edb12cdf2so152785285a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785142362; x=1785747162; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qjM0UGKNUOFhAgS8Nr5otzjH1wWmy2Dpxf1XA58dFiM=;
        b=hOxYU3IMsWFtZwI0LpPeDleaSxyk9tS8pIjQOyy489CCHHeCOL48jQtEDTuLVuq9DZ
         UWDSwGLRT0yCCTpndw6VkMuYAORueWnwdSIzLssMDc/qmJGkh669HCUtx6iV+QLEXwEZ
         PJ9kqirGnfJrJZFrHAwLwAvsCQKThVKY3g/FCkJgV7vTcCesO57VMjGYMQN6uTT8i+Il
         Q4hXqd2E9CXZ+I+Sdso3C0b0nYVbk+nPWNGP/34kQx6jpvYVj7+dq3Y93XsMKg254jfx
         lUgnKBVwSJbyyw7n2+bnHaxSX9CIY6+eg5JtcEoplKL3m/BXE22Ag8EdIGt+yiAsRv9K
         dJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785142362; x=1785747162;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qjM0UGKNUOFhAgS8Nr5otzjH1wWmy2Dpxf1XA58dFiM=;
        b=gkT/Gr+Jgqfxj+J5rDRI7PrOUBT6NmqN6rNoR0kIxB+sP2tCmNO3MZOiUkwAL15pjj
         qqQKvoGB1E6oclTQnQS9bdbF33FiLVvctQczDd57wHRANzL9nDbhcYt72izHR+t4PL63
         6/+CY1P9IEtgucpgzVOMJP68no9i6gIkHwsU55NPh7gNzi9SNC6xFsgdvv/IR5Qtut0u
         F3qH1CnT7YbOJ0Dm2N/9FGXyIeL8HgrUaaaPYGYlJydH+lmrVSCSSUmWI9Iv4PPA76Dm
         UZ3ry+e2O3Oem+AdREjoIXfTb4vNVYTOOWIO01Az9oN5gvNS/W5cOxEMgdTO8iasMxEt
         +8Rw==
X-Gm-Message-State: AOJu0Yy7EKXzZHy8o1Viq4egGX6OoQSCrv0iOQoYmbJ2leDZoe1cTsMv
	4ZcY0pyQzChqMh8WGs6Crictpwt8beGX1Sl4klkc+XBoUw+fMXxWtwGe1bW6tw==
X-Gm-Gg: AR+sD11wM56/dE3IESFWc282QZSkEl+04dBwUbdAKkOg8RAPCmjfZW3sZ2rrPIOchOB
	p30t+jjViww6ubOyDVrdMJXdJWXXyjQVgaeajKpNPs9vyue3thBY9Y0X/J/Tfm1G2p+4XnSVkia
	1OKq9qYLqttrgs0HeZz8C+Sa+q5iW7kVNMeiKckVlpgvse8rMRdGOWCYOFUMxaqpqu4yvffKlrR
	yTklQumXDyhBXolX/tP7s0hcWJLBxYsdj0zocqQaPpGXEOBbdWkk/O/SWSC+vrrLVj6VuLvMrdT
	PkTQxGDgFaLsUNDPL5m1aExRtCTr5U77Kq1NsPM8HPt+zVaGzhIMM1y/PuVvPdEMVaYbE2CfTqM
	jSiDdNo4L7qW6GTBTVxMy+9OK3x+U0AsvygC1qe0FL2us+CAFg5lwWKKwIkpivih0Ai8Qstbt9p
	gJGFn2Fg==
X-Received: by 2002:a05:620a:4050:b0:930:a06f:36a0 with SMTP id af79cd13be357-932df7514c0mr764470485a.83.1785142362331;
        Mon, 27 Jul 2026 01:52:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.18.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de6729ebsm571507985a.42.2026.07.27.01.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:52:41 -0700 (PDT)
Message-ID: <6a671c59.d5c1a6d7.130cb8.ba7c@mx.google.com>
Date: Mon, 27 Jul 2026 01:52:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7144681676318208338=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: RAP: streamline session handling, reflector setup
In-Reply-To: <20260727065954.1053484-2-naga.akella@oss.qualcomm.com>
References: <20260727065954.1053484-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7144681676318208338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134915

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.60 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      574.08 seconds
MakeCheck                     PASS      1.03 seconds
MakeDistcheck                 PASS      153.47 seconds
CheckValgrind                 PASS      146.38 seconds
CheckSmatch                   PASS      295.25 seconds
bluezmakeextell               PASS      95.22 seconds
IncrementalBuild              PASS      504.70 seconds
ScanBuild                     PASS      889.55 seconds



https://github.com/bluez/bluez/pull/2352

---
Regards,
Linux Bluetooth


--===============7144681676318208338==--
