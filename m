Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848345A2B4
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307614; cv=none; b=kr/ToEZkWDDrwhLN/MKb00hWyWQNbFaKudBbmeofPbQhBSqJgkKArbY93hioAxSOEz+4CuJPwT8pxzjeR3d+vrdq59LYphSDqb+SieBPtr0NZy5xxbtfzZVS4LL+U+LKcTz0/zLPd0vppzBydMAxWrapLjC2rc7jkwHISCviUDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307614; c=relaxed/simple;
	bh=CkDRGwu+i6BWMxccw5+nrkY6JrUOehELB1K/7wE6HSI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tW0SO55xl0BJTKDY6BQiltertNa0w2GvnWjzDo2ZGqb6nPG5JKFOKKSpaDaWcNatwJgdt3crvPhFUUC+nkWJHjWHcHTVTfXhAAOmgfd4Iot3d5g/Sz0w1y7gLpgWohVX/nfiiBiaXZ0K8zKbSoDDgFP/f1ueDgafonzUzSWoLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+w5iHfH; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+w5iHfH"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-45ed55cbbaaso433473fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787307607; x=1787912407; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WuheTftfkcf58QVxXixKAd377N9Kb7XA8Q0EwkolDWQ=;
        b=Q+w5iHfH6JnLnuD1k0RjVrvI8QkjhaOgDadT5rnPCCDU3FAohlZ3n219jtWx9u1fWo
         0+vs8oQR76e1HDro/yWmCc2LN/h8L4G26c/mqaYPx4ydM4Eo5/OEr7Jhqm1FnG+v5/93
         hhlw7GNfEToECO+kKwzLV8oJD6tUmeBAuS6oocrbEOXQait2SmVWnq+R0nIqrJC6APtM
         mFQmM+87nnnpZNc7GcIZdSGNKxpPaEK2ZCcGv5U5h7myju8U1FWzGzJ/KweniJpbRUWI
         W9PEyKPgDa24D9TCAr2ew7qASewSu97U7tmI0/XgTPt39alKyUsd1EYhCUo8d2849+x5
         leuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787307607; x=1787912407;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WuheTftfkcf58QVxXixKAd377N9Kb7XA8Q0EwkolDWQ=;
        b=li6olXtLqJNLcuFIluS3N3lDHjtXxZsKnLjAJkTGdfEzb4BC2k/punrCp8QIfq35pl
         CcO/W6vwm3I4++MwhzNMNVC0aEL58/aSQykSpsVFJs4JsTP+3S7/Q6lLSvxgGZD9sP9c
         YDCy/35JMOlIQaGOekAArM6fMz6SYpgVuN1B7iwMxKEzikkPvCgm7s+DWscuX8I6WoTP
         iqto3ZbBSpI2UpSiWQ2ttOLxOi0BkBLhaxX5QYg5wStRK1TgvPaAEyiPjy+GF2Y132tb
         UHR6O/xqeCi43ADd0H/RppLbdh66qxt4F4ELvt80mjR3hC27PL4NAm3jGG6aLWaDFMYp
         m/tQ==
X-Gm-Message-State: AFuF++nGh89jMJ5HnbzTJH7v2vpvqXWZZk2z0t29JrccvjPmvN5mAq8S
	KQI3UcGT/Dl1JxM56Z4vndd+fM50pEw4R/w09+x6A2/8N5NJPYgk71BvGfoi/z7Q
X-Gm-Gg: AR+sD12LfstYlgrN+I47pW3wIAtNLMh55w6rZrxVHk5cKVtX7pAjaqV/IHRnEKlTIZn
	qNm0x8VMQd8BoHxekGvfCZZOv5xLZFBJUtT4IxgLtqR1V+PhjF7amee5iy6Scd0tvAGjAaxOYo7
	1wpYLYVZXjR8Rc0DpZUUvBG1vTHjk95yHpVKSvXgsczTe/udyGqTJilgfV3BHWhrJ3aTJs0w2SA
	xR2h71eOl3d7Xm5IFdo4HANVmmLdqKTVfYdMveav7heohtRBHsUM4H+D0TAJernW+CV90jpnbka
	fOqQI6QkuFNKyomEarWaCdeR2M+dwh5unZfWA0GW1vBrKwp3Du7MQSCP4uUI09X2nDWSi8ytZCB
	MkCb8b20zBxDGSjofOPNdYrsq7LSbgTpcSfUJW+mW1QeIBY69fkfm6ygBMMEX72YSdMQrw3qs9u
	WqZIa9cstjSRCaoXfwo0YafJEGvDR4LjsA0wBhfAGlu6hkY17CI60K5ZMoK8JB2mbQxg==
X-Received: by 2002:a05:6871:b13:b0:45e:9b66:7175 with SMTP id 586e51a60fabf-4635141bdc5mr4376285fac.16.1787307606633;
        Fri, 21 Aug 2026 03:20:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.37.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632aa5180bsm3689662fac.16.2026.08.21.03.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 03:20:06 -0700 (PDT)
Message-ID: <6a882656.5f95fffa.d69c4.a424@mx.google.com>
Date: Fri, 21 Aug 2026 03:20:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6331950287990831511=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: mgmt/device: report link security level to D-Bus clients
In-Reply-To: <20260821090908.1546451-2-frederic.danis@collabora.com>
References: <20260821090908.1546451-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6331950287990831511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149614

---Test result---

Test Summary:
CheckPatch                    FAIL      2.48 seconds
GitLint                       PASS      1.55 seconds
BuildEll                      PASS      17.17 seconds
BluezMake                     PASS      474.06 seconds
MakeCheck                     PASS      18.02 seconds
MakeDistcheck                 PASS      129.68 seconds
CheckValgrind                 PASS      188.14 seconds
CheckSmatch                   WARNING   222.72 seconds
bluezmakeextell               PASS      79.10 seconds
IncrementalBuild              PASS      525.85 seconds
ScanBuild                     PASS      715.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,2/6] mgmt-tester: Add Security Level Changed event tests
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#74: 
Assisted-by: GPT:GPT-5.3-Codex

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GPT:GPT-5.3-Codex'
#74: 
Assisted-by: GPT:GPT-5.3-Codex

/github/workspace/src/patch/14760938.patch total: 1 errors, 1 warnings, 163 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14760938.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2424

---
Regards,
Linux Bluetooth


--===============6331950287990831511==--
