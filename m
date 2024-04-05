Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C591160783
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309537; cv=none; b=PBMDgn804wd5WcK/BTwkKjmlhLQwqV3/n0+CxQ0ZZrR7/9bQqMHcxLRfMpntJYaKDtoj2y+lXiSESRQTqGoGP9lsUW3EjAOVIdds1cqTLGOTRvHClB4B5l55YHB8CSpvCVueofUVsxu61ZfzwZpmBvRgdntbKtPBoexyR1EZT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309537; c=relaxed/simple;
	bh=XTCpGuxjoGp5bBI1P3TnzDJtEByg+Z0HfYEI+XSi0IM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b7ypLrDIwMwhm4aMl8bbbuaZ/vFZfKdXzZfvR0kGAve/6BgtaV6GLOTI1Qd0VhgKbFnftqoujYNt+o3IdgiGU89dzIIe2T96+UU6ukLwt1vpHO2N/biyJ3ORGidoRMkMVdhdXQkzGX6r2EOlZiBofW+6d8jtFmX3ncbfAwZl0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8GdKnBy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8GdKnBy"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d4944e0a9so24790185a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712309534; x=1712914334; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=145lsAJbJlwZb59y7HCNP93ikkpVr0YbALs2bYVFSSg=;
        b=l8GdKnBy14jv41sdjPaTxIUDNoZW0Vk4dW5/wjLTEdHU5GyfZC5Wduelcn5ENV4jKT
         th91eOXwkW2+fdMmsmNZRW3D8Sr5rNid54F5fxsakVmJQ1PN4KpErJPGETV8w5VjGlLj
         GbMVRhk3e0Hw4ANqn6k88V/4bRGLdc6z6Ne20XSF9PemH8v6KrA5lpe/M0d2zvvlgaKV
         jCzWsPBs1tOWrxzgWLURty+oryl/ORc5Dl/rMjaDmo062A0sd7DAr02jnPCK+AEu6HWl
         ZGeX3tZL8CdqAVzGAxfW2oKwj99eOilPSIx4QH+BRiSv0W3qhabDuro9kPFzAxaE/fR6
         NPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712309534; x=1712914334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=145lsAJbJlwZb59y7HCNP93ikkpVr0YbALs2bYVFSSg=;
        b=QAbpf+3NAvVkXYJ4M326qVhMqgTPgcMhLF6HzPA3eG6K+KGQKWqulMFcJoC9qSMVOv
         wydw9BGxKMhOAP4+dp2J+JQCJ5s1TBHgBpmj7AZiV8lP2Kws4QmQGdf1uQBPqNRMyST6
         qoAtnRWl8RivUmvQBpHJW8vGS0DRKbnsxk238QV6RH4jvo/999nrg1BPVmsbhaUJT2hS
         a1GWluHMBZXjPUJzLbNKpJ2bge7RWlVWnDfYVFfXityC0ByhIm6psTze0IbfflTjhY0d
         eq1/4dywLsiuYwqVqINOTO6/uPV2aUzYL2Aadz5zNSdMM70ThJqCn7pRrrUaFrUia5qS
         +n/w==
X-Gm-Message-State: AOJu0Yy8SzB4x4ExJ+CQDPCyRg+vm+5GMmcA0WkFXSzihvkx/gprAs5k
	MhS9SBNaZQvVpLVYhcqxYn2idIgfIlz/TNsZ++xjPpi4isBIVfsdlwKIjEY+
X-Google-Smtp-Source: AGHT+IHYfp//5G0egM1y215EBVDwL7knocv8XEFsbKfLIiAkK3dAhGQx6+V4/PTIEIn4h/GtHMw6fg==
X-Received: by 2002:a05:620a:8111:b0:78d:3516:eb3b with SMTP id os17-20020a05620a811100b0078d3516eb3bmr800472qkn.20.1712309534369;
        Fri, 05 Apr 2024 02:32:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.241])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a136100b00789e2961225sm487169qkl.61.2024.04.05.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 02:32:14 -0700 (PDT)
Message-ID: <660fc51e.050a0220.77fb9.29c7@mx.google.com>
Date: Fri, 05 Apr 2024 02:32:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6062418140298119123=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Update firmware names
In-Reply-To: <20240405090118.582310-2-neeraj.sanjaykale@nxp.com>
References: <20240405090118.582310-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6062418140298119123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841719

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.66 seconds
SubjectPrefix                 FAIL      0.44 seconds
BuildKernel                   PASS      32.47 seconds
CheckAllWarning               PASS      32.98 seconds
CheckSparse                   PASS      38.54 seconds
CheckSmatch                   FAIL      35.09 seconds
BuildKernel32                 PASS      29.36 seconds
TestRunnerSetup               PASS      529.51 seconds
TestRunner_l2cap-tester       PASS      18.48 seconds
TestRunner_iso-tester         FAIL      30.79 seconds
TestRunner_bnep-tester        PASS      4.69 seconds
TestRunner_mgmt-tester        PASS      115.71 seconds
TestRunner_rfcomm-tester      PASS      7.26 seconds
TestRunner_sco-tester         PASS      14.94 seconds
TestRunner_ioctl-tester       PASS      7.66 seconds
TestRunner_mesh-tester        PASS      5.86 seconds
TestRunner_smp-tester         PASS      6.75 seconds
TestRunner_userchan-tester    PASS      4.94 seconds
IncrementalBuild              PASS      32.86 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 121, Passed: 120 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.223 seconds


---
Regards,
Linux Bluetooth


--===============6062418140298119123==--
