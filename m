Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988501A6824
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782659229; cv=none; b=X5ld9G7WTh5zy9T90ZLzVkSkRJMNrIWi404B44tsd9fde5AGGNcRLLa91Kmor8t39Y35b0kfwvwnXyQ1DJTRy5RPLx21M2iPVQhfWWM2Hqbr8p4Ae/pdqViLMDrue/Are2JWhHzGPXEB30u33sZcF/Gu1i3dYmwNxzdVDO1YBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782659229; c=relaxed/simple;
	bh=8rCygv+8QreMiw7J9/7RLzMeUsz8HYyU52Bsp6pRz64=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DT5V2U45mXrnYN9i20vh1xousAUpuekMEvSuQLfE6lBKFVfQ3ujw8TMiyowuGXnAnc32QqJbJBcIlxCdtWa7rfpFj65yF/0cpDqxvegT1a6E7jch66F7aI8jvsAo+OpEiz0qV5DnCQnAQLQg8NmLl43bcSJFSUtf+/RSHy92m+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaGR4X9W; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaGR4X9W"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92120eb916aso273135785a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782659227; x=1783264027; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0LHhcfUwmRooJ5mWwHhfcHQV8BTv4sFjrRulqi0oZxs=;
        b=TaGR4X9W0ltlort5mlzvZKrq/8VFvbJqHc5wFQnnxjoGHqULF3d3npoF4lV36zrjGd
         L+3cAWpsbEvQzhCd1kLbEHj8l5UZ3GEU6RO1wFofcqIaENxOaHjgz3v4mbRsq0JIdnWL
         arpTLHpTbRGxRpq8Vn83K8Rkqbl3wITIHTW+47eqmHkZ5CKfHoK+g0jzELatQMVlyY0I
         IW/CnjECFTIb0z+EUbgSjFd7GrbBqv8EVW1Lm4ElY9BJ1QXgPLUq1VOv3wH4qox/Ob2v
         BfnbdAFyU3DGHpHc8xKF/R5N0nVvP2MJWnA1aW+f7bm4XNO2jo06dVkWtR2HOI675hn5
         Ap6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782659227; x=1783264027;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LHhcfUwmRooJ5mWwHhfcHQV8BTv4sFjrRulqi0oZxs=;
        b=QLsaUrXDPXTvkCLPtJF48sY6qK8btj5za8BglhFfSC4jSbRw63E0FN7zQAVyzxkoZc
         sksvP5tKabqRIgp18QLmKQa+rjrzCRTufISDW9+8Q56XAozksO8F9gtBVvp/JD0VZ7i7
         I8YPOgoaeFNFYmMNeI6e+Q53IMpCetURFbpMh66D6cnpUx3NA6DpFpm0MJ7nkjmyGJbY
         c47/7W4V3+kcnPIU3f5+p8dMer5LFhgZUVhEq7v+u9eLw973s4Nwv6udqSnAeUqvcKhl
         04f/C9V3ZHcl9mBWghzJH55KfD8GhhVQpTGdznL/98/+kTjjER9UiLiZSZkIjlDLUy/m
         c4/A==
X-Gm-Message-State: AOJu0Ywgv9NsPWAF686mUBg6wC/oafJSPYo32n0gXrWTvt2By91fJqzw
	4IWX+VBKdeFzlNcWyplLO1/rC6tJBEOTDpmQVmwgIHsjGIt+wxpvVA33gQmUlw==
X-Gm-Gg: AfdE7ckIBjcy5Xl6gkHzIJud0mXTjUPC9NdUJP9jvmjPzTexNwW66gCeDvn6o8LGJSL
	ncb9j1MZUU/mBHa0T5wPGfq2ytM6eISXEQEZ2o3wx3017k+TSpHWRj3fjMg8SOdC8Q1Zi+ZJFW3
	n+1jUVB+g7aN1YQJCAxoRRgx0PDWBYOHa+QM4qnRnFvsiFq9p6//4xhBvf+CJ3RFckxKuvppkXe
	e/gX/IcJbhPUwq4/toMrTcauCH/wlKxtYJcT39KHegGjcgKKuBVdhghyWS1S1t5+mkbc8SRz6Ig
	aARz1gsku8xl3bv24ClcQmnPbPQV2NXigmKvupJ6MNs2LDf+BtIov/sZRh+p5WCiQUplvrGOYAp
	/Yur3JNKMfFIMZJRGgcJcqBCxRDEo1j0QcmVPG0yWAdce/regjkiY/E0YJ3TQyKit0Z0gluvnAN
	+Rri1RgzbWM5fclSeJpOHZZNYTbSf1Xg==
X-Received: by 2002:ac8:5511:0:b0:51a:8c97:9391 with SMTP id d75a77b69052e-51a8c979683mr69140161cf.72.1782659227472;
        Sun, 28 Jun 2026 08:07:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.127.229])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51bfdc32a93sm622781cf.25.2026.06.28.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 08:07:06 -0700 (PDT)
Message-ID: <6a41389a.4b29c3fd.ff37b.e71c@mx.google.com>
Date: Sun, 28 Jun 2026 08:07:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3733814659749185217=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_conn: hold conn references in hci_sync tasks
In-Reply-To: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782652695.git.pav@iki.fi>
References: <7a22e9136652bfc95b52bacc146e5ac461b82ec2.1782652695.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3733814659749185217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117683

---Test result---

Test Summary:
CheckPatch                    PASS      9.42 seconds
VerifyFixes                   PASS      0.33 seconds
VerifySignedoff               PASS      0.29 seconds
GitLint                       FAIL      5.36 seconds
SubjectPrefix                 PASS      2.27 seconds
BuildKernel                   PASS      27.32 seconds
CheckAllWarning               PASS      29.65 seconds
CheckSparse                   PASS      30.33 seconds
BuildKernel32                 PASS      26.44 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      498.43 seconds
TestRunner_l2cap-tester       PASS      58.76 seconds
TestRunner_iso-tester         PASS      77.50 seconds
TestRunner_bnep-tester        PASS      18.91 seconds
TestRunner_mgmt-tester        FAIL      211.39 seconds
TestRunner_rfcomm-tester      PASS      25.97 seconds
TestRunner_sco-tester         PASS      32.02 seconds
TestRunner_ioctl-tester       PASS      26.08 seconds
TestRunner_mesh-tester        FAIL      26.08 seconds
TestRunner_smp-tester         PASS      23.51 seconds
TestRunner_userchan-tester    PASS      20.07 seconds
TestRunner_6lowpan-tester     PASS      22.75 seconds
IncrementalBuild              PASS      46.39 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,2/7] Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks

16: B2 Line has trailing whitespace: "    "
[v4,7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync

1: T1 Title exceeds max length (81>80): "[v4,7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.608 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/365

---
Regards,
Linux Bluetooth


--===============3733814659749185217==--
