Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF62080C4
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227995; cv=none; b=iKNJ3lHxFnEbhXgxn0NBMd/fJEuio4/ye5JA7clfJOP/eXFlNzyAWnqmF+pmXieErsR8qZiY45YH8/6WMhuORYOgTvZQBn/LovBtSG28TEAht9c8g4SnZ/3pj9JzAFAky9B8H4rM0oUghr4lt9gUXyLfwG1uJHrRnjyXz8uwfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227995; c=relaxed/simple;
	bh=QKeDkRw/HhXwYP9ARKiKBJxkmn+RwnTWQqQ8TzimL6M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oZUhw6qpwViiwCNtTDlQZZfBZcLsqbkA68mrIzJGqnCmrZUNNOadUOmDhq+OroHYsFaVfsSYm8806EUjP3gpXmGNHTaJ7IGa1doJXgb02+THl4ZZb6IVxroEQuKzvNmAijJ1Ps3VIL5iDXA9vYPQ86xbmaMNSfHMvYzUXSj2/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHrh3XVy; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHrh3XVy"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e65e0a3f7eso14067306d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 04:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740227992; x=1740832792; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SEwA09bdl1ZQ9+PDr/dc3QbKW+S7/ooC0O0S1cvJwxc=;
        b=nHrh3XVytZDPsT0ymqqRF2QWiyy9bw28bhrDd9jTeMoasFfl2iG6XkTsUieFjv5fyB
         lCBDfbTqjYJYsNCCaDvpqvhD35aTENbRyAAf1lT4bYW6EtS+UXoHDTfhQkEbajWghDu4
         sy17iHHaHni6aWjV587oSzB6n+XMYmoOHbZvjkEaTKQJD55wYJcj+XmUxHqhK1qx25Cg
         nFOTmftavfwiSm5BHI11xkUlu2I6CzguUdtMQSd/hR6D+TqZUJaTkpqbly3maN1DljTA
         h1jqqlueZxnLB2MAbxu/Z0ewryUkssBS4O6jbxJ019QDx9BpDdDCzf1bDqgZHrCkygsJ
         BDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740227992; x=1740832792;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEwA09bdl1ZQ9+PDr/dc3QbKW+S7/ooC0O0S1cvJwxc=;
        b=a3n+PiQj2dJ/XhXeXe3snOxIpCcKEmHuF6meugCwrOd1wc4Yti8d98g19MICVsxuIf
         9oyaSxUEX6/4xcZ/dAWN4EDRSQ0cofe5MGD3zR0OtlAlDeCq/AryjITdqlP8nKaktYOv
         OzIBJ9r+NRhizS67AAnnftPWhjMfeO4Omy3aecvIzw3nDhGNwtBYUfw8iiCSb/gPilHX
         CgOivH03Qz7PQXbtstL4gDmB7MD+NF1R8rrJEB5HC8X8xBlRvi5dKrHwTJVL70MBuXV0
         qEGGMhY7odKBb00P5qwY2d8+/drhAe0cpRei68O8bSccVRhMyNGRin/+cGYuHM9JMZh+
         z/cQ==
X-Gm-Message-State: AOJu0Yx3j9vSDq2dzzrdjYkwexOzyZ2jrFofbnw8w9oNQdsrGrMXtcVD
	Wfejrmgt1h7ro7Jhp4jiQ8LC1TQB/RJ2h/GPoUI2oOU9W7hn5oQfnfXCy4c2
X-Gm-Gg: ASbGncu4cRxhEONEEIsIinHhPFPyXqoJpo4edJcBOD26Bqcw5yo89klL1Bfo44o0tWE
	uUu6MlaQV1nT7lazt2CvXLiMnQIG5/zJWRDlcp6GkTH/MI3ZwD+yeOR2lpjQ+Zef9k2mKDZKYDa
	IynF67GTwBERDpwfcNBWtLEfyEq6BTaMYdS4h8FYvYIT92cvUaUj539gngSdh/w4nYl5/U6gC3z
	IavaBe+xeHiGoRcb6eOqsUSENTpm0cL4KkMnTU00Y0Z2Mu12qLjP7UIsQ5oTm0I9bAPfYS3geXw
	nrAnROZcSEUDCZZ4PtEb9W+sL099hsgqZQs=
X-Google-Smtp-Source: AGHT+IFv9G7uRMOixyfp9mCusAeTVpqJULetxdRhO3UY6WNdJ5925rHrSOsuJjQDvm+G0Yd+pH9FIg==
X-Received: by 2002:a05:6214:c8b:b0:6e6:630c:71e8 with SMTP id 6a1803df08f44-6e6ae7d03famr83916856d6.7.1740227992207;
        Sat, 22 Feb 2025 04:39:52 -0800 (PST)
Received: from [172.17.0.2] ([172.200.180.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f348bsm109250136d6.77.2025.02.22.04.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 04:39:51 -0800 (PST)
Message-ID: <67b9c597.d40a0220.19924.da68@mx.google.com>
Date: Sat, 22 Feb 2025 04:39:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1073941000646456574=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aha310510@gmail.com
Subject: RE: Bluetooth: SCO: fix ABBA deadlock in sco_connect_cfm
In-Reply-To: <20250222114809.11634-1-aha310510@gmail.com>
References: <20250222114809.11634-1-aha310510@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1073941000646456574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936701

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.54 seconds
CheckAllWarning               PASS      27.09 seconds
CheckSparse                   WARNING   30.47 seconds
BuildKernel32                 PASS      24.45 seconds
TestRunnerSetup               PASS      431.91 seconds
TestRunner_l2cap-tester       PASS      20.76 seconds
TestRunner_iso-tester         PASS      33.53 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        FAIL      121.54 seconds
TestRunner_rfcomm-tester      PASS      7.92 seconds
TestRunner_sco-tester         FAIL      9.40 seconds
TestRunner_ioctl-tester       PASS      8.37 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      5.12 seconds
IncrementalBuild              PENDING   0.69 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:147:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Add Device 3 (AL is full)               Failed       0.201 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
BUG: sleeping function called from invalid context at net/core/sock.c:3648
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3648
BUG: sleeping function called from invalid context at net/core/sock.c:3648
Total: 15, Passed: 14 (93.3%), Failed: 0, Not Run: 1
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1073941000646456574==--
