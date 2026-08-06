Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01E395240
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002496; cv=none; b=jHZjvExK2x2P+tKlV2DEqNwSDJ6EQuq+wjIFMTvYzColTC8TBhN/rggM9sEZjAep081SGOEX57Tr9nOgqAXIGGx/0GMbvj11pQ+yR1t+OE97CqAZ0f7XeLTkpeygopnTi3pmYQpsq8beht7o/DjnE7IomjkB0dy2cE7i5qM7RjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002496; c=relaxed/simple;
	bh=Q06lwN35W0WcKA7Y2396KY11Fj5z18dLpFIS19dUM44=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OuDsHiQBiy/MURKJLoV5GDDPTQ9EZYbDilRDAaneHcd5GqveKF+/jFdGqYIcjd8PIZG6a+DfNKZW5pnO9jjTk40HNXyrHlS58po4p8zUmNrWdjwYhw181vbKFM3od/BlKsRn0AbBaziARsrvrD/STBLGZf7zGN4WCj0ZOkZTJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lvz4wapQ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvz4wapQ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7ff05e5d009so22697637b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786002494; x=1786607294; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1eQNlYbY2Nbic/4Lu7MlRYNAaPatjih/XHMnauhCWRg=;
        b=Lvz4wapQoQvYGvttkkySHcaaJvHRi3hgqPGwub3qR75V1BcWiIxgW2W50pOLcZ8aWY
         u22AE8HjVYkotaG1AxMcYByaugPLPMDuqI/elZjOQK0Qe47Lw9gT3eU4H2H7Ywk+jJOQ
         G5Vt/S+WWXCKbCULB6emeCuQAh+DZ/XbDQNF+2U3Qb7Kk73QsMScyMsIfHnTCBUqjE/l
         70tulj6TQLP1nOoLy6ARUS/9u1j/4Nn7UypaWBidSP5YYtn8thscsmoLhZSVQVyYz4js
         /j3v5qQw1s2beQXZvATLovlQXfUwvZIINtEuepWve1H2pdQu/Em4NGFzO0g7e+OOqgb8
         OdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786002494; x=1786607294;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1eQNlYbY2Nbic/4Lu7MlRYNAaPatjih/XHMnauhCWRg=;
        b=qGxsAhKDWAy34WStywrTcxwLjnHiLwbtovWCwy36lJYdfFbHLE14WPrvMllzmEoHdY
         dsNjFG5SqW3FsTiS1U7f+ZFGCm0GfMJhvQDSTKQyOHlEaEBeeiBuc7L6AM/zGux29zva
         E1SiFsB8ioHb2ohNsHX9d+M2W7hInUajMtPep0DsGN5nJVvdvpvi92EqxwE/SDMglk5t
         xjIm6C8yfvmYxs2Phf6nVK8cRUBKLqAZ+j29SUM7avwYqzwwaQ9k9Brm057rpuUiP0qS
         yuQNPPp5JxSCSI65MvAsfURpZbb9/0Y2mNnWCFOC3ExWXpiRw8yklOGPXPOTo8L3ORpD
         WrHQ==
X-Gm-Message-State: AOJu0Yy7cRgvLhuqj7igwaA9RKzDolTKnOKEBOKSS1LI5rH4VLTmLVQn
	Il5ptBVq3lAnhR2qkv9G2/TQ9okC/GfZat4Xoh6Vy9FDfyQxFthvQWGAxOqDsQ==
X-Gm-Gg: AR+sD112XH2Ly+yLwUHTK5dE4NOq+gwb/8IKJb7SfZlWyQMQwcpxEx970r1rcsUBkOS
	BLk++tz8LHApnv/EuUT0i2POG4oAlT00zesXjhm4Lk/4/Dp9+6UtE4vhryEL3fuKwshQUomSNFv
	WFKlXAdiwoPsw/R/QN6612HOVPska63FwqWrrqLmxvJW4meE3HQbnv052dzHi+/yxivBYVfKe6p
	O2Pzupp6rKbbTqRCmgj4pldgA6/kMLalFgMIyLUb6QL/2oVDBtHDwVEWVhzheO46db0+c4g4JiS
	9coZmtbxheuotUbx+JMGWzXH46s33pA8ZbZgomHnTbQq0imHmwP1wsygm7GCsoxw+LFerWdUsh4
	lp/APsBO/nPsMa9LpdEiU+tKc/36HsAF7iWsR9TgU3rdTn/avw5JG467X5glzWuL3DUH7yZVh4f
	F516DkZxiy3LXEjaJT7XaW0/UGP+j0ObGXhEDdfqfMo1k4pPEz7vq2PaOzEpq1m4HM/D5X9A==
X-Received: by 2002:a05:690c:6081:b0:7e8:a091:6c4b with SMTP id 00721157ae682-8202250b677mr70200237b3.24.1786002494291;
        Thu, 06 Aug 2026 00:48:14 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.200.213])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820132385dbsm34807207b3.16.2026.08.06.00.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:48:13 -0700 (PDT)
Message-ID: <6a743c3d.37ff367d.260749.ca80@mx.google.com>
Date: Thu, 06 Aug 2026 00:48:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4693065933394421474=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaojinming@uniontech.com
Subject: RE: Bluetooth: btmtksdio: fix deadlock in close and reset paths
In-Reply-To: <FD5D03449312D17C+20260806-btmtksdio-deadlock-fix-v1-1-3a2d4392d117@uniontech.com>
References: <FD5D03449312D17C+20260806-btmtksdio-deadlock-fix-v1-1-3a2d4392d117@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4693065933394421474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1141212

---Test result---

Test Summary:
CheckPatch                    PASS      1.93 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.87 seconds
CheckAllWarning               PASS      27.42 seconds
CheckSparse                   PASS      26.24 seconds
BuildKernel32                 PASS      24.28 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      452.08 seconds
IncrementalBuild              PASS      23.62 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/538

---
Regards,
Linux Bluetooth


--===============4693065933394421474==--
