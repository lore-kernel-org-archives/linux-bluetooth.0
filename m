Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D792500C9
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318493; cv=none; b=XgKKG8BzgvjYh3xWiRETizxaV2VxL/cKHNViTEYYA1eStHPePdU8lNsZD9wNIxtJlDsaJ2Pmrt9g9BYZCy0nN/lDC3UNqXKwUaSObJeh0pgQzdUWJ8fkoqCzkYZE443lAUAVvOjNSIvhw6GxDWYm/YzqGb7V7sacG7d58NQiyfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318493; c=relaxed/simple;
	bh=YUSXQOG7OvnWxYeS57xmAzYK5CcwYrgMP5KKsnLpPdg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MFB0+vZPHYYuQdg/n2zd6hIZ9KbKjSCJeViFRda8UD9QOJRYL2qEavFfHTnOuLpTfAfUGN7P5kRRrCGZ6TdbcZMCXqIajZ2lotnmnVKG03NJteZQTOgGICVVW4GZNlQqW1wWyHQKtoEKj8ZE/Jl0cy4MsuN815n0oX3ODePPRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGbcRQPu; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGbcRQPu"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4668cec51afso54336021cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733318490; x=1733923290; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Yh28G5OTnHxwSniLzrza0pf8yMaZckkJQWRmKdIhlg=;
        b=IGbcRQPu8xXOfesfRgPa4aMgm4syNzyNZTNJv5vE0ko0vYzgzeQjZBxdufqDSaQWHI
         9X8mHYUKWp2Ze2pt47ueIyPLaqMMz2hfETnCq/+YITgbzwTes5flGbS6H4lXBquQnUUB
         HtuTN1eTDSEeenDPJMJiB7NNzch+Btf/fsHgsSLAlYFAtPK2d7zTIHm1Dj1faKm0fb6o
         XGn79yelm19HkTF5J8eGgh0G3ruI1kMWX15P6PGjGr0eKDAD7ynAwqzF7hGe37NEeax9
         9isrt3LexO7PPKL8vAG4VKe7ZIvnIkcOpaG5zZid46IEB3mi/gOO8a+6bAdxzqsuxy8F
         I3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318490; x=1733923290;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Yh28G5OTnHxwSniLzrza0pf8yMaZckkJQWRmKdIhlg=;
        b=Ld+iXhGsXfk7ZZPliYR2TyY/CP54A8asNO7Jif3zGEoH7n4HcHFTJ+loRQ4nkprlTX
         4iyt/VtlFZiEaQQsyB27HDeqWdKpJghuUe39X3DzUYOkxOPNrzKH/aMonjaxYI/5or1g
         J3CG4jsJOrTsH6gCfYoHY8oC/26dwSoynudTbNivtD9wk7mKko3GkpAMynsLMOxxO9zN
         v8g9R1rulfSy9u7XQQ6obdPhixYCef/zcYeB5tQQxRiHIw9ZKj726ABOxImrTxKOhYeD
         W/Z8jYUO7MYAc9Nu8wXukzp8U/D11zxpy/6VKNXpQkGEgvfYevQqig8cJo0PsX80fehm
         HajA==
X-Gm-Message-State: AOJu0Yz9lIY9k0hil6PtQYrKYsBPAAaD69nWO+PKVcMngX5IvfUGLT9+
	uNdjsfoM0kneweSP9WxUtR7AdmWiuTJbc4cknOK62AfgZOnN6a+TvEFY5A==
X-Gm-Gg: ASbGncvct36G52RtNf+P3DK0hrqeQNsL+j+tRRq+k5TIZKp38au8viuMHHp5eNquzJf
	X9HCDif8h6/hP75JFjzNhNTwSqX11feQ+dqoRkP4FyTae8u4HIQ1qKJgQSOfAEbts8Zu9UsE82p
	MNkWQ8s6L3VaxUNCQi01BugN97fzXiPLVVQD0a4CYuG/r7v+gC8m6Qi0ixpc+Q4HumBTZmv0/+j
	XOhhhG0JB4Kv1czq/DIRrJJ+ATubFtgA+vQSNXp5padOJzhe5tdwniywtM=
X-Google-Smtp-Source: AGHT+IE+VOGuQIn31kwbK4L9esvy08Vki0jYbWW+DUyh7WnnTwSgzt8IENohiEX2aiCRPzukZ4RvPw==
X-Received: by 2002:a05:622a:528e:b0:467:1f35:629b with SMTP id d75a77b69052e-4671f35709dmr14767501cf.15.1733318490339;
        Wed, 04 Dec 2024 05:21:30 -0800 (PST)
Received: from [172.17.0.2] ([172.183.147.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466d7f29f7bsm59752921cf.31.2024.12.04.05.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 05:21:29 -0800 (PST)
Message-ID: <67505759.c80a0220.34a073.3513@mx.google.com>
Date: Wed, 04 Dec 2024 05:21:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0509094987100894571=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: iso: Fix warnings
In-Reply-To: <20241204122849.9000-2-iulia.tanasescu@nxp.com>
References: <20241204122849.9000-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0509094987100894571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=914536

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      25.32 seconds
CheckAllWarning               PASS      27.56 seconds
CheckSparse                   PASS      30.86 seconds
BuildKernel32                 PASS      24.37 seconds
TestRunnerSetup               PASS      439.51 seconds
TestRunner_l2cap-tester       PASS      20.67 seconds
TestRunner_iso-tester         FAIL      35.49 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        FAIL      119.58 seconds
TestRunner_rfcomm-tester      PASS      7.58 seconds
TestRunner_sco-tester         PASS      9.45 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      6.09 seconds
TestRunner_smp-tester         PASS      7.06 seconds
TestRunner_userchan-tester    PASS      5.03 seconds
IncrementalBuild              PENDING   0.47 seconds

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
Total: 125, Passed: 120 (96.0%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.242 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 486 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.186 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.147 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0509094987100894571==--
