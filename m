Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0060282F12
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240436; cv=none; b=SSlqNLpWNfWn70NJ7C49KrmxGnPCuBCfFPz7KuBhHdE1w6DADdz2WHpK5EgLRCwRadt8AYUGIQ+chbv37KJ8lCdNpkXluzCyD/cxdN0nHE+D6PgavPL6eLanzl1Q4eH3GgaBqt3vE/DHUfORKh2/m8AxclRjlKUHSxTZr73/dmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240436; c=relaxed/simple;
	bh=IiiHonleB0c3UBRwLK5PFyMK+79UDCg6n/HmybewN5Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZTqLAipSeBq1ndFMTGfT4yHCgFjrcrzRF2DT5MfopnN/KORFHLxEn0TT4IiQPt71lB72wvhnKSJxmue2sqTSP5TpHpvZHHNonlehjpq5FPGe8Rh0RJG+uqOsF/xp9U+79RuQGlHSImerZTshm5h/sqHVdX2cgmb/6OeUBVp3mvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6vgMkYb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6vgMkYb"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso4389618a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240435; x=1784845235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FlkEVxAeKVN9OTdcdam1ZBtsJq4w7gHjDd92/10jVYM=;
        b=F6vgMkYbZnzHGgxIS38tPvQ8oenh+gZLWubO+EKioS5eQwrAr81AIDkNaWOq+fxxVd
         YNc6fgQFHyjKuT4rPe/z8jfjA4AjrtXi9XyMa5d0gY8Wzr5p78DuAgUAPqlECXs46GbE
         iyoU1RtfNBTs557R5vy6BfnUOQpWzK1zvAgkZKd3sE0bOOviEqg5AbtQ42e5+/u4rrzz
         nby3Rj2AJaALB9i9eIK24pLq+9RFplJ9SQyd96Cia46uhUPkvr9dMOjxltXImYvlKHm1
         1MEU3kAO2yHJNojHxwg7OGwf2JpwJzgO2OIKtSzuZHJib8OE1Of/bYIkP8LgQijymG5E
         Y+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240435; x=1784845235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FlkEVxAeKVN9OTdcdam1ZBtsJq4w7gHjDd92/10jVYM=;
        b=laAhrEmdZfJiZcOD8S/i2wuApt2Ymxhd2F1MG1MLBMAST3qDrWXvFOt1x4NvYYRbLi
         Pn2vFYJTCgWCqEQBdOarI8S1ATW3m73seZ9BkLcNdJV34KkDe2NteFC54/sDV3hZmjoM
         rBtKvCl/WZ3IqBu1Yb2w5B0qto3behe3AEMfAvj2TkkXApVRUVQ7MQ/emq+M/OAvyzVI
         Mhru8B+Hz7Cio1SHe2LdMdWB3r863GYDB+aqQtVghRVhrfvlJWxNzmHrQeRlKLygFR9N
         DNBM2Tf312Ej4U227/OZyz/Tk+bj1B0T9VUwm1DW8fzj4YNHINgPtAeqNmWOB0uC/MCS
         iYfg==
X-Gm-Message-State: AOJu0Yxd44ZlotV5a1fTJevn4y7G1j6xC/rmRRMrRKP1fg2rFyL0v6J9
	yRFU0swKdE49kalskAY4Feyl3IeDdZSVp2fjL/e+c9O8/LTya9unQbACArGxsA==
X-Gm-Gg: AfdE7ckF+34dnaM4zzNxqXfnHO904YovyKgyrvK77bXq3ANhFPVJ+QB3vXTa1DsbfJt
	oDdzZ+ZQGYk4otI8a/wvbmtg/3O+J/gJgBMF4Kb3ur4usDPrKW9yeeaPnLnb1mnNA5TnFmHqrHm
	04h5/0yn6n1JXFWe/brHszwnMsYOoqzAdo8FdSjI7NivYNX3S91rYpC5PcyWPNT+Nbzt0FiMlPP
	Mw/sJ9hUITKG/kYqRO/iEHK/EK2OuGHw26h2oV1zrDfFKEY8Gzo0v7qoMN81GsZhn4wAgcof4Ae
	ORylFleZvJzRzCKnrk+Us0wKQoDOGOO9qi8RjK4nv3FyhLJR09qyKI6YRZFGnxQFKuS3i9p81e2
	l7y8jd8JZWPNi4YPDcZ4dxrQmJS99sZ0XfF8XBqH0QTh8jBb/3LgenaIdMooRUPHL7GAO9pJC7F
	UyuAFfOh9KrZ8=
X-Received: by 2002:a17:90b:3b4c:b0:381:96a2:14d7 with SMTP id 98e67ed59e1d1-38e17e42772mr12930227a91.22.1784240434893;
        Thu, 16 Jul 2026 15:20:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.150.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d439sm54775eec.5.2026.07.16.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 15:20:34 -0700 (PDT)
Message-ID: <6a595932.743400b0.23a7b2.c8e7@mx.google.com>
Date: Thu, 16 Jul 2026 15:20:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0453955810891848991=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pip@pipobscure.com
Subject: RE: [BlueZ] adapter: Infer BR/EDR only at public LE addresses
In-Reply-To: <20260716204514.79356-1-pip@pipobscure.com>
References: <20260716204514.79356-1-pip@pipobscure.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0453955810891848991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129094

---Test result---

Test Summary:
CheckPatch                    FAIL      0.30 seconds
GitLint                       FAIL      0.22 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      550.48 seconds
CheckSmatch                   PASS      308.97 seconds
bluezmakeextell               PASS      100.80 seconds
IncrementalBuild              PASS      542.15 seconds
ScanBuild                     PASS      958.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] adapter: Infer BR/EDR only at public LE addresses
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#88: 
  bonding_attempt_complete() hci0 bdaddr 5A:B4:98:1F:CC:04 type 0 status 0x4

WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#113: 
Assisted-by: Claude Code:claude-opus-4-8

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude Code:claude-opus-4-8'
#113: 
Assisted-by: Claude Code:claude-opus-4-8

/github/workspace/src/patch/14692154.patch total: 1 errors, 2 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14692154.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] adapter: Infer BR/EDR only at public LE addresses

7: B3 Line contains hard tab characters (\t): "	if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&"
8: B3 Line contains hard tab characters (\t): "				!(eir_data.flags & EIR_BREDR_UNSUP)) {"
9: B3 Line contains hard tab characters (\t): "		device_set_bredr_support(dev);"
15: B3 Line contains hard tab characters (\t): "	if (device->bredr)"
16: B3 Line contains hard tab characters (\t): "		device_browse_sdp(device, NULL);"
17: B3 Line contains hard tab characters (\t): "	else"
18: B3 Line contains hard tab characters (\t): "		device_browse_gatt(device, NULL);"


https://github.com/bluez/bluez/pull/2324

---
Regards,
Linux Bluetooth


--===============0453955810891848991==--
