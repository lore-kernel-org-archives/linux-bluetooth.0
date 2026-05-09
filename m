Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A252BE656
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292879; cv=none; b=qRHdSYLVQG3kjtqty+JZ5WNxOztS8asr3FgiFVbh0AWnFIru/zmzYCojCoAub5pMKTsIAe8rcXNH5YOnQbIHRkTuurm+nxc4XuM6Dv2PoWYzgoUMEzwKoMJi0Kp1Ed8v1XA+t4xcNEY2VZpwQjhv9YpTOKaGZppIkY8ZK6/y8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292879; c=relaxed/simple;
	bh=BlXXPxODtBS8eeDnc8bmmeuTkFQF2C4EfGdZwsf1vMA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jT8K+ivmNTBIQ3zNE0pKmkELQnzJs68zGS9O54TKdGmYJ4AIGqSyPVvt4M+YeylmnNkXUUjIY3WIENvzZxW01DnVpXZ9Z3gpwdEo+LTJOtdU52BupyQHIlGBRQ5ZJ6TVptavDC3VfPpqMgot4nwRb2CQ6vtluMwWrVSuQuF6O3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyVhhR9N; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyVhhR9N"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c15849aa2cso3390367eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 19:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778292876; x=1778897676; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fn2M8IdrAMPfV8M8KwZvDkJBU7XsFASy4uleN2Zl6kU=;
        b=QyVhhR9NVJNDdmCdCtC+kDmzqgNjQbbqkcAynW3gkyZ3sFhXkJC6nV4In7M+NKx9Iq
         KTaQQbRUXmyT3EUwuuov0EZci+TGrM+heneNNy8qwUnTEb6jHJ7ERbF4A77f/Ebq2/A6
         NWXCURPwuwIpVT9QaKuyORC9aqPBCBxrHXpqAGrsVm87xR/jS/Dc9oq6ykwmlPG3urg6
         yGPaX8CG2wtmfnyQZPkH8RX+qtrMoAaWvvi/wmwqBdURqR249sEulir5Qvbret3OIYOH
         VtBfo90yKF/vv0Ag8gC/TiyACKFTGfoal1ICLCjp5xAJGORh2ekX0McjvfcgJdn6t4F+
         L+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778292876; x=1778897676;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fn2M8IdrAMPfV8M8KwZvDkJBU7XsFASy4uleN2Zl6kU=;
        b=EBhx9Hwc+HcGd78cT4kqx0F70TU7e0IXtSCFDXplChVhcvtVzQ+0uX+6EYFxVJcGnV
         +A6jn2gjHxXEF8bjpUtenqzLp+pip6TiEa+2J3JkWjr5Xu7r+S6XD/MdTA2IsdRgv6di
         zdFTfMu1JZtJiqoFDdChedxzzLwvSmz2MGa//C6pgpvMBmUMhy0JDI65aLrMhKeast9M
         P+bguoab0QDKLowcgaMr0rtKwl86v8MXBdLl9VEoFeHj3Okiqo0Q6sHMFIsWpBQpVs0O
         4laYzpt4wijrjgg246I8uRXng2Ks7Y3rfaW8ZxaD2fpQjT88q1W6fmkKGpyCixvd5k9z
         CLCQ==
X-Gm-Message-State: AOJu0Yz65PMCeENpBzwTcq2zbKR2t08tLxa0YyMFF5fzb8kw91Qs5B8S
	U0DpW3lNmymupVB843X+CIKUBkS5cxbJBinV9S6zRi8jzytKPkEcMSR8iA+eMQ==
X-Gm-Gg: Acq92OEXxVGyQ4lT391mbnSB82sn2zzxBjx5RUsqKEJKAHg7BxAmJreUiyM+5SrFC/R
	+oNnx0/3N5bRgANZVAigmo9BNBt01VM5VMY09FYgs9ZJs2lbwFLNBMUZlq2tJulC2htMADTOQg4
	hvgqFuFa1aSXm3Gx7HVPqBWB7U1FoSdqtq+qQPg9PRUnk5xcwC4WSi6ti5e/hhs7bWvLWUVwo2T
	wXcG1r87T2+wP5WuV1XUDvSGSsF2UUuFvdm8drFst2bTmGKGnjKIMD2xDUD7oas5aVXbEo9h+n1
	lN5IooMLCthCXK0NOJQ+9gH6nx8g01TRTRmReyp38CLZM7YKa7WjtBTsmflp51dFxZhV4WI6exB
	3aAKLclRmMqqLOnbCA+kCc1DxNfpaHBMOaVYSU9DC3yCb2g8nQ7FHynwqSClmdVnwnmbyrcVJ2B
	SpgQ1UeOLeCbuD6Jdq1aN+q7uFMK+KXJRoDg23dwDqLf4=
X-Received: by 2002:a05:7300:6d08:b0:2ce:25be:c8e8 with SMTP id 5a478bee46e88-2f549f7c307mr7538067eec.17.1778292875642;
        Fri, 08 May 2026 19:14:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.209.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm5443411eec.10.2026.05.08.19.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:14:35 -0700 (PDT)
Message-ID: <69fe988b.050a0220.2f853.3ca7@mx.google.com>
Date: Fri, 08 May 2026 19:14:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1716516543025464397=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@prestonhunt.com
Subject: RE: btmon/TDS: decode org 0x02 as Wi-Fi Alliance
In-Reply-To: <20260509002249.2771777-2-me@prestonhunt.com>
References: <20260509002249.2771777-2-me@prestonhunt.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1716516543025464397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1091848

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      643.92 seconds
MakeCheck                     PASS      0.89 seconds
MakeDistcheck                 PASS      246.11 seconds
CheckValgrind                 PASS      218.86 seconds
CheckSmatch                   WARNING   346.88 seconds
bluezmakeextell               PASS      181.91 seconds
IncrementalBuild              PASS      639.76 seconds
ScanBuild                     PASS      1013.45 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2000:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3909:52: warning: array of flexible structuresmonitor/bt.h:3897:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2113

---
Regards,
Linux Bluetooth


--===============1716516543025464397==--
