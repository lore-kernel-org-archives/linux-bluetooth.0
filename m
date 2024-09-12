Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CD17DFF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180655; cv=none; b=VGNP9f+IhwSctqYW1OJn7L4z7waCUnSEGc4ivlb7ZkTVNcAwhrkN68ZNqpBlndgePm9vqAWCnywVpWNckyKFq2wqKqZ+E0wMn/dW7LFy9ZFGldthE1bLBj545m+voDWJuR/vtf4/Kgp/s+yiVOuDDCBQID8WXFgcpxyjTBmRp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180655; c=relaxed/simple;
	bh=CCMRL5sncvvWkAu/S76KGLTfOlb5NFpdt7hTVMYNbbw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aMJz2lOQeJqAi9TU1MdAf15OiQr0OdVpfHsCLUL8Jke7ZEzDPM8cEHNuRu/zny9fHNZmHP5zWpoWLbcQ503h9kK5LfbV7NoCKv13Pm1zKeqlsMlXVunkdUU1T2xXlOHDsPPasiSUHHlXgx/IRIyUkkFPt0qQrAPlDtXWTVGRLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZJtIdb8; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZJtIdb8"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c35a23b378so9325586d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726180652; x=1726785452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JSLJvLMOZtizsrX+7hZxclFEkoXCq2oWVHEKo9a08s0=;
        b=SZJtIdb86Q4+QRsEzqdAXhTbF38j01V4oXj6vDRox9KNN7TS7YTof2hHrFSSwX9QpE
         O/M+faADNYhCNTABMTOTdBPFM2W8QZDbGwIeXHzeV2ro+wju0YFN0YOWm2my9HmcLFQE
         78lwEGrsqiVUNxx0ApBLP6yPT+Xt9+nE5Vpu94SPGTJFp93jvJT/wM0poqLb5uc+TR+J
         dR8cAnjkfm8ifd/jS3AiOterZSU3eFQcDsrbWdxSteW5AhxoSBjXkW8X5xlRNSq01701
         KNomKz+eNrrIjd8zV9dcBDZmqPT8R/7wxOHWMgcwdO+chLDChgSS5woYyqvRysy3hqY1
         T7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726180652; x=1726785452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSLJvLMOZtizsrX+7hZxclFEkoXCq2oWVHEKo9a08s0=;
        b=psYhP6+ytg1hHyrKIhklcg4ITjgyH9cAl+Dwf4//4qu68IXWIWUSSCDtg2cV+mhcUC
         WVhY4F2qn44xeSDRCsEnPWOwqghGt3Xty7Jkt4kMY3fuiDOBUlXF6Bgr74OZTfB6GARJ
         HzTbwdgW9KLUmqcgs1IYa28RE70gSOxgPwMbBPnWHrabwVzBc0n6DobKRhuvE16nCNE8
         TjnGQPreVmyJYlfzpJI7G/uiNYxlC2uszQaA5rEtffkvf3YhXVmGD1NZtRbklO8C34KB
         MJ45Evg7uJ8Qo7fOanz4xtpfagelyJ7um+JWRwAe6Dzlur+sRMfV34Him9tFZBl8s9nC
         NkWw==
X-Gm-Message-State: AOJu0YxK/jOLT4+7SVhU7fO28lASk3Y3Z1Xf5/9qAZYPBZa4OnnvEbDo
	qRFaLyoaplGmToJkDnmLdQkfGf4WolKOSmQlCvVRo/Vy3xK8VfGzmHTDqg==
X-Google-Smtp-Source: AGHT+IGASiNepk8CeffQqWAdUEFXB1ZIqiviazwv/CU0kSraZNFp6ske0StR6vnBnm/2dxcec/s4Tw==
X-Received: by 2002:a05:6214:4498:b0:6c3:6cf5:d567 with SMTP id 6a1803df08f44-6c57350e755mr71461906d6.7.1726180652169;
        Thu, 12 Sep 2024 15:37:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d8e2sm58740506d6.87.2024.09.12.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:37:31 -0700 (PDT)
Message-ID: <66e36d2b.050a0220.35540c.6d9f@mx.google.com>
Date: Thu, 12 Sep 2024 15:37:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6979835383611348133=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Add BIP for AVRCP covert art OBEX client
In-Reply-To: <20240912174921.386856-2-frederic.danis@collabora.com>
References: <20240912174921.386856-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6979835383611348133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=889869

---Test result---

Test Summary:
CheckPatch                    FAIL      4.87 seconds
GitLint                       FAIL      2.45 seconds
BuildEll                      PASS      25.39 seconds
BluezMake                     PASS      1704.84 seconds
MakeCheck                     PASS      21.99 seconds
MakeDistcheck                 PASS      193.14 seconds
CheckValgrind                 PASS      274.95 seconds
CheckSmatch                   PASS      356.90 seconds
bluezmakeextell               PASS      120.03 seconds
IncrementalBuild              PASS      11587.97 seconds
ScanBuild                     WARNING   1015.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,5/7] obexd: Add GetImageProperties to bip-avrcp
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#78: 
[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_final/plugins/bip_util.c

WARNING:ONE_SEMICOLON: Statements terminations use 1 semicolon
#366: FILE: obexd/client/bip-common.c:132:
+	return g_ascii_strtoll(size, NULL, 10);;

/github/workspace/src/src/13802399.patch total: 0 errors, 2 warnings, 926 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13802399.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,4/7] obexd: Add BIP client for AVRCP cover art download.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,v2,4/7] obexd: Add BIP client for AVRCP cover art download."
[BlueZ,v2,5/7] obexd: Add GetImageProperties to bip-avrcp

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (95>80): "[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_final/plugins/bip_util.c"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
obexd/client/bip-avrcp.c:119:3: warning: Value stored to 'reply' is never read
                reply = g_dbus_create_error(message,
                ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
obexd/client/bip-avrcp.c:141:9: warning: Access to field 'message' results in a dereference of a null pointer (loaded from variable 'err')
                                                                err->message);
                                                                ^~~~~~~~~~~~
obexd/client/bip-avrcp.c:162:3: warning: Value stored to 'reply' is never read
                reply = g_dbus_create_error(message,
                ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
obexd/client/bip-avrcp.c:181:9: warning: Access to field 'message' results in a dereference of a null pointer (loaded from variable 'err')
                                                                err->message);
                                                                ^~~~~~~~~~~~
obexd/client/bip-avrcp.c:322:10: warning: Potential leak of memory pointed to by 'encoding'
        reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
                ^~~~~~~~~~~~~~~~~~~
obexd/client/bip-avrcp.c:322:10: warning: Potential leak of memory pointed to by 'pixel'
        reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
                ^~~~~~~~~~~~~~~~~~~
6 warnings generated.
profiles/audio/avrcp.c:1942:2: warning: Value stored to 'operands' is never read
        operands += sizeof(*pdu);
        ^           ~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============6979835383611348133==--
