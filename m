Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0171B6CE0
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740812615; cv=none; b=NJOCGTknVHqeK6WQ2NtChGkLy9imr59o1l/7izH8PK4Q6Jv0mt559IGl9mFDSOj44wTr+UZ0+WcM6rReXqy5e713jKhJ5MnCZDL+ipSoeXbqrTdOlROyTogC6bJ1eltkDz5vgdmRIAyWYujdkB0MLQKmhr7uwf0qqcNgd+hvIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740812615; c=relaxed/simple;
	bh=7j0qnVcW3tI+/e+Jl7lWjGRmvwFStdVqVYHRi49SDVY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nUph5xfOZB0nehloO6lyBk6M5d30bIqUmmCkypUIKN75xZh2UpYd67ygKIFjbhEBFSapfHl/jP9+pXroa+DH7Rnz0rEi26iikZw5OLgReEMmMbYnOB5uxQiujz3YAFCr+0v2MKW0SZS1M681djDDpuMMaIGpChe33EaQpZsRRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nflZhQ8j; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nflZhQ8j"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e894b81678so14667546d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 23:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740812613; x=1741417413; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bRa9dPtbv3Xn5UyXeYE2gJ2+o2lvv8zGC+Z7WUh2T4E=;
        b=nflZhQ8jzfvq2lH/eUrZBKmxMAMr427DakuoCdsyHCSiGO21ZkC80GlKbduWSHcKkR
         V2RxjD1WOr3oX6p7gFgFsA4IjRhZZAmfphzYU+sUS+AI/1WLPxxB5waHfQXmCLqd9G3Q
         iwhZ6u8UcaWrY+EX1G3X2iI/Hr694l82ZwO/HwzzFXBDpvJvXSy3GKU62RalNADMlpOP
         SLmXBN6Xj7vAkaF4YSx91avO+MIsiMohmD/0h4rvvgW5ZjbzIvTOckXMGpERvVp9fTY9
         lYyBG3L5p9BhCh4GmfHZdEzr/jtnnigItlbFpuVRvaTYPXhk10WP/aY5iSSWMCp69jMa
         +MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740812613; x=1741417413;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRa9dPtbv3Xn5UyXeYE2gJ2+o2lvv8zGC+Z7WUh2T4E=;
        b=LZJVL2Bw4Up/PIOG1MpqqcoYmzSQqrxyft0nIo3AtsmjJySYqh1vPe4hLg1zxnG5NG
         SF4np5xj+BOwN/16cvE69vGrM0+MPUtmhz8owDRrJzWEbm49s5tkCd49Q4a5cIGuTZD8
         tc0AjE/3gLDisStmeEAcjk+l2Qje+FaY61kJnoynLU4UA0erSRKrjg0FAiIXfAn/P2OH
         kPPx+Lx6aTEHoVm4JuJMx8BIqeDMvVwIybn05NvH1eVptcpOeBPAhT2cYjKR9oMsO0VZ
         nB1kZ7VFIOmYP6k2dDQrgXA90TJsmGIg66QM8XRFmZvStHpcwY9wP4yN9XX4Uh9tbNga
         BanA==
X-Gm-Message-State: AOJu0YzNXcM9xY54GgPy5mDGuixKlAMEvymRtHmOe1wZeJP8faO3i0uL
	mYcayf2I1FS4xqfEfEZ1AUQMR6WC58vYQIhM04MR6f4IW7quuBIDbvoqaA==
X-Gm-Gg: ASbGnctd3Tk9rMAmGKb1y9H5ctsDlz+jJGChEBofrqsaEN2AcDa5DJGFQrvJ1W25kCR
	j4Y224BR3a9KfjvxmxLYbyp4jc2sNT+CFZePNFvarmVWHCGOyFZRjhetSnsBX1LYXsa3T2LZu0Z
	g9nTZiemQzFqAEHIq49l5v5R9Fcjh/klcyc8foVoCyUJmO3GEdLs6QP/8eM76RSa748aM5njcTW
	XQsamrBc1k2V3F2Gq5DApYxcJd21qUJx5CPE6LTvrqA7ItJWfoMmtIbPm8DUGWDXtprf3vEyool
	iLJzazawqbTpN9jUMXsmMpS9PRTNal+HURG8SsFvmHnOFYis0A==
X-Google-Smtp-Source: AGHT+IEXxkuqgMRK9jwpmdRnGvLf9EyXO4LdU/jERZ5/DZoDQJEg4FAp1/DKE6HO60YGRpOQKL+OJA==
X-Received: by 2002:a05:6214:2b0b:b0:6e8:9444:7ac2 with SMTP id 6a1803df08f44-6e8a0cfc1ebmr90753926d6.13.1740812612832;
        Fri, 28 Feb 2025 23:03:32 -0800 (PST)
Received: from [172.17.0.2] ([20.98.37.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976d9fb8sm29924566d6.94.2025.02.28.23.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 23:03:32 -0800 (PST)
Message-ID: <67c2b144.0c0a0220.22c682.bd91@mx.google.com>
Date: Fri, 28 Feb 2025 23:03:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3042718509728319689=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nishiyama.pedro@gmail.com
Subject: RE: Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
In-Reply-To: <20250301062301.18029-2-nishiyama.pedro@gmail.com>
References: <20250301062301.18029-2-nishiyama.pedro@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3042718509728319689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939232

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      24.21 seconds
CheckAllWarning               PASS      26.45 seconds
CheckSparse                   WARNING   30.12 seconds
BuildKernel32                 PASS      23.86 seconds
TestRunnerSetup               PASS      425.32 seconds
TestRunner_l2cap-tester       PASS      20.66 seconds
TestRunner_iso-tester         PASS      35.46 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        FAIL      117.97 seconds
TestRunner_rfcomm-tester      PASS      7.80 seconds
TestRunner_sco-tester         PASS      11.62 seconds
TestRunner_ioctl-tester       PASS      8.22 seconds
TestRunner_mesh-tester        PASS      5.90 seconds
TestRunner_smp-tester         PASS      7.19 seconds
TestRunner_userchan-tester    PASS      4.89 seconds
IncrementalBuild              PENDING   0.72 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.195 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3042718509728319689==--
