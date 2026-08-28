Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9912FD69E
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879435; cv=none; b=RSGilGXzh8Id+KDPnoh0A1g5e65qNpTKpLJu4Q2MVmvJKr2/1vLOt+cSMxJyD6XJRrOwBlEw9t2BIw4OZj+be2GWA67rBPruesLJDvUcW4C1SeS9dXiDB48hMSfcf5+ymOSK5rLfZ6NJv+1S1cmEJLiyQSveVSTZR2fTLaOPjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879435; c=relaxed/simple;
	bh=iEO/mBrZbCEEndjthpsjpeSVJYcM8igAkPCMeMM9DSA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=scGMK4w7syUZ8kqYXTKI9CnMXKEC7xyJKJhjOsbrApdBPe+FcPdOvb+ahg0E+9CieKyNVriLGk3shVZlFl8ujRe/0AIfjX7ro92CT7KasSWmQHQBWJDgeE2+nFYrSwXAWpYjLukJXL5djrQvo3VRku5asH/5NwyB6g4LXrA2Jno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUTb07gL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUTb07gL"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8568e3ed034so94758b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 18:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787879431; x=1788484231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BpNxxNfa7bXPAQ2sH7YwbwC5onDu7Jss59xqVGn3zZE=;
        b=pUTb07gLsqNVuw4mNk8qBfud/2zovK42CIa+hoVEQdUuaJZykoulPAZ+rT0lvnWXDS
         mInz6/MwWMOK6yCNlSHk3FgtCry8X7lbwtG/X8biwAwXs85iEI89iHEJnZKsa1OGFsf1
         o+0uXzyX6idz4pn+5Nmkg4M0keGLgIQ0CW3/uKVjdQcE2fulJWTzT+cHP+gIUXU/8RLD
         3DlavUTMUxKqvHeCrfcJTfJp46FGGIhJyuOWRJSXNEiJi0qLWBTnNdzJHEl5xGCWpUo5
         +IEOQM64UUou/NvsJ/P++zL1RGzzaockt0B+PSWH47WxSbQWO1xr99wgk6Y9Jz73o8Wl
         aryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787879431; x=1788484231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BpNxxNfa7bXPAQ2sH7YwbwC5onDu7Jss59xqVGn3zZE=;
        b=RLTzRmnIMn2s47/AqudCnomLwMfA+kTf6ZcvBPkdXWT78x0QhIyf8nuFwRhGm4rAog
         SnIM0w3CmRTePHpcExl9qkI5XHWC1cOkN6UAxn1FootP1vSg7L32+Z+QnXJ58qU6PTYg
         XMZKWlN8E2yDN1BhXSj3hkxRPYPeX79bUSQ6/xCbXRw/pokqK1a1loDmG+V/ibmqAPfJ
         GwDFBioLZsyZoOrWOm0x5KonnAvoUVrtuMIiHz3caI+6sXleMa2eZ7IQrKctsm42I9qh
         V+ky/voiLS8xeVR4ExmT5BMHVPIU6JciK3zyBPS8fsE/EhRsVwVa6WY8oSfcSHiTVTOQ
         1i4g==
X-Gm-Message-State: AFuF++m6Ht9yGfkPkvnt3a/r2l7rTkyv6EyODNSso/dEAm0LK4+YTfbZ
	et6y8qDYJM/sUnkJpYuFmeZVCw4DSM45Iux2CfjgyDCfs03ZRZ1ym6jISsMbIw==
X-Gm-Gg: AR+sD10mNNttDQXrAw0xYO6ayfTGhzYe8NQ/UCvwn/+CZcJVca5qPwKAJeXeYkY7CN+
	nuWx45FTPdCQilJ/xi30ApXHoaQyYNi7QHAroc4sNX83TZ+gLhS8KLg6oiIPi4A6Awsw8KAbX3V
	CLbsjfdbekQDpm59jhS/r3D+cKeXJekqzv1NO5z/juRK5d2NA5x3fvhz68+S9s+IZqUKFlANa0P
	GybvFWJncNxP7cSgYCH0LhAHAb5VdrDoAdc9iefjgJtwavXxC6jjFiX21789pZ8Vx+Aiu98bFNK
	RiNmDppOlqtwPNK0Pk05WVwSESZBUQ4e6QzE1/nd0KJxdutZyYvFo6seGneGRe3v0r2TR+0G7hP
	cz0JTOLBef13mJq6yn7YrRMmm+PQprYVKo5W/NQsPxUZoPVZXJFHPsguyuJOE6nMBLaB5uGt2n3
	pYsK5pu1Mur1kT7OdVyJym16yh9vLki3gdj+OfO9yRGR+EKmZ7yMTfQJXH0Cum066Lg9Gj
X-Received: by 2002:a05:6a00:1308:b0:848:2e3c:9955 with SMTP id d2e1a72fcca58-8562973064amr5793951b3a.4.1787879431171;
        Thu, 27 Aug 2026 18:10:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.107.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569f49f50bsm63443b3a.11.2026.08.27.18.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 18:10:30 -0700 (PDT)
Message-ID: <6a90e006.d72a6220.3d59c8.dd32@mx.google.com>
Date: Thu, 27 Aug 2026 18:10:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8459838356502991152=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/2] Bluetooth: SCO: require CAP_NET_BIND_SERVICE to bind
In-Reply-To: <20260827180149.415744-1-luiz.dentz@gmail.com>
References: <20260827180149.415744-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8459838356502991152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152789

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.76 seconds
CheckAllWarning               PASS      30.59 seconds
CheckSparse                   PASS      29.04 seconds
BuildKernel32                 PASS      26.89 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      503.99 seconds
TestRunner_iso-tester         PASS      102.37 seconds
TestRunner_sco-tester         PASS      32.11 seconds
IncrementalBuild              PASS      29.64 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/657

---
Regards,
Linux Bluetooth


--===============8459838356502991152==--
