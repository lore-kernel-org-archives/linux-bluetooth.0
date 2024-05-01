Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FB211C
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588526; cv=none; b=AcoaKYCGWMZm/uOZMBgvvkHLW42sJRL0uTKR1j3MjBfugdzms1BwbTCftmNuw7sIMJfQPDUxx17+CZ16HgstSkbJ8MZjrlx9NiTmFGHLg3cXDAvxH39TYdJcmHUvjDicZWBrzItB3QUzMsaUqkz5JSJ8f1VVxZKuJsWWkHEVyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588526; c=relaxed/simple;
	bh=FeXaiGe7u+e5gkRNAKNt14iJ3+7ddOZcd6zKWolnoVE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pj5kuHXzU7weBy/KnXb1KDgKs9eIS06kNxh9JUhbKZFJtZXxad4kc87Zx6ijRt2FMia3q2zqgnH43xoEEw6ZQ94L0gljE0s4YWX5sgkxMjxSuIHMbw5mBD13f5PL+HGuJcTV1saqjT/inyc6YtIALrFM5g3LYdx7rV2ZCOLQTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IssoPEJ4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IssoPEJ4"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-790605809cbso624419185a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714588523; x=1715193323; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Koa6z+lEGl1G/g/mTlpOd7H0BwHEHUqudkG9USEhw=;
        b=IssoPEJ4q99qWTWmiAKoMSdv6zQb7pfEuzeZujhWktO1JUTH7Hd3cAmgcgUFv3nMD5
         SMLcoo5ohLLGKjIWzj/W/V/s+mMnCxeLa+UBAVLbr+GkteZSKlhErDKJiLl4TLzTAm+L
         ZjMuY5xPfrA2D/4yHTRyN8GULfXjZDgLlE/dugUCFyewNU12EfXuGKaMtYI1ZHfqWfUX
         b/F470RehRaplLTC3OYb2eoKAK+EqPEWA34b1MLRgCgVozZ4d4VoUaPZLj2lVhxXzmWc
         sdW1SzJISNLUOWVFk3UovGNcbdxK9KBhpKySig3cIPUVgJXHrePyVTOqWdx8OS/m3MBi
         yIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714588523; x=1715193323;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9Koa6z+lEGl1G/g/mTlpOd7H0BwHEHUqudkG9USEhw=;
        b=n61VqxiJ5jzuDnfH/sO+Iq1n2mAA0/7QMBffzBJ/WWltoVdXjjNhM2CEbqNHrPbw1L
         jzK/92i1WwJ1pb0Ri+jfwuECY9OfN79gB++niyDgu2EyhJujr0SXW6pkMQOpnaDu0RXA
         H4LxqUzjyFF2+QhIQqF1jhSwNkylVQP6taDCeG7HWuAzltMMg4QgVyAp2vseNiRiFl0F
         cyI/ieZRAneCq2cuv200w6b2krc6FbhcftM6qXU9sh2eszKJ6GnQ/sydeph0muLMLUc8
         y03OzhLAkr13X0XSm4DqVWdWjX0iT34OTbxmO9SJhtsjft4gpDNlcVVz5fjR3jdoyOBg
         JHog==
X-Gm-Message-State: AOJu0YzkiyK+9dROlcYhbun/KLN22Wcyo8dNjXhvUxTqGLAvPSLKVAnu
	NqmtKasQv/sBSj3+p7BqPsSzAQJn725qC5h7wSCwH4pHWottjCz19s6hZA==
X-Google-Smtp-Source: AGHT+IHWgzYZLGCeoC+4pCaIbXxuej6nADcz+xJ0yp0AZ/9Og2XNgN64YWpxn/dA1agndicWxoVh0Q==
X-Received: by 2002:a05:620a:3b93:b0:790:98f8:955e with SMTP id ye19-20020a05620a3b9300b0079098f8955emr3420045qkn.30.1714588523457;
        Wed, 01 May 2024 11:35:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.37.3])
        by smtp.gmail.com with ESMTPSA id u10-20020ae9c00a000000b007909ec6a8cbsm5884244qkk.74.2024.05.01.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 11:35:23 -0700 (PDT)
Message-ID: <66328b6b.e90a0220.85ed0.c569@mx.google.com>
Date: Wed, 01 May 2024 11:35:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3103135378171611256=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gustavoars@kernel.org
Subject: RE: [next] Bluetooth: hci_sync: Use cmd->num_cis instead of magic number
In-Reply-To: <ZjKAyg2bZNyTcT+C@neat>
References: <ZjKAyg2bZNyTcT+C@neat>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3103135378171611256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849713

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.68 seconds
CheckAllWarning               PASS      33.46 seconds
CheckSparse                   PASS      38.84 seconds
CheckSmatch                   FAIL      34.88 seconds
BuildKernel32                 PASS      29.17 seconds
TestRunnerSetup               PASS      520.92 seconds
TestRunner_l2cap-tester       PASS      18.37 seconds
TestRunner_iso-tester         FAIL      31.48 seconds
TestRunner_bnep-tester        PASS      4.75 seconds
TestRunner_mgmt-tester        PASS      113.41 seconds
TestRunner_rfcomm-tester      PASS      7.35 seconds
TestRunner_sco-tester         PASS      15.06 seconds
TestRunner_ioctl-tester       PASS      7.95 seconds
TestRunner_mesh-tester        PASS      5.95 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PASS      29.55 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 121 (99.2%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.184 seconds


---
Regards,
Linux Bluetooth


--===============3103135378171611256==--
