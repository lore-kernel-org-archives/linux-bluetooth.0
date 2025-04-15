Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187F146A66
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736653; cv=none; b=P8lCMNlwB+gWfBP+1Ezvrt8QF6Mkj20y6JwhE65bTobvrPw2LTx64PU7hZxh8oMjpaCH5ClmtClzstSLddaONbYgZDGwnm/je+rZXxiT8PCyuZxSeHcmMqlBRUG77Poh482UaLhwHQVQwamcbk8x5IgYoRdey4F6D/lrZP2LKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736653; c=relaxed/simple;
	bh=ZZhNfeV99yofBi0vHFbLNv8/SiUVzj0tm/V4n0sdAdY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tf4xK7lfz9hDXuMzZ7OwKhbafSvwwk3DahuLMNVcncye3kTpoQQDL3uFXj/W9Lqqiyu8EgRwVhTs46NYCFjP6MSvGQuYm3DubjIm1vMTPlgiNn7WVEm7vpgKXUeTSye+dVC1deqIWmUAdZ2nIaBso02WTG9nouVssM+yOCeZXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAOuRRid; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAOuRRid"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so67034676d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744736650; x=1745341450; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j/f63C7ZDUm4vqDbloxMG7spJb1mJ6NiQNQv/radAaw=;
        b=QAOuRRidGOyPTtIDnx0BkuR25PHHcPObIEjnBsODj727dd44ARwcbcQ7h80uLdy6y9
         oVcGKw7lZhP+4PvsG3KTxw9awT5aux0oL01dK/pTGkbBtMk+c5UkBJUCwzgYqlXkZsYE
         dkBZceUMwaGjgLdiUZzoCIngYJ0Mo7XZbAvNdzjWiLSXnq/+tV0q/vb4I3Uua24aHnyL
         MwCY5Zr57lN3OP8wsSL6P4ZaUxyGISYdg8PeT2T3YvhaLRixhQaUgSNHypca8/AcUAn/
         FRhFJV/fJ6GmII6dw/b+1Z1kzMm7805Ip4we25BjWPRUBxQptlDaQMZ7GDXwW89BB6Oj
         o5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744736650; x=1745341450;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/f63C7ZDUm4vqDbloxMG7spJb1mJ6NiQNQv/radAaw=;
        b=dkkSc24HlBMt3u0+fUFxlQswv1Yj66Lc/H/pPzsN8dUe5bV/gR6t+ozTcDM8KHTVeS
         MVJwJSRFzso/Ki6SGr0alIFK24+eSXQRypOEDAvIbrm8Gtct2Pe2ul0N9k9VWk3T4Px4
         gLuCYGUaovpCY9OH04G5KkAVkZlQlMIrfdI5GSBKCFvy02uNOl+1C5NXbKPGSurlK+1K
         badI2Q8pZBSfX1tcAjOQ5xNlFc2q7pzHR8/4a1JrFFL+VLquJJNwlRYnmwA76bXWnZed
         G+9X6yr1oOZg3Zc4LAFkMbKTYizclYiqtk0IhGdMri+c8+mYb8tlriib5rVHLhpEKKDj
         Oi8w==
X-Gm-Message-State: AOJu0YxOQrtVkJ6NLBTjf6IBNjmCoh1ZpLpXLw4tzkgxb0/eHRf6UPcv
	x+Z2VIAZ5prvvz34+/KIuoDbEjjOaBvLF+3n0okXNdJGiOeSIxDkf7ASVw==
X-Gm-Gg: ASbGncsu4HnqVkXBCPHN7elRAuULHh8pjxCThflM7zfYU/bdHhqbAFp3hYuLJD4Ov+o
	Ac/kG7pxBhssKf4CWVT0+GNZN5ht3aWustfDAkDkl82MSRzj/WzKLW3RYqKD8i5MXQ8OTBT2rV3
	icgtg+KX0wkfq7yY9EpETizFHNjstQljbShOQIAjeSqI1yb8ro9ylHhWOXxqAoLaqL2yS54R3nv
	a266qRmiOky5FILGfJ2RjkJZYJxZ1pMJL/alHfieJi0MYG1xJYYVqv9i1oLjglHVb1mSCd17gzE
	H1dmJTrCGMPtf0YAQ2J4tcj1ni+cdhsgVJvRH84oJH6H
X-Google-Smtp-Source: AGHT+IF4ii1y/phrW8YY7U/4ph8j4vr0KJyeMTClQTTVQnOuPSMjPCxM+IURGe/mD8yiMIyhu4K3XA==
X-Received: by 2002:ad4:5f07:0:b0:6e8:f770:5045 with SMTP id 6a1803df08f44-6f2ad9747a6mr3515886d6.28.1744736650300;
        Tue, 15 Apr 2025 10:04:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.79.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea106cesm103316216d6.103.2025.04.15.10.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:04:09 -0700 (PDT)
Message-ID: <67fe9189.050a0220.3238e4.a78d@mx.google.com>
Date: Tue, 15 Apr 2025 10:04:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8002397388483491234=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kees@kernel.org
Subject: RE: Bluetooth: vhci: Avoid needless snprintf() calls
In-Reply-To: <20250415161518.work.889-kees@kernel.org>
References: <20250415161518.work.889-kees@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8002397388483491234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953638

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.58 seconds
CheckAllWarning               PASS      26.80 seconds
CheckSparse                   PASS      30.60 seconds
BuildKernel32                 PASS      24.17 seconds
TestRunnerSetup               PASS      463.69 seconds
TestRunner_l2cap-tester       PASS      21.37 seconds
TestRunner_iso-tester         PASS      32.87 seconds
TestRunner_bnep-tester        PASS      4.71 seconds
TestRunner_mgmt-tester        FAIL      120.00 seconds
TestRunner_rfcomm-tester      PASS      7.85 seconds
TestRunner_sco-tester         PASS      12.70 seconds
TestRunner_ioctl-tester       PASS      8.43 seconds
TestRunner_mesh-tester        PASS      6.25 seconds
TestRunner_smp-tester         PASS      7.33 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PENDING   0.84 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.147 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.183 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.185 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8002397388483491234==--
