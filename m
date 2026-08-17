Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27583D6CD7
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004845; cv=none; b=VfZtjjk8Ow8A56Ix8JurQOXUi7z3Wq3awe1cmvXAtJubBDEDDsRX/Uqqh3lFZ4++Ev2c7cDVjmGddaC18+/P+bYCv57XyEJld0h+mwSsIHGnHtNUd47mRYe0HBJGUlCXmxvGKyatu+GqasnY/zyCFjljS+JDLImm46zFZ/1NgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004845; c=relaxed/simple;
	bh=Exnxx9FUEFQFCVEqsqIP5loJW0jed1gh1rwbJ9/1mPs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IUKYmOCDS5cjKFRlqtJbAtep59mO1Jt83gbGLKD/dOHbGwmf9KUQy/f/8AHrnA3jZDX93TWqq4f8lk1GXgJUDBN5oqQqnOcC45A4p8158u0N/mnOFp8cmuMraUnbcXgfcLsRDCl0IMkG092FJcK312tOKWy+PisUpWNQ5frOXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrspQ/Hz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrspQ/Hz"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so3590727a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787004843; x=1787609643; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x9+NRmf9wnIdyHKtHGuAEhXYacmFPJzxJxpODx+krrg=;
        b=OrspQ/HzO8OpYPZINjflwCJHFmJqKRz4yPd08l0k+6ktgFbDJU5KuFr2YbWa4gh2hc
         FVe2PPChikSFBIchaTvdLyujiFWSFE9wxbDMDnXoW3U1CMe9WwBFDOrwG7k0QIEKbglh
         wnEPpcEANkfMbIb4QdQPSEEmxiU6iYdt/U6I6jgtVvkXCht3VC/tTpBywilNOsWQ3J+v
         bxewpZ0yU7UzxPfgTzBMKJPFQTdJCYrgc5ifs1s4O+sFQkkmwHt8RUPfVo0tB8pPSviR
         +sUrusS1vDrUX8tbUjHrOXrMAT19YizwlfzL+q/ZdN2wuBC5DejHAREilPbUvVlqXrQ8
         QeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787004843; x=1787609643;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x9+NRmf9wnIdyHKtHGuAEhXYacmFPJzxJxpODx+krrg=;
        b=Sdpg6gkeLGmDAg+Pgll9UoKUK3RnURxQiu/CvUIPsJ8nr8R15PN17zH7ONBfc4ymQx
         anYmvaD8vYVOyVdYrWCml9tHgBrQRGh7eoLuZqYiCuLyu0L64oOsLlbsRfX5sWgbmdv6
         sV8UEPMQxsOQ8fajP0KDxHAmQOjNdnhvnro2llJ6zw8o2Fw+5X49JDrsNtHcJTDkun//
         XAYoz6slxZzgAfxnT2PPZaEUOQDIJe9+CE5qNteHPH/VsJP1sqT7d8jKfji9Ckr70JRs
         MNsLwnYTl7scfFYBzZNQEJ4vzeOV79w6PXTF7O4i2SJF7ffGK5kG92RRvaa5ZIGd8pxF
         bPcw==
X-Gm-Message-State: AOJu0YxqK5wOvWQS+q/s4l1VGluIPMX66ySxojgwDXvFHG1TzdLv/DQh
	G3EF+DSupbKrX6uwgKhsDA3Du3gdaldLviWGa8uyKC0Wvv+3C3KoL6IJheEJOA==
X-Gm-Gg: AR+sD12qtw3fQpSdUqxkSuk2G2M7CvUgc9P87yY1+057QseaoSGTY7zFQJRpcxDcep8
	agUOCaDmHKvENYBhci/XWSS8p5JgolBnCBxBKZhpinqtfF0WrS9OPmClVcGMhI+p19Rb8NrxryD
	oPoqlcUTDc826vqHxwnnaZ3mzN6vADrbs7jzA0shDWo3A5et2Owv/JGN8wSyQ2Zi+zJVOo4rUD4
	vl/qMyfSXjU/oi1z+EyHdcLZ5zVUbeZmZ5zabUYT3wkhQ3jQ2SPjRvU117i4GMgOi8v3sX6n9vK
	QE4nDO36kwqC59J7TIPIjLSxZOg22qeFVNnIL7nm/zU8vsaRSRGPaXAwPg62CsAfDKIY61daoE0
	CsM4/5YBCnH4A7DgzYeFI7YwvqSjqQ3q8QjepuQqu/ujbmyeYhbRzilVgIAG70zsGImTTfxdiLq
	BAAOZgAcskhuQxkg6nvA2bE9tAGe6r2YiiBujQrb/ge/i6l6G9RnT+UWRlvw1kVxFSHToo
X-Received: by 2002:a05:6a20:4311:b0:3b3:26aa:5455 with SMTP id adf61e73a8af0-3ccda9f9485mr3355186637.13.1787004843083;
        Mon, 17 Aug 2026 15:14:03 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.226.219])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c388e3csm10337403eec.21.2026.08.17.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 15:14:02 -0700 (PDT)
Message-ID: <6a8387aa.9695d639.31ab27.1798@mx.google.com>
Date: Mon, 17 Aug 2026 15:14:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6659650742486064402=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/4] sdp-xml: Use a queue to collect sequence members
In-Reply-To: <20260817210038.1839617-1-luiz.dentz@gmail.com>
References: <20260817210038.1839617-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6659650742486064402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1147412

---Test result---

Test Summary:
CheckPatch                    FAIL      1.43 seconds
GitLint                       PASS      0.96 seconds
BuildEll                      PASS      20.76 seconds
BluezMake                     PASS      611.79 seconds
MakeCheck                     PASS      19.04 seconds
MakeDistcheck                 PASS      159.66 seconds
CheckValgrind                 PASS      231.94 seconds
CheckSmatch                   PASS      315.81 seconds
bluezmakeextell               PASS      103.59 seconds
IncrementalBuild              PASS      645.38 seconds
ScanBuild                     PASS      991.07 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/4] sdp-xml: Use a queue to collect sequence members
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#113: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#113: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14754210.patch total: 1 errors, 1 warnings, 108 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14754210.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,2/4] sdp-xml: Fix leaking the parse stack on malformed input
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#119: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#119: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14754211.patch total: 1 errors, 1 warnings, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14754211.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,3/4] sdp: Fix memory leak when freeing alternates
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#119: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#119: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14754212.patch total: 1 errors, 1 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14754212.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,4/4] unit/test-sdp-xml: Add a test parsing alternates
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#108: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#108: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14754213.patch total: 1 errors, 1 warnings, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14754213.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2410

---
Regards,
Linux Bluetooth


--===============6659650742486064402==--
