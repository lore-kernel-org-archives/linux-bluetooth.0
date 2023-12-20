Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93652482DB
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbdeB1SP"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f33cf014cso33263106d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703097004; x=1703701804; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7TIoFjNLtO/dnf+MfLDZXLtCtnJZHmFH68QKyAAfuc=;
        b=TbdeB1SPDLrc76cNdGxIdBpDEHWeN5KQdu4qtvcVIkorcISppxbBI7dP/BkpTOz+S0
         QXIskvv325TXCmReijhmlcwus/JHmIP6gZ9Gtw35Z6zaT6Pc37rXZprtR7DKV1qvCEUI
         9jfX4D19gV2Mvm6wq0kqzuz75kLCBP7xCfk7GSLe70ZDkAmBaKF8BEiznyELg7qFz2hc
         JHVO5UihtL5a2UKMLA15Kw5O7g1cQWO0Kc9HCUZoK/Sz4z+QYTn0Q+npMTPpF2VZd929
         RKGKqMhk+ek6AcyhEJj3dGV4pOhdeXUgmO8jSEwugFao7LyRAU/X33ti+OmE34WQ7mGw
         HKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703097004; x=1703701804;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7TIoFjNLtO/dnf+MfLDZXLtCtnJZHmFH68QKyAAfuc=;
        b=NVLctJgTo7F1Mi9VM1lMT2a/1d0jaBVWc/ZfjA0lqWQJCcmlLG3M/saJIVp7o16NTk
         bxm3kMN5CROUbIUTYIGZTJfZJWzcZskbG8dcEYGS44RqihFRasPRFqhefCouu2CeBXQl
         XM9YkH1lAgtHT2zCGy+BWmalJTOJnCMEJLepqV2DECiDmjzyJaMe6eb139Nz6S0zy86G
         4SRcYIZ/AHinNaO4mCVLu8qNzPVEwUj0UZZtLFgXvH/OWd2f5qoFVs5LqkXYkuzwYS0Z
         pFsS2ZdBYyoGCIhadMq/pglaRL0VndtvTEnWa1tKRR93fNdk1OwN9CJbQEk1L/Y80PIK
         cyQg==
X-Gm-Message-State: AOJu0YxE/Omt+WiWmgRh5oWPFMlNgX9OR7Y6J54cALzBrSOeFC+/8YTb
	jUIQL9z0mIx5tC9TylqexgbR/hUcZdk=
X-Google-Smtp-Source: AGHT+IHR7QDXsy9Uvw+dbkHuPQ8cRd5qvFk6T7Y4YyeN3WkSCVWnbxYY0YTHHu0bhmKN6dX5DiaMuA==
X-Received: by 2002:a05:6214:1d05:b0:67f:63a5:b39c with SMTP id e5-20020a0562141d0500b0067f63a5b39cmr5514828qvd.11.1703097004153;
        Wed, 20 Dec 2023 10:30:04 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.102])
        by smtp.gmail.com with ESMTPSA id d5-20020a37c405000000b0077dc395df88sm112196qki.32.2023.12.20.10.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 10:30:03 -0800 (PST)
Message-ID: <658332ab.370a0220.c5b26.108a@mx.google.com>
Date: Wed, 20 Dec 2023 10:30:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3934477073478590602=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [v2] adapter: Fix link key address type for old kernels
In-Reply-To: <20231220173052.1617172-1-xiaokeqinhealth@126.com>
References: <20231220173052.1617172-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3934477073478590602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=811904

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.24 seconds
BluezMake                     PASS      727.82 seconds
MakeCheck                     PASS      12.00 seconds
MakeDistcheck                 PASS      160.13 seconds
CheckValgrind                 PASS      222.20 seconds
CheckSmatch                   PASS      326.17 seconds
bluezmakeextell               PASS      106.33 seconds
IncrementalBuild              PASS      674.29 seconds
ScanBuild                     PASS      925.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] adapter: Fix link key address type for old kernels
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#76: FILE: src/adapter.c:171:
+static GSList *link_keys = NULL;

ERROR:INITIALISED_STATIC: do not initialise statics to false
#77: FILE: src/adapter.c:172:
+static bool link_keys_brder = false;

/github/workspace/src/src/13500412.patch total: 2 errors, 0 warnings, 102 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13500412.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3934477073478590602==--
