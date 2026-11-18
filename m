Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996432;
	b=oVMAUxy/LkwZvxYddyIEqpxQsJniyDJOtJrsiKygHDjnw5npxojcix5Hi1dYiuJPBBtB
	 qOVCyvr4KZi1w1olD9BgbltyyyAvyL56tgIQUZzmwbz9FydSwhO00I8EKp5m0lpSLKv1J
	 1Tc44uuvN7JXcmyujqrDprCgjmCILPeo6U9+s5td8hjaVp+Ff/5TBSif7dE5m54u4Fq5a
	 5XNzkh0xwD8xjn1+fIgxPRW9U7zA9WI/EwrA8kEG35wZd/nrM15jdLl9hBTJLyz3oCGdD
	 /vZAjavsAiBvDA5yOUTi7tgrHW+ryF9Q5+cRHJrPysCZxBla1co0odf84/Mv+sCr9EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Mglvr2MIGV6QFMOsXciiC798qRc010QbVK918Upfw3A=;
	b=feVdaka6gXQ/6gd+URajK2x2z1ckGB07BvTyoqYdkcY5yZZPryYzNu3ra8WClleDTjk3
	 Vo/ib6Ur0sU4xdCKayrNzBpaJNvRyVdH2lctRYU/OuqM5YKYvWjwOGHn8OM3lB/17bhIp
	 zwyorza3bUv9lWkp3NZmruMHjbjP2KDiCW0d7WOu5VcI6H4Eubu1AqtEK9nMf5nBVqMlX
	 qNJ0Rb6X5PDpuHBhY5AiVMnYihD8Z7+bqQ2LrH+zW0OP7oB4hK8wA5UuwhulZDza8IH+B
	 Gn6Rx+77kxPdObjOy/gMJPoe7EjxJnlS+UubRTSTsmSpQCL6p4RBhiA0oOm1lQh79sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgylOUj8;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF67606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 10:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF67606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgylOUj8
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a3c08d6928so1184442c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 02:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996431; x=1795601231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mglvr2MIGV6QFMOsXciiC798qRc010QbVK918Upfw3A=;
        b=hgylOUj8SSOJiFtvQP4iM2xuZxTVZiaowkR6fYw9B+7xzrzGdUOyGmo7AIoVS5C1+X
         TnB7IhvwEAJj3+AZeU2yASRZKBdIdGdGJCZvHUHbnzfkdD7MppcI697pYaZaSJkqMUOq
         4EctXNVOVQqi8H5v+VDcJ/pvveiUmYT1SZc2e58YNu+gQ1TKb9udjFAOP9uPeDw0P4EA
         UinGvwy1Y/uFw71Ta7F5lstj9mHMsQ+CGMpGOY+l0sZY9ExjRe3z1pXG/eMnLMMg0Xnm
         11r5V+mAhZ5LBHfWMvX+U41G4kD2mdE6Bar0ZOjolCoiCLrUi9oq64JOleccJY76A32W
         36KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996431; x=1795601231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mglvr2MIGV6QFMOsXciiC798qRc010QbVK918Upfw3A=;
        b=aB8SPiggHcSvqC4+jHfstqzE7HeaxQAoWK8+47BTqe2zZrOEosUo0jJ7qnm0/6xfE8
         rDJyS+XziAvnwjHcxIWTVIF37VoNrh9xFP3+62A/VVL14TXTCSxeX4X6nHVWieD9MJvW
         GLRtkZPhmuYQEPOLMVTNomYy6gF5IJo2ctPpN36qNEUWZEVdB2QtJzjbCgmQo9xos0yw
         ctoWl765pw9I27bqElAabCLexUsVn4x9bNK6Eyju5iVyy8IkBRWxmI8OpckrscG4KSrB
         WVW4+MnuWZcLNIuQ0PPwMXY4OVo8fy0RAErl2cUrJ3zHhlcbnfxjAnK0/3kICEkqOmxW
         sNUQ==
X-Gm-Message-State: APuU4Z9DBIPRoznWh6YR5no06INIcZptORLfYdIqeSh8gYkCiuhFEMQ/
	LenRIwd2TEsZReuZnNRc2ElqiHu8xNUvK9Am87P6vpg3rtph/bQUWyU8CWx7iw==
X-Gm-Gg: AYBFou2mWJ/04m1hP460pthUxq8D4JVCDh61hSEuDJjNNyi2eRimDww0dbKtvfrndKx
	d3L2X1ofKgUVSyWdJbSaSYdU1gLP9odgeiJJHPIau7tIlbRePTa1Vnz/iMir4fvXrtu0atmjfyB
	l5CbTjGF/CKJCC1WAR9yJssv6bsTZ++9KrO5H9rnNbzuK3tlQcNtgd35oU0Oo0ixE3VBL0/A3ey
	aTkP3ziB9F4uQGhZYsAB0gCb3DaYwjgP5fhqWrL+RU8XGetILm/kfAD+r1ZJDAytB27En8P0+pV
	2s1j/xX4nkkH8kM9IuvJbbb+J2N/ldY3oWsq+EQfMHr86suZ5O9Roeal6PNJqk23kyGOUGx/+5t
	azHUY4gpw0H7cB1Sl7X8jDH2GPneZeswTIAjURurJuZ1U0GcfPpBJnSuqw1jC50LvLXwlinDyqZ
	BF3MxD0W+J3IksDcrZZMQXovCdIalJPaZudbCZ/QgGpltCCbkAkPIeAFKajVNmy/nG+Fg9qEehD
	fdDORGkH6L1PqAg4rKIm8i2rcxBSkHZfzagbMBD3e8iGrQOZmzUchj8Oj6CKMqs1Ox51shVu2R8
	X1SK11c0
X-Received: by 2002:a05:7022:ea46:20b0:15e:9126:c60f with SMTP id a92af1059eb24-1b543cf2943mr2307936c88.29.1794996431459;
        Wed, 18 Nov 2026 02:07:11 -0800 (PST)
Received: from [172.17.0.2] ([68.220.56.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c1193sm5333489c88.7.2026.11.18.02.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:07:11 -0800 (PST)
Message-ID: <6afd78cf.bdce4de1.73551.5c01@mx.google.com>
Date: Wed, 18 Nov 2026 02:07:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2377838707314415472=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: SMP: Serialize root channel updates
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v11-900043ed2303656c76fe-1@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v11-900043ed2303656c76fe-1@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2377838707314415472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1214536/

---Test result---

Test Summary:
CheckPatch                    FAIL      3.40 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      31.22 seconds
CheckAllWarning               PASS      35.87 seconds
CheckSparse                   PASS      38.39 seconds
BuildKernel32                 PASS      30.97 seconds
CheckKernelLLVM               PASS      34.86 seconds
TestRunnerSetup               PASS      754.06 seconds
TestRunner_l2cap-tester       PASS      14.77 seconds
TestRunner_iso-tester         PASS      13.28 seconds
TestRunner_bnep-tester        PASS      3.14 seconds
TestRunner_mgmt-tester        PASS      87.96 seconds
TestRunner_rfcomm-tester      PASS      4.46 seconds
TestRunner_sco-tester         PASS      5.63 seconds
TestRunner_ioctl-tester       PASS      4.66 seconds
TestRunner_mesh-tester        PASS      5.55 seconds
TestRunner_smp-tester         PASS      4.35 seconds
TestRunner_userchan-tester    PASS      3.22 seconds
TestRunner_6lowpan-tester     PASS      4.40 seconds
IncrementalBuild              PASS      40.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/4] Bluetooth: SMP: Publish root channels after initialization
WARNING: Non-standard signature: Assisted-by:
#149: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#149: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14995467.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,2/4] Bluetooth: SMP: Serialize forced BR/EDR channel changes
WARNING: Non-standard signature: Assisted-by:
#225: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#225: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14995468.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,3/4] Bluetooth: hci_core: Hold the request lock for the power-on update
WARNING: Non-standard signature: Assisted-by:
#158: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#158: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14995469.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v4,4/4] Bluetooth: SMP: Serialize root channel replacement
WARNING: Non-standard signature: Assisted-by:
#323: 
Assisted-by: LLM

ERROR: Unrecognized email address: 'LLM'
#323: 
Assisted-by: LLM

total: 1 errors, 1 warnings, 0 checks, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14995470.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1147

---
Regards,
Linux Bluetooth


--===============2377838707314415472==--
