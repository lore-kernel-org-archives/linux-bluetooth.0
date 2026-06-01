Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F722348C7B
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297865; cv=none; b=lRpiS6O6qVcY+Ubx7I770MPcn2FdciUAqG19rweVzcvOsQ/akpszIcj8S7+pDwVatYlUJAD5y7y7O8QXvzuZuoXVl+iw7Yq6LTb1exE0qSbZviKeeJX4TNnmVkW6c0vo/ujDiut5av3iSoVDUj9N9hQ6hXRwL4VKRLmGoar/U+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297865; c=relaxed/simple;
	bh=AGQZ4+0rA7scgJPEVZy39Z9cLbuyO79oJgdfqQ1hu2Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ngdF4zAJzfESO9jbh2rNHyNvGXK2mQ7a0tB4iBGJZKD/EceWYtcBa+YmBcHm8rp0Oz89nR14wdHGr5jVhrJ/KZD3IsTk7BNZdzwlkleuNz9n00Zq6juZu2aEJ8BP08wWlzEFHDhT2oFyGOI+ZKFg4E280pnR5jClSkXdRuN5muY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVoeydmc; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVoeydmc"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304cf518c9dso5673489eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780297863; x=1780902663; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VWIqpv09kTXMCK2VJXdgQHoJHNdUnMHcYr/hNZRkmb8=;
        b=gVoeydmclkVpt4YBM48FJbn0Hdw5ZbOJf+DSOg/aGIMUzit+KGdI8+YaH2FHCLflYy
         HWsZ1vKNRBtcO2S2aGrbkSRH47mxyfItIvIThik7cyJs+bCrbKOtse6Cc65/GlrhELro
         hD2NKbz2lNbvzinoNHViULLYDhvLVsljPYgqnZCqHA0/P5S9Cp0qou0lYGor5Z6ZPZB1
         Ez+8NRGYu5CEhR0y/VJOVKbYo1eYC+t+KT8VKBJR/nutDkBPiFAI97CtHhuZ8lIEkzmC
         ziaUY7SiDtESx54xql6vRQFDIwo0OWavZuJxHEDLsLSWkFqI3vkhe4n+rKDzsn6dCE/V
         EZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780297863; x=1780902663;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWIqpv09kTXMCK2VJXdgQHoJHNdUnMHcYr/hNZRkmb8=;
        b=STPgjwuhNSyja3sGr6b7lmLsv1uX/tMwhrhhdix9UGM73gcg8cNKhXyyONIMCrraeJ
         l7wHbNDGHRXEbCITdJHzg4AniBDnvB0ITkChGFUH4Co1YClSdn/WGRBUoPrX+bcLvtPC
         5aQxepZdNz7iSQT16AHW83hYgCxpwt0Fy7jJ+MXE4ji+I004ZSsn0SapcbpC/1kWklNT
         KE47UyQ1xz+alOzaU6GgzOSdHH761z8bBwofsAWQriqArslh6TkSRQ1//i5PneGbJItV
         qb9nn6rSUh7988qSTvneDYmRActcxL09qacWU7BrQ3QbeGyxgdMyEnunB2oR1OXpf3Cy
         9GHg==
X-Gm-Message-State: AOJu0Yxmeh62ZHwxt8r6XkJ9FGmoMco4j2Np1HNdwVT1NYJ9lWG9RrbM
	ULu8nUoJIgz6gQRfs032+PnALQnqpgWC8MUpV+1tlH9zSlgrSe63tCvIkjq1iQ==
X-Gm-Gg: Acq92OGADthE3hBAr5zeEmoX5ELyVWxV10DH2R8YuCw7mUMgUktM3pAQayorl7eZdMp
	Zv/Zu0EtQ/BpXnrt+/TzUAdLmHhsaEmx9Mm8790gLV+8ZPOnqe3fM0RkY+PL+mmeuLGCV7UpSHR
	kkZ22+fcelTuafRHarAKtfqeXt2FGRpWMshTE0ZQBwvZ+VCldGkppVvONrruTV1xDbjHPzTcUmx
	NH0Po1fTA6FCgKm9J23u57PeYsMQryJr0WIzQu9kTNWHfeGqUrB8rdWGc2gF2r15tbrVoquqpct
	mhrvJp0cUWGE9EKG/FQbuP17Pm+iOADOOPtpxwKUff42UdyLYYlv8Ki1ZxvuJlnOqIWKIoACZWk
	v5Z7gCeX3/qs1iZalD/FpCmblG6nXoGXT6jeoLNamUjTQR5pd8wVrAaPzqKSx7tt2OVwqlXHvnm
	4hW8lvH7lf8vCng/J1GABQfZf567tVuiBg5qxC+oV4WwE=
X-Received: by 2002:a05:7300:7fa4:b0:304:d835:27f with SMTP id 5a478bee46e88-304fa5ee2f2mr4566771eec.22.1780297863244;
        Mon, 01 Jun 2026 00:11:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.195.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69c0asm6672504c88.11.2026.06.01.00.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 00:11:02 -0700 (PDT)
Message-ID: <6a1d3086.e877838e.2f313b.ec03@mx.google.com>
Date: Mon, 01 Jun 2026 00:11:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0191988328227507180=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kbreddy.rpbc@gmail.com
Subject: RE: [v5] Bluetooth: fix memory leak in error path of hci_alloc_dev()
In-Reply-To: <20260601032426.119034-1-kbreddy.rpbc@gmail.com>
References: <20260601032426.119034-1-kbreddy.rpbc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0191988328227507180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103734

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      26.23 seconds
CheckAllWarning               PASS      29.19 seconds
CheckSparse                   PASS      27.87 seconds
BuildKernel32                 PASS      25.89 seconds
TestRunnerSetup               PASS      575.48 seconds
TestRunner_l2cap-tester       PASS      62.40 seconds
TestRunner_iso-tester         PASS      86.46 seconds
TestRunner_bnep-tester        PASS      20.30 seconds
TestRunner_mgmt-tester        FAIL      219.12 seconds
TestRunner_rfcomm-tester      PASS      25.38 seconds
TestRunner_sco-tester         PASS      32.48 seconds
TestRunner_ioctl-tester       PASS      26.31 seconds
TestRunner_mesh-tester        FAIL      25.89 seconds
TestRunner_smp-tester         PASS      23.69 seconds
TestRunner_userchan-tester    PASS      21.00 seconds
TestRunner_6lowpan-tester     PASS      23.35 seconds
IncrementalBuild              PASS      24.81 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.260 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.005 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/263

---
Regards,
Linux Bluetooth


--===============0191988328227507180==--
