Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE573D6489
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063087; cv=none; b=Lvi/TdiaU2qyodHP9AQqViJbpHuCCO6WP9yR0skH8vfnWNte3kupCmBWwCIl26VKOs7bsRB4V8/gb/ZNSr1DvOrbmzmST14rckcDiZW63XQlcCCUKv5sKPfnPJYE9xwxkWwgG9hxuqacon/Js+V3ADBvLlj8GAqwBLY9VXSvAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063087; c=relaxed/simple;
	bh=PJgo8+wNKwh1QpQR8N+IWSTfDv7vvD5OQbzle8sltZk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Tii4uxEH8sJSQKVV3ozEFXRIKO2yktcdBp8+qxslXaevfn7T3z0ASQbU2mJLVXa329pR6O9OLvAfUZRQjxvOMptPBEv/u7w5hRSYL+lP4koUTrMQP9msU5fhj8a/GDwVWxsCCA1TzfRmbiUPUHI62IH7vdJ1cc/qtFpUGbapDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJOhxh6h; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJOhxh6h"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c726f46baso10386208c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777063085; x=1777667885; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OYDuk5F7d8WCLEqS3xiXXwxfPmA74RPUAQjujHt7AYY=;
        b=KJOhxh6hA8dntEl3h7owOmfS6TU9+DQzoljvcWWANF7Ssx2fKLMxLI4XYpG6FN3MEu
         OB0DzfUCnK+dE/gsDeCAxcBnoZCqr89oEUv/5WOPaEOXnXCc5b2PGovwZkeSYO7yYDYh
         IpJifzaZrIChdT9gcoVzWzgfLkoq/fr4E1os5MLkpmGsKikotM6ZnHA4607k8m40mSKO
         m2Ggy71e8p4D/1ExzCqua1ml8/DRkbVi3Bap8Jxv6IvJfX9v92qtQL+P+U6Q/s0sajKV
         f7EFvofLLvhrlYjc3RqkJIE5xAZPK1XTDEZGiRiO1erPHxDFNDSta5CDXGywZsSKkYTr
         8geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777063085; x=1777667885;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYDuk5F7d8WCLEqS3xiXXwxfPmA74RPUAQjujHt7AYY=;
        b=M/UROCUCdSOodxcaWyajSeRBVgNmQhzqfTOY3pZKLG4FA2PxVImypb5btSrZ5NRU6X
         PR8oWRMvYGnAvF4EAgcBQrYyLngzylOwv9GyUaxywEZepKXtAwH2ubTHjt7xibYuPGCi
         uO4dcBwlNARpMdD7IagI6R82YjeO/Cw+o/rE2KsZIxxh1FA9cRj15sK13n0hvMXkJOB3
         45/3VHFxz6raFUholwImQxa6oOqdE1LgXX9KNstwTOkDAkXV42LpkiCzB9Cz551RBGVO
         t91/bMqcnyHd1dnMK+GvJ75YafY3mf7Tod2nFP1UsN+LjQAZnd3y18xR2Pjk8q33p0SD
         XhGA==
X-Gm-Message-State: AOJu0YzeSR0iW75Z47lNOpBtxYp92UzNo5fnb+eJSR+rl8V41e/5dXSR
	Ta++L7AkIYPzrQhCoBsZRyfb6n1+mS1OoFBerk1TtKVoBEC88Qv3hqfome4dGQ==
X-Gm-Gg: AeBDieu2HlSNa4RjajyAI2K8f1XPBO6A/FHAn94msydGvfwAfy1/dLYmhWcLCeKI3X/
	E0JWELOeT0Hl9s3+LfM/QvfVMin+N8secbylQ1MZ2Va6IaNZVOmGUQW8lH7gcicA95Mgk+uGSQu
	ImtVbKb8WL8okBglFtP+R02IpV3lY8RS+PqAXwnp4S0cwuYbPStE7IJzhaxnZ+I2uxTOSQsDc1i
	FpcL4b+NuBxxfUmv8NOza+jPP4t8pe5hVp63pBPJWmoB/1xgaamlff6HziUF83sci+1ZbLt/L8m
	7o28/2S1bJdKTTHFOXjVB3OHxvhMam7v749038amMJM3EMYR+Q771yv369VQ1Qj/e9ccUYoT79F
	hTWwp1GHzhbz+7gIN1D9Gz3oOd29dEb6kjmkO+dD794ETG+T6DvUUWEi0cn3HJFSeLbhmgaVcfk
	5IyAOYzcnkow1Mlf7MlCOCziKLX8nPrv/PPtxbknJU
X-Received: by 2002:a05:7022:3d87:b0:124:9fd8:4ba9 with SMTP id a92af1059eb24-12c73f6cd01mr18820365c88.12.1777063085057;
        Fri, 24 Apr 2026 13:38:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.118.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20eb5sm42733779c88.14.2026.04.24.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 13:38:04 -0700 (PDT)
Message-ID: <69ebd4ac.050a0220.f32ef.836f@mx.google.com>
Date: Fri, 24 Apr 2026 13:38:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4181183923953076005=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: btusb: deal with MT7925 invalid ISO RX packets
In-Reply-To: <d5d33658e20fc0ad4cfe80df185d31fecad66fcf.1777059145.git.pav@iki.fi>
References: <d5d33658e20fc0ad4cfe80df185d31fecad66fcf.1777059145.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4181183923953076005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085337

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      24.35 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   PASS      25.30 seconds
BuildKernel32                 PASS      23.95 seconds
TestRunnerSetup               PASS      524.33 seconds
IncrementalBuild              PASS      22.40 seconds



https://github.com/bluez/bluetooth-next/pull/122

---
Regards,
Linux Bluetooth


--===============4181183923953076005==--
