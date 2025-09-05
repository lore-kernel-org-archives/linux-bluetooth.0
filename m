Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5B1F4613
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064953; cv=none; b=UHOcYzOvGnfzHgRhxrbCTWMRdcmCOww0W02zFZ9rlafncDqbfT6y7ueiopr2XzQwd0aw5n5VtIiKFVlBGkK6PWPttZ/aWoYl3VFuJP6kcTiBbVlGBjAeEB9HW5+bIXMS0tzVD8R+sy9UIDH9G+0qWL/fue9nfJ5EIj3XrOHKcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064953; c=relaxed/simple;
	bh=qARMuP6W2/apIkI32Da6CoGwwUTHW3531xyUN4uEV+E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FWrImYwNezzD3l7ciS6GgHTo3MYWQsLOQZq2kTdCYquo7JBXei/YySSy77Rkto7Wif5zk/kImjK4aCsd+7GLUX7whlklpJM32l3/MboBvvme0v6hSHrUCA9ataLhEtnHOJ8kSnyWF2T764B9l00ohqQeUnSPRDVYmpbDUKuJA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZwBxaFT; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZwBxaFT"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e86faa158fso210935485a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Sep 2025 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757064950; x=1757669750; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=McmrAA7H645QH5SeTBTskh8icyt58i9YysUXnFsc8c4=;
        b=EZwBxaFTx2RdYod3il2nVB0dwhJiR+dAG6enWHXA+tSAsXWBsKnReJmVsfHAl5pvgi
         Pp3JLxJNKVg50oALQaAru/B8iEAkSJvKQ24S63Cx6lsXTKOTYBLpim1IpEQUo2Fpp3M4
         +7wjbljwNH8X+Pmoot/CZ8szI+F35UFBE62AwBmZzkXEqTWN2A8fe6Iam/N1/ULlA72P
         Q3X78sVqdDh2RvTSjr4z0Aus82OWKKEZkm2DyZkf7MaAX+k+URH/0PDutz0WFE9d7jTi
         LEGG/8SeNGEO0c6wClH+UDcLpB6Tb+jiZkPiKp9NmwOBpVUNdnrGbdu6fhwPrJiZLvjj
         /29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757064950; x=1757669750;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McmrAA7H645QH5SeTBTskh8icyt58i9YysUXnFsc8c4=;
        b=Qwih4/k222T/g7thGPoSGU7W+gQ4FGeftbvsSaiksFPnwsRlmJqn2U7iI31uRgzhIv
         8dOp/JBPAendJ5eqnDfi1hVphJN46wd1yviFSF4EanlBszotoiTgATWzii69AYDaEUMG
         QxgwbgLZRP2Nm46UHhorVY0qRRHeY6Cb48yaiOufH9eyAZLs0QTU54hCjAcrQqBUN7Mb
         nPfsGuxiXigPFSuJ6EoURh4YyZXsWQhgmFqD7JlqIYCgmAedy9BlV8T/gUFEsJj8v8JN
         w2s7K2L5jzBXfkRSdFgjgD8G1JkeSpcFQ887wQF9tj98+OhQYcAtzadbB5vrTeJUW8Nn
         FoOw==
X-Gm-Message-State: AOJu0Yz8ycNU8U3d1gXJAwBCdrxGIxaskuCW7JZOsAYA5Z4OWOcFDFo8
	HFB81ySHqt+AqTCBVTY33qeU//8HLPhbwww2AVfoGX1Uukimr9p/RId4xR2pIQ==
X-Gm-Gg: ASbGncvFv8ObLvIG8A5rJLFYBWtnrZuco+4TlVovBuSq+JnANpPKvZVtDLW2yP9etcl
	s6iGLKRzb5UjaN62MQE5b7QSF19EhhY1eqGFEVKGgN6eeQgRNhvTqaJGslXWH0/hRUTQ4Zqngfc
	vdbaMp6jOtxFPtApoKCU5e/ahkf0eTSf+pdhjdl8qtK3hv0etQseaZLwuRa2f5k2bVvUmfPKOns
	+w2NhJXhjdLMuDZ1hMhbttOxQRwQnPYpG6FG0tmoAHitZ0Uu/MXhUympsXpXJvghIetc+x+jKzk
	9jgIfjbt/n6W1265EW0pSl/ltFG/CdLq3tVyHYq1X2JHngPtOK/jhyRQ6pNsC4CeqyU6Ll5hh4L
	04niUZvW/ovY1GL4cZZgxVYIszWYRXIYG6au86E4s1WbjRyw=
X-Google-Smtp-Source: AGHT+IF1wvV2Lz5LGvxb6giC36e4TcZZJXO3TFvmzIxf98iWULMGF7L2CKUYoR6brw5HrF0WBV+n6g==
X-Received: by 2002:a05:620a:4628:b0:7ea:622:f844 with SMTP id af79cd13be357-8109da22eafmr397230485a.35.1757064950301;
        Fri, 05 Sep 2025 02:35:50 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.151.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aa6e4c981sm448584885a.21.2025.09.05.02.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:35:49 -0700 (PDT)
Message-ID: <68baaef5.050a0220.16259f.f2fa@mx.google.com>
Date: Fri, 05 Sep 2025 02:35:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2781768505152365639=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: [v7] dt-bindings: net: mediatek,mt7925-bluetooth.yaml
In-Reply-To: <20250905084433.26999-1-ot_zhangchao.zhang@mediatek.com>
References: <20250905084433.26999-1-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2781768505152365639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=999225

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 FAIL      0.39 seconds
BuildKernel                   PASS      25.80 seconds
CheckAllWarning               PASS      28.62 seconds
CheckSparse                   PASS      32.46 seconds
BuildKernel32                 PASS      25.90 seconds
TestRunnerSetup               PASS      499.85 seconds
TestRunner_l2cap-tester       PASS      30.65 seconds
TestRunner_iso-tester         PASS      53.91 seconds
TestRunner_bnep-tester        PASS      6.23 seconds
TestRunner_mgmt-tester        FAIL      133.33 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         PASS      15.01 seconds
TestRunner_ioctl-tester       PASS      10.44 seconds
TestRunner_mesh-tester        FAIL      11.47 seconds
TestRunner_smp-tester         PASS      8.83 seconds
TestRunner_userchan-tester    PASS      6.44 seconds
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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.109 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.951 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2781768505152365639==--
