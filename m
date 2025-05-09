Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D182686B1
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788543; cv=none; b=TnjO6X08ID1XioVDIhH3Fe/Bt2KrclUK7wyQpwbFF+J7PVjV95aFRyVaxf2TbPguMEJlAKjygCuFpl3ab7qNASxlTzYN+AlRqVMmtTckz02YWiivUsJVjTBNARdogN0t4GAvJjC8N40+x2ym/Qi6uEF0NsHEzue0pm5TYL/LH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788543; c=relaxed/simple;
	bh=HSawhTljW29bnLPv3RXGaHJb/rCTKwH+R1SpxjX95ZM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gpBpxa5cPM5kl1OZCf5iv3II8lxpFPv7YPkAkpmCoJ9pt90F6EPUBYiZI7R+9Hyt4U3zgAqPkk+uRcTjFyAfHebf/LIde1Iwrq/PhtNkeQe0xA3RlYyMftnQ6m/yJKdAKsCzN0tkCkHUp08HjEHExFfu18QhZS9zV3V7pzyW/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvofHFrD; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvofHFrD"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72ec58e45baso1356268a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 May 2025 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746788540; x=1747393340; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wAHSFEaOdQR/EuR7jv7FPB9CgERJ9TSv9cFs5yeLcrM=;
        b=mvofHFrDgbcPNG8nHS7H0f7ctLw/w67rvkOLQjEVxjrju7QMbKL6lYXBij48nmX16e
         l90dj9c/UKf/q53BQAcb+AcHZ1/smNvX8UeCfDIiv7+brmSgjvuDareRy5IStjr1GZQ+
         hAKw3XVE4dLuBTOsikRim4wiE3e3TdPRpD18ipMuQmztP1kVtHZFnRG6o0XKQ9qehVtD
         RhEF/7CkDLt1mfRYETFftCJxVsC/EOl64BnjJE9j93lMdQskF2tSvXodeJPX0H4ibaNc
         /G3OT93LDYHxNw6R6yIrkXCUVb0bnP37ceUQXGuqNZv/KMHK9aqKoYDSk3xnJnIN7wMr
         xvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788540; x=1747393340;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAHSFEaOdQR/EuR7jv7FPB9CgERJ9TSv9cFs5yeLcrM=;
        b=fkaWxRXFfx9OfT8w1Fp+fqf4tmp5+qeH/itcvjju9TSaXhvukH0xwc99tXvGXFknwF
         uFJMSxflIJLyEhLy35XMcE6w/Y61Pdni2d4Y35Y/1S7tO4il5MiuqD56l+YeDl3S0MYt
         SjIj9sbAM5n/+YZD7pGDHApA8bQOgpfK0B/THEIGIJoTT8/nsyXeNcqIPyrwdaRpEj1u
         YQ2k5ChOl1zN9M8mS0zJ09AGHSuhradjsvs7KF+6+FprY3kfKzUOPswAbQkvaCsbwXyf
         o3JaOkHOUf7whS2OQ+G6V6GIjGgTk69zgsrVFa/A7/37JfbJn0xyqq7ziEC7pCfyIGcy
         O+bw==
X-Gm-Message-State: AOJu0YyI0S4x6UB/Nw+NdpC5dQxaTZcy4vtr1Z4Ls4twxwPOpcWScD2s
	2XAOuP8syrT+yHWGNlH1aZHKV77qSKUHRvvHD545TEnJh1UxuA+JT1EiVA==
X-Gm-Gg: ASbGncsuW85L2wq6No4qUtbkMHpybs+HgNIagPggtM/Z5yMiFGvQoWFYZqArCKDFZd+
	/XC+SHMwsOcu/eU+eqIwyeVY+ubbKfuBevLpOO9F1HrRaURM/9fNGOfke9jzAAP+JzHTSPYw0S2
	ZZ22sNXcizNhzDiGrlXeqiTUXbEX8mURZv59n0zbQ18PE1rkXTWCMCDdNhSRwxyf0wDSpY1XyKr
	gnhpYbuq76SofekA/ee/UItFEDyAFtYagFqiLtiw/X2KrHjQd7F5IKKL8Oo+9otI8pSosjXnwS3
	doKAGyFBXptJMwVozC0FpDLJAgm30hWageW+T51E4lDmiw==
X-Google-Smtp-Source: AGHT+IEB2qVI1H8t6+Hjz3gCwJl0ANUDMUjBgdCkixsmhc57BY38qds29ZHSMaJcWjMXopLpGUvjew==
X-Received: by 2002:a05:6830:61ce:b0:727:42aa:e888 with SMTP id 46e09a7af769-73226b6821dmr2065892a34.27.1746788540513;
        Fri, 09 May 2025 04:02:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.85.45.118])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-732264d8597sm488616a34.33.2025.05.09.04.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:02:20 -0700 (PDT)
Message-ID: <681de0bc.050a0220.1b4ddb.530e@mx.google.com>
Date: Fri, 09 May 2025 04:02:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6584633345982279615=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v2] Bluetooth: fix socket matching ambiguity between BIS and CIS
In-Reply-To: <20250509-iso-v2-1-da53bd18c193@amlogic.com>
References: <20250509-iso-v2-1-da53bd18c193@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6584633345982279615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=961268

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      1.15 seconds
BuildKernel                   PASS      24.23 seconds
CheckAllWarning               PASS      26.98 seconds
CheckSparse                   WARNING   30.38 seconds
BuildKernel32                 PASS      23.75 seconds
TestRunnerSetup               PASS      455.29 seconds
TestRunner_l2cap-tester       PASS      22.12 seconds
TestRunner_iso-tester         FAIL      41.14 seconds
TestRunner_bnep-tester        PASS      4.99 seconds
TestRunner_mgmt-tester        FAIL      121.78 seconds
TestRunner_rfcomm-tester      PASS      7.71 seconds
TestRunner_sco-tester         PASS      14.99 seconds
TestRunner_ioctl-tester       PASS      8.14 seconds
TestRunner_mesh-tester        PASS      6.38 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      4.90 seconds
IncrementalBuild              PENDING   0.51 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 127, Passed: 122 (96.1%), Failed: 4, Not Run: 1

Failed Test Cases
ISO Broadcaster Receiver - Success                   Timed out    2.393 seconds
ISO Broadcaster Receiver SID 0xff - Success          Timed out    1.994 seconds
ISO Broadcaster Receiver2 - Success                  Timed out    2.010 seconds
ISO Broadcaster Receiver Encrypted - Success         Timed out    1.986 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.202 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.149 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.157 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.198 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6584633345982279615==--
