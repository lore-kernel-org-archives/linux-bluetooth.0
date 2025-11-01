Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A8145355
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018349; cv=none; b=kFi135aMXT7L2+irJk1F8duYDS/HQ4RATZ81EMPM5dnOQWM6Co6XLMXgn5V8siUlK5COR60Y9aIrqY9MOEIS5mlLeQb8YpZseVvzNOM7qgtv+bcoPObfU6/TZAxsc/ALXptoJA3h8IlieXtlBVL/c6Ygb7QlyyLdPdEEciCQAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018349; c=relaxed/simple;
	bh=U3b0r6Rm9zZsfhiIB3QpPcPE07VGLKmCAexCGSIsIC0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A1QEiI/8dX1Tp9sdLVwtO0jIJy4jqrxk4TmTtj8YldJqRccpb9jUT+FFaL0mQYFd/wq4cVBZFu2cSnk2JFIxdgr8c0N8/u37/EN/VzNYGDBGJhRoq20WcaokMIqHJCRUZNcJzu2b7L69F8jvuBLFuVguGGQ3dqjlG5Lck1zco2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfJxujzs; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfJxujzs"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-9483ece8d4aso10134139f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Nov 2025 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762018347; x=1762623147; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IUzlwL2tYY76FVbly2xV/zsH7yDOwYQg606ZIe8YYvY=;
        b=mfJxujzsK6PgkoOKGyNQV1K2sjqpeMFUy8b8lU2ZQl8r2Kb4VJ8VieHNhqY0or6zfd
         lrNI3GDZuHjypZ4kuX1AAdL+0fou6Tk96QnNTwKQ6SZeaUHgdwIU6gkEkck1EhqfBsdB
         13608jTPYDPL6vLiaoZPgIP928qbeZBKznaJwqzxb6ReSzKlQV8G7kKh0drSDVYgn6qg
         dLhipTWRxNeFOTwQKibsQVYl0H1iXkL3ZUZLqSchrlh1HhcA9L7DzQaSf0eS98Ax5jc9
         ebJS253+5MtHDYOHKfX8UyGngP1g+j7kK303GDILMAiwObYK4wAOBzJf4OV6imiLeYck
         GLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762018347; x=1762623147;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUzlwL2tYY76FVbly2xV/zsH7yDOwYQg606ZIe8YYvY=;
        b=fVjNSLYVQwvu/fgGmA/DKX/ogBNn6EDFzkKdXricH1XrN9Pxj20q4ZBFW6Mh285ytz
         fu326z7q4jI6zWYLV9NF9QzqCmUdY16DHFlVb5f/0K+Dc6mxzB4DmxTY3VUYwZ+noE61
         RVp/XI4h3FxptLURIC2oOVbKe4PELjx1ihxpYUlJjYlCNkhlD7+lm3lS9uyvt8PbSmcl
         vInC414pJkx7YQEqlzZfJ8re9ZqJ1s1VUWG77fMusFuBC852WfcidMV8wY3edUNK8Ms+
         ddacn20JT//yX0NpBdPRlX3JAXl6jlSa/Gc4aAKOj4gYv/YqISaQ9YNBU9VQ4o385mZz
         ehWQ==
X-Gm-Message-State: AOJu0YyvvUqaO/MVQUiQv1W4cMCYoZXCHV2KdhIpK5YAzH7wJdhBfO1N
	ZAD5pChXHj4zlFKXNs00ExcWctyVL3wSR0M0Rgyws/H5tIlrR0tIeHOPCwU1gw==
X-Gm-Gg: ASbGncvhR+/nE5TT0EOBACH0Az/jegEv9XNKV/B9PGXDXTfxSMXzfHO2xjlDlZYKMuf
	WyKsdMnUTbs7U9dqBaPvnVThy3muuJO6aU18D2O+UBd9wTk0qPQ3dID/8oWF9hBUOse9yEG88Wb
	L5CQ5SBW/ucwP+sKP3n2rk6mL68xS52LDN+c9HvzezPiRBhtP02VDCQqrfjrLLDdSm7lqAb92zI
	STRZ60weKrjfkz+525ebeIWL2X+wvbsVADitD7sqz3RDqCU9bc50NCLNs33HincEWUullrv84Hu
	0hlqopek+eUbFXTeLekyTOwEKho2A28iu2K8NND0z1pWrNYCDlERWes6G5l8lMUbk9Ea3qPYUQR
	C5zQ5Tn7YNJUXO7YRuaWXTmcw7L+7mbxcyigZ+uRtZwgVhlhC592CQSvwodKkHmCRnKRBefXNBK
	CrBBdDAUU=
X-Google-Smtp-Source: AGHT+IGtaYTEYdbwncmztdHw1si+vHJlNwd+O3p97rF5ahlTBNKRhx6WePzW5RexZXk//ZZ5YB3j2g==
X-Received: by 2002:a05:6e02:16cd:b0:433:246d:283f with SMTP id e9e14a558f8ab-433246d293bmr22622675ab.17.1762018347058;
        Sat, 01 Nov 2025 10:32:27 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.142.228])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b6a5a980f8sm1902824173.49.2025.11.01.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 10:32:26 -0700 (PDT)
Message-ID: <6906442a.050a0220.292b81.2ea1@mx.google.com>
Date: Sat, 01 Nov 2025 10:32:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8053055033951377551=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@163.com
Subject: RE: [v4] Bluetooth: sco: Serialize state check in sco_sock_connect to fix UAF
In-Reply-To: <20251101170110.179111-1-zzzccc427@163.com>
References: <20251101170110.179111-1-zzzccc427@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8053055033951377551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018547

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.61 seconds
CheckAllWarning               PASS      27.29 seconds
CheckSparse                   WARNING   30.75 seconds
BuildKernel32                 PASS      24.60 seconds
TestRunnerSetup               PASS      494.91 seconds
TestRunner_l2cap-tester       PASS      23.51 seconds
TestRunner_iso-tester         PASS      75.97 seconds
TestRunner_bnep-tester        PASS      6.21 seconds
TestRunner_mgmt-tester        FAIL      110.68 seconds
TestRunner_rfcomm-tester      PASS      9.16 seconds
TestRunner_sco-tester         PASS      14.97 seconds
TestRunner_ioctl-tester       PASS      9.98 seconds
TestRunner_mesh-tester        FAIL      11.56 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      6.51 seconds
IncrementalBuild              PENDING   0.52 seconds

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
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:153:35: warning: array of flexible structures
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.090 seconds
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.154 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.190 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.072 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8053055033951377551==--
