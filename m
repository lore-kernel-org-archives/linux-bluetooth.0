Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938B2914
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102282; cv=none; b=S0U2a0taX7270xXpril83blZNFiOcl3DTx4YcqLXgySWgXdbefo2Wlx6p6WIE6ug/wQG5Kxxkh2Pgox2lDqxYq/9LMBqp9HwF8WFTcZaYV4Gfis7txjf2UnvdjPz9ldvHZTAjUUoPT/uZborB/187J+s09rIle3cqGGs+yoHLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102282; c=relaxed/simple;
	bh=se8LqxbQNh9HxOX1XbncRy2aKLE93K/TnjdPo+6li1U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M620OXF3vxOPruQG4b2m1eR5r3hAJUJFIgsQDQ35y2jxSlbwZ/SlqIvt/RJXmaIsceNa2wW7skSG3ZLq1QQI9HcSsfIg5M3ukryxmScdqJdtW/7edz/uGt9u8XT7NE9LbL8aNHyzOqgj0fMq1+pMkRRIPoLS+4tbUlSKOBoTUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl71DpWF; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl71DpWF"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47664364628so14482791cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743102280; x=1743707080; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qVOYLi4Dj2ixvZCyIxzSfcKlEE3J48k92VYtlIwQDM4=;
        b=Jl71DpWF5VHg5kQa0WrKdMURytVNHFY4bYzOOG1hoTT6QK6YS/8YPp++m9voqCpZgc
         mcnUjP5yP8R2pUJ/lX67evVALu3RMGc19eT/ClbmaPvHU4x8P+LNfZhWExY63q5dfuO9
         cCesQXXc8LdadqYWxGjpYv4uijaktrzIzuQS2TamGvgXBRuX7BRzvoM5kiHG/V63UKnL
         m64VRP7ca1pI1EtDsLbQoYHzXhbXQRKze02GDN+ww5rY95QJXNNvHlG4By9JlwL1lu/C
         HO06uoG+o6bjr1kwRwGkfg8D/TRm7UtpxXebk0/pMh2GATjBb6Uze4Hl+B5iun6+l7LY
         R1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743102280; x=1743707080;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVOYLi4Dj2ixvZCyIxzSfcKlEE3J48k92VYtlIwQDM4=;
        b=lPAQlPGIVhJx2quDxmJkTD3iLHht62HosP9qfKfCjHHlnjeTbyNYB/MM1EyyEH05B3
         Exx+ae+cknyttiOXEt/T8YLRQacFNc97qa1bAwrrmjiYfhgGYeIaSON8MzPmajzFC/sI
         nvts/tDAHo/PS3oIWRuEhkAMv0vcjHoucfagEyn43pUzinEALXpD5fSq8ZKa1+89Vdby
         BqSYzgrgtLL17AYEeFX6bEeex7Qz0W9vZYekgwIDox5RuzwuBbAYv3uGSPZCw8UJId5U
         jUg6MGnYm+37pPs2Hbdcie6x1sMA9CGgJuclcAoc6bEYIOZ64WXvtNo688KrbNKYtgQh
         Tnaw==
X-Gm-Message-State: AOJu0YxpAMYpODdDC9nLxfh/viCyc2drWk3bZnyKi3mSf4qULIX5NLJw
	vr4ArSyNtjKL6sLr/XUGfUMO5EXiUhHha0JN+XTYeKEylp3jRWmn9I9teQ==
X-Gm-Gg: ASbGncvoVKLHq9W9NRk0W16zxi6HomwI81pJrrSQlyvyfJ5upg4qecXuk1JynvGZQ7a
	KQUhUsYrNs5T12kggOI1A8JZKwaFGK0Xlm5G/qMFqaFfLcQkVV9CutNzPg30s9dTselT8o75G13
	wGmIOBOC0JwtWtNtdWz76IS4U50XMVlXkdXnl6WZURXWR7Dt8rczXjj1pr+SsCGJor/Fjs4IZcG
	84k7XrwOvo+/wt58PtcT+aGGPpZpkIp+VUuLf6mEncbgRdDPP4OwJvbywMoWKEOoNwQsKHQPQbq
	+Leou8lPwajhRdAhIkcl/on3BMDRrwGOVJWJQvG6LjN592BPv+w=
X-Google-Smtp-Source: AGHT+IHZrsJYwquDUyyKWUqXn7WToWd1T6KU+c4TuMhKtuJ6mrU3CeSPIDyqVqIsDdJ8LsWE04NJQg==
X-Received: by 2002:a05:622a:53cb:b0:471:fef5:ee84 with SMTP id d75a77b69052e-4777f77f3e2mr22567701cf.7.1743102278394;
        Thu, 27 Mar 2025 12:04:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.79.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47782a0ffbesm1293791cf.6.2025.03.27.12.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:04:37 -0700 (PDT)
Message-ID: <67e5a145.c80a0220.326112.17dd@mx.google.com>
Date: Thu, 27 Mar 2025 12:04:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0210230104583938207=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1,1/2] Bluetooth: btnxpuart: Add msleep() after changing the baudrate
In-Reply-To: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
References: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0210230104583938207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947856

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.22 seconds
BuildKernel                   PASS      24.08 seconds
CheckAllWarning               PASS      26.46 seconds
CheckSparse                   PASS      30.51 seconds
BuildKernel32                 PASS      23.99 seconds
TestRunnerSetup               PASS      426.74 seconds
TestRunner_l2cap-tester       PASS      21.02 seconds
TestRunner_iso-tester         PASS      32.10 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      118.29 seconds
TestRunner_rfcomm-tester      PASS      7.81 seconds
TestRunner_sco-tester         PASS      12.50 seconds
TestRunner_ioctl-tester       PASS      8.26 seconds
TestRunner_mesh-tester        PASS      5.91 seconds
TestRunner_smp-tester         PASS      7.18 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PENDING   0.63 seconds

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
Total: 490, Passed: 483 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.130 seconds
LL Privacy - Set Flags 2 (Enable RL)                 Failed       0.139 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.159 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0210230104583938207==--
