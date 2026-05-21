Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5165384CED
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384238; cv=none; b=LBSowmK1HHx2VCH0xyWsaWtRv/FrlwUrLFISbR+xDZ9OBWF73aoBC2WqizxzbpQR84Mp9coIBTyaPQ/1f/xlOBcRJ+4oM9dfXWVwNg4o3aVZY8+9TKYB1gsoCStMak2FrTcrTwWwv6i1W28js1XXBTOzXDIqIT7pIzDZZpDIZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384238; c=relaxed/simple;
	bh=Owaib1n1hWGDOXXTQanCODmUv+XqMg2s/ayS5edQDsY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZWhVIXUZYx7bWrLjfrmr3RqvUpUz3p64qyp2zR9anjggxRyhqg34gYn0p0ZtFEEl2E46TbOzO7so6eNfyp95JTUWAooiSDqgHQmpzN2E+OoC8M7v6fHF5sJn7IU/pHTXon+1LMv5WZR6eCxOiD2ZS5UFqwPl7QFvQKx+Jc0hJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgvdt7Cv; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgvdt7Cv"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30246cfd41aso983758eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779384224; x=1779989024; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X94wZkbR1xJK7w6h1anPcpwUowZEZiBSYP0dmu+78nY=;
        b=jgvdt7Cv1bS3tHK30SP1qZ73/gafYmIXaze0Y7s5blxF9Vf3A9PL3HFH0YaShHpUN7
         TGuzY9sFW4ihbBVjHR0D0m4XjLcyH98gIDG5F8m+HBzeIULb+I/GFx33iA3xQJ+sfNBD
         rRMPfwhVg72A2AfD2ae0WAt7e6tsXZ0o0mhkyvPchTH19Dpls1/H8cmoG3FjYKhSi7Nr
         PQIP1ldxtgGhbQQKJaQdEK3V0t0y75gpT2rU5FDvW0uaWwlEznPnxF0eLwxy+XmMgxb5
         6dP8uLsXqnF3AIP9C1FxMh5AI8le1LC2lm5Whd2JN/4fIGhxf6QpKqNCqcb22LH2725w
         JFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779384224; x=1779989024;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X94wZkbR1xJK7w6h1anPcpwUowZEZiBSYP0dmu+78nY=;
        b=YLiTvghN6Xqw1roSsCFCCEcJNmjP2CnuDj+V0Pzo8dN7L2Y29MuH90ZVGElO25heBb
         jIXxwupH8KWlNQgEIXAol9/FvodDrUHPKp00HBBNHl1cBhKubiIH9jKijCbuo+vBp3x8
         iUs0V4LIj/UpNDOwv7be7/Wk50dpcTIkfO6qJTTVTLDmaua3avawvj60ppQ+rS80Kn3z
         2MRL7kz4k1S2babjXVaI4iwUOEz8XGMIJkq6wxd7ODKCGqfPj59pRwSjF5xmr5fSQWxG
         Zl68eXqZvFH3pIVm8odALA2vH1HtKIYRzmol4x5eo96Paxu6cYnVT6llGMLZYAUblew1
         bv4w==
X-Gm-Message-State: AOJu0YzLNJq5KM59T7AliVudEJMfoqYLCgHmsztEKqdIdZmX65XqxoLM
	qO1gXiB4X57CkL5uwbz722DGTMMQz3kY1SghtS3JD04fxTi6dtHXPIZgqxBo6w==
X-Gm-Gg: Acq92OFqEEXry41huGU0HcXiYx7eKxlYrKoZq2nhALW66faYmXbshIWWhHhr4vLDBUY
	lfH8C54FnO03r9cu9PMsNY3UlXYtKHD2Noz1XtbigfiwDfq3O0Ip5FzhDxZT+NAElgZKr1V8I2w
	bAA/M5Ptu/d0WaavxR0GGZjCUJtiRFvQjpPgiKq7Xtrlxbl5JBBrOLDU7b9wE9jyT0nRcvsGcG5
	opSim7DjGmYLE4Nb40WBZJVtGd+rLknQgReHRvKcfwQyQ2yah1a80BIuilthiLcICKUMqoiWhn3
	NHQLSrn2nNC4ta9G9dtsnm1Os0W8yPqbETMHms8Ef7sfSaJVlNh1uhCWWNp9mnxBnLR4wuiyiT1
	W2ZFDWWAUGNIwbVg1TPU3uTLhjzNtAiv/ujKq373qcD7I7h8UnJ91+m6sH+1YgsEehbrbxdIKnQ
	BfU05OC3g7+Y49xtE5Q4jq7uKFCtA5pFbYtx+hBnYC
X-Received: by 2002:a05:7300:6412:b0:2e0:4edd:64e4 with SMTP id 5a478bee46e88-30449196139mr13211eec.26.1779384224227;
        Thu, 21 May 2026 10:23:44 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.61.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30443598966sm942222eec.21.2026.05.21.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:23:43 -0700 (PDT)
Message-ID: <6a0f3f9f.67020e13.1e75ca.e7df@mx.google.com>
Date: Thu, 21 May 2026 10:23:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7983863210322220581=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: [v4] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
In-Reply-To: <20260521144518.1361335-1-michael.bommarito@gmail.com>
References: <20260521144518.1361335-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7983863210322220581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1098859

---Test result---

Test Summary:
CheckPatch                    FAIL      0.80 seconds
VerifyFixes                   PASS      0.48 seconds
VerifySignedoff               FAIL      0.22 seconds
GitLint                       FAIL      0.21 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      27.63 seconds
CheckAllWarning               PASS      29.12 seconds
CheckSparse                   PASS      27.57 seconds
BuildKernel32                 PASS      25.63 seconds
TestRunnerSetup               PASS      578.13 seconds
TestRunner_l2cap-tester       PASS      61.59 seconds
IncrementalBuild              PASS      24.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
WARNING: The commit message has 'stable@', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 65 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14587556.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: VerifySignedoff - FAIL
Desc: Verify Signed-off-by chain
Output:
Commit e9a1f367f155 ("Merge fec51f9217e4a020fb088da178104f4d925554fb into 133f77de6bca4b8873bcf67e3469bf1b28771a68")
	author Signed-off-by missing
	committer Signed-off-by missing
	author email:    61600790+BluezTestBot@users.noreply.github.com
	committer email: noreply@github.com
	

Errors in tree with Signed-off-by, please fix!

##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
37: B1 Line exceeds max length (84>80): "Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com"
38: B1 Line exceeds max length (84>80): "Link: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com"
39: B1 Line exceeds max length (84>80): "Link: https://lore.kernel.org/r/20260521000555.3712030-1-michael.bommarito@gmail.com"
77: B1 Line exceeds max length (82>80): "v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com"
78: B1 Line exceeds max length (82>80): "v2: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com"
79: B1 Line exceeds max length (82>80): "v3: https://lore.kernel.org/r/20260521000555.3712030-1-michael.bommarito@gmail.com"


https://github.com/bluez/bluetooth-next/pull/231

---
Regards,
Linux Bluetooth


--===============7983863210322220581==--
