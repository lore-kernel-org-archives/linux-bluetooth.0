Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D043AF678
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101957; cv=none; b=ogrBx9Kyi0K5QFpoXq7VyyLfydRDnGifKu5RwOMPMRXPBGdvum4lcoP2HKP12O5cEM2zj1AMSRlMl2MAaajmtUEzvnxl1gpxyVrllQbxgkzYkYHskegjh8DTmK2g28/FWfY75ZdfhpPqJiXahllGaZITpKhmRIcrll66TtH9nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101957; c=relaxed/simple;
	bh=Y3qFJx4FfKfss8HEajFYuD1hv8eSbLpGtIZpyoVfCWE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IC/4CsRHFvV9W7UhwlQBVItnXPSe2zXA8YPXnvQ22ugcQitJgsqNmA6HzEV4pDIwlm6ZhtMegEcVNeQ1At43tG/x64N7WUvBSBejnFzvs2+62raR9knfXNJBfVhu7vI9vSPZKaO3xO+IZGyntubpH+DRm5jhps5Wq/QeW6mdNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu49/nB6; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu49/nB6"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12dca45ca21so304795c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2026 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778101955; x=1778706755; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bGHOSXrk5rD71M8MrW99MzK9dalkQvrjMKdpB+khqcs=;
        b=Wu49/nB6HZoenHjVQ8nLHsVANlo9uapDxO9GQLOABBWRThdGwmMpqpQNmoftN5LZhZ
         AnDNuqQxXL0MUsyMtlu5uvuldGMhEjb7jRHdvN3zl4SJjeCefljBghc/tQRFfxx/TFA5
         g9NHuzNyd8U0FaRdFiMUjEBjE8hb7EnnVkSkUd5VEeZaeEbPG1GSn2J1np/1ZcD8w2Q/
         zo/GZmHcY0xBPxRK0g2Dqjs6CjY59N/NmoH0fOIO8Z9BRiIrQRqgeLVUnB8jciwTdgwm
         v/326LWPBrERMBdAuyDtSPzjOT7mTZEOQCazwUSK2K7PAagCno4k6WBHmS+aKmfnPOhs
         1xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778101955; x=1778706755;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGHOSXrk5rD71M8MrW99MzK9dalkQvrjMKdpB+khqcs=;
        b=D/RKMkcN1jKxF5v1Xvtl9lmGM1S1UJWbmtKBoEsUeaDkRreqwABzuO+R5y4x/Msd90
         ufQWMSHiKbYfACctdbqxGWTgfIz07qL0LaBEL6NQp7yARLy/FKIvLz83kIFPQr9aXhMy
         TjNucQmHcB+dTnL7/LSkkuf2me8YO4sSAVBSZ1yp1d9oWx4tdfyl5SiGkRCd2weuTtBQ
         vysyj/oSj/yzYB6ZDqhWg6EOeOAXm9S/U2bjTsxRGBsVoUL/N/FDB5A/jRwTGGAxyw2x
         TKwM6kjNpfYstzFRood4W6ypatT2xEhQl8z8gnAGTiC4EzU8iQEg/QySt95sGbWRlKwu
         dFNg==
X-Gm-Message-State: AOJu0YzF9ALqco+NqwJxMcfKJ3dvEI3ZZRWBg2Uw1Cj5icb3Z1qO4a/D
	jNdouzA0PPfGByeW6lll+hNGQUp0SwO7Bp8drTx87lqKDn9ttVfTTLWi3YfQ7g==
X-Gm-Gg: AeBDieuE9W2BDlrd++QPjoCXArx12tw9q6LYo34uoq5WO0HC2K4XY7CD5NQztapp4Hk
	uDMjXW/NBA6+HI1W9lGdpZqSAXX6O08DCQjUcy9ypBQgxTMAaAfmqJ62XL6c+xlrFxQN+YTEymr
	ri9ylfBfe8cOuYcN4Ofdv4tiSojb3kfjDyiVK4GNzDbZCAfgTHBNj+kkri2/AQYQn5+n0JfDfZT
	gKAdDs1ZhChInyrq6pjmfDek1Yo64mcHY5+L2laU2ABww1CIFkMBKlazHNiH6JTecgUfvCSHDrs
	lIncPKSrNZiz31DVtLZSn29NqBs955I3nYhbZ8282NKlVLFlvUKw/6sVOCugUW19RS60pDkgDbV
	WDEjYam/57BKBsiTkzxLhM0C4NPS2EyTjiLO4nUF0CbJ2ZUtxHx8YhuSKpnLdb7jwid1S2woo+s
	4jOntO2NjGj6WJPfOhbW4mkxb4Apc+PLx2Ghdh4JslJu/4Ly9oXfqR
X-Received: by 2002:a05:7022:e981:b0:12c:66fd:6595 with SMTP id a92af1059eb24-1318eb52ed7mr2613759c88.34.1778101955160;
        Wed, 06 May 2026 14:12:35 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.137.133])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13202db1914sm6063773c88.11.2026.05.06.14.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:12:34 -0700 (PDT)
Message-ID: <69fbaec2.050a0220.b3c4a.10f6@mx.google.com>
Date: Wed, 06 May 2026 14:12:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6254420416765616480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] tools/tester: Fix crash when hciemu_new fails
In-Reply-To: <20260506194150.1701855-1-luiz.dentz@gmail.com>
References: <20260506194150.1701855-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6254420416765616480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1090665

---Test result---

Test Summary:
CheckPatch                    FAIL      1.10 seconds
GitLint                       PASS      0.74 seconds
BuildEll                      PASS      20.80 seconds
BluezMake                     PASS      652.47 seconds
CheckSmatch                   WARNING   352.56 seconds
bluezmakeextell               PASS      184.99 seconds
IncrementalBuild              PASS      680.38 seconds
ScanBuild                     PASS      1001.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,3/3] tools/tester: Retry with debug on hciemu_new failure
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#241: FILE: tools/sco-tester.c:196:
+		data->hciemu = hciemu_new_debug(HCIEMU_TYPE_BREDRLE, print_debug,

/github/workspace/src/patch/14557929.patch total: 0 errors, 1 warnings, 100 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14557929.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structurestools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2103

---
Regards,
Linux Bluetooth


--===============6254420416765616480==--
