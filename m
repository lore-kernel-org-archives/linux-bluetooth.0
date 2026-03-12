Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA83B0AF8
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348779; cv=none; b=l9tLifd2YQrMnXpNxur7cNRcv0dxImpibM/143wTrXVJ3rBRYtRiijxFf2qYYACzAUlDLH6mLWhUVHu5A/jIafE/fclOOZzvuNA3ChQnDLF9RhXoRVRpxGpHr9Tfh2GtsWOzObf6lbxN8FpyR5TqypReNvhqL6D3d/0tvFVErIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348779; c=relaxed/simple;
	bh=OLkJC1wJMgZ1t34dtg6ZwesmUZx8ftqfBNsLAmqfV9I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TIp/Dk0JvdnUJAAmFUlxqW94EX4klreUeWJD9slVyZ+Ykx8XLFnEbzrVjsEMUkSusUQvY87Ppco45xqT/OrSyel7RJ2q/deG70CUK22nY3eBL2ZAvXPv7G+O+/YQ/Xw/VSkBItaCS/h59449ngjDKTZgz9qU5gzoCVyatcktMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk2IjGxg; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk2IjGxg"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bdfc4b191fso1806132eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 13:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773348776; x=1773953576; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UOOKeexVeFCUCQsnNgg8vsQgXQ7n5LgNzgWwJHr2zmM=;
        b=Mk2IjGxgTr0GCFZVfXxhHOF5j9Tx4uMduzi/bFI5odzxkPga5OM7sFIXUFeSCsOBLY
         Obk0ykHPvAY9aMTyK0aKAyG1mqkjjkIso3gqNd0zeXGsQogOe4sBJUd/zEyuljAog6Ym
         HaRnSDw2VFWNyZgtGpcJjmlrSD0DR6yzJXh5BhNFTirx1/Vacl24Ow3x/FkzIYn0EkyU
         ptwYYmWFejv6+NzCiuscVFUjg5Xq7sZsg1t0HLtaTFA7pcNox/xWzLjmW3pKDKFU6BF6
         CYCvJEm/3LSIM7NGzs6UsyW/TfL6Rei7eM+dzXRr6GL3ZCKHlMk1BrYMoZe/D6Lib4O3
         iTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773348776; x=1773953576;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOOKeexVeFCUCQsnNgg8vsQgXQ7n5LgNzgWwJHr2zmM=;
        b=OA7iEynxYOeK2zH2/OJpCPmTFwjcdwvwdmQB/KlSJ+kcC/pUloW4IGtFtuyGMz7bbE
         XYFDvZ+pWTHMGxICr5tY46e7bxwV7Uua+DD5JAwgm8bdbsXr/Wbc4BYS/m0MF5bTRiYD
         a+WA+d7ckRqnGK27HQ5BnJ5gdW9nJb/k/5AL6Yy1TMhbY+k0s/91VOWsU78PlR8n4oNW
         sR91fqmSk2eZ3lFrJ2Sobyj0HWJVFs3RLyVGh+SmRQ0j8G6cT/I4iw9Ul+ErlmLYGNQZ
         ttczYT4lgFsl4BJVxaFlxV2WiuhsilsH/olkpVDiGCGbPC0k3esanVc0mz0RkWQZoPyL
         s5xQ==
X-Gm-Message-State: AOJu0Yx2OwagQpULqpZ+sZIkuGhhLcUxFS8IMBZdudsRZerFp2Dkz724
	woXPYZuMmkxT6R5Kcv8DxM3k1rF0qtxTw3eNW81DoVAIVj8iPQJ2OnX77hoI0A==
X-Gm-Gg: ATEYQzwEniMA/ip0InIQMlkHEoXTqaCbZJW8Gsim4bOO7qz7Eid1M88VXdZaqreFFf2
	SwmDQejjCo6BR6zXyCTOszBeuOccUG/ZcELZG586cMO2EhUupsFV+AeQqqJwo+adAchgX/JlvHD
	C0LjRirf6h/g0I+DvbtUqSFrDbA2HgdRUOlLq+6D1f+7xcKEx05pLBhbai0xRUXrX7ys7MOxdAu
	h6oengG8Aiw2nUZiQ3/BeAaZrtywp7mIqdtSNhnWPIGvSOJ4QoRIwfutVp+SZD7o5mZKbg3o1Cg
	PEH5smXSaRrdVszn2/OTyMoeGUScEZ+7psQ68c6RCzt1BI0+pPXUlmPr4tqKPNG0Fzx7HwMCqCO
	T/6xcMY1od0qs+NVtsULUsmVbo/SZXndxBFn8NBtQrwCrVhZ4SBfv/u4Yl47k2mGT7qHgizhv3F
	pUXCKfZz/2+hkNupXiO0gsoa13ag==
X-Received: by 2002:a05:7300:d4c6:b0:2be:969:75f3 with SMTP id 5a478bee46e88-2bea57294ccmr461627eec.34.1773348775455;
        Thu, 12 Mar 2026 13:52:55 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.60.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa96fdcsm8076421eec.30.2026.03.12.13.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:52:55 -0700 (PDT)
Message-ID: <69b327a7.050a0220.ea7f6.e3fa@mx.google.com>
Date: Thu, 12 Mar 2026 13:52:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3500857919224844951=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
In-Reply-To: <abMgjwF9IdkNhmpF@v4bel>
References: <abMgjwF9IdkNhmpF@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3500857919224844951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1065909

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.54 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.50 seconds
CheckAllWarning               PASS      28.83 seconds
CheckSparse                   WARNING   32.60 seconds
BuildKernel32                 PASS      25.72 seconds
TestRunnerSetup               PASS      562.46 seconds
TestRunner_l2cap-tester       PASS      28.63 seconds
TestRunner_iso-tester         PASS      94.11 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      113.01 seconds
TestRunner_rfcomm-tester      PASS      9.50 seconds
TestRunner_sco-tester         FAIL      14.56 seconds
TestRunner_ioctl-tester       PASS      10.29 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      6.75 seconds
IncrementalBuild              PENDING   1.07 seconds

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
net/bluetooth/l2cap_core.c:7803:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7804:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7806:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7807:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
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
Mesh - Send cancel - 1                               Timed out    2.751 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3500857919224844951==--
