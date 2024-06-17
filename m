Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38AD181D1F
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609730; cv=none; b=qBUqROpgIr/zPT6nuP8gmufFZqSLWtI6q6HodUHx7AJ4GC0TbkkpWJjVmyISQKj9r7DZWORbKQEaHb3pIDaR32lx+SGffIauSi5Bop8EgzE+94k/4Xw8rCfGbiC3ngaLYiTR2WyRdaYVEqcyPqrlPfO9+5K2xKbOfYcpG9MPIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609730; c=relaxed/simple;
	bh=QUhudMQCXX1sCQgnA0uEx3U85ssQjyFDLbHfIF4MnZU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nHZKgedRtg033zDtWvFr0XC3eS/UKAVYhRxJWQymaO2TRxQtkPeC9K2T6LLyev6wdd1kBFwGBJI9PmpqTc6kgOVuhTe71it7IBJHje4vZ/Fj/GnQFBBIOp1XrDgFQ6n9l63KSD/Xbg7XLCeNIh4n3Hv19yAH8vgkbqynoGgHtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGgcdDUt; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGgcdDUt"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-797f222c9f9so246490885a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718609727; x=1719214527; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U5VylCy3E0YfS0hgz2rs/hLAl4lRrjTT3AT6q5eXsG8=;
        b=fGgcdDUtMDCofcuVj+iKH2/0XH8Yr0kBCG73zLVQpuztUBF35JUxOoUfeHflboGsoB
         G5b0a89i7KUAkL3+K2i53qEiTK91qzCA4KXG1jHWqpL9hWGHRWO9YdqI9SM8SuJ8QOlu
         H9xmkU1gIaal+vMdDaqLt2ZGijLwZ5m6eNhnSoSfb1moPdtxO6w8RifsPEm1abaybLj8
         9pS4NAU/ad1mWfWxF8r9ASjCQ9QU/HUlXnCV7zLA8mHraiMqmyfyF2h6O2MQayN2PUJz
         SxQexOKuW6xo/e4j601lOz7OPIMPnlgOGkhvf2jkpcIIgLLySZ5YqAfOU0RJ4fazYJ/N
         oqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718609727; x=1719214527;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5VylCy3E0YfS0hgz2rs/hLAl4lRrjTT3AT6q5eXsG8=;
        b=sPFwTfrERIu4sX7TTUkfJmzgOnmr9jk2pkp8MIT5OpGn4t7J45CuC0X4Oy3doU3hxA
         fdz6SHauvoNhq2yuv+49NWzi1NOU2MpUNc5LWTQURtya53qseCGrUPiiJyYHrljGtgeJ
         z3XXiFJrM4weT48LkTnXNJCY3Kbfk5IalpGLWwsrMOb60Gk/1O2FVv32ZWDNGTU/bjJD
         bRH1b4slOgjCbvEFfUqWQrupfxSU4+LrDxNWB8KLg/LUi3dKkWy9Xzfl0bel3roAFG0+
         ydnoLfC/jT/JS7z4NpmoyEydUJYdD3V++0OYDVdghiT7eCuPa+uKB3YU8j/dZUTvE4Pw
         bLJg==
X-Gm-Message-State: AOJu0Yx3WWqr9X8Wh5hcUw45LJDpEwlGqvo0CVxnpRG11UvE/BivvPVH
	uU52w9UQvCk7jcuW2zNcyjwEJ1qTejBRnl54cBX3yr3ZESv72zPdOvn4Zw==
X-Google-Smtp-Source: AGHT+IEgiLHsAhgFNV3H5XkgtLYFKzsx0IBtTCr8lYSb+VRYPhrzSSrnMfQFsibu433la6npS2cQRg==
X-Received: by 2002:a05:620a:4492:b0:795:8e6a:3c70 with SMTP id af79cd13be357-798d2694137mr1084828985a.62.1718609727429;
        Mon, 17 Jun 2024 00:35:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.58.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe2795dsm407809685a.109.2024.06.17.00.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 00:35:27 -0700 (PDT)
Message-ID: <666fe73f.050a0220.3d118.c3a2@mx.google.com>
Date: Mon, 17 Jun 2024 00:35:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1487042386704020365=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: [v1] Bluetooth: hci_qca: Increase settling time for baudrate change VSC
In-Reply-To: <20240617070039.30824-1-quic_janathot@quicinc.com>
References: <20240617070039.30824-1-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1487042386704020365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862483

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.52 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.03 seconds
CheckAllWarning               PASS      33.56 seconds
CheckSparse                   PASS      39.37 seconds
CheckSmatch                   PASS      105.21 seconds
BuildKernel32                 PASS      29.79 seconds
TestRunnerSetup               PASS      535.16 seconds
TestRunner_l2cap-tester       PASS      20.70 seconds
TestRunner_iso-tester         FAIL      39.66 seconds
TestRunner_bnep-tester        PASS      5.05 seconds
TestRunner_mgmt-tester        FAIL      115.36 seconds
TestRunner_rfcomm-tester      PASS      7.77 seconds
TestRunner_sco-tester         PASS      15.31 seconds
TestRunner_ioctl-tester       PASS      8.16 seconds
TestRunner_mesh-tester        PASS      6.14 seconds
TestRunner_smp-tester         PASS      7.17 seconds
TestRunner_userchan-tester    PASS      5.40 seconds
IncrementalBuild              PASS      29.33 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       6.165 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.171 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.206 seconds


---
Regards,
Linux Bluetooth


--===============1487042386704020365==--
