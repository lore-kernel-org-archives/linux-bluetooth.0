Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5A4D58E
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914353; cv=none; b=tBrgrnl0qI3Vj8j0hUk00HEc8isBb0taWTVP5hcJP5N+s4BhVLS0b/JnsodoyDLXSu4Rz9soF3l6tmov1yli+6jWyYjImcW5Nu6hCco9Fe1p10x7FEbTLG8pJX/Rejrb0H4o2MaiY5txPI1Emt+CR1ldhbP4rqXO1C+E4V0ZU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914353; c=relaxed/simple;
	bh=LaOscbDYbTgmRdupleu45y13itE4JnRtftnVkWkJWck=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UVAsRWMTP8ekHKf5P40Vy0XVEy6yc0J7pZ/4y6dIjwa5gdg/GbwUcaXM0OMp6FGwybiV3OIJlT26Tx1xMVA661uuIGAuqQoRW4ZeElK9QTdlSPAoMpubN3sSu4cSMdT9ZzCtLccM9vVL813DNLNlSEiTvTXd0Cd7XKfK/GsrLSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRj70MTD; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRj70MTD"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43492c1a8a4so3205881cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712914351; x=1713519151; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H9b5D3ylhYcoa3srBzDHhItyEjpRalRCW5krXKxDzI4=;
        b=NRj70MTDL99Bnwl0yCSxtwpJCPAVtV845A++xaIFw2cyfm1lEUwPNsN075V8eb+su6
         D7aiqJKL7rjo86n2oy3gNraNKohShZTrxkPTZljjKKcVC/Fh6qKFxGBlQeTNppqTYnnC
         +EGynCksP5tyk4zn6PoUslrLkyONYqfI7RBo/Oz0CnBZn4pm03rCO/XPTnfUXCnBlEIh
         lNli/MuobbZuXsTLLaLRGse+9X3CzR5cK9xdOPr+Ih/i9JYi421OlPVD1HHVWoMfkeA/
         ic4Fn0t3+5kPgsDo3ygpRAHXruI9174uGOQsZ6Y/CMD4zgKfwgA3Ygv/j3+zhEPqgZyI
         MMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914351; x=1713519151;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9b5D3ylhYcoa3srBzDHhItyEjpRalRCW5krXKxDzI4=;
        b=ollaaB6VIs7/Cn8S5OKNeuKcJivnIwqDQWa5pf01yWrMSPpfCR1Cnh73nAoIKGp9J6
         AWSjpFQAr5eA4LReyCJs/wl+f+PsLxyQJYrrVKdGPhzih71++hU3aRt6QpEuus77ASBx
         VhLGh4LJVCesSP1fJcvjX7j5TnuHTC8v+ed4jnBTBUlnD/wGA5oMe7PIUb67+OShNrDj
         yyg01tdZp/rhXAAn89ocG9BHqUteVSBAuiT7VjJ9NPf7rbBk5zP6UyGtj/jNxsHy4CzW
         gtUii3E4EkoY60MWzHxZdjtzYR9vF5KuqsP+aAHK24qtvLMH6Yn7FpH+YBp01AaB8Z7B
         bJfA==
X-Gm-Message-State: AOJu0YwK6xE+0SSgYKKBSVlvvVMTyPDnsjnKVh41r1oingWJ+3Kl2HJ7
	K0iRTWdf772hofBfZgFaa0GCQghurvLLpAXQXqsg2fOiXJ7MmhodfjN/VQ==
X-Google-Smtp-Source: AGHT+IEViXTkzc9dU/2Ee7fCOzO2FVtATWYrUZxkK6SBapgzuuihOes7gYFB94i5cirdwrZ4YzNhLg==
X-Received: by 2002:a05:622a:24b:b0:434:3ee2:8e3c with SMTP id c11-20020a05622a024b00b004343ee28e3cmr2200967qtx.29.1712914351145;
        Fri, 12 Apr 2024 02:32:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.54.3])
        by smtp.gmail.com with ESMTPSA id dn2-20020a05622a470200b004348513d0dbsm2014769qtb.31.2024.04.12.02.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:32:30 -0700 (PDT)
Message-ID: <6618ffae.050a0220.b8e75.4590@mx.google.com>
Date: Fri, 12 Apr 2024 02:32:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5728670431534811900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hao.qin@mediatek.com
Subject: RE: Bluetooth: btusb: mediatek: Add usb reset for firmware setup failure
In-Reply-To: <20240412084128.24452-1-hao.qin@mediatek.com>
References: <20240412084128.24452-1-hao.qin@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5728670431534811900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843929

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.48 seconds
CheckAllWarning               PASS      34.55 seconds
CheckSparse                   PASS      37.69 seconds
CheckSmatch                   FAIL      35.40 seconds
BuildKernel32                 PASS      28.54 seconds
TestRunnerSetup               PASS      512.68 seconds
TestRunner_l2cap-tester       PASS      18.44 seconds
TestRunner_iso-tester         PASS      28.77 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        PASS      109.71 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      15.11 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        FAIL      6.00 seconds
TestRunner_smp-tester         PASS      6.90 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      27.50 seconds

Details
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
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 2                               Failed       0.094 seconds


---
Regards,
Linux Bluetooth


--===============5728670431534811900==--
