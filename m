Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0480514277
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991888; cv=none; b=AdmLY6N631NHQ8Dnb/LUtAUERfLPGeqLLasBZ73Y29g6lXNG0CKWPTXdn4iXD6Y6Yv7xQXN4QMZIk7cd0uUClzU3vS3mLGEzjtftMvImzcnvOZW04kuBrMiRRYwez+sFxcXiK0Bd460PSvR9Oaj48YjK3C4Uly12p7VBeDEqBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991888; c=relaxed/simple;
	bh=SQNjWMGn/mL1HBBWdm9jRZETcLJuL3Q5TyBQypuHkFU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nPLowTksKPnBwO7mKqxDA1T48YRaU/JWB8PWBUu2yTwpZXISiFndsf9TyhROPH9di4xiOkHKmloDTulongjP2ZDql9fAU99y9EWcREbFpYwEM+8hHU/gjEgUP+9gThztrocknoO14hl+Hr7g/TWtfzpK8csWw2ydHkZBl36hPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvvmEeHf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvvmEeHf"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d42da3f7so34532285a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721991886; x=1722596686; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vsDjhHZ/VE9oTvhI+Y4/onzEFTY2evN+5rTHXNCfgGQ=;
        b=BvvmEeHfS0Fp2BBSWk67GVKqmf/mMrnLRvMhhvMZQkK9GtM2ZU76ZJoAeeqGikCnZL
         uejGYoeAtZF2j2I/uTtefbf0tA1ofhH623RntjRN8DtvlueSvHoOOAGLRQ+DkfcnmAzq
         cygouJIPlO6OpfSCClbsPGbBAPGsaQ7y0BDqCKNLLfv1rBrKq0zmXKZARrQHZX0S9sPQ
         xFwBTIOP0VbL5Y3sEhSbd+tYhUB6UT1TMaiKmEQnNwRCt16kFiVqJbFl9QeNHGmtjl4r
         egn9EaY+1dcSLI3WXAqXuhOYmlNowSX/w4NDcHBxHjG8SENB2fXzb8f8RhZ/5mog2cRy
         oNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721991886; x=1722596686;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsDjhHZ/VE9oTvhI+Y4/onzEFTY2evN+5rTHXNCfgGQ=;
        b=tWKgg3xb4z3UkkwY5pDqvMDcv1MIYkYdi/wH48uKmXGA6eaxwNojgHRXa8ZqoItwxc
         J7yYleEco2RJjlhdPgDg7bP/vOzB0//nta5a6YbMZwMXuFMztlutKuGw4/8EAFH2csuX
         hXnHGBzFfMHN3SwwL9WAjL+GWQ3ULRzmECQ6SBN4gj30n0AvBXCAT/oFx5zxO4VIfhzb
         g9qb2n4A/tvfBUUxauCCmrbzxo3E0seifbEt57+B1MiXqyTxvhGucxcQhiXG+ZVUx9gL
         vX0pJSlMt8UZgr717tJ6b8Bv8CWjxGY46oICZhnPoyDKfevLNn7UpXFRwyGAXteIKAMg
         V6ZQ==
X-Gm-Message-State: AOJu0YxFvuNdW6B9NPF1+xCru6tHDdrrhpMoWIloqQlQsi+ThO77JAzw
	/Xykmrn31vZLWpYEin/Ev2kp2leXmwb2wdjN+0kACA1TdTjBwIh31SDMWQ==
X-Google-Smtp-Source: AGHT+IHm+EB5k9EhdppEUYu6/z2lUbxnfQ+zpzIWvRdEJ4iVYDJ+8Ff+j3gFMDE1A7janQdvLuRrFQ==
X-Received: by 2002:a05:620a:f15:b0:79f:16b0:df8f with SMTP id af79cd13be357-7a1d7f0f473mr495697585a.48.1721991885735;
        Fri, 26 Jul 2024 04:04:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.189.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7446263sm165861185a.102.2024.07.26.04.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 04:04:45 -0700 (PDT)
Message-ID: <66a382cd.050a0220.5ad33.573d@mx.google.com>
Date: Fri, 26 Jul 2024 04:04:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5328704387345134882=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/3] Bluetooth: Add a helper function to extract iso header
In-Reply-To: <20240726104326.459668-1-kiran.k@intel.com>
References: <20240726104326.459668-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5328704387345134882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=874047

---Test result---

Test Summary:
CheckPatch                    PASS      2.08 seconds
GitLint                       PASS      0.93 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      29.56 seconds
CheckAllWarning               PASS      32.00 seconds
CheckSparse                   PASS      37.29 seconds
CheckSmatch                   PASS      102.80 seconds
BuildKernel32                 PASS      28.72 seconds
TestRunnerSetup               PASS      527.14 seconds
TestRunner_l2cap-tester       PASS      19.91 seconds
TestRunner_iso-tester         PASS      28.97 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        PASS      119.13 seconds
TestRunner_rfcomm-tester      PASS      7.46 seconds
TestRunner_sco-tester         PASS      15.08 seconds
TestRunner_ioctl-tester       PASS      8.02 seconds
TestRunner_mesh-tester        FAIL      8.17 seconds
TestRunner_smp-tester         PASS      6.91 seconds
TestRunner_userchan-tester    PASS      6.66 seconds
IncrementalBuild              PASS      57.24 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.100 seconds


---
Regards,
Linux Bluetooth


--===============5328704387345134882==--
