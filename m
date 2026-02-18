Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCA2FFDD5
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771420359; cv=none; b=tEXmRdR84MtiDG3mIyKtenLcJqWM4C2GGq4UiMSsGqmV05x50ROOkoycTBnHE4ipQEue4Vqodk1Cv0kE7ZqNndYsWtxcKfUC/cGewu22iCIkOq1Vphgg3ow4fh6rPc4ok4FVebgMQyN0cB8S34bjGwCFMn1PiWCfLnjLQ2j7SpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771420359; c=relaxed/simple;
	bh=VE3fXPI/PccvO0QR6HwMi0behUpkwBcZWxKNtjyNyV8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=faFG0fatAXxq+z08/V4hehIJv4nOAejrTsiVLxuoDrV7P4lfTaFDi8RnYwZLwA/1vZwoTOpIN5FVc5I2t3gI2+rRCOtzxAVtGR1g1xYpT/FInfKcQ4Do4T9EEE3aWlfRF+kAH7bVVupCvQy3dmEHjY64Px1Bg1wfHmDazdQYuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbflFbai; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbflFbai"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-896f44dc48dso46362966d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 05:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771420356; x=1772025156; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p7fNyA5hVpSDEnV4sUwP0Kjo0U/WhsL5tHh/pRy2oM0=;
        b=TbflFbaiKb241zU8QLWZKPyxAcDEwH2KwuNTx35czThCDLT9N0AACmqEDmTXLgPuLY
         b9wth+2/L8sg3c3tKF1l7oJWjaPsKC0ZyRNhUj1+niCMAtBsITn9C9dhGOXzO5BJYJlC
         +Wie6lUfGia4EwTHHbQrDkbeDDO+OIu9HMbkkwfM+ORM8QcpNCet+DlS0pqLFHn6y2w0
         qIsZXhLzjH2uExFRDNfphwFSMDsiV3EPBmD0g44JtpvKtNA0rbIRinCepCnXkJKc/Ph1
         9N7HDHcNNj6XZYLFeVr0HbJ7xFM/ONgPK1NsO9/IhqPh1q10L8bTqUCVjH9e67Fub1FE
         ICIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771420356; x=1772025156;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7fNyA5hVpSDEnV4sUwP0Kjo0U/WhsL5tHh/pRy2oM0=;
        b=SPGsSI/2SbjU0Eb8U9AQCceaVo05SqaOldNspvoZG9/+Ws6c2Zq3IaXBnMsToZpAFl
         NJB8bNrMV5ojmkmqEEBzL4263mcQO6IBr0i1d3pk/MoteqGPBVhO5KVfhyNOBOaQZAa/
         liIdrnl1WUJceZBHqAaEmBTbv9mCE/5B/qLfl6eSj1KkeyErItZqOBhcX+QSzHX6B0AJ
         D3Y8ZRceHGuKkSlHmgV+4zMaU8HCGWj5dxs/vxlIsiBu49P66mJA3ilaS71YRCGSV3Sy
         HmLJhf+ZN291u3tWWQceeY29U6YqOR7z96nJgw77Jq+FUEHK8E4NDq5QZOu25nDn45tR
         EmjQ==
X-Gm-Message-State: AOJu0Yyhka9dZC/qq2aTl9azWEHc6Kv0CxOtK1B7aMR19njOyffm2Sie
	UU/DVAOSuY3SefN4dUlUAp9PPncXSeHd1eU94jWi1u9d4FCSxo7QbDNeFIPtGZ8h
X-Gm-Gg: AZuq6aIXMQ+YcN7uvVSdsrNSS+HW3Th0aft6XVxPclTh7zGM1JqeUAAfBJfZAAzelFt
	rfRkteHS4dudVMYFYoVPK+tnZOrphJ9Sh5LGuP1U9wRGqGlDMsgPBJz43Onha8S3buBEsX9nYi7
	fhOswJASVpQb8zeuWeDE5Ax98tVnOpYNct0i1H/DhspuZjvhQkkeLzmOfQW02vUJcsnBc74ih6Q
	uhBvHDeR4CY2CCoNVVJv2/p20hYWoghHkwOTqSKsOUuySyFjpHOBPn0T3jJbbzs/f58cB5n5JRb
	VLFibM1siEOfXhohp+WFOEYsEQfANXFTpkG2mq9/dNyUeLtGv/QhkQLAaEtavF/hghRU5cbCDRg
	G3wFoidARMiOq/RBkgw+6HrBWgAYcWo+tsXSlqgohMwWR6R2+UBnSo9+Zh7X3e0UUHW2g1pFAPy
	g2sXrctT2mKNSRQsNHzJxkecSBW07Abw==
X-Received: by 2002:ad4:5c87:0:b0:890:7f0b:4108 with SMTP id 6a1803df08f44-89957f9fe92mr23137196d6.25.1771420356494;
        Wed, 18 Feb 2026 05:12:36 -0800 (PST)
Received: from [172.17.0.2] ([135.232.193.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cddb9efsm224697916d6.51.2026.02.18.05.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 05:12:36 -0800 (PST)
Message-ID: <6995bac4.050a0220.10cf4f.bea3@mx.google.com>
Date: Wed, 18 Feb 2026 05:12:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2979637010755743358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vivek.sahu@oss.qualcomm.com
Subject: RE: Cover letter QCC2072 enablement
In-Reply-To: <20260218114955.3970974-2-vivek.sahu@oss.qualcomm.com>
References: <20260218114955.3970974-2-vivek.sahu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2979637010755743358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1055191

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      26.27 seconds
CheckAllWarning               PASS      28.62 seconds
CheckSparse                   WARNING   32.81 seconds
BuildKernel32                 PASS      30.79 seconds
TestRunnerSetup               PASS      561.44 seconds
TestRunner_l2cap-tester       PASS      28.73 seconds
TestRunner_iso-tester         PASS      79.07 seconds
TestRunner_bnep-tester        PASS      6.47 seconds
TestRunner_mgmt-tester        FAIL      116.49 seconds
TestRunner_rfcomm-tester      PASS      9.62 seconds
TestRunner_sco-tester         FAIL      14.64 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        FAIL      13.21 seconds
TestRunner_smp-tester         PASS      8.62 seconds
TestRunner_userchan-tester    PASS      6.63 seconds
IncrementalBuild              PENDING   0.96 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btqca.c:1051:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1052:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1053:1: error: bad constant expressiondrivers/bluetooth/btqca.c:1053:1: error: bad constant expression
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
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
Mesh - Send cancel - 1                               Timed out    1.802 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2979637010755743358==--
