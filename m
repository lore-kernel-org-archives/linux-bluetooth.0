Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406E19F11B
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776744541; cv=none; b=OdR0IGg6UpAJaWkVl/OglFPFF7Fd11oWmyjMvSCzZlCFwJfe80HbJbenSVo4yVtMFejsT8sx7EowLDQcd6ouVr2dVFWvQb09s3DOy5p8qA0FxNczMgx6yFdXL0xP4yCtkN5PgkhdVd8dJGcYG/yW+16vrgla/gADELTv+JXCP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776744541; c=relaxed/simple;
	bh=oCWHWz4bmL83jDgqY73WGsflPaZ5mv63OU9FD+M27qI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OHvdyye/9sixCpeqq1UORJZ5K8MdagO/UwIasicrcSADGgcSy8v0idqAGMl2K5CGnwNmD2dDRbsax5XAIT4mZN9Mtai4Yg721sAqotUHF/PRU9u0GQ/LSVU7FlrGbs8v2IuuZFLtjSwnTk6r3LRMhfV9RJY/hsYxddUKIjd5WZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiZe86QU; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiZe86QU"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4102322eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 21:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776744539; x=1777349339; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XbyQCnfTKx3gnKHNYEXVixFYhGOwndCnRihz/NnDQMs=;
        b=iiZe86QUTmGmZ5wIrV9Iz/NbaAVwfqpUkhUkvj5KsLNRqC3hJWDwDZJQwjZJuwYgDq
         4T+I5uxTl9ZxhsAuOmqcHpI51eh5WKFubtIFkmtSoj51iGxW2s3aHj4MLFzbUjsQa5Os
         1yCk9rwGH1qj/3mmDSiydEFSnifqJSVwOuhsms6O/ENGGwHZnEAAgLnm5j6FhAauwQ6t
         wX/jiRwfgNVs5WCpW3ayWXkV3RGBVu5DM7zevmiyfSrahw68b6HZqex8GqpT6Zjnu6Rs
         eMQO0boresc861VqmRChwauO8O8O9rbMr+L0KP4M6bQoXZ6M/rwffSFt638EzCyi6UL/
         z2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776744539; x=1777349339;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbyQCnfTKx3gnKHNYEXVixFYhGOwndCnRihz/NnDQMs=;
        b=KEnEu+Zu6ZwRlVG87RCbMjSHiV2qZbzl2nebeLpBiGYIGdkb+OOR4qanCVS6L+umfw
         OeKFsBLHg1dYdsAxmpTFABNqYBFqW0SV5fzF0w+Mu5AjuSPT1WP3LQ6wpqVga+kw1smR
         Hq4LcVtNBslg95nfebzPiLnPjYcAkJoF/OIYCy9CzAyGvdGoAIjd5ErLFowFXNAsRl5K
         sef00KEjx/m6DVRT31yYVDAzw+qfK649us93EebMXCsaBY5ib0FZb/80CRKtzuF3pnJ7
         Gl1geYG/diih0gGrpgEa61zdaaSTlhMfVKs97Wz8ko9nr/ygtSur0aKnA7if4mSRDqqP
         Au4Q==
X-Gm-Message-State: AOJu0YwYO3pdqPetVwQmyOnie2ovBh6Mm/30Usl7AE/KTgizXHGmew+t
	+Hg4SpjRqyklFINp+ENbXVBHfwNEoi5waiEN0VLIx+8ipQcJa5ZCv4SoXTANkA==
X-Gm-Gg: AeBDiesUmySyVDPAznk2lfmS5Ux1QY1jQ1KYuPYWRhKMTBuDw4SsL5zPtUi654xY/Nh
	JwxGhHohB9Vq1cSq8eeMwjLMJNcoywblPg14ntFcHepx1CGXMnhgzis93i966tPkpr/KplY9B2h
	lDjqkWTDHmKKhODDym1q0f92JRvOPyJHy45TZAkIMi6pxX3KIVBzA/P3ja/ZoBu8oSJtJoxmlz+
	t5aobExYdJT49VjRDlqKPbiU1lL67vm+uK7LSEAlxHBETgWB7dQmAk3pQ8gvr5oU0KMMR16KjaJ
	PzgSOGO79vhcskPqM/p3liphU+JmbcaeTDtDwbWsci9c40L+GnUlNEwFjaFiWa1KJyXRvPOnfFF
	OIFrpi4l+ERr8t+D7fAV/WsPfNdFUx/vHqInOiVNduZtSEWPDImtg27MGOSJNzDrXhftjndEig/
	tQmXyGbWWigV+wsJ2iYjKyvWaSzdSdKDJ60FP2OG8KGg==
X-Received: by 2002:a05:7300:818c:b0:2d8:b2e1:20cf with SMTP id 5a478bee46e88-2e46538ca36mr9220477eec.10.1776744538530;
        Mon, 20 Apr 2026 21:08:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.46.213])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d4bdaf7sm16902722eec.25.2026.04.20.21.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 21:08:58 -0700 (PDT)
Message-ID: <69e6f85a.050a0220.66d6a.95ff@mx.google.com>
Date: Mon, 20 Apr 2026 21:08:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3989212575598859612=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, suunj1331@gmail.com
Subject: RE: Bluetooth: ISO: Fix KCSAN data-races on iso_pi(sk)
In-Reply-To: <20260421025122.55781-2-suunj1331@gmail.com>
References: <20260421025122.55781-2-suunj1331@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3989212575598859612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083591

---Test result---

Test Summary:
CheckPatch                    FAIL      0.93 seconds
GitLint                       FAIL      0.37 seconds
SubjectPrefix                 PASS      0.38 seconds
BuildKernel                   PASS      20.60 seconds
CheckAllWarning               PASS      22.42 seconds
CheckSparse                   PASS      21.78 seconds
BuildKernel32                 PASS      20.58 seconds
TestRunnerSetup               PASS      419.00 seconds
TestRunner_iso-tester         PASS      26.91 seconds
IncrementalBuild              PASS      23.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#134: 
race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by task 549 on cpu 1:

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14531805.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#156: 
CPU: 1 UID: 0 PID: 334 Comm: iso_setup_race Not tainted 7.0.0-10949-g8541d8f725c6 #44 PREEMPT(lazy)

total: 0 errors, 1 warnings, 0 checks, 137 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14531806.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
31: B1 Line exceeds max length (88>80): "race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by task 549 on cpu 1:"
44: B1 Line exceeds max length (100>80): "CPU: 1 UID: 0 PID: 549 Comm: iso_race_combin Not tainted 7.0.0-08391-g1d51b370a0f8 #40 PREEMPT(lazy)"
[v2,2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[v2,2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths"
53: B1 Line exceeds max length (99>80): "CPU: 1 UID: 0 PID: 334 Comm: iso_setup_race Not tainted 7.0.0-10949-g8541d8f725c6 #44 PREEMPT(lazy)"


https://github.com/bluez/bluetooth-next/pull/108

---
Regards,
Linux Bluetooth


--===============3989212575598859612==--
