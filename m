Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4061E491B
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120101; cv=none; b=XS/N6gpiytVzBNOD6oQhemdVaL5oeUdecdDREJUWa3zs41eemBCPwoEZsNzE4OY5MDhLLvzjG78mpBu2rsYB7D8YCnCyWBtYFRmPkmQGJPVdxk8udldg181In6eeKZ9uwGqNwONlX6vUqEY5/czxmVWXq5WlSCRIne/lxfxdaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120101; c=relaxed/simple;
	bh=T2TEhQWSciKo2B6ifMEIFIFjyhUC7SmWCNP35id35mA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Uqmjx1+mhOimwtje6juy9zGX8cMCYuMaG4Mx4HHRJMPVIRobrrq+OCMvGkHGuw2ZjyekpqW0F2x0RgxG9aJqpWDzGD1dvi7xFAqHWDi925UyVBh3EqMN6fxmVvf5ynuabY3fGJ68gUBSGrSQGsnK1fgg+64J4mVlbaVQId9B3yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw82brx7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw82brx7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-309fac646adso6076011a91.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747120098; x=1747724898; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=svqTayZ3sD8js2MAU3J9TAAgFn7Ao7gHMxiwN1/Nek0=;
        b=cw82brx7zVBAsiFPeAdnwHX5KAArt49t+jK+AmUTP5z7trrnwSDe158aDTYNtEfBEt
         eHCX5GEpwCFFWPdtoJZFeIQxHEeOraHvuu5ffKNhGNSvFK/aYQrsIN0oprWGN4gW+73P
         RU2+2QwYxiX3r1fY+bxAaiNR2Yyo8fwmIRqr+34IkYgQQ9xfcOeQfHkeh4uMqMdRE5oL
         CFXDl0rkCN74xlcMtTtNaKZQ0vtuMx6IyeNAJhvK5664ELhK6RXHlxvKLz4RWfko8OCH
         8aDmSX/EL1E0G2w3CxQapM44h/rxepxe2rEN8B1fKeJBrElt/lWPzsvD5F+/Roq03kmn
         UvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747120098; x=1747724898;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svqTayZ3sD8js2MAU3J9TAAgFn7Ao7gHMxiwN1/Nek0=;
        b=wxGgibFX9e4BCwcKQCHvRBHRQ4SfryjHNaQjXPZpZaEnn934U4/+dzT355XZ6NSvfi
         RyjOnITOPyvo7H1Qk+L22re9jgznTdcKLHmNbG1P/Y+qtz+EAhL9wnSmOimf3Dshw/8f
         bJVxFDXI6OMk1qZ6SBmeHWzfkFOVtlRk4aOnHyUWhD1ZAzIxZKQYU6umvM05850YN5LP
         Z+JErkZGpyGCEAKWS6sQCaannUsZodiqgEgY2cAUiDpibDl6is4NbvF1LVv9mRHohpX0
         LnY3UfKufPfC0Wx4pfXFR4zYKlDNaOlSf81Hn1vxgmqQS0CO0oUxJ7dv1Osg2e2dAzku
         idYQ==
X-Gm-Message-State: AOJu0YyWqFUdh16+sQ0OvRMdHXVcqraVjNW9TtSAbtsmIMhjd56rdxEt
	jT66RKZwutGl42EAk7+fbLbK2gpka7iU6O/06sEye6CYfjk+03m4kjuIPg==
X-Gm-Gg: ASbGncumAHNel7dcnKN8NSEiDk5L89CRfRxJXnuDX0VUcCpoSqg4TlSREyZI0iEth/E
	2uH7izsPa7yaeeMSs6VYmyglj94wKnRonjsVtgJZiawEk/fyQcDYQSmAy8Khl8NNIDmhgelk5+h
	5hWe0RrLrCNMlaSiEiXcL/HAjUOhSceuuWGTIuPBdcFbwPYOGfirDhX31J5t+NFgZw8A1Ej1t6X
	4p1SK8t1dY5qbdij7gbeytSeW4rjn1q0yEwEBGA2jPlmp5eD/3xr5s6k3UswcESi3osiHHgj4jF
	13KDxNnxqCMWdUnAOXmwHtFmCOawOmc6sVmorT0jBNz+PeNKVXm7VO5A
X-Google-Smtp-Source: AGHT+IFHOdv+u6khfKhBgEgwpPglnU8/e/ePDG+jnePqPtO1oEy5BQa93QSbihS6Nv1TtLHZ678pdQ==
X-Received: by 2002:a17:90a:da8e:b0:2fe:93be:7c9d with SMTP id 98e67ed59e1d1-30e0db064e2mr3325289a91.7.1747120097810;
        Tue, 13 May 2025 00:08:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.38.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d56981sm10002948a91.28.2025.05.13.00.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:08:17 -0700 (PDT)
Message-ID: <6822efe1.170a0220.27b472.b195@mx.google.com>
Date: Tue, 13 May 2025 00:08:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6713155186595844627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sunliweis@126.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
In-Reply-To: <20250513061353.13521-2-sunliweis@126.com>
References: <20250513061353.13521-2-sunliweis@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6713155186595844627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=962284

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      25.78 seconds
CheckAllWarning               PASS      27.90 seconds
CheckSparse                   PASS      31.67 seconds
BuildKernel32                 PASS      25.25 seconds
TestRunnerSetup               PASS      475.03 seconds
TestRunner_l2cap-tester       PASS      22.87 seconds
TestRunner_iso-tester         PASS      35.86 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        FAIL      122.67 seconds
TestRunner_rfcomm-tester      PASS      8.10 seconds
TestRunner_sco-tester         PASS      14.32 seconds
TestRunner_ioctl-tester       PASS      8.62 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.22 seconds
TestRunner_userchan-tester    PASS      5.13 seconds
IncrementalBuild              PENDING   1.06 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.215 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.197 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6713155186595844627==--
