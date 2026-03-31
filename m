Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B780366056
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970535; cv=none; b=esGLduV/ZnV9naygpgwF/OcmX+aPSI6itcMWV5roXq+JNJrM55st7BVW59AnTSUCff0GeT5aXFi08lZ+VsM1RSeQy1XHkQaj4Axd50fZ9sU4J7O+84kFthKiC0qwMEEW8ddWKaU4kxLdMz8YjCz5ek7XykOc3QjwtX7MKA4lgtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970535; c=relaxed/simple;
	bh=/b98vm13wy0tClgyIhP2n7n+joLh/CUVRJMra7EldMM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aQVoyj2SQkwJukzwrpDWrsmHxbzKteIoadV/CFsOM/0iKimiZLGXYN6RNbSDBxzr+EM0VmcCxbWMxWxQyj3DhwEUJmVeJvdmDvNMxT+90dPr4JMFXTOCEkerFB+KWDomulNTmL9wUlujydmzy9uoGaux09kcP0LkA64IDoT8P2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo4geZPo; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo4geZPo"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6501d242e2fso4165184d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774970533; x=1775575333; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J3zdryOLR3krxCvjX5SbPIfqx0nEjcvL99tOL9UURg4=;
        b=Jo4geZPoxgnQO5LsbdrnlZz7a8RMrzIZSPw0LKQ8GC07aXHEO8MzgcjXt7aR7uYvyw
         KUzL0ej79FWiqmpsAq6lhWIhSzKwQDsPVpCxvyuOdnPBy/5ZRZQyDcdoh6iAaToZfRIY
         ZyByL1LsRR5J9EvdfumdTTq2AuPjLsPHxiSvgx//nuP1Xz0eb+hpUVF06MF0imSBQNyp
         WQspnWcrhtej+MODdHqDHGSOsep6U3DCI8QSATLW/H9M75UQUxO2WfCkgKRyATmPyasK
         +S2WUzUHupaVwpghu6nf8yI0AT3KfeBuKcn9hI/osl9OXnAJ11DRBpiXVB7D6TKXBLxI
         SYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970533; x=1775575333;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3zdryOLR3krxCvjX5SbPIfqx0nEjcvL99tOL9UURg4=;
        b=OyjhF9G/QRj/mF+EgtOhzgiiOb1uN4wMOvhRg+4zwDWCs3xBIKpmDrlSC2eIC7bOcv
         q3usY83VVQU/GePmYTO4jXSbx+HjsSbTC0NBIx/CF4hRItmIVb4klAtECHi8qya7p36C
         tMJLl9IIhvXYEvtd9I3uaXUaT7GNxngkUQ5taFaDY1Gkvy/dUSEfesckhUgm9oy3NtI1
         cJ+AYSY1LzJamVaXIt+LERhtuCYiK8tGXiKgapr+0LsFyx6tXXm0mFYQ3KACbDu6koc/
         YXUqNuLPxbwj0tsFVzX0+TRsnj6vCkCSmTDldLQdjptoVAATXuUAtnxgGblyZ2ulD53x
         YvFg==
X-Gm-Message-State: AOJu0YzayKrGfmV0p0jq24xqtDqNjTzDrb0b2XsnVxda2P39qeIe9fKA
	5LoHFjqnso+ThdmH0tTcZYiWh3Rtm3B21NgbGervGdXYWbp5NH0RgVcszhi0PQ==
X-Gm-Gg: ATEYQzx5TI9DV7O0dXAmWqK0hjZ90lTY9pIVcHajZHypV3WJrtA6pf6G9gWbCWB+AFR
	EV5VeM2LkxIKiWeLWWqpIkgdwnHOPg9qHpKSWnNHYyLX+O2xAnDhuLeD77FVlm0dNcdq8kzaVVY
	n0CseevtMK1ydBq8UHZXZqBbyhWQLxlqD3hYSEPTfx7XCyR9nGtHTLv/0pRpQjfxGj9ZILowcPj
	c+ttj+wukvoz82RY1JpwJxz1X1rPAoWdNYoApeLkdoPfl5aMqAXO5fZgKlFLHfnX0Qw9X72f2pC
	RLxsgnwRqnY3H5jsuodmvxH7rIKlAH5sjA5dNj0ykNAqNg5vHCvV0UdOhKqBBRbwhHbbkjNeQPP
	h9Cw+3EoCh3LANYUGXWpgMtIc7+tXxy8mLdaNP7pGNiD2RqI4qNLDy2sssy5i9D6QIiPpdHeIC8
	njgmFC+RZA8EgmWO/jKP8EIYAVpt+/ElWr
X-Received: by 2002:a05:690c:15:b0:79a:bbe0:8cae with SMTP id 00721157ae682-79bddcda1femr172033307b3.1.1774970532730;
        Tue, 31 Mar 2026 08:22:12 -0700 (PDT)
Received: from [172.17.0.2] ([135.237.130.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecfd525b5sm96135346d6.42.2026.03.31.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:22:11 -0700 (PDT)
Message-ID: <69cbe6a3.050a0220.1ef18e.a2fa@mx.google.com>
Date: Tue, 31 Mar 2026 08:22:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0278656848291621760=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hkbinbinbin@gmail.com
Subject: RE: [v2] Bluetooth: hci_event: fix OOB read in hci_le_create_big_complete_evt
In-Reply-To: <20260331141358.3244105-1-hkbinbinbin@gmail.com>
References: <20260331141358.3244105-1-hkbinbinbin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0278656848291621760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075230

---Test result---

Test Summary:
CheckPatch                    PENDING   0.54 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.97 seconds
CheckAllWarning               PASS      29.71 seconds
CheckSparse                   PASS      28.46 seconds
BuildKernel32                 PASS      26.25 seconds
TestRunnerSetup               PASS      580.72 seconds
TestRunner_l2cap-tester       PASS      28.52 seconds
TestRunner_iso-tester         PASS      44.02 seconds
TestRunner_bnep-tester        PASS      6.53 seconds
TestRunner_mgmt-tester        FAIL      115.81 seconds
TestRunner_rfcomm-tester      PASS      9.70 seconds
TestRunner_sco-tester         FAIL      14.98 seconds
TestRunner_ioctl-tester       PASS      10.72 seconds
TestRunner_mesh-tester        FAIL      12.54 seconds
TestRunner_smp-tester         PASS      10.94 seconds
TestRunner_userchan-tester    PASS      6.95 seconds
IncrementalBuild              PENDING   0.75 seconds

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
Read Exp Feature - Success                           Failed       0.113 seconds
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.174 seconds
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
Mesh - Send cancel - 1                               Timed out    2.510 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0278656848291621760==--
