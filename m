Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C332DC783
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852885; cv=none; b=ADZG01j7tFGBe+RWBzBZTmrC4olURjiDA4eir/SQN8GBxsJqs98v/3vtE3dSiHPTPitFKlzoonz4ndSv0ZXz05RV0kKI89GMuzSQbIO60svMbNKsTNWrk2lr0BOpOaUygzjszAOb+FcKeodD7h9FwoWW2Im10MwyGUDQZIwpqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852885; c=relaxed/simple;
	bh=5iEbli+IMnma07U+7KWDW3zIHhNLrlzy3DJw+ABN4Bk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DuxUKp0437hqS3CJQ07B/xxODYpDvalZjmJAzIH2tyTOqz13C4Gp/AwH1ifH/Kkh9oLsHjugZGqRD3rrc4DMhMPYV6vrFPlPPUdKZ1xle0Xeo30tmCFJSB1JqNfEtCtAzjAEq2RgXWNIfkVG+Y2COKf8h8eaDRa62YIn1seDt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWYCH21N; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWYCH21N"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30cce5be7d0so2226641fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759852882; x=1760457682; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AVGwMV+AYLvWH+sAUpOCm3N8qWhDy31gxI2ioaj7PT8=;
        b=TWYCH21N5K0jqRcnfq3tTXGxYK1wEZHvs3sh6yKt73IFRAUx9K4F17ikmKgaGMuMnI
         yHALA9wLuKxeCHgeeqZyZJv50SRTW05Lp/ZPCv9beUrF2GyKD/xNH3uHYlR2WrAV93Jd
         NGjcLu0Xkv0WBivt3+Fz2fkWEaPhcJOExVyfwFKE+WVzwcmBhdpc9LYT301yeym1g1jY
         8G0RlIl2gSPY6YugBHyexOpuoU7jEUCwdnDc8XuO3c6cZKu4kHUVAN+Iu31GoJwqBkET
         YWF/fneAeHh40/BBqQ6+3Cb3wxzuEXz5WvW7f0puWGZqpaYBMIhKRf/rrX8kjYzK/uVI
         2Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852882; x=1760457682;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVGwMV+AYLvWH+sAUpOCm3N8qWhDy31gxI2ioaj7PT8=;
        b=eNtKhr7sYsrE9uAxwRF0abpRu1TDWgJ9Wd1pYvbgkAwb6RuZ3bS6NugAF4h3GLXA/s
         HxxiAFKt8ElH0EYe7ElZ64S1a+XsEpip5nYzJmeje9eYalvGQm9TstNkqzTuFgRzaJxx
         Wh07lcTwnoWB9rS7gPTl+cvZ/O99svTK6hphw/OdWaKuMogktxM8CqHsGCzVlc7i/NLd
         Cf3IFVIA9nxCaVy9J1eb0ASnAl58yAUlB81jxpsTni9rn5CvioXLh/qng+OLCNw7Hniw
         8mgu8Rrc5KHeH1L+cY4BCi1EcasNRhpEGzAjlNgwjs/qVDkOFaowqGTgVSuwMqOAdwyJ
         7hvw==
X-Gm-Message-State: AOJu0Yx0q6rJxohjiP66zOzN7VuhzC5ZRbyK/Hx/5BrqPYJF1ufjtebE
	UG9A/08gShzLpasb7N/6Kqzx9ZfysqHYIu6ZrjGJgrqi82rHgMBNH65MePzzlw==
X-Gm-Gg: ASbGncvmyEQRyVxXm0KAY/qpp5mPr2ncFTn5P4VcHmeF+t2AdEodBCPEDJz1e048ZvL
	jSzIfRw0XWdPulLyl6nqoxXLTPxCIPgnu13cxql5VmwMZ/9VDPGgUrmX195LWHf3K4mKq77RpWP
	3hF1QWd3vm8cElxv+aHnkEz9++wYCL4BlZufzs71MzSs+yTymtfLIKIu841kbpwXHmwEvjMBPLo
	Ncn6Gk5/TFPxSHxvAogVFvho1WjNZyKxX5NE9tMEf1Y9TCwFPgYMRGnSeA78NCWrrewqoJux0kt
	eMJmzIHeHMl2QVPYtHZmJSdRZb3QAHZIXjwldjniBiKGepc1nZ0Tg1nyoATfnBg5dKOTRzBXKdZ
	ttNOYwM5bqAKrMCd8WibHG+4F/1YoODO4FrWRNAwgRY/2SSJWnYZR0f8=
X-Google-Smtp-Source: AGHT+IETz0K9BqxQOctjNOPAUgwO0Cr5UbyVoumwwonLugFeDMglOjBr56rZefghRMaYfNi1Jms9wA==
X-Received: by 2002:a05:6871:5b29:b0:36d:31f3:9f1c with SMTP id 586e51a60fabf-3c0f48ca80emr56687fac.14.1759852881372;
        Tue, 07 Oct 2025 09:01:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.118.198])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55d0cd0bfsm145865911cf.36.2025.10.07.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:01:20 -0700 (PDT)
Message-ID: <68e53950.c80a0220.14c139.0e79@mx.google.com>
Date: Tue, 07 Oct 2025 09:01:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3299360485223113147=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, evilynux@gmail.com
Subject: RE: [v2,1/1] Bluetooth: btusb: Reclassify Qualcomm WCN6855 debug packets
In-Reply-To: <20251007153315.72565-1-pascal.giard@etsmtl.ca>
References: <20251007153315.72565-1-pascal.giard@etsmtl.ca>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3299360485223113147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009076

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.54 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      27.09 seconds
CheckSparse                   PASS      30.44 seconds
BuildKernel32                 PASS      24.45 seconds
TestRunnerSetup               PASS      490.10 seconds
TestRunner_l2cap-tester       PASS      24.39 seconds
TestRunner_iso-tester         PASS      70.08 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      118.04 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         PASS      14.63 seconds
TestRunner_ioctl-tester       PASS      10.13 seconds
TestRunner_mesh-tester        FAIL      11.38 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.50 seconds
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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.177 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.785 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3299360485223113147==--
