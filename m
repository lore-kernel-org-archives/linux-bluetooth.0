Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDD3A875B
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955645; cv=none; b=RdDUz74iGFLu+XsKUNQ7QnonxpXg4PvqMIIOXed5/mBAY9Lac4mRdc9O3wwoh8Akgdnmb4ScHC/S4sA3JhA7C342YSVuPgj8UVvs8xAl9BPDa6mAWHSq5GX9kF5rmTfSfy85dMZ+gb965fQF/enXG5xqxN1dM3FZFAGTtmwl+pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955645; c=relaxed/simple;
	bh=IGBkp4mmTsGQtHs10CrIWqo+uSnFL9ue3pci6IszI3c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n71jCCdVTgLwzey5uIapqdB+XcUhlVt7J99pmSzOMjqSXsStU0v/pcFcGg/YBrZqilIPIM2rlquO2/OCDmgwy1OZA969ljKpilLFv1ABa3AvfcwOAC8gz65aj8oVARPcuvcca/dn19OakGeR14VhxFRqOYYewqHoK+trEQ9MU2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHULy8ZP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHULy8ZP"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f4f53975e6so1449085a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787955642; x=1788560442; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yYQufSZx3b6l7PCmbBX9fBpaHSRQMWyrrTh44tIXnSs=;
        b=HHULy8ZPWFfmZk3+YLK4AgQgmwQ6Swb0KUe8ieonrR+d14A93gdoPI/mVw4jpdA3Tf
         7xUsPDjdDIfoCTq8ORO2DxY3nzSMttNrHGaKrTFVE3jxAlT83y1KuZqgiBQn+3858QwK
         Ity3CU3O6nKE2ifTjhLDM5eYvU179gPQjq/8QqOzlCrij7REoaKAvqA4C/qPuHGjHP9B
         kxT6TK0ugfoEUIdhrtWUP5ndeL7qaGOrwDsL7kdGmzjoCJjtBcbulgvF0eBo7uxrkX18
         HN5qkasO8Hu9S1VNBYxfrD5zp7j0THXCvFDWBBGfJMRkhVbi0maLUf0czJAT0BwnwpAk
         mEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955642; x=1788560442;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yYQufSZx3b6l7PCmbBX9fBpaHSRQMWyrrTh44tIXnSs=;
        b=fgGicdnyPm9G4XKeSBFa7hSQSVLD/li7lZ54BiyXj5vKFTS9foUSgoiyRgVZnsQO4a
         qydo4rFt3RFLmiNV1mSpSBaD2UiwY3TKea8Za5+X34eVsQ2qIisxeNxupCuSNeJ8vU2P
         bGyLkOHDHMF+CfvH2W9LHhx9toaSWV/qhSxFby064++6GanPJanrU1MiORa8lfD5DlLE
         E5ov5sG2ZrgH1PtIGTamkKK3answl/FVIo+ROWQOTX23hlwpd1ghikIcJr1x70NHImvz
         stnZbP56781zrRciQbCNxTkVQ9rhDhNesix00wMiQ26mNRRFHVfU/nTWihFxQvvYkWQW
         HLEQ==
X-Gm-Message-State: AFuF++n5rqmiaQk/yXZf5EpKB9fNJR9UgL5hJeJBedojan+xVzkQEXnS
	N2YKtGZVd6cwZ6s+n/Es5KGGDD16rU5ykXVBVwHOPOaHColidKZjejfQEn4/lg==
X-Gm-Gg: AR+sD12XwwKPP5McZOULVRW4jk7rwmXvJTnnTjlH8G4nE3DDz7lKjhl70gJ5EiodUBh
	ygee/Zq9j0F2myYppeeMuWDz9etxABo3afZkWNhR2+xCVRuJxSXcOUuCE3+XCOuqQbWaEU3I7aI
	hwa9DlZx5pO4KV+mqGE4Gun0N3beSKun+S4/iKdZovLMWu2v17KXdCGZ22UA+mbBDarZu9SEtaT
	JznzB/MCAgqNCz+9y4lLbwiq93zdWMseuIdhgTrD9hisP8ZCTynvmo34PRnopzPIT/D1RILVuwz
	XoheFuiyvtRmfGoeS+6qb+nvHMMmWFs9eRsd2QFoXcRS7jvGPGOzCi614tspWDPYlDDekPG9x3Y
	iwdETS+J66v1Qu4xWy9/p5lSv4ifXCjhPbeLEdf49aey7q4jmlafeWLFJi/y/IaIIfBHLfN9boM
	W1MJ59qVMM93oOjTqK75D2eb9KE+VY7FU/rhAj3rUvCf3TLfRSJuICa5dlC6kuySsMmTA=
X-Received: by 2002:a05:6830:6519:b0:7e9:e8ae:7049 with SMTP id 46e09a7af769-7f4f22c9710mr14290023a34.7.1787955641962;
        Fri, 28 Aug 2026 15:20:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.182.166])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa9d6406sm2231583a34.27.2026.08.28.15.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:20:41 -0700 (PDT)
Message-ID: <6a9209b9.bb286e2c.950c9.553c@mx.google.com>
Date: Fri, 28 Aug 2026 15:20:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6760186891283254843=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response
In-Reply-To: <20260828161702.519421-1-luiz.dentz@gmail.com>
References: <20260828161702.519421-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6760186891283254843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153367

---Test result---

Test Summary:
CheckPatch                    FAIL      1.48 seconds
GitLint                       PASS      0.82 seconds
BuildEll                      PASS      18.38 seconds
BluezMake                     PASS      660.03 seconds
MakeCheck                     PASS      3.19 seconds
MakeDistcheck                 PASS      146.90 seconds
CheckValgrind                 PASS      151.18 seconds
CheckSmatch                   PASS      278.03 seconds
bluezmakeextell               PASS      95.58 seconds
IncrementalBuild              PASS      675.82 seconds
ScanBuild                     PASS      902.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/3] avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response
ERROR:BAD_SIGN_OFF: Unrecognized email address: '@ax-nnlabs'
#121: 
Reported-by: @ax-nnlabs

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#122: 
Closes: https://github.com/bluez/bluez/security/advisories/GHSA-m2vx-pw5f-rc8v

/github/workspace/src/patch/14773935.patch total: 1 errors, 1 warnings, 56 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14773935.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2448

---
Regards,
Linux Bluetooth


--===============6760186891283254843==--
