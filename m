Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E1485CF2
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847287; cv=none; b=KbHzxNiskdJH/NwZk9HeWAo7kdx6fcNNTKl64czhisEWDVjy1J6/8S7rCy5sstpMf6mlg8Lj6atPYPM/WUQCNsOFNc+mMOC3EpNBERS3dyNBIyFB8W2YiMuPU0/E16t9llEES3m3YbzIBJ3U5LQ3BJNKJx4kBCNORMiPri9NS28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847287; c=relaxed/simple;
	bh=MSg3ixK5qBn6V0aBZa0J56hiCE/I87XQo960L5Y5F2c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bgrKscmvtDX6OrJ6jFcCcVwHtBziDu8ywlQVLDJ1qCTVBWBgV7lRJ5X7VSVypDBjN1YBkugn8kXXw7YDrCo5shWE0ebkbsqKE6OAGZCYHwd/bbvyuzb2MZnjFqvlgSCxmWDTw7RfLKOk+INaXRTEua3MVEBMfrsJKSy10Zz6B2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEnR0Y0a; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEnR0Y0a"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c0c45c580so580901cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787847285; x=1788452085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1XeVaNUiRmOQ3GHk03cnz7K6QQIEBFldqadjScaIO3g=;
        b=mEnR0Y0adrYwzmZbz+nD/qVXGId9VImBNDn9IZngazVjg0GL3Z9+3qFEmi904HckTe
         AQe6agFvYMfAN8PEZ5kIeLZUdufHRFptymjfPF99QK79oE16VuE5T4Yr/GLgwaveMHbC
         2y5dTxF9S6xpUVCT4XjKVn/ifGAeTflHTSY0BJ61hA1tWEPV+nYsWFk4oTu4Od7GrOx9
         bts9grRVoGLuw9lMKWsVNiiWI65nf46Cv/Yafc2tUiOoWLuE4ynobaItw712lpzipD7r
         c6dVaU7Rlqe0jbeK6sZmFaV58dwwQgCDex3dKPynKsvODSae7uKh1btis1bbJtEhtzsb
         9t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847285; x=1788452085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1XeVaNUiRmOQ3GHk03cnz7K6QQIEBFldqadjScaIO3g=;
        b=LQI1NVauG/a6SKRizh/Httn+XKoHplgdoDXlXsbFXzTsYa4RSGRz2wlUqigmM7s7tr
         cCC2OoY2hHWR85bh9d6U6N0x9n5QSPSRPYXuhWITu7PBOQMXcP3gPbWqGWWUIBetCOnb
         vfJITkEQF1tY+CKLhiZxYaj4KsECHbSU7ajOtJkGopCodVttXajLq9yW/f1Lt2DtfALR
         Jsa2tO4ZNfcfQnya/jN3G/ovtR4M9zHPXOML+PCTwStGKBF3AJwqOSggtJYgOzExp64l
         +rEzXdXDs6/D9xd5AA704uVF5YwPE2eCVoKD+61/PCQbtr/LJZp8ZiTY3T8XZ66mrjpw
         Z71g==
X-Gm-Message-State: AFuF++lQ2hLDqgbINPC8kqe3vEWIej9xyEKmxjoTkIHD+J/ygyRACNer
	kLa3cns+gEf5dJhrGJALZCBW5CbbrfvA+oWSrjgC0F3bvMNxwNEiB9crduU6PQ==
X-Gm-Gg: AR+sD13hA666QKFCTe0CPc5Z6t4/0SJs1ge12ioH+Vvs401zKJDo/iw3RwATlTu2rXN
	L7HZFGsxsS//vOd6/dBNb4KZNw+MnKLc2/HUf6nMK+oVaFFzik63Eu2cbxx3ovacjCw0QTDYItk
	8NgEjDmeNJAjGqm4oedWR2nO6p9p6K4613C1DHPgThlMzF8Jqp5/M14nHKHwXvFxgKivRr827UM
	+F3jXiUk6QEtQ2BFdil0qE81LKejmX8mZDMYkT4JJlsxd/jC2xm+a2uf6DH4CzRE6M8Iu4BcvyT
	HMC7ZEVHwYeA0JUzaWWsyLPl57tRHarUaK+r5fxw9SJcDTZYIX+SI+s7GMWmYD5uoQkx3hgWCjU
	oeKMzJrvKnEhWQ/UOLOkPJ9EzUuIbVm4psBUPpn7NxSYPW3CRrMutmDUNdIpJW3rAlnErMW+HAS
	a9PZFnwayM+ymKOFMYvKrhenX5kYJXuipvNnEKoG/mRmk5QJuClKoggNhLVsqD7y7Y8vl+2A==
X-Received: by 2002:a05:622a:6114:b0:51c:84f0:d903 with SMTP id d75a77b69052e-52fb9410095mr2018311cf.17.1787847285005;
        Thu, 27 Aug 2026 09:14:45 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.157.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e4270a950sm39684671cf.15.2026.08.27.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:14:44 -0700 (PDT)
Message-ID: <6a906274.0bddbea0.2d6b2b.7b08@mx.google.com>
Date: Thu, 27 Aug 2026 09:14:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5876311644520555413=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] gobex: Fix ABORT response being discarded
In-Reply-To: <20260827083651.1355587-1-jinwang.li@oss.qualcomm.com>
References: <20260827083651.1355587-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5876311644520555413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152525

---Test result---

Test Summary:
CheckPatch                    FAIL      0.52 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      20.98 seconds
BluezMake                     PASS      566.26 seconds
MakeCheck                     PASS      2.38 seconds
MakeDistcheck                 PASS      155.07 seconds
CheckValgrind                 PASS      149.90 seconds
CheckSmatch                   PASS      301.14 seconds
bluezmakeextell               PASS      98.35 seconds
IncrementalBuild              PASS      562.27 seconds
ScanBuild                     PASS      902.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] gobex: Fix ABORT response being discarded
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#125: 
Assisted-by: Claude:claude-sonnet-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-sonnet-5'
#125: 
Assisted-by: Claude:claude-sonnet-5

/github/workspace/src/patch/14770796.patch total: 1 errors, 1 warnings, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14770796.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2440

---
Regards,
Linux Bluetooth


--===============5876311644520555413==--
