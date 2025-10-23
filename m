Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0131076C
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223911; cv=none; b=tinwZzwVOkC0sH94zzVY0bDKFYZin5vFE5vYvxoSxfrLkdfTSBCQCUTp+L2JNzlc5klNP2z/EWwQNSEhs8crtivnX9DNojZrYVfh+yD8M/h+gWkehNR/lFVx7EkTZiUARRF3hLSE6uFHnZzP2PJ7lwcDbJmAELBydunwoQ4jPCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223911; c=relaxed/simple;
	bh=7vGS7QExSMHG0WUgkFoiofvxmJftLabGZjhhWXSQ4xE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OmptYkKqqnpIa4iHqMsdbNhlsTl2bY3wZQhf763HUCNVXSFC4zRGpOmchPXI1Dy86VfKpCevaAlPrO0BUPM7hEf//0XwaSzT3+6CI4oqeSRzuJ5Mzr8cdr4Ll/9PJ8LRBS88Jyk4Ycxd+WdOzfrHP6yeQq9oHsTKM1VdEPCGG0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjWc+bCS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjWc+bCS"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b67684e2904so552575a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761223909; x=1761828709; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSsnHqjL1C+Y4shp09P9S2o7NxAk4yhjwy0dosnxFVI=;
        b=GjWc+bCSAD1NgThkj9qVPZMzKU3y8jtwWovbM1D7hJcXW4tb94wXV+Y8pIQ3a+7G7u
         KRlBnKN2ABpvJazbaytj0e0Sbt1Z1HOhY+m6EMzyLYQuabTlm2fhw4mwJt6Jm3LJnFMb
         IZ19FhQzG6SK/lUT5YOqwhvFW73RwWAzpk1SmR/5mtAicCDVlhfLYSOJ7etL5yA+mpk8
         cIMr3nh45lUXh3IERmQJ8ICLgYUSYyvDIxk24NOI3accs4/wMrT9wrBpoWZCPQ5yGgGw
         SpKYwLZSSD8H76VVBLHKuColI+0y66509x82FRNM4oYpj/PZLw4MutUF80Ry5FE8qElg
         sXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761223909; x=1761828709;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZSsnHqjL1C+Y4shp09P9S2o7NxAk4yhjwy0dosnxFVI=;
        b=V9GgSeN6Moecut2Hf1wJLsA1tsxuUGA+qGsmfr96fffLOvwkqgEEm1vt9XPOXVx8Pm
         fXOlqmFKR8mLmrA83rcmuxfqYLgTvyh0hjtmaG6MMRV8UYHlMsqWbBgU3V/Nl4Spm5+f
         sJhEaWVcW7DCozXfmQ9azVmgSsk1pF62CeCC2NbR8KxiGYUdQnTsHJZGviTox3qeKwYy
         qLWBH1+g4pg7Uo+p0XYqV19B0sKBYnIG9WK7Dl3nh+Qn2ckVl1DzLCIC/I8qNAPtR3kd
         yevsq07L1RnBrKuJuxMVOtY8mfpcHiUm341QHKo2BV14R0yRTIc9dQXONIjoNSsn6Ba6
         pF/w==
X-Gm-Message-State: AOJu0Yy62FxDGOu6D9M7y6eU4ckXMA3pt/iXfKGOuC+6dgx0JC9iqBh0
	GXYvRxDx5nFzUShUTQhBBBUyvKsEt0GRyLlUJISwFKpBtPOYXMKpjYHeK+Hcuw==
X-Gm-Gg: ASbGncsx2f9QCpaW8upKLs+2dhAhR0EFadf5zcuLWeC8uhOnk7CZxNjx5WwMzTwk0O8
	mQh5JRONahCuDHLomccY8MRUMWgJ/iI1MsJ/RN8O2A/bwdGs4AXpq4dLKv0WxNyd7kAfGFQzdrw
	ZzgnnW3pr1ilunmggDim709VBnOUPJHvwpE7AEZtJxibzHabHT16SYkIbCQFxdDOX2CKfyTCmZH
	OJQNfjdYFK+FiYPpdHpdoLBt5YZuX85IjLTnLuMpPNJK7q4EUFn5VVb9hzCYKk8mJtnGapgm80m
	8e+bk/qCwMoDuZ/MPyVW+pWFOeLuJkY62JpiZ9dXUV8VKljoqU/7n7m11WG+2eO5xbW6hH2ytKy
	C6l9B+m1nWH54QjqEy7ig8O/D1xwLJyBO0I7Zle8sCwQ0hq6Pq3P+KMB48sE5jpnmQqImoyeibe
	p6Q8hD6Mpu
X-Google-Smtp-Source: AGHT+IEvkhbzS4Go8sMpRxKjnL7usdXgw+5brxX9U9zOpPjBpcT68419q+ehqBCUGxzsLrFz5mSAFg==
X-Received: by 2002:a17:903:b8b:b0:26d:e984:8157 with SMTP id d9443c01a7336-290c9c89ca7mr245322965ad.8.1761223908765;
        Thu, 23 Oct 2025 05:51:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda7955sm23456485ad.4.2025.10.23.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:51:48 -0700 (PDT)
Message-ID: <68fa24e4.170a0220.2739c5.6ce3@mx.google.com>
Date: Thu, 23 Oct 2025 05:51:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5113652475415600213=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan@kernel.org
Subject: RE: [v2] Bluetooth: rfcomm: fix modem control handling
In-Reply-To: <20251023120530.5685-1-johan@kernel.org>
References: <20251023120530.5685-1-johan@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5113652475415600213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1014980

---Test result---

Test Summary:
CheckPatch                    PENDING   0.56 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.60 seconds
CheckAllWarning               PASS      27.39 seconds
CheckSparse                   PASS      30.70 seconds
BuildKernel32                 PASS      24.50 seconds
TestRunnerSetup               PASS      489.96 seconds
TestRunner_l2cap-tester       PASS      24.18 seconds
TestRunner_iso-tester         PASS      102.68 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      117.24 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         PASS      14.40 seconds
TestRunner_ioctl-tester       PASS      11.28 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      6.38 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.171 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.191 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.157 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.792 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5113652475415600213==--
