Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE87329E40
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831359; cv=none; b=dvnD8wvaACadyi+uVxkOToOUeJCpirgX6mZC4H7zuLHYZgatynb1vr9ZLcSYcNxv/W4KixTgwgeTXWN9iSH50r1m18mzmZjcVaJYv0e4v8b8sXOwErHEahN0feuDP2n7wvx/nbovVP/acfozTd2YUtogfJn1k+OiAcAxp41kDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831359; c=relaxed/simple;
	bh=vWMl7x9IFjyWlOxOHYRhZlbiD/RENraiohB+C3QRW88=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=W9M2I4Y8xLUGIPgbeMlj894IDVW5YX0QvdY54jGcmzX6ydWw8hYigpUORQoLSvoVzb/q0VsDlRbx28lO9mNtqCaxYmx56jpB4Z+8tbsMPuy+EsJ9PVQmIfvjYCmrAgiEDPcKqyS4gpOXZrd8A9vpzRoVxwzJrAWj/WvkNcYRghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui8A3CiK; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui8A3CiK"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4267846eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768831357; x=1769436157; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xUfGH/w5plO2xufRqymq/495aY/LPgQtB1bZt0FJs8A=;
        b=Ui8A3CiKIrR2qzDdRAiansfpC4mccdfETAY9cSm2VNiLFefCHfUcaybryIgrLHkOnu
         DGBeUWji6ecY03CDJS+Od8JYDjiay/y9aItJr2BeVwT5VHHJ/EFU5uKrRhknklSX6r+l
         JVW4bs0tCaFkgkG6voyuAVoxBeyNldf5IOwFz8AsfRoiNnOehRf6d5uShwG0DvNkrd3u
         DfbDJiDAUIOEHW3Dy2bRecnLJ8ZYy/nVAK9Dt69cypElEM78e0QlsDJy9DxrxJQ9AOJR
         lCXa3bJNSinZrDleb43KONYF9iIPJVytraBmz1m5SI8ZRXehWu39XXVotJvGkJgvoaE2
         EkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831357; x=1769436157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUfGH/w5plO2xufRqymq/495aY/LPgQtB1bZt0FJs8A=;
        b=I4GYzyx28VZZkdB9USkGLik/HXcmVkZART+go7DMNkupG6chTFU4KcmN6fm/F7F72q
         yQC+9BGuVKWrkqhu7KsSkGKP4pKgAQo46nHxE4qR85kz+mQlnSl39iqxTbosw2JpYMXp
         2GsqM+KgIIhB5P7eOF3oqpErH0S9NpU49C3hYumXYwjFyUoIS9WH/7AQIM8dcoU/0tMZ
         RzB5Q0iPCbXHdZ72akUybEQj4ohx2ta5IpCXK9xEAvdFHagaIRjUmSCEA8Nn1+iFsYV4
         GbAGbu6waceKi5tgI9YnTUh65rZtISdcyzaIh7NqBvVvAzjRtnE6QXcKfctVHTPSVRak
         6APg==
X-Gm-Message-State: AOJu0YwScT20zp4BEqkpeEXOqdoaYi335nmXChKCQ5Af9MeIuKTHQD+4
	u7CaOU3d+Jp00ouFZY3bTTzuCsl2YUoguEGDpD6Bm7ft+SuEc+hc9dsosHsoLJTegjI=
X-Gm-Gg: AZuq6aI350dyipjfcAhRROiLUqeoHC5/jBRsAbV1cJoVE+K1JGKOpoIoql3hc8v+Txb
	kHGB7OsANfmSoENR7XMoH8rsWYzGEJYrC3U1dG3Fml5imuRj+RbH80naFF1VZZGHf4Y8RwdEppT
	2lzINGgb6rsa5isqV8Or8TOs135lIXzMB8FH1II9L14aXu8tEqREALzjzFFeB/YvFBUAC1D1qN6
	t0594buot/N9kzXzj50F+hFlYfRy6C8HdwSh9GseLhv6i03uLb/ASyaCcQ+meWB/8DvkNlU+CLq
	OOb3FrFezfTP3LC0tAGg6BYyqeCbvIQDgmTA3Xmevmuq7QhoNatzpvK7QpkTsW5mofafZCe8Z52
	mkJYIAy+pHziDbWnG9a4r7g5n1L0ODSvBLphKUpfkfFNGnpYvd97LGodEbstehFdtsQxRrqQ8ZK
	2w9gkbEr81dkynyDGx
X-Received: by 2002:a05:7301:e06:b0:2b0:5342:e00a with SMTP id 5a478bee46e88-2b6b3f2a334mr7012937eec.15.1768831356410;
        Mon, 19 Jan 2026 06:02:36 -0800 (PST)
Received: from [172.17.0.2] ([20.169.77.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a7bsm12718666eec.19.2026.01.19.06.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:02:35 -0800 (PST)
Message-ID: <696e397b.050a0220.2a909d.c51b@mx.google.com>
Date: Mon, 19 Jan 2026 06:02:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4697897591166673757=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: More CONFIG_PM* simplifications
In-Reply-To: <20260119123537.2611794-2-hadess@hadess.net>
References: <20260119123537.2611794-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4697897591166673757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1044140

---Test result---

Test Summary:
CheckPatch                    PENDING   0.48 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      23.61 seconds
CheckAllWarning               PASS      26.42 seconds
CheckSparse                   PASS      28.89 seconds
BuildKernel32                 PASS      23.45 seconds
TestRunnerSetup               PASS      515.78 seconds
TestRunner_l2cap-tester       PASS      28.67 seconds
TestRunner_iso-tester         FAIL      58.89 seconds
TestRunner_bnep-tester        PASS      6.37 seconds
TestRunner_mgmt-tester        FAIL      124.26 seconds
TestRunner_rfcomm-tester      PASS      9.53 seconds
TestRunner_sco-tester         FAIL      14.63 seconds
TestRunner_ioctl-tester       PASS      10.34 seconds
TestRunner_mesh-tester        FAIL      12.49 seconds
TestRunner_smp-tester         PASS      8.81 seconds
TestRunner_userchan-tester    PASS      6.83 seconds
IncrementalBuild              PENDING   0.71 seconds

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
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.108 seconds
LL Privacy - Remove Device 3 (Disable RL)            Failed       0.204 seconds
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
Mesh - Send cancel - 1                               Timed out    2.711 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4697897591166673757==--
