Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A61A9FBC
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788116354; cv=none; b=eINnE4SRATxo5A+Z7t98RoxC/rWAhKB/sgbQo6OnDerayaPrEvUSYIRAMEOoCV/TEJJNR0IfYcNbmgdmTByA4/CDVM2PRAXag8wWdAQ+1ylNUjF6ByOTFJIcbJpMJvn5g0mcIRxuyb9bbDc1S4lYRC9tYDdBBwjyIA3W0ZFfy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788116354; c=relaxed/simple;
	bh=rpF9QhPmxwSjwweUXCtCdGvUp5dNeGzLmcNU6i8sw00=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VUPHrOoY9ZQ8zEXlNqAjsRqnMYcVKLNmMBWKS7cD46+JWbwOe6CDP/1yezkn7Y7GcYfH7YwZrG7LFj6QI8WD7wUkvMyXJFLpbo1OCYQCbCes+pz5S5bfQW8d93OInrlnP/0R125NjJT2UmmjPMdyG+NorEIx5Ic1TNsp9kJxBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqex5i3h; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqex5i3h"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-46ac75b44b2so144280fac.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788116352; x=1788721152; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P3LMSI3xLnZyVHVfFnlMGe16RVQe/qMfJq+dk6tLbZo=;
        b=bqex5i3hHkh11sIpxhtDMpfVubKrU/K37cjoYPjOU4zMWbwxqdnuxvel99efVoeHhN
         62xaSi8Ni7IevZ3rv7cvVzEYzn4Kbzzbi/quRdFBdFT5Lb6Tfep5hLsfJc1wFIt/At0k
         48cwwjuWZgYkMDhoI4ZTsC17Js5Oo9ayyUKgjAwfMPi7raI74TKApwl8wSYK2EbGHHIn
         i+XWd2SU6T/9LPKaGCbUowv9VK8fXncoE2waGaocVmJmv36+zXdlP6vrRVmZ+6cK7TdR
         B/3eS4SG08bSmoAPU8a8eu4PuL6TKhBPRMvih8FxeK5MO+QfAHQez96jvyzf8PEQEOzH
         UDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788116352; x=1788721152;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P3LMSI3xLnZyVHVfFnlMGe16RVQe/qMfJq+dk6tLbZo=;
        b=VL3dob8wxugi2GfhXWO/GxHp1ryP6ouIHfEtrK3GpXCsQZ2kD+kkR56FkEigKUEGUT
         05VuJb1Rt+58s1SPrCC00bGaMYnfDSNNevIgi0k0/lFScF4WCkZciRKEAj2g/P2AeiHY
         IgUArga07AZN0c6K3RjYNZF4jmejzGlUCdiQ/P7MEK/ApTS0O3QUXsIdwb36Pq6UBA1/
         UqCa6kFSNvn9QDFWqOdhWfM3v9uNhzMsvmLo002HZ1PBxOx6bVsnZPGjO0qvLcNlZ/wf
         kan7VOgibAkbdfgO5JhDk1SX9j2X6skAzyEBXYn9jZH+qNpCuHrgDrvuqXcCdDsJbPy7
         BWIw==
X-Gm-Message-State: AFuF++mRgt9gVpUbUTxI514gwD3AfGqGHX4XGbMWUq/N0Qyc4dyiKQLb
	ch1Nsbv3RVsChtY9+8DWpJlK+c+B4hdHUtaBVmTjSu4CVotSEjDB3GNZseNRaA==
X-Gm-Gg: AR+sD11L3QHa22ZAwNYr5vypcajbEAD3/8GQDPdbbk/1En5D4pQ3J5CLCQ4HLZeWaFU
	1W4qGY4Tgx7llj1QJ2ieLPlxBwWaNE2aSMo3yxva/bKRSFBTdppO/EYCKBVQKo01cy4pdWIX3P3
	DYLj1f8pJaoeJXdUlnM79YsqO3KtpXqFEkuy5ThWL0b7xMFDFU+FA70mb32NtomMI/ZoNkiiqWZ
	QqMlaZCw13su+VB/QRq9H+OaPjedGTsE2m0pjsVCBuqVAG27CfNZjLR2ThZXGil/JjJCD4TiHz8
	DRiMEvB4bbyYYO99u10CwglFj3uuZY1zpRbNab9DLxIK//FW3WgBwRS5vjVSLwoOdBnFWu+yqeh
	ZDAx831AvAPN9op950fdFAjYYiouGK8RxuGiq24iPQgsCLbT3X1bFX0CvAfY0HStoXews1QPCs8
	xLQ5XBkL74Qe3QgdBZd625RJo1UbFJuPDWZUtUx6Qv82EJMhmuT6N1gMdJKHKZwu2Pow==
X-Received: by 2002:a05:6871:b1f:b0:456:ce37:7f7 with SMTP id 586e51a60fabf-46835a07726mr21266856fac.4.1788116351765;
        Sun, 30 Aug 2026 11:59:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.80.86.193])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46a4b7a9f82sm4452380fac.18.2026.08.30.11.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 11:59:11 -0700 (PDT)
Message-ID: <6a947d7f.298d7a4b.21887a.d121@mx.google.com>
Date: Sun, 30 Aug 2026 11:59:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7638970420934958030=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jhs730127@gmail.com
Subject: RE: [BlueZ] gatt-database: Fix freeing wrong client notify IO
In-Reply-To: <20260830154054.25086-1-jhs730127@gmail.com>
References: <20260830154054.25086-1-jhs730127@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7638970420934958030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153941

---Test result---

Test Summary:
CheckPatch                    FAIL      0.37 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      15.01 seconds
BluezMake                     PASS      575.97 seconds
CheckSmatch                   PASS      190.71 seconds
bluezmakeextell               PASS      68.34 seconds
IncrementalBuild              PASS      565.92 seconds
ScanBuild                     PASS      602.89 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] gatt-database: Fix freeing wrong client notify IO
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#122: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#122: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14775471.patch total: 1 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14775471.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2456

---
Regards,
Linux Bluetooth


--===============7638970420934958030==--
