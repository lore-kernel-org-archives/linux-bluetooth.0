Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B83845B8
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657411; cv=none; b=GEWA3h1jyMUl5UbW8YzSBt8tFVqAcPth5VJJJE9phPYhfUNY8PrQjqckSQWtbbVnqXZAeQkeHAu8VzfKHCD4UAFxm7l7ScCyn7NlnIJfL4rqRysViH0NcnuT5tRBrXxqXEnGiTcWvyj9Qod0eJhVKrQKd+KQASqmm2l3s6anyuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657411; c=relaxed/simple;
	bh=cqgY/yiVgNWPkV62EqDDsWaMplZehHQKFi4A1YVgLYY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V/opW3YGo1oSJIXqzfRL2uVNYaz7yncUskeFGPVP0XhbX2UW0zVwwBReltL6iDwSRoECdZO0CZmrXqdNUaSKwIh1Lv2rbMZ9h2CfkaHumEYbmjHf21TH1zx03NiOrBD84MIw409kJPv+3EYGmf0CwHpMD3B4q48/HzMMLh0LVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y003tXXA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y003tXXA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb3825b0fbso707006585a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772657408; x=1773262208; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LbRyC0vUtCSOxl2i/563r9mHFGEelDJ1+K6/4GJrJXU=;
        b=Y003tXXA/wWHoKy6oOeROE5EeI4EtBtg3g4OWCgpiWUS9BOBHLc8h4AGBMYKIqNDwb
         44NQuRIQhY6FnYJdueWUIjt2AQqTGSgKj+/Q1M6Wyit02f41gi388leZd+vtR8iDVX5I
         jdJjdO4Zun36C7qixCF8sr2EALeG7mIDbNTqz4dV5aUiD8wkVu2vHsa4x9Ab+gU5RSvd
         dSSZ5HT7kxuAbIs1bw9C9Pi4dJLZCR2Di9GdOrVAeZs5ZzaLTZOw+EtFOaMnV+j8nUGG
         rF5ZtT3Uo5xhp8+NM9blKVcW3qo2Ov05LwAD53zzYdJ8pwrTPEGOsTT+zrClXaLZRMgr
         osPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657408; x=1773262208;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbRyC0vUtCSOxl2i/563r9mHFGEelDJ1+K6/4GJrJXU=;
        b=Ri2NF7e15u9GXTFAdq3hBS4j1yuCFmkNs/9AgbL/bEh8C64TmSmWM4KwJpJm0Q+PB/
         v5kj2SEHwwn8UcYdT516QBUbXDBaZsytwQdVr1O9Xb1syDJME/d+5I9dv7E4K/hdrCQ5
         CUC+L6MwWy28Y7QRJqkOEh3NEcMvTAVXyd70K+g62T/JZS6nR2bPvgvtfd1ev9B2Bw2U
         qCIGvKloKTjefPvz/Iyo/rwb215ZzKiUDDktZ3SKYCRxqHvZIFzCoRpC973vkeVUn6rS
         GEJI647wnioMZ+xV4ZqoeNLq5YTzWFipyu/tWWsRxHtP3yOcdmhKqIgqDkwtrzaXMlkB
         /HKA==
X-Gm-Message-State: AOJu0YxEj26FKh0MAcEYW+TU61l0tzar4+NNox1o6s2XFNBHbP3J1tZp
	XLAkgOPMBrVY2EO1U+W2HQCKFOZ2wXr0TxK2CX1y8bd9Y+a9OSqJrcmqj6B9mQ==
X-Gm-Gg: ATEYQzzNtYXqhYPM9vx3+CexgqBw1aSOm/Bgg5gtPvQkH+Jnqn+7yYTBLhbze1fMkJJ
	MRTvWiPIy5nGZn7Qeha2Irlxd2mpDvmLIsKJOkpCIHkYnFZV9HSpNG00X0yZ5Nx7h46BYixtBfN
	uPGXpF6BrX9gWZPnu8GW6jZRajyouAldoPyAlzizziAjtn2VC/QSYnj0y6qrCAH9NRvOw1Pqr1M
	hv3vAKRyrFeQkDj3QY26wYi4JrtU3/Uaa+yOMG/c1XYNPo1TxR3/IDdgLPNXmZpDJoFJz4+lBqz
	2Od/u6SvokqYPNXXenaZymMeCfmagJJ2kfZCIN8m0ZYzLMhcf2BZXdq0t1Rxyem4fig4gcOQx3l
	+gsIT13p76q6LhwRTNbD4jXi0nG5wB35JzChaqbyKgUGvNia6MshwNwK5ah3+qAVhlI3gP7IpuB
	nOq11J4Mp3c5g2ErrYubVyTKmVWHiKPw==
X-Received: by 2002:a05:620a:3945:b0:8b2:dcde:b668 with SMTP id af79cd13be357-8cd5afa5be6mr439025785a.62.1772657408091;
        Wed, 04 Mar 2026 12:50:08 -0800 (PST)
Received: from [172.17.0.2] ([145.132.103.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6fb519sm1729246485a.29.2026.03.04.12.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:50:07 -0800 (PST)
Message-ID: <69a89aff.050a0220.3aaa76.a9cc@mx.google.com>
Date: Wed, 04 Mar 2026 12:50:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4195027535880331505=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: HIDP: Mark BT_HIDP as DEPRECATED
In-Reply-To: <20260304200632.273572-1-luiz.dentz@gmail.com>
References: <20260304200632.273572-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4195027535880331505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1061551

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.63 seconds
CheckAllWarning               PASS      28.08 seconds
CheckSparse                   PASS      31.83 seconds
BuildKernel32                 PASS      24.91 seconds
TestRunnerSetup               PASS      562.87 seconds
TestRunner_l2cap-tester       PASS      28.51 seconds
TestRunner_iso-tester         PASS      79.50 seconds
TestRunner_bnep-tester        PASS      6.33 seconds
TestRunner_mgmt-tester        FAIL      114.59 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         FAIL      14.52 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.86 seconds
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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    2.770 seconds
Mesh - Send cancel - 2                               Timed out    2.000 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4195027535880331505==--
