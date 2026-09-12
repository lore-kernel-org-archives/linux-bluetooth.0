Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65432366541
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789251567; cv=none; b=pmKOBw1RVMta5nCA3rocZ1jwkR8/z3GGBDkbvHgk1NGPMRGj0RsT2/yUU8gAFir26I0mqcita6XqUAc9wPnIRNvVibh5mMA+TAkr8FjTXCb2AUOlr95CfaTjy/wSTGBBrHytfSJF3JGEKS2aLqZ5VqetPknD+6y0vbaXGHpzF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789251567; c=relaxed/simple;
	bh=itVXF/+DeiI5me8zCmQrtTreJ1ZQ3a+r9gYKpZ5gK34=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lVd+kfvr/B1VHHETfN94xAEPXTyJDSD+eqo/NOxYxlowEOvbpaXbb/yTmwx8O4B80nkZA1Q3YR6oFT4hzDlmYeNjHlBjPAkmfOi63iaDQupPFb6Ay1d8KTwF96YH/F0tMIcXUQz5ssSbVmTtYDK4uhHSSovMWJK8TYl6DFa397s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQEWVaHk; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQEWVaHk"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-8055dcba0a5so254910a34.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789251565; x=1789856365; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lcZ2/hLf/73yL/L9sHTkIWrH06XW+XdZ2L+T4QWPV9o=;
        b=QQEWVaHkEAgKpwCjiuUcAnwhieYF3lSsqDcBidq9R8YScSuN7BkWYNWWWnPD0HTexb
         AtUyztMAOccQmwXCLPzvbC0WyCcp3xluAHbvjOTljNBmmSuLbu1P+tNGriuSlKDGit6A
         8DVbh/94TBU9zs9rSXZKYHrv3FQFabhJV4zYka850Mz3pXAUp3QwJLBLy2eOpd34c5ML
         Fklh4bpMHqIjzNxqMoZLYEmyzSll3UswbdEggf+XF/yLz26lR+oOXOjAyrcBwrOvJG0r
         o0/XKBmsD/uI4wAqIie/KTk0lktPtr+RkEImex6bVRfsNgHWDfRJWxYKWFg/kfYek6W7
         Ma8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789251565; x=1789856365;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lcZ2/hLf/73yL/L9sHTkIWrH06XW+XdZ2L+T4QWPV9o=;
        b=L0JS73CFZzI9ndkSIauh1SAphmfwtpvQVC+eON7S4hmUx9PjTjvCPSRZRw0TASF8xo
         BdjziLNq6qYTLPgbOfUAgmZTyqWNwv9DAECf3rS6QzISvbOJUR+vbAjqaB9f3wiHSfqi
         /vZBES0X+AMyJrvsCLBpcsJ4N39/y7o3FM2vDArQ0xUH4A6hCj297ea1Hl7/Trq9rIhn
         RVreNvID0zgcj+cQhTKDhebI49LqpR0dIVn4HUd/Nw9TpwYjyrvUNTLZ0FhIH8Q+JMCz
         ZN1NSAxwNtniNegG0s0b3nO0bxCCK/2sGaiDJ8CIFoXszOVMKQh49gUANaoTjKUfwM7t
         Qjfg==
X-Gm-Message-State: AFuF++lOZoXzaJ9ZmvCen1AyOI0GOLeFQpiZ8mutZAak0qs+rPXvSIic
	hWO4Zy2+3Nur1LYjEjMQw+UH5MdoJZSllhhIbinT7AXkBb0UKaBAgNmKR0e7cw==
X-Gm-Gg: AYBFou00hth2P+V7+3S7eEnr4WelLydf5znF6E94cHUVZFGFvFSf5lC3zP69GN8udbc
	hUmFMz20e2HumTcJwhHEbQob4DHCXPWcKyRsuf3wEtstfIIfamcUq+5Gk2y0rnAy8IjQw3sd6OS
	GtlV9wz7QKS2NI7a6VGKjX//CF33cybfBbrchBStewEAwhM2dEqP638Egk3bRIWKL+1diKYOy9J
	HABVgRuJaf3SKBhR35bDhA9WOUEcJ5gpghbFAuiywpBMcNmtpSS+QguAjHyOzJPsTl2IZ8U69f7
	rl9Jx7JxNwgt0dJDP7jACdWGH/MCMvg/UmbaZkJ5eYJsi0k3+nbquwVCNo6wsh5dl691eAXwjIh
	e2D5jgroaUCSD22MZrRrv8GoucIzd9QSLvBVRHh7yE/EfNb5Bbkn+DByDbsHWbg+j5zt8WmtED4
	ANL+73Na3EUFOeJ8m7b3pRBZoDsJauGknS0AWRqlIIiKHFSSXV4d0RLJ3Ug+/eW8aD438OSTzpH
	G4KNGgwKboq/aSw
X-Received: by 2002:a05:6830:4423:b0:805:b4a8:724e with SMTP id 46e09a7af769-80719b1c5d3mr21837a34.6.1789251565077;
        Sat, 12 Sep 2026 15:19:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.101.52])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8051005d845sm4685851a34.24.2026.09.12.15.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 15:19:24 -0700 (PDT)
Message-ID: <6aa5cfec.5ed50510.32ce1.03ef@mx.google.com>
Date: Sat, 12 Sep 2026 15:19:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0972023501663793052=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mlukerbrown@gmail.com
Subject: RE: Bluetooth: btusb: Add USB ID 13d3:3626 for RTL8851BE
In-Reply-To: <178924584937.116572.13159457162680472249@gmail.com>
References: <178924584937.116572.13159457162680472249@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0972023501663793052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1163612/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.50 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       FAIL      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.29 seconds
CheckAllWarning               PASS      21.97 seconds
CheckSparse                   PASS      23.26 seconds
BuildKernel32                 PASS      19.10 seconds
CheckKernelLLVM               PASS      19.46 seconds
TestRunnerSetup               PASS      488.94 seconds
IncrementalBuild              PASS      19.89 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add USB ID 13d3:3626 for RTL8851BE
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#123: 
  Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000b lmp_ver=0c lmp_subver=8851

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14810877.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: btusb: Add USB ID 13d3:3626 for RTL8851BE

29: B1 Line exceeds max length (84>80): "  Bluetooth: hci0: RTL: examining hci_ver=0c hci_rev=000b lmp_ver=0c lmp_subver=8851"


https://github.com/bluez/bluetooth-next/pull/757

---
Regards,
Linux Bluetooth


--===============0972023501663793052==--
