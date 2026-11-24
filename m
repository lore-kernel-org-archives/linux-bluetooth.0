Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504233;
	b=cLwTC2CMjmt6MuzSOnx4RBzo4twFxOOiDM4QKrv2tCJFSn8iFDICbwFtOfmmIgdJJ4Lk
	 vxOca3m7ioWsxwKKeQbk4B6uk4laBbux+xQ6q/rYoiuldJ7W7eOHGA5sSUDbrw6JJ/KFy
	 ztgizVLZg/fQiF+NHea8nMcx4XrdDmVTDhlLBdn0Iee0RID+EFdxR2YvydwnRHE0PZOkp
	 nRYjG5xNHnO7MK9Sq/fx9McqDS6FT+KK9Ye20EidCuAW48ea6ORHEXqFBb2PWiMZoxA6F
	 Qt1b1hwOCproRH0rtRgY9pkIo8BeJE7p8XgCfzI1Q9JHeTupDEFnUf8dqTrmd7moNCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=aWvbjMd0OHDtjvar1S7fsnMaMVbfdsIlPpTNpyNYiZg=;
	b=dSF0N9SJSn/uMeXaXihAoup1KlHGwPVRRKOiZOm0X7nMU4ajaAUj5I90W8+6eTnZJGQX
	 031/rHxzZuO8zWwLvSjSZbDc0ZRzjy9TVAyNvkAztrSm9CDldTbtGNEa6VPwlWRznvwLG
	 N3venV9lf1WF0HGO+OAHPlP9b3Hmsy8UYHdp9QqGSH7J2iIO+dhozLaXl4dHpV5vwIBMl
	 7uNdAFQoL4Q9MgyZ27CRlsCsnQ1G5kjowS5JoN8Ks2LYOxP2d/HN37PLVo3BzRsCkyqpV
	 bxcphC4/MhznvdBahT5Cc1bot/cE1Mc7ibFbIyqYc6EnugJl1slvquVyghGMfAW+MMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmGLIXD4;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16E606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D16E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WmGLIXD4
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-85a5455bd3cso2376250a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 23:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795504231; x=1796109031; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aWvbjMd0OHDtjvar1S7fsnMaMVbfdsIlPpTNpyNYiZg=;
        b=WmGLIXD4onfis7N9QQ6YZ7S7Jj7c1NwQrayMptbUsuBbl6+4Qpd+sl7m2a5sdE18nC
         JTklw4wJVs326fcL+kGSsIKbd8Hlj8V7U+AMT0iX2rrQl7Rxq27mwhRPfZK418ej5YXj
         JmR+uyoNP+huukucg+nKquNk1AbOho6tFHrTklmKU+pxqCC/iHqkj/1BBfrUfYMXP9jZ
         1NPWPapBHteBsgTZVf7qADOZU8iUARW18fiBDDrPQh/Nrxpa3dXdoupquF+MlC9KVHSO
         3xLrwRVkKdOFKDpSij31fiOJ3kqtQada2TPoVJDwOI+9MoXsH+jPeNy/CIMo4IoZbLpr
         SBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795504231; x=1796109031;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aWvbjMd0OHDtjvar1S7fsnMaMVbfdsIlPpTNpyNYiZg=;
        b=axo5jYrUpn73HyahU8ZlMRUPG0kQ+WeBUBWR0/DneiCytTePM2Wgm0Q/zDJK0lXP6k
         /ls7qv8dzwLwNZdYznyXtPxsc8ApugARNjd/3jzsI+VZ4FVfWhmvyOa/tbK3Nsx+0IdW
         6yw/J7+5SYHQSuwo2Ey1wEvZf39Ig/PA+490hrQeUxIgDIAbuQS0sYIDZ9v5JdBGbzGm
         cX4jki7MAy6WDN0+l9MgZGyQ73G+jzL/vkGOzBEe5hn6u0ZldyGydZ5qVGPlck8fd1dD
         foW0cuc0VsEb9TiGdYODDLedQd3ia/x+MahvXiioAuGz/Cd2pbe/rMQl9zuqWOQOmF1z
         Cd1A==
X-Gm-Message-State: APuU4Z+pNDoKpxlV6oOCMUDIiUxnnk3IjbHwUxC7W5tLcREH16nTdmIq
	FQokGF/4ma1+3MwQLYlZ/rjTfgxw57MRvMsgveMcmCmSHbh+BOsX+0vKp9qV9w==
X-Gm-Gg: AZFdTZegNguaFcTMfeXRtUXltiNASuVSqXKXGXC92qH7USzTJqRoTLW1GfYjPbsyPDH
	QbDoi2wFXu9Qsj26RNUk2FKHWvwl3vUP7vh9B5gLxkwTPyxL6IXe4+J/+TDu092OpxK9Vfn7yY9
	zaK0R0CPAB8Kp67kDcPcWsUkj92qqbkK509HeJGbZeLDgAguMpt5rDt7EiCvJ/TEKRRRXgC1hJB
	ByaQMJTtVdr7FUZkmh8QS9CPyrEUSyb59op4IZm5lTOG+nNc1hh7cDn0I8Yn0sOqr5NIyFqPw73
	AdeMRhIBSKyytXE7gqZRef10bJOnarEpxrCpShRdT8PILZ18Hnw57oiPQrz5Qlv71gCc18Z7fF0
	LKlpgllgpjlaDbbriU1ZYwlQ/DeKpFRhxcChNQDgwyFuB9nxhBbKFQggsnkO32rltn0yysMqdXA
	tjljbH+HSnszbsExBCEKWLtAIOSrXtkX9sDB6ansokUwdTbkb9mj+Mw/Z+TXfD022OnYQSZbldS
	PqlJNkLVVpz3FHv8aMJEw0H3oYRKpUtz+j6ZDh5jG/7PsM6RguAZehsu4DUeJgkHQ==
X-Received: by 2002:a05:6830:2b06:b0:862:ca2e:918a with SMTP id 46e09a7af769-863159af93cmr15247321a34.19.1795504231396;
        Mon, 23 Nov 2026 23:10:31 -0800 (PST)
Received: from [172.17.0.2] ([52.183.222.228])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631692d9f7sm10690545a34.24.2026.11.23.23.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:10:30 -0800 (PST)
Message-ID: <6b053866.674ba918.33e30a.4373@mx.google.com>
Date: Mon, 23 Nov 2026 23:10:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2471775805993016625=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [v3] Bluetooth: request LE data length for MT7922
In-Reply-To: <20261123233502.222664-1-cochcoder@proton.me>
References: <20261123233502.222664-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2471775805993016625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220185/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.46 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      29.14 seconds
CheckAllWarning               PASS      32.88 seconds
CheckSparse                   WARNING   35.15 seconds
BuildKernel32                 PASS      29.21 seconds
CheckKernelLLVM               PASS      31.26 seconds
TestRunnerSetup               PASS      676.98 seconds
TestRunner_l2cap-tester       PASS      16.66 seconds
TestRunner_iso-tester         PASS      14.91 seconds
TestRunner_bnep-tester        PASS      3.05 seconds
TestRunner_mgmt-tester        PASS      87.78 seconds
TestRunner_rfcomm-tester      PASS      4.39 seconds
TestRunner_sco-tester         PASS      5.49 seconds
TestRunner_ioctl-tester       PASS      4.54 seconds
TestRunner_mesh-tester        PASS      4.40 seconds
TestRunner_smp-tester         PASS      4.27 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.33 seconds
IncrementalBuild              PASS      27.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: request LE data length for MT7922
WARNING: Non-standard signature: Assisted-by:
#104: 
Assisted-by: OpenCode:gpt-6.1-sol

ERROR: Unrecognized email address: 'OpenCode:gpt-6.1-sol'
#104: 
Assisted-by: OpenCode:gpt-6.1-sol

WARNING: Non-standard signature: Assisted-by:
#105: 
Assisted-by: Codex

ERROR: Unrecognized email address: 'Codex'
#105: 
Assisted-by: Codex

total: 2 errors, 2 warnings, 0 checks, 103 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15014728.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: request LE data length for MT7922

30: B1 Line exceeds max length (89>80): "Changes in v3: move personal correspondence out of the commit message; no source changes."
32: B2 Line has trailing whitespace: "Hi Luiz, "
35: B2 Line has trailing whitespace: "ahead and prepared this v2 quirk patch that "
37: B2 Line has trailing whitespace: "Thanks, "
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1206

---
Regards,
Linux Bluetooth


--===============2471775805993016625==--
