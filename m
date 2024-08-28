Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE515A851
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831107; cv=none; b=GajYkObAaPfEiDaaI3zZOZAEZ2snoiX8Y+/EIeQX1BTq9iesWAh/aR0sZE6Ks0qsQYu4ETc3CNso/SCSyPfbtghYAwTa6gUyWFhSs6chSbnsBFq3kXUoBMLl6w47KSPw8ihKwNMIcl3fgIw3xuUOxFoWYSw383TbxWSPfjfRGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831107; c=relaxed/simple;
	bh=IAJrz9zw0e7vZa845yOO2+tV4ZYYvHMSWGib7eaN9fA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s1Sm+6aFXoPqIdkUxGdA7kwe6BERDwYFjihHRlLRwPVJLY9O/g5/xmRbiq1XMNUCkuJFt+lCmv98dFZCZxXnyN2rcTa1Uydj0ZTGonmGYAImN7IbiA9NtWufbTZVyaLvMScCLPvCOHR+dVgi5M7/AP3JpdR0OSkUuY0zJ3RhG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCQgzZpB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCQgzZpB"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201fbd0d7c2so53145605ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724831105; x=1725435905; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hQdAc2NqvKJYINkVnBlAh8d18FKejKHjhpu362+l9UQ=;
        b=LCQgzZpBihUblwizWY6xIM2DHk3vmU9trFGtM9NpJuK1WmC8HZIrzlNLDw4irtkRQa
         /kxUbFLeZeM0T17Q1/M3pP6RM6uh3jpHbiN+DFGEvnzm3NWXKjZLJiwU+8ibbvxdaiNo
         +NAz0ZbNEOLiqislLPLrjRile53+ko1Q3md94XShggPU/EBtvI2VlE1jQZQBKty5XKSR
         bN/SmxH7xt1qwjEiP4X/DqgLlugZc69z8Iqi3NJYxutOqH+Jj6RHxPSU4keUQ0yQYg+L
         lnCUQ+Z9zsviGcdBenTyHLzxc3wkHbBWovW/16ukPeK5GJL9AufChYoqPImUJVuu/Jgq
         ycag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724831105; x=1725435905;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQdAc2NqvKJYINkVnBlAh8d18FKejKHjhpu362+l9UQ=;
        b=S1oVSe95omY2ONKZQK3giqicpfw7ZcNlUKOUSzPQUkNVgUgiOp6J8BMrj303pE8P84
         4T1bbpbA3w0bsWbg0WGWccigGr5ilnZpQHdpSUt31/KbTpm+7oFON7Tpl149edbm6msX
         3ZUcHjXZwqYgpeIqmwgxkgrs9l7DCRSbM9MxcKH3dkImc/DXT4b8JugGacsYEZ/omMe0
         3QKQRIcKeY5BgLhI4GbpW3euhHW1wXPrHYy1sDn1ZkmzCL4V/25E7InLAL2s54veZsx9
         /uNgGRPWS4gXhbA+JcnkPxqhF5FHYZXzu/hpynEcd4Nc+X/AOxRYQa5T5w7pkuGGIXT2
         CJvw==
X-Gm-Message-State: AOJu0YzV/0BAFMfI6RAW09ap3bsT66/U2CQnKBjgfU361lGObN/9Rs2K
	9YqmKHLFhDPl1Wd0i91jFQCc33pY61A4falQiKNS8WvvdDHiHoYA6jLLmA==
X-Google-Smtp-Source: AGHT+IHwtclhzhgV/8tyYwUPVy1W3sTF94bBXCW0OmyN1FryKZnAB5wD/8qGVHZXDsgqcSQnyNBI7g==
X-Received: by 2002:a17:90a:df0c:b0:2d3:c6a7:5c83 with SMTP id 98e67ed59e1d1-2d8441b1f5emr1298441a91.35.1724831105415;
        Wed, 28 Aug 2024 00:45:05 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.227.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445dfa64sm963374a91.6.2024.08.28.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:45:04 -0700 (PDT)
Message-ID: <66ced580.170a0220.1fd9a3.2824@mx.google.com>
Date: Wed, 28 Aug 2024 00:45:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1324967068314587638=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raj.khem@gmail.com
Subject: RE: [v6,BlueZ] Provide GNU basename compatible implementation
In-Reply-To: <20240828060926.3710535-1-raj.khem@gmail.com>
References: <20240828060926.3710535-1-raj.khem@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1324967068314587638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884094

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.18 seconds
BuildEll                      PASS      24.43 seconds
BluezMake                     PASS      1670.47 seconds
MakeCheck                     PASS      13.81 seconds
MakeDistcheck                 FAIL      68.03 seconds
CheckValgrind                 PASS      252.55 seconds
CheckSmatch                   WARNING   356.66 seconds
bluezmakeextell               PASS      119.91 seconds
IncrementalBuild              PASS      1469.35 seconds
ScanBuild                     PASS      1011.25 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
../../mesh/mesh-config-json.c:31:10: fatal error: mesh/missing.h: No such file or directory
   31 | #include "mesh/missing.h"
      |          ^~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:7850: mesh/mesh-config-json.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4676: all] Error 2
make: *** [Makefile:12226: distcheck] Error 1
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:136:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============1324967068314587638==--
