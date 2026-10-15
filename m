Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E05038E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067957; cv=none; b=jjbUQ1jc0LXCVHsZmrdVu+kM0M5pgBbDke6qrFF29RJHFG6hQDOSHs9nmnbAUuTddZxqLxgNYnD0QUGESUL55s/5gq7IQFMrjvQDe2xnj6udXkFfdJVwCN0EZ94BY42GocJQea6M8TUOr0lfwIySBah0z5KklNSvpEsIjMt6iB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067957; c=relaxed/simple;
	bh=BCaf6dOlvRIydDjNG45eifuSSu0IHCdTG0sDwLn29oQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cuczj8JH2oUpwauIFRB/ONRB+GWt/ASCj9TTz2uMcmW1GW5OqY/ttpS9bA967BEicp/kYs2JX/XDuTIm585yZtxfW6nukS7oPVrgCeW+W1JdAAhplDJ6lMUcF8Znm+UfScMh6Te/Z5iy+lNjI0I6S4Zp1xd6ILJTQSVqEbyuaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+VqNGue; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+VqNGue"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8253bc5a613so1480025a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792067955; x=1792672755; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d7MJvOmuS7J3nX1VsSQoObEGb4z8Qe7ChkoJffbzYyM=;
        b=H+VqNGueF1bRk7CrsJO1y9CpwytQWVENxGfmHFv231nMT87jZtv5CJYQ8QiLvCBQ3g
         p/RSYGCVadBr9FAhb3fGiPzOXgvfQ669Su+hpbperoHSk8+GIXh33Wrgg6dDaxR2asyN
         ASoeT8PH3wgkQYSF8JmbZXNTiZaSkWLNt22GwgrJJKPwgFKk/k6d7pJ51Z+FV6XZZN7V
         c5DQ7XTJF+lff/+K/msdLvVknqj9YjNDRyg6Gq14Ly07TlwapTUbRBbf10VVhzKx3boF
         kWwD8QdY/mD8HsaDWDCtO1BFOrk24O56y46FZtZKqPoykm3TAKDxxOURznF7TOTF75uG
         jrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792067955; x=1792672755;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d7MJvOmuS7J3nX1VsSQoObEGb4z8Qe7ChkoJffbzYyM=;
        b=y4a6CRNSVz0/nlVPaAYs30nsZ1JCarh06aR4efUzd8UEki2u/jprY8mAibQUroPJ8n
         jziA0otjW1NRUgeL3RF/xkb74U5Ni3wTHbk5DRE2twMYQJk5tSTKsQuGYRfitm2Tdmy9
         Akf3N3W22Z6cvLu1tzIZPHYId8tMEliGm8z9JBp+D0MhBEAgwdlJtirmlDBcPXjNfONc
         b3cUBUENuQo6KJNEPqpI/ISsSCvJrN8L1xTZy4INn0UYuxaboUu+RAsaeOv6648yVYJi
         sKv7NJL3ppNgHovoIvBWaQY3qhIcfBjTMLqHkdPSPKFmNuDvfJVkhwbKf5IgnkB7q2iE
         ltzg==
X-Gm-Message-State: AFq9FYLtehVSTdtKEZqfRgIYdoxJ0+OP9jk0h1GMq53iNqP75H9ZcNjO
	kB2gwf1mNXe8DCvm1UfXFBV3qVC86iuSP8D0/5Ydnufk4SQJ8Unxc97sPw/Lj4W5
X-Gm-Gg: AYBFou0tisnBLi2koXyXWx+RBQ+TMj1HNCYjVKxAfgteerMD6Yjle3q9RFcpu1aaSgb
	4Gtlq3XYnnSijVj35C02kAzcyKYdVCm+Akn8XlCt65Rz6nNQYuu3/gyy3YfNw31JYBhj3X9Vtac
	kAC6By0rxSHqPPG6CfazkTuEXCWMxPanquuMEMdXCVYWANGD9m5ugviq+lpAN7LRAbbnpH3R5wL
	JZW6dgjFP0hqpEqgMEdyT2yEv6RPgRQz38w3XnoRcgrTbdmX+1Id/kS5pPu7y5nAAxOeTJI5igf
	xP68nf/oIcAsUNfjyfA6S9CG5i+D8gUpfuu5WpKtMvd439WZSdZm30VmTHEGqmTl5gQn7heyhsZ
	0u2TZIAkTJYgAswNRl3qz1rlf0OrKzRIRuW4RLhX1GDa0uqJsfwZtFssIWhUBwwph+fEsbTRSfH
	K3XPSI2KQ5rdQ71r4bMEr3k1hgFf+xwbCXmPI3COPTDRSobsxez+UpXb47e++WRKIaRlITKLVqM
	0c5zc/s
X-Received: by 2002:a05:6830:378f:b0:829:9992:20e7 with SMTP id 46e09a7af769-83097c6b64emr18237944a34.30.1792067954889;
        Thu, 15 Oct 2026 05:39:14 -0700 (PDT)
Received: from [172.17.0.2] ([135.233.117.225])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8302f625a10sm17303933a34.0.2026.10.15.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:39:14 -0700 (PDT)
Message-ID: <6ad0c972.2a54a8ff.370b22.5b9f@mx.google.com>
Date: Thu, 15 Oct 2026 05:39:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1236252317777957523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ajay.k.v@intel.com
Subject: RE: [v4,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
In-Reply-To: <20261015115431.27456-1-ajay.k.v@intel.com>
References: <20261015115431.27456-1-ajay.k.v@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1236252317777957523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1186424/

---Test result---

Test Summary:
CheckPatch                    FAIL      4.17 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.82 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      27.70 seconds
CheckAllWarning               PASS      31.40 seconds
CheckSparse                   PASS      33.48 seconds
BuildKernel32                 PASS      27.54 seconds
CheckKernelLLVM               PASS      29.08 seconds
TestRunnerSetup               PASS      638.79 seconds
IncrementalBuild              PASS      28.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/3] Bluetooth: btintel_pcie: Add initial YoYo debug support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#385: 
new file mode 100644

total: 0 errors, 1 warnings, 485 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14891598.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/947

---
Regards,
Linux Bluetooth


--===============1236252317777957523==--
