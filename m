Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2695A37CD5A
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332094; cv=none; b=le0lIZ8I1Z5R8iZ/wFQOv29wHwu+Tf2WFhrJ6z6le2fxugpzdeiaaYlqeHJfdalh5zBxfJdY1n210NGMKO1FPTVe0tznaQIMObpD0prdZ7wSkDEbGso4xxZ645WQzZ/9ycBbT2yLdXndj3+F9ToSKoU/8/860TUVCWKg0yV7xq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332094; c=relaxed/simple;
	bh=w1t97NcOVQqRprakU4ofZ6V2tBmSC4uxd4UTJ2HrrrQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JyWiI+/KSUW+jVzfh/diBMlBvGIhp2izb+BCozRl+NUYWPf2b8WMm881Smr8OPpi7CLmw3vafddxSxwQQMQ0ebhiuy4XmPH0Wc0yom+6Bp1J0zk7rMunSFrfHGqWHaOz/OYWxOHqAC1185i/nXm5f/nrfwuseuRiXT/WlWZN40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=datKhMVG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="datKhMVG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-936e8bd9caaso88472285a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787332091; x=1787936891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PooHrXvgnURML02hHUznpcQT7NEX58t4dbemYAwwzl8=;
        b=datKhMVGTPiirQIhjrVoVtvmLhS0h1GuoVt1csaeDMZ1uZVrgDk/bgrQa7r0gBPcv2
         JpiVqUnMuTXKbE+xwNfv3J1eJWJimo5T/QtOdXn524Y2y+x7sNS+LDFfm1VfaHLiqjFu
         Oc1MJlrda56FrHpExun73+aWXAEajV0zaU0ziwkZmyog96pAvw9XFyHiof0XpJuk5Z9M
         1JObmtPhuScrN3536vkk68sCJjV2A7CwOKmR09wWZcFfEgGLEjMavA0zcd+JwcrZXfE5
         N2uB2Pt8ts50qtMq7cmUQrWnRgtuWxKZLeO1Bl+2dfmU2E2wvY+9nvCSoLtS+NvhhpU5
         owzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787332091; x=1787936891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PooHrXvgnURML02hHUznpcQT7NEX58t4dbemYAwwzl8=;
        b=RbZeYg+VJdUIs9v51FLh81XOvfbYQOmAzaFWajbe0IXBGWpvzMDCcRn9BSze1Udftq
         lfwp5WDtQdF25DhSRx7mmn4dAX72DkOMEg9u0X4OnlVbW8h87hq5PdKC0uA4MoOj/sgN
         BQQZU07s7RaMHoRY3rhkjkQ67lndDYGI/PVLF33WA8uWhEUekjAudUutnU6zsDcPe4A4
         kblRwr0IMRbjEFiUIoPC8kVuvRbSBIBmjkJFXNVr1ZtvuhWmqhv5WGQoBNPrTlO2onln
         lD46vDvThK3x5L0a8UITPW+LEuTiRNvesBJBixE54Nj6dhEfEEfafuHjYp45lqCa8iFv
         E0LA==
X-Gm-Message-State: AOJu0YwuaccSN737JENJpH+p1LZWrf+AF/IUpmA1cEWETxLnU0VBvBdp
	sHG5ADkSWYwdx+1xxrPanaFSCAne87t2khJWE9EyloLZpnl/cMK0M63/cg/6CwjGWgs=
X-Gm-Gg: AR+sD10mGChusDwmhpVgzDaW6itLlIphGr/qOfUss9eadW2dKLzYYLkSjrBLOazL1Hw
	0IxesPSY5XQ7rM+x67ZQ4a5xEqUz2Ag02LCAAlOWHCulTDQ3k+FpLxajkmLDcy2UmhA2Sb+yj9x
	vLhzOBZ2CISrriuKvDOTq2QR7OobTkfilw6GQQF1uRrPzAlFMdeHS17XxXV48f0dSvMScZ58JgL
	sy4WzsynaC85F5X2pps0X22B8i1NaMV2Zinnf5Tuzi5b5rn4taEohLPyZp5BLQ9ku1J+JaCNev2
	B+R83v4Og8WV3dvuK+8u0Grb+gEASEZTDi08zMJ8itMaKrjyXKtkCj2W/5UA0K9H1r0Sr6c22Ti
	t4ZEXAdQCYII+GhVriXqHhSL8Qn5ufVvVljw02qRgO3QQ6wKit6LomWx4kSuHSflZ7oT5oaFW+I
	Hlyq5hOoKz+DNPQRmz9pPyjBR0DX4AgNLp0jEv14gWPyZsIcO5gKdc52K19bWoka8pAUH+cwd+u
	P8ifi1O
X-Received: by 2002:a05:620a:3724:b0:92b:32d4:4af5 with SMTP id af79cd13be357-93739431d29mr716481285a.5.1787332091421;
        Fri, 21 Aug 2026 10:08:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.97.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372ea69aa0sm386851185a.4.2026.08.21.10.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:08:10 -0700 (PDT)
Message-ID: <6a8885fa.bb95a62e.38334b.ba6d@mx.google.com>
Date: Fri, 21 Aug 2026 10:08:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6415287051029713433=="
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

--===============6415287051029713433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149924

---Test result---

Test Summary:
CheckPatch                    FAIL      3.10 seconds
GitLint                       PASS      1.34 seconds
BuildEll                      PASS      21.53 seconds
BluezMake                     PASS      626.39 seconds
MakeCheck                     PASS      19.77 seconds
MakeDistcheck                 PASS      165.13 seconds
CheckValgrind                 PASS      236.59 seconds
CheckSmatch                   PASS      320.33 seconds
bluezmakeextell               PASS      103.89 seconds
IncrementalBuild              PASS      669.66 seconds
ScanBuild                     PASS      1035.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/4] battery: Add component battery objects
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#114: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Codex:gpt-5.6-sol'
#114: 
Assisted-by: Codex:gpt-5.6-sol

/github/workspace/src/patch/14762094.patch total: 1 errors, 1 warnings, 575 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762094.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,2/4] doc: Document component battery objects
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#107: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Codex:gpt-5.6-sol'
#107: 
Assisted-by: Codex:gpt-5.6-sol

/github/workspace/src/patch/14762093.patch total: 1 errors, 1 warnings, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762093.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,3/4] fastpair: Add Message Stream battery profile
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#110: 
https://developers.google.com/nearby/fast-pair/specifications/extensions/messagestream

WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#132: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Codex:gpt-5.6-sol'
#132: 
Assisted-by: Codex:gpt-5.6-sol

/github/workspace/src/patch/14762096.patch total: 1 errors, 2 warnings, 1207 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762096.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,4/4] test: Add Fast Pair Message Stream tool
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#111: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Codex:gpt-5.6-sol'
#111: 
Assisted-by: Codex:gpt-5.6-sol

ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#132: FILE: test/test-fastpair

/github/workspace/src/patch/14762095.patch total: 2 errors, 1 warnings, 576 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14762095.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2428

---
Regards,
Linux Bluetooth


--===============6415287051029713433==--
