Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40C29CB54
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695882; cv=none; b=oQ1TDDvu+86KReXxZI2XJ3B/rgGeXKUVynFhRpMztkDSieh1/nAUC0jMZlxtAZgL+dCb3kjruQM5A80m67msYtLRL66IQUKsyTOZyzPK2DNGc3vwDArBBvBGJq7hqfoBRwKN62/tlIljkuK59AARZiYzt/nLK6pwXfdwMZGClv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695882; c=relaxed/simple;
	bh=BN8KeXeaJf615s47PEsdtB03bGe/9xDvFeQUvxw58lA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tZYr8Jm29XT2y3L1ydOHmQJxupwOGWFmV1R6sRf0HvTpUrKMuQPx4/RJLhTHHQdXCoZJBGMRfRDLQ3MeC+HJjy6QHQeP3yCUAhSqV90pl7YEr6RkJyHWPKyuz4HDtuoPwDdNF2ZuDVOdG7QgB8ARFe2eRF0ZxfFLKk+qOCS8Oyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F55MfCoi; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F55MfCoi"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6faf66905baso4214316d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752695879; x=1753300679; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kV14Vrefd8t4ymjTch4I/rbqPmDS8wygk53szvhgPA8=;
        b=F55MfCoi5A8lUN1RfZ/Nvj2kgNZgNZOPqmKvqeKMu576V4/TjzKXSfufDr1EMhtg4m
         eJz0NLL1LFHgsVBLTFgz1AbjcV1U1eFRVvXxDu7ptOxqdfT4zj/zU/e0htv26be/rQxV
         PtQDJnI9mvlHaKChnLh2UfsXM8AsNDUPJ78i8dJlmzeURb23TnlSXxoZgVpBK15faFca
         RAegxRR+5TPPr7BIzf6v7K4zbKuLfjqvxATd2icyK5czvO63eQyZwqMhwIAfCJwcLdD/
         vdcaUcohO52cgnVIzJoHsje6AGi3el8sfVp5F7rQhnDk4alcjRor2BnNb/p+hSQJdoG8
         Nsjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695879; x=1753300679;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kV14Vrefd8t4ymjTch4I/rbqPmDS8wygk53szvhgPA8=;
        b=pyZXbghhF/dnJ74Po1OWR2LM4ZrchJFEFZY/KMFyjUyQm+OsjIiYW2n7HLyS5HHPXU
         pM9wmMoySMjx/WJp2BV4wZ8p+HseHb2URfoCuLYECeHKplvoCa7eM0KoosQeTCH3FaGR
         mjbPZ30Yvc5nmeg0scw/GsBAw4MbHs5ZFY8XOwmnQKFciNP6VGxVyVrp7KumgfeFLvPs
         ExTmpAiuVCQgyAOr6nMxDCOVtEuMRYy0vi9R5R9SZBHQfwy51oy0cesRMl2PJgctOStV
         ZtDWit/K8/UtB13hJKr+a+BwTlfrGz7pEq8q1IVbbv2V3RweaEPEWg/Qr9SnjjgMTMr3
         o2Rw==
X-Gm-Message-State: AOJu0YwuKKvSSPWhGV6pibpcA36P9yROUA6F/IZLCrjbEDfJOIh8fBur
	DFqtjFiUTb1/mFYA4v/NEFTy6D/1G9uHUZB+uOFLhfrgpsvbDonGdweaX6gUog==
X-Gm-Gg: ASbGnct9Dm07Hak+bAmiYWcFOFWM/jq98CCsA9kDo9Bq8zujWNBoLbVRRO2Vk4n5HZb
	bnm6jr60hg2jP0cOQ0nbRRfIYSTE2cKfjN/yKD9Ud/3BzyPCGJphON6g2lm74rPj2HTut92zawZ
	Whk9pMrhcd+muwM+qWCg1IIOVcpQf58CYo8ncxjh4ycnxg4SKgmnoAHPxA8Dav2h2qMx21vhzcM
	W7zDBHjeI5gkU1K97gDXhi6L4NMhm/RSviCvIdoGbEyRMEWaSI+syxez4mR/yo6PgXw+Cy3+Os/
	LhzlO8nqUOzgNBN8dDEFYvT1UO/Fc+hsUZfYyR/SbATpG6CBOrcpqQCZTfLzasPo1E26jhBM8eY
	B1OEIOakP619dl1S+36+FTsXIp0k=
X-Google-Smtp-Source: AGHT+IGYtr4cOopXkwZKp7wyy/tS/Ry6SvWpz2o1xNlgOW5taVKJ6eDUr+EzdUv3CKgccu76uRRkAQ==
X-Received: by 2002:a05:6214:3d02:b0:704:f952:3d65 with SMTP id 6a1803df08f44-704f9526d89mr48500856d6.46.1752695879073;
        Wed, 16 Jul 2025 12:57:59 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.135.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704ac0a989esm57673486d6.87.2025.07.16.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:57:58 -0700 (PDT)
Message-ID: <68780446.050a0220.1b0374.a5c8@mx.google.com>
Date: Wed, 16 Jul 2025 12:57:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5114282689110090852=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [v4] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
In-Reply-To: <1313ef02-285a-7012-74eb-b6589d471be5@salutedevices.com>
References: <1313ef02-285a-7012-74eb-b6589d471be5@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5114282689110090852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=983081

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.17 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.85 seconds
CheckAllWarning               PASS      26.49 seconds
CheckSparse                   PASS      29.97 seconds
BuildKernel32                 PASS      24.02 seconds
TestRunnerSetup               PASS      469.91 seconds
TestRunner_l2cap-tester       PASS      27.17 seconds
TestRunner_iso-tester         PASS      36.04 seconds
TestRunner_bnep-tester        PASS      5.94 seconds
TestRunner_mgmt-tester        FAIL      132.92 seconds
TestRunner_rfcomm-tester      PASS      9.35 seconds
TestRunner_sco-tester         PASS      14.77 seconds
TestRunner_ioctl-tester       PASS      9.82 seconds
TestRunner_mesh-tester        FAIL      11.42 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.50 seconds
IncrementalBuild              PENDING   0.81 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.210 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.114 seconds
Mesh - Send cancel - 2                               Timed out    1.993 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5114282689110090852==--
