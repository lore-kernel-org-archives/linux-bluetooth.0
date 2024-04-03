Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F06FE0C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183974; cv=none; b=oUhq9HxgbC69F7wO1WMauLwajKcED2/7lHTNrWZBungtlNoC61k+pYppCv4WoFPZY3J2JoEPRvOo9YMt2rGAnulNqvV9pIr9Fy1EW81OTy1ntXzOSDYI46San5fWDrexj8aknpEy1RHVdFS1E6wGjaJhaxj/QPvebGVemR0Z+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183974; c=relaxed/simple;
	bh=zc/g7f/3aKIdkqLjKfMMf/mhScVBcpCzeG2tboR6W5U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MX6oCEyEwoDifslI1uZeoxehxypXTUjk9mFRBOmuPNNDvLt51+1Mvj+2jV0EBMeAFhraWzPOebga/T/UgL+laAveaZOLx8U2yFLQuFaEWj3BHXt6e1IwvRBO2wJZKPjOWyM2b0Pl07eL78gCxkqLsnr0cglkYwSjNJPLH3O42Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK9fllKv; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK9fllKv"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78bc322a55cso22698585a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712183972; x=1712788772; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9NFpZ+Lmhu/J6PstSNOYoHLJXfR5HnABnqRZS+qp+rI=;
        b=gK9fllKvcMplKp3nfHjhCNztc+ikoigcGp++m4fuVYx8f6HzT2J7jAP3ZTuoOoyp99
         +ggK0UB/FJty8oClK/WUx/8+a66/XkashHUWStON4blxLTCCfuW2FAxY58/IbhaU5jDH
         LvTeIzgMtyX7RwxstCQjHAu2VQ2jylWz31bDOPGfYH24qSrFYSZ6TzmUthZCoW9DMZSs
         wvnIMi0kp4erciY9M8LMi2xLmjSs2EnSiAYzBECHjYuqKNudzvMhZM7uZrK7D8KDINRt
         RsDUpu75N7DUndMRGkKSvTODgf8yVkjx5bPQO1L3JpyoVJfgrnm7UaYY3WWKQKaEgpYi
         cMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712183972; x=1712788772;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NFpZ+Lmhu/J6PstSNOYoHLJXfR5HnABnqRZS+qp+rI=;
        b=v37sf5M77UltBq+EdpNoS7aqJ//yLTs6oHeFwN9TMTZprTMFofOuIfUabJge8ghf6e
         VgJrP8TbQMO6daj+W6UzGUdlvZt2BjCMl1tMNuirmPNOKIhvnQjj8O1lNBXH2hF58aRI
         9AP9kwpgNTTDZh+s3MLRul5V9dtr6V7CquURGXDAjXH364GCGVqEHJwaSu630gicO1Lg
         rSNfgiDrKQr0PdzkX05tC/pdGY44RPPSc+i5bSTC2tLEl9YeMBgo2JhwublTtaTcafck
         1zaQBfI9FcBYRpoLXunrfeENf4uxoctI5I1pzXW4SPALEwK2D0TwnfM194I/5DoKnG/8
         O0sw==
X-Gm-Message-State: AOJu0YyJD2Wvg0z7bBkT5hqreX55SLoWIVGUvBveQPxuQ1dA0lUz+ctu
	Xr9JFhUS3Eez+2Kk+YZZjgDNL1uxu7h7CqaJi8GvY9uNctFDoHpNMW0inRJL
X-Google-Smtp-Source: AGHT+IGy2J/rMZ5THGQjyAKXVlhKSxzVfGq0cUKPfxnOe9xOBH9/NbYaaQINKLLFvKI/eIemnheMvQ==
X-Received: by 2002:a05:620a:147c:b0:78b:e6f6:737b with SMTP id j28-20020a05620a147c00b0078be6f6737bmr569890qkl.62.1712183971639;
        Wed, 03 Apr 2024 15:39:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.207.139])
        by smtp.gmail.com with ESMTPSA id de10-20020a05620a370a00b0078bcf660116sm4171431qkb.79.2024.04.03.15.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 15:39:31 -0700 (PDT)
Message-ID: <660ddaa3.050a0220.bc593.4c2e@mx.google.com>
Date: Wed, 03 Apr 2024 15:39:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9003472175206686501=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dimitris.on.linux@gmail.com
Subject: RE: Fixes busy loop when disabling
In-Reply-To: <20240403205252.71978-2-dimitris.on.linux@gmail.com>
References: <20240403205252.71978-2-dimitris.on.linux@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9003472175206686501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841223

---Test result---

Test Summary:
CheckPatch                    FAIL      0.63 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      1713.67 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      176.41 seconds
CheckValgrind                 PASS      243.68 seconds
CheckSmatch                   PASS      345.98 seconds
bluezmakeextell               PASS      117.79 seconds
IncrementalBuild              PASS      1567.24 seconds
ScanBuild                     PASS      965.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] Revert "device: Consider service state on device_is_connected"
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '44d3f67277f83983e1e9697eda7b9aeb40ca231d', maybe rebased or not pulled?
#94: 
This reverts commit 44d3f67277f83983e1e9697eda7b9aeb40ca231d.

/github/workspace/src/src/13616707.patch total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13616707.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============9003472175206686501==--
