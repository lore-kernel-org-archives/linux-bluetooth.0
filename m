Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49D4F052F
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892186; cv=none; b=EYInTwJGJUAVxD4tuO+cF8VGubLJ3ukKDnS+MoCM2j0pQkCJscbgASu/pkDk4pJM+0Hurx7D8cWtss3ajWJvbMJBTRsiqf6euzfRocS0mlYTilTth9+57p2LKBfW/mpU+fW7PEZBgWmbT3UR5WgDPU1hpRWDFQur4DZS08Hkyxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892186; c=relaxed/simple;
	bh=bkQalbqcFYfYq/IHelAu6svxDgumfpsVW5qv6U16wnk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D4xQH2lstx5Fihdcl6vv4V00Z2FfRhDS8RKd1m83gqLZXFY/qhIMcpqLQtXTRumgaGdFHbSSDadn/HFpubEzOFmWF/UL1P3SC61yjOTZ01N7ewYX9kQsamUPA77YKHCVPPL+LtCYLWndrByYBV92iS1nDYGAYfR84fi/3Rjw/cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjIs9aAr; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjIs9aAr"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so1946019eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892184; x=1792496984; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HasKaEYdmsfxF8502o90lvo5JRyfY6i02VpCWyJL2EM=;
        b=qjIs9aArqOR84S6rrgx3iv74sbbprHbyC1w83ZEWdPotf0LClIN97Jqf/s8vy49bYy
         w6VVEM997JhbjP6qO3EWSZ+2g7Wc8YQ5Ac3Z74/AkPpvfJLhvhGKyCcB6W4xjeeEsq2w
         H3zlEhlM+/WUtrAl6J7wp7XKrnbY64wM3NWWKG6J97uTkHfLXSS83hm5vbHL4bUnp83Q
         hI0gpROPQuFZYJ8L5lbbyjvvj1CTSNGtb4j8Cwci5qrItizohasG6Go8vldz0FKCBtbU
         UE0eFq/W6ozKc0Omdhi9rF92PHHY8C45xh7H0ZM33cCq/S5W0tIpFVl/5WwFupf0mzoD
         Plng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892184; x=1792496984;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HasKaEYdmsfxF8502o90lvo5JRyfY6i02VpCWyJL2EM=;
        b=rI56BZXxAHcfuHQPJIXaqg8klvKO6R0LmLMKktEPDRXQAVv1qJxdWkJVsAP/rqYAME
         3LHIaT5VrcIOWeYUHHbKqsxlWeloNoS83d5M53BTKy/fFMvfzp1cgTmUBxj80UAeUjiV
         grMOM5WpHONWnmExXAbCfYisMD5WcYusoDRzlqp9h4Oob6LtMHe2mTaDH1xX9+5doAVC
         ApMYYvhatQI1PeYdp88Gpy4xzPcK2Bspnysu9zH8JACnLuk2pKj1qVyz2+aGs/ro1/C/
         X/sDVQqGT+ClrBzjqnJo9/exBRNQf9VIdr+SiEnWAZ2Qv5IBayTpeQ8xiUWA0yDGkmuV
         r6gw==
X-Gm-Message-State: AFq9FYJWjg1G893t0zXdUK6NTKeONtJFJ8sZ6bJiZ4AsUbJcFH4+D9fv
	pSUHnrsNEzNDPG0Op4g/wlcZYvsvFKdqCP6fEF14LUDMZNrITWFSOqNZp94qgQ==
X-Gm-Gg: AYBFou0N7P9+91GQbHV2n+Nyo01QU/xkOKirARIaXkZ4kEFbbh57nS1/2sU3t4Tmw2y
	6FiqvP0UuTUreQivc6mmpSA1eHCIG1aO+bnrvsItEuJVMfWhB4zrv2zZaBDW2BYGkVfpP1Ijwur
	dDkOvBpgYPuQ8FAqBg+6RDq0C/wpWlWrqBZOE1C81gA6GL3tuWf4yWs9JGsAIpb3sSIpbXnZt7L
	ZDnbAAjFIc0/l5RLGBnMO6AgivVmzSPIBUiZ8f+whTm36WBPeZhX0tNiRrR0DRu1LKEjtOI+lbl
	rDqUhDZixG3jli26ArSEfgZBXJ7zFfaTrmtC65l+zTnu1iTVysiw8n9kTl8+9T6/QmeGklDnehN
	KNlXft84awwC0PzmN14+/CD27oQEDUeV/WnI86h57bp8VopSngZ5bGqE0heAP8IcDCUgE5zS8xl
	Zg7Bfp22qkDsySUhXjDTrDs4b+ucrbiWuw/IBWJukgTUy31YIVbbWPdVafjro5jxcxfngftpjku
	uyn
X-Received: by 2002:a05:7300:ac81:b0:34d:de2e:1fca with SMTP id 5a478bee46e88-3537dff5a5cmr26278659eec.21.1791892183728;
        Tue, 13 Oct 2026 04:49:43 -0700 (PDT)
Received: from [172.17.0.2] ([134.33.67.124])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm46426993eec.5.2026.10.13.04.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:49:43 -0700 (PDT)
Message-ID: <6ace1ad7.116bf87f.27c28.01f1@mx.google.com>
Date: Tue, 13 Oct 2026 04:49:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1091890489479256962=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, an.wu@canonical.com
Subject: RE: Bluetooth: btintel_pcie: guard debug dump before hdev setup
In-Reply-To: <20261013053118.1201636-1-an.wu@canonical.com>
References: <20261013053118.1201636-1-an.wu@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1091890489479256962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184381/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.52 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      22.87 seconds
CheckAllWarning               PASS      27.82 seconds
CheckSparse                   PASS      30.11 seconds
BuildKernel32                 PASS      25.65 seconds
CheckKernelLLVM               PASS      26.78 seconds
TestRunnerSetup               PASS      533.63 seconds
IncrementalBuild              PASS      23.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btintel_pcie: guard debug dump before hdev setup
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14883827.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/911

---
Regards,
Linux Bluetooth


--===============1091890489479256962==--
