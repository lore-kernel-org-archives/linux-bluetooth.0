Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A6446857
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515900; cv=none; b=H3cwSQIrdcA2xsFHDKVd251fUTP4UjeXYTXPXLjrcTXJyn+LxKP0CRogdFsj20iocWuf2aXyGx6leJlHhCT3rd4rg2J3ZvVBbOtcy+J0cDLL5G5WGtAJ9owINM+DPRh2yRCcBT7kzpTUZog7/eFt2JqAnfmC1DG0qb2TdFU3dlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515900; c=relaxed/simple;
	bh=TQQ23Y6u1Fi00aI7p8kyItTrU5zY65t/6428NLzThXA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dn98Tf0+zeG39iJPoA/jQO3ympf+l1VVRYHrwtp0AzAA6lHKTHwRpEz+Y3XGPXHzlvDoNTifkRNXnQDxjTPYHU+py8Rs2IQDx7BgoNWUjIY3Ej/l1nYPt6w9yJwEErF4gqzBHa2z/cbfhNXblLJxcqZchIvg99+QIIDx/TE/kEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3pmzGVy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3pmzGVy"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso1039414a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788515898; x=1789120698; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BLPyOiNE8PIIsgK/vyavXxnvFy3ajaogQYsN82IVNZQ=;
        b=U3pmzGVyGAYzF9NrMIYM+XYz/BhnzdmNfjy8+bkj9GUyirdp1Z9TwUNdIADcPAJubh
         fbb5wlCma8FKZAQN0QsP5S/WeTjata4/v4TlA4J4L6d91CeOZRea23RlWfLSw/g+b4LC
         dsrTWhInWFOpR8Q2tW9bWKhEIVz2j0quo91A2Bl84FCzSaJ7WjVThI0Fj1L1z/pwNgsp
         MmdC4/b0FwWXtZDxFS//J4yW5Byc+ebJMSuEiVYig4yHGkw9txl7oYUOsPFc8z0/iLTT
         qIxPJbuWRyNbQiV2hdsaVPY5euZhJiqRqSOJyNoxH0swj7WPWiM3HsLArQZOOoHKEjEW
         I8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515898; x=1789120698;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BLPyOiNE8PIIsgK/vyavXxnvFy3ajaogQYsN82IVNZQ=;
        b=gbakj7eP2bRURZJ9cjQVBAp1k/5udOhMnpVsfifoQnMDAuDQ8WoaDUGwWzB7XHcukZ
         oF1SjUzifFyVwtRqMTPmJPt+duJy8+QsVRhDOUbl8quG9iqwbI11kCHXDZHFECbzzHgX
         Fzo3wv8vXjkdBNlivhtiQmAh2gHY2Poi9DjZZ28xXmlRU3KHLkOQXAVKbVP/cWkwPrYk
         YhdDVgTvjPp2r84nVwT32IQXVlc3FVwgTVHM7S1sDFtJFRZDEl1nFkjAf24i2kfJOr2Q
         gJkw5MgrEvIX/lh2nxe/TSFwW7salEiXCPuAdNupH8StlrL1m8SUkvlFgvXx0QrH/2Wv
         Pt5w==
X-Gm-Message-State: AFuF++lOOACz9AUFGC2i8lKPNPxCSAHF61KVFftwKthhS/zSysrJzBKt
	RBWl29mNlNZ5gbO/y1Y6wT64J6Xqg5gNCtkjl1jcb4nr7Tb4P2NALk07nQWqXQ==
X-Gm-Gg: AYBFou1pnDCrWbqTBPA/ye40EIUWpfde0DOxLm1dQ6DuUtFneQHEsg1eHMB3eBtJoYP
	R1g/szgsXsnAnSHZO1AafJo+oBJ6VXm81SYs0wGBLwyGTrfVjQv4IK6pmXiVxHdXKKdLtyUw2wV
	v0bCrzFGZgzwRg/wJbfPUrK0FvGB4ByzquiKdEQsz4APeFfi6kcu7/akODByS8H1BsdgIPfQjcb
	n8I9yHheS9iguIyLJf2hKAidmuG0SonDiRwyzKKr5o8kU2jaeT9YrlXtqntXqkay8SS+oFmrEiB
	BYB+qnhLo5kAWy74tteWjjsiGtbpwtWmgkToTYnl6MDFOpFIt2TzTH/j6mWhwoF/mDT4IwYaDCw
	uuAPrWmh59MCkmHhaX2NboA3ltCMaPX67VW6tKe1DSQkptxutS1+oKHEuVYcVEUFnAF5vop26rT
	sk7b+XI1DcNgjyUsUQ4q1+UFsiGVU6LM5DaqUv/SD/3tyxc0HRKUA+VwOx1NF0p9Pp
X-Received: by 2002:a17:90b:2781:b0:398:9c00:29ee with SMTP id 98e67ed59e1d1-39b26289136mr8218142a91.22.1788515898389;
        Fri, 04 Sep 2026 02:58:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.93.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3346ea43377sm1535529eec.3.2026.09.04.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:58:17 -0700 (PDT)
Message-ID: <6a9a9639.6d09a46e.ab77c.8d5e@mx.google.com>
Date: Fri, 04 Sep 2026 02:58:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7110091127823633324=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ivan.hu@canonical.com
Subject: RE: Bluetooth: btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware
In-Reply-To: <20260904053007.667472-1-ivan.hu@canonical.com>
References: <20260904053007.667472-1-ivan.hu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7110091127823633324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157596

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      21.74 seconds
CheckAllWarning               PASS      23.53 seconds
CheckSparse                   PASS      22.79 seconds
BuildKernel32                 PASS      20.50 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      379.41 seconds
IncrementalBuild              PASS      22.69 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/704

---
Regards,
Linux Bluetooth


--===============7110091127823633324==--
