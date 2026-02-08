Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245F338F35
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770537477; cv=none; b=hu8zsinH2GpXCyk6NqYjfZAzTC/DQpvfwPuseQ3NrzO2pGxl99KgYm1zyGNRgduvQNEgdbhyeiy2hiVSsrwgDoXDSFiterhAZbdg6xPWtD3FbTWwpSsSRFGEpadR05rsvTmo6HDxVax2+0FbpQhuyhyBbx5SuXmyBXbOrb1rHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770537477; c=relaxed/simple;
	bh=ejnQ5C0K0+O77ts1TU+vc2o0ZF2V6f8te7xz6TgY41k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z2aIPwHAZCFYFaWygyxq0p5HtM8SjJQTkfirDPrT/LVXEMAZ9opqaP9XFSRiFtLHCkE3CWHCbbDkKtTDgI2HaZdvEjSFlUgTaKQxXCgh8tVLBj6eaAFR82mCeMEU1upsXo2TWXp9kXf2dxpvi0HiaDkgNOvq1f14sILQoGgB6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HislqqQ6; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HislqqQ6"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-40429b1d8baso1125587fac.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Feb 2026 23:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770537475; x=1771142275; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B3NL/9URKDVayAnZapspj9Fr5K0GDxpPRNKi8lBSozQ=;
        b=HislqqQ6wTj4Fqcf65VxHjRjuxKoA2UzsNRaC/jdJ5e38B+jjfUAu/jvgjSvvIx4Yq
         PkbojO3bYOB+6QTMEK9x2du5KmkUxdlFabl+p5XCziNXdmEBOjG7RldPuTWZj6ifIjaB
         0j40wCMsBxuBzET4G0k2SuuEd5ygioEWav26WGAzyXI+NbnmJPR2SkBiDpEzWQHbk7kh
         zn6IC4pZ7E8QHlcHyjW1byTRBKsyrCyuhIJmt/JEJFZ2a84yZhcr6OtNgdtE/KrxfuhO
         R/0G1I4XsTA9/REB/i/7dAgq+lhB0QextRBuStgF9AXAsdvayP0MBzRO26Ljzay9Dr7b
         9joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770537475; x=1771142275;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3NL/9URKDVayAnZapspj9Fr5K0GDxpPRNKi8lBSozQ=;
        b=xTczsZg6HE4efE9FblbmqL1bTrDyklPIP6PRIPvAfup54Xwr02GTq2WDVMquRxKvh6
         gjFvetXEYJxFH1/6ZnWWkfF3bU8dPmW8od/DcCU0NlJ8QQ0ZZhMXVi4f2FjUN2e9PfgW
         Lm/qge/GJNl46J80NXii8cfiuXasM90X/f957yFu4IpZbpkL6YBjx2NBZKQdcaG98Jyr
         G+/daAgcb3T7OdiOi9ILs31nZX8JJBtsVZQsqopx/GuH93AzH0kzG+QNCzlum9T92EM4
         YpNQBlxtcuHkC8NJY/CsZ5O8R3+8++VQCcgnqEhzsf0Nu5HZrTLCfRAQhLYzuLGSLv6s
         hgKw==
X-Gm-Message-State: AOJu0YxrLlfijpoNXZGlCpVSWPBsnyd4uQHwpacgINwiExyerje7QPJl
	M79H/l/UIIr7UoCunQe7K8lNJmMWoFkmwgsvCWnvlp5YGHLFOeuz+w0zZ8xT6UAV
X-Gm-Gg: AZuq6aIwuDg4JdVRHb1p6eI3gd9MQikLlV76Fg+YBu/93jRlqB/jm6+hatE+YjfeaTm
	k/Zi5CkNhnhPmlYa4Jul1//kuV8YJRh/cAumTZhUxMqtoxGQ7JSBMcduAqYP6e+8KKha36GYuWm
	bdus2fHE7kvnPJTYosn4lHiXI+o6UgxMwIcC3fphkmAXCBw4Eyg2FoaQ5jW/2I/bkynuyvCXHfy
	hRJ6fVtN/bpX4JwlHXdLwMFij849GdPgJ1i3GXeluW6EDijlazVfI0qJ/Sxk4XICnIir8/K+04p
	23A0/dJBckiNpHV3ofXxxDhYBICWdsSYMW7BmAJatlDQ748QMJbJo711FuggIQjgFE6X/+fA+zL
	WWjyQdm8yaHC0OFRG9XVeFRDorW/bDq7Cs7ISzMf8GqrmkcZYID/LsitfsGXrae9SmqJ5iYERss
	LHJlEdR1T9x0Ce4O6yhw==
X-Received: by 2002:a05:6820:617:b0:659:7e1b:c247 with SMTP id 006d021491bc7-66d09abf091mr3776469eaf.3.1770537475188;
        Sat, 07 Feb 2026 23:57:55 -0800 (PST)
Received: from [172.17.0.2] ([52.176.125.113])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d3b2a5aefsm3816930eaf.13.2026.02.07.23.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 23:57:54 -0800 (PST)
Message-ID: <69884202.4a0a0220.2d1ca0.8c4f@mx.google.com>
Date: Sat, 07 Feb 2026 23:57:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2148525945527444818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maiquelpaiva@gmail.com
Subject: RE: Bluetooth: mgmt: Fix heap overflow and race condition
In-Reply-To: <20260208064951.41392-2-maiquelpaiva@gmail.com>
References: <20260208064951.41392-2-maiquelpaiva@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2148525945527444818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1051963

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      25.68 seconds
CheckAllWarning               PASS      27.92 seconds
CheckSparse                   PASS      31.37 seconds
BuildKernel32                 PASS      24.96 seconds
TestRunnerSetup               PASS      556.32 seconds
TestRunner_l2cap-tester       PASS      28.56 seconds
TestRunner_iso-tester         FAIL      56.63 seconds
TestRunner_bnep-tester        PASS      8.25 seconds
TestRunner_mgmt-tester        FAIL      116.21 seconds
TestRunner_rfcomm-tester      PASS      9.73 seconds
TestRunner_sco-tester         FAIL      14.53 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      12.61 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   0.64 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.100 seconds
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
Mesh - Send cancel - 1                               Timed out    2.780 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2148525945527444818==--
