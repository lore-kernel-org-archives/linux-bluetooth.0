Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5C322DD0
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385011; cv=none; b=rFj9AsAzbrOt88RtLvoM/7tB6z88iGt98i0+hnCs0wbvrq8QMFatETMZQJsNnYDAnS8V4k8yVuWsSLrOdsOXZhiiUnG9qbReBaDy2uTjcDbhKQnhYembtRYAw4jNohhp3cMjihCOzQMyHq6IxihIEnGMVnyValCBgSAXpw6pFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385011; c=relaxed/simple;
	bh=jpmkYVN/bd9MhymtDJbl9eABgzZ7024X6k9I2xdApsE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oacU/l5ryCd2ko34TTx+ixW6drxu5oeSFeY6HtfB1Opyd2jBdhjUvhaXbe6fOW1PBtfaVAu7OUxLoQYMQ2xfOB4/dDh+5GOOI4OUFvFITl/ysQclfEDe9khFKcWmvtsjCLwUEQXz+awmOXpVYk29OOpxACnVj84xMAJMDJqAKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP0q/V8l; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP0q/V8l"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so163846d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 08:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765385007; x=1765989807; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vwcn8dSdE5WhCXDnj9FA2bUgALOVBqWZJPGea3Hbnu8=;
        b=dP0q/V8llAWUkpzuyTVFoGZnJ8D1t94KlAMDEet9Eqj9C9jpVar13N+Vi4Nc2IJzCw
         CClk8jso2LBuAznrs+AiukaceibY84C41BTKHPfm27LIH6JhVgBFYE0MEQWXAruEKJzY
         hFbt0dInHRMBlHfq1cXQv8yznXbHQWk6fxML52TinTvDKh1clrV4vMdOycsaYbH9WbYw
         ViX8yeRzCb0iPECNlUvBFdFSv/mSuEFQOh7ADCgOUHv3ZfFiLkbfFmqEGu2kvXEEUmTP
         2sgoaK39OybeEfL0dHBN++ShrwpKaIew9V6Y5ldd6yctl2zcVw9evUwUDQrUJR77Rro1
         iAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765385007; x=1765989807;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwcn8dSdE5WhCXDnj9FA2bUgALOVBqWZJPGea3Hbnu8=;
        b=F6Fww1St6rdr6SA0xnEI01/pmmC0EtPoYxWN3IIl47nBd37uxIphaxRXWLRes+uKyj
         nCLRNWxdE6fNf5+9TNoLie4q+KBwnTBK7PA9iMbfTSNxcr3uZF30WDhF4kVf7w6KvZG4
         jHNzQQSuAocq6+p5k5KWMaTYFx4xb8HmuR85yw8mdufNQOqPdblrjC1BldxXHtwlTkh5
         y5pkJRYfRXAXRa8IyY5VLjfA/XGHz7BToKIG7b3WPFktmtFv4pGM0toSlWkSuA4Pc5bi
         FNVy8iPm4Dna8C8L7X6w/bUDIfuHDqI76qfU5Hehn/6WcbtSqg1vTS1evDVyO7v3nm5D
         ng5A==
X-Gm-Message-State: AOJu0YyvYORnS0TaJ4Ki2BbxAoYe255fjGwD3UzH7uMqmHDCuJ/c5du9
	E5p4YNKonrE1e/CmYjRrDKPyY+LqM2/crR5Q0gEpICSv4gsyO/lOhPoWujDeUg==
X-Gm-Gg: AY/fxX7D9cXxS/I/cqq0/bxxM2WTHff0/weGkwurLyBefIcalsd6+TE3FBS5JogDSNA
	F7WLBimfs1l4IlICh/u3onTokmNSsTWOmFNa9y3qViuPnDa07U0LiiuRF9O/iIFaMa3wzDE20kj
	qB2lVPIJHC3dQD5Hu6B0q6hiEp4t67FGAakoD1DaEV0s3tU5hTElsYRTjkg1TBs/Caeu3q1t9bT
	9Ebt92WJuoCbVt4J9nZwTYGAS0zGlyEEgTT5wVwylnGMQBdqwvsGn8EGZy10OVFZOuUt2U6gQWQ
	TkeBRaldwwymDaok2AJSpF6ITcwqokV4NjZfldKE5vbnvJO4GNXvoYw2Mo8c8R62ByEwsxOa4fz
	ZSj7egkcNXHHwtbt7o+gPPoqjN2Mp4yYkp7rifCorW6WgNqmDvlUTR7b9KtlaMQbvemARpbUY1Z
	glZsN+vIuBvHH4s5rA0w==
X-Google-Smtp-Source: AGHT+IF7VYtc+4SSk7sUtuTFBFL47rA2o/AI7T9KY5h3h4TBPYQfEZzE7tpg5MLiVbDBxzvbBPvXmA==
X-Received: by 2002:a05:6214:c4f:b0:880:5279:98e9 with SMTP id 6a1803df08f44-88863ace61emr42310866d6.40.1765385007233;
        Wed, 10 Dec 2025 08:43:27 -0800 (PST)
Received: from [172.17.0.2] ([64.236.140.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886ec57d3asm1143396d6.23.2025.12.10.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:43:26 -0800 (PST)
Message-ID: <6939a32e.0c0a0220.10bc18.0741@mx.google.com>
Date: Wed, 10 Dec 2025 08:43:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4760393274967815017=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rpthibeault@gmail.com
Subject: RE: Bluetooth: btusb: revert use of devm_kzalloc in btusb
In-Reply-To: <20251210160228.29074-2-rpthibeault@gmail.com>
References: <20251210160228.29074-2-rpthibeault@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4760393274967815017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032047

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.24 seconds
CheckAllWarning               PASS      25.56 seconds
CheckSparse                   PASS      29.18 seconds
BuildKernel32                 PASS      23.11 seconds
TestRunnerSetup               PASS      514.56 seconds
TestRunner_l2cap-tester       PASS      25.17 seconds
TestRunner_iso-tester         PASS      65.92 seconds
TestRunner_bnep-tester        PASS      6.02 seconds
TestRunner_mgmt-tester        FAIL      112.82 seconds
TestRunner_rfcomm-tester      PASS      8.91 seconds
TestRunner_sco-tester         FAIL      13.64 seconds
TestRunner_ioctl-tester       PASS      9.32 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.10 seconds
TestRunner_userchan-tester    PASS      6.06 seconds
IncrementalBuild              PENDING   0.67 seconds

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
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.170 seconds
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
Mesh - Send cancel - 1                               Timed out    2.318 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4760393274967815017==--
