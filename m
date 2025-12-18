Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67896273D73
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088622; cv=none; b=htO4lSB4EGJKET9LRARv83mZfhPrtFXBkGVH3Sijffo3Sn8O4qZ8jjmSqLQRdFla2Fg+3ZGiG59oYiwDvtVaZRUmhbzASKHdCbwWLyEC5TcZvZIiAVt1r55qUK39aE/NJOkUb24MFqk1MXJUDrGnSCGukZnwvLo3scW/ZBKQApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088622; c=relaxed/simple;
	bh=mFjyVsDsdGdfyVxGLXpVeJqu+dmFg8zsTXBaTQ7cVtw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PGiTodIH2mVY+bCIxFsl/akjQ+8H4w5ZSWUeZ+R9k6nV1ehsR0eeOJr/bn1uP/JWhgJZUvqYBvdAO3d4TSSobQQesLBpfUnUJgegbsMzMrVpExpW3HNwMLh5GVprRdUzLY1rdBmhJVC80Y+8jM/60ji6/Cku4MpdKN5++fBO9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYlJ4ehr; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYlJ4ehr"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so865344b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 12:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766088620; x=1766693420; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nGTkN6zOQgL9HTP23/HX3GCxwJeHTeJszIF2NRnlAZY=;
        b=CYlJ4ehrq3iq6Bn8zqQypp9O0Gz9MU0Gim971RUtSBMNko+FZ8X0twliDKqjjKKA3c
         fbnGMuFffpuMD8qgw3gtGjXbUjhD3T+kesGeT5BkimLarzys2CV8Nb2jt4nppPhtyCWI
         VW+y7CseINEZtyfXd6xsksHJhg/CA9XvYvkyrg6Q4Rh62APxzWOQu9i0txqS1htbdCYc
         tnJnJ+U1HKb0vk6dNZS9PbwAmxVGit/Q/w/TUy/rlly8NzcoU3wXFWWRjTr+AhfwS8pr
         W83QpbD9L5rmf3AYM7od+9zYN/45i2c7amcXQxF9Rx+iqUNAFMV/pu61uHgdKe63rvev
         snTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766088620; x=1766693420;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGTkN6zOQgL9HTP23/HX3GCxwJeHTeJszIF2NRnlAZY=;
        b=StOykfOJbxXXyOIoYHvwfCY5ZkTc/5L+9061JBg9WE82w5m6TjhiB6vb0ZK2qJvWV5
         qcjBgHfchzIhY6AqzqbSNJOmeTErhztNRYYVcP53vmX13wLxY0DtTHnxUkdSIviqadHJ
         iiqIaZ7lfComAyk7gBLS6pX7vqfrr1pmHUZZq4RwdAGUeCao8yJllyNK8tPfmEijdJNc
         EAqazmCEPF7TuWZqMH97UJ3Op90z+99OzhxUOqwruubIcBik6xz68EN2cuoXAg3HLO8C
         b3DS9GzZ0fkuEQZ8PAiiYYd5B7U9qtNaVMrqjh1WytTQe2mNOmg9CzY3p7HlzgnkAhGY
         enSw==
X-Gm-Message-State: AOJu0YwBhN6V2N93VKNv++GUntEkm7z3Lo4Fp/RkFh9B8i4SC5bVA/pG
	jxX11W0ZWkOtw14nSXtMJRZ87ehhD7OlNIHRP+i772dPAiCV6xReT5ulJei0adok
X-Gm-Gg: AY/fxX6gjIZ3vVfula1EH5vdo6Z4/tLsBzsq1yXVa4EO4XvQ7QXp4iMMRbUMOatlXdw
	/QP7Sj3vceTWdEcRmf3DkGZE7C5a8tVGV/KmoRfcXcLahx5F6iirJ411OrlHY1OMr6tuOFTnBfB
	YbDSORz6vIcUW7a9GNE8Gf6PIEzu5uNfH/cUFHHvggB1T4Suk9q8nL8L3mmr7ilLn+0oT6zE0ow
	8bA27A0KUZtbAmZRXt4WaAfLt+v6YukZ2LTeCGYqOrpGGtT1qxdoCX0hrejJaEX7h5C3Xu6Itrs
	4S0/3/GVly9sitTZCGQNPJTtkbYpNvVxeNh0HTr2tBlu2HgS6R637wCiX50E7iRFrHMzaCaHqum
	lNdPwgjZ65LVYJ43ds0986B6Im0NzOkEL+GTt/C3tdVrmtw9VVwB8wnqqAUGxIENwasjKlSQKxv
	i0dQI4nVnZc4A+rsz8mg==
X-Google-Smtp-Source: AGHT+IERf+weMIN2i78mSBkqPBfs23QQxppq9hCG4UKJMSVvJ4k7JpK8ExtJgm0WUUb6iY/uQE5TUw==
X-Received: by 2002:a05:7022:6988:b0:119:e56b:98a4 with SMTP id a92af1059eb24-121722b71f2mr643601c88.11.1766088620068;
        Thu, 18 Dec 2025 12:10:20 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm869672c88.1.2025.12.18.12.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 12:10:19 -0800 (PST)
Message-ID: <69445fab.050a0220.336b33.a8e8@mx.google.com>
Date: Thu, 18 Dec 2025 12:10:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1163263960172270886=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Add support for setting BT_PHY
In-Reply-To: <20251218192159.624935-1-luiz.dentz@gmail.com>
References: <20251218192159.624935-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1163263960172270886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1034736

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      26.24 seconds
CheckAllWarning               PASS      28.93 seconds
CheckSparse                   WARNING   32.43 seconds
BuildKernel32                 PASS      25.24 seconds
TestRunnerSetup               PASS      565.72 seconds
TestRunner_l2cap-tester       PASS      26.22 seconds
TestRunner_iso-tester         FAIL      49.21 seconds
TestRunner_bnep-tester        PASS      6.45 seconds
TestRunner_mgmt-tester        FAIL      127.81 seconds
TestRunner_rfcomm-tester      PASS      9.77 seconds
TestRunner_sco-tester         FAIL      15.04 seconds
TestRunner_ioctl-tester       PASS      10.54 seconds
TestRunner_mesh-tester        FAIL      12.69 seconds
TestRunner_smp-tester         PASS      8.92 seconds
TestRunner_userchan-tester    PASS      7.00 seconds
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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.654 seconds
Mesh - Send cancel - 2                               Timed out    2.001 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1163263960172270886==--
