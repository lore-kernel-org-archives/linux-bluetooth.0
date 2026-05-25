Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAA4355F41
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733573; cv=none; b=VSwo+RjUzP/Am735e8KUqYjOWtoLiVTQKQnqq/cq9ipIzyNHVauC03IkvjMe2bdAbY+n5m6kYnYinAZgGDph7KzwEAwehB2xEpa8RqpIkGcVm8Sv2EBzORobbeyQC9aCrllh5secQfV3gNa8sxc7hVRgXdyDQkvQJ9DJJC+sPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733573; c=relaxed/simple;
	bh=TwHuepQBYLWTDLvRFfhFecJCYijF+0YCg8diQne0OCo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ehGksDkAEJJxDYYRXPlRKS0tLW8VESQlmnvZsMdmQ8NnPWNZU56ds6BNmKeUKWt477R8SU4c7jFlceIwakAsvxiHj447GqcZbNoDXeLVS06qZnwySEzTsUpKtZqp58njrQfgFJssFSTEKoTgWPRodMm+uOwwyVWDkatJDD2rbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL5uSOWz; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL5uSOWz"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8c7154725easo113714046d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779733571; x=1780338371; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yuy/1noDCgZFOJb34T8mCtmt3/Sy9Run9SdNtzXD+ic=;
        b=IL5uSOWz6BFOvlM3yWSMSCJcCqGMSEZMMZIMVIKLp0ckhgdq1qzbkOtgob6rnTnOpp
         5wQDMTpo7mG9bbUaXMOk82pzROn++YA87oyPXIjAaIXKj63Iw+5VjJ+e7PzfGXjqRH/9
         NsiNmVwpbbMZ/x05gGIgPf+U71FhKtckotKxCg/eAFdApQdXFlJjQEzO/s6SoIVZCLHc
         WzyO4d/oBxd9hFwGb7ZIij4xnnhnAFdu1+iU5MEb2hlix7NdMhzcgXSBtDKDkuFojFts
         8TK6jjUexug2i0g0hUa1/TLzlPyFH/FvOrq13stQFfv7CfmksT8Wgbaz2NnkyAMGLpHX
         BYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779733571; x=1780338371;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuy/1noDCgZFOJb34T8mCtmt3/Sy9Run9SdNtzXD+ic=;
        b=PCfOdgDsz44aHD0ukduKRnvETFotODWyNNaSE+juuYTDJeaxYFwa2TPLI2E9DQ5cDO
         LjA383gmQ7ax9LtTZyn2e/sJhqBczGMs2fes5P4Jv5n3gYv7VoKIXaQNnQNhE8E+6dMt
         k48BYptQaJI6k/+789R8RR+jUKV4aUiGzpIeX97hvd0oaXw3F45ZYI0g9xH2DruraEay
         H0DP3AzUdBXUC7Quhd0BKh6MijHLblABp1XUQmkBxHmnB5/kVBkOYO3CBPhtEePApNjJ
         d5uJedN5/s8wFDFC4wNHgaApcB9XO3Aae1g1oFw78mTgLu3MMCMAk5lLC36pmhamO/3r
         70Ww==
X-Gm-Message-State: AOJu0Ywd0GuB2czZKieQJ8IdlbMqi3nbQy6TyYIKFhEhIvWK0vJ33kIP
	1byE7kcT4852blXrA51Ojg96hVkXhCL4ZtcShWL2w2EV8ZFndB2K15vPZPjUSQ==
X-Gm-Gg: Acq92OHeozLR2Bn/Cq6OYHCFCC/qfMat6iT20KFrbZKzw7S1TyfK1aaLxWlEan1+89J
	O7/9EfNT/409Wkpk5ZvjHuw97y36VSgV6adspfqLJSZKwMGEreQjnivOMhCXcq3kF9hKowaLYG7
	LQNw7pmw58UMELNGSRHDlnssy8BvxmVbE3TLig7C9LuIuPcc3YI9ipOxKhM7aP/OIldKWxZ01vV
	bK4NsIULLaRp2hhCARiJjscsKLpoYPiRExXHAIm5ILqDesNAVV+Lyj4jp715lT2EhEPkJrZa4Ib
	/hCq3vDasl/ISbU77M7Z3xyZ+sZ1bQ5wEjk+o5Tf+DdfyOD2F6eH4w+NMT1bQ7QU0xUJz2uXQXO
	KBvaTXvVfraA5CwNH3Ut2UaHJNEZ6X/M/qrKjhBnGU31JTLvDdH1ROf6dQP5Bh3TfiIzDi+BqnR
	AghBUtgNu0ZD9sBj+awyoeif+i5bH5I4veKc1ef70=
X-Received: by 2002:a05:620a:6404:b0:914:ca75:e8ba with SMTP id af79cd13be357-914ca75eb1amr1275928485a.52.1779733570889;
        Mon, 25 May 2026 11:26:10 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba0deadsm1137291085a.42.2026.05.25.11.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:26:10 -0700 (PDT)
Message-ID: <6a149442.d5c1a6d7.dd8f9.f8c5@mx.google.com>
Date: Mon, 25 May 2026 11:26:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3416788977274846920=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zenmchen@gmail.com
Subject: RE: Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB
In-Reply-To: <20260525161942.5206-1-zenmchen@gmail.com>
References: <20260525161942.5206-1-zenmchen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3416788977274846920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100543

---Test result---

Test Summary:
CheckPatch                    FAIL      0.73 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.17 seconds
CheckAllWarning               PASS      27.61 seconds
CheckSparse                   PASS      26.34 seconds
BuildKernel32                 PASS      24.62 seconds
TestRunnerSetup               PASS      521.83 seconds
IncrementalBuild              PASS      24.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14593507.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/238

---
Regards,
Linux Bluetooth


--===============3416788977274846920==--
