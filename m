Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFC7D096
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218748; cv=none; b=TSxJh/goKp+NNh1Ozjgun6i1c6Z9L40GjbLnIbFa+1e8UMoq3aVIsK5YrlX4tN8bU/lHYSKz0m7IlFrCB44PYQ5FP1N8thLpdt4+S+l+QuqhQXeQE67oDVFRvpysD0hGi2Vk7ntU4wxPF5uJfxjJxAkrFmsQ6Z6eziq4TorED8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218748; c=relaxed/simple;
	bh=PxBLc5/+2zWIJOw2a0zi+2LybfyHDKeEoIg3EZ3iZHE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eeg38gHAfs31f7yuIcKW9n7TGUkN8eSwub8y5zg1dt3bgYzan7x4te9l47/WrxkNC2qQeHFlWb0t74jEwO0LKdknkNI+cESfjpmPtTGjAwYvSPATckczbcMUkg1KkezlxE830u0kbmbvcY35XyARIxGDCss/VdjFDp4cWgxhQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My1PWcd7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My1PWcd7"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7042882e741so116533b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718218746; x=1718823546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=712oFhqD20nxJGNyIR5z1+RDkDjMJS9aPW6s5UGkJ8w=;
        b=My1PWcd78O2z9zWiVR6Rnbj5SqkGTSSKzk5SYJbCnycxzsZ2jngnwQyoADRbTe4pgy
         nEdAqulqJ/7AoYTyq7RzNSBC9TxoYQ+pQSy9DnE2o2KGtbWB9xmHn1C415NnBspYT5bN
         hJjBtw2GzJpmVHrKBVQqCZbwXc6q0bfJvU9W+5uyUa9x90OfTs8q7x6GcL8gMqI0L+5l
         rqhwGJG43QnU1z0b7NGwQazCRGyvZtWIwoN2T4ZBgdUr4ky/WLoCYobsOdLsceS1SIaq
         mRfnL84JpqMKQZAX9/Kfcn+j2xpRSRK+lrmu3SPfUT3hzwPSc795hQyF0M+oHZzzTyfy
         pzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718218746; x=1718823546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=712oFhqD20nxJGNyIR5z1+RDkDjMJS9aPW6s5UGkJ8w=;
        b=iGLFjzFav21NOupBKT+VLNR7t3GVi1iO9Cbv5iyIfECgZukFyrWOPMNfrBFPqHZpug
         29Skzqe40Dkr+2AODl2Pfme7674Nqgu0DW5RON7EETuN0YZPz2+N/cjmBCRejJ2f+9VH
         tqaCwDd2FjyPiLiql7BhPuY6DDTTy9KZfdOgb+90j5Ed/Vs1V41IY4Imar6WMbHscc9+
         DbRGJNaWuEpJ2Spzqzngb9IZXQt2kNQTAnEAzNixxwT/7NAKvQWAJvCqjSSQC++gtqju
         UaymtWnoOeVtO9ZBVzzUHivReib4gHqTbfUvoB6PaJDwkoEbqs+qIlGqFDh1fcp6FcSp
         g76w==
X-Gm-Message-State: AOJu0YxpANLmFNnVJafXc4xc5fnLmiD0QOKWuqIoucZvjjHLohMGKGyZ
	HMNa7fB1rq90bHaWMF4AyDsTxt6PHPOTXqQfg9jtIVz/oWHQiSYE01y43g==
X-Google-Smtp-Source: AGHT+IHa24zC1XiZcsZtvDaVV8Pq0j8Ao/VDuKkKlfYEDbGVfVMfKusgUcdjbruWZn2ESKk4g8k2Zw==
X-Received: by 2002:a05:6a00:2382:b0:705:c431:74fd with SMTP id d2e1a72fcca58-705c4318047mr1838111b3a.28.1718218745909;
        Wed, 12 Jun 2024 11:59:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.76.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70431fe7bfesm6873571b3a.41.2024.06.12.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 11:59:05 -0700 (PDT)
Message-ID: <6669eff9.050a0220.1b097.5b77@mx.google.com>
Date: Wed, 12 Jun 2024 11:59:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5660072111011872810=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arun@asymptotic.io
Subject: RE: ASHA plugin
In-Reply-To: <20240612162041.689679-2-arun@asymptotic.io>
References: <20240612162041.689679-2-arun@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5660072111011872810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=861276

---Test result---

Test Summary:
CheckPatch                    FAIL      1.88 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      24.99 seconds
BluezMake                     PASS      1703.92 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      177.93 seconds
CheckValgrind                 PASS      250.39 seconds
CheckSmatch                   PASS      353.68 seconds
bluezmakeextell               PASS      120.61 seconds
IncrementalBuild              PASS      4577.41 seconds
ScanBuild                     WARNING   1025.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v10,3/3] test: Add a script to test ASHA
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#105: FILE: test/simple-asha

/github/workspace/src/src/13695335.patch total: 1 errors, 0 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13695335.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/media.c:1048:7: warning: Use of memory after it is freed
                if (req->cb != pac_select_cb) {
                    ^~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5660072111011872810==--
