Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48701463B74
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986745; cv=none; b=Qa5LLT/auRGDi7YIrciKDwT1H8bcQ5UBXfwIuJqXLnIzMfKlEfk19ifuUcUTA/CS1S7zr6wogKx9WQ1yq7CqBl37CwIHWmhm7OGja7CYCnGarG750Z48wNsT0vuyQ9nUTYNdFMEYtiN0c5QHFCvzM++Rde18NLpBlWm8Aihm3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986745; c=relaxed/simple;
	bh=IwTlwYY8e7M4nknuPZEigKMA10G+M7l2gBIUe5oPdns=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Pcq3cj+Go2n64X2sposbvPW+J9zupspGqVEZu0BY0HCj0dPo0vwq8sYH3pmzcCi27I6MiM36+05VG2+ta95hGw14DCoFrludLLGViBowEKVWFzqm4FDaM24eX6EBI1pIBS/pK6s6v4H9hJOgHWiGl7wNQ8q7Nz92Au7jjddIAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ60eF5C; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ60eF5C"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso2694355a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786986744; x=1787591544; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MGeV/zroSu1K1/srS0n+SDkxRnKG/cWtoHmguQIm4Do=;
        b=GQ60eF5CsxwUy/4Cy2vkqdXs3ZWXbBvFArMqjkxakM/3uQ95tTXiMbX9TWXRrfFlNf
         1eUjJzmdsUVi/gpV/hoYZ1xl5mLLZ88t6FEEiv1Naa5d4CFF5/SkDWynAZwTnD0mEQSV
         rzbwEfjfoh+3r7ofJ4O81Fd+VAvyDJ5ywuQ/6DrLBb2OM7kMipMuhYtND6/iPsadNpxS
         bt8zBMJxxfTJTz+ii3fNMT7y99JoNArQ3b2FLeCiMQv8+IqY3L0YdSEbA+5qtDdQ5bMo
         t65kMeO991pe7+aiH4laqBZkduT9Ha6GRGzTxLRlaJkOmWZwQBbIn77b4f44ExSYZGvT
         6ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986744; x=1787591544;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MGeV/zroSu1K1/srS0n+SDkxRnKG/cWtoHmguQIm4Do=;
        b=o3FWn0CzwZdaAXkUoZMFb0NR3M27SbnTAXSLKB3Hjv0LVfoboCrgfQLITwdDfFP7TL
         Q+31/TL8zk2Mc1nJp0fvgKN1yG/F6onLOY0S6DaGTBSnU4cOIr5MDnVDQuaEUef4JPGJ
         iUIGOvlm1F4RWzvhgM01fqZ2J7vbesgCxIdGRdCUkaP3a+rrXIrBPFBeRjKj5S3JEdJX
         GVrxtyCwonNZdV5AfRBr3L0y1d4jNs1o4k95Gg5st7C4+HEuSK+ppNMRnZSDZdqwqq+L
         Oev79FjQRwE/e4vN0HLOfIghVYwbVo9Jo0Q8qr3CZdiEMbGEsiBQhy+1G5Za5uQf0v/H
         ep7w==
X-Gm-Message-State: AOJu0YxzN5xaVN1IO4amdIfus+29TT9kcfaAtuRzIPQLNlfYdZpJ3oaR
	tWcwWA1ZvyoInUeZlZR7S+2+tR0g4QcAyy9vtFL1R0tJllukc/SUau+YB6MOdw==
X-Gm-Gg: AR+sD12t3W0gh69if8ZZBqGFLqYi2YrnoTJoUt+JEK3xIAEyt2pNMHpPjFmhlRvf4Vj
	0JCIR867ZdqvBniiCHqnswmcxd+UfPJzw2LRa4V+Xbb68LWHEQ3yJa07aAfwMbyZ2vyTqGRAwDi
	Ii1+gKAhiPuxgsZnyvWbRCMJqtKH4FEhQM8N1D8axh8PiSQ+KdQekWifZUBv8ihxAZ/0KUQSqZ5
	iqqpuPcHoUehNx3AEH5ShCU7xSq9sdcNubaFht0vdogoBgreFxFzEXruINBuDp0s7rKQiIAxHUQ
	Z8PgdOUrMlVNPSybocnEq4y6A01J8DrWLvSVL9dmpVtz4kjsUvuqeWoGA6IEw/C9mSBtOgmr+xz
	vPRTDTagdV14KN5nGto05Carr2wRzJ14oJLBC7Lzp8LvVWGh6uN7+cowM8tbt32Z4Cn0p3pNe6z
	OlUOmvDv/6TsZ+m1X8nS2O0Dbg0JHZ0xEzXcs96FNUH05wVpfeWZIZyOQPrXMs/BeNKiZ8MQ==
X-Received: by 2002:a05:6a21:3281:b0:3c4:46ca:3347 with SMTP id adf61e73a8af0-3cc71c1b656mr26565874637.2.1786986743590;
        Mon, 17 Aug 2026 10:12:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.158.201])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1415315e2c9sm7931212c88.9.2026.08.17.10.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:12:21 -0700 (PDT)
Message-ID: <6a8340f5.e5907290.132c56.f51a@mx.google.com>
Date: Mon, 17 Aug 2026 10:12:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3242326213349571878=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de
Subject: RE: [BlueZ] obexd: Reference count the phonebook back-end setup and teardown
In-Reply-To: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
References: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3242326213349571878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147292

---Test result---

Test Summary:
CheckPatch                    FAIL      0.45 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      598.08 seconds
MakeCheck                     PASS      19.61 seconds
MakeDistcheck                 PASS      158.20 seconds
CheckValgrind                 PASS      229.46 seconds
CheckSmatch                   PASS      308.91 seconds
bluezmakeextell               PASS      104.97 seconds
IncrementalBuild              PASS      608.01 seconds
ScanBuild                     PASS      970.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] obexd: Reference count the phonebook back-end setup and teardown
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#88: 
Assisted-by: Claude Code:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude Code:claude-opus-5'
#88: 
Assisted-by: Claude Code:claude-opus-5

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#202: FILE: obexd/plugins/phonebook.c:21:
+static unsigned int refcount = 0;

/github/workspace/src/patch/14753861.patch total: 2 errors, 1 warnings, 121 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14753861.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2409

---
Regards,
Linux Bluetooth


--===============3242326213349571878==--
