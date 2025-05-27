Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C38462
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335159; cv=none; b=AFD4RuvRxe7VwACYCnaMItaqKmjF/SBj8HXGFTC3+Ut2Xjv6Ec/+pwxILUAEkMf00a8t2XISdWJIVOkK4DgqhFnPbNRQgevEfYaDYyouim4y/4ckmy1zSgMlT7gtyVogLRU8dc43I9Nsgl8kj0oaJ5S+s1S1SPpXfEChADDNa2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335159; c=relaxed/simple;
	bh=u/a7w6MWfa7cIcF11KWeNJnG0YOE65/0Lw+pJV6Und8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UegfNyX0gRCWBvnsYIcYiGZA5XXasr8Iv9REEcZe1RhdgXaWbapgRjCzSY72SQgQffUEK8LSHXvChg+D6T6q/ObnCE7QN9k3q6hoDurMBQYGqadK6ei/Ryn0Bw5zGTDbAKCawgmZoDVWHPB3Z/ZzT539Cno8CdnveiIOk5X3HW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H63PfnSY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H63PfnSY"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so39532926d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 01:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748335156; x=1748939956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tJoZBGPe1Aot9MtGaK0NuogFa0iVVaklX7IyM9aavB0=;
        b=H63PfnSYT4VSO+EZLa++M7c/4KYdD/EXyOcsK36vRROt6xBiK01S5TIAw+0tQc9Enr
         EIOcHEYIAmCZnipNtaZikzkZV2v/MHkIDMaslGk/1HtiwrGbPCtJl5YJoLDzhi0TmqsQ
         /GQlSgXvrPimunojnCfBuUZggAEAJoJ3Z3iyvoWXPw+8wDM5WZrTMSHtIxD6VCuGulRT
         PMQg2gniTCUP9kUCv04aZYStcM6aTvVJ1OP2dnvrCO78F2wGv/S21EeoE9M07QESHFFc
         dyUsnMBPKo15oaH0hMjt/+XX5N/ldh092lXqIYadg9+REy1DkfECZ9AhfktViiFY2mqM
         XP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748335156; x=1748939956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJoZBGPe1Aot9MtGaK0NuogFa0iVVaklX7IyM9aavB0=;
        b=iUActMzs7u648zJQ/wUDS9Wg/eyI+WM/vQLKKZ0+tVwA6puRgam/pnpBbM7m3Ols9P
         JJhwK7BDS4NNUtkXekTfqcAoO5C9YDTj7V5BV1slNYomaJfYbl81lJQ9iRe2+kIqJ+5Y
         ysXWO4vPOXbZ5fg66PfhS5QilAHBBHG0i1uj31l0HNRQSbtHI+iOf4e7MjjEzUpU4MWR
         koK9+oT5tQUSOI+15A4t0EiUilP+0Nb7hDdcKACqtJBJwl3sfpIq/VJJb7J1n4UTMOBV
         IyenEDHyYR1NuW8I09QUNU1v4ufS0rkxnvV9tzihy9Uh+rlJ4+GvmSsVRTDYXOKJi2jE
         xV2w==
X-Gm-Message-State: AOJu0YzzJxT6w5O0I83TM/q/+w7fDzys7QATkHV7dzLsuK4iUu140eHw
	WGfz029zqro6HXGcuOBGSqQEqUCJpqfV6KEwuODxs1yZbq5qq0pXR0kLnAVsBw==
X-Gm-Gg: ASbGncvX/JjOCUc4QWOSiw9IxRd3h/ZzwW/+x7JigeA4EBXPVykMLH8OFl9+htxEzua
	6fF/8Opv/Wri+TXwH3+NDf01qyVZxAs8clgLhTlVIwZG6Uf27WoYA//wSmhejRHPgwnIqoMoSoE
	RNxftfTa0gSQK/Vy7xMhghMERuQZVE7Io21Sw7ryv5HxCfpgw/BSVl982IXM74J7J/DWNbS6p87
	q9cLEQ5V0rcMB2R0GyC9+CSTWKozFlZBhmfLfNQAf3Z80l2Ou9ajV7TSWtjA7UCRSKkZF0XlV/t
	Zxw0JpuzjUXMaRIRE6pyNzXsdxkCZ2RuorWnUwQtV49zhXddTYT9ZjaG1Q==
X-Google-Smtp-Source: AGHT+IGb9PbI1n9Hcd1y6Idu3UvAvedpGJq6Pek7/j9LqaZJU2Wt9e3vTqDIcmNyAvYgARm95wsZfA==
X-Received: by 2002:a0c:c212:0:b0:6fa:9a3e:16d5 with SMTP id 6a1803df08f44-6fa9d2a2b03mr154414116d6.32.1748335155824;
        Tue, 27 May 2025 01:39:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6faa317b340sm41516196d6.24.2025.05.27.01.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 01:39:15 -0700 (PDT)
Message-ID: <68357a33.050a0220.2b3bb9.aa9b@mx.google.com>
Date: Tue, 27 May 2025 01:39:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2198724080242610109=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: hci_qca: move the SoC type check to the right place
In-Reply-To: <20250527074737.21641-1-brgl@bgdev.pl>
References: <20250527074737.21641-1-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2198724080242610109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966577

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      24.24 seconds
CheckAllWarning               PASS      27.40 seconds
CheckSparse                   PASS      30.50 seconds
BuildKernel32                 PASS      24.08 seconds
TestRunnerSetup               PASS      455.94 seconds
TestRunner_l2cap-tester       PASS      25.19 seconds
TestRunner_iso-tester         PASS      41.68 seconds
TestRunner_bnep-tester        PASS      5.98 seconds
TestRunner_mgmt-tester        FAIL      131.47 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.75 seconds
TestRunner_ioctl-tester       PASS      9.99 seconds
TestRunner_mesh-tester        PASS      7.39 seconds
TestRunner_smp-tester         PASS      8.55 seconds
TestRunner_userchan-tester    PASS      6.25 seconds
IncrementalBuild              PENDING   0.65 seconds

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
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.192 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2198724080242610109==--
