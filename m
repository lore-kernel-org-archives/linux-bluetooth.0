Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A351419A4
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157621; cv=none; b=AjwJjSWBlPdpx3lGgm4yhQIWxqcBE/iBuugDngE1JaskXNd+3DMeRPOdcizFfUrxTrSxG1ncVkKIvWtTEWcJ51xihSrt632lJCZ7MJo9CTZNQgGwRoI2wkmJUSmGRdmClgUNPU/sAuSOHwgAgYg5o43JaS19nGj3cO30Nif43yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157621; c=relaxed/simple;
	bh=l6SGgt4u0NxVzZqg/M7f6RGURFVeGelpkHpkK1gNpgw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=au6qmDFizU4GXLJ6P9NZ8DVuIHb0AfqdZGvOAY5N7lQfB9eSzah2znyatnvQizspHAMu5t9GMQroTkao1ZPYif+uqL33egCY6DNiLo7nru1WK9exGm5G4FJX+kxGnmj6adDZyfBV66sucQrWHmLFLZYcxwdAZVuO+tBOpWJgbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa4IZ+uO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa4IZ+uO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9387752a4d0so196084285a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 23:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788157618; x=1788762418; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nbSXkjxyaeBA9Y+cPwoCWShlpkkGz7hGf6kFF6TDUwU=;
        b=Sa4IZ+uOQFi4+S2OQrRCofiYkeaeo65+ObWIW8gRsh9UulkPJE0s6qhd3N/lqFWhIo
         kOqmzizOAu/fq2dp2SDNit8a87mKvDdGAVPjh5KKtCAPeo7MyLzU6UEGhQ6MYkokECpa
         qeSSCO/13vrDLtrknxY9MJD7oVDtIKP5afVQsi3s3TT738Fxcg4vTlAIt1t64Imudlrr
         jbn+BALRh8d9SGBQfM0LZ/xaHwYCVUj84po1H+MMasUhHY1vkOcLK1YZW87rve9ygY+l
         F7YOrlRCspRJoY1b1AMoswvmiZhLGRPLiPPr2Ioo/GdqPmxPmqUjNIR87goKgbq9Xf65
         N6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788157618; x=1788762418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nbSXkjxyaeBA9Y+cPwoCWShlpkkGz7hGf6kFF6TDUwU=;
        b=fnzunXY72hyhUjETjaubdG7nQd7SR2aDjp3+K5FerxJHx5FEakxDrc5CwkWNGbzd8G
         pliZ+maBMnfc+pRtOVkF08pYG91o6fWxuHrCTcX1gldWLgvk8+DuZRTVKFGiy3tPy9tR
         apGqoRxGk8bb3UT06BEnP+muYtmdZ72hcvnq/VWtY80J8l8FxYfUnbbRXTjOIKwq9EkY
         Bqi3QgPCdMjq7AlBllandJwM5YQp7wFnY5s6jAMbcrXyDS+3zURaEIlCGGTMsP/4w23h
         ryakTIC+JFRLPpLc8o0aSKurpD+ubjf0ot9rz+tckxGcuVmL1i6FD22+9u5uSccUuKmE
         SZbg==
X-Gm-Message-State: AFuF++n3DiJjPLIBBAhivt87m1ACQ3UuAIv/2Y+NnEFrLO0fWqWxGpie
	OZon6xDw0KjTCde9CFMvjG1Jde/a+N/ynIapyi1cUgCF9ph7aGM2CZreT8GH/A==
X-Gm-Gg: AR+sD11xQFboNr2v4PWR25qRyM/gwSwodpwQG2MdHVl2m4ViyoeXQ4Fn+K6wJ0mBGVc
	sRJt6q7L7qUbGdJFfpg3OvussIN9D0d/rQ/9/sLdiTRseou8m9mVOFPRqzuiWkyC+Kmq7CC6N0O
	6WJ+3gwsZF1Qbq5CqOmcstoMAJ2LpSIgvYrm3QjK/U7zudT0Isn1H8HHRuWZsbrIc+mJlib72Ib
	xUVJ0wLP7fzXdepQkzZP9sMmR9P7ue/ZYAVrcJT9k1SHKIhI4jMolKY3lv36jaPqcMhjBiW/rYG
	bekZ/LPTplz1hYQqCmxdYePumluefKHqKlyk98HwLaO9/32eztep9+p0+Ey4GMINsoXxiiHyIne
	1e3VLFUifs7Dh7yqIRwW4QDsjf8lDmK+JI3iSWA19UEXdsBm/n610zqlWeHIjDT11SG9kJmla4K
	UcqxC0G9VJDuzTtQOmpKFqea0jvIYyfAvE5vJMIV+EIbwGOtuSBOLnBUXMZu4boo4msg==
X-Received: by 2002:a05:620a:711c:b0:930:9585:e08e with SMTP id af79cd13be357-93942827695mr83413885a.10.1788157618367;
        Sun, 30 Aug 2026 23:26:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.95.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173a735asm719949685a.28.2026.08.30.23.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:26:57 -0700 (PDT)
Message-ID: <6a951eb1.157e68eb.3cdfa4.5a48@mx.google.com>
Date: Sun, 30 Aug 2026 23:26:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5991076315617897113=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lijun01@kylinos.cn
Subject: RE: [v6] Bluetooth: pm: use DEFINE_SIMPLE_DEV_OPS for pm struct
In-Reply-To: <20260831014638.123808-1-lijun01@kylinos.cn>
References: <20260831014638.123808-1-lijun01@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5991076315617897113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154034

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.72 seconds
CheckAllWarning               PASS      29.43 seconds
CheckSparse                   PASS      27.99 seconds
BuildKernel32                 PASS      25.90 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      469.40 seconds
IncrementalBuild              PASS      24.71 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/669

---
Regards,
Linux Bluetooth


--===============5991076315617897113==--
