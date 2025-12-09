Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC731DE3AD
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266019; cv=none; b=ZTtk636yMie/5eop0eo7TiVLTs08YOoJidv8hwlVGtwXSWA4YSZOTlxY9AWQF8IXzVJfe/2Ei+56W9s+/w9JtqardMVo5GWjRCHRI5sQQ5pRhd9rYneDz15tNeirz37aOPUsI1O2JldvChhcZdhkrICC7ZAf8DKJeYebhuyCESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266019; c=relaxed/simple;
	bh=FAjvoTlTtpojLfX388x+hsqRGNzcKFg284Jci0caeqA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tSic1fT24DYBEq8SDZgUwkA+3kGP/5sFVagwytEDC/jeavNBCj9XsiqZlAlYv6l72l1ywjis3HO7Mgp2Uo4AfPMYIAKq+WZIOzK6Y+eEJS29LSOEH4DraceMXcYtR8NaPuIA5mTHzKPLy6fFjwUlptGW27l0RyNUqy24H70pI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDgucNzx; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDgucNzx"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b2dec4d115so527250785a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 23:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765266016; x=1765870816; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jqnjCECiISAKBOQBvEanTRA3ZSSg9ln1Vt8JgYz6tEg=;
        b=ZDgucNzxvrz9DJqBuylqeAVQBHSJxqxKe4Vl7TJx3dZO9tOxZJGcCpkbff+ZlAsFWR
         lKZAP2MLO1SGYF/aWeurUCvXP1OhE9QxRl4wxIyb9r3gf/njzjWUqTSjxw4x94Q9pfHk
         5Y02dZhevji926ezTPtP7D0PLWUE5tDIhwNLddM8/OA+sy8TrRU6UOZWweg373wkqesv
         3nFEXRSRYcimtXMUxrQZxLynaQ3OgPDeUAyM5lFNl8B0AN+iIMDv3FlbnpqISKr1CAHb
         zNHWwWhYpzuVZ7rj7XIY/rj6+NDipA5IK/Yl/abqSSRC7ml9WDRETAZ+C0DoBoSFn+5X
         Lhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765266016; x=1765870816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqnjCECiISAKBOQBvEanTRA3ZSSg9ln1Vt8JgYz6tEg=;
        b=I5rlE64kgonOH6jeFPUaEanPa7hti6sQILifuoMHrNksBAAvzrj3RbDctikB9kNBQX
         zB0wr6kIPxT7Kk3/E+jmewqjy/av1cN5qZOF/cJVAGMTzJb5AF4Peaf4gbbE8HIzkaw1
         Gpl40DO9P0FJwTUp+xAzRpUj/ggADVB9NIUOpAfAbwIVFmxhn4cZfwt++4Kz+9oWbazY
         7/u1ApXfh55u/YaEBL/9Ck8CWaOf7RlMSj5B6KzjjGnGEqPnsuLVXT1AwpHrMwAt3pyO
         3AMQyycSgJc0ztwbZrANKdpEvvxIBntaR+28NXbtA046Fcj7Gqre3lonDi8GsUkfObX9
         W3qg==
X-Gm-Message-State: AOJu0Yz/ADntx4M+dis3ng1g6YEVAyAQZb6xti1FdaI6xJWGqV2hVlCN
	poLwK9Xf480CPNgv7ufoy01EVoqCK7Tyews/P4TPme0+EtsMOIQUyEeF3sQJ5w==
X-Gm-Gg: ASbGncvdUT31QmGg91T3s9tSqByBgjeek/7XE/2eDWJbNdTks7iXUhbkcuPPxQXYKc6
	YCWiFDTfCS0F5xqqjgY5NYVLUU8JglF2yPxXhqY8FZehlKFaEkPqNjKdz4ZKdrxit/vrEYskWIY
	A5iVAp8fBCaVYlkWziNKq+P1zJM6+j6d5qq3X8C7EmzNumqWC6TAsWLMXw4gud5giHRcska11f2
	zmkEsXZL3RQFuKhmh7u99F3CarmKS0g/z8G1L23uHDGMYsPiA4gQv+1SJ7yhCt9b+WqzTrlsrff
	9az9HxblvQ0P4kx8Q2qFVVRU/tND2dTfY/VlttXv5rP3VitsF3OZll2FshvNpc5oW3lN1x2LQOk
	EAoHjb6ccHSSk0RuiGBr3RpHc2u0NMArp6J8ZgAYoXJ6QhMNIs3vbnRjMq88c5XLa2uFJ3qn4z+
	ZzoQtHuxw2S81Sa2hdXg==
X-Google-Smtp-Source: AGHT+IETF5vmQRFp36bqOkXSTDubWzf5SFz9jzZ8h3J0xCYxrsR2pfVawJ7XNav6MHIQhbKzEqwjAg==
X-Received: by 2002:a05:620a:1708:b0:88f:ee0a:3d66 with SMTP id af79cd13be357-8b6a25a951cmr1355913185a.80.1765266016151;
        Mon, 08 Dec 2025 23:40:16 -0800 (PST)
Received: from [172.17.0.2] ([64.236.140.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627a8a9c7sm1248179085a.43.2025.12.08.23.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 23:40:15 -0800 (PST)
Message-ID: <6937d25f.050a0220.1f60b8.20b1@mx.google.com>
Date: Mon, 08 Dec 2025 23:40:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7248679673720887597=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: btintel: serialize hw error recovery with req_lock
In-Reply-To: <20251209071248.3575845-1-zzzccc427@gmail.com>
References: <20251209071248.3575845-1-zzzccc427@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7248679673720887597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031579

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.34 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.47 seconds
CheckAllWarning               PASS      27.48 seconds
CheckSparse                   PASS      30.42 seconds
BuildKernel32                 PASS      24.77 seconds
TestRunnerSetup               PASS      558.28 seconds
TestRunner_l2cap-tester       PASS      24.90 seconds
TestRunner_iso-tester         FAIL      57.49 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      127.02 seconds
TestRunner_rfcomm-tester      PASS      9.67 seconds
TestRunner_sco-tester         FAIL      14.68 seconds
TestRunner_ioctl-tester       PASS      10.38 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.78 seconds
TestRunner_userchan-tester    PASS      6.69 seconds
IncrementalBuild              PENDING   0.44 seconds

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
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.179 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.160 seconds
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
Mesh - Send cancel - 1                               Timed out    1.793 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7248679673720887597==--
