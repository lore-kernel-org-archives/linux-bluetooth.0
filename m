Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4914756DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191855; cv=none; b=SbNLWA76ItVhK3B3D/iFaXzjldV91tj3mk1zPVibdaXzwyE43ggSIbQAubrvKA0W7PiUlulAByiHkqNWMfuQHPO7a0DGE8eerqDIhj22x5Lb3el21pRPuYEkcx0AtHzsDMuyhQtuZt71OREmnzGEYH5MpGc3zABiW1ZkqD+7Wz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191855; c=relaxed/simple;
	bh=6uJd2JQp1K7LR+nfvvpYo71TMSQq20FuT+/QsD7Ej70=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AkN6n/tB+Hmwe/Vy4FRtT6v4lCxf8jo8OR2Zb91Dmv1zl0SzJ23dQ/HtKjYkRBeZf3HtRpMjGzH5K/Jnux1P8GxYP+2cFdl9caMAeHzscWbdVauGAkqPiMMMKP6YOEPtydniV1oa41reOAOzwE7O7WnGiQ2yz6OOlKSUz9KJCuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYSqFMnd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYSqFMnd"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2cce930cso42038191cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191853; x=1788796653; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b202+k2JUT1O/e01e/RWflBl/LzY80u7y9TrZ6bkZdY=;
        b=DYSqFMndqHElNoN20TvrreNn7ILtLeiJuz1Q5gZ+/1PEKrZ9LVDX7tRIw3/4mIUydt
         nUm6ZI3IgACNA7gZrzNGU7iT+0Q7PfGWJ0PNMuwWyeqKWekzLgNK6W7/LtsTBjLYfIun
         wW72K9Hq5WdPoc8mysPrN3lNJvv+f6o1PtN/pt1UONoGHZalSI+lM3mN3zj7X46spP1W
         Muub6k4AGl57QahuWO/zRDK7kIsXMVLS0xbKrKYHcJY6TNx5BkeTyr0v0HEroVjdIGWB
         V0My01CeFYrvls9xcSNolaxSfWppJIEL1No7NfXNthsVzWhdWzFoN61AZU+5bAOTFvZP
         TJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191853; x=1788796653;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b202+k2JUT1O/e01e/RWflBl/LzY80u7y9TrZ6bkZdY=;
        b=mY11oft6M5R0AqBix9l17J2U+Lv6VItv81uFbdoLX7V1ithHQ3WT95zpYh6n94OCSm
         pllTxYm7Yz5tQdiCCNn8OASSK37mocLQ5LM4kBD+sk6F05WeDBaMMTolY5pwl1EhPry3
         K87SbEMN8xUM+hZh3WfjI0iWF3P00tS3pPJ2+pzJC+Zn4GbN3sxK0592kGnkPFoYdaeh
         AswlUtC6H3vXTumVvzNGe6+R9itMolikbbpmckX7ah/hppWuDJGzH4HiHd7scS7rBhlX
         CCn6N2HNh2BRNyrS05OCgw14ZySEQON3K0smgpR4Zw2CYCMcfFX5YiFvF4uIEccsPgjl
         sm4Q==
X-Gm-Message-State: AFuF++mKHJaMoH3fK+pg8CfpIYbgmOJaeJDYXxiFHrAMQqQgISjku0QX
	qHbxVdOvG5iZ9FrANK6P4vFBf9gLT448RYrXenbIAM/eGCUsKJ0HjvheeVwQpSjL
X-Gm-Gg: AR+sD11HWFMyGzErC4FXkA4qzTAX8aE+xfEEr8wzAZLH/tGjeX92blbRmHuBy4KbOeo
	J6xlEBMUZ/4BbhjG8jKPwKAU/zQ31u6GiGlMhP8uS7+HzgIkL6g7FOt+KHJBMwO6Gx0+Pgug/P6
	pMlde+PDBnySW6TSmbaLy+r11ZvGh8W/F9GlEieEAHAUnXqMxL8dbcHBpPlWKOhC7DLMJ4F7JOE
	aRC6ENHzdSfoRXVUT1SE87VXnF/AkZsd2OpSBXEKE/U4c+dK14PWtQ4dWqZ7DcumP2mhGgaLQvO
	jnRgIwwaKeZd06vvpEOJ58mH9nWhHZ2fp/qBHgjM73CJghy60vUQwXGc8Qb64d12pfLB5tBgQke
	4P/QfsDZa5agTey+yQtE0lBtxgq290DG14vyOH5gLmSKv6hg6WaZd5QqZtbkgWcYzK+sih2LBk+
	96mnrhtXmEeZELAlZa+AiFcJzjBqpSEbCVj1bUqUkJF2avLmVK89687pwbQK39spSR3vqR2A==
X-Received: by 2002:a05:620a:a00b:b0:930:771e:e8d0 with SMTP id af79cd13be357-9391390425cmr2951140985a.25.1788191853085;
        Mon, 31 Aug 2026 08:57:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.223.104])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173a734dsm816621385a.26.2026.08.31.08.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:57:32 -0700 (PDT)
Message-ID: <6a95a46c.5d490f9c.1f8313.ec99@mx.google.com>
Date: Mon, 31 Aug 2026 08:57:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2376827176726912677=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] shared/bap: Fix use-after-free in bt_bap_detach
In-Reply-To: <20260831144437.127711-1-frederic.danis@collabora.com>
References: <20260831144437.127711-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2376827176726912677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154582

---Test result---

Test Summary:
CheckPatch                    FAIL      0.49 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      22.35 seconds
BluezMake                     PASS      630.19 seconds
MakeCheck                     PASS      12.77 seconds
MakeDistcheck                 PASS      163.29 seconds
CheckValgrind                 PASS      214.31 seconds
CheckSmatch                   WARNING   318.66 seconds
bluezmakeextell               PASS      105.24 seconds
IncrementalBuild              PASS      626.74 seconds
ScanBuild                     PASS      1029.37 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/bap: Fix use-after-free in bt_bap_detach
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#81: 
Assisted-by: Claude:claude-sonnet-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-sonnet-5'
#81: 
Assisted-by: Claude:claude-sonnet-5

/github/workspace/src/patch/14778040.patch total: 1 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14778040.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:318:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2462

---
Regards,
Linux Bluetooth


--===============2376827176726912677==--
