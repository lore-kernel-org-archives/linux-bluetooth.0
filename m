Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348A946F
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147261; cv=none; b=n7xzlhkMxYRL8F7ZgjgnKSH7qdNOvTok4LlaAzrOe+F8aSsaBgpPUCJUKvA5pa8BpTF8v4Hj/mX5aKppjHMLUKOouesYTT2GM5NOe49W2S7Dq0rdPc3YR5i+kZcMyFFVnHMZbj1XXDeo10okYwoaBG9tgLuIyAw9R/VDyLGjr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147261; c=relaxed/simple;
	bh=/USagPLcjk0UEXacH+4KaRQ/QuLuBn7HoHfUEUvbr/0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kZZrCZBQkxJ9fxng7fFiJfpEsU+BuEzIeiKI+KJb1DkkhocjmQ/I1pEH/qFiBjg8OhCnBpHnPSz7tEKrPZFzuvVHVo9J7xR02QtJ0YOCOedTEZJQQt9AZVIXitFeo4RNQu6graKbJ1viUHhNLEN8ajwynKMD++BZnXDVmd+X86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7ZgfNKc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7ZgfNKc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d0976776dcso96946785a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752147258; x=1752752058; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=joqYtTuymK3zXmizIPzC7tYR0E7OmjBUjmQqZFQxu/I=;
        b=k7ZgfNKck7GJepyfLIZU0WWaRK5WLgnAtT0Ij2Vb7cN1GN3Qsi/qx1cBnq6QqEHnIF
         7g8ji05VTc1ES7WTplQH2KY4uEL4v2Espf3zDTBpPIH/vZijCWPEXEIh8hjKiAR80R/I
         ojskclR+Z/kU1dL35g6crb+Jd7D9EIzECu+5/gq4OOBrhogUXcIV0bauj1XO+jAAU3+C
         UuisC3YZGF+NPGAL0yxIAsiC0coeYFlcMQ24dS4r9egHR7GWmleoCEUn7roWpE12sylj
         DkY0934BMm1A0QMpotei3jp8JnNxpE8nYIVODVNOmrOeTkHZ7sMwFeT6NmqRVpqgnFly
         ipXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752147258; x=1752752058;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joqYtTuymK3zXmizIPzC7tYR0E7OmjBUjmQqZFQxu/I=;
        b=tt3GIx9rhziMrPiq833SKrGbb6xaUAov/Thy6Ea4w4P0Sogu9Sx25xEvXX8VnHdJuU
         /QgCL5cX69AgoiPLtAV+VfTRwzMzCOZ9Qbj1DfKW4XnNlLxc1v9i0LBCkuS4V0Ryy3cx
         BV6/p6cH7N98XNLQcodtrAlAkfBIwnhU1sxhksyPn63L3glAhGFdaywZQkYkSzfqpOgQ
         IWD2oMWFcCreWbDbak2FQJQB0lYXEUsbD6klPCyaJu6UW0VDo0iKHRHYwn+PKIQFevOz
         b47BgrgD3sMuWsCPiYWDj3iEfUeispsH/uNoqzcz3L8tdyopVGAjLbV7I4/cMKNxxSVa
         J3ow==
X-Gm-Message-State: AOJu0Yw/9kjv8kROfCwN2CN9DRKNbMwpxtXTAPvLj2WsKzkpwSwg9giv
	EhbNWhGDOoPudxOqqkqHWjgJpvMoZPSNQ3bdW39wpSV1JrdYHjKKdBWqcR6njw==
X-Gm-Gg: ASbGncuxpoSu4egyWkmLCTBme7d+8NfQrL8csp9KdbNpmFT6tUh7JyS9pJMwvH8kv4J
	+NuWYUZJXMD8XqyYObBUbpb/s5+FAU2Is63czBrf6FsgA5W2afKXJDmRxI/IB4k2bHQYz6PVFol
	TdhNDmF59GVaxaMdXP4maCgHJgOhvaUmxqf2mdHxx+ZP8pMXW9HKSAa2QRLcnk1i0PWNHJ7vs3m
	6rsaVBWHyNWVNpJj/rQ++3p2dYBrE7rytjUW+diTO1cRFqx+f+tIj9Ze6UCH9FxJ26AsrYNqPrC
	rAIuqpQl6L9x9KZ+s+q5wnjnjpGMgF6D7Iyjq9wFoM/aFkon7ZzCcvf/rc1TUd+M4XNBjVHogFD
	ccw==
X-Google-Smtp-Source: AGHT+IFhduwn/rRAEaL+FI0RGehFzGELcr6DLmdA34BaWkNTcjsKbjLXwJDdoBUMWp8GWoEhRJYC6A==
X-Received: by 2002:a05:622a:1888:b0:4a3:6cbf:1fb4 with SMTP id d75a77b69052e-4a9ec7df2c9mr34202391cf.29.1752147258112;
        Thu, 10 Jul 2025 04:34:18 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.207.44])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9ede7657asm8025921cf.46.2025.07.10.04.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:34:17 -0700 (PDT)
Message-ID: <686fa539.050a0220.218001.1158@mx.google.com>
Date: Thu, 10 Jul 2025 04:34:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5390266782456259201=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections
In-Reply-To: <20250710-pa_link-v1-1-88cac0c0b776@amlogic.com>
References: <20250710-pa_link-v1-1-88cac0c0b776@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5390266782456259201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980979

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.66 seconds
CheckAllWarning               PASS      27.27 seconds
CheckSparse                   WARNING   31.11 seconds
BuildKernel32                 PASS      24.39 seconds
TestRunnerSetup               PASS      474.87 seconds
TestRunner_l2cap-tester       PASS      25.52 seconds
TestRunner_iso-tester         PASS      38.54 seconds
TestRunner_bnep-tester        PASS      6.30 seconds
TestRunner_mgmt-tester        FAIL      132.28 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      14.85 seconds
TestRunner_ioctl-tester       PASS      10.10 seconds
TestRunner_mesh-tester        FAIL      11.37 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.24 seconds
IncrementalBuild              PENDING   0.80 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.205 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.204 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.126 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5390266782456259201==--
