Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F81A4F33
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868569; cv=none; b=mS0XFh2WhwJDVcZMrjPEIsau8EJ2kAQC4yQgqInVQYSSZ6VAAYPe6wGZ59ALVOeFrgVCFs7aEZ1bWA3sl8sBK2ftfDasiiduYRZ74DvdfMUVaOHBtxQd3zhqeS4Sk6hRJ/H4HJNfRjsTFWiYEuZaTPgx8YXLMCSI5ZCVvhadnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868569; c=relaxed/simple;
	bh=QsIOJ77ydPlecGsg2sEKG0sqADY3A1K4s95nM2uGiCk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GHgV/15ywPIdnV07PVEG2usnZtaV7Ik/+s4QMjpCxi74ehRCaBV3rbHz8QjYlcmovYftUDe59pQMAcKGCIVn6xxR8xeaIM3kAWUPrvQ9F5YuX0VsjR0xxopV8/hAFKfQIedwCf4lcNOJQiJnCFQdZdBFZRE8yOZ+DoVHS6QqpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU7hr9nJ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU7hr9nJ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a3574acafeso447618185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868567; x=1725473367; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j+erK0Kx7ptw+zZs9ns6/1TEFVsi/Gksi9kbeWbL4YE=;
        b=kU7hr9nJIFiEUiU3A1XNWg0eRD0g0KZJz2To56X4U1A06LyR1nkID/SylDarfJ7KMW
         3CIG8A+EG6Yff9Kbf7huwppomFNSgncu3wfXju7oGv6G9na2rUSe4Si4ThqJ1bqK91iy
         xwKwEWcgK04RDVqc8QfrJs5Meoa1aCdnk7cmdOZpURit4FWgvSDwK81ikKa4pnSgKc7D
         Q9/Pcal2KpNJ2HRq0Ytx47nsimYCePo+Onj96MOhfunGI2pbTLhOKWwrOrUx0FXBKrFp
         H/mKKFZippyk+60B61Ot7mdB0Ytbazvgm/IsCx/stWgcv0vOO3VSjH88lFa3F5E140uQ
         3fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868567; x=1725473367;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+erK0Kx7ptw+zZs9ns6/1TEFVsi/Gksi9kbeWbL4YE=;
        b=PYaaBeXiMOJKjIMlLyQGgLP/QfYCxnM7qMPBvbh9xOhBwQzgdlnI6+SaOIfT/JeHrz
         dig263rtxcR7RRCrHvIq3i9zSkXneBfrtP1IFu243T+g7gD1d2orzvtVWGJ3Vx1BxRCR
         VrVRY2TsnVBrJf2Ih+A6cm9mCrUf36IDeMzCwccu79TRWOF5KFd0NQPJqXT79zc76C4+
         rtX1W7pYBE+pOpBt1eJWLIfJ674d9YSKtBbBdliiRV8wJ7HSYpxhKS3GQGCidA8kF34u
         klHrW0LYyp4+lGN3bJ7owOgpiqgbhD9pGeQlVUj4IZ/jr4hbCKAK5XJ8d4hTIk79xnmO
         jRzQ==
X-Gm-Message-State: AOJu0YzuYSzHIXT1CPuFE8Tpf/r83gor0qTRyN9x7yt9DY+17YFaVtSj
	TxYX5i6oO6+m80vHDvqDL8tO2WfiTLonG+vOR16WYyRG00nX3M3AFtT/dQ==
X-Google-Smtp-Source: AGHT+IF/010Z5giUnwAdh30cwBXOIBDkRpOI0Kh1Tl9UkdtcqO07upMNnVkeFIC9QaXOMQ88UnXiaQ==
X-Received: by 2002:a05:620a:404a:b0:79c:130:452b with SMTP id af79cd13be357-7a80426337bmr26269585a.47.1724868566651;
        Wed, 28 Aug 2024 11:09:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.46.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a80236a344sm24777385a.81.2024.08.28.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:09:26 -0700 (PDT)
Message-ID: <66cf67d6.050a0220.28ff9.2a11@mx.google.com>
Date: Wed, 28 Aug 2024 11:09:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0036787679584214858=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] adapter: Fix up address type when loading keys
In-Reply-To: <20240828153956.861220-1-luiz.dentz@gmail.com>
References: <20240828153956.861220-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0036787679584214858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884360

---Test result---

Test Summary:
CheckPatch                    FAIL      1.12 seconds
GitLint                       PASS      0.61 seconds
BuildEll                      PASS      24.67 seconds
BluezMake                     PASS      1628.74 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      178.68 seconds
CheckValgrind                 PASS      253.12 seconds
CheckSmatch                   PASS      357.20 seconds
bluezmakeextell               PASS      120.68 seconds
IncrementalBuild              PASS      2944.83 seconds
ScanBuild                     PASS      1002.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,2/2] Revert "adapter: Fix link key address type for old kernels"
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '7ad5669402c9acff8e4cc808edc12a41df36654e', maybe rebased or not pulled?
#97: 
This reverts commit 7ad5669402c9acff8e4cc808edc12a41df36654e since it no

/github/workspace/src/src/13781508.patch total: 0 errors, 1 warnings, 136 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13781508.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0036787679584214858==--
