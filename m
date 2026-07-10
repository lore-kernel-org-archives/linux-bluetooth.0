Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB837F721
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712561; cv=none; b=XxHvFhcKd/SdHP8wdf96Z8+lCAye4XVV8rWQAnXgUba+LGIO2dhnV0X3yT6dHf55zD+oUhr78Ro5SfGD5UtPK23O9G3Dh21pcitst0zIvtEReLNiWXr3WEBBbwO88BLmEnccIsTFBLHhefBcxOPvLvZ7UU2kBE7t9uBl+IX5OkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712561; c=relaxed/simple;
	bh=tgLBrqiyzjhiTZpqOPf0ZmlGBDpB5GBujpSikeW016o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=otlKh9Dvhi9GXxKJCFHfZLELsXgpYXGxiJxvgT5PYEitx6y2iIwTkSqrA71VC1ShMK3Ubt2gMbECuoq4x5dvwfpK/jT6DoIkYWHddnBot/F/HtrbX2qIp4ByoMuKeFc2lsqjZa4hf50VRUuK1ozZyL1AY6gMb3oOu3WcpKXfZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeW4MMV8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeW4MMV8"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so7774716d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783712559; x=1784317359; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xK1iaGd539bOofXxE5F05+RSqoIsvhIe8hgZ3YBYwM8=;
        b=YeW4MMV8apamdmX5s6NdE/GQOLj+tPBz5wYJWr363p/iSmUOEH5smYnl7rMgpsdntI
         6Q7RnT/LhUrZG61n5EXdOKyt7lac1N27mB5yIBxbi4hetEWfUJq+0g0l/pKZapRvKanW
         /ze6w4OdpMbjlw/nlAkdJ7h4NhT9VO85xv1FY6I3pbkHQR7qFlzIL0m4KEunJX7QxUBQ
         f6OF1ATqWJ7a+Ii6BuvboWbZn144QVZ30biHHRnBGAFtQaQn1RZqpW7oKcypv/ignZE9
         S4hcFSlB5KaiwPMf43cbm47jypgvie33dLoGeG3Oza6vvCQQ91899Ooy1JRAv8P+hJ7b
         46QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712559; x=1784317359;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xK1iaGd539bOofXxE5F05+RSqoIsvhIe8hgZ3YBYwM8=;
        b=kGtjjzsP+gJxlZeaCPu7ZkJHwzYXu1XYlG2NpbGjT0v8vAQeVYmDtCCIkqU4H4O2vI
         Yv+M9ILha/f9faFOnb9FaWMUU93meJSuaZyG8XCWNdCgIHpmp0vbiQR/JePrq1FgVK+R
         AD6kkE8H3Yknzs1oIWfIzmkbk/AqwmjqcVTMKtn3+C1KH5UouuLbtuESyLWgMNobSlTi
         hoofIkIhqMc/wxXMcGlLe1hzQPG2o1xBiP9YYHoCR5XjB52BC1BMUIxfzRNiIfc77g6v
         9HIs/xjepdFL+50nBC2u86j3O+KvETY4FCV0SCDyC4YsJboFtWOJoVmi+KdkOds4bEMb
         6KFg==
X-Gm-Message-State: AOJu0YzFbjZ1e1QO/0XrrMODyq9U6XqLPqcEM5HvkVd/yNrl397frpoq
	incnbdA+9uY6UtfttpdhXvawXI7VHECJc+qfXydyngG2xcx4du7jz6OVqLCatw==
X-Gm-Gg: AfdE7clWyME0mel3Dt/SXGygc2I6H0VnibpRV46ytGcF/kKUtBHj5Mf25hOnGAMtYjg
	pHZpO6+AqDSI1Ia7Iqk34e7HRqzl+H6S80FHtYSppt1asPApemCk3c2OM8W2i7X/mMPvdW5cfwG
	tE1teIutfouX1QzB75p9Eq/Sfx51kK6qPoDHzd7PEBX2yR2+wQ8RkJz5JIN1rAXuMnW4nt6DCvp
	Q1rneYM+O62/TFpu/0iYGB4b7KIa4mgRNDQ/46AypaGUxPuEReyntPOtMlVtrZ8Ei2snS3uHRpu
	5urz+IAcrMYWSnlZy/alPt6X7ys8lp0tc20PVLaC4bkKCJlePXPRKwCO720FEZRbZY6bJ+R3vhJ
	mJeYJSe+TPjk5e25xloHY1oKIQofInrphcM1HM7d4RBJf+JsSZiryaVGx30MBZWkWjPAk1iCjq6
	pXTDsHpki0zEyFfbiwq8c=
X-Received: by 2002:a05:6214:238c:b0:8f0:dff8:9889 with SMTP id 6a1803df08f44-903fea491c5mr5838826d6.16.1783712558786;
        Fri, 10 Jul 2026 12:42:38 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.191.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f4bbdsm48235436d6.36.2026.07.10.12.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:42:38 -0700 (PDT)
Message-ID: <6a514b2e.e3f372dd.3db143.2430@mx.google.com>
Date: Fri, 10 Jul 2026 12:42:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5053304911190709605=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] lib: add iso_data_* macros to hci.h
In-Reply-To: <e2b3c5425a653eb198700cb28c453607e2d82840.1783707145.git.pav@iki.fi>
References: <e2b3c5425a653eb198700cb28c453607e2d82840.1783707145.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5053304911190709605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125549

---Test result---

Test Summary:
CheckPatch                    FAIL      0.98 seconds
GitLint                       PASS      0.76 seconds
BuildEll                      PASS      21.12 seconds
BluezMake                     PASS      552.39 seconds
MakeCheck                     PASS      1.03 seconds
MakeDistcheck                 PASS      163.72 seconds
CheckValgrind                 PASS      158.74 seconds
CheckSmatch                   WARNING   317.83 seconds
bluezmakeextell               PASS      104.59 seconds
IncrementalBuild              PASS      574.99 seconds
ScanBuild                     PASS      1013.17 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/2] monitor: fix parsing of ISO packet data header and slen check
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#98: 
Assisted-by: GLM-5.2

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'GLM-5.2'
#98: 
Assisted-by: GLM-5.2

/github/workspace/src/patch/14679169.patch total: 1 errors, 1 warnings, 106 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14679169.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2295

---
Regards,
Linux Bluetooth


--===============5053304911190709605==--
