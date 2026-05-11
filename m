Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524243CED5
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519004; cv=none; b=uyEtwfKoxuLsvD6Wmu1UDM1yy9qagaXUaEXqGdEKOWllxrRBdWSVTE5Zll41l4WXH/ba8PXhELtV3ppN8eoOti3TWOFlGv1msFXIvEv7TY6hooBZk0BlES9G1FDzMx0JqxJrF2IncyUne9u8RP6pFAtxv2+qEilF+plsTUGB018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519004; c=relaxed/simple;
	bh=thWJmmmoXyQ1iAu6IFX1pASmwzHDgw6CmKELVJuT6Aw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vq9PFgPgn/sl/yUlYM04yBqiFt6+dbKfhZ1ApyPdwmky5F8QNc0b/Z11M1txsectt4p3vY+LklMQWH1rWDIcq6yshUcU0aNSvfvPGOOG/1hRuLoKLWRprRPMG4/3nXoS1x26aiiLZq45s4h0sduHMBJbMu7lrwFh3tYmPwzUXqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLgoKkae; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLgoKkae"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8eea23d01f7so611918185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519002; x=1779123802; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lj3szlKfE+9awghHWDYqGrXYPkZeRZjXhkk3gcTxetQ=;
        b=nLgoKkaespeuUJmusxMCwv3NKG/+UwkEP8ZAf6f0hEXm0D/pdhTAlyGYi4Iv2cHrOw
         JI7LvMW6JNEznrRE27wEr7VuBAZifiDVxImSUjilVNbLOZ7Me1Y+VcIwTdaHwd4ZU8EA
         Ij6CQAuMuli+6ApWYMwywokMqmZF1k3qNUfHEGGmX55FrQvUMoIqSdIBgdqo6o7vXAxb
         ituZPbioumUnzt3VV3AkmHCPb5L5EwNVc/5qhF25nGa+unEA0rJqdLn8N/ZvnWYqzpX3
         rnTnHoY0Wm+k8qkNlmTfgVdMwOFkDFecJQoVv829PFTpVogYOKxdSWm8uxSDm3qv71jP
         6vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519002; x=1779123802;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lj3szlKfE+9awghHWDYqGrXYPkZeRZjXhkk3gcTxetQ=;
        b=PBIAiPxuKgS++x8Mj8o+UWTx1OHzDrJFuXiRFecbSl4oGHJX54XsE4izT/0hrEUjdy
         A2AlrTa35nQ/K+2aPzyIWrAal3W1rP3+zsC0hGDJoDtIuudl1h2qQyAhXnj5kjlB6DgM
         WPw/v5N3sHWHZvc55kP/1VpMfEf81EXzf8B9f8SioEsdGGJhcgrfXJFyH+s068jAOLEu
         TsPc3w9M8g1pMHWupiuoAy4W4a7AMP0mjkfLqvq4wOffUlQy/dOpuS6JoVB5U6tH7v4q
         JPemlyzU/Sn/7Q+8nQFdzJf+vW2pwgpYWNtudzQi46wYcvryAkgnV0aQDYlIy5fbbb02
         fXAg==
X-Gm-Message-State: AOJu0Yw4h1+tz2nR5neL6zbcbZ419p1ZKnGMzTkIcn3YKVQn9g27dcZB
	JtMKRKOjLvbi5aTGsG+QNel8+ZWhMEuYXmExmQfd17GJ4XsaW8oOzh+BJ7GIXg==
X-Gm-Gg: Acq92OEb1NFJbtfb+XgpcnrbkjjqBvo0FnIpBUCRrJ+J6mF4JxoPx1HYMTEdEPJWiXf
	wY7HWiCYQmoGpXH49Bkyo5G3HUshNMVWDs1uN2sLZQG0e7MsDqgDcfFwGEfOXinwbA37mZmmHBw
	LLrvdKRDiOL0B7gv3GFfTI7U9BsGmQG/h/i5BnNa+HGWoDTyet0Po9pAoztvTlk2T3H/oCe5wUC
	Fus5+JHYcTMb0SEAWUoLrrgxI+n1OaUfv/zpQjtcG3MvBvVVj28CSM0qKR4xCP1McG01qgBDWTq
	nvjPtXrtHxenGnL1g3vlGklmXDqUc/6zekUJGHSEHzAfS9qcc6IzKRgXZDQKNYf9FRnBQpDlkrm
	RHId9ZT9YTqyhdCgXRnlbsaM1j5hB34IjSF0LlY3fMlz9hExFbPMzVsPB0Ay0PtSaVBMnmeZHvR
	1yV0xteyUWnbeIraBFuyUDOnBEEhdJ56E=
X-Received: by 2002:a05:620a:470f:b0:909:e4dc:fb32 with SMTP id af79cd13be357-909e4dcfeb4mr1286133885a.33.1778519001823;
        Mon, 11 May 2026 10:03:21 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b87bd789sm1197971185a.27.2026.05.11.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:03:21 -0700 (PDT)
Message-ID: <6a020bd9.050a0220.1c0de4.d7e2@mx.google.com>
Date: Mon, 11 May 2026 10:03:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2212020961361864440=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v6] Bluetooth: hci_qca: Convert timeout from jiffies to ms
In-Reply-To: <20260511135837.3967550-1-shuai.zhang@oss.qualcomm.com>
References: <20260511135837.3967550-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2212020961361864440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092831

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
GitLint                       FAIL      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.02 seconds
CheckAllWarning               PASS      28.87 seconds
CheckSparse                   PASS      27.80 seconds
BuildKernel32                 PASS      25.35 seconds
TestRunnerSetup               PASS      563.31 seconds
IncrementalBuild              PASS      25.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v6] Bluetooth: hci_qca: Convert timeout from jiffies to ms
ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit c347ca17d62a ("Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling")'
#135: 
Wake timer depends on commit c347ca17d62a

total: 1 errors, 0 warnings, 101 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14565792.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v6] Bluetooth: hci_qca: Convert timeout from jiffies to ms

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
28: B1 Line exceeds max length (89>80): "- Rename macros by dropping the _MS suffix to reflect that they now yield jiffies values."
31: B1 Line exceeds max length (84>80): "  https://lore.kernel.org/all/20260429123802.1310681-1-shuai.zhang@oss.qualcomm.com/"
36: B1 Line exceeds max length (84>80): "  https://lore.kernel.org/all/20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com/"


https://github.com/bluez/bluetooth-next/pull/168

---
Regards,
Linux Bluetooth


--===============2212020961361864440==--
