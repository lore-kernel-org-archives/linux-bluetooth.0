Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770D39A4DF
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508189; cv=none; b=ltX7LGq3oBbfnKe9C0FQsJMcJeHM26Lx/k40oIHc5REfIFIBUQAqspLhbHuyYDHC0FeF5qPq/c8eBbMCkP+ZXPyb+uJyd1nEicz13/K5lmsgOJCiFU0W1uzZKIOPFu0Iki7gBTHdrpKzNQ093q6Wea2MQw3vm5JlOTzZaUbUL+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508189; c=relaxed/simple;
	bh=zip59D24NG345DvghJv+yanOIuKVhHuO8iFKaEnRmmw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r9KrWgXn0rPlpAic/v4KfRmjG4meuhdgaNTIh6ZruF0YGPRVOXAyBiDszxhOJRr5YK2P/Sau6xe7s7wgmVEv4U15ya9IDZB/+rbjjfnQcrpxgC72jmk9h1Nr1ZQS3AJTs+cqyBKlrtP/rXYtVsuueeBRJmSB/gcZjrYV5hnViJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5cvDH2M; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5cvDH2M"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91574384cc2so326859585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780508185; x=1781112985; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bBuc2+6hY8GY3uPPzBSthp0YQeoDeXSbW2/1U5+JhK4=;
        b=i5cvDH2Ma8nOgjCFLi1ucLoZZWUxe/39oIdHCtidbXGgUO0/D8ZSW6AOSggu6ovLYP
         UtqYbe/aLPsjBaPGuclK1vakbwfsAd7TuO/qVNrXPGzZpsff0n2PMjcyXIZ+E0l6Ren6
         nCsKMqPnFyEApVr20NQ8wGBisQdvLjbL9KX+iRcwu16J9BY3nDbCkYdhH2fj4PZXav88
         T/DqFNExqppboUSZmwRTRRPI6yfQ3k8nJw+NTz/JY9bd8G+Enk2wDdEpuRm62yqs/xNt
         GVswP08IvJ2pjctoVYMgubuCIgfvSLbUxfxbBcIGA5HiqPztcTIEVYoahurJ86L/tuCt
         qLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780508185; x=1781112985;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBuc2+6hY8GY3uPPzBSthp0YQeoDeXSbW2/1U5+JhK4=;
        b=EmVLTSuOQn1NxDce4rpCPWoglsSJH6CWb7sAriPfY5A3Ddq7KJheBPMLayNP1TAtxd
         BXDUdn24LZSwU1WIhJIPyHWOb437+l1nGt6YWtFpD+1l2dpy10wYRQMY2r+k1VqoJXZf
         vT3OuQoh8vDgS8AATgH4rIwG5IeghQnC4NqVUMdU8sQRE4pVyGH/z1VVoCYv2y9/PYPQ
         aBt98myadXkU5aQmLwKvsgCf2HE2pGoz0qhvXnbLCeQn//moTjgDlYFTye4bE+/gJ3qB
         kdM/hFGNJjsiV2pyT5a00hedTqzF3Rr1h381pSKrqDuXIlJ9uRQzbrxCvyxWdHYml7w/
         VGIg==
X-Gm-Message-State: AOJu0YzorBFsobdHaWRwgTBRip/a+kxiRglPju+dpAuEXw2en/+sxbeC
	gm/zKiGF8NrtErANA+HzKDyc0UMxcreDfyq1k9xwDpNV91QxYmMpSjrUwCqABw==
X-Gm-Gg: Acq92OHh0zbUZs/z2nsiHNQxJSwDzloI9g3s48VXZZaHRi1UVWobFoqp98cTM7OSbpj
	PtXKO4AnIGJSGxMiKL249/Pmf7SgBlpKSb+Y5IYTij9zqy/IKYbEeQfo3MGAdLW768XSFtNxPE0
	rl032OKtSnFvgvvGSD+/pCZtojNwhZJXu/QrII9U7NjT7WSIoL9NIusd5+6cFa7Hw3sdyGYpPgs
	D5wMu+n5rQBefioveN0sKcpnA72baB88qkjnmtUBsFuk0/qiSO0+d5oBo+RT6zTC41jIGVbm9vw
	JhWY4SRYMjQvTY1KWlblZr5X3ErkC3CB8m0D2YXeIdo/2Uzrf5TxleQ4avUcLC4iQIYVL2KCWyn
	PN1HlWXuzXofCtmh2AKp4qRZMpkmT7cB3IKSnAgEX95nJUdg9odWzloSuwBRnj9Tz+Sf1mdYPRm
	IZHZhXWpj4bVwSqh9pDCn/J9sMtUyGKIfak1XoIrsE3xE=
X-Received: by 2002:a05:620a:6cc5:b0:915:86c6:8433 with SMTP id af79cd13be357-9158a69758bmr751828385a.14.1780508185094;
        Wed, 03 Jun 2026 10:36:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.125.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afbcsm309880885a.9.2026.06.03.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:36:24 -0700 (PDT)
Message-ID: <6a206618.42a5d9b5.12dc9d.3f8d@mx.google.com>
Date: Wed, 03 Jun 2026 10:36:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8637908080758186207=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan@kernel.org
Subject: RE: Bluetooth: btusb: fix wakeup irq devres lifetime
In-Reply-To: <20260603143643.2514595-2-johan@kernel.org>
References: <20260603143643.2514595-2-johan@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8637908080758186207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105369

---Test result---

Test Summary:
CheckPatch                    FAIL      3.64 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      1.87 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      25.55 seconds
CheckAllWarning               PASS      29.82 seconds
CheckSparse                   PASS      28.84 seconds
BuildKernel32                 PASS      26.46 seconds
TestRunnerSetup               PASS      529.51 seconds
IncrementalBuild              PASS      34.26 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,RESEND,4/5] Bluetooth: btusb: fix wakeup irq devres lifetime
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 699fb50d9903 ("drivers: base: Free devm resources when unregistering a device")'
#82: 
[1] 699fb50d9903 ("drivers: base: Free devm resources when unregistering

total: 1 errors, 0 warnings, 51 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14609619.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,RESEND,1/5] Bluetooth: btusb: fix use-after-free on registration failure

10: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 2.6.27"
[v3,RESEND,2/5] Bluetooth: btusb: fix use-after-free on marvell probe failure

10: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 4.11"
[v3,RESEND,3/5] Bluetooth: btusb: fix wakeup source leak on probe failure

6: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 4.11"


https://github.com/bluez/bluetooth-next/pull/282

---
Regards,
Linux Bluetooth


--===============8637908080758186207==--
