Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C330149B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144748; cv=none; b=KadBwKK580HKmp/o9l8ifX/m4uFImQQ4otaJCRQg2c7+YETnoGimAyBXukQJ3XAYiOndl4xQ68cW5/reu2vrjBpUqspabKUrRJM4szpvEeK1OuSfR+Spqcw5Xy47L+zAIVw8wo5ON8mwCzUErnNdN28wA7d1BpBiA9JyfabYYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144748; c=relaxed/simple;
	bh=J4+lQbuLcE5hrd8Xn5gGG+sT96fypA8WNE2vBPY3sxc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nS62r1GO9uPKVB0aMZytL9NL8o8yZgdmoxBehBY2I5w0HEBOT9PhORHm55jcxZ3voNiOjue/8bWGepar5ghoacgcjFloyhF+3NkafOHB/ZGytY2GGB9Izu7c7Ixv2z9wSnS/HtXtmKl+uX+suHTR2xhWUDgjB6VM3wxovEs9gRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQM5uoES; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQM5uoES"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-246ef40cf93so8626495ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756144746; x=1756749546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMk3j9hFkuEDmcLaIxARhTZQBpLJh2hm+uTR8pjry98=;
        b=BQM5uoEStGdWyXh0iYbFAa3bp6SwVrSwE/aV3FqwiIBq+MMjl1UY1xEjZ+vozG7Irn
         tF5hE6i2y4CotRWWqGoF3eqTZ8YdsPxc2UPQ2+f0Gg74uOajiy75S+d+rAYMkqBYfcxa
         1Z1Zb4fdoxZOkGpowHRqCSBEkwAuhynFFoGQ71uW7BhunrwIUnD8zy5PiH+t5XGZLNbK
         taZyqyrJ2vpQid4jt6b825sGQ2vE5KAlZPQqxStOyskFBglGnrJrM5teHG+WiyeL88Rq
         r1WjGB681BAvSQcNsbsV2Fum19e14B8lRzdbFqNwKN4PyMoU9mB/1paPH+CYo24TYIND
         8lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144746; x=1756749546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMk3j9hFkuEDmcLaIxARhTZQBpLJh2hm+uTR8pjry98=;
        b=W7vRA4MsKdp4hRtzVGFXPvzeRZ9FXWjwRbWoAc1pPLi9zzcSWOVdYdYuWSEsuabWRh
         SuyVUpTDLJnMBKAd0VLMDUo8i8CsujtCLREfRZbcIPa95gDZn9yYH2iYbRZok2G46Evr
         rg97d8VqRfKMwxDe7woGjmdfvZzVvlZywU1jgobpcs9IMHtcUapm2Pv83fTD0XwZCBdu
         9YqkDRbII22kx2rWHmMFKydTKKQGqW6yAVbQ9YJbtwoT6WcbAZtCZrncSgBmuA0GxOeR
         fDe8HkSgytAqty28FPhCVk89U80PbDFM6mwLz5Dvbnn3xx87hV9KrfH5wgoZFK73FVVu
         UE5w==
X-Gm-Message-State: AOJu0Yx9z/50q+sCrmLNG6t7mY7pgAAEulyrB4MetAyxFh/lqBpxFnYH
	TkxV8F+f06wmOVKTt3io5kpJxCRP6wesQqhBK+WFFGfIGloT+m+1bypDh3EwIw==
X-Gm-Gg: ASbGnct60mvEMe5A8XRhgUVcDXOg3fVl796wUtTelM9BfgZlJtydcHFzfisBakP+1ck
	4hQwSTLF5wwc6UkeWeylQ1lrTs+uwshXpk9aI2MHaauyQT3WnGQ+sDcsEZB3Re28VrqruebpLc2
	QCcBt/TkPEyGwitXN4K8V/3MyUYDk6/x/L/XoUtRIBnUg6oRddMn6vSxZwvIcxvE1Qd7CybGrAR
	ZTdsWCurH80Su/MBBhMMtJzBLgEbQV+suez2efb8Rf+1Q84zJ/+YHaJQ0oCaoK694uWOB+1gIHn
	cM3VMJiHZ/+d/5r0pAswQuaghqeF9/RMjAhjUPSrFnGJuJ3W7WNk5CZfS53xD5JCV/t7UqYEvtO
	akJoxkuRMd4Sk9bqW/ob8ugN83VEJEw==
X-Google-Smtp-Source: AGHT+IFq+g8fOaou08xTPtYccxEdrEmQVqXmkqusJbpgNftg/If6lI9SXxicXnDQ08HgCiRAs2c+1g==
X-Received: by 2002:a17:903:22c5:b0:246:61e:b561 with SMTP id d9443c01a7336-2462efd975dmr181149535ad.58.1756144745642;
        Mon, 25 Aug 2025 10:59:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a06esm74090565ad.31.2025.08.25.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:59:05 -0700 (PDT)
Message-ID: <68aca469.170a0220.2caa0d.869c@mx.google.com>
Date: Mon, 25 Aug 2025 10:59:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3622052434545652213=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: Bluetooth: btusb: Fixup quirk for reading ext features on some Barrot controllers
In-Reply-To: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3622052434545652213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=995337

---Test result---

Test Summary:
CheckPatch                    PENDING   0.60 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      23.90 seconds
CheckAllWarning               PASS      26.53 seconds
CheckSparse                   PASS      30.04 seconds
BuildKernel32                 PASS      23.87 seconds
TestRunnerSetup               PASS      477.43 seconds
TestRunner_l2cap-tester       PASS      24.95 seconds
TestRunner_iso-tester         PASS      40.75 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      125.99 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         PASS      14.71 seconds
TestRunner_ioctl-tester       PASS      10.02 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      10.82 seconds
TestRunner_userchan-tester    PASS      6.25 seconds
IncrementalBuild              PENDING   0.67 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.102 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3622052434545652213==--
