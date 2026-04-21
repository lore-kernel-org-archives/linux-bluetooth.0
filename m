Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F091AAE17
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783087; cv=none; b=jD+/o6o7WLHJkgLMy1XRFZZB2TV9qjouXBajFgIUAZcDTme0N94KlRJLIBl/DMAOCgoaCCDuvh34aeQRvE6YFxKLVrILVcFD6GEqSTsvAesfIszn/U4nleA4gv1u2MsM+/o/6gbr2vsca6bkMyDsPI2zDz+o17ONbFiMDsbYqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783087; c=relaxed/simple;
	bh=GubX2Uz/m+K11vGC3agRLB99bkoKkhLCYqXyfObCK/I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bdag3oe6ZEjvklRHM4rQZ+R6YUp16kVTkl7q9O+gjhZP5WfbnbJD6hUBGt8nYLiMHsIzjj62HYdrno0X2s6pOQ56ql1ugaVbUZZk3HLe+njbAHY3z77Qmb2AMjLwfs3rVsKE5U8oozTI5mISLzsZ3mLEqdjw2zqvLnW8tNAgW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkHKdYWn; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkHKdYWn"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c156c4a9efso5690574eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776783085; x=1777387885; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=my01i5etMgtfKVcUlFgzCldpEvH8MteehNfrQqA/JAw=;
        b=hkHKdYWndNqEu2+9db78ix+WyP4V2RsKgPl5b8LSPSDQLq5ylCHMNpAP3lDcOV4HRx
         Gt4s1wqIR5+yH3vCC6riDG7nXBUh5UbozsGeyQ5ByZNgsTKHUcuVHODgBkBNLC+q6mHC
         ElB3oUYFSfxwZtVB5ZuiXAGXFSww0hiS6ShkBs2Wb8L5p23CtvgUrU0u/DGeshV/K8Rk
         xpMdyzKToVpqjpNiH6ydcL+EL9406gSLhQNVBxgYFdVlTy/ThwxlS+R0YR8nxeYql2Qv
         z9WR1jEv3CknyaOc5oUgBbUg6IHlaZqKjS75MIPl5T0g1KxXOJ/PCBVtJ6Q2slS9WPgm
         4vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776783085; x=1777387885;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my01i5etMgtfKVcUlFgzCldpEvH8MteehNfrQqA/JAw=;
        b=DcSvOE6OVLETTlsGRA2R9UfVu7btF8N3IiScR/1XfcwnRr0hx8p8CTCx8JAXvKXJeg
         OdB9PNYbUnwbKrPoO1TAxOMHkzb9RuprGZaF4Me9/MNy3AKoamuk75eErA7eOr+n6BSs
         BAaubQJoD0b/IOXT+yMXXQ2MjYgRrmlYap9m+qd+YLi+W2SJ/KQQP2/91l67Y0rSIsYI
         JlARbREGMdwCJqC06OTgfffSQD1Sn8o95M5GNh2gtbG0b2ATKgKbb2KJImGlOEpqXbWq
         c262uZCQswlXNtXP8bx70c8L1QCHZiwj/XtL88Sn2HDcT4DO0B3NjwhLfL5b0C8QquOU
         8TZg==
X-Gm-Message-State: AOJu0Yw/1w4K5i7g1IEiYv4DXXwCQgymBD6fCEkbu8Vor5CoW2S4UqTB
	JlekVyk7ucgbSB3oyd4QIH6zdey0UpBT3g0RJN9tuzdg5xisGGWQfYQNaSdDqw==
X-Gm-Gg: AeBDieu8tACWT+mZN+2i9C7+u3TzF9YCvUZ/U/e8+PtnoU0yUmweiPrCdXqJDUo22jg
	J7K4UCUQdXb8ZOiSA/rUOMNrZgWGtAD7XHoMwlVyxIPWRrVFZVrBY1SgzbMWiRKSwnY6z7SUQlQ
	KQBpR3CAttzjyr9CvRler77ZpH2bpCZ6yxnBZ3FYtbBRpyfunP1UM4Lk6NK2iqe2h+4QoBCmR3w
	AqGO1cdeJSvmUcb/nFEOhtUP8ozgCYp2M52KLPF/K6N/lajDwlL23p8m/k4WKqrRZcMYK7Xvh5D
	GucLvChIBPjdKL1A01naoTPNluE9rCZUpvXXmIyQAPezU+J8tQMeg0SSiL6BmhR+jxEVJqI9RtZ
	ld0Q4ICS6uFl1GVGQmY9pBu8DQa8wxVsrr09lenKOUsM56Yd+KzwrF18OVaI6/TICkWcWN29T4s
	LYgr3eccs5t/3KtKvId4sauiSsvLPjTTFJDP/9P3v/IA==
X-Received: by 2002:a05:7022:220f:b0:127:5cd6:fa45 with SMTP id a92af1059eb24-12c73f72632mr9044401c88.14.1776783084680;
        Tue, 21 Apr 2026 07:51:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.180.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12da8b8fbc4sm7308534c88.4.2026.04.21.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:51:24 -0700 (PDT)
Message-ID: <69e78eec.050a0220.2fc4bc.3bbd@mx.google.com>
Date: Tue, 21 Apr 2026 07:51:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7830589840555669866=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: [v2,1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
In-Reply-To: <20260421135639.3185653-2-michael.bommarito@gmail.com>
References: <20260421135639.3185653-2-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7830589840555669866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1083882

---Test result---

Test Summary:
CheckPatch                    FAIL      1.20 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.17 seconds
BuildKernel                   PASS      20.51 seconds
CheckAllWarning               PASS      21.04 seconds
CheckSparse                   PASS      23.68 seconds
BuildKernel32                 PASS      18.71 seconds
TestRunnerSetup               PASS      403.79 seconds
TestRunner_l2cap-tester       PASS      23.06 seconds
IncrementalBuild              PASS      21.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
WARNING: Non-standard signature: Assisted-by:
#125: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#125: 
Assisted-by: Claude:claude-opus-4-7

total: 1 errors, 1 warnings, 0 checks, 72 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14532642.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,2/2] Bluetooth: L2CAP: skip ERTM re-init on repeated CONFIG_RSP
WARNING: Non-standard signature: Assisted-by:
#124: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#124: 
Assisted-by: Claude:claude-opus-4-7

WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 1 errors, 2 warnings, 0 checks, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14532643.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/111

---
Regards,
Linux Bluetooth


--===============7830589840555669866==--
