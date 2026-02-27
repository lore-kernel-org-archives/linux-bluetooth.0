Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B103EDAB6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194506; cv=none; b=pnCmMUYRC51dJisR9C88wXb7keQYxSQ4GwjzpUDKaE9B/JoRDTfW6KIQB7uyQWDvVIRDeuAFhWcgmaFQNr5OdU7zCx94q8x9D8XMQf9bShSI+PaDpvVE+YtPeBeEFxOmrpihQydzEaHpjc+0mN3jxIUN/XBUwt6ieWrsYxX2gCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194506; c=relaxed/simple;
	bh=lBvLaqAbR7eX4aqXEfV9uJhQgi7xIQMlAJ3RvOZqn3I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GGLL0YWOENJAVr6pWBFWIWCInh0cY2l2/2IQNWryESy4H3usVR7V0LiJi9JVfdGFgkWnl8MJ0t80MiMHz97x6jWekvVhizv5HO+YqnEMZ1PrN/BBNUNNB+AxcsYcCeb2xBsBb4YXb15GsNL/+POqG5nIfePqj6i7AcvvPdsOpZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8tGjwCT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8tGjwCT"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506984b6d83so14536621cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 04:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772194504; x=1772799304; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlPlL/5dhdzaCfmxv0PUyTq34yVtaRLO8REZP1+pwOw=;
        b=C8tGjwCTgJD2rHdTbDzEQHKtgKIAE/vF2zsJcc8S1bCJOP98NfbmHfSQWL2/pNy/sE
         TWq2shcKpBfjQAqdvtrotSfkaO2/9L2cVpTH+OMGa6oGbnfcxHAkHnrDeo2qE4xmgFPN
         B9agMTVUn+GERpwPeFQ1BgGldO0twO6wqRj4E8kUtLHzms1wT9np8nhwHOy28BlIHsSE
         W+51WdB9CSpKG1c7F0A9+aujQuVrCcmlC0pmDifbRsZmFup8P5Qyf3r5iWWf/l/eMzf0
         sw9+uuirb/mgLtdmdxwfVP2A8RA/lDLvYMKaxRhOkMnlNzDWOfvU4w3s0GfEB6audKpA
         U8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772194504; x=1772799304;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlPlL/5dhdzaCfmxv0PUyTq34yVtaRLO8REZP1+pwOw=;
        b=AKw25D7t9ud5ObhY/FW4Mn9POE4b7jYuIUDVG+AiWuJvkR407kZ6E5iyAntUoVA+b8
         JweU5pN1aV4EmD9zSJ4U7mIMRuw4CtTObqGvZwZ1uCc1rAUoF1Gebnub3XZf1r+dvvSg
         8Uk1GSzddEjuwJqHwduEpDvGfIJS1QFXADWXaAh3OQvrZqXMkHZdToP1QW0b8uXs57oq
         T5D6pXBJVulfC0jtoXwBpjehhpdbugo/E8+ajBgwBQQ6c4hjldrvdY3X+6OaDWupIRu4
         yOzYD/kNDMzTSWd6eL/zxcYfv+vC46EnpN41KP0UfrSvg9+Zf289w0lNAxh9f0uZoO46
         6GIQ==
X-Gm-Message-State: AOJu0Ywv3IdjEWbIZ6GRL5H3Bzwy6euVZeykTJ5dRcO61V1N8Ib4ErFR
	hSUAB7NJ4VN0N3MXmeYSX85jwfOoPx0IZPwprXgjnLdvlWrr+0GRLm28Oa0x5Q==
X-Gm-Gg: ATEYQzzg3Rsvf6BfijltpZcsBSOWaL+mHtjsTv2e6aTQ9rcohUnZEn5LA0rc3XTmkxW
	p7V1ybb9KS8kkZQAWNasbEcU99/ugQrQLwA4mSeLasJCTkraOTy3HqHzUPQPzd68b1ayDWqdwgT
	0vf1ToytVrweTd9f4ghU6LhvWaxgJ7LpWJ8zWMXoi7CPvpsshcnBG7BEvYLdhVv1005hOTSLMqq
	O1q5F/28Kn51ULNV+JfWHPY4QnF0yYUdq4vc1FE7G1cW5+TGA/Kc5HZTd5INrQoMmDz6Goxg1Uj
	qyrd9BgV9y36Z72M8ZdJN8gF9qPOSPEbNpXdZxuRlmA095qlZIi1u4fzSau2BmiJL/+tNuwCdGU
	QgDE7tKY9H5VZyY/ARpbPlEqVloq/3hODcovyxABkeW2R40XYfOwaPUUphyvWGgTWqR6M6wvlBl
	NZdT1pkW/vX86jrNJQ0QhwIYfy9jh5fg==
X-Received: by 2002:a05:622a:284:b0:506:1cc9:f546 with SMTP id d75a77b69052e-507528de7f0mr30565491cf.33.1772194503670;
        Fri, 27 Feb 2026 04:15:03 -0800 (PST)
Received: from [172.17.0.2] ([64.236.134.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf717301sm452719985a.36.2026.02.27.04.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 04:15:03 -0800 (PST)
Message-ID: <69a18ac7.050a0220.23beef.4474@mx.google.com>
Date: Fri, 27 Feb 2026 04:15:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1442205731748014597=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wangtao554@huawei.com
Subject: RE: Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers
In-Reply-To: <20260227110339.919014-1-wangtao554@huawei.com>
References: <20260227110339.919014-1-wangtao554@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1442205731748014597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1058928

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.66 seconds
CheckAllWarning               PASS      29.41 seconds
CheckSparse                   PASS      33.30 seconds
BuildKernel32                 PASS      26.49 seconds
TestRunnerSetup               PASS      576.25 seconds
TestRunner_l2cap-tester       PASS      29.23 seconds
TestRunner_iso-tester         FAIL      60.16 seconds
TestRunner_bnep-tester        PASS      6.56 seconds
TestRunner_mgmt-tester        FAIL      126.65 seconds
TestRunner_rfcomm-tester      PASS      9.69 seconds
TestRunner_sco-tester         FAIL      14.92 seconds
TestRunner_ioctl-tester       PASS      10.41 seconds
TestRunner_mesh-tester        FAIL      12.46 seconds
TestRunner_smp-tester         PASS      8.88 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
IncrementalBuild              PENDING   0.90 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
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
Mesh - Send cancel - 1                               Timed out    2.470 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1442205731748014597==--
