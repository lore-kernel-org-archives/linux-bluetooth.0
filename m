Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4D1F5FD
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972608; cv=none; b=cQi743AMf9j9XngzlsPXTkV8sPNve9aRSXerMo2jp5U38tifJO5DK/s2XvZCEPEQ1Quch9NXmM2a/60taC2H8Mls26LHmO9B64Sc/jy60TUcxUDGhmjgxzsxGpU0rxotn2WwhP6hv7ZeCtX3FSRVhuLwzedT3xwoavWn9RrdQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972608; c=relaxed/simple;
	bh=YCtNyJJ0Ea2CJniqomvws4d43PPrQd5ytpnVE4HJqbY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hpkLgE8ElFHxwKgoV+tEZyco/w041fPXzA/YZ7G/y4JukjQY0Nv1nErq0LUQqTXxu6T4oC1kFpPNR4qsSLAdmsNk9JUVP691ZUhCkywEnbGzLTpU+7i1hUl17XHtZVM7z93VtjfzUnuBUbe387/td1ACRE9EZUwwDURBMH/pE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UO8I1hDN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO8I1hDN"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so2719005b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711972606; x=1712577406; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YZaeQ9sH6iaY3jQwvAP3giCDURyf/+nnYlpkHjbf4YY=;
        b=UO8I1hDNU3fN+D9Qty+Mo1VaDzh0NMnJ9flejmZWjX1j2puLmQkzTbSZhuWHZPh3LU
         4znWoLjTO1ZL74Gr6C+2uwuzQ8YL9QhGkw7fD8UBbJCBvoRGfFpcsRyT0eCHC5W0rw9O
         jrlwZO7I7WDQFqGPOccvcX/QY1v2gJZPjMbNRTIv4sVAWsdO8GKsTtyLLt7uFYYWsGJ3
         2I2pu+xNChhKpggYYy/EUJxMJySX1B+kQ7EJKdZ4DcknESoIy/sEZLpjN8ODlcrkKev9
         A9bi5UjAB+AdW14Fmoytxl814+OgGnUvpaRZ3sJKoOxOdzwNbeJbi1bHjMqQAnkimNc/
         fhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711972606; x=1712577406;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZaeQ9sH6iaY3jQwvAP3giCDURyf/+nnYlpkHjbf4YY=;
        b=sU3FvJMIJkl2xgHFK2Q44QvLk8/YUeel44iTTcbKilPb73JBrapI2SeupmaLS2t2Uc
         84hV45FpPjl++cAlH3SPrdlU1ISKhlSDM1OIPu6Dml5GOPTLhtSMNgfvStuVFDwJvs8V
         flRnltq/pa35OefOW8puqEJ/zndZaEiEOQYuGudyBL1KqCuGZkA7nqMP6mnlFNOnmt3y
         KRZ5h0nogagrEnulDM+GAGUGUK/su1ucFmMO9zQsCIFa0H9+8ESPEAuDwxkKEdaB0rR0
         YJCc4eECeJHgSD0ifCk8ipsf1oCR1/bfwJ8iT9K8382VshlO3CbeWt2+7WdtUZ098X3J
         RyCA==
X-Gm-Message-State: AOJu0YzllYiIu/ZEuFFVpVUgI3yENdvrTz5+lXrPBKi/zAZKevH4GrkB
	a8J2Ft1oZwC16ofNSVSrJKBOZT1X57K3gYJq1ZoawFOEGglTMMMq6R1/WrJY
X-Google-Smtp-Source: AGHT+IHK0bB3tEiSs8hKfR9Zt3rGHYZ2e9XygT6Z/1aZd2XsBRzkzyw08LFkTLRELNtIUvrYmpzGDw==
X-Received: by 2002:a05:6a00:2d9d:b0:6ea:e8aa:f11e with SMTP id fb29-20020a056a002d9d00b006eae8aaf11emr11395189pfb.17.1711972605869;
        Mon, 01 Apr 2024 04:56:45 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.115.136])
        by smtp.gmail.com with ESMTPSA id p5-20020aa79e85000000b006ea790c2232sm7681276pfq.79.2024.04.01.04.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 04:56:45 -0700 (PDT)
Message-ID: <660aa0fd.a70a0220.9076f.29cf@mx.google.com>
Date: Mon, 01 Apr 2024 04:56:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3538722135122506616=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] Bluetooth: btintel: Direct exception event to bluetooth stack
In-Reply-To: <20240401114214.1082870-1-kiran.k@intel.com>
References: <20240401114214.1082870-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3538722135122506616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840239

---Test result---

Test Summary:
CheckPatch                    PASS      1.19 seconds
GitLint                       PASS      0.51 seconds
SubjectPrefix                 PASS      6.87 seconds
BuildKernel                   PASS      29.29 seconds
CheckAllWarning               PASS      31.97 seconds
CheckSparse                   PASS      37.61 seconds
CheckSmatch                   FAIL      34.21 seconds
BuildKernel32                 PASS      28.41 seconds
TestRunnerSetup               PASS      512.17 seconds
TestRunner_l2cap-tester       PASS      17.82 seconds
TestRunner_iso-tester         PASS      29.53 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      109.30 seconds
TestRunner_rfcomm-tester      PASS      7.19 seconds
TestRunner_sco-tester         PASS      18.14 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        PASS      5.62 seconds
TestRunner_smp-tester         PASS      6.66 seconds
TestRunner_userchan-tester    PASS      4.81 seconds
IncrementalBuild              PASS      32.49 seconds

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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============3538722135122506616==--
