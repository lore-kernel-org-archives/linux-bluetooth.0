Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE430DD30
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575212; cv=none; b=uejUsM5j5bdIzhLcrDUNQ+vovS0Kh+bQy+EuFn2jDzbIC6wCSDPRmYtS888wgwNpCSmg9pGBT4yqxYISBE6BAxbf5MXpbWZ7pPxgigeP69E0Ve9YtuzmiketIqf6fsuWPVKjLLwfgqfNuu5s9NShTBHriC4X9lVjEEA0PQelPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575212; c=relaxed/simple;
	bh=xP055PrJ9+zxmxp1YRnc2w09mEyE+56UUjJVfPhFlhs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b12fOO2tfA2tW8FT4huCFCUZtczT6y8UCfbt5pOdxk8kWGRXEXagTZftUawPW87fj8liDiJtRqgaWI04VLOMmFOAPLVOwECKI3OAKaFHIok5rX0eRGSdj+OfF34YVHt4xr31YACgTWQUltN/RE4fAxzhQLtvcNvMGnBuF9ZNrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2hoknMC; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2hoknMC"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8845498be17so73376d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 10:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763575203; x=1764180003; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mPfDjMD/NOsoKhub+UurgUrKC0ri+m+SYTgVWU1Tz2s=;
        b=B2hoknMCh1XzyY7S5R2tmxItcR+gnm5C8QPq34ipu3qCBVRNTOWBFzLng12VtLnxwy
         mwHsUbQhvKWbguPpsuEb2/nIU0GaYyT+at59KYzn0ynePPSBbFsTpyxO7BoonhsAcxvn
         kho2JsSlILTtyN5KhSw82v/zy1dHKjuaOk8U6/cflKGwMjIu0wFi1w95OvDk4PmQlS+f
         BmBFVQsbmugrjB+W9n7ClEdL+xuKEwCfxQUjgz4zLi1Hl3DaJOcRdyiQsUr8wlVx7/u+
         Ilr3KVStDCsbxpC1oEChn0fs6HcmbQV05VTSDurZ1oDebjiWRM7PcJk99YhWlgq1HiPB
         9v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763575203; x=1764180003;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPfDjMD/NOsoKhub+UurgUrKC0ri+m+SYTgVWU1Tz2s=;
        b=mJS8zpZC7eQMurJaT2i87Ouu2avGCQfCbnJggT4qGuGZyJCbe+lRP2ANFQNAMCyh90
         q5JuKjCZrELUkfVkXQWAIFTAEhurqMab23o2jTyifooi2V5/ueeSAjknLXhVdqXf1ssf
         PaY1Nt8BDSZdVS4sgjb4JUqaTCGcrp5WvPRY1pz58knjoMpp0sncALOXth86u11IyBzm
         ub5ZxUtdy+Xau96HiD3yY/kXiqzePBLum5BT7mCvmggLd7bw/J8LwlWa9A/BnjoVhyor
         6sEjJqzQI4HIqLJMnxAsloSMb/ph4cEUQ1vBUOvMdZbeZVauE4JuhQ29M0BNiTSTxZ8M
         Pwfw==
X-Gm-Message-State: AOJu0Yz9vxamu9ECnUxBLWFTXK6K/L/fsLsOjgpi/M+3BB4L0UzSjrTW
	B4Ky8wg6DPE+E+d7DYPrxXXtcuh2C9mWt64m+ERCfFT5GdbVxhQTRR5ahhOjzA==
X-Gm-Gg: ASbGncuOzZtZNwMnQQkVHkd4oAIcyfzcLDG62iTyPWwpWOrGBr3xUurYFHHTdPs4HY+
	MMXgLLDwpjy86u7pBtK2dLfS50Q7DIdvt9VcXtGUkWx2KcEr4anaPHnqGPi93W8rAMJ7LpmwQza
	n1zNxCLE2/Rt71R1lW66dFwJwyes78zrZFk5tbqT0Xs7zsqKu9ltvaP4ZFg3zct3cdmjQUjnIvE
	o7X1RCAd5uJODt8WoQiFUuciZyRZc1s1djxGivfuCAfLloduJYlFtIvUHffNYJNqia+SvO3yBpV
	3JPmD33APW0jSbgvlMtO1xVahiqf43NJYqnsEQRLan8RFpDh5IASFi6Fkfm+zGx8GL3CwcPnLxF
	/p3b7yD9SOlR4xzHmGwN2C4TqVxhAvAtmot3Ba5+JBOGI2x+PAJMbgKhRdgrxnvZQNY7UHJMU3u
	OEbNbEucX2q8U9NlI=
X-Google-Smtp-Source: AGHT+IGNHghJK2wXSKt81nTIrSy12NEuOQP7GhTI48RcJTUqfQoYxequuXAL8r0yFtJ2tUu1SRUm6w==
X-Received: by 2002:a05:6214:468a:b0:882:4e18:a7bd with SMTP id 6a1803df08f44-8846e1d78a1mr809566d6.62.1763575201822;
        Wed, 19 Nov 2025 10:00:01 -0800 (PST)
Received: from [172.17.0.2] ([68.154.38.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e4682c7sm65826d6.16.2025.11.19.10.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:00:01 -0800 (PST)
Message-ID: <691e05a1.d40a0220.147713.00b2@mx.google.com>
Date: Wed, 19 Nov 2025 10:00:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2228222384255876654=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dianders@chromium.org
Subject: RE: [v2] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
In-Reply-To: <20251119092641.v2.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
References: <20251119092641.v2.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2228222384255876654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1025451

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.37 seconds
CheckAllWarning               PASS      29.01 seconds
CheckSparse                   PASS      30.82 seconds
BuildKernel32                 PASS      28.67 seconds
TestRunnerSetup               PASS      549.32 seconds
TestRunner_l2cap-tester       PASS      23.95 seconds
TestRunner_iso-tester         FAIL      41.90 seconds
TestRunner_bnep-tester        PASS      6.15 seconds
TestRunner_mgmt-tester        FAIL      113.94 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      14.44 seconds
TestRunner_ioctl-tester       PASS      10.01 seconds
TestRunner_mesh-tester        FAIL      11.62 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      6.49 seconds
IncrementalBuild              PENDING   0.52 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.102 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.207 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.961 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2228222384255876654==--
