Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BCE30C368
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783008746; cv=none; b=BxbTYXUdjBxDj+E9FiQHSfkJys8Wf9rAgYtwjmXzYlF7KNqaHbEh43BQ7KC/2Gvt7ZlCLbVS9RI4O+WerDSrO+b0HUcAa4cjUhK9Sx0ujLRxrYHGnEZsP6il+H925LR7U6M0SaOniEuLopydQYUEAlFm5/y9k/N6cJEZBRV7BgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783008746; c=relaxed/simple;
	bh=5Cenauv4U7Olsi9zR3RKt7QPbFgXoVGMneDR1+bWV/c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BsoOBYDoTA9xgChmsSVVk8G2MMyAZXYvHoc+I5AJx2UBCFTtcDz20hoKH3vdhS7DeonDOn5WWWoJ4FaDwJQEEXUvHwVjkW7P5dBVyUn4Q2CROjVW+TCRokO+EFXt8quhg0tJa+JXI9CIHOXAw3e1TF92TrSxKnfZZkf4FyPwtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLrA7JJa; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLrA7JJa"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8eff5ce3b95so17373196d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783008744; x=1783613544; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=97PE4GxCurgsPgMFgXuN9KmttZbpEHdmlUlFoHEv9hA=;
        b=rLrA7JJa7pLVPSJorBkNEZfv2H5QvT5KOR9XUubVZN/MdfPNhs6Jkb4YSYuFFqn21r
         lBBLQW6mpwswL632HZfEHu04/sqHz9sHMrD24vk6TaM7LqGY9qPZuIE/SB7M+h+eBuKA
         t+uPTKlt8JfCkRPc1piRlTb/05mZGwIVmQfWH+qrCfiWtSJSlB2BXURahZ3/nB27dHVR
         gLuOMt+uZt4HR92worIDY2tamZ0pog68RZbou5pFSj+UJaGU1q4xZhwf43t+aoQZskjf
         v+H/vJs7fhjwZswYLJLfSrSa72tqd3hR2zNgmDNrHjHKYgjdklg4gKx74ITyKf2dhVxc
         MInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783008744; x=1783613544;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=97PE4GxCurgsPgMFgXuN9KmttZbpEHdmlUlFoHEv9hA=;
        b=Mt1D65A/nBmoRgqbNz3FgaLYzT7CBRQ4s/QxCypHt4l1xJLX3q61IK0yHGEKOMjrCK
         ws9CaejMbubOG8/cwkwuOcbE2pAaS+mYB6qWJTpRJSwWc8/MIVPASa4UOeJ/kEEYB3wy
         v5ZpHtLT2h8i8oXzrl24/8iQcFt6l46+Xr7VdZex5Mteaq7YouXcIoxlDdZ0vrmkoDPF
         5RICMLMzmdSD00alJbgimLedhcdkPka+r8/3U8N0v6bC0wfHFhq3cx7ivu6T544HA1JB
         uPNSa7PXj4YhymO5IMkwcR99g35shOp9ihD7NPODUT7v+rDNk82rdqK6sqU1h+gSBhDG
         s2qA==
X-Gm-Message-State: AOJu0YwAlv0s92r/EvKiy+/5GOhwOm+d2J2rflB17Xl7PQBsWNdOHQ+X
	VM9G6077b6jyOF4cIOjIbWC+WTrle0koh3JhKKSjI28NuoJScK+phRg+v5nrkA==
X-Gm-Gg: AfdE7cnp0t6ku0yoIuEFDPLgADw7yFYydYU4md321yTkZ15tEgWCdc7VHVxlIVI1lQx
	f1A4HWS6DY02hJ+D5e1adL1c8rIjOVD38YcusWxheB3vgcitWNd2e2rjdMNh75Tk5tXDFCYXefg
	lKq2vnlExLm4hb/gNysiJtUXgQwKW/uzYVrQgzPV/bb3Bwl4VdBZL+GOMBTTCpKNE7+/tulKP9u
	F2DF0HihG1vLJXAUiVUZSf6xFgAf5T8cpgT+ioLQWHem+hDdeqdf+j9+6VS1AxMr2Kldzc5nct/
	NcyasVh35lr+81ULzZhEy0XdX1n483fVBwTXb9YJgHIwHwuwdcBVLtk3QHNEkf8TEQ0JbFB+SwK
	mimdzwV6qbfWvMHdx7ZUhE2E96Vk57gHmK+1XZ/i6Q4f9JEugtngNYGPZUk4DHXAQZUM3EjDboE
	GAE7pw6UtzVYXVWGdnX5dm
X-Received: by 2002:a05:6214:4101:b0:8ef:1fc9:935b with SMTP id 6a1803df08f44-8f42168d382mr77549706d6.12.1783008744055;
        Thu, 02 Jul 2026 09:12:24 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.131.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f304533sm30184726d6.18.2026.07.02.09.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:12:23 -0700 (PDT)
Message-ID: <6a468de7.cfe3cbd7.10f249.8500@mx.google.com>
Date: Thu, 02 Jul 2026 09:12:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8008743747586983655=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: ASCS: Add validation for PTS SPE test cases
In-Reply-To: <20260702130907.49942-2-raghavendra.rao@collabora.com>
References: <20260702130907.49942-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8008743747586983655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120502

---Test result---

Test Summary:
CheckPatch                    FAIL      1.72 seconds
GitLint                       PASS      1.37 seconds
BuildEll                      PASS      19.94 seconds
BluezMake                     PASS      502.85 seconds
MakeCheck                     PASS      19.31 seconds
MakeDistcheck                 PASS      150.76 seconds
CheckValgrind                 PASS      217.00 seconds
CheckSmatch                   WARNING   289.02 seconds
bluezmakeextell               PASS      94.04 seconds
IncrementalBuild              PASS      661.80 seconds
ScanBuild                     PASS      884.71 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,3/4] shared/bap: Handle ASCS control point protocol errors
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#96: FILE: src/shared/bap.c:3427:
+			meta->iov_len >= (size_t) ltv->len + 1 + sizeof(*next)) {

/github/workspace/src/patch/14659293.patch total: 0 errors, 1 warnings, 33 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14659293.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2263

---
Regards,
Linux Bluetooth


--===============8008743747586983655==--
