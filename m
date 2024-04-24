Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2515ECC7
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977957; cv=none; b=AYxvBOgPDvsHx8NKyFgwjROFMeZkWJEAU2OIXOzusN08eaQzG2ibjhFOSa/67EMhQun+RNi8uv6rYmw8XFZ5WdbgL2lQjijz9f9hEklaT4IIV8lhU/bUpeQ2V7nRzgyG3/YxDaFkxyvxar8xQVTEYnc6Pj0t+cZ3CUypwzr+8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977957; c=relaxed/simple;
	bh=9yqq11vxguLJeSCKToKm++hchq8a9oGhhqmKV/TEPUg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nyAjRmukbWkgC6LWaIiKLRMZN12SDM6Nz7zyw0VwHMgtuj8zKYRGMkNDHRHZagZbl8D3LIXanLhp/v1dUesi0b8/P6AbkoIgPBxoVCRrF0ibY/fZDY+5MpVbdzRxxEmsk7ko/ClkiUcE4R6p0NaWC5g9KU13Edk8lxcwrj/pkH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXRrARe6; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXRrARe6"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7906776e17aso307630785a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713977954; x=1714582754; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0YyEI/ijQ54wfd1YNJ2bVTlxpZ+7iszYlKwbgRCvdwY=;
        b=JXRrARe6XwcCfT7mPlZvJqgfHd5o1DHtE0sG16lHf7NeTn62gsRKMOZ7snoSIp2jQS
         cRxwiBRQjeAuFFHWLxACxV5bhynYkYgZWXHRwZRPx4lboBRgGTQiFupJ855/gvomXlxm
         /GIHeY08QaVza7r5aQ1klE1i+JCADZMgUUZ238nLVknCvhiLshFTfkgno36UgrVnbHzD
         +3HADVIHJZhPht+mdRQNOmsZ2SGrB2sI36BF4I230lPASXJ2NELxVVPjLsm5gssE1XYw
         FWy2SyuVtjfS/TO02RR7ytP0qFAnQaY1VSD7AD8Kj75zFEl15CzuKZ/NAclzSHoVB7hA
         z27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713977954; x=1714582754;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YyEI/ijQ54wfd1YNJ2bVTlxpZ+7iszYlKwbgRCvdwY=;
        b=gSUGRLX/76LMSZS9IIHpZDpL34iMPc/NusoRkpPN8xVL6Kn0zFzLxkOGUBDF2Hwzag
         uDKWnR5UjaCaM7arn10BJnyX/gG5IQbon7hr4JER4VcqGj91fiKgcMBIVjU8AbFweTIS
         aRXwvca7fePFOkuAoGxFBEWmTyMws8hnQwkcZp0JOLLdC2ZeBu8A1PLvBJ8f35JZkzZD
         K1E2vasRP3brKb0gOQcm8n1D7vuQUMvLR0mqoH1G9Bswdc7gd5+ErHioAXs5b/qyM5X0
         2Ht10zq7Dkp1f7DK3H7eu5VIEpXZ7h88CSmAY8dE72jQWqEmx7pBhuZkZyyNCMT7Xw6e
         IQVg==
X-Gm-Message-State: AOJu0Yy88wbdivadxVjnJ3KT7PLMFqk+2723US11UhwC38lba9Gf9dxq
	GiubbcRTHOBOfrALKMYZWCVO5b9LMHJlsnWAJvyFPvtdWDb1bvE2l9iHvg==
X-Google-Smtp-Source: AGHT+IET43CyP/CzcogEbwk0fWr4efjqatGvJSa8Xesr2rn1LLAlPorxckpu+9nYG8ppxtPpQ0NkcA==
X-Received: by 2002:a05:620a:571a:b0:78e:9714:b097 with SMTP id wi26-20020a05620a571a00b0078e9714b097mr2510988qkn.62.1713977954582;
        Wed, 24 Apr 2024 09:59:14 -0700 (PDT)
Received: from [172.17.0.2] ([40.67.133.159])
        by smtp.gmail.com with ESMTPSA id k6-20020a05620a07e600b007905e4a1ae1sm4805090qkk.96.2024.04.24.09.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:59:14 -0700 (PDT)
Message-ID: <66293a62.050a0220.66b2e.7025@mx.google.com>
Date: Wed, 24 Apr 2024 09:59:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3037619042028282221=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Replace the global bcast_pa_requests with a per adapter queue
In-Reply-To: <20240424140741.73899-2-vlad.pruteanu@nxp.com>
References: <20240424140741.73899-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3037619042028282221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=847482

---Test result---

Test Summary:
CheckPatch                    PASS      5.65 seconds
GitLint                       PASS      1.27 seconds
BuildEll                      PASS      24.27 seconds
BluezMake                     PASS      1678.41 seconds
MakeCheck                     PASS      13.02 seconds
MakeDistcheck                 PASS      176.27 seconds
CheckValgrind                 PASS      244.95 seconds
CheckSmatch                   PASS      348.74 seconds
bluezmakeextell               PASS      119.73 seconds
IncrementalBuild              PASS      6256.02 seconds
ScanBuild                     PASS      985.83 seconds



---
Regards,
Linux Bluetooth


--===============3037619042028282221==--
