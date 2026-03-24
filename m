Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816D178372
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774325862; cv=none; b=NTaCU8fmyV7rzDqF6vk0ari+3nA2Ue74jx8kEAY325jC2jpuTCpp4pW6+cjfRiSoZvMwko7kLj7yTyWzkNQZYD6TkxBAj4zO7Bra8c2tyxiD+6prs4IM9uQJDJUYphiOY6ZCJVFH/dBmV3JP0ATffTEt3oPXMuGkda3VLtV0F2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774325862; c=relaxed/simple;
	bh=Ta4EfIXoVEePZNKothLQkDFoRYhlyvVuw6bBpjrj5N4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WtfGXFZmK3SAal9AUxl5EFQZ0tfVnf83ADghaiupMD0/dwPDPPAyI4h/tUy43R7ihTy+HHCwrPQPzdcVQ9f70FhjL7vYFpeQR4ZbavtesOTu0eNbxhDgo9BKL+BOUWOxGBPj57iaUSWvvPSsXJZOei2BMfk8GBSICcT0gc/+e8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDv9u7/P; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDv9u7/P"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1274204434bso4495526c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 21:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774325860; x=1774930660; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MOZ1yeSzqM+iLDjXcARk+oU7T26wLtPs4JRGFiNiTn4=;
        b=fDv9u7/PeC+f5z1y+aWvq9U2fDceLun04a7eQYHHFXXs3S2ol25uXF4LEVNjywiCLe
         23Xl4nHX67xik0ZxPYS/BvSToqc9QX2R1C84Uddygwr+xY/t4l2cxZ186kH4Q98scHMw
         WXnw28I/NK+uXHIfRlUztp0D/TXyA53UNDvy6XfWYonP5LQgvBEPVh9kMo2uI39VZtAz
         GFDfC12fHKOHdu7pGVOon93BE8f7apsSukfQVJJXGb89iwGowxexR/la/jxlvgYVvXvn
         EnIujfLcUTOr38w9UIF8ciN0tV0F/SRGf07QYc/RprnW+yOkvgRWdw++A11fp8SQjSA1
         vrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774325860; x=1774930660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOZ1yeSzqM+iLDjXcARk+oU7T26wLtPs4JRGFiNiTn4=;
        b=Vf9whNsO2YMwZc2vF53OR2WHWJ+oTcRN+FLihZg+ZO+ABqhYrfRFdD1QF8cbRHc6j2
         ykXeWGagRX/szfkaxmwbSQCVvh7fYPP5naYeBSm84P/VuPNs4Pbxe2jn/c12jCfnjlfo
         job8AIeR7G7j+RFUky0TYEocHILi4RydiQ3wcje6au1659m69ENVor2ANDF3IDRf5yPo
         JSqpmHn56K9Qrw0LvzAmjffjx0GjUMG8hdjhQOyl0a+BP8zFUSxKlT1yUIJI4i6Jdany
         +NvwbMmOlsl3Iyaw1HZiDkftLlxktSNJutqPlDUUxNWFrHLwMDDIUFhsZsWMTyDQKdbQ
         cBTA==
X-Gm-Message-State: AOJu0YxG69UKYP/CEz0b3U0lLWf113a7o3LDGI6eMu0cf+ciy1yWcEnt
	R6fg1NfIUDlLcLHOKXXXg+wYZ2Zk6JfQHC8gU4PaWqX0J8alJAYmf0QaO6vH4Bph
X-Gm-Gg: ATEYQzxgzNmHdS5BciXo8FVM1o+z7oY+sgS1VpegABmfca/KdRmWKZS2E8yqWKJAFEP
	SVVSn4003oj1Q3ZXT/Bdv+p2JZ1pkw+fdb9YhzwZzu6IDH0nUaOGsO7giOC+PqL5tyR1QOAjE9r
	kH8IM8si/8QY4/sH7MvlAOK82ePda8THTG/EiazLWluZtc8zljCKdWKtLC/kt20eStGykdAHQfh
	IeCY/l6rORlNmSXaiWT01jhG+epM2vysvxf/NUliIwYQzGw7s429BWK6+GfjFRlHaFps/QJq9HU
	m1zP72nVBVex9AqH9W1cQ6fuc9ruJJXdGVSXoKV7LcXqIYUhEeSXL0ID3sMREfUk2iWhbBdXU2h
	kblgds8x04t0OKbx5OrMbdePpezM6Fn3fj3oaB6yN0hCf0Hg2E/0PWUVSp3+WnkzB0RpFq58aYe
	v0n0+1FaWi+St8SnQy14d9jgeXjRY=
X-Received: by 2002:a05:7022:e994:b0:11e:3e9:3e92 with SMTP id a92af1059eb24-12a8e183efcmr831192c88.23.1774325860086;
        Mon, 23 Mar 2026 21:17:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.6.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b929csm10743429c88.13.2026.03.23.21.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 21:17:38 -0700 (PDT)
Message-ID: <69c21062.050a0220.123ecd.3a65@mx.google.com>
Date: Mon, 23 Mar 2026 21:17:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1648909896957140413=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: btusb: clamp SCO altsetting table indices
In-Reply-To: <20260324020427.60125-1-pengpeng@iscas.ac.cn>
References: <20260324020427.60125-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1648909896957140413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071323

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.43 seconds
CheckAllWarning               PASS      26.93 seconds
CheckSparse                   PASS      25.70 seconds
BuildKernel32                 PASS      23.78 seconds
TestRunnerSetup               PASS      528.00 seconds
TestRunner_l2cap-tester       PASS      28.35 seconds
TestRunner_iso-tester         FAIL      34.42 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      112.30 seconds
TestRunner_rfcomm-tester      PASS      9.33 seconds
TestRunner_sco-tester         FAIL      14.34 seconds
TestRunner_ioctl-tester       PASS      10.28 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.56 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
IncrementalBuild              PENDING   0.89 seconds

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
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
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
Mesh - Send cancel - 1                               Timed out    1.812 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1648909896957140413==--
