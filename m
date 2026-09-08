Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF01D57982A
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882991; cv=none; b=sQcNNyY5TvcFIVPVtINlV0jIqzd/dctpqW30nm43bjslxw65pqQxu+kaE3E/0P3kuzQYsY+Cis7osLZW9YV6WSEAqwD4ZAWeiLFOVZ/UqUuYp0woMXM5K5QlM1PCVZvwsA7ZysyLLQ3UoAYpTkCyv/hd0JNEuLrFa48d3YtWbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882991; c=relaxed/simple;
	bh=2xI+abD3N9T/U9g4Vkr48W1klG3qrquSPGX69PfImwQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GjSI1Kvk9zKEibD7Eg4Xf4ck95ct4eoMZZUJHPczWgGZMp2VVKQVIv4J9QyQKz3ku8yOCLXY17K6xlI3tRx/KK5T1LdNW5kU3YkoCQUqfMx9VFPPjByYNico5+aLMPSTpwYbDMNxWh6lIq4xcMu8GndJmxp/SmUce6Do3asmrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA0vy8SS; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA0vy8SS"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52f83889a93so49640111cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882988; x=1789487788; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VeU+JHBr4v7EDq95UyWXUN/U4OI1PvVgsYvROnV+nFI=;
        b=GA0vy8SS/ofLqiYkIK/+I9tbmbCg5hxX4SF+JSMDm2Kdn70GgKMppzmbYW81ucPfQm
         s2NT81OsEEllHNFf4JEzKCI7KnvkhnLnrHkcSdjcEaSLsukq/kNNvNC7ZueQMI48Blpo
         fHp3by9Rfax/t6RygiPRCT/LyIui4A6ZqN6vH9RVSXzRk7bSXKneqheIXId3Z3vczkq/
         JDbVLj2JB+yreDzhgLJNlzsEUhyL5b/xO25ZRUL6M97I5OYNYwYeQcEUS54BX4Z7yaYE
         cG3lriQ3IQkcLSiiA1j3BXfXM1gE+BuUmimx/9cdPcDm3+TLLVrtinuHQQMVALt9xjX0
         /3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882988; x=1789487788;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VeU+JHBr4v7EDq95UyWXUN/U4OI1PvVgsYvROnV+nFI=;
        b=rvhT0Pb3Kzv6K9d5SBE0SFCJ8xxEl06tgR/gxb/aYSByYYp+WJH2ET2IprpeY/evRf
         a7zDOP5di9+XiQBGxY0kdwnfrKHTKDvGQzmdwsNiY8ab1ijygD/PViu05rNbyn+bKQNq
         yeiCp6mwI0Aiqedusp7fnxpZXMU/cfI7lsJrxcOYSbOP2YoQOX8nsGx9Zira0rjbYJKr
         /HsxNwCezJf4sIMn0rx2HiR8KQkNmkOr9+hVWkyjXMk39RZbkJPRVFT2SgBObCa7jPfK
         GYYUKj8RSJ3JTGDWIIPczZk3+Ily+YyQMX8HfECyyl3zlSxBy7hYZ4UF+5gXuJQxvCTn
         NcnQ==
X-Gm-Message-State: AFuF++l5KgG47ixKtZlP7UtY73IWOqKeKm3XgRMLTjzpKke/8zYsg69D
	v/LU07UL7znK5KLR/mvCyJ0L0vjw3fbye00uJ8NOAWXP0TWGGJI+bEgQFOj0/A==
X-Gm-Gg: AYBFou0juOO1oNxfMjeZ31S7P3lKqAw1TdojbD8ZYCUm6qTFbv0EJfw+2/ge00lSmFC
	7FysW6qsTw61xj6TCDD74n4z+9Y8fyrUAhexV7MDbSEv9sOZUgdL9mvOHo7bdbe0VvpPKXIZ6cW
	PovDGFln+4CCTiem/gZYvbVC6ifPaEkVGM16GT1p83TDjhMBftXR9D1r5Pf75WqZTlNyIA8gznu
	8dcnC7wJmE20tw8ZjXK6dVa6aTUm4fK0sh1iG0sNX6rwgX94UTbLf6pTSn0qS/FuxaCkk8hIJco
	zG2SxJ/ikOTv+T25XdwlO+eu77VKYuDu05MAFqAl7W1Pu72tupywJbz3E+Ww7GOGb+YSzTKEfT6
	1JagmoTbSoKxBzfbTvQ0YtBuyMarNCy0SMkE79GBwriPRk+z3iCi9n3C60WzWZGKal9+P086eD5
	EbzF15lv82Ctf/kHfgy4Xz70ik3skE5y+QO2lKUF1ouCSBdSLd0qsp9/qJsET6hsSZwZbcfw==
X-Received: by 2002:a05:622a:e3c6:20b0:530:8d19:b904 with SMTP id d75a77b69052e-5308d19ba25mr79257341cf.42.1788882988503;
        Tue, 08 Sep 2026 08:56:28 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.102.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541436b1sm116313901cf.12.2026.09.08.08.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:56:28 -0700 (PDT)
Message-ID: <6aa0302c.bfbe2361.1f9905.7500@mx.google.com>
Date: Tue, 08 Sep 2026 08:56:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5648095709612063881=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nithibert@gmail.com
Subject: RE: Bluetooth: btusb: fix NXP IW610 composite device handling
In-Reply-To: <20260908080108.1260799-1-nithibert@gmail.com>
References: <20260908080108.1260799-1-nithibert@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5648095709612063881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160261/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.14 seconds
CheckAllWarning               PASS      31.31 seconds
CheckSparse                   PASS      30.88 seconds
BuildKernel32                 PASS      27.34 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      511.12 seconds
IncrementalBuild              PASS      26.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: fix NXP IW610 composite device handling
WARNING: Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format
#125: 
Assisted-by: LLM (Claude Sonnet 5, Anthropic)

WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 2 warnings, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14798256.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/721

---
Regards,
Linux Bluetooth


--===============5648095709612063881==--
