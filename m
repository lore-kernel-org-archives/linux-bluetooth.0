Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB71A9FA4
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 May 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351352; cv=none; b=V8z2ayONBYMunzJNPLYHf6gIWB6Lg92YrMvAvhRqoI0qato9TeoRI66P/RsYNQve8odQHW1W5EGXffuIMDAdUS8h69aL0wVOnGD+8eWWcEzR/ite5zdBlqDhf6lQa+m/rY0T8OGVMRw+jKql3dteooc0681nwbVYlrkxL33JN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351352; c=relaxed/simple;
	bh=NMVsv4LTBFgsbP0p5QRffJH93e7lt3M8H4Zy7XY9F/I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g8Zkq/ikIbE8fli8uI/dVwTYkLy7iklXgWytu9fzrj5F5jrhhzZfWfq3j/giE7AvJlwuAL7BVAkYZ5amtGhM1xf5EcxwsWIuk8poojOXAysqoNgJEwAgg6M5oIYJOoKVcpmF0MzSQWsfb/aif6YxO41R+Euec4M2DysFIx9y6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lglx9Zlv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lglx9Zlv"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ee9ec26edaso361634085a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 May 2026 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778351350; x=1778956150; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cVME8v05VY1AZucnCw2+gqxgjL1DY1Otzyv4nlsvGeo=;
        b=Lglx9ZlvL/52epIhi0Hd8d6vbwofhRPSJTSdIf8BYd3KGYYRgorqdU2Hhv3fYUKtNt
         j8oC1XAeUQSZMhW2xWhJxhkGIVv2jnel9b2Y+9NfygJIPSif5rFlGrkytyavyQhc+nC5
         xITR9ncrp7BwPL7MMo0k9vNf2azzgyMrVGJYP/u53a6uT1r4a3s6gHij3S5IGL2m45B3
         b+wpZDcgMP9wv/Kly4eEDa+pzygR5BP1uScJG+g3jA+iKTvrZ2HFFW6gdCK1A6xlgPTU
         6acaIG4FUc2zXbvyRccSs+qTD1GMh73FWUOJXalah9LMRCjRqfES594Egm0XEZDKM1SE
         JlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778351350; x=1778956150;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVME8v05VY1AZucnCw2+gqxgjL1DY1Otzyv4nlsvGeo=;
        b=DsqMJA61Rp6EKUN3FMlKJ/BgENdI5KN0RceMdETEpJhjBDgk4bkv28+To1Wv6Gcu/N
         sE1tyWl9ztgM9KzIQghPTmXs2MeUFJ//5YxfYR7orHEGJdOfsfwdFYpusDKV9gEFu7wA
         AITKooQIsRCnq84c7MEyrSM58UTgIOhhrCYUc4mh5Nc/8D43rWvfYhxt3RQDcFz2B4ba
         J0z5onqJs9eiLqmpI5yIBPdY0A/sli+jm8L/q58WSVVp5P2t9cufqM4bvYDAQlb9v1a4
         IdqkjSvt+2vivXmeQzhtoTQSNa14x7lbsMLYx9/7B3bg5MFQj1pybecNsu4wrHYKOC3C
         Gh8w==
X-Gm-Message-State: AOJu0YyiiFa24tWxddZb8D5BXCCAguC7af70rOpzEc/S5FjX19+WNU/S
	9jPbnTOTJ20Q43gkHihlC6xqaNR/liJMnJDSED1Xf2/z6BdLHnyqOSJlkgT75A==
X-Gm-Gg: Acq92OEnmSixAu0o4hB9Gh3g8D7T+uduB+xRTDIdzWI6mIz9UcJ8nbgC1KucWIqVSjE
	ai8Gdtzj/WyLIIN59o6LhNAsG7sb5WaKsTDHXxSevXflIDcNw+F65qKhd5IK7zbaREnnubx4YG6
	/FyXADdhevzjC2f64kLHpP4eUS9n+AEr8FkHoqV0v7mPS7AAHeqlkRgpTNfit2z8Mg09VstVaEe
	bD+1onRgpWRn5INqc17ELSlOhLXOzgjBI8FWZAV4wmrNj+ExaySDesHKlXpROHIu7Wpcs3A7ssJ
	pHzBbOYlIKCzwN0esiGbleI96bEVpe2Gy7MIK2Wb28WFhjSErItNr36LnvWZw0cUggkxbCh+3xs
	V3ALqdORAX90WuOaY4xemd7DJ7eEzTM1ZgAWwiEKtek12/nJ3EvHB9QUbM/cZV/A1BsdEA9DAv9
	yyBI+Vil1oQhggLEdzr8tet+tzsne0I239kZxJJEsb
X-Received: by 2002:a05:620a:4552:b0:8bb:ac44:bd3c with SMTP id af79cd13be357-904d6cd6819mr2584896985a.52.1778351349648;
        Sat, 09 May 2026 11:29:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.101.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04ddesm2613335085a.43.2026.05.09.11.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 11:29:09 -0700 (PDT)
Message-ID: <69ff7cf5.050a0220.141698.f23c@mx.google.com>
Date: Sat, 09 May 2026 11:29:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7117387498647923233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
In-Reply-To: <20260509173727.412674-1-rollkingzzc@gmail.com>
References: <20260509173727.412674-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7117387498647923233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092078

---Test result---

Test Summary:
CheckPatch                    FAIL      0.77 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.98 seconds
CheckAllWarning               PASS      27.45 seconds
CheckSparse                   PASS      26.44 seconds
BuildKernel32                 PASS      24.22 seconds
TestRunnerSetup               PASS      518.00 seconds
TestRunner_rfcomm-tester      PASS      63.49 seconds
IncrementalBuild              PASS      23.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#119: 
The buggy scenario involves two paths, with each column showing the order within that path:

WARNING: The commit message has 'BUG: KASAN: ', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 2 warnings, 0 checks, 65 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14563150.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
23: B1 Line exceeds max length (91>80): "The buggy scenario involves two paths, with each column showing the order within that path:"


https://github.com/bluez/bluetooth-next/pull/160

---
Regards,
Linux Bluetooth


--===============7117387498647923233==--
