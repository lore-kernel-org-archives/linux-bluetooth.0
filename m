Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E19237A4F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110309; cv=none; b=o84GK8QUzDkO6pa5ZbeEFiOpWK6gt9OsT1nYezkU/P/tqKnWL0Xcn/faMhCLVxdOdQDve+lVtnRpbM+oUprmw/picZiexB/nzDKidglQs+j89TVnXG6wTLVImKz3LehNDncCmDZw1k308Em0SFMSaqq+Q9gDJ8sd5RZPJtiN5zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110309; c=relaxed/simple;
	bh=GwlYRPiHb4iSqWzLP+I6YNmn2aZaiJxhiSznFzDY2vI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Jgpdj73PdaDKMKELtqDuJUBM5uhZcSfrSlWeF+HKTnRWOuDPQ0Y8WO0xG2vCWNTQWb53qlWaMYJC/fWdxmJcwz24rCSCQFCZ/wLJnkAu/+NibKCoex2PjQgq907+MisTpaA6fmLgoWoyPRcTSwzZ4Awwnr2Lj1mRlP7ScNhwWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH4HNTAg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH4HNTAg"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330b4739538so2080876a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760110307; x=1760715107; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3L/3ecfQq1dCqh1UGtqnixrNlkBVxDOmhOsfFfLytJQ=;
        b=RH4HNTAgDvsghU59LG2reFjjZXzKQ4rZYjpY1wilBa0sQPCQvHErzN9O1fO8lHyzAt
         +W5SRKgU6ALtRs50jtWvMfkEen3H5BA3RCDF+YpwpaYTuB66OP2qjxmiS1CuRkhJHFvp
         UdfSyQaackrBRrlVktWebf6dllSr4eldEZ4/qOsrWWfVFrDfoCpUYZqHSg6eZ+tU2CHl
         QOq9iEnWQsnRjHoo7XCvyUeE5tg2EZVFbMrhrPI48sbHFDKCURpRHMqvjxLFm5kL43HY
         pWsS3kqvU5srcm4Rph4DpKAMo6aNMu7HwiLhXm1CERH+gLvhig/K+zBCdZ2N5gqOBQJv
         VFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760110307; x=1760715107;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3L/3ecfQq1dCqh1UGtqnixrNlkBVxDOmhOsfFfLytJQ=;
        b=jJjH3rHIlmTt/QuxubgsCpSAXcAg7aGaKiyueYGC0tHMm4ZQys4bot0LqCd9hpNB6X
         Jo4EWbywT96HQX9m6VXEUixobHjKDORFEgWbrJs/Q8Siptj2h+1yahIF14sAyTodM3/f
         ZO+RNNqMnrfr9v7a/+YqVd0oxD+O4nTnXpi25pYY37lQ50sItHNzMyxHnxDQ+UvSWHvv
         0RkdPPUpWj3gi7lrr2grx3SX4dggyNFS+ixXMDYabRkQl9vmkHllWZ7VjaPl8fRO/xEL
         hBgKOQRwg/KhhdnIuMnEilPOBF5XVDiFafr31IjEpz1vP3YE6LGWG0kIkYvhUs31ov8C
         MMXg==
X-Gm-Message-State: AOJu0YxRAC+PeYjxLcB2eEV5kkXhucj7PiDPfM9NaOAxtWKHAOu6RsYF
	2ZUvSQCLLCCWGT18LEE/FBWJtSmIJgxcSNL9LM8uHTff8fRVUxwg7l8HUqEvPw==
X-Gm-Gg: ASbGnct83crfqOHQxmkMR3neUdI86MoUaRPENbdoyMZohU5Hf6//htiChGJQJ+e3yyp
	hNSwKr7lpMjvnUuNbmjMhsijXpd6No+BVkz33S0kuuxSj2sdnzAWsgN4Nc3LqFxo3BoGzvSWnWP
	KxDKuS7Jvp8DR7TWJ595oBfUzV7IUiYBp2LkIIpODeGJh5vxJPeC0PC0LFEMmFnlUk8w1MKKa4n
	4WPTId7HcSQoSLTjujAAy7Xc4AN539VfSKpNGqe35WdBhyh/g8WTCWU5LHO9ARjyQuY4qx7Lq/O
	yBmjf0FrSGaQXj+JkLwLLMlCewh3zCN62aRRyIr3wOhZCsLWM3vKUq+oCR++0gKWrAEHm3GTSL4
	k/z/MlBKOxR9ajoUHUepAg1wkXKNl4+qpgOjDhx0pdMEOhE7OJe/eRCet4w==
X-Google-Smtp-Source: AGHT+IE73al1DAf8SNP0nCcDr3no9GsPR/W8mJi2nQZWnkK3wd/6f6Seqgwi/sIenlt+/ROQGTDw7g==
X-Received: by 2002:a17:90b:350e:b0:329:ca48:7090 with SMTP id 98e67ed59e1d1-33b513ebc36mr15200176a91.37.1760110306841;
        Fri, 10 Oct 2025 08:31:46 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.7.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm3314012a91.7.2025.10.10.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:31:46 -0700 (PDT)
Message-ID: <68e926e2.170a0220.30773a.e6da@mx.google.com>
Date: Fri, 10 Oct 2025 08:31:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5400405527496750868=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, adrian-constantin.dudau@nxp.com
Subject: RE: tools: Add raw advertising data support to BlueZ
In-Reply-To: <20251010135521.4854-2-adrian-constantin.dudau@nxp.com>
References: <20251010135521.4854-2-adrian-constantin.dudau@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5400405527496750868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1010113

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.41 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      2756.02 seconds
MakeCheck                     PASS      20.23 seconds
MakeDistcheck                 PASS      185.85 seconds
CheckValgrind                 PASS      238.04 seconds
CheckSmatch                   PASS      308.97 seconds
bluezmakeextell               PASS      129.29 seconds
IncrementalBuild              PENDING   0.45 seconds
ScanBuild                     PASS      926.02 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5400405527496750868==--
