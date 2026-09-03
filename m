Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDE37F30D
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460923; cv=none; b=Dpch0q6eYZ5J8PX4JCKOptuSlPY5+z+DbW5LLHwvLs++sd2Vy9V+ESohN8unmi1u7V3nsC8J72w61pxn74rHzywjCo0Cmfb6yJAKnZIPEGbh/7zyy9eEEZul9irVTrva6KWgz5J+5wqW1TWYcqo4ZGVvTjKlyKDrbiH5dR1295U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460923; c=relaxed/simple;
	bh=yCjeB/QH2TUGd3PqWOVZq1JaDe/JfBEwTDLEsrD/6MY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QaNAWNqltmHOhinDmP800fNDFMjs4pnGulsDod65gBDsXTGUpv4cSYIg9wPt/HehPIGnV+8zHMn5MsdqWCF6T9cQqN0hHXPwgXtkehNGEJy5GkJv560G7vsWA+G9o6znjHHOPfj14jfZIcD6n4vPlZ28MxmBUe2QrwZafP4yvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrpvPWFH; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrpvPWFH"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5303557a6dbso2896631cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 11:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788460914; x=1789065714; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZGmsZaoHOZGTRBE6NBrH06i6JrljlQR+XDb7SbjZBqc=;
        b=VrpvPWFH60jxqyTug9DffYb5OMGef89zvHN5EHItYzpZrPhKth7ffv4v3r2n7nH7To
         lT0oN7p3MSxbLZNQXgP1Bo3BUb/wLNu1XwJSHoqeLi6udaRQUP0oS9p/LDS6ZWPZ1Ij/
         YQVMB19SBklTqqKAuKBwjYWsfBGYrDsZIbXMIKRbwMiCCrah3yI3KM0CR0hNiU9VjnIq
         lyacNR1/W3hhxwMboaPIGRNtysHWSYnxAGqqxEIgmc1hsPgWEFoUsQbw3VKUUowuhvsW
         88GsgplZ06TgRSyCKD7A9kVAobyMLwCPvs9fXiosigEDjhQQVEUx2sxVZ+1ADlVMM/Yn
         U7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788460914; x=1789065714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZGmsZaoHOZGTRBE6NBrH06i6JrljlQR+XDb7SbjZBqc=;
        b=Yx+D/PTDHlB9mxNfYii5qDoFqZ++mxTBKQ/0Fvu5O77cymK1euF2u3MrHwb8SGTG8B
         rDSbcttAm9wVm6PWjPMrundMXYUCqZfrvyH9ZK2rA7tLInd5UqIXjcQtnczTYcgwQKMM
         WHv1xiDzz1e5u5htCIh9qvBySq6rmxzJ9n4bUP70PmMbHYfGBptFQCKwziVzXy8Nsxc8
         3StOiTKqOT1V7PaGe4742xpakYSgkqEtzQwa7kDzoTotj1dlLkc1UpvCm1BaAYLhedrY
         0i37/YJP+nb92cfxOECUbcK+y0mueLTtzE1kcsO5ILlEz9oXXo1t0dc55Psxxe4Cu9XP
         Uw1Q==
X-Gm-Message-State: AFuF++mw/ttaxFl4c24XAoV0RT0llvnU60236l1VivD5hVzOCdVIA+Qw
	rSvcJTTnbSHhUekzSzEa7v0R9EQGU2GS3FRYn2JtQECxHDZgdPPCCAoIuOf1DQ==
X-Gm-Gg: AYBFou119ZqJ6gCa7B+6MCAEvmpg4XUWMHQiyMQRQ4BBF2WW6KYrh/tf/AVYg6KJ4Dv
	1E3aPHSgEn2SPgJTScBNHdNtu2qkBI1AVf5uRM35B1KmdQSpiRLjaW23bGrYaXV5PZjr9FZzvLn
	JIHhvm+NUvlM1VyORuU7s5YKX1uhTC45KsqUT4wAmUmKGY1IyGtzqPeLRv37+PS0B5HUMhn+/Ec
	+dcxd5IpKyOMYYid1HNE7p4eavO0upTYuXPyr1VPOA/IG9Y2pwRPOGYDIEg6iC2Ukoz1Okj0srH
	yKACYxXBqT7z3Y12gCLw5Qq40gHMsZ8PjBC+IBOrfHz5hz8dncGvokDekvTy3m7Zsx9y4buQd+R
	EQhXnfxYCBzZbyGMqakQ0RjzYOE66SfNmustVsaQL1BhVS3MSYE17k4br1dkyOeq0gK7DgrwRCV
	6MpG5CB9yiKrV6aZaBgDczMmTEaLPTSRj/n2qMEo4/d8CEwtZiPYOdh09jt8YDLruOSg==
X-Received: by 2002:a05:622a:999:b0:51c:1c73:5943 with SMTP id d75a77b69052e-53054961719mr10874761cf.23.1788460913732;
        Thu, 03 Sep 2026 11:41:53 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910405966f0sm1075336d6.6.2026.09.03.11.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:41:53 -0700 (PDT)
Message-ID: <6a99bf71.ff298dd7.18bc5b.7a33@mx.google.com>
Date: Thu, 03 Sep 2026 11:41:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1249100970400526723=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aritra.rohit2003@gmail.com
Subject: RE: Bluetooth: btusb: Add USB ID 13d3:3556 for RTL8821CE
In-Reply-To: <20260903170322.47004-1-aritra.rohit2003@gmail.com>
References: <20260903170322.47004-1-aritra.rohit2003@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1249100970400526723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157292

---Test result---

Test Summary:
CheckPatch                    FAIL      0.77 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      26.91 seconds
CheckAllWarning               PASS      29.31 seconds
CheckSparse                   PASS      28.62 seconds
BuildKernel32                 PASS      25.88 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      475.44 seconds
IncrementalBuild              PASS      25.71 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add USB ID 13d3:3556 for RTL8821CE
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#112: 
  Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=000c lmp_ver=08 lmp_subver=8821

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14788283.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add USB ID 13d3:3556 for RTL8821CE

18: B1 Line exceeds max length (84>80): "  Bluetooth: hci0: RTL: examining hci_ver=08 hci_rev=000c lmp_ver=08 lmp_subver=8821"
33: B2 Line has trailing whitespace: "S:  Manufacturer=Realtek "
34: B2 Line has trailing whitespace: "S:  Product=Bluetooth Radio "
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/698

---
Regards,
Linux Bluetooth


--===============1249100970400526723==--
