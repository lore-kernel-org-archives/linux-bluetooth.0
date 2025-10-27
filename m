Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7A1990D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574903; cv=none; b=urzfFPDvqnY01ZnMd6uZwIBJvn7t4HN8pADqTKDDrx4nKgsuZeFwz0zhmF3kzmQ/j/3mxxeuDzR6yxYI1cll/NlKdAYKAKUaJJxgApUlN8+3qC7UQe8wStoat0oPDk9e7qh+CHY5NUiVif83KHPdHb5GeIbgViCcrIjVzPS4Zr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574903; c=relaxed/simple;
	bh=hlOOxULLciGrtVNxBWMX9GiGIeamAEBuAx4dYk/t9gE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=i55UpVrojP98Izqyj48XxTLdHyfvW8GuLKXYUZIKUxaJadesvSlB9QSxypSwXDqji1k9/4hjsyzJmOX32yR3x4zmlqK2uZ60YGUO2+I0ICv6v2eJT8JgsrVNDfWgywPYt/zEo8tRKjKcHn1+EAfRHmHmlzboNfqX1Q+DeA6Anyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIZi/3Iy; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIZi/3Iy"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-945a42fd465so63285039f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761574900; x=1762179700; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrdynMhMoLqeA4714o1fmB8p0telh6d9txOcNaJUS/o=;
        b=JIZi/3IyepW+FRzqo4XC6lbHFfI/q1BBB+iEcNj8pgn7uK60Ea7kbI5Avin7maKgZ6
         QZ6ff0ftVLXvE/lExBt1iW9OfPEyv5BW3r7Z44ZgkW8HSId9yDZZL3OTSuQfY7Ll+vDY
         17Cg8qNEgkpQrZoqBSon2B9emCmTi/vY2vUzFinTIjmP+3mmGI+i7WeuwyEGbIB1wqe1
         26olilfBqIIbuEQ4e3MSEKAXvk9B+yaTZJPtMQoJYgXvhb28nvhetDJiFhCEVoca6TTQ
         I0wgu6rAkDqMa7qflVveNuNPJKYgu8QTv+OtSokhBSi5c57lHEUDTpIJUjwTJ/xqOHdw
         wlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761574900; x=1762179700;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrdynMhMoLqeA4714o1fmB8p0telh6d9txOcNaJUS/o=;
        b=XmVbq3jbE/vWCQxLGuHRtGsujHwpxRvEBC1na9AnqmpGiwbC3/l2KJBlooCOcaa828
         xwe5abOZaX38qe8UZNMz81mVGIffp3F2whcQ8GEVQoJhZR4OU2gLLqYD3RHV4VhISB4c
         JDMHSqWvI9rqYJ8AUABLv/rPlY7jca//W+8cZpumW2ZEuBj4Lh1omSw8XR0DEXLCGyVN
         KhHdSnOvYaZcwCY5fWDUkQUK1Yij8r6RMNleRXeOqUU5+US5psVjNcAPBc8xyKwiFTex
         JzxQspq1FGNl1badWNiTHG9R/Md9B3aVa8cTzHojgIYA8+v0ww5X7CEnwFguEN7lmbuu
         SZPA==
X-Gm-Message-State: AOJu0Yw1hJNbhd0Hv1zxShSISkyt/6f9pZem2HEttBAbNubmdcpjUOo4
	XGJ1ztFl28wGYOUXHB5mCato//nYObQM3ysrhm6K5Dw6aU+zO7i3cBiPaWj23A==
X-Gm-Gg: ASbGncufZDDFqrtbjeE50L4khKljlIIbGWR4bE94PC/l05R1UKXVZ17HkevxcerDGpu
	zpdH3Lfv7NxnnklSrvJu1mm+YaGyMyfaqIYbrMhmINiysqW37I8acQsep2JU59KLMl8S8N1M3Tx
	9LU3CE4rWhBg6BqKv6uE2osC9ebx250alxHh4f/W2mNJ6K1eSfl2iG+qNkE9uU2TdTfD9VmeHf1
	lTmf7uDXJ3WfKaWJ027Lg21zuZ+TZT6g7RmJtDsfPAtrvOSfmDeFu9aPvbx2Y9Hx7i5bPtjecuf
	HPjTyqKN7h48zUHh2hXtUSwwAk6dbPY4OEd1OfZHHRXUx2GPeFc2S5ukVZ60m8ny2kNUxcsMoWW
	GimGEW5ltoFMfr3dAUaVAukZALkUbZ5Hxcu+uKHBS5ZDBFkCi/8vixNDkwsyPOP9vW1r4csTTH3
	Ri2YbMwSg=
X-Google-Smtp-Source: AGHT+IGfUxoTwJhHsjFR0O8JJnLUq/Tdsuwcc4y5Ovp0AtSDqMk1KUbYjEz+H+gF1qubFQaltv+WgA==
X-Received: by 2002:a05:6602:2d90:b0:945:a4e7:4d50 with SMTP id ca18e2360f4ac-945b84bc50bmr31751839f.17.1761574900227;
        Mon, 27 Oct 2025 07:21:40 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.120])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359f11e0bsm261774739f.17.2025.10.27.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:21:39 -0700 (PDT)
Message-ID: <68ff7ff3.5d0a0220.225006.3d2e@mx.google.com>
Date: Mon, 27 Oct 2025 07:21:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4799228386845697299=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sakari.ailus@linux.intel.com
Subject: RE: [1/1] Bluetooth: Remove redundant pm_runtime_mark_last_busy() calls
In-Reply-To: <20251027133538.393138-1-sakari.ailus@linux.intel.com>
References: <20251027133538.393138-1-sakari.ailus@linux.intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4799228386845697299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1016289

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.55 seconds
CheckAllWarning               PASS      28.46 seconds
CheckSparse                   PASS      33.93 seconds
BuildKernel32                 PASS      25.49 seconds
TestRunnerSetup               PASS      505.10 seconds
TestRunner_l2cap-tester       PASS      23.94 seconds
TestRunner_iso-tester         FAIL      31.82 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      112.64 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.76 seconds
TestRunner_ioctl-tester       PASS      10.06 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
IncrementalBuild              PENDING   0.95 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.170 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.962 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4799228386845697299==--
