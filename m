Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917A3A6B84
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557523; cv=none; b=Xig3NhlbwVPQaHxqikhn9ASJN4cG1Tn4eB2GrggVMbywg4kWKXdD0yHTXLFnA7rARPJDoyintoNVhKbmajO+iSXjapIvq7V6ihk0Wu4b0Zmv92saMnbm+qANCqOXcqJJzZZpIn18050pIAzU0fwHQpqYJl6lGnqNqL5fUovuI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557523; c=relaxed/simple;
	bh=cB4r7VWWImUpOOykUYhjIpHmrtyADIB+UtwoG+L7H/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CkHtzABwwUXh2MKNv2hAj29FdTxiO4vCUGXC8c56gm/W3/m03soIEzf9R76fhgg84woFEgA4vEjCCNp+AHNmFaGxajETOo/jkNvrAQQoHsTe3LkgfAxxkjhxcbh4yx1CCWGyq8C94N/t+4w5+K12W0jDnJb+bZwIzpWiPTypatg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpyPMePH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpyPMePH"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d63635d80so32644381cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775557521; x=1776162321; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t2MYX53maI2Rrm+/qtNps1VUlM/0m8iufNWP9HbJMPM=;
        b=gpyPMePHd0SMumPSR3Kk3NFEc00rmHqobbvwwnqdV7YRA4YbeS63HBpSvx8GtLJGK5
         Ku4ScTJGuJj0Ikrp+asK6h9iwXpY6y87incYOk+H3O+hTfHYLi8GqoSgY+TKmlvsZ82b
         yPTyMr2+ehpGF4zjTKfX5B0EsXzKsSCbbvLsOne+FQGltFrE97WmUI2SRbOA6lGRL0qh
         D87l1w8G+Uiv+4A1eNaZBsL0o3k4WcTw9K4tUzglVKfBaVzI5dWmkD038jBs5e/zCPgC
         BF0P6ObUoMK/KZdlhUPzaSvFGlCbEKPWjWIAzc1BnubegAVSfpf767d/AQ5lt5DHJRvJ
         sVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557521; x=1776162321;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2MYX53maI2Rrm+/qtNps1VUlM/0m8iufNWP9HbJMPM=;
        b=f7hho+gJRs2Kq2IPBkUfcoJaR17/JfQe+941BNkngruX7D4a+OjQmBPB5NetmRcNqG
         6h1Zf9PGbZoGqvbLPrtGMiKf9Va8crHWbEZeG1fO4lcr86BWBjfSJR51x4U2TDb+sJLa
         2n8Mv2oDXIY31Iz7aBbK1kpkVymxoTYGPzITY8syOn0CaD0eQNQmzJ9KBCz7maqs+pV6
         o8z6zXQAYaKKwgTYL1Ehh17Zf0NnL7dlJ/Lb00szcTdrt71i8+N2mIjSX6pF7Z9xy5Xm
         RIIOq9Mimzc0xwimRnGg9umIpYsiMo/riVUD7Rbqt6MP9f5Ror35rKhDtxwJn0fEBuIJ
         2eYg==
X-Gm-Message-State: AOJu0YyV27/DlAB1XGwwW9HgSraBj/zdkJHkCdW7ohIs4kQZzgReONSZ
	rqvbTuVTIs2o6jhrpIZCJHVovLWVQQNqvnVlJo49aq99EhqkieweFWOhR9Godw==
X-Gm-Gg: AeBDietsP2DKHADcPI5uO9IRXdNxPFnAohPjLzpejIJI1HmsoTCDG6uhOM4T9Z9IUpf
	2agT6eEaf75WEgbrDPJc9ftjpJ4BkWHLFkfHgVnkYwkpdXU9ncSPmuiffp9oDi0PJccb0CHsxhG
	vV9PAxHLG+BE/8EzgtQibCYi71APxjRgOXrQjPij1YAR6SXc1dv/WRBw0rqfguWcXhvJ7vESWNQ
	TIDyGH6eIppSiFHD5y9/4RPhtf6Vp3mUN55pjuKDAX0IAzrf4s7gDbSzCR9hfiFYV6zRqZ+pfjC
	Lq9ow1sJQEHu4FbnO1J4D+/XD03jUOrrPAZNXTxh8rSphMofLhXP96Rypaqi423v2GCp2mmX7jM
	ajiCaWjUixZihu8ZkJjKKeK3Gw0SeJwCzMzUuqw1ztXcgfNRQnrP+lpCsjRV9/h6Opp3NH+zDbR
	Lv3OdtC3Cv3+qh6sA+GOr5EtyH/ZYB
X-Received: by 2002:ac8:5d89:0:b0:50b:436d:dcc1 with SMTP id d75a77b69052e-50d62b4e677mr247607271cf.26.1775557521001;
        Tue, 07 Apr 2026 03:25:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.42.210])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dac753208sm1007171cf.20.2026.04.07.03.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 03:25:20 -0700 (PDT)
Message-ID: <69d4db90.050a0220.7e12a.78ad@mx.google.com>
Date: Tue, 07 Apr 2026 03:25:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6300504335698563900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Support Product level reset
In-Reply-To: <20260407092940.1272507-1-chandrashekar.devegowda@intel.com>
References: <20260407092940.1272507-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6300504335698563900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078042

---Test result---

Test Summary:
CheckPatch                    PENDING   0.42 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.07 seconds
CheckAllWarning               PASS      28.71 seconds
CheckSparse                   PASS      28.19 seconds
BuildKernel32                 PASS      25.62 seconds
TestRunnerSetup               PASS      570.96 seconds
TestRunner_l2cap-tester       FAIL      28.10 seconds
TestRunner_iso-tester         PASS      40.19 seconds
TestRunner_bnep-tester        PASS      6.41 seconds
TestRunner_mgmt-tester        FAIL      115.70 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         FAIL      14.29 seconds
TestRunner_ioctl-tester       PASS      10.24 seconds
TestRunner_mesh-tester        FAIL      12.55 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.77 seconds
IncrementalBuild              PENDING   0.66 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP BR/EDR Server - Set PHY 3M                     Failed       0.116 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
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
Mesh - Send cancel - 1                               Timed out    2.753 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6300504335698563900==--
