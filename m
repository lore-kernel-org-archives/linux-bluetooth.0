Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693EF3E1200
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909874; cv=none; b=l9EGM1j+AiYuG+7o0Ttyy9APeOyKZZrnDxTQu3QEvgq7Az4pS/8xnfweWLK4pZKpLYPjmUEVmJSo61oSV/JJ6IJoPYqkjdWg+zY/aTj/XHeyw8EAMpC0l5tW3kE1V7xcxCmmcFX83krxo87GgdPcR0aMS08WbFp7MbJSw31gFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909874; c=relaxed/simple;
	bh=EJh0v1zL2BHbfGn8uv/2qL5O4hckkS9gRNtIW8ydZbY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FRv18Mi7D/acgpT3c7f8gctRLKMApOR1oRbBtMpHMzXJQr7ldJ3QoG61WKnBCFr/jLseEZ3L01uQJ8Q1GHzlyqVUrJbnz3uFrA7Mhd2bFdkbUHXzaM/aEUqPcgRMg3e07yJPGGb4dmv9GJUYjimaNcA+lxUqFk+y2crCbSRxuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL5RCA9p; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL5RCA9p"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12e332315a8so5157275c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777909871; x=1778514671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YTazPOz46SUr3KkDW6dCqN8pW4XkQsFNhu5RqiBi44Y=;
        b=NL5RCA9pBC2NJlqMHqHw3JCGipbLVcBqNa15mdtEseoRuluS0mBv8VQNrf3qSFgQry
         Z/kdOfLfKcxodeNONI4zejBMoDIsAiJBQajwXPCOtBbZPDFHzbW1xcpWcZmOmH4ALSVH
         deg1s9zzjPT3NWLJz+3+J6MwAD/nODrSE+i9CFaNHtDrh2KzI4VKn4xowIe97ndHqG58
         YcSHtiAkkKE1IZPSfFVz2vONiOYYzZWWFRIZZ8RtAbUiTNLkvWADTVaZOBuOjmcQShf9
         4D39ZfOsUjqYhCL4aEX3a7OvrxmUQOfWwraiYpfzhVZjPP6d9S/Ol8GUfH9adhum1aJf
         WGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777909871; x=1778514671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTazPOz46SUr3KkDW6dCqN8pW4XkQsFNhu5RqiBi44Y=;
        b=FrIJXlcNYCoilVGtECrcVw/4md0B2GWeqPknoLy1STXphh995ymVidYwy8KITkKC7a
         UYfCctq4NIZeYgpH0qdHxReGXZTxgI3K2nHZci9OowyNReZy1ZuEHU8kZ3bjpDeaNSbj
         NpkmNUSpMn5uImYDjzynnQUIVspvZbH9eJLQgejuOO630i1Yj8eoLmCldqp2OXP8tnKT
         /bhAP9wH+Ms0rAZBVzZj654TVXKgpb21jYeZM01tmOo6AqhaQxDaG+jEHIQqNgq1PWiX
         N+eyAniM5gMSUbzpaUbF9M8MUoR5ob3C0jD/bjQa7OaOCgEXRk5ZXnPKWB2NijHtYq8i
         eK6g==
X-Gm-Message-State: AOJu0YxYLtpo8ys1gq3UDBvBKznt76rAhgsvUQAV0yx8NWJOtJ3vraNx
	MwlDHi/O27JvVXL690uqP5Uq4hyusKzM8+N8To766iUE+Shs4XzQiyhJ4pThOQ==
X-Gm-Gg: AeBDieta9PFzM3New+u8Y/PAm4flV/WJq2igfL9zD8FKHwELR3uhUR6+aG3gTpllHSv
	fGmw5yKureaSDva72qTCKk7feK/bxLRITAPmOWYaDpgGXKZR+atQOnXyoCKPg+Du13F2Fcbm21Z
	g+Bmksc5PWTpojNpOrkhW7WdTVwve7bHNqWGULeElCRmHN0/dn8dSF7RKQrz3oNSkAbmKXY9Yy8
	QJF8VXsBYA7YVdq7Ee4malmNmjxFlWuArd5+rcgASyLdLs98J2w8dNUmw3F914R/NOPQ0iupfPk
	O12XstfLpg0mpdR1Y3w4X3P6wiEegb5cihfXzt8/1lgufKMBxkWWSBwuBjsJQEtpiTwFfQ2atjw
	/0VfgrmzQ/eJqros//j6hEF7UZ+tqR2hMB8uZieo4o3ECztrPAo0ngb3MZdXsdA/GYEde4H1Cr6
	bDT1GETePQvhs6P/570a8RFU6fn/IKpWK1V0z9+Xc=
X-Received: by 2002:a05:7022:e25:b0:12d:de3e:52c1 with SMTP id a92af1059eb24-12dfd84d5b1mr4561850c88.37.1777909870707;
        Mon, 04 May 2026 08:51:10 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8295552sm14519223c88.7.2026.05.04.08.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:51:10 -0700 (PDT)
Message-ID: <69f8c06e.050a0220.14571e.7585@mx.google.com>
Date: Mon, 04 May 2026 08:51:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8984185863561954850=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jannh@google.com
Subject: RE: Bluetooth: fix UAF read of ->accept_q in bt_accept_poll()
In-Reply-To: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com>
References: <20260504-bluetooth-accept-uaf-fix-v1-1-1ca63c0efadd@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8984185863561954850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089360

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.94 seconds
CheckAllWarning               PASS      29.43 seconds
CheckSparse                   PASS      28.45 seconds
BuildKernel32                 PASS      26.62 seconds
TestRunnerSetup               PASS      554.33 seconds
TestRunner_l2cap-tester       FAIL      6.36 seconds
TestRunner_iso-tester         PASS      294.03 seconds
TestRunner_bnep-tester        FAIL      6.60 seconds
TestRunner_mgmt-tester        FAIL      8.86 seconds
TestRunner_rfcomm-tester      PASS      28.81 seconds
TestRunner_sco-tester         PASS      67.96 seconds
TestRunner_ioctl-tester       FAIL      37.29 seconds
TestRunner_mesh-tester        PASS      27.03 seconds
TestRunner_smp-tester         PASS      6.53 seconds
TestRunner_userchan-tester    FAIL      6.70 seconds
TestRunner_6lowpan-tester     PASS      22.87 seconds
IncrementalBuild              PASS      24.55 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: fix UAF read of ->accept_q in bt_accept_poll()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
61: B2 Line has trailing whitespace: "--  "
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_bnep-tester - FAIL
Desc: Run bnep-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
No test result found
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
Total: 28, Passed: 0 (0.0%), Failed: 11, Not Run: 17

Failed Test Cases
Device List                                          Timed out  -30.834 seconds
Device Info                                          Timed out   -6.182 seconds
Reset Stat                                           Timed out   -6.185 seconds
Set Link Mode - ACCEPT                               Timed out   -6.188 seconds
Set Pkt Type - DM                                    Timed out  -14.375 seconds
Set Pkt Type - DH                                    Timed out  -14.378 seconds
Set Pkt Type - HV                                    Timed out  -14.380 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.383 seconds
Set Pkt Type - 2-DH                                  Timed out  -14.386 seconds
Set Pkt Type - ALL                                   Timed out  -14.388 seconds
Set ACL MTU - 1                                      Timed out  -14.391 seconds
##############################
Test: TestRunner_userchan-tester - FAIL
Desc: Run userchan-tester with test-runner
Output:
No test result found


https://github.com/bluez/bluetooth-next/pull/143

---
Regards,
Linux Bluetooth


--===============8984185863561954850==--
