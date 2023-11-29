Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcbFTBN/"
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33516F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 09:37:44 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-42033328ad0so281621cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701279463; x=1701884263; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FfOkgKNEqZq5/XSsVUr5ioDzr4DYK29AjLztrA8lPRo=;
        b=EcbFTBN/vEGXqYkKOqIGief5UrDs2a3TgOD0KZZVajNKO0nqBlWt++mQBGIrnLtwMF
         6IlT4qqWw8S7HU7OQ5rSGzm6OSaAMMsYbfYHmtYHuSvpZg5NNGKyIdPl4j7poQSiWRdC
         dshytfSlYPDhCL5jExeJwl8/aZBGnfz0hbVDsh4f4ZOSr4zdX1nVZgOvm0CyC8699pyl
         Nt8N1Yfd28AWZPwbOW5VB5wkMyuik8B2aTV91S3++8ZkiEZ5ubQ/MmOYdNfWliqlRqWj
         wM1ZPiTpdD+6lMCRus9fUJr52rs9+4g7YbVHRLx/wNNNrJplk1FHdeNb41dL45EQ9FDJ
         Jjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701279463; x=1701884263;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfOkgKNEqZq5/XSsVUr5ioDzr4DYK29AjLztrA8lPRo=;
        b=w1DDZLF4YUPYIgzLz8GDJ7o38/5d7HXpsR+3v3D5qJYfFqDw+T1KTqewpM5ZHdd2ZL
         spr0EddfuczUljyBScXfqHkkAjaiyJj5EFSZemXJhsnOJCnHg8mRsxJm8ZWkM4eqr/nA
         LmfgX0LBBcrd5jReegMnLBFUAD6jQ9b4xM0wQk4Lv22q+HJh8rvw85aP2mglmjnhTwHH
         2B3RRIjSIf3ZH79zvdNFpBDXnMqNGfj3agdVL0rcwY3anQL0VhymFtz7gXDQIEn08nWo
         /6gp2iR+F+votb3XXaakpXthLd57tGDh8uu2IBVAL2ilPz08hSktb4Q3e5EaelpvOv0J
         fvGg==
X-Gm-Message-State: AOJu0YydMl/dcmTWjyzZH7YLqZCmz31PLAoSjrXpRDiRjRJuG4tK2Pzl
	DlOS7agAMTH5Y8yUhOFrGjP13nABAVU=
X-Google-Smtp-Source: AGHT+IG6s989R779S+IQ5dSeMc2E+29ETwOQurf0qngBAd/YNaL5rjK3HjUDRaA/JTNsDr4YvnGDVw==
X-Received: by 2002:a05:622a:410c:b0:423:b92a:7fb5 with SMTP id cc12-20020a05622a410c00b00423b92a7fb5mr16442528qtb.12.1701279463022;
        Wed, 29 Nov 2023 09:37:43 -0800 (PST)
Received: from [172.17.0.2] ([172.183.91.41])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05622a229e00b00423a0d10d4csm4498106qtb.62.2023.11.29.09.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:37:42 -0800 (PST)
Message-ID: <656776e6.050a0220.4ac15.59a8@mx.google.com>
Date: Wed, 29 Nov 2023 09:37:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4996191637333534455=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] test-micp: Fix endianess error
In-Reply-To: <20231129163041.2075184-1-luiz.dentz@gmail.com>
References: <20231129163041.2075184-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4996191637333534455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805347

---Test result---

Test Summary:
CheckPatch                    FAIL      1.04 seconds
GitLint                       PASS      0.57 seconds
BuildEll                      PASS      24.38 seconds
BluezMake                     PASS      558.67 seconds
MakeCheck                     PASS      10.92 seconds
MakeDistcheck                 PASS      151.97 seconds
CheckValgrind                 PASS      212.07 seconds
CheckSmatch                   PASS      319.44 seconds
bluezmakeextell               PASS      97.57 seconds
IncrementalBuild              PASS      1026.37 seconds
ScanBuild                     PASS      925.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/2] test-micp: Fix endianess error
WARNING:TYPO_SPELLING: 'endianess' may be misspelled - perhaps 'endianness'?
#57: 
Subject: [PATCH BlueZ v1 1/2] test-micp: Fix endianess error
                                             ^^^^^^^^^

/github/workspace/src/src/13473187.patch total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13473187.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,2/2] shared/vcp: Fix endianess errors
WARNING:TYPO_SPELLING: 'endianess' may be misspelled - perhaps 'endianness'?
#59: 
Subject: [PATCH BlueZ v1 2/2] shared/vcp: Fix endianess errors
                                              ^^^^^^^^^

/github/workspace/src/src/13473188.patch total: 0 errors, 1 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13473188.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4996191637333534455==--
