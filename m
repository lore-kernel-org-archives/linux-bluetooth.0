Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046B19C54E
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296650; cv=none; b=m1ijLyS1egZzXMCMLvq0f7by/uJ5Cz3YdAPcnDEiUOSfgRtbqiWu4IUAJIbfOYk9yWcbVnTfwnOksjTfAvZU5MgK5msetKIY8OrBQIRjvAV1pdxYV/vcieYDm4YP19OeJl//ED9VCYKgJnwAml0zzou1+bowJNSOOiKn7ilxvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296650; c=relaxed/simple;
	bh=yTVK6KFGxFxSq1ds9/WGq7w9/Jmar1n5fSCNFvSyExk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SoLxikj9g4Hc9Dx0IVNlsQblRGcxhv+zF64s5DSizWi5fRjTO0Dyoi/8H2Nyh2KnD7yD9eArRHC2NJS0yOMCxHu8JRe8D2iNWFO7b3/Ht1+W76e7f5We2XBV72sniywpj7I3ziJYTn2BvEuOa0mMnCRNwMbxmLDgLH7y+Jk8ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntNObGNA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntNObGNA"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38511175ad3so310627a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788296649; x=1788901449; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EbCNHk+axd+0xJhtXajIp/zr1Do9csZfxarlvuJs/xk=;
        b=ntNObGNAYShA5CiNvOzv/5JFw9Nu0nxVdj8potfJGXw0/8RPYw+Z/tn8L8oeo9W6yg
         V4cYelu+7P29Owpp7EOCleyv/F66ZI+cvkyRq+OsUUDoNOuIl3jF0wNxxSE8qMJk31Az
         pp1z8/fElSYIqsPiyWb0EpMzwVKHFwGFq/IdY2suU3hnZ4t96XFBFG1ZDrxtlkz/zt/q
         LX7fcaxH6jyIy1wzBILpDyaUlfbHblkp1a4v1BsbZuN5nCuaDO783y+5SNXkTun5oUC8
         vc3ZhPiCK33DZrW7vbz1gAvelcSWglQZ0SblkNwJxHKwqzyeXNWe3QPBGRfEbq5F+b/M
         oAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788296649; x=1788901449;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EbCNHk+axd+0xJhtXajIp/zr1Do9csZfxarlvuJs/xk=;
        b=ZdrhArFS7xzFylRMUERggydZc3flBK6KcucFioKjlH8pPg7EiGM1ykWzl/V/0QSCTu
         tUCiHGQLcRg1ImXt5rOqQlpvpOS0jDXJvQEIlFK8XV3MiaAbcGFcgMpiVUDXP9IHXDO3
         OhRkiRhBRLCWeCIP2DkrRQM6Aub0Q4U+i+/5UbtFSidWdPge8q1UYtd1JgGt/IytFl8R
         xJXTyrAc4fGgyFcIM/MJa3ku98vy2Um89vUoNQuZiRLV71Nbe8F9qd83zaVqLAMSzsv6
         096Uc7M+3rtBfh1fCKlJYCo4H8mR/vBzIVEGRpk4IaFjt0imeGtBiTly7ifjVdCLvCP8
         Z7DQ==
X-Gm-Message-State: AFuF++ml3FwuVWCvVXZUFYmzFYbZazfKvWr2R+02qcHSQdsytojvuZs2
	6zxkXee/GXzijtwVf08K6TvKbZbLPkBIxtcucpq1Bl4SWQsFL/ZokdDXCFrESg==
X-Gm-Gg: AYBFou2Hb0h/4ZXoEMVYVagVMP/mSrPErkZtyMVxQsl9xrh6ogCEAVJu6MynU7oDRGu
	cuNwuYdZeuzXD4dlQK8pVXXzfZ4RA36au9Zr4DigWVO0zWCexjIA8VoJke3NP6cW7s17Zoccx4U
	61z1/oOMLGEauy1oPMPw0mkrzeY3rFy43K3uHYq/SEjIBod4Xn3FwiUADEncz2zSuJiUQgZg68D
	+78SzDGYo9bRvxEpu/DoueSMmLAPKXlnJqFerThvNwBo/AfJ4+rXf6jpzj0jxmbbOsM33BZbrw5
	cxT3Jw/cdcBSZXdSIl9ygJGlSEHyjS7fq0FQLb4mxJM2YwDgkdtf5C7otmenWcO2NFmjkcN4MAP
	ZlLSuxGqucqPo+Ko+cg3icuL73E9P/cSKVmsCgkjS3xm2fze8PSC8+0LV6uRx2AEhEu56u0axsZ
	NHimON3SpAW2gKl0xy96Aw6qnGOj0XPortvboLqQDplf1VZoMuANPyeoKTh/VGxNk=
X-Received: by 2002:a17:90a:10c9:b0:39a:e002:f192 with SMTP id 98e67ed59e1d1-39ae00301efmr2929034a91.22.1788296648596;
        Tue, 01 Sep 2026 14:04:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.6.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07a1bdaesm695471eec.13.2026.09.01.14.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:04:08 -0700 (PDT)
Message-ID: <6a973dc8.3865fcc3.2668ac.b541@mx.google.com>
Date: Tue, 01 Sep 2026 14:04:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4478076305470595564=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/5] avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response
In-Reply-To: <20260901175315.1348621-1-luiz.dentz@gmail.com>
References: <20260901175315.1348621-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4478076305470595564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1155564

---Test result---

Test Summary:
CheckPatch                    FAIL      2.45 seconds
GitLint                       PASS      1.20 seconds
BuildEll                      PASS      18.31 seconds
BluezMake                     PASS      650.51 seconds
MakeCheck                     PASS      18.63 seconds
MakeDistcheck                 PASS      146.15 seconds
CheckValgrind                 PASS      220.71 seconds
CheckSmatch                   WARNING   273.13 seconds
bluezmakeextell               PASS      95.39 seconds
IncrementalBuild              PASS      819.11 seconds
ScanBuild                     PASS      882.40 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/5] avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response
ERROR:BAD_SIGN_OFF: Unrecognized email address: '@ax-nnlabs'
#121: 
Reported-by: @ax-nnlabs

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#122: 
Closes: https://github.com/bluez/bluez/security/advisories/GHSA-m2vx-pw5f-rc8v

/github/workspace/src/patch/14781994.patch total: 1 errors, 1 warnings, 56 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14781994.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,4/5] avrcp: Move response parsers to avrcp-parse.c
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#127: 
Assisted-by: Claude:claude-opus-5 valgrind

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5 valgrind'
#127: 
Assisted-by: Claude:claude-opus-5 valgrind

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#373: FILE: profiles/audio/avrcp-parse.h:37:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#384: FILE: profiles/audio/avrcp-parse.h:48:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#396: FILE: profiles/audio/avrcp-parse.h:60:
+} __attribute__ ((packed));

/github/workspace/src/patch/14781997.patch total: 1 errors, 4 warnings, 609 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14781997.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,5/5] unit/test-avrcp: Add robustness tests for response parsing
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#135: 
Assisted-by: Claude:claude-opus-5 valgrind

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5 valgrind'
#135: 
Assisted-by: Claude:claude-opus-5 valgrind

/github/workspace/src/patch/14781998.patch total: 1 errors, 1 warnings, 422 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14781998.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
unit/test-avrcp.c:374:26: warning: Variable length array is used.unit/test-avrcp.c:399:26: warning: Variable length array is used.unit/test-avrcp.c:415:24: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2467

---
Regards,
Linux Bluetooth


--===============4478076305470595564==--
