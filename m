Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57B25B0BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792581; cv=none; b=YkldD/0ZyMiC/oDVr8v2Kgm00ibwnVZ77e3fWB8i+2K0Y9VhXTUQI103Kq6hbMuhuLEllrgk8mB5YrfoKljMlF7DkKt5w6u+3gkVV75yl2ABeTofjSri9pCs5H0fZXvfa51/uigrFN7QIa8Gksn+a5gIiCk1kLNE6TYhJmZkL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792581; c=relaxed/simple;
	bh=+pKz2zUjLO2w8iuWGHU8RgJyi6kA7RQWO5/iEHRG9MY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jJcgP5wTGivCZu0yA5PwGnlZWlP7qj1KBodbYDrqndYJzltXcO65owB5ENTLs0PsdxbPHF0wi0zCIfSmnU78RlM/rfwIG2K5GxfICmwMc15rDhPUvlpNklHzwC1AzpUCDSFyshHB3sgsEQlQgAHpnGJEnjPmlbnxhRz6jYgGwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HM+pg5Fw; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HM+pg5Fw"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-82380b0f55dso791382a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 01:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792579; x=1792397379; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EifBIl4o3dNfQeLDu8d+Du+eCpPV/cQ/IB1gMLejoK0=;
        b=HM+pg5Fw04glBGi1+IfrcMPZSL+OEBMBKntHK8fZZGQbC8LjHy/n0tthywJUVw07v0
         +70rB3UdPPjw4ef4a02VYLzPPRDnX+oG4cg2giAFOljRTAR3m3M57rCnZvQqySatAxRe
         moeL9zOX00OUt5ii1M3NQtgx0xZMAMYlxJCkz5DrgxfibM65HYZKa7ZcEPhkUihffVOu
         g9R2hUmXzUzgqrGk1YPPmBpCxwUXVzOsZZo7iIFEq1j5+9WgDEBke1JJXWy8IJkOWCxI
         6kLZu0jdInTubbpIOZr4oTa9WpkJBMdaKh+oZzhM1xCtMJBWf2RQu6MJfuNOKW1j6PHQ
         y5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792579; x=1792397379;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EifBIl4o3dNfQeLDu8d+Du+eCpPV/cQ/IB1gMLejoK0=;
        b=HrUvvSw+LQs6CDwAa42NdQR6tZo9AxF+2qgkbNWcA9VEJDKUsXGqchRxoyJ+wz28BO
         t+93TdvT8VX3wf9JXRvY87Ra8iYPuJWSgbv33Ck/2tle6l5FBdvX9t+m3MgZO/ckWJJx
         Hv8bQ2+CRAS+6xEsw0lYGF3iJfAcNjHsrZ0ITOHSWYHaYou4V9EIPMS2lTQ1nh+LmLWf
         G7B2teTM27szbXkbvZ11L/NRyG9fgQP6kGoYVk8pqsB80T9sD7XyXr8Rig7LOqBSsDNf
         8fIlF5CZmsFZYbmbpPvLabTH+5pmy9lh6QbJDB4evToXeFYFW75FZEZEQ/M6Fw26Kj5y
         Ka+A==
X-Gm-Message-State: AFq9FYLhsY38qz2CDOQIsMIsfkgoq9dbUzP1YD8Z84Q5nhtoKBU/ewCW
	7vm3067qrYcTJAQd5qzVi+b71W9z7wPlqT1NG88u1mrVEUY3gWWPmahyF/lwvo5M
X-Gm-Gg: AYBFou3Rck6TDa6YZnGnoawPKqEAYc4c/D1/7KMjyWAWKwwpWcgHNOPwJv1KDYrSk7X
	YhvzFfFlJjIxlbiTe4L8ZItaBsW5aCgXjYiBeBxKtgtoT6/jDpRUz2kXR0NNqHl0F20WL4Oj8pO
	i0ZHwQTlGVAodLItFKNmemtEJ7959b8m/5gMoo55GNDc0Ox3aBUGYBCXdkMtUpdScM3bOd53IQK
	GUigJ88VtsOn83Jjfvbv/zpMSypJdMZR5HwsXNVMQhrjgxBG7pqiEoyPjMcENSxX5s13f7tRZRW
	EfAwo1je200PbiQxtAQYc6QIa897aXLdJk9NLrcJRbS32FvtaxYGKPoKeoKHsxpk4F8gT4TEdpZ
	Ps66EBdt1o3kFVnDQWBONDmIRuauUprMKqo/EwhuA0cz5jIPPHSr0m6EEWuxCImDrkveOWsEInK
	Q9iNSZsMNn95eznPAM4VtoAD0Qio3EyzukCFbypDgYqbFvONqzj75IohpRM9eZXmyoxcjf79q1q
	bovY6rA
X-Received: by 2002:a05:6830:6995:b0:81f:138e:77a0 with SMTP id 46e09a7af769-83097399b48mr7961520a34.24.1791792578855;
        Mon, 12 Oct 2026 01:09:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.123.176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328ee6sm9328366a34.23.2026.10.12.01.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:09:37 -0700 (PDT)
Message-ID: <6acc95c1.2eca3aba.37f0b8.746b@mx.google.com>
Date: Mon, 12 Oct 2026 01:09:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7269099270117937195=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: [v2] Bluetooth: MSFT: Serialize handle map cleanup with event processing
In-Reply-To: <pm-bluetooth-objects-candidate-0242-v8-0aec1bf7c46970eda23e@gmail.com>
References: <pm-bluetooth-objects-candidate-0242-v8-0aec1bf7c46970eda23e@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7269099270117937195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1183558/

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.97 seconds
CheckAllWarning               PASS      30.62 seconds
CheckSparse                   PASS      32.83 seconds
BuildKernel32                 PASS      27.08 seconds
CheckKernelLLVM               PASS      28.50 seconds
TestRunnerSetup               PASS      665.60 seconds
TestRunner_l2cap-tester       PASS      13.84 seconds
TestRunner_iso-tester         PASS      10.10 seconds
TestRunner_bnep-tester        PASS      2.89 seconds
TestRunner_mgmt-tester        PASS      58.69 seconds
TestRunner_rfcomm-tester      PASS      4.15 seconds
TestRunner_sco-tester         PASS      5.27 seconds
TestRunner_ioctl-tester       PASS      4.37 seconds
TestRunner_mesh-tester        PASS      5.25 seconds
TestRunner_smp-tester         PASS      4.07 seconds
TestRunner_userchan-tester    PASS      2.95 seconds
TestRunner_6lowpan-tester     PASS      4.14 seconds
IncrementalBuild              PASS      25.63 seconds



https://github.com/bluez/bluetooth-next/pull/901

---
Regards,
Linux Bluetooth


--===============7269099270117937195==--
