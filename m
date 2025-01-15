Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4C86327
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951426; cv=none; b=lmJyJgSq4+mhg1LfeGz1b0N/7Wc6UBY6qOVpTWw6CXio9hU/vEqxVh3eL4vIPLFaRcoN2zTw0R9nx25x7xvt0fgNzEPLyHsVHotdbY5vk3Y0GdbozfJUUAkaUUAgcdRM0VG+s196MdqV5D4QWwR5OZSggzhUjofxROVZcmDIjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951426; c=relaxed/simple;
	bh=1WQGhZuiZnhGBSjFBR8ms7hOgPIUCS5nkjUxYT7LnqA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=puF2pmhYSHd0Gh4GI3FXTF7xwL9tzPE3mlN71e4wT8THkD4jRnwOZAsHGzELmszNNnAng8Tf7JRFXn8LFTUzzc+9tNQHIEiz6PYtLLFoaq6VHhocfqqA2FUjvepnshcc15uJW5qV6Urlhc+tZ/aMWCyfURjsyFp24todkzqPVAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTNtBFVZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTNtBFVZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b1f05caso123100275ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736951423; x=1737556223; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9+aGN8LE1aXAQ4trwprf4LWfEoAE7tRSMCuQnNrJ/AM=;
        b=HTNtBFVZDL1gKFYNp4vhirwxe2YZFxa9LHjDt/xiPMpY7FrK0HxVBh2wZ+FJ5dwXht
         9zcY1sPnXYPgmCxTno9fbYw8JQqMZlxuOLPoa8cA5WfJQY9DSkjJUEVLjqv0UQppGwGO
         xo1Kd0UyhwNe7u7E7q0MfKqzdtCpEXgJZzVbs0gyJmM1ZFF0xhwLX9o98x3Mf1C3B+z1
         rjPKHaBDCuxUp+ye6SxpaEd5U74yV5/OyFcn/ZSyh3V80L4wDrW2Fwl8NrXYX4Hyq5kA
         i5Q76Am3ouuqfs6zFYtpILWwrmn5UasuurE9p8pNT5pDW6fxCWUo9A0pIGdzFB08gXbw
         mG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736951423; x=1737556223;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+aGN8LE1aXAQ4trwprf4LWfEoAE7tRSMCuQnNrJ/AM=;
        b=e2i9UBpffM0NhU4Em0ko/R6svtP0UJPx7XSExLLQsEJ8+yrt7T3GbKF9RzmZqX4EIr
         yYaCr6haEX37Jza3MEN+syNGuO//v3BHD9s0S1C2DXh1SeNtlOtR2RgOUh6ozcwSzMN/
         xHAHpBmcbdh1a6++TYTOn+3m7vjZYUtgun7Ls7XUQc07KZvPVLbHDxywcMTZgFkSgLzI
         JU0gq6n72kT9EYWr+9mwN7Lw32wuG+RXQfhL+yrAojztceYkUi+sDkKb45JncXi/oylo
         YLGV5TBv+aojoakXAi8yOXDfz9zGzl3+6a74fFN9vjf0a7ts35Fdl0ZTiV65D76ku6HY
         vRYg==
X-Gm-Message-State: AOJu0YwMMAUznmXproonUfP7ZOg4R9r106zTg0OYuM3FWaewHS22XiTQ
	k1PAYBHJ1jL/QTxgDDEMLvFMvDJK+k8HP7LPVpv6H61od1pTXF4NngjigQ==
X-Gm-Gg: ASbGncugw25WFwJ7os5UDnHQv0SAlYW0eU8uQwBLGJCr8vi2TocaD/RgP77kOiU83yW
	PeYKmC8QjlBrqR5RifLWabbhiVuutW3vqYll1e6x8d1u5sK7nbD25324aM6gao3uNXmvaiMGaWp
	0MisouDEeLeQZB6EOMZ1wSyGOLgLwecOIBqqSgUtBY+4nX0y4UkBJWleUFcG6VuKYe8ElI0LnJ6
	NnG8ZsmlPFSThY4Ndl/aJbBBWrUoRAUZnSFnakzhihSWs++fci1uV2mHBwX0w==
X-Google-Smtp-Source: AGHT+IFN+9JOnIhitazrU12HPbEBBjvZqdxXUzHUX41Q6WAmJYiEmvJ8y4kKm16JKNRwCFNoGj7gKQ==
X-Received: by 2002:a05:6a21:3389:b0:1ea:f941:8d7e with SMTP id adf61e73a8af0-1eaf9418f1dmr10848765637.13.1736951423354;
        Wed, 15 Jan 2025 06:30:23 -0800 (PST)
Received: from [172.17.0.2] ([20.169.15.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a5a32sm9611796b3a.173.2025.01.15.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 06:30:23 -0800 (PST)
Message-ID: <6787c67f.050a0220.174aa5.91c0@mx.google.com>
Date: Wed, 15 Jan 2025 06:30:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5115948819670153674=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: btusb: Add 14 USB device IDs for Qualcomm WCN785x
In-Reply-To: <20250115-qc_wos_btusb-v1-1-811664ce5d64@quicinc.com>
References: <20250115-qc_wos_btusb-v1-1-811664ce5d64@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5115948819670153674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=925711

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.75 seconds
BuildKernel                   PASS      24.17 seconds
CheckAllWarning               PASS      26.57 seconds
CheckSparse                   PASS      29.90 seconds
BuildKernel32                 PASS      23.96 seconds
TestRunnerSetup               PASS      426.74 seconds
TestRunner_l2cap-tester       PASS      22.14 seconds
TestRunner_iso-tester         PASS      40.78 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      124.37 seconds
TestRunner_rfcomm-tester      PASS      7.64 seconds
TestRunner_sco-tester         PASS      9.58 seconds
TestRunner_ioctl-tester       PASS      8.31 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.62 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5115948819670153674==--
