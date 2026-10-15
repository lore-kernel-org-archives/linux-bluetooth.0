Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FABC52B1EC
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068118; cv=none; b=mdLi8+nvifuyCl9T+86Z/RcCYi4F+69eSuM7/tNNiuozpi1swoKVsemhTJJj5x/hQ7gkc3df2eiNZP8V/9DdL7jnXAFxgDnGZZ5ZWtR37bCAbawaZLyRWG7rZHdRA9Kp7mm8G7HCgULaV8Kluav37LOloCZj8VX9rtHXyws7ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068118; c=relaxed/simple;
	bh=Vi1rGMZs+0IihaM7dsJPHW/H8ZxT7I4eFg/ajFlsUQg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jyuyfK7CB/5U8TKSJRqhuXLPAju7TOKwiSOc8SB39oMgBgXrLAHJx0dd2B1hIyvFyoZMN1Nw9QJAcvZR2WahPSyGA3VFYaa8jJqniNCoZm00Dv2unmmRPUaP4PvfftpUEkulCu9L0vZN1/UpYJKfJpTLIw7SbPmdDxa5VUokzRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N65hsDQ0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N65hsDQ0"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1c9879395so2056408a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792068116; x=1792672916; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jkf8i6eLkkA3NFegDqV2uGtF/nXHGGLG9hiA6eN1FCg=;
        b=N65hsDQ0s6mMlm+rOpMQtq/4yotAQHBWBqYka0s5R/g9FABuUhJmJRId+D8vPO8sOH
         vgQdBwrtuSt3nNOjUW+eQDcJ9F1ad6ifr4ADpjzHARWuJgpYOrBQq40Gb4v5yuv3t//+
         /baujsY2eu4TD+hpVlSxy3a9ZCjRbBZ5xCyx8hpXEOYkcOjepav2yXKkHQa5rfbc7EYq
         hwej4YQsMPFRd/GqOGbnZC0iyvWYJD6arNF5OFeAHoukjRuvcr6WtXh0keeyUS1Rdxmy
         Yoi/37f65DrfPld0nlT7BMT1oRWhWIlpvQss+cBEiMxh5p5o/fPSwgrq2OWxg0vMcXVT
         THBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068116; x=1792672916;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jkf8i6eLkkA3NFegDqV2uGtF/nXHGGLG9hiA6eN1FCg=;
        b=2KnS/RoLL52OhDiYrgJssvDduTHFw3y+Nl9pZjeQTTUrymUYJiQg3K5gQvwpHIJGeR
         ydomK+nt7Sgp9cm2DfrxXD7M1NAIhrz+U5WnIdMzuLsQNjC7Y55kZPNvqXYzFvveznS2
         LtIdUkNpS9EIbsGBNLQVQTfve0KepGlrGI+cTzxeSSyKX2Pv3uKVsIjac2mrzohUwfKV
         rrxbBT+O4Su/OGF55wsadzpNXL8EoWWISVfLov+I17la9ihb+o9Iu6n5YhxFZt8ztynn
         jEVle1SQfaZOXKClYD4CPf4+WKaChhTbKAkQCj06dSjPMbktxTuEgtWfOMxtsNhztEZm
         OIrw==
X-Gm-Message-State: AFq9FYIa2sjquEf23UYHXC3WwysqXflw+MGugM9kR+MnV/Mktgd4gMkw
	zAVYmNFw515V9EhXNNvlmyj64B25MKCpoMWiwe187dv1YOhMy+ui17hYYM1tTA==
X-Gm-Gg: AYBFou1p4lQdheP0g73QkKgX7tnJRVS9WNo1rJxbsFxtBKJJkmtrbsf/53NMIh3fQwn
	QUqwgzvrgCYRWU3gMH7i14IFYvrIcPcGgGHeJey6XBOQFJhY4pXcsfKGnvEXj0wmNWTYMPusu+s
	g9FoeTr13+m6U73MD7OPXZGCMO27Dw2KqhIQoubMTrAgAVgG5Pc3aWGy2V3ERvWVwYpvf9N7kff
	zBnDHz+/FpcP2lxBh4f8etW7az5jAz/6dXlwLtmxiBD2x5OTnfWLw/o94UURGJKNoWFz1G/qUqB
	3+qqdXHArvz1nR++c4vtED4py2QL+jpAvHw4M1CDJBvwrlZU/pi0hPQEUTn8/z1EhLnz0+/G5Dx
	ko49f9xBIHJdH9/xjDlhInVg0Nk29R/2DQgW4w6D8sVLYl23PK3xfUJllT3z5k89k/T1uurXam1
	kjCHs8M5cWJPV8pZIPBbLuevwSQsk2FXs4sFX/pEDFAh9Q7Ak7wVoYK8fecqQ8Wkc3faL2GRCpV
	6wP4qOI
X-Received: by 2002:a17:90a:c885:b0:3ac:9d14:feb1 with SMTP id 98e67ed59e1d1-3ac9d150251mr1728961a91.43.1792068115571;
        Thu, 15 Oct 2026 05:41:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.214.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac92a49d7bsm1910532a91.0.2026.10.15.05.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:55 -0700 (PDT)
Message-ID: <6ad0ca13.0de28573.2f3bef.b4fb@mx.google.com>
Date: Thu, 15 Oct 2026 05:41:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1735548907315690437=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: Bluetooth: btintel_pcie: Add initial YoYo debug support
In-Reply-To: <20261015110218.22585-1-ajay.k.v@intel.com>
References: <20261015110218.22585-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1735548907315690437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186389/

---Test result---

Test Summary:
CheckPatch                    FAIL      4.24 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      29.19 seconds
CheckAllWarning               PASS      33.30 seconds
CheckSparse                   PASS      35.79 seconds
BuildKernel32                 PASS      29.04 seconds
CheckKernelLLVM               PASS      32.86 seconds
TestRunnerSetup               PASS      692.10 seconds
IncrementalBuild              PASS      29.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btintel_pcie: Add initial YoYo debug support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#377: 
new file mode 100644

total: 0 errors, 1 warnings, 485 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14891510.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/945

---
Regards,
Linux Bluetooth


--===============1735548907315690437==--
