Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC36379EEF
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790543691; cv=none; b=Mu/kKMQrZXXyKTFcj5wDpCBkbknMWhRGKcft+BI3srKOtY8s9THq8JcpffoouoCHpxHFDBqLt7XvvHhh0WRHIKNiT99hoZMxJK6G2n+/8ACVeb+cK0d6RSemvSdU/o1NZELI9JOnW85fbMBVQazW3W9czGCRD7lZGLTE2/8Ru2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790543691; c=relaxed/simple;
	bh=DYlZfC0RO5xpp9e2tTBGJcZ/jZ1F7FSCjcHdB3Rhng0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R2oCt9CA2qujkDEzVoEe+bEKpwwUrxgh2266Kwo76JTrF5o1JNTs1maufmRw/wej5ETwTBI+GTjnCTpV//nc+nQ/Et0D3BJPgy7TmT6cWF3y5B/r9dyW+wgfncGYTj5gw+BOQ8Heo0GrhcCOhniFIoSU8fj63ijTBN6jk/eY5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeipJwht; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeipJwht"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c632d5d42so77715685a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790543689; x=1791148489; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JAdJQ9xmplbFds1kV2zRlVGbBOoBLo9J/dikymJQOK8=;
        b=oeipJwhtKISrFwjut8iheprDbTMYY49I0WFy3J6TnbBaVfJr9LrxHllsKiVXlpye5I
         2Hxho/RYZoVX5jbSWThh1w437gNk26NvGrjEdVturBhLUqP1WTgiJTx1uM87WKXK2V9j
         bfaH2qvn7r6k1+INe0ayJQZ5p73p55wi2clLnjbI7IfPT9gv9nkGJiUzwb75KFR+2zV1
         Oxs/Prh/Rk0GaC2yxDv4Uk7SToz80QBcd8/2HO1Hp6nHBsG91bXajzJTqyCJqnzbqO+K
         D/IABzXSLEYJWQy3YwoZi6qx/2qVqWQXIwLg7Nar08TGr2C5YVa113FEkL42cNYvwA0j
         t9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790543689; x=1791148489;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JAdJQ9xmplbFds1kV2zRlVGbBOoBLo9J/dikymJQOK8=;
        b=ziDXdXcwZwOSqW8S1XKwTvgqrWIryQzv05DeVG32hpOy4r21s08k/2LaI3l2bY569C
         0Uw5MXyAO6TFwZbEm0AgSde95dzrvTIzJtJ5XgQGMe+d505gf24ufFcCMNW8TKqK8B6k
         o21XbLNLfNdIQph1wcFyTGlpXXv9tQYnJVVGJ8TBvSZbigHYNa+4eejmXhG8i4mdKMrz
         sL3zGbVrHKOu+ct2C+NO+55/yowTOy3syB6eN3+ar+iZFA44dMkywS38uGAAXItx2lL0
         /btD/OGfsFAyCExcZZOaxl0BCgZCmIZpJyotBqL9ExgcASWImizK2fAkpaMugA7Ilday
         yYHQ==
X-Gm-Message-State: AFuF++n7Ef7ff8R7jvpF2ZEEFr1X3xWNHyGwl/lHCEm4QV3pHUic23e/
	wWmrHeoMQutYS+mzvXPYBsl4nLg8vPtzVS7uXiGNkUM2kddH7LizHHcKnmrjRQ==
X-Gm-Gg: AYBFou0CE979iVeKxQ25KvXAaRRSlCxbbypoFjuDAOj1CRjCY05sx4mxUV1IPAqRUS+
	FxR0x+coQE/BE2EIOhtFfITuSA4mYLiQ+XTl0NIxVPtQDd65kmc0fRmOiGUvqRLnYsR632CNGig
	ql2GqMeoGKHZarGX9G8qRmNxXc2uidVWaj13/GFkHdxY8i+RM26ytVVsaw4xSPWQM3iX0FzTc/C
	DZ6MV7WXDdMm0CijCNPVjMW9xyt6JZ9BdxMuvdZuxgxtEhnuQWGRVFWx7FmY4VfbynjeC/SyP0l
	w0k27ySSlaz2OGc0mK/tQ47HJjSnJys61Addv9SeeBdjEAKw998iMtuAe1bs+w5jYnfAAN0i794
	9DEF3gTyF0UNvUoi98IMQ6VmLeh/hQeNZeMpL1hNf9wz/+kMmSVw013W4gsfMvMyXcU9Z46qztr
	ffkolonkaOOXkJW1c3bMwHA02Pm0P4aUo2buImlVGatICqi8MtH+0d9PZS1gQSvr7G5uScaSDG+
	TC6Eo+IIoOPXsE=
X-Received: by 2002:a05:620a:170e:b0:939:5ae7:2dad with SMTP id af79cd13be357-93c43c9fcddmr1789634585a.38.1790543688894;
        Sun, 27 Sep 2026 14:14:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c7f0de9e3sm17446385a.3.2026.09.27.14.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:14:47 -0700 (PDT)
Message-ID: <6ab98747.f3e70d7f.7867e.7423@mx.google.com>
Date: Sun, 27 Sep 2026 14:14:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1835493640246093144=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] shared: mainloop: Skip removed mainloop events
In-Reply-To: <fc1baff935104e08b170f528477e31bfedc57c7c.1790531371.git.pav@iki.fi>
References: <fc1baff935104e08b170f528477e31bfedc57c7c.1790531371.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1835493640246093144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174578/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.13 seconds
GitLint                       FAIL      0.68 seconds
BuildEll                      PASS      19.09 seconds
BluezMake                     PASS      381.66 seconds
MakeCheck                     PASS      14.33 seconds
MakeDistcheck                 PASS      137.22 seconds
CheckValgrind                 PASS      227.86 seconds
CheckSmatch                   PASS      284.89 seconds
bluezmakeextell               PASS      92.27 seconds
TestFunctional                PASS      1082.60 seconds
IncrementalBuild              PASS      406.78 seconds
ScanBuild                     PASS      1103.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] shared: mainloop: Skip removed mainloop events
WARNING:COMMIT_LOG_LONG_LINE: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#96: 
    #1 0x5637f7b41f79 in mainloop_run_with_signal src/shared/mainloop-notify.c:196

/home/runner/work/bluez/bluez/src/patch/14849970.patch total: 0 errors, 1 warnings, 48 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14849970.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/2] shared: mainloop: Skip removed mainloop events

18: B1 Line exceeds max length (82>80): "    #1 0x5637f7b41f79 in mainloop_run_with_signal src/shared/mainloop-notify.c:196"


https://github.com/bluez/bluez/pull/2597

---
Regards,
Linux Bluetooth


--===============1835493640246093144==--
