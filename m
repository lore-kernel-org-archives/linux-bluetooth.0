Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C023768
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621467; cv=none; b=EC4QBuug/6BRFUm3Nl3cZMTZYtjamYNh1UySpYnvpegGKNFpeUNfoi4+tljn5cSQQLcun0JYJCQs2Hdj3oa0lHu71BVU0Q1fid8UMWiQ0x7/fMgyDp/saFrAluKygnsgP4jKKHjFW9yJhXiIihogeUR8gnMEHQLgz+J7DTAmRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621467; c=relaxed/simple;
	bh=8wVVfwTZyaNLIi7jCxAZW5KFBZcpIW4Q8ejD9VSW1nE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jgvgt4p4odWGEAkP2ogoTzF1U2osP0ybp+wsLMWOy8N+OTeZ740L+gbcpJw5Fp+9GtAR4ns2b9mdY8xha2vxsViPRwSvjk1vB0ZDuhNiunhXcjwmRiumaqpEs5xwkMyL78jtZvj2IUh/Ai4mRk7pk9IhqF3JPeRcibJ6Cz7TXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQzBzhMv; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQzBzhMv"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-69b730fc89bso15402606d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715621465; x=1716226265; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cyx1ZM+IjEGyEus0VxSJQh5lD7FkG534VfM1Nm3/V/w=;
        b=HQzBzhMvwlan7X1+fy3v1kO4JlmxJVBLqi8o2PJz4448ybcq3KtfOsZJGy9r8X4o+P
         kDS3yIPydTNkeKEM+S3oGQJcCe8VMO96O7/z1yNoytgVxi5tExJX8h0cTRpPBzQX+WSU
         CjwsV3ck9X+sQwOJNq03ikam6iC7usybKEuIME1ISA+iKgUD2YAnOlPqYC6EN/XjxAkj
         WVGVzoQVkf3M1oJtQIIZfCvLTOjEO2moI0VcYBzw2vwPRhzbyTc9RoRNrI54zKQsVYdQ
         73Qn4kuIYt/dXOKD/L+mq2kN8INa2WHeAwVswwSjjmFPy7haT0XwEkH5FGeOUFVWV0sR
         +RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621465; x=1716226265;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyx1ZM+IjEGyEus0VxSJQh5lD7FkG534VfM1Nm3/V/w=;
        b=E8Dae02Vgvg69YYWCWFeo4LMdmVGL27PmBlMVrA0dB5vogvtvkLsr2jTMI7EE5dwSX
         gpztnn96CKRR7tSJUmS1pJrLKWGgNkA9JZlAMpy/hoA9yqxT8ilQ1/nffY9oxd/BzOxR
         ++IqexOsj6nanDZZtIt/bMeHOyexKMfz8N8xH3FSA66GsnvX/y4F9XODH1Yy0gMKDwCs
         R2ns9SDsNBmvZV0ezAyskxb7Ky/LUncq+rJE3KjMiScX9jUhGu+HBEuM26rzdX6cKSTn
         s4Uo48req3Q9IOlAQL2Q28HJyEv4TDu6U2MxTeXVr5Zpq4zXZFOmmV5E3+opoXKU4zVz
         V6zA==
X-Gm-Message-State: AOJu0YzZTWn98uQBiYAfHLV2vpLMQqAms92qOaSRmNo1Zz7TuBUDB88z
	MAnepb/GuYvgoZlG9o2c0P+lONsyQSjRTGUOnNbtAy73EaW1RGeDzU+Cpg==
X-Google-Smtp-Source: AGHT+IFlSHn2X2eFpQO1SI10Rc/qJ7gMqJUKwWSj7kT33AD3bOU1EkMwg4C/clCuHFMrKliSoK9/0A==
X-Received: by 2002:a05:6214:5509:b0:6a0:c6e3:c025 with SMTP id 6a1803df08f44-6a168163e1emr124586426d6.18.1715621464850;
        Mon, 13 May 2024 10:31:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd3desm45350106d6.88.2024.05.13.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:31:04 -0700 (PDT)
Message-ID: <66424e58.d40a0220.360ec.e1da@mx.google.com>
Date: Mon, 13 May 2024 10:31:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6340515130409889104=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tharvey@gateworks.com
Subject: RE: Bluetooth: btsdio: Do not bind to non-removable CYW4373
In-Reply-To: <20240513162200.2658571-1-tharvey@gateworks.com>
References: <20240513162200.2658571-1-tharvey@gateworks.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6340515130409889104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852863

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.79 seconds
CheckAllWarning               PASS      32.82 seconds
CheckSparse                   PASS      38.17 seconds
CheckSmatch                   FAIL      36.10 seconds
BuildKernel32                 PASS      28.81 seconds
TestRunnerSetup               PASS      519.15 seconds
TestRunner_l2cap-tester       PASS      18.47 seconds
TestRunner_iso-tester         FAIL      31.44 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      109.18 seconds
TestRunner_rfcomm-tester      PASS      7.23 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      9.75 seconds
TestRunner_mesh-tester        PASS      5.78 seconds
TestRunner_smp-tester         PASS      6.76 seconds
TestRunner_userchan-tester    PASS      4.85 seconds
IncrementalBuild              PASS      27.91 seconds

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
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
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
ISO Connect2 Suspend - Success                       Failed       4.225 seconds


---
Regards,
Linux Bluetooth


--===============6340515130409889104==--
