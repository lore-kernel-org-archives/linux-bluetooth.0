Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C342F9984
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411557; cv=none; b=KNT5I+EP20AZE6GaUlx5RZFo3Ug9Ps5bEzobEgfmZNCUjv+OKwLDILQkkAwpAldT3ZR6VkaUhYJdeZMBJ+PcOsN96WnDR7dhTo1NwKSo82bODxJkJykxvJSvqtSFDlrwTISG1ZUYAgdgyZr800rbVwDsvorea4gwJ5ccMmBO6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411557; c=relaxed/simple;
	bh=ArBnq2/+cxZGN8xreeK5l3lYEQj0a21fjJBFrRRXFvk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Az2l668+ph+3ukXK+wKssnxys5sCTbFpFo1a89oRJox8D24jSn9uFp1TZ8xnEgzof5UX0eqjQYRUr7D/tuhM9TywPQJK5n/WNzO8F//i56edbI7/L/nQ2Vra1ERaS97AqAG1cIcGcaApSfbAzY07Cx540gHx4Z9cdHLmgYFPTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwSlciyf; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwSlciyf"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-11b6bc976d6so7222674c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 05:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766411554; x=1767016354; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv3L3cVJbo4h7f4WT9O07gLsFhZltn2/BS2xq+1YFuU=;
        b=QwSlciyfdxCsJGymraLTKgQ6I9L1Bc/g1jrhPmuzho2ZtyD4IW5bXKQ3twQkuKXqXW
         EWJjidFGTjb4rB9D5YpTRZuxe/UoKdgtEJ4UlMLCYnUNuAK0P6QzeChm2iKmxRZWoeJO
         Iwm5tPYCMvNN+/hfZtDiS4VWHC/SVssbrApkFKLNX6yPosE1qm2dK4lzPwZqGxq9YUNN
         YEakdfDAmHGbTe1wP+TaJaKiGwefIHJqiFgsDVyfKue7SqQDMHwOpagBVSVT4G6KxmEx
         R8F4DHgSz1bvDJHz0k0WgLimFDGXwdMi1AyNyoGUmoXRayWdr3wAubtGbcEhbkAlgZ9M
         KQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766411554; x=1767016354;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pv3L3cVJbo4h7f4WT9O07gLsFhZltn2/BS2xq+1YFuU=;
        b=Qp99KNXm2wMgc5/MoBK4Aj5zPgI4hUd3PnjJl5r6zoJRyLue5uvzukMQ18suWxB6Ga
         cnwKkLrWxZrSILGEuw6mvJwYg2AIufMZbUVFLHepBo7I8Ob7KvZJSWdXEgUFloXbsxmJ
         0Iar4j6FmXISEvcALe053AkJMYD2EqFgTarfypWPx3KjLwy3NTNCtwZhWYX0l+MUKvoF
         Bq9cgkbyqi5tGrPkUH/Wr8NdLCzoEX3uX5IbTVRfJNQwDn21LaIwyGgLJKDmT2Yvo4dg
         Z0HjypCjr40lM0jT4LukLwp2btQlOH0+Fjn1YTNRmn6r7HtfZDtRyk1Vv61OGzhnT5kU
         m3QA==
X-Gm-Message-State: AOJu0YxIBIZybi3VqSi/H73heVhedk5QDIlVdO2RtbDGZ76vGiwFLz7X
	a6pL+0EaHvG/Mwa5+kDY9IKlhw5AqFFbsmVjMock75gcC5YAZmSTCs+R1UYuj+Wf
X-Gm-Gg: AY/fxX5IesbB5CVsEvOTfJ5Y2sIXgYMlSZsDkl/+dk4IH7giaKXD9DIIHgw46czzDhm
	69tjTXCzmzfVwOd75YcOWSEaxRX2/Mj3Mj9/glJpnABQ7G/El5VgeCoTgdv4TbCDq4Xr54V22hY
	MJn6ogqXnSjrtslkd0Jrs1ryBzEUV7mmeQVsdHQJ/Sn/0P+/bnmY8ZALGOe7B/c4F8PLkf+zuWU
	fVXdJTcRKW5y2P5o3TGFt7wmk5Bo/dAwP0a1eyd/Q9D0oOn5FOqIQpZnb7QHj0f0fu9OWyx/QgI
	uwFayqgm9ywDSiFWScy6ts2IroMh0WgKNKOMXz3L8rRrjUH++E1vhhb0C84+aGBbDSPLdukDrNG
	hV0xWLg1VUu1zU+TikDxoGqCj3kGsOKsv5ackws/I8VjFgZf5CONOBBr8FdzPvs7rZn3juQM0lY
	Ue5/Xf5OTge4K+STvpSQ==
X-Google-Smtp-Source: AGHT+IFoW8tUeKKPWmqcFo115x8wvOZkSDxiRkNyJnoTTDR1hzazLxYeAcP7Wleo7J/xXyvqK55Dng==
X-Received: by 2002:a05:7022:6883:b0:119:e569:f86d with SMTP id a92af1059eb24-12171a75912mr14243276c88.10.1766411554156;
        Mon, 22 Dec 2025 05:52:34 -0800 (PST)
Received: from [172.17.0.2] ([172.215.211.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm44562134c88.1.2025.12.22.05.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:52:33 -0800 (PST)
Message-ID: <69494d21.050a0220.336b33.c054@mx.google.com>
Date: Mon, 22 Dec 2025 05:52:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2234297443149497294=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] FROMLIST: driver: bluetooth: hci_qca: Always perform cleanup on every setup failure
In-Reply-To: <20251222123824.3000167-1-jinwang.li@oss.qualcomm.com>
References: <20251222123824.3000167-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2234297443149497294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1035706

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.38 seconds
SubjectPrefix                 FAIL      0.42 seconds
BuildKernel                   PASS      23.79 seconds
CheckAllWarning               PASS      26.01 seconds
CheckSparse                   PASS      28.72 seconds
BuildKernel32                 PASS      23.42 seconds
TestRunnerSetup               PASS      512.69 seconds
TestRunner_l2cap-tester       PASS      28.69 seconds
TestRunner_iso-tester         PASS      68.25 seconds
TestRunner_bnep-tester        PASS      6.29 seconds
TestRunner_mgmt-tester        FAIL      122.41 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         FAIL      14.59 seconds
TestRunner_ioctl-tester       PASS      10.08 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.110 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.174 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.175 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.851 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2234297443149497294==--
