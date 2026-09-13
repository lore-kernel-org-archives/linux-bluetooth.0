Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE838655B
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335689; cv=none; b=IprOF2O0OyGiyhjjavsTXgP8milTbyQV+DZWKdheEU7xpzSd5JTIuM9l7un2op83mj4iUi/XV9ko/HxZiquSlLOtXl99/VJO88XU3fLFOAMHTzi3kGw5/dH5WAehvv7XrgwoT6yoHCkc5To3yblkVl7j8lpZF/isMuz7rt8Tgck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335689; c=relaxed/simple;
	bh=MbCzdLsEjQnKwHx6kTgKlWCWfvEgvpEdE5aVPYHov/o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rNlndL1s0C90c74MEk76kJNZHmybQQeK15KZT2oLDAbwbeUC2bKZcT0aiw5I4bl1m2cuJAyihuXCcbfkyiGw6QE9flsGCI8/BrPWGe2cXcQyX5BoWTYBnJ5YfnIuRxFnFqo2n+ECd77B9budBeZuaoGyiWlDYKdwmetOT++sRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/ZRB1dq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/ZRB1dq"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-530f04a0cc6so9364821cf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789335684; x=1789940484; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Oq0bdICuOSN/bHg+FsjlIb5PxdJv1r1IrVNVLTma8b4=;
        b=P/ZRB1dqSwUwFjbXigWBnV2tHAulxbfzF/9qnuKriv8XJbWpS5Z/wbO++C+Lr27Zh1
         w0WSdRJzP9JIPIf3bd/rgl678UnC6k3c/zRX3nQcvEeakBSQxEDtFnaRuLdgPadA9fm8
         AlGVIlaoO95sJt6bI9KHLcxJb3iJHTTKLmTpO+5PE83iM12rqoxcPiPj/qFrWIfCc+NN
         3O0bvE81RmRVeDkYB6bK/A3e3/FCeqs7ULcbcCmMo2dvzzGnsxN5jfR5hyGJpcVkP3p5
         uem1Tu8/pfpQrWy73D0UHrT335kvXX2Bu4Sr/VgcMeDbuCqBsPRXIcV6+BcrgSFP11C4
         osZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789335684; x=1789940484;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Oq0bdICuOSN/bHg+FsjlIb5PxdJv1r1IrVNVLTma8b4=;
        b=PmEpN9kV3v0QaqTkRDwZvtZp/6vbI/+BzBTbSn1jzyB5DmExRcRPQggb2Y+v1TUaYW
         9e1Nc+8PMy/QSRy0sxPNSz5a/gi3/fXUlSDDZeR1SgJo/FEXHtKCoU31GMIh8DLjXkqA
         FS7r1GW1QXZxigCLLz14oYuOFu/pwbF9yecEFELmy+rcqDrYWjawQy8Cm/wun1BjD6Vm
         XHmm6X3svQ0W+AWEvXMf9LE4ryyMipSC+RqLjEWOMdW37kRnKoc9QWSmQCfmPff7rHFs
         ZduHdR7zLMVn82goCu1Rzq7zYTOYPuiDJ7vcarGWzlMC1l0n1WrYYh9u3l3qMLD7gCfj
         Dgtg==
X-Gm-Message-State: AFuF++n5ThovFwMe7g0kofzn6Lt0rdwlfJyoOB4+l018TdXf4pn2JLgr
	MYHZWPc0qSTQNu/NoB+4Ksrpd87G+nPKHD0Avaiw6x/aiYa7bbqrebbA/yFdwA==
X-Gm-Gg: AYBFou2a63l33zmRSYjIFfSL8/ipLJetEwazC0xWb923FI12Fi5R57fxwIT1lDWUqfl
	0hH/IwIj5IOBd7JVx4tg/AbQWBALjGlQpmpLdizfm0Fnvbf0xJaZlrinu8P+QhoICi3ccXvGzMq
	9srhTgtIyqInrjw9ltvtB6fHPGJXN9OEyLy6EP/6P91+69oAuMEOTYlwdNw4Hd0Eyj9TQMX6Kl9
	wu5czjppVbONx5+8yKORRCykGdJDLcnQ1LRpT9wZ8MjG7CotnPTc51KpsdJ6OZ6LDZYVlFw2QE8
	zdnW2gcDs+hJPpJOBwJLW+ao3lNcB0nHA+ID3fvE308ARhf4bgeYZSzCN/z+F9x0y7hL4BC/5P3
	8AOoO5C6IwZVVWatTBYuceI02hTwshIFHY0PcdVFsYdNq22EvncAUKvWAYrRWf/YE1LvLMQFl1x
	dUlVfCYGi/M5gv+NfIpYmvwbRO8fMoKJ3yhM23trdK2ocmIgB3hdLQR2fIjYVGDl1qTMGkFHEhV
	DpKhg==
X-Received: by 2002:a05:622a:1316:b0:530:b2e4:91be with SMTP id d75a77b69052e-530c87a5865mr222287101cf.55.1789335683844;
        Sun, 13 Sep 2026 14:41:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.213.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530fa03dc30sm26776331cf.15.2026.09.13.14.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:41:23 -0700 (PDT)
Message-ID: <6aa71883.67d903fa.13fe1d.42c9@mx.google.com>
Date: Sun, 13 Sep 2026 14:41:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6669361094325302593=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, radek@podgorny.cz
Subject: RE: [v2] Bluetooth: keep dst_type with dst when reusing an LE connection
In-Reply-To: <20260913-for-upstream-le-conn-reuse-dst-type-v2-1-ed1d5dd4ae37@podgorny.cz>
References: <20260913-for-upstream-le-conn-reuse-dst-type-v2-1-ed1d5dd4ae37@podgorny.cz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6669361094325302593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1163972/

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      6.25 seconds
BuildKernel                   PASS      28.71 seconds
CheckAllWarning               PASS      32.20 seconds
CheckSparse                   PASS      34.54 seconds
BuildKernel32                 PASS      27.86 seconds
CheckKernelLLVM               PASS      33.63 seconds
TestRunnerSetup               PASS      778.92 seconds
TestRunner_l2cap-tester       PASS      44.25 seconds
TestRunner_iso-tester         PASS      83.62 seconds
TestRunner_bnep-tester        PASS      12.97 seconds
TestRunner_mgmt-tester        FAIL      143.33 seconds
TestRunner_rfcomm-tester      PASS      16.58 seconds
TestRunner_sco-tester         PASS      21.83 seconds
TestRunner_ioctl-tester       PASS      18.24 seconds
TestRunner_mesh-tester        FAIL      18.82 seconds
TestRunner_smp-tester         PASS      15.69 seconds
TestRunner_userchan-tester    PASS      13.63 seconds
TestRunner_6lowpan-tester     PASS      15.98 seconds
IncrementalBuild              PASS      26.61 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.143 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.271 seconds
Mesh - Send cancel - 2                               Timed out    1.998 seconds


https://github.com/bluez/bluetooth-next/pull/760

---
Regards,
Linux Bluetooth


--===============6669361094325302593==--
