Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42A368290
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858222; cv=none; b=AtjUCxG7Pdb6yI0it8vZFMIlXCbQ3OZN9Gq4HvOMAkjVJu0uLJ+GmT2P1imYni1KNl3AKAAKu6y1Gv1MIZbWQK+K/XvKOicvM6P1VmsYuJEbKBVjCzg1svU7jzoqL6FQcYKSdXKy6cwt+U6r1xxa5fRzsaccE5FKH4Ri2FgsJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858222; c=relaxed/simple;
	bh=nkacX5LZF3PKW7MTb9w7McZ2oyGqH/bnFCpS00n5NdU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j/XEzWqo81CkVAEqI6DGCK8s07LjLETNOo1RMImb6m4KMFosJOEzmoFdrCOKPfnlDNvjgDAl7FrGV4NoBAAIOV4YIKuNKhkzN15Oh3lv2feX5UTxsmH7APLVXRTZeiVJjNAopdqPa77wY8WnaT6UiGGP1cmtOhTwuPAhjaTRlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PK5CBucY; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK5CBucY"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a34450f19so29197326d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jan 2026 23:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767858198; x=1768462998; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3d/g14TFJQ7VmqaQ1kVvMbu2ZGWLJwEHqwIJaEzJRbk=;
        b=PK5CBucY3VtcmjyMRVjB5lGPRIb897AHc22WI/qej5DaspG8OKFPS5fvIMyQ8MUDH6
         jUtCwda5muLd+KHBgL2ppLt2IvQwxw6bJdkQSeQdYsFgouDHj+n+myw3YPSxa+NWPbRP
         KwovLv4kdRgw/0ccRSdrx52K8fNMPQEBPHLKUKFE01d6O2t8VTZDPWF8OtLv4GJ+/Rlb
         gYPRK3qJ+yVF2npfF5KhyI2OpiktWCJAxadcXrBBg7f7YVMnn3TZupWdP3Ftz75PeW9o
         ORrVPgJHWPNNqCQ0lHikN8oo8AesJgHZVHXX8Z9vS0sDlaE9mJTTEZ9tTu0mhdxQprQw
         f9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767858198; x=1768462998;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d/g14TFJQ7VmqaQ1kVvMbu2ZGWLJwEHqwIJaEzJRbk=;
        b=qnnVe13lvxrHGvXi6UGubd12Fiz9RaWPqQZ+L/8XHhRekomDa+dZ94Z8oo2SxPxAji
         gW+AiV1fXs+5vMaqBLO7zd9Ufyk4Y4G8dkeHfXAavWK5GP9o+EX76l8k9YFjXUakN9bw
         /E2GEaxqgdIr+kWMT6YdRDZ/MaanF7cfd3zM3yyGxwIPmCqGkGUrV/z2e77fvBATBhoa
         2b8OGL2mKHRflbV/XvRXQMM1SQOS9FcLdvIDGLUfh2bZxahRx/9N3dz80FEacvcR81A2
         l1sSd2kx73l/EoM9DvV6R7o56zar5Y0oKje8gJChPFO6xFCWY0qRw3xuthOV/FSpfNQx
         23zQ==
X-Gm-Message-State: AOJu0YwawjCaZ24xhL0XSf0z3OF1J/iKaiZGEdygEkcGmQtlOSqxUBr2
	+JoroHQpa4XNS/6l1VSkKZBfVmQJojeBo02UY8Yzk/frrkdvb3Bnln6gopvag8EA
X-Gm-Gg: AY/fxX4G6r+H0TbFYWsdSNbQ/e5v7ibZs6oyg1XdeQKBhw+/O2CFJQmKmdR2+F1NB8x
	She/6w4RXG3T4YgJ4M9gkDLfcKf59tkrVhyUNgvwSH8zYiVfjQ36H9hNs5HNelRdnti1TTamaX0
	4Nsg6Ln3+FTYdORBegUlXPzToO2Ap4xIED2PgTRyETsMO+w4/YO/UWOi9942ktDNnMHB3OsYALm
	N+5TtcM8EGH8AmL8RgCU7M2y97Ybo1/YBxxm5PK7H4j+dApQ5sVU5mAD7SbFoS/ZiwWAtKCMlIn
	3mh4NuXLZO46ctDcbxA4hYEVFyUwaw4S8MHKJGfJXRITiYcK8yQP+uDWQOAtDRQ18DL99kC9gZF
	KEpAi9JQkdZFe8ku3yZkNNkUmNu45CcFPJlxtCRACVfZMoQvZFtEnNmg186LhyAqGTtM7uuHdrT
	IDc0brltsRJZHYSMM=
X-Google-Smtp-Source: AGHT+IFWZoxhfNEqJbb4wt7w5cWGGAyAD4Z9J2bQ+6xe6W8lRZyGtCmnCLGU7jZI8MPB2U660uXs9w==
X-Received: by 2002:a05:6214:268d:b0:768:f173:a0a1 with SMTP id 6a1803df08f44-8908423577bmr81783406d6.42.1767858197803;
        Wed, 07 Jan 2026 23:43:17 -0800 (PST)
Received: from [172.17.0.2] ([172.214.44.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907723469fsm54706776d6.37.2026.01.07.23.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 23:43:17 -0800 (PST)
Message-ID: <695f6015.050a0220.5b0e3.fa4f@mx.google.com>
Date: Wed, 07 Jan 2026 23:43:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0578832475829540801=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: [v2] Bluetooth:btusb:MT7922:Add VID/PID 0e8d/e0d8
In-Reply-To: <20260108070656.2769061-1-ot_zhangchao.zhang@mediatek.com>
References: <20260108070656.2769061-1-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0578832475829540801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1039713

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      25.65 seconds
CheckAllWarning               PASS      28.02 seconds
CheckSparse                   PASS      31.57 seconds
BuildKernel32                 PASS      25.24 seconds
TestRunnerSetup               PASS      558.08 seconds
TestRunner_l2cap-tester       FAIL      29.00 seconds
TestRunner_iso-tester         PASS      82.70 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      127.36 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.21 seconds
TestRunner_ioctl-tester       PASS      10.14 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.47 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PENDING   0.49 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.122 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Set Flags 4 (RL is full)                Failed       0.218 seconds
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
Mesh - Send cancel - 1                               Timed out    1.805 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0578832475829540801==--
