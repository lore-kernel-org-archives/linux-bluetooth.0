Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C92F616A
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017995; cv=none; b=RncP0fSPaj1SJuuIk6lODeWwthM9BbWafOgXqImGusb3yDKFYOqqaoIQ1fb17KhxrDqlfQZN1iLQrHACOHWAbHPzrNRGsFl5rRw6dfHHSTF4AtfKmsoyMkF3ixYnGjIhS7L4Y/sECA1y/mzWfxhnT5gn8kN69t02ULFBf+UITqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017995; c=relaxed/simple;
	bh=MnyiHQSi2F8hUb3wg0wOoJakGzmZ6THWyIyKBj0uVzw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z90XUAfovAQi5+JRu5EVIJRTuRr86nM5Z6YsD0xR7GP7JC7LFvyHnnt9/yYetW0iEDzy4FzxPvjXCkgWmDcfPPyZ41RRklYKc3GbYS1OvpEEpznpH8ud2kBFWnqtjHaBspJrg697gcNR/szfuM2RsM+JTSmPg3RkVmPpU6fikUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYPRnk74; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYPRnk74"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8f83efb5729so625325285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 14:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778017992; x=1778622792; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XXmJtZxiSjsFDve1hjpmfFXxiqwYcTmnQc6Y0aqdGXE=;
        b=PYPRnk74/FzlZzHeNZN8QmiprtvO4uEjnkNc2aBReeHSrF7noCyctB5DCsKFKiKScd
         iPeiauQoQu1p+4jz4IOQMTsvnKwooEPYwkZPFuwBbnFmhztpLuXhRh7FFaE4Mrg0LbpV
         SRIKROIBriFjH9XXzcytL/pS8AV7gRFBh1T/Ps4lU6b2ljhH/1O9T+8KEld/+IPb+fgi
         brp5Oppr5Oq16eLLADkY/GHKbXxdEaGrbqLY2AeWrAQz3hzR1xXheX7ttoux2uiXe+af
         NOe0X6j0bmr2pULLC4I72UbolOTaLcQKsd6PgHSU2ZUQhuNpItnjgseD6l56aAKEi9kp
         g67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778017992; x=1778622792;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXmJtZxiSjsFDve1hjpmfFXxiqwYcTmnQc6Y0aqdGXE=;
        b=TxAFln5uq6Bqa5zgH+dv3dU6eTHxGuvHKOmsPvgKYMDmCJnEsYr/cNIT1Qr7xoiq5Z
         MARw9t1m1s/LmeWsicU/F2ist9kKVSTcO89Q+AH3zYxxdvcYHVcwrLSzrYQ7VA7hqfAB
         S5S55x3/G8I+XeSCByfHZru+2eeNUD8uOupxASytPRuZj7/qy6qFO89tmczqdgBCnHds
         spIAU1CAlWmSXfPXLJflX1qrRoi1tZ+08+sLU3EevMzeCz2Rh80ODKsRBvjrWiyeATUN
         1amfs3bYEZRJ272NxmOObZkOSlcSAdskhpuUx6ujozZM4uHbY0JVHRNweodAgTxKIFwv
         pPDg==
X-Gm-Message-State: AOJu0YwDmbKFgK2n9qsyZy4xxAufeOOubaTKt8N7BdyzwGG7IdUqLiH3
	gR2ESmrus3Rqx1Fy6mQgr5vBxujWIvMHllYuX7ee6hH1apXT3zBTa9EEgSL8XA==
X-Gm-Gg: AeBDiesfcbiNauE2Bcx2fRtE++j785+GBebVIsKtBolya3C4il4ZiESWPXaUzbJV7B9
	B4JQvxg6cVJljRKR5QJqUQEcqguJmVPfeyYHQxgpxAsQ0Cur1qigxT1NDMkXyuhDlGL7lST/16q
	r8YFtx0zsf6pk8JHjpN7l9i5lV/xTc/5fcskvkXFTSu7Tb//hXyUB2LHdfTXWOTqpnsTHb1l5hk
	nzMjGYW8Z+I+B9+DQsK5+yPdlK3aH8550HjMaNmX2N57YkJmyJvtUL0POZ8g+q8QyDWLE6CyHIc
	z7FJZCMXn1hWiNifa6tYUcumuNyE1/b8gJL0wS4WdPDGLznPGbovtssdtCFH2HGTh5fv4YtcYGw
	RkBRFRsw7MmlgIDwS4CHgPifx2ygYwLYGk/lxlJwED37MwGufxmPaUPEeG4x2bjHms0C6Y7pOS9
	g6BbF+IS+it8gT8eml9mgTaVfS+xIvgmKYrA+B5YkI
X-Received: by 2002:a05:622a:1103:b0:50d:a8f5:d51f with SMTP id d75a77b69052e-51461fb8f60mr13427931cf.45.1778017991896;
        Tue, 05 May 2026 14:53:11 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.151.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b534ac8ef3sm167199366d6.0.2026.05.05.14.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:53:11 -0700 (PDT)
Message-ID: <69fa66c7.050a0220.13bc7d.9689@mx.google.com>
Date: Tue, 05 May 2026 14:53:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1416122688861375630=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] hciemu: Fix crash if hciemu_client_new return NULL
In-Reply-To: <20260505201548.1328953-1-luiz.dentz@gmail.com>
References: <20260505201548.1328953-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1416122688861375630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090113

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       FAIL      0.32 seconds
BuildEll                      PASS      19.99 seconds
BluezMake                     PASS      602.95 seconds
CheckSmatch                   PASS      320.60 seconds
bluezmakeextell               PASS      163.77 seconds
IncrementalBuild              PASS      603.35 seconds
ScanBuild                     PASS      908.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] hciemu: Fix crash if hciemu_client_new return NULL
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#106: 
   by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)

/github/workspace/src/patch/14556374.patch total: 0 errors, 1 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14556374.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] hciemu: Fix crash if hciemu_client_new return NULL

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
14: B1 Line exceeds max length (95>80): "   by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)"
16: B1 Line exceeds max length (87>80): "   by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)"
21: B1 Line exceeds max length (95>80): "   at 0x483CA3F: free (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)"


https://github.com/bluez/bluez/pull/2099

---
Regards,
Linux Bluetooth


--===============1416122688861375630==--
