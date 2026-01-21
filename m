Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A032E72B
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768976023; cv=none; b=PGvKIca0Sc9UnRnNHJb1lO4XZtX8N9Q/2Me2KIYGL546f7b0pOv3IKu4dTpl2Z1yQ9Ok+dc2mgzoNOhRv7RFMAQZrXIH+Y3GoJTkWeaWD4p5z1u5Vco8JBYAjZtwogQOAajx+5FpC4jjPIBIvzyXYAmP6cdKqF7gnCMdemrBhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768976023; c=relaxed/simple;
	bh=IOW214fcMiyMkqOqn0v1ag7+mm/dQ85Qf3H/zp2orCg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NC8OG1FNC6ZEoSv3f7GHIIhJDsKPWSGbxNt7Dp2MylBzmi1KOsbrtl49HJYzm/Zo8h/bdv4ev2O7zQYZGRoejLSCE8L4KUW8iPb4uuCPc2L16XDdXKKwVlY6Kx2zm2TZaiuJifn3Mg6rte96VgOLet+ZmkruGfOXB1q+r69iEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOWgPtgu; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOWgPtgu"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-894770e34afso745056d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 22:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768976016; x=1769580816; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bwU7xd8QlCzI/tESBhWa6PsNmZfuDPrlyxpUIZ4XduY=;
        b=LOWgPtguQVUKjdffd+bbVya6rfa2uem3SG0rHTPDnA3nZrQ9FnfEt/rTSBpnXSNSNn
         sA0BwTJbvUSPz1FTGFqH13thVJ9Mz1m1iIB/0AQUZM8BMR3ub7KVtxjRHy9l2JvFF2CG
         6wLeC4ZLQrncxMouJUhgSwK/S2XICgYrHGeyYm544KabMLsXMTkL9nu/PDy5dplFmNYa
         j0GyN1McIB+jt0WMQBxViLiSXpIYDwrjrTLwGshnY8aet+bFhh936lihhs78kbd300iN
         7/dK4bCqaySrFSqgEfjsx37LzomvrL2yUOjdtuIodoYL4X7p313j/cKa1wQc1mfV2YZS
         GtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768976016; x=1769580816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwU7xd8QlCzI/tESBhWa6PsNmZfuDPrlyxpUIZ4XduY=;
        b=uv28duBRVDkgXzfHreCTGucuszPP3XwRpCyrvdG+3xpOXiNGoGsfxXCzua6e1T/vN2
         8Q7AXTJOIaLQguhxu7Vdnqksj624p4h6Bymj7nQ6mbkOem0KWL7ESv20Uye2xskAuPtB
         W7B1sViy+0VtHQOdC0ZRp3pM50pI+Z8PazWEsQi/mQ1KVZjqRWx1f9JORuoQOpedaH6f
         /iMnliwpQbY8nVOLO30c6v8qiHMot/07kFWb1Y7TiFmUoUiu9gFrFxHe4yASpvJ0gffx
         LrK7L/EJA52an1CAJ9jRuwgXF1Z5HL8RYOgqWbapKq32D8+vxyhw6iWovcRmLh0FTHcO
         khtg==
X-Gm-Message-State: AOJu0YxZD3gNkY+h/t37EBrF+bILig8dcRg05x+QRXGSpXSFzFybMt2n
	1pJby/9Lw+RslOyzApVHXuy0tIq7UBe//x1vxvAKWQv2Y8f1l0c6n/MwJJFzCz60
X-Gm-Gg: AZuq6aJ8qQ/NJtLnn5NLJCKfpFzOz1V5b2vHl+ovExDZ496Qeee8+na0TsC9dBzq0Yl
	Bv0COB+tIa63PUueOCVkwjZCbz5di94fNZfIwSzGxf/3czoqRyoO+X7TEUNmSzaatZRV+c6sw8U
	OZcEe57LgSzRyKZ9svaXJMwUqJTpVrSSBN7OblcnpXxOTXTl33CemQWGGgrDkONirjryRQYlL3q
	+3rftMuu33BJdQEAeOHeyhX55gUNob5hG3xOVjUHqFvTytuaVFvP95i+AGreDv9ypqMvU0GyTsH
	tWDYIMSvV1Psa/2BS3OCZQ2cNWTvnDpiA+DLBVTUd0iox5FhmhitumqwGCO1kyKbEo/hxS9X8sm
	xK5xA4KZR88peI9riUPmMb4D4ItEDYuV0iagP8IR4mdA7cw70aVAeW/UaHJidzNdvZ3RCCSHiuB
	uWt+6Kq+8goDlBNORkSXU=
X-Received: by 2002:ad4:594b:0:b0:880:5a06:3a64 with SMTP id 6a1803df08f44-89463eb19f1mr61810206d6.66.1768976016158;
        Tue, 20 Jan 2026 22:13:36 -0800 (PST)
Received: from [172.17.0.2] ([172.208.127.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c9b83sm119780456d6.46.2026.01.20.22.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 22:13:35 -0800 (PST)
Message-ID: <69706e8f.d40a0220.3a37e8.9e55@mx.google.com>
Date: Tue, 20 Jan 2026 22:13:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3309008211078417135=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jianpeng.chang.cn@windriver.com
Subject: RE: Bluetooth: MGMT: Fix memory leak in set_ssp_complete
In-Reply-To: <20260121052926.3539017-1-jianpeng.chang.cn@windriver.com>
References: <20260121052926.3539017-1-jianpeng.chang.cn@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3309008211078417135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044966

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      26.82 seconds
CheckAllWarning               PASS      28.97 seconds
CheckSparse                   PASS      31.82 seconds
BuildKernel32                 PASS      25.55 seconds
TestRunnerSetup               PASS      553.55 seconds
TestRunner_l2cap-tester       PASS      28.87 seconds
TestRunner_iso-tester         PASS      87.97 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      115.12 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         FAIL      14.64 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      11.50 seconds
TestRunner_smp-tester         PASS      8.66 seconds
TestRunner_userchan-tester    PASS      6.67 seconds
IncrementalBuild              PENDING   0.94 seconds

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
Read Exp Feature - Success                           Failed       0.104 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.162 seconds
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
Mesh - Send cancel - 1                               Timed out    1.785 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3309008211078417135==--
