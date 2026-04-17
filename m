Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172921FF7C7
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466525; cv=none; b=ZsEuZIcSqzvjVdcQZSuJCOiVMsybAeWYwLNRzDguKdp/Mngwc3MFmBa65tcoLyfhSE23yx5K06mGWggMlNJ7pAY09lkvvq+bxU1tAxmPHqvSms0ZSrpZ2jfZcesDfe1XY7gQhxAk1c/PDdHLNrQv9dtLZ64OHsvhxAOwMg+4kTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466525; c=relaxed/simple;
	bh=+WqTQINxN6GX9sKqpigmzawcteXaAG+1af4ig4DmIzQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cADFbRtUvtAbkH4XEGLXsImVaPNxiNlt5JCTvtf3UYeCiVLT8fGWymZx1LwF3jof9YE4VL0zHadGQj7bcEb6NCVDXqefx1hEbPWcaVAcPdZRlOmbOj6aQLfGM6q4E73AgfaOMnlhA7Mjj1GhtJ4tEmwpXxCuzQiWD4/P4FDQJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLffaNYw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLffaNYw"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b69bf5638so13030491cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 15:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776466523; x=1777071323; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wIAk5eijfYGomUtrILy1hQ2EHcC0HJUFhS+dqLWqUmI=;
        b=dLffaNYwwu8vDo6Q9c7OpidjzcpomtYwJ8uUC4He51CNjvySpRA+13CazSVIgJ81IC
         cTKZTQRyzEBf85DwoG8MmE6CNfsoynuUcTGrEJ8vD2aPKNrZhcTADyZ9DHOz733oSuxS
         sAUX5XPZHL5FWKlqU7Tn8iueJd6Js+LMFol0AxBRQNI4a/Xv3xcywSuCMAQgxg9tZxJO
         isjo/itPi6XjCIsOJCvjoDY7h8hrjQjpCJmntUZKZrsEBtNJTA8R14bIYSuepy3e1fpB
         oVgEB+2aY4POaQe+PqhpI8m9jKU6FmtYIvjTk9VNIx7u78vhnicNLxqiv5BiPnWdSj30
         dZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776466523; x=1777071323;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIAk5eijfYGomUtrILy1hQ2EHcC0HJUFhS+dqLWqUmI=;
        b=ki4rqXEtoBw1tUeaaDJUVc/SK/8U34vHTwWkxd6jS0500jROavPwch7UG8b6+JKnj5
         hQ90mThpcD0VTwWPvHmE2oSm8DTl0MXKV8EF44kr9PyDV/rx6fGQxEZBSjQNOh1pE5ns
         +k1MwqonRf5g6zHQAY4UbYRn42B3v9KVA0d9GJQiW3+ru/aiC1plYM8uyJKtn0NhM3hB
         ev9VE61/jNVf3I12lPUbyv7eZbDO47ker81e7GO199lEGCN7VdKmJw4OKVc/SCmX5DI6
         UA0m5czmdvSQORK+tG6IbjK3Fnk+YECz70BdZCQ4HdiOPMBgwiR6JqPpBfdZp4jl0Wqy
         NsyQ==
X-Gm-Message-State: AOJu0YyA3F5nx4o19pChe4/XueeSTa0ZwAwNP9sgeSJQnjPP0QM2VtQQ
	XRwZm4Diqyosx5M4YmCYz0DIgp/7rODPZ2gZ7pfGvCrhLVCuyuFCVAUNNcx13g==
X-Gm-Gg: AeBDietRWT1sv+lZQp+8OWD+6bh/ESFnu6RzpK/LsNcwxj4d4Fukz/Pr3rWwi9+pNI7
	W/Z8zstfjwT/yqwAEIrWaZhpRtwVsSWe3Bx7Gm1PXAXon8Of3C3J9V4Hg23Nf/5ZP2QAptJ/4xd
	ddfKWIdZS6D5LDifCu2a69ULhk7KjaIriXeJxkyfLk5RAlaS9XXTKxHabBSnEQNDG9EbIw2q8JU
	lSP1oLMje0BXMDc/MbyX++ci0dZDPS+Q8CQa+mmXEL2SGifeRAyF3OAeO0TrHMfDpRt6dfa0JVJ
	Qg08+LeYfIfos9qxzRq1WX/1+SnxdvHSdpmb1lrkTZ7n+tZNTt1f31kLgUxlG0e+/YGrI9Of1pC
	DznbixWKTiM+Pduyy6YupLXg6ZwyBehStHNzWdZNX5by9ajruJhPW2njDi0bto2j0B3p4+Y82oM
	DhFFOTyaLBNRASlIO/JZfe3dhTrk4WAu9OhV8ld1ojFg==
X-Received: by 2002:a05:622a:2515:b0:50d:a9a9:fbfa with SMTP id d75a77b69052e-50e36c567d5mr70995211cf.43.1776466522568;
        Fri, 17 Apr 2026 15:55:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.119.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39130d7csm21846191cf.0.2026.04.17.15.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:55:22 -0700 (PDT)
Message-ID: <69e2ba5a.050a0220.14ae6c.568e@mx.google.com>
Date: Fri, 17 Apr 2026 15:55:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5684493727930697639=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
In-Reply-To: <20260417221628.1674866-1-michael.bommarito@gmail.com>
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5684493727930697639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1082694

---Test result---

Test Summary:
CheckPatch                    FAIL      0.78 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.65 seconds
CheckAllWarning               PASS      28.56 seconds
CheckSparse                   PASS      26.63 seconds
BuildKernel32                 PASS      25.01 seconds
TestRunnerSetup               PASS      526.98 seconds
TestRunner_l2cap-tester       PASS      28.12 seconds
IncrementalBuild              PASS      24.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
WARNING: Non-standard signature: Assisted-by:
#191: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#191: 
Assisted-by: Claude:claude-opus-4-7

total: 1 errors, 1 warnings, 0 checks, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14528993.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/100

---
Regards,
Linux Bluetooth


--===============5684493727930697639==--
