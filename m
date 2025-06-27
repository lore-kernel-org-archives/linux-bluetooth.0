Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B68BEC
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750994744; cv=none; b=fvOHHKY30Mlh4seIQ7W3co7M1f/H8ge1I9bZyrtM8gy5Cm0PPsC5WSqyss2E6UGKoAZr9w2SkqjguQFZkPPuUKoHbM6fgWZL+6U8lr/Z/nwdvx0d+56k3cLFbxIxyOGuWi56jiToiPDhNLPxOYjcVh2Qig4RHaLknCQDK29y1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750994744; c=relaxed/simple;
	bh=tk30Sc035liUwPBOPLAIzhCoBT6mhnSDJq5pDWCUwfw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qcd24GAbQwuyJE1JAuljAL1C1uF8xcJQIZBHbAtXEUEIN4O80JL8CgwWPud1pvJArq0Rje3NoFM75BHnhjQ6l45VTnjPqR057eUK2CXXeNf6emQ5zL+sbL/3bIt4V+/4MxhYcz2voIIdB2bMyqcZNk019tEomkHo1gj83s9xe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5EHUe90; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5EHUe90"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6119b103132so1139715eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750994742; x=1751599542; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k08mQAXRGZtZpX4OHnPfu8aYI1eQ5e9mPN0G/ZJ2lE0=;
        b=W5EHUe90CmhwEPVuSZwPji5OYJ7BKZiYtCTKmUagBVGf2D+zv5N4DTpWbU/EXSQHnp
         JHa7DoVrt8uUbXTpfm0kH8l2pV6CbauZwTgdWMI/nFDYh0/CeZz/JCWEISHN3gDnGOlu
         sbXE8UnOT1gmkOetE3ty3HXmSiiQfpCv5BnTjZyrHgaVICDLxjij9IBCCga3c8VsZvzD
         GsAEz8yezAcw3/p/I9Y51qizWdZWzXmlW0g3mSrt5uu+A4wkTHAi1po1FnKIzNfOoOLX
         QKHRbIgGEgvRvP91s6YQbubOPyoXzDYtwG2vL4PJB0teGiWGv/o4Bv0T/tyR6ja/rKjv
         3zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750994742; x=1751599542;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k08mQAXRGZtZpX4OHnPfu8aYI1eQ5e9mPN0G/ZJ2lE0=;
        b=gNTlGfJGRqlb60T3UshChin5prArjk9EdKAPwnra0nrMzbQumpa8uJAMle+cF2738a
         wktkRBi/dbY0i8bGISKVQ/8odyLcmVqLkQqSNLfIlSFGDUzhjiRoSMtn/h/W1WtZv4FZ
         de9A4qzPWTGPgmJXGg2Dq5M/7zAV/wov9pnVAbN0US7RUU+ninIzH+VOO2IwTZE7tKYe
         JeG6UUcmooYjDqLtr7E+gZqk2Al9rgymtCIBNe6l8XHAhRLZf1xOFM6GK3uda6Y4KRkq
         Y1RDuL1hVOqPx0BEUxN8HYqz3v9ef9N1abXCfrDBgK5c4fSF+MiRol+P1OojxBhs5ecU
         cHBA==
X-Gm-Message-State: AOJu0Ywbrx/g1n4shamcNskiPqYt4S0RzbqLX3e04n2BXmNgTw1l1hQC
	fhzihTJgkL7xgy12JfPTmi/sn/SRp/KVVjI10tdVvi8YUagkcoFMnuh/VZzQgA==
X-Gm-Gg: ASbGncsmSE2yYFUcaySWOSWI2L4lOeHfM3AkJmJSQQ1d462tmeJbdSt9ATdKS7EYK01
	3wNl6Dt0q50VC/GVj81VnrZyQmNGSi9by28bFh/VkMMH4nL57URIVainQDNG3pTMLz64sBAhgOc
	/iBht+StC1d4i4ZkNKBObTN3kOCdTOalwLd0u/Bq9mXGrl8UH2rwaPdllRAPi7VglNeIKs8PfSn
	U1NmET/ZTblsAeHeJxFTTyk6OU/iWMNLqLOEmhUYMH3O7BxmdZPAikD5bPiAqpYzYWJT3cApR78
	p+n/fpmGoWg5vC5ze58DAWuphjOECHiiD0tMnU8bHfMPycwrJubWSi+LJZ9RpFT5daMd
X-Google-Smtp-Source: AGHT+IHRB714pijwxC8Zt/afDkTP3nJf1r4xlHjc6taXZI4FBvnFXB4yLHhmKaL8xGcJ7E4jvdjcaQ==
X-Received: by 2002:a05:6820:2d43:b0:611:ae2b:4d24 with SMTP id 006d021491bc7-611b95cddbamr1016881eaf.0.1750994741949;
        Thu, 26 Jun 2025 20:25:41 -0700 (PDT)
Received: from [172.17.0.2] ([23.98.189.159])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b848d77fsm148338eaf.14.2025.06.26.20.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 20:25:41 -0700 (PDT)
Message-ID: <685e0f35.050a0220.318443.18f7@mx.google.com>
Date: Thu, 26 Jun 2025 20:25:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7965705329672677674=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_shuaz@quicinc.com
Subject: RE: [v1] net: bluetooth: add callback to exe l2cap when read_security uncompleted
In-Reply-To: <20250627030229.1720287-1-quic_shuaz@quicinc.com>
References: <20250627030229.1720287-1-quic_shuaz@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7965705329672677674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976441

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      26.35 seconds
CheckAllWarning               PASS      27.48 seconds
CheckSparse                   WARNING   32.98 seconds
BuildKernel32                 PASS      26.31 seconds
TestRunnerSetup               PASS      480.84 seconds
TestRunner_l2cap-tester       PASS      26.40 seconds
TestRunner_iso-tester         PASS      38.17 seconds
TestRunner_bnep-tester        PASS      6.42 seconds
TestRunner_mgmt-tester        PASS      139.41 seconds
TestRunner_rfcomm-tester      PASS      10.14 seconds
TestRunner_sco-tester         PASS      15.76 seconds
TestRunner_ioctl-tester       PASS      11.29 seconds
TestRunner_mesh-tester        FAIL      12.82 seconds
TestRunner_smp-tester         PASS      9.39 seconds
TestRunner_userchan-tester    PASS      6.94 seconds
IncrementalBuild              PENDING   0.61 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.772 seconds
Mesh - Send cancel - 2                               Timed out    2.004 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7965705329672677674==--
