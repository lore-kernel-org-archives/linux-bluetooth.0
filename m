Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309F140394
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313334; cv=none; b=HmNBODhNuSWOBdvGwS/HyrcTXBzinPMztCkZnhm978522pbkaHWBaYqYRd7b9fqh00acTGUgPlhaVp/2mEsC3Cfc3pZ0//Icir963e9D220CegiWBN7mplvY/YxljkQxRFzZyk3ofg1UYLb3VaK8pT2N9GJrJmtGLPrfL0Iqql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313334; c=relaxed/simple;
	bh=hU/9hHEfEwptl4+SoQGGYmCq9cR0KXaOji7oqKiuI1A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BheHSOnZViAJCZIZBVCHEr3e9jP1Gmb832faGcVQS7rka6OitHcT1fkcVOa3wLyHZmJTYMuuC1UX775N874b33BUhNU6ua8ivjtwFexgQEDdq698q5WItRuqSdr6cjObFxOYalQCdpqe3ylh2L3U5UFrOS0/8gvowBJGnupdcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+K+bXwn; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+K+bXwn"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b7a3b75133so2907166d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721313332; x=1721918132; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dZlfLcORaD5t7zMhommF1oFsDBg/Dlqse0uj49UzRlM=;
        b=L+K+bXwn7q85FHXnsoq9hAKvpK9WV43VUSGQR1OarXbPb0ui/wAw/7zb5vi3OD3KtH
         UUSeKMYlK8+Nx0W2RXDYy+7nf0xKGU2RzJIzA+b8pC7CzSe77dSRhSYUiaFVz1KWzqJl
         UqXtjH4cz2VsYFZyKAwsf1a/bPo4e5trr6mBdzh5zyP1m+vuy1WZK546VdzveZBWbBVe
         EmWqkLRXS0389e1DFiBwFg2++1PXstgF6NKVcf9S1AD7tFKnaCn57UnzrE5BdLPC8fDM
         hNg0yutuaPMnWhudVrRlFuCNCqffbeGeW+xtHSM9RwqT1vZsPGAiWP46ubY4jcpmEEsg
         KHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721313332; x=1721918132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZlfLcORaD5t7zMhommF1oFsDBg/Dlqse0uj49UzRlM=;
        b=SqhkRBxP9IvDyrbntzyAcmEKu+hWX7TwGSoKVL1Yqh8+1n1CFPk5BjjwYMS/+5HQHh
         GGoV83vMNdK3DVsxbM0Zl1lzdhbUnwvzTcAd4eaP5An8hN7DVxIdAfvDGg0be0Vpley2
         Bw8HXMbi0eRQMtByUOsAqvTeKHzFM16mwxiFlUZA6j1gHDMv9DvxtzZ+UVRPKsZstWBg
         QtGI2ntJtWHnUmCK3hjuuQHSZGypbykFYl93n1fg2WgozkYzj5aiHsBZzVNFgKjN1vx4
         AQIDcQjDJi0X+9Yt9gDRwh5HMiMr8KfW3sGIexjUJ7197obdEjI+YV3x3vv9FmMx+fs1
         mGog==
X-Gm-Message-State: AOJu0YxCdpRrtrmnYqtQv5mxBxIfJXcNLwSaFTWPITzk3rJ4uvkoBQNt
	p/a/Y+BDG0mgy/9tpP480Vn/hu/g4Rb+m6aMRLmOAuXXCjIiaJ724dZDMA==
X-Google-Smtp-Source: AGHT+IEmjuzKMcl3TlJZT08+/5ld9mVI9iqXhQC+G3i3qO1C2nKELGJJgpiu/q44qDDWdviawE2yqg==
X-Received: by 2002:ad4:5fc9:0:b0:6b7:a4dc:e243 with SMTP id 6a1803df08f44-6b7a4dce559mr10176346d6.15.1721313331508;
        Thu, 18 Jul 2024 07:35:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.165])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c609bbesm8559346d6.99.2024.07.18.07.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:35:31 -0700 (PDT)
Message-ID: <66992833.050a0220.4957c.348d@mx.google.com>
Date: Thu, 18 Jul 2024 07:35:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4855436098914058693=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v4] Bluetooth: btintel: Allow configuring drive strength of BRI
In-Reply-To: <20240718135655.3948028-1-kiran.k@intel.com>
References: <20240718135655.3948028-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4855436098914058693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872275

---Test result---

Test Summary:
CheckPatch                    FAIL      0.96 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.28 seconds
CheckAllWarning               PASS      32.81 seconds
CheckSparse                   PASS      38.42 seconds
CheckSmatch                   PASS      102.39 seconds
BuildKernel32                 PASS      28.65 seconds
TestRunnerSetup               PASS      524.54 seconds
TestRunner_l2cap-tester       PASS      22.03 seconds
TestRunner_iso-tester         PASS      121.95 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      113.87 seconds
TestRunner_rfcomm-tester      PASS      7.52 seconds
TestRunner_sco-tester         PASS      16.09 seconds
TestRunner_ioctl-tester       PASS      7.96 seconds
TestRunner_mesh-tester        PASS      6.12 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PASS      28.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: btintel: Allow configuring drive strength of BRI
ERROR: Remove Gerrit Change-Id's before submitting upstream
#113: 
Change-Id: Ia51d0d86b980fcca1b12247ed8fe9ae9d2b06307

total: 1 errors, 0 warnings, 148 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13736562.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: btintel: Allow configuring drive strength of BRI

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (81>80): "[21.982720] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 build 45995"
34: B1 Line exceeds max length (82>80): "Reviewed-on: https://gerritwcs.ir.intel.com/c/bcp_linux-bt_drv_kernel-5_3/+/117825"


---
Regards,
Linux Bluetooth


--===============4855436098914058693==--
