Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71930DD32
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408124; cv=none; b=G2fAuxrKluNCoaCMM/VYntiHp+W6DdJUj9OIKD9Kn79qvvqgEhfMaisql6YQK5dWqWXNX3nqqvXifIUDVwhfeSYl+7ZE4ss4BRSm6hGYgFlK+4RRoLRBZWm1TtmQx89/YcGU6gQGSNouCMCkleLXeMEe0KIj9EDJ4NOfM3pte7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408124; c=relaxed/simple;
	bh=rqauxThdwI66cFV2Pdsn1u6rsehu/dg2B1ItKNgLdfc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=F3ttdiOBRclT3IzI81FXLV5FglV6DOU1l8hujsYQfxP7pyXVqiOdIj9n7k/wfamj8Ags0CsTECwKYwhUoyl9gkT7z5qEYV5kXEd6i+VSasAtIkNz6OTHzBSMLaSzrkeb83lYH6nQDdMgQJaiqXp+D1GAyvaLZJff+WuppKM0f+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsH7XBYX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsH7XBYX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e239baecso51858635ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 11:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763408122; x=1764012922; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yD1tZNTv9gzlv/NOXaeg+PIwTVhK74fCuHPvc/tC0cI=;
        b=KsH7XBYXpwXAFS7ENQ/GYZxoibVP8oTwnpwpM3w/BqFpi4A1iPyqodzvf+6QdIKuQt
         Q+eUXt8ZeYMKj2iGt0hKK5sM4UXGY9/myKnzW5nmDP8C8nixO8MBkXT7saqAs3XIm/lx
         FxY48NgiQL3CyiKbNkciH1FNojGpCDra16J9P1KiFaObnedQnE5yyaoKCbxvCYoES3J1
         c7nA+q5fflQc3u/Nh6ntBkIWeGAA+MQzCiQDVtjyCq9YRAwdYT+sL8wc6d7TNOrqqf64
         schNDNugT29eX0pTWVQnO4Ucha5q42fbYIu4sDZYI5Fjdjqy7gwBEjgyT+WADLfa1C8F
         KaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763408122; x=1764012922;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD1tZNTv9gzlv/NOXaeg+PIwTVhK74fCuHPvc/tC0cI=;
        b=jMGzFOFcz7ksuBwMQYBXINntKcTTjWC7powJt2UerhpQjyNkWFDdCptl5NBBj2aNeB
         hgg0qv9ihWsjQ1G+0WKEr9BN13YXYhq9lG2JQGD/n9ouIfKFcHK1VAy9QhQymCvnqUgz
         xrTIHDcXLza9XeZIFIShHqMpR8ggMYhHXAmwpzc/xoBaNBSmhxE5SbBvuac2Va5OrzOA
         ETzDOyUYt9/HFPoRGa/qwnhCCNODleatQySV5EJL5zzfLXJ++txNvvUMdltCwva6EwWM
         ZEtDOudSGSpJJMBEhUGuVcUfvck0F7TnJTSE17GM32bZM8cEmLIaGrdIZ1XpGJJvxokd
         KCWg==
X-Gm-Message-State: AOJu0YwR5ci/RrckGFqw/5MdYH9vcDccOxFh1x6MqWDiPByPexTULG/a
	JP7UCpZ5mE6c7tFk7tS8TpOrdEQt/ip01hqeo75V+3ZP1eeoIBUwyW0Zw5JePw==
X-Gm-Gg: ASbGncviJwtTEjBzkGJrbAUDfl1UnvrtkA0CcejnSUFKP2e9H02uyG9rKDE7IM1oFVT
	SW8chZk/g5wLk816L9nQSA1zRueX96BirayxIQvKefUZdpkFGHV/2X63RbyHhTfe1l6sfWP3cpa
	dorATXGYgJJBGT/i0E6JaXRRuB35Z9JinnUi7M3kFw4/XsVGqxXXaDQ1unNl/3DevJQuN2XfFyy
	AJm1d8LqFkYoCmx4e5646soNxnU4JMvB3ykFskWzuMIjvf0jZPYPJivaBHNFbryb6Ef5UgGjN4R
	pqyV7XXnb9KyLdefFnh6HTlLmNsGDdERLpYLsM9S5ony0oj7XvE7CMghsHzyUwOb2MmTal0alo/
	Iog3mQasdeaIpsRMyz/T586O+nLkKUHYJ7InA7QqhXS/zhcc+w5YbYAxt5Osehl41RErC2IrD7N
	GA+a8TKXQLl6WlUb4KM6mwImkgMVUE
X-Google-Smtp-Source: AGHT+IGBvpWIaiishLBLehewI1PT40TpQVoCCi39jgzxk9/s7AM9gZkricbntOwpq/59ZlSC/ke6Wg==
X-Received: by 2002:a17:903:2345:b0:297:f527:885f with SMTP id d9443c01a7336-299f5424486mr6190385ad.0.1763408122247;
        Mon, 17 Nov 2025 11:35:22 -0800 (PST)
Received: from [172.17.0.2] ([52.159.243.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c9dsm148662675ad.67.2025.11.17.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:35:21 -0800 (PST)
Message-ID: <691b78f9.170a0220.2e9b6b.2da0@mx.google.com>
Date: Mon, 17 Nov 2025 11:35:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6947076065349425356=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: SMP: Fix not generating mackey and ltk when repairing
In-Reply-To: <20251117190232.3918619-1-luiz.dentz@gmail.com>
References: <20251117190232.3918619-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6947076065349425356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1024463

---Test result---

Test Summary:
CheckPatch                    PENDING   0.43 seconds
GitLint                       PENDING   0.43 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      25.50 seconds
CheckAllWarning               PASS      27.77 seconds
CheckSparse                   PASS      31.76 seconds
BuildKernel32                 PASS      25.53 seconds
TestRunnerSetup               PASS      552.29 seconds
TestRunner_l2cap-tester       PASS      24.34 seconds
TestRunner_iso-tester         PASS      88.22 seconds
TestRunner_bnep-tester        PASS      6.13 seconds
TestRunner_mgmt-tester        FAIL      112.14 seconds
TestRunner_rfcomm-tester      PASS      9.30 seconds
TestRunner_sco-tester         PASS      14.44 seconds
TestRunner_ioctl-tester       PASS      9.91 seconds
TestRunner_mesh-tester        FAIL      11.54 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.48 seconds
IncrementalBuild              PENDING   0.86 seconds

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
Read Exp Feature - Success                           Failed       0.105 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.182 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.966 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6947076065349425356==--
