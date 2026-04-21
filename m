Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2933F5BA
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777584; cv=none; b=aJ5Dd4WGPKMCyGgp/Mqi9j0yW+XzEUK4hJLFnqfXsenak0XqSBEoM1yEoEa1idITzNDACWmHf5hBqN9B5ru+jfo5HSR1vANeiv5NYRnL/rFUYBn6XpkcF+Ucp5Y8/2E+jMILVqQ12fXAzyoPw3ZV+QEvn0E3JcUNp30Y+gyWIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777584; c=relaxed/simple;
	bh=kAMr0m0YAe43/flRXsvpQ/EY/9oTRipUubFlMwwvx8I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jb43aRz9C1shrZlVoTPsedtD0fH4K5aCeUlcl0+lddsfrJjjjN6++BH4uk19PeLNI1iUUPFr2bglCEDuuo0DDvQEzH2+/g1y25W5xLv0+UsIXcSCTqg8jTmmidZEIwTmN1AEJGGTNQGyZfnfTKnIx3qRMjx29M61ilaQqPGTv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epMfu+tD; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epMfu+tD"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2dee127b3c5so5221158eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776777582; x=1777382382; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m6f7XHocxFa5U6UlG8MPdLHO8XEDhyzP90coN8YU2S8=;
        b=epMfu+tDbCbpo8PqnZIBhCPwornM10lVMXi6xy9mxRDJeUZQ5K9uT29NHpzDu38yYS
         67/D8m4jezqB+Q7NHBemVuGsc4v5wf69Yq9/eRV1bMpUKFPvJnA6XNdzQ6qXdVvJ6Scd
         BcJZQbgwBiJL8gtiSRo+o3yUNHt3RwAL5wNM6KY0QcY/Scn4rnCbBiHj/hRKPSqBql22
         X+lSf7uDiHU66kNtvDp/CRjzhQSWIfQj1VK92UDFXw+n1BQVydRNB5YPLgTbX+j6Y7m/
         ql9yz3NXNdWhJbP/mMw52zDLA/KVkrhi6ddkvdplwAQV9DLQe7eBcW7WCHlK9UbuK5tC
         Armg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776777582; x=1777382382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6f7XHocxFa5U6UlG8MPdLHO8XEDhyzP90coN8YU2S8=;
        b=C5Du1lTgeklgR896Xoibu3G+0ZMI1Jf1hg3fR3zShlczfvK1Mb16VYTSymFKiZXib9
         r17VVcpB3JysMRZWAmUhOJCPH+u39+vZVcrGBw5A4Lts+Eqpt7T+MwgCDWjohhaGs2uX
         poLkqVMQaqV6W5Za1NI2N/LjfuOBmSolaz9Ch+HhKlm1f4/wOH9KFYI29wKsCwlrd09s
         lJnWws3j009ChsQfMWww+O4Cb7KMWcV8+tCziUcQFWI8awZX/Y3tFT+fHv06RFYb3ZC2
         LjjRuRGzGaLwUQHYQ0dk05xGRnPOsRPmbnHdZEIb1h9uPK05US8zBlrUtTePu4bpZ6jo
         /I6Q==
X-Gm-Message-State: AOJu0YwTVWZN1fvSra5dMCBanCwLd9PfLsaDBdEersz24tMpj+1XRFXl
	la/cuc63sn9gYR6BZwl2sQZk7vV6BmuRSaGqTBPxWwkZOYL2F0148xF2gcZBBA==
X-Gm-Gg: AeBDietsTSi63sI41PICrKIKoAp2gsjQ9PTzgNbi8aBGu+/2pGA3fZA33uoXtQ5RbBy
	wSNE+2FrsqVVAY8qnISKbuyl0FSZZIiCm4TPia3Xux88BZL/DoRdjxDEhhyNg91Jb7fSsM/epRS
	sTKO26L1/iJpf+79svuQ/EjYnEAUcM8PrS1n8Ylury75CTOz5KyXoHVDusSHaEizmcY0vUTa3Je
	b69Al+FjOvAGJobPnryACdxWaOhqhBlOaj6vsD4sWY9Hj3EfMRsgaApQXowvw1JzqFQUMXdnfTo
	3e4SxTlxDGp/hEHjsnaHnwWFvr72airKlVOv7GGq0ehnzcidQG2FrlCdSA9NQ1lvKyhQcYtetP5
	CS9BxKlgmN6WHVX87h7SqGAaYweDb1KQGsvuQskSua1MRFSgqup3o882p84D6eEiYnlL9qxsEwW
	mrH5RKlTRccXyjX4wFbfp/OPNvEXFyVETo5L2kYETt
X-Received: by 2002:a05:7301:4185:b0:2d9:fa9c:87a9 with SMTP id 5a478bee46e88-2e464ea79b5mr10076229eec.5.1776777581994;
        Tue, 21 Apr 2026 06:19:41 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.11.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfc1dsm18334289eec.22.2026.04.21.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:19:41 -0700 (PDT)
Message-ID: <69e7796d.050a0220.343b8b.e3eb@mx.google.com>
Date: Tue, 21 Apr 2026 06:19:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0890126375121706345=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aurelien@hackers.camp
Subject: RE: Bluetooth: hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized
In-Reply-To: <20260421135331.15425-1-aurelien@hackers.camp>
References: <20260421135331.15425-1-aurelien@hackers.camp>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0890126375121706345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083813

---Test result---

Test Summary:
CheckPatch                    FAIL      1.16 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.17 seconds
CheckAllWarning               PASS      29.88 seconds
CheckSparse                   PASS      28.56 seconds
BuildKernel32                 PASS      26.33 seconds
TestRunnerSetup               PASS      586.79 seconds
IncrementalBuild              PASS      25.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized
WARNING: Non-standard signature: Assisted-by:
#96: 
Assisted-by: Claude:claude-sonnet-4-6

ERROR: Unrecognized email address: 'Claude:claude-sonnet-4-6'
#96: 
Assisted-by: Claude:claude-sonnet-4-6

WARNING: The commit message has 'syzkaller', perhaps it also needs a 'Fixes:' tag?

total: 1 errors, 2 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14532478.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/110

---
Regards,
Linux Bluetooth


--===============0890126375121706345==--
