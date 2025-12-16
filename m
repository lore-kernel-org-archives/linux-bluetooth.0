Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00E2D131D
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879753; cv=none; b=qGlaNVh9OuPXFOWs5UPAYhncdBF+shm31q/xg+JA7phAdfADFrX8uRMBpBrs9mHL0cSyTn+4uLWUtkcnldCKNlSppF1ZwHCnvrND3B/4dNVeC0DQcDQ9yQ9QtkHvJHPkBzktUbj66/3tN83ZKJQKxhicjA4VjpTi5X0WjDHLNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879753; c=relaxed/simple;
	bh=ZwXNpu05gaat6S7m+IgN6sjf2U7rzctnLfl783/blnM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mVAjf6tSThAWC8/3rtGW4gdV9w0Roojy4cR1qAOj3Ghe4Iq8CcQe0fvQPiRO2/2359q4ZHv+4R4AaVCGmgTJh5Adt8e66pLqdRV5ABQKiK8QgRJ+zgBdwywF2KXdFMe2jqH8ccCoxGdS/y0e8BAHcH3IqX8qZbgJGlSLMJ/toKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9tkNo0g; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9tkNo0g"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8888a444300so31848666d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 02:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765879751; x=1766484551; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gjvbv62IGrehrPekqlkGLd61TQ2OotJDzORErQpkx4Q=;
        b=V9tkNo0g6lE8RD717ZrzwtllepLeGzyLVDpL5L+M3HxbZc/g6I40cGeTBRi5LKc6Y9
         hbs5qbczrd3SB73X3Y/5eh83KzBuDfiptCESGDx4781ecyTYWD1aVnjMBA+xNBz8sMU+
         SeTw5R2Th5i0QiA0fgQSazc5v8rN5jZhAZWdqOvnmVWAvvDD3/N+LUW8dUaNSA1z/gPL
         aafiTu0jxKpQCgAxj0EyUmzVmsO3EpxeadSbUphnkC1Gbe66W5d0rdJOGFStMLfPAljB
         NtBc9kwi2wIsqcCfktY45kcynYotopC/KFi+ydjWummpU6KvxtDU2H9T5U85+1aB3vdZ
         gljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765879751; x=1766484551;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjvbv62IGrehrPekqlkGLd61TQ2OotJDzORErQpkx4Q=;
        b=BDvRncoM8zdM/dqyyQepchKmfFlHB9GGs4WNnr/3s1QJ1ZstjlHyzpMbwO3HA/FDiq
         BR3PEPiwIoynDJQg5fLmLZqv89+bhxaa8xds6jxw1WTy/GPR1u+Mal3Va+YiV3JN4S2P
         +8JMIL/kQQVZHJPJCeQrYh33ltWbwRXqlvRXxTIfAvPePXUaiN/7d76Nm7DkRyypsIJS
         w0/L+KQ0n5GejMNF/ZhEWMyHv7D5OkcGIqw1zQ4qjbIH7JnDtlpwpXnIwOYsp1JdKQ0X
         Fl/4KpO+/s4h4w7+vqEQ5TPH7USfw/A0jIIJhz9hLt3ohb8KHPPnfLk8wsIkJDtnT9LG
         SPrQ==
X-Gm-Message-State: AOJu0YzjHTfd6/D20V5I1jWE/T/tRS8u8ugqWgNkhPL3Pu1u38GuHPsx
	IU8U+MdVsP4GXkokBcHam7ZSQkQFKFK/0bCa+hGdVlAXkUuIhwwNFgxU8uQiLhlB
X-Gm-Gg: AY/fxX4WdtMULbziStFVnHeq5tvyfGX7y3Ozdgma/5+Cz3yLmNUgGivj3mJ5a43QmXD
	KEHgl6qLreCMR+EFAXcwKcAnCXRGR7nohOfWQWnczBvqtgNfNixVAGsLEIMEC1ekIdFwaUR5G3S
	39FXxClJ4+06UQNsSdG1KuF4DDFmCoggKMQyWLgF2OppqXlaj8yELe2BP5AecGnGdpt/pXyWGKn
	c9wN8DfwY0ktVBtZC9eBVoS/KWSLYRvMrH2qFouyOoRbL3PI2TKH8eKWmUZRcfYmNG0w6EIEm2A
	Vgkz7Gw5BxBTkvLZ0ylU9sgew/xqizVM+eu3mscFsA/0aM/Fsi3Nq/UgY/yd08G4fInydc0QhTa
	SCX0a/SkNZ8yR5cx3ElWARGGcO8145b0NuPl2Plm26ZS1SyFFvQ7hQxHjCZBcpJZrBWI4SJ4Eh6
	/dyNurLVeq0iSDXx+RaQ==
X-Google-Smtp-Source: AGHT+IG3/fI+8xDRzRIjV+/QP6bIDf/mfGYZw9h9ycYmScF0cDlkTP0aNetsJr1J+c2f8uIwMWTB7g==
X-Received: by 2002:a05:622a:5c13:b0:4f1:cd55:d9af with SMTP id d75a77b69052e-4f1d05a92f9mr177589691cf.47.1765879750645;
        Tue, 16 Dec 2025 02:09:10 -0800 (PST)
Received: from [172.17.0.2] ([135.119.235.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c2e5f7sm11810031cf.20.2025.12.16.02.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 02:09:10 -0800 (PST)
Message-ID: <69412fc6.050a0220.25ca59.2046@mx.google.com>
Date: Tue, 16 Dec 2025 02:09:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9176614046153309734=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ssorensen@roku.com
Subject: RE: Bluetooth: Fixes for BR/EDR connection idle timeout configuration
In-Reply-To: <20251216092011.111208-2-ssorensen@roku.com>
References: <20251216092011.111208-2-ssorensen@roku.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9176614046153309734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1033698

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      25.25 seconds
CheckAllWarning               PASS      27.92 seconds
CheckSparse                   WARNING   31.32 seconds
BuildKernel32                 PASS      25.31 seconds
TestRunnerSetup               PASS      551.71 seconds
TestRunner_l2cap-tester       PASS      25.41 seconds
TestRunner_iso-tester         PASS      80.01 seconds
TestRunner_bnep-tester        PASS      6.24 seconds
TestRunner_mgmt-tester        FAIL      115.42 seconds
TestRunner_rfcomm-tester      PASS      9.40 seconds
TestRunner_sco-tester         FAIL      14.50 seconds
TestRunner_ioctl-tester       PASS      10.44 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         PASS      8.57 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PENDING   0.79 seconds

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
net/bluetooth/mgmt_config.c:127:17: warning: incorrect type in initializer (different base types)net/bluetooth/mgmt_config.c:127:17:    expected restricted __le16 [usertype] typenet/bluetooth/mgmt_config.c:127:17:    got restricted __le32 [usertype]
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 488 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.153 seconds
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
Mesh - Send cancel - 1                               Timed out    1.850 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9176614046153309734==--
