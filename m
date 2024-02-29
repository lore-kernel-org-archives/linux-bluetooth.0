Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF94AED8
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227921; cv=none; b=okvUntrvwC1J6ohyKFaIi0I7HDiLDOXH0dYaqX63Y5IurXYtaBLlIpPyuwQqzcx7VCGqvU4AgylZMUwunnj2gkALzUk0JoZXpDcBxOCkRHzKPSOaq7xCGxPi3npTySbmVzhRNbW50r6pfzayxd9f44PV3A9sv5Gvq/Ve582XqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227921; c=relaxed/simple;
	bh=ABMpxjQJiV4CYhndMYq1GLOg6MceoEcDBuUjPWsjsm0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XZbtoxTgh+fk/8fYZuv5z55VPU/D5FOjHcBMUK3woPClzjlhjJ6TDcUrD/mYGmjELOVGllo5TN0Y3vnzb7Apy9XJ16xH0GjLH+R6pVG0pPD55OGXo5HtRossK2iv278IWaLFFUyt5a6ufqk8gBc4Gz20mtxTGtPmh1pdc26Ossw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwJYOSon; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwJYOSon"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-787ab7b56efso40788385a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 09:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709227918; x=1709832718; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GAUKyNR5pmQiVQR4VF7EZRkU/8G3tUSGLqf2bpyhxbA=;
        b=NwJYOSonjt5x9DRyaf0nBbmKo3vQSDlZE+hqJ2bB6PqNPBrh06O2O3NAIKRJMSuf+D
         pxUN+mDckg2YuwSO84FflwetnwsrjGdxxEk7HGhUfa+SUM4eM5b+j7dIAwSAhXEENfwe
         FJ2l5sAeCJJaIKIjVoarC9VvWCohLrlEr1Df5TZQpeEMyBqizAq7p8atRY2EwijFS9lc
         x19Bkvz0HI/w1BF49bF+GBmGsKi1ZuX2A3mwszn9Jnh2AHpURtJRH34C7Vb/UwIaAZp9
         rqMBqeTQcaXwrYGzWgQo3ZGmN0EyxJ0WtObNjijRzhcvLm2/KSMrnDbmQBCi2FIo5Jkl
         7kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227918; x=1709832718;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAUKyNR5pmQiVQR4VF7EZRkU/8G3tUSGLqf2bpyhxbA=;
        b=Ayn8YbiMAbPSvy3f2//w1NfZGvPwBL3+GdBYpJcifV2XpoW/UdYiD9hQVQFig/Miv4
         9hargfnJCD8D9V9qYfgc2s/Zxp0kY/BfBQWY8T7P1SgY1YyEIWO4JO8itO32EU3Dk9JX
         +kC3RWuCZh7sacuQ4BtSbvq8aLYvpbZFFLnNM9TVCCXLxUZGtSRUxJUsezfrmPqX8DmH
         QwnG8QogJ6tIV1xoQEjFUcuDX0PqNPle/2LD1X/GtHzV2KspMcZZzbV76RgW/1WBC+kN
         VeIeXG8Xtj1Q5ls1fX0vUuxdCuteQVSWWhqWs79iDcwot3RMehqSDG+TbDltYeEFVRSY
         Ywig==
X-Gm-Message-State: AOJu0Yxbei5mRl9UijFCYU3mVRYDx8Jt61J100fU8xeNqunKGm2+yGOh
	6RhmjUHnf7kinCM1eV/2OCPeIMBuQnNc+VH41lEb5SHSHkh3aJYXsL+8anA+
X-Google-Smtp-Source: AGHT+IFh1805dLuJ2Ss5Yk45bWmDq/NdTOLIMR37haYIqWlY/DhG2ikJWK/ya+n5WthXCm+P2WtXoQ==
X-Received: by 2002:a0c:cc03:0:b0:68f:2e7f:1d24 with SMTP id r3-20020a0ccc03000000b0068f2e7f1d24mr3139827qvk.60.1709227918521;
        Thu, 29 Feb 2024 09:31:58 -0800 (PST)
Received: from [172.17.0.2] ([20.51.199.0])
        by smtp.gmail.com with ESMTPSA id oi4-20020a05621443c400b0068fe540ff2csm936180qvb.115.2024.02.29.09.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:31:58 -0800 (PST)
Message-ID: <65e0bf8e.050a0220.8cf6f.46bb@mx.google.com>
Date: Thu, 29 Feb 2024 09:31:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7118792184001554987=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add command to create local endpoint in bluetoolct
In-Reply-To: <20240229162119.57523-2-silviu.barbulescu@nxp.com>
References: <20240229162119.57523-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7118792184001554987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831169

---Test result---

Test Summary:
CheckPatch                    FAIL      0.68 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      23.97 seconds
BluezMake                     PASS      728.66 seconds
MakeCheck                     PASS      11.96 seconds
MakeDistcheck                 PASS      165.23 seconds
CheckValgrind                 PASS      228.23 seconds
CheckSmatch                   PASS      333.51 seconds
bluezmakeextell               PASS      110.62 seconds
IncrementalBuild              PASS      687.16 seconds
ScanBuild                     PASS      961.37 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] Add command to create local endpoint in bluetoolct
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#113: 
to configure the broadcast streams, but no local broadcast endpoint is defined

/github/workspace/src/src/13577335.patch total: 0 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13577335.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7118792184001554987==--
