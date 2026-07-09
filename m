Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD6381AFF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608033; cv=none; b=WfgDGHsP385x8fWPXwDWpL9P1Htxaf13wGe102hlm1IrrTs4+26e2PP90s7aCDomqdDthpjEjQLGgq4ICgjaqRANWfFedkNpt2yJ9xgR6wTBq+2MbdDuh1apVQWe2oxTn5Iw3ntSzmnIHRtAzJ+2OKCh3AXxOpXX5ECURdm4JCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608033; c=relaxed/simple;
	bh=43HbWZvOm2CymL5MKr27eCMELUNblUkBRfN9WYlOGfI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D+OdytBgjSpi/Oj+5D9Kil2CZjrIySAIjww1f32U08r+h20aq0WTJC8Sm8d0Ldb3YkVla4u7PJ8oZnCLWWM5tkJkGtlnL2Hl0AfM1nUXx4J4lI8340M3eLy/SSPuwopjTEtTh9IhEkdzvK5ZvmsuJvDwBgqEDX3LOkN6ehhXTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpm8GQtm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpm8GQtm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-388b404ea89so1145109a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608032; x=1784212832; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a5tD0+lLpxUMNF61dtPcHsueHJWAUVQKPuQCXpFsYKw=;
        b=Hpm8GQtmcAdZS2ajveA+VBYMVTFvJk2EPT25ls/n4m2VMGKbTrqDD7AMMCa4SxbADL
         aAIARXeofJzm8bxUHtAPjjKycBbS3Y+F10WxkvBrj8Dw0tN71oqyMZbuPf5RDXHkF7QA
         mvC5H2AZJoFuCLFPFE+TBEUKXj2wW4oKszMo4gJRf8OxnuO/ifpyw6EeeLB/YP8g+gkf
         CWUBi0YWwxpgl0pwOL7HYFiCLB+YXYdkd6DNT33b9J8EIO8RI6rmPP6wlHeYec5yJk5L
         c0P93+FGizZa+E73Zaftj4JygrlA8lzNDpscscJYD0bN4A+rOEzg20Ta1wr9RMIq2mvW
         G4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608032; x=1784212832;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a5tD0+lLpxUMNF61dtPcHsueHJWAUVQKPuQCXpFsYKw=;
        b=VIsysSI2bQiB33jaOxgwLXSq7grvumQbsmQlUW65s1rS1sB/9Q+eV1RePvwmfDifWd
         vGFZJ7Rbq2vHO3awL2RyDXwpyFx2Wky02dPiKOg9wq3J4L9ow1DS6IEgGqHq2uWqXLF7
         4VGFUQH91ZhkzyEvX1lu5PEA4Q+1I8woGoqX4F9vU+qnarbeZgFaAky47Y4eV1ChSKro
         GiamvxcpuBBjtqAS98oWe5ZMcx58U4KdNU6XubYZKPWBLX1FizMQ6IcD4EpD4I/1oLux
         AbyY5paBz/mTTGEAZAfBxCJXjDuzj77HFdJ5Rv6OjDbgt7+fb0NKs4dT+C0RyCasyXnr
         iVJA==
X-Gm-Message-State: AOJu0YykTx5WM3iKFOfFZF2VUVztdaKzlDL1pth+LmXTZyNWzU7vb9OA
	i5L9kEYA/M6my2bm+Qa9SFdCroSmH0bY4D/ZVnob/IN85cmhqkiChhSjaNBN+w==
X-Gm-Gg: AfdE7cmOE7rGYsSsWU4WqkPytxs/3gS97lHlTt0Klr7vyo7DkD/cfUYF7Zg/RTKFcSx
	41IfhIFUiXl+jXgQbkxFuOC4djkPbPsPAtwZfl14G+0RUbkEtX3XIUyOUXgzMl7GJ6dnztGGuj9
	QB5daDV0pwMi6etgru66LFe/INoYteALAHTPoxr5zgMUa0136MrmW+QZ/QZj1lBlVw1FkxxfjCv
	jp13J+lInR50KrClxdSCcsFFQnt7+bZxVItvvQq23GUTTJdcKrHx36v/SKLFRilqnrrmk/txir+
	qQsX7GR+qtgGw7tNg0fsFONkLuJJ8MS9lNs9FBypdPJHi284FmyRNTEOKYTWYApc72xlnXWQ1Yn
	HapTjJDhEj06ZsAXRNpzjNwZIGC9RZLMgG5yRSnxaD91tPAx+nZ1b5tMiHEytYGmNz1Dlmbii9T
	2ThDahUtxPEMkxVAGWUxJW8A==
X-Received: by 2002:a17:90a:dfc8:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-38b75138728mr3562275a91.14.1783608031848;
        Thu, 09 Jul 2026 07:40:31 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.220.217])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm33018711eec.16.2026.07.09.07.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:40:31 -0700 (PDT)
Message-ID: <6a4fb2df.fdc477d6.23591.44af@mx.google.com>
Date: Thu, 09 Jul 2026 07:40:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6164412493355017764=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, haoxiang_li2024@163.com
Subject: RE: [v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
In-Reply-To: <20260709114745.4030794-1-haoxiang_li2024@163.com>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6164412493355017764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1124641

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.91 seconds
CheckAllWarning               PASS      29.72 seconds
CheckSparse                   PASS      28.07 seconds
BuildKernel32                 PASS      25.92 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.53 seconds
IncrementalBuild              PASS      25.31 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup

32: B1 Line exceeds max length (85>80): " - Reset and close the virtio device on probe failures after DRIVER_OK. Thanks, Luiz!"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/418

---
Regards,
Linux Bluetooth


--===============6164412493355017764==--
