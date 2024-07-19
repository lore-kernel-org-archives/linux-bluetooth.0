Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFFF82D72
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721385267; cv=none; b=VxPAUkNqZa4q8vtr2mS9MhynhbnQ8FU0keNtPeQvuXAhyXPPtGrzoXYkC7m9uZA7o26WE90xwJw9Y+kCeOC+qI0Utb/fVmpASyc3/t3osE3/bbQvzCJkD7CRIA/sPVP7jl8jKEfFpJF7wcdF3yIyVCwbD58Dfnua31km8cu/RUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721385267; c=relaxed/simple;
	bh=PMSyVEk+g5zqHKXu9mN80pmjqvWrId9Bl3JxYPQGM9I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rGRgRs+cjAN2LyfmIuMN8XnR6eWFUEXzefuHWZV7/1ukm+9IgJj6xTsSf8jX8xZmsx0f30y1/wHKjphgOTlm3aqjIAmDaEf8xnkga7WZZiXwb71QuZ78BVfIGAch9CZx10l2mcmzX5gfO2buBwvTRj2WwhnGQ5RK/TJp2oma/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLVnRP4j; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLVnRP4j"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48febcc8819so595826137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2024 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721385264; x=1721990064; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n/OaaQ8SwOHoCes9Y7wyVFDyBHKeEVgD9+YEnJ3KM34=;
        b=NLVnRP4jcfXH7ceNnDUARnASHLqtr+w2cZdF9vhqynWcXrMVzZnz/C6I2+xxAngepH
         BgaIgFsvfHHPPua95So0rBgLkEiLDc+Wf9twzaaHsqAQdW1ktedQkR/SOtHGIFdVQpyZ
         Da3iEztnk4mF3L7PeqG9YrKT7VfN7YL//rol94yD+GGGH/vC+7t/7PpmKFWAQZnd/ga4
         KWaIG9VA6S0xd15uzfCm1pTAcVHe4L/VBH2xSWICg6BImIUed8aVYiuGPNA5S6lA79r5
         83wPiW8dJ5pLc74xPWwTLIdpI42DNGe64JXURByH1HnPMQZy9htrACGy2PRQBNUJ23+5
         IgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721385264; x=1721990064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/OaaQ8SwOHoCes9Y7wyVFDyBHKeEVgD9+YEnJ3KM34=;
        b=tj8wkHDMkXklNpyOc9LPi8YfJt84auwnFg2LUQP4Qs962FwyjiTpedv/wOdNG/xazx
         J9zu/zNBi87+KTDuAu52lN78S4G2bnB43MNigx4fZuHQEP+4DU/ImuPR35eSrA5t7tQw
         CJw5n54Cz4aghoYldnSu3gsf/ktHnvJfwLdJkDVYhFsToiXQFpN5Rxr4NQ7Y7ek3SAUw
         QGFl4UpY0kCOgBBwFfZnI1aFy8qmPCXm8y9JTIFnUi+/gMdLZwcbOxK1PEYXydpE0Y3m
         piLn/5hl3XQWhWw+WmUVrgHELNhwF35YySa2d2jmchM+8V4KRgxV7IMsjPRIxRJ0EvqS
         QvUg==
X-Gm-Message-State: AOJu0YwfYD+sJPmyeBg6PBHb4KsNCnB9FWbEwHn/is/KEnjmg3FhA0fW
	7suSkBy6Z0a3JIwIz3QXUSKIVruvwf9TZf/aAxpCxc6uXn0DcEL4hjn9Aw==
X-Google-Smtp-Source: AGHT+IGDRf+JNifeVrtYwdieUJQfZJYULNi6x9W5HnF6yVsyP5nb04F+VDpDXX3fgFq9FizMw6h9kQ==
X-Received: by 2002:a05:6102:f98:b0:48f:db5c:d598 with SMTP id ada2fe7eead31-4915982bedcmr9687022137.2.1721385264012;
        Fri, 19 Jul 2024 03:34:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.175.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acb0b0aesm4671816d6.140.2024.07.19.03.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:34:23 -0700 (PDT)
Message-ID: <669a412f.050a0220.578d.1469@mx.google.com>
Date: Fri, 19 Jul 2024 03:34:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3415855717385437818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: Bluetooth: btmtk: add USB dependencies
In-Reply-To: <20240719100554.4183635-1-arnd@kernel.org>
References: <20240719100554.4183635-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3415855717385437818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872493

---Test result---

Test Summary:
CheckPatch                    FAIL      0.88 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.64 seconds
CheckAllWarning               PASS      32.00 seconds
CheckSparse                   PASS      37.68 seconds
CheckSmatch                   PASS      101.93 seconds
BuildKernel32                 PASS      28.50 seconds
TestRunnerSetup               PASS      525.23 seconds
TestRunner_l2cap-tester       PASS      22.27 seconds
TestRunner_iso-tester         PASS      32.67 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        PASS      113.03 seconds
TestRunner_rfcomm-tester      PASS      7.46 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      7.97 seconds
TestRunner_mesh-tester        PASS      5.99 seconds
TestRunner_smp-tester         PASS      6.95 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      27.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btmtk: add USB dependencies
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#79: 
ERROR: modpost: "usb_kill_anchored_urbs" [drivers/bluetooth/btmtk.ko] undefined!

total: 0 errors, 1 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13737152.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3415855717385437818==--
