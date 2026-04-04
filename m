Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067B332EC1
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Apr 2026 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775335498; cv=none; b=o3RXE9F7umkRJqUaEFa5z++p0apzokBD53SEwomtiZc2Zf3N88Hfku5Rh9PAJnGR6HWOeeMNqU5jaLztpfmTi+V8PZ6e1Vq1a2QI8b+9OoK/2K+draGQay9AdmrROIYgdP+AkCjikoz8AN0mppG9g1eQ/vUXkm5eE57SjMTPAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775335498; c=relaxed/simple;
	bh=PzyB2v88WkZNenSTwm1KiVQGKUEE20o9VEvZo+4yX6E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YJNTRiXCuGe3SYQ2l9B6CzeIHVfQIjqJMREDRwDe98FGkDpOstUStjGY5Hzy0+D6fG6q72UnetC+EE+TlrQzPIBu5I3dkmAhGk3++hyHOL41LfkYJVVINr7osBQIpUsQmzZmv+XyP6l5w0JvwXqP2IyfeWalzLxsIcBRr+EoGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb3Ak1Hv; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb3Ak1Hv"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a5800772f3so25114696d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Apr 2026 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775335495; x=1775940295; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+GxzejMN9Jk/qfXmP9TGAPOSZqxtZzQWZBh1o445qY=;
        b=Fb3Ak1HvFbmX5GpNBHv0eSbUAMhDxEdMYlT1jMC00xxcR6ciVR55SPikJCN/01b1W3
         218VFJ7vCQUA4vuRdGN25jOKGHvN4Ll20r08GGi9qnGTZI5DHsw70jDRhPFgSsQU5/MX
         MlPShrrjl4bb/8rEXBFbRFIT0TnqEaj9SRdEckXtaeFdK/eKQJz/5f4Uose6+Bdq6cTS
         8iFn6rXA7CQjevZvsf6J8f64CubjX6AUfXnQ8B/d1Eb9ttCByZC430EqtU6DtFTF/H3l
         a9GnLx6AhuwUj69yP7C7uvaK6PGT4GGjIMzJM0uaiGmTku28LGudvnDhaKkX8fw9wXFg
         sq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775335495; x=1775940295;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+GxzejMN9Jk/qfXmP9TGAPOSZqxtZzQWZBh1o445qY=;
        b=AY+ZObqNiobk/Q105c8aBTXi2w/dPzKXx+j1jepOng7TePwfmAyJ2qagSjoI9JqYCA
         8gHA3QDkgH5FfUdBmdSC+38xEJQdEXzy6999mttJNQDofzXkmhAuOcMD2QFibfgL5hDv
         6fTAhp+O+ybZZjCjec8MphsUb8UcbBSoZHru/CE4fzxnkLeUgTlp4k12M8+gbyCN+0ft
         OrQcF6l7vqRHkseCKs+9fpmRMBvE4GUVYWzXtwE7PAMAJ9z/8uq7+DixAkPF2+nLpAz2
         o6gwul8A0PHUjeKgcAfHvsoPqy9QSlGPIG572kKfwArbwhf/s5d6ViOrMBaYDwbbx2Eg
         BDOA==
X-Gm-Message-State: AOJu0YwizSqCwHTQSaksHrYuBOtKG3jWg0cryRktDDsKyppzDFjIZWBF
	ILkcuymy53eIiYNjsabEuUaMMja59NoC4hzXq4l7Q7aA3unpuBLbSlJRqE+6Bw==
X-Gm-Gg: AeBDieutiY0B9SA38RWn4W4LXrLHWPk4NHUPH2PdJsQ0d+QqECEIhdmFEQCcJrDrND1
	FIwpUepSMcqgN2Gcbedqy3YxWz5hCqPpqF4kOxoB4OrhHUnK4u5wZBoXp5Osa6sJdjeyLwqOAXk
	FoaIL7lPv8nbFrEdr7akQK0FzDih8MrE6CGJnMygEcGDOBdvK/ffw8SrUMj0jljVyZg+YHORWx7
	emDwAWbUp1a7+BpebdUmdAo0Bi5Ru4eEdWeAT/8xCBIWf+KFxdoJsZZfFydCt5FoU8QlXaqQVfJ
	drIaOF+V5fioEuUlvwHDJsQzGWq7QJZqOqZn3UDYj6F8mCxN2yj65FsILOn9ZfG1dvQ+Ddxk27k
	i2SgakO1KHYyaGNuC+6yOtd4pvGnPpvvXnixPAUkZrJc+C3v/hzgyxeVCMtkV24i1q3v7J8GeGU
	BYpeSjBaSXZppOAYoec7SydrOJKuUGfXI=
X-Received: by 2002:a05:6214:6014:b0:89c:b504:6752 with SMTP id 6a1803df08f44-8a7024bb2dfmr114996686d6.10.1775335495382;
        Sat, 04 Apr 2026 13:44:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.38.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593906450sm81322916d6.12.2026.04.04.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 13:44:55 -0700 (PDT)
Message-ID: <69d17847.050a0220.2d16ee.d495@mx.google.com>
Date: Sat, 04 Apr 2026 13:44:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3037887844042814129=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ebiggers@kernel.org
Subject: RE: Bluetooth: Remove unneeded crypto kconfig selections
In-Reply-To: <20260404200645.28902-1-ebiggers@kernel.org>
References: <20260404200645.28902-1-ebiggers@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3037887844042814129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077352

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.21 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.04 seconds
CheckAllWarning               PASS      28.50 seconds
CheckSparse                   PASS      27.27 seconds
BuildKernel32                 PASS      25.26 seconds
TestRunnerSetup               PASS      566.08 seconds
TestRunner_l2cap-tester       PASS      28.16 seconds
TestRunner_iso-tester         PASS      37.97 seconds
TestRunner_bnep-tester        PASS      6.54 seconds
TestRunner_mgmt-tester        FAIL      114.68 seconds
TestRunner_rfcomm-tester      PASS      9.51 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.22 seconds
TestRunner_mesh-tester        FAIL      12.54 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.81 seconds
IncrementalBuild              PENDING   0.46 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.751 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3037887844042814129==--
