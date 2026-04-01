Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12709472765
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060756; cv=none; b=bgDFsnNMqmvIWpGB4dBN2WiBUzNp5s9mocgrdhAi0tM9RhkHrOd3WyqW8JGTQ/ot+lZkDj4byoiiODPGal4G4rkQAcP6mTlZ61AHeQz1SRW9SrZMtVg6eltTcNfOHsneY1YXlWSDxS7m9B+bpdYVkEh9t16uOCDBEmHAca5Y10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060756; c=relaxed/simple;
	bh=CzWQzHfGNGgsEI7VrYojacj3lEI4YUxUNPOtaK4Ok8I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Njr63tEQwKRHyzFYa0neLttXmdjfJ5+CQxZAK3lEgQEr0GRosu1IX6RxCpdvQYavRCJqYIMNKUm+clB/kv/W5aMAeHX67gjuw3Q9ukEtsaHxA1PZoIjP+vHZD1MH3HzRQeSuJHt5aTZty/LXeMk1YI40iyMfFC318vgj08dNeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEQqveY/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEQqveY/"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a068db9989so10809726d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060748; x=1775665548; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf/7g6YR/eLRBYjXM/ViEgW01Jp94wW45hmbRWQPHFM=;
        b=iEQqveY/rDrBsFkctQPw7GrzOlVU10UnjovnUlggVkkfrk7vC32CfYTARvUkck3ijD
         JiWJtQ7SSCIOLAY5b7eZpURtaKiRc0IXS95Z+gU9+XC8L4K11146pGJNzKXJrtIYVed4
         HPnx+VSehbkDh0MVrkQFIdj0lAlykjCRLFNDS+8+gxHx8rX1KFdd6tOEIqN7iUkb7nSg
         /mfn8JVDq6HvzbuHaRpeHo3rsxwzdlxI7w6RPGCQJLkRxghzqlVKJ4gvaTLlpnq+bSvP
         hcycmpyCG1EDF4P85uPk2ildPqf/s1hZec5a8jM8A5bWx+S3IITD2OasxVWAvm8LK1RY
         xcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060748; x=1775665548;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf/7g6YR/eLRBYjXM/ViEgW01Jp94wW45hmbRWQPHFM=;
        b=BZVRfEtGzS9Espa07XuS6+eedDd+bIWOACaj1JUD9nn5GrK76Jsjz3IxYMswryzCb4
         f7bUmeMgdJYMFVYHu4EtFg31l2pe+8bZ68NZs5Q1Qt5X0N4Z2p+PDMLCYPjVoUFCfHER
         xG10gp0YV+0taEEapJi2TKM92r/BdMnTOClB7DWRxcZxRA84EaXDOw2Hutl5o3n+Iv1f
         Wdv6Jxjjucp5po9jz65tGbdfaj9StfETtPW9BrDzQbN4TkhXzmYdRAZ5ti7PJG57drws
         WxOX2rhEEQ2I6YBkpf5P+Wn/tnBy1KcLUBp2KVyHIA9WSEbWpkAsB7hTlgWYw0H0ZlB2
         tPfg==
X-Gm-Message-State: AOJu0Yw5aVDrLeejd+3uipvF2QG4S8LdLeghtvRyV6psVYx9fDM8SPkP
	2zXTGV1lkTCvQA2GlNB6Be8/bxBZxKynKJ2AyoRp9CU+T0GYmJQyY+w1bJgKgw==
X-Gm-Gg: ATEYQzyws4T+0hcCAFzbC3n6k5WzFRXxXsUvNvhgIXMpW3WOGU4CcUaBrMw+JpNZBoo
	TXPnUrgoa+d8+LDiClTZIBi4JIvfwRflDSUTnQuiU4AGvPUUCutCYV04olGDgJxRyXmQlKVnNiX
	0EmpERRzMAzLlley3U/P6lpp9W3RHbUasDgOO5sBsUONpv0ulR+Tx47PXQCfdHBM1BekpaHLG2c
	D3zIGzr8AMh/SynUakVLrRa4I+rwaLSghASubw8LqG8ROKn9Z/Wm/s9Suw3MFgRzzVV5SvEw8mE
	J61GY3XNsf/fMjkN3fixmnN7VMBGOrG/FePSs/z0UWZcZNpLnsv/WB5Gj+kXZTn+SRKUsZ0kqTw
	tkpqPEYchV7i1bJm0SQfepvylShH5Zw89EJOdflAGUA7oXxzprQEhV0RHNPtU4R5TSX5MUmapXX
	JhJtIsNc4RtKI0MnWfZ3+xZBmEXwBVzcxv
X-Received: by 2002:a05:6214:1d21:b0:89c:7bf8:c564 with SMTP id 6a1803df08f44-8a2cb576a5dmr118022556d6.27.1775060747578;
        Wed, 01 Apr 2026 09:25:47 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593906450sm1576906d6.12.2026.04.01.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:25:47 -0700 (PDT)
Message-ID: <69cd470b.050a0220.2d16ee.32a2@mx.google.com>
Date: Wed, 01 Apr 2026 09:25:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2155852883587131905=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5,1/3] Bluetooth: SMP: force responder MITM requirements before building the pairing response
In-Reply-To: <20260401160153.1980387-1-luiz.dentz@gmail.com>
References: <20260401160153.1980387-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2155852883587131905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075938

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      25.80 seconds
CheckAllWarning               PASS      28.42 seconds
CheckSparse                   PASS      27.16 seconds
BuildKernel32                 PASS      25.12 seconds
TestRunnerSetup               PASS      564.24 seconds
TestRunner_l2cap-tester       PASS      27.98 seconds
TestRunner_iso-tester         PASS      37.67 seconds
TestRunner_bnep-tester        PASS      6.35 seconds
TestRunner_mgmt-tester        FAIL      113.95 seconds
TestRunner_rfcomm-tester      PASS      9.42 seconds
TestRunner_sco-tester         FAIL      14.23 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      12.52 seconds
TestRunner_smp-tester         PASS      8.54 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.63 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.177 seconds
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
Mesh - Send cancel - 1                               Timed out    2.695 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2155852883587131905==--
