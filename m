Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF15481AB5
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065418; cv=none; b=UZjhwYBXUDVSYVaDko55YrzNW7mjCf1dT8rshVQ50V/mc6vrC3YxghLNVQFCoUOsk2R7emF9OCcXaJ2EW2WH7LzQNqS5xEFqjTB/pwnl7NMfx5i6D4kXQXHEXf8ovAurr8QrA8GtqpPpaJo52WTP4AQ6yO8eMGYsSadWnjGj5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065418; c=relaxed/simple;
	bh=K4Fz19t6kqD9KdL+c78PHckz3UVJnC1dW+6LAXc1FI4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DFAiddBGNNLY20e2DDGfwQYP6KMxFJdgBdoftDitIGHJ5ZxS4Y8x4Sw6F66v5KcVRqkjdQNtqetEwaEPrIJjokYlUQJHfzanDuZjOWOG985gV0t4vozk+CH2pB6JCFY/9DUawdWvBlM2H7WqntSGhS/yk+7KuyUsHyaqMuyMGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8Bq2E3h; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8Bq2E3h"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6f5fc4so83347eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065415; x=1789670215; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EvBNhH7/bU9oV6Xz3b4RLEbYgyDVHmQsrra6DPKUKAg=;
        b=l8Bq2E3hQTa+2yAJeMI4IaN72vOxTUzFFryPsL1m6kXSyRtrrHPuy0NYp4JlUB3k6a
         bootLlQhRCT1UVHT3O9b9rmu6hHNJ7IPNgUyCNcQ/2jAKghqwsUWVdVxiVEagJsqR0YZ
         fUpvKkwg/3vWvN+rLKpDy+xGdcltBQVys3jXH8lCyEyQJMjyloti/UF8OECg6gRbGGz7
         xcoUtCg71+zt+Hu3J4yS5TNRfOl3V3YSAV2KIC5EIkXLEMB7YMi1SNEapFLZvCzboZ2M
         TNl6itsyLfgp4Rl2EtZ7w78xEwZVYHz7UGHAmUrOIcVRXtXedDshV23Pelw7+KaIfHG3
         8EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065415; x=1789670215;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EvBNhH7/bU9oV6Xz3b4RLEbYgyDVHmQsrra6DPKUKAg=;
        b=FQLodlKf8hH7QVa/ryZdRa1xi3Zz5f8AV53DO2nq9dptETWBtE8nYgaHfjGM92OSAK
         +a4Cg8EJMzcfnwmqUEN6ahAih+EVJ6PvlLSecTtLGZghfTpBODW3MXmNBlCtfpUd52As
         NdxCaQt1dVcrE5lY4iktbyNsLRDZxte4RqCHy1doHq6g04fHtt15Xj6U2HlmcelBJyNr
         blS9lQ79fDskCPYPneVqaBkVk2fTvOnXF9ey9axXHwaV36KS0uOwcjjY8f39/V4D2rvb
         XgSQA9upaRSvh0n9sBQN+2xmnT2K+GyK3mOAKricd9hNE0e9EAB8gy+PiF6/wnEf8tNo
         hCkA==
X-Gm-Message-State: AFuF++m2WRX8/ko3P8q8uZfuz4nb7+S0hBHgJdl3bHKqZmNagoWHtCvI
	YSzuNC07uzvTob/gJOdcbyyUa2OMJ/Oe+cMYhPoKy++UAzMGYgYfMXH+mXx6Ag==
X-Gm-Gg: AYBFou3Rj0o9ChyUjswZWkbm9CNq3SDGYKzr1FCKNoDjL+C+HG3dOJa4/1a65ZxCcxB
	Y8tjLtIZR98Xpi0Uk7fYf2w9dd3KTx38ct5IPobK/R7Jtx9WD5MxYnco91+nIHa0um18sLTjpc0
	Z0ZhooJQfU0UBxg+/bAVrDSYJcsstq7O3aBtJLTR6oxz7WqpLkfc2jTDYZivOaCnHk58E9MkjUq
	R3auJIijMZ2MpyC46bp+qRlCn3xi3O9OAyOUA0WhmQhTMUM8EPym/ORWVYSRW4TUAXI6XH4qPHo
	md6Ps9b/wSECUbWHxYfOhhhozf68elh3nXPRnc0jSCRUa+hvcsxSuPF9nSnoLiz2DBhkfv/m22u
	hAcHCDDzUDBFjin/0CwflkfSdK9cpZfGCEX9MBTCB19BLBAG8NRKMjV4S98NJyYHIf2RVgcOF4h
	4QCZmnbKR0MnXaJfiIN24wQWAFNH3esZZLkh1CmJareNbIoLnjHQoMPrAAOmxgrVsAadRcnNNt8
	jlibQ==
X-Received: by 2002:a05:6820:c0d4:10b0:6b6:71f7:ecbe with SMTP id 006d021491bc7-6c0bbfde86dmr305132eaf.18.1789065415569;
        Thu, 10 Sep 2026 11:36:55 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.19.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df64dbec6sm9665fac.2.2026.09.10.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:36:54 -0700 (PDT)
Message-ID: <6aa2f8c6.54a17f45.182fd6.226b@mx.google.com>
Date: Thu, 10 Sep 2026 11:36:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7054091393082327480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, m.kurz@irregular.at
Subject: RE: Add component batteries and Fast Pair Message Stream
In-Reply-To: <629f0d030e62a80caef0265bd04f541cb8eb0693.1787327795.git.m.kurz@irregular.at>
References: <629f0d030e62a80caef0265bd04f541cb8eb0693.1787327795.git.m.kurz@irregular.at>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7054091393082327480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1149924/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.91 seconds
GitLint                       PASS      1.07 seconds
BuildEll                      PASS      21.83 seconds
BluezMake                     PASS      389.14 seconds
MakeCheck                     PASS      14.12 seconds
MakeDistcheck                 PASS      141.75 seconds
CheckValgrind                 PASS      233.56 seconds
CheckSmatch                   PASS      293.14 seconds
bluezmakeextell               PASS      95.25 seconds
IncrementalBuild              PASS      434.52 seconds
ScanBuild                     PASS      1140.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,4/4] test: Add Fast Pair Message Stream tool
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#132: FILE: test/test-fastpair

/github/workspace/src/patch/14762095.patch total: 1 errors, 0 warnings, 576 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762095.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2515

---
Regards,
Linux Bluetooth


--===============7054091393082327480==--
