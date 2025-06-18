Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E1F9CB
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253400; cv=none; b=bmAJamBrZLxlsVb+m+btgRdA0OgaWaSaHCQm+/mSuw3MnueFmcWmBHvTsMqQvHWK61IpSf5GR9KL9ue6c/PoEKOd6K6GY7Rw+FSFwyWHySbZNzDDQvGcU1iS41+R3VIqHgZjnZOOjwYBfjgo42eaBaYSeIL7qyD+DXW6dcXjIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253400; c=relaxed/simple;
	bh=hEXB8ERdycaBqgwmjkCwWDzbmi4RSo7MSOaKWoF6adk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DEf4o567vNk08C/kqHSaRf4RPRPUG+5sWT9vDvVI2iOC+8DYCUt15KLROFrR5xXQREu91ZteBI3utWQxFhiRV4TAYV7fR0kOyqnIyuIN36c1828bca8WcA6fW1BUZxVQ8xTrz8pc91jqePtvzi5e3ySHrqU8YcYVGVCAP3mH4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fncc7TDj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fncc7TDj"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fb01566184so57784886d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Jun 2025 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750253397; x=1750858197; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p55FQjHTYui9688dPMiC/sH9mBlcN8AxGrWfbbRHPhE=;
        b=Fncc7TDj1MLR0uzqI3z/wTasHqJE7FXpB1ugknzpLafOlBQqHVwvAvKRV0u12YNVD8
         h9qZ90Tiz6RApqzZT8c7qmhmwtrEOnRMzCgxgMEBOfzrA6Ok4OWTiFslklio1VOH5hnm
         W/QcDPK7pXq4XgONsCmMfHFuOaglWW0Su3g9WF9klmsmjZhMgCqmlubxf83Nxu/8lIMe
         XssQfuq17c3Qk3ybxiVypinY1fMz8L99YbFHHoW+jY2tf8pzvEi+aRTXhI0xeGMjWflF
         YXwSoLvHLv9SmLA+bS1xv/9LIHk0uXfV2db+Pb407WONSUSUAD8Zj3aZDCWMAg7Md2RI
         g1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750253397; x=1750858197;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p55FQjHTYui9688dPMiC/sH9mBlcN8AxGrWfbbRHPhE=;
        b=dNU6ePu9DlxBwEUB3ICfusqcSSyN8DelTPsG3iz/EMMKWnfXYmqP9BbIYaoepuIkuc
         AxT8uLtj5HmhtfCw9NXdwe+RF49PNFnhoomL3cxxMh8Cor6r8CFg9LAiL9ym3x2XakKD
         oTUW2jhcnsh85H2bgpoHAYP5J9DFiTUD9ZhoP7/SFtJH5qPMay0kFVbvOjhpIpDYzXOy
         4en0XeD2/TCmb2JP3ns9eZI1SbxPSH+tKo6xPNLDrTqq+hn15wOSY8cSruAZA+li6I0T
         l4fPZHO4QzjxxyUmWNVX4O2Tba+kLMD8H8KNhtZfceGPAqVL9iCq4wOM95WoXt/9IOjX
         F6rQ==
X-Gm-Message-State: AOJu0Yzn4dYy8VPdfe9+lcHI/M51Ilh5BiyovQF2Spb7+otNGea4irFz
	ssZf8Lk46m6M3neweXf+x8zhHclQnPWCA8YePg8Iukh2fXQFuEjSo2myym3Fvg==
X-Gm-Gg: ASbGnctItn11hWQaxNEAHY3yJJK/XmaLAsLdz1UMzir+3nQWUiUlQb0C+8ofSWyIBzB
	r3vnnR9C1ih0uRa6VmupsjqXAWMlPqZUqFldnUiVTfMKko2Z5UWvQEYRb2KnIPybezkE+pQ5sLm
	Lb8mlzzRzeLPlGjbMBrVsbZhlmU5+MdJItud1QT7qTIKqPfc9P1iCuJpDNhemY3NRsY0NIgza7w
	gzXyAsrQC2G/h/SdtVWgkpfwEZGTrKCWsWU8GxJ2ssBoy7PILNNcdjAeyT0z0Enbf+qK2Knt7pK
	OOS739Rm2jz67Wlny1YsLX4kPI6wROCgbJDyDv1mW7hew+fZQ8Zldo7skAgaGKcAStUs
X-Google-Smtp-Source: AGHT+IHbcYmOXUo3bodJjNxoDn7vUCMXazWUmBTaVcDII98U+6RiE6SLi/RbfurtXEnuz1f91ApjvQ==
X-Received: by 2002:a05:6214:b6b:b0:6fa:bbb7:602c with SMTP id 6a1803df08f44-6fb47779079mr235822346d6.29.1750253397309;
        Wed, 18 Jun 2025 06:29:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.17.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c84148sm72619036d6.109.2025.06.18.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 06:29:56 -0700 (PDT)
Message-ID: <6852bf54.d40a0220.170b79.d4ae@mx.google.com>
Date: Wed, 18 Jun 2025 06:29:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5677627913573869457=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel: Add hardware id of BlazarIW
In-Reply-To: <20250618125555.773327-1-kiran.k@intel.com>
References: <20250618125555.773327-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5677627913573869457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=973435

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.52 seconds
CheckAllWarning               PASS      26.76 seconds
CheckSparse                   PASS      30.15 seconds
BuildKernel32                 PASS      24.24 seconds
TestRunnerSetup               PASS      464.47 seconds
TestRunner_l2cap-tester       PASS      25.57 seconds
TestRunner_iso-tester         PASS      46.92 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        FAIL      133.34 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      14.70 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        PASS      7.35 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.13 seconds
IncrementalBuild              PENDING   0.99 seconds

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
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.183 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5677627913573869457==--
