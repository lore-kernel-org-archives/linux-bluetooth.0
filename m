Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BB6481223
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154338; cv=none; b=buanYLBrG91IATwW2+YRXHLBMa/Dfn3mp3Hz6WlxXx6peSwXaDY4TuNYA60mwiNlNATp6090qyo93EJQNgsCp6oTGPIQhiqsRBlmZDc5/4pKOAykHS+269KtEI7hhbBsbrZNqYp+jb2vM8SLoA7AF0LeBKnSDaYVS81Ivv76uE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154338; c=relaxed/simple;
	bh=NyaIaBT9ZDMcyXAB6Iu1EEM0K/K8Kz+LnKjB/6jLHdk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bD3fXZwVRXvSI/Ab3iTz5uqSWFoAnw/USwwI6+sVHpwJ3HsxsePdtCEj300azOa030G8xxcXXtwdKDfuaSi8oKUcbitEO8BXTRMxuwiwKHaiweKCgXiMVkTl2bEZaqWVVOUdiQPi3tYWOwVd2d5hiktrKOq/j09MG0Q5xmU2WS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikS/jVg3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikS/jVg3"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8f032b47e3cso9395466d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787154333; x=1787759133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7jySN9ZPRFbIUFsoY/2LrHKwfd14jPLyh0tsPtGkqzo=;
        b=ikS/jVg3hcv30JH+IaEh8haEcfBV0/SuZ0s47YvSiRwSKEGczFHMtEJ7XJ55jFaiy6
         rcutfyDU02T2afj6ELVXEScxdGQinp1yM1ljsLHTyTT7kvXb6eUv4hCRRmANFlePAfPi
         quTnGJg0dJ6oTuzpFXV44FYb6HF6PEMVp8mgI9qstUPqX4GEL7zTkhECVvRBcpe62+LU
         gcV1KLGLeZJdt8M9aD977YOR/GJbySvi537KaBqJXlHQx/LL/nOvhTLlBL5skr1fkKRC
         Hz+mrz8vSVTLQVjPInpF4jPJVwkGmCXJsYsR6ule2pzF2oczfQkxu+zyrFAy8cbFAVCD
         QVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787154333; x=1787759133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7jySN9ZPRFbIUFsoY/2LrHKwfd14jPLyh0tsPtGkqzo=;
        b=Lz1nxk4sc/Dtz4mvWRG6Sdpu650t7IaIrNT2pAkNXqempgQD0JoMmPho3Fy2ls+AL9
         UR8GbU9MVZQhOZHkuDliKaHCMbEqokRLnAy/3ZrmObbKbJtf8BklA7R9EWTnwlLpYNQY
         WP2FuMoJ5tU258C/xsoPWPVBp7/ar/ITlVRUINORCZzNlXuHeKIbjy8DRm8IESIiD4jh
         BXGjj3Si2TCfttilbSOKjlS75GD3iK3lQW/yXng7UdZawRhauohXrimFdteCOBTOXscV
         K96eCIcLlj97gwCh+10fJ787qLjF3eeArx+X+c7sBTUNkDK5LVQolklbg5iQqCT3A1VZ
         jAYw==
X-Gm-Message-State: AFuF++mLIniNMaIkT4O7J3j6wnpgoS1k+myxLwxT3abUqgGGWRtmeLrm
	i+bg0NgGdvvcAwxluvjOkgSqmhQbUKpO12aW+eCBTRr9h7CXHjCzltm4CrqmXA==
X-Gm-Gg: AR+sD10KM32oEflto3J5k66t20iyDJKdEdZ1cCK9RlcUtvrCf027mgQbznp74O1XKfS
	1ZpOvXzkdJpN1XwzQxgPAJgpYviJl7Sa04E0lPgj/f5ZCofscQsFUdyaDZssl9HZ8dtYqFfQdqV
	Y9rzPcrMiNlLmSCMo42+sKaoIs9L27MmnTR8hv1pSaSNjdMMFknXCFeLXlFqKjPCOcEbZfagrT5
	mXAS3PUOrgJib6lz0w80ZYZfooAGeozOtfbYhjtLANEXjd5G37w2AJ6bpjxcGtyBA5EYMvmFJLv
	BzTX+M80D5efmkqtdayW2l4cItxJuwBjBqpMcVRGTKJCfW35GKAFfSG9Qz+2Fdez7KnpP4aNG3N
	BGUJIDrX942I6EhPWQz+UyDLh6/+4TI7rvlVbU9lWNDcI23S676lYBeka/KGROHuaAFHBKxGjtA
	rMMdcniCs6ne71d0H6U4AHN2A6tizeGx3k6kI14QlyTBAQCjF3f16Rm0pVM5jmhE9qtRU=
X-Received: by 2002:a05:6214:76c:b0:8fe:5a1:c97e with SMTP id 6a1803df08f44-90c5eae9ed9mr48759506d6.29.1787154333026;
        Wed, 19 Aug 2026 08:45:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eee3936sm17216566d6.20.2026.08.19.08.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:45:32 -0700 (PDT)
Message-ID: <6a85cf9c.656efdb0.17cbff.6c77@mx.google.com>
Date: Wed, 19 Aug 2026 08:45:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6643732996335718428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: plugin/admin: Make allowlist adapter-scoped and enforce at runtime
In-Reply-To: <20260819144337.889893-2-frederic.danis@collabora.com>
References: <20260819144337.889893-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6643732996335718428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1148530

---Test result---

Test Summary:
CheckPatch                    FAIL      3.55 seconds
GitLint                       PASS      2.31 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      573.96 seconds
MakeCheck                     PASS      19.15 seconds
MakeDistcheck                 PASS      156.08 seconds
CheckValgrind                 PASS      223.41 seconds
CheckSmatch                   PASS      299.38 seconds
bluezmakeextell               PASS      96.93 seconds
IncrementalBuild              PASS      645.06 seconds
ScanBuild                     PASS      886.24 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,1/7] plugins/admin: make AdminPolicy state per-adapter
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#84: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#84: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14757533.patch total: 1 errors, 1 warnings, 259 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757533.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,2/7] client/bluetoothctl: make admin.allow controller-aware
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#79: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#79: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14757534.patch total: 1 errors, 1 warnings, 170 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757534.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,3/7] src/adapter: enforce allowlist for local services
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#86: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#86: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14757531.patch total: 1 errors, 1 warnings, 178 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757531.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,4/7] plugins/admin: reapply allowlist on policy updates
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#74: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#74: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14757532.patch total: 1 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757532.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,5/7] doc: describe admin allowlist runtime enforcement
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#78: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#78: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14757535.patch total: 1 errors, 1 warnings, 28 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757535.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,6/7] device: unify admin allowlist checks for device services
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#97: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#97: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14757536.patch total: 1 errors, 1 warnings, 106 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757536.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,7/7] profiles/audio: make A2DP admin allowlist enforcement role-safe
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#80: 
  blocked roles to remain visible during capability negotiation, which caused

WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#101: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#101: 
Assisted-by: GPT:GPT-5.3-Codex

WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#227: FILE: profiles/audio/media.c:3179:
+			info("Skipping endpoint %s:%s (%s) blocked by admin allowlist",

/github/workspace/src/patch/14757537.patch total: 1 errors, 3 warnings, 112 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14757537.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2414

---
Regards,
Linux Bluetooth


--===============6643732996335718428==--
