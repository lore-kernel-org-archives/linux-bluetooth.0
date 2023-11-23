Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfpOcstf"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C77F101
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 08:34:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf98db3569so2893425ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 08:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700757271; x=1701362071; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9VLhC+xrYMPjPrTpEW3LFvucJPQ2w+y/7icKO/QjTqs=;
        b=DfpOcstf0AbguYOrf71uSvMAGRBKy0ohAdkcGULdc0V02k4g7rBWMXUp0OSJIfHa4o
         XKRyFSkCm3H12nXj9JV1seovNRsITfDoZubFyB+OapKjz3J/elXZUEo+tk2xPH9KOwMJ
         352HkT2mML0ddIP+lXkOEQaiTxDwVNkAacTyTw7OxD3vds/d02Uh5KVrZ6vu/VV1nMDj
         q84Wu4ZMb+IXjMUlIy91ZcZx9Zx6c9YIKJhAhyfiOYchY4ZqTDAZO/gYzROQGYdyMVmI
         r0WpDREalnRR4FE8AEGwVfZFtq1xnqv3QZ54lTdIq5XXC6hN/HKUSR7lbAuh3k3UidyV
         fVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757271; x=1701362071;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VLhC+xrYMPjPrTpEW3LFvucJPQ2w+y/7icKO/QjTqs=;
        b=GkHLpCFg8oSF0bGBp9VuZgs2CLz8elm9yv57Jq5UG9DkyVYdo8dsweOmuLJvCnamIm
         DRVKGBjaAbFbQQ9TI3C1dPQ8cQ16KU8SyCs+ukL2OS+5vlqOxOwo+gKKemo4AlO3XKE0
         ctOFZxt1XQMVZ9uIU+5zkAUDKd47/ZlmiU01H5/4Y6SnwrT2fXSCta7/QiPmmNojiuGc
         mN0VVnvio65GOFR56XnbNpyvRR2E7e6819KheBOKdT9xm4qX4motruTNEj7bnFrxg6Aa
         m00m9NALQ+aVb20+KbRt2Ty4kSlfWpR9RQvySKfR5MvGIOby5sBad7ak4yhDQjKsV8cn
         HrVw==
X-Gm-Message-State: AOJu0YysALV+g72uZa8K3yGFFttId6U8yx2Os2mPdYn5pdl5td+B4K+g
	QmB55YO5XXoJzjIB1uCTGODb8euzMtY=
X-Google-Smtp-Source: AGHT+IGnDqvLLVYg/aylZm7/9+OtbSMAFVKlmV+AmFXgv9jc6M02PHCmPO+xIgJiYQ9OqZskSoOoYA==
X-Received: by 2002:a17:902:e752:b0:1ce:1603:f50e with SMTP id p18-20020a170902e75200b001ce1603f50emr15242plf.42.1700757271422;
        Thu, 23 Nov 2023 08:34:31 -0800 (PST)
Received: from [172.17.0.2] ([20.172.2.101])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001cc52ca2dfbsm160897plb.120.2023.11.23.08.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:34:31 -0800 (PST)
Message-ID: <655f7f17.170a0220.a2ce5.08e9@mx.google.com>
Date: Thu, 23 Nov 2023 08:34:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3674637279174525852=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for bcast multiple BISes
In-Reply-To: <20231123151033.22898-2-silviu.barbulescu@nxp.com>
References: <20231123151033.22898-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3674637279174525852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803744

---Test result---

Test Summary:
CheckPatch                    FAIL      2.70 seconds
GitLint                       PASS      1.07 seconds
BuildEll                      PASS      23.80 seconds
BluezMake                     PASS      548.39 seconds
MakeCheck                     PASS      10.56 seconds
MakeDistcheck                 PASS      149.20 seconds
CheckValgrind                 PASS      210.32 seconds
CheckSmatch                   PASS      313.90 seconds
bluezmakeextell               PASS      95.74 seconds
IncrementalBuild              PASS      2507.10 seconds
ScanBuild                     PASS      920.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v5,2/5] audio/bap: Fix source+sink endpoint registration
ERROR:TRAILING_WHITESPACE: trailing whitespace
#136: FILE: profiles/audio/bap.c:1106:
+^I * The broadcast source local endpoint has only lpac and broadcast $

/github/workspace/src/src/13466329.patch total: 1 errors, 0 warnings, 72 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13466329.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v5,3/5] Add support for multiple BISes
ERROR:SPACING: space required before the open parenthesis '('
#551: FILE: profiles/audio/bap.c:1037:
+			if(curent_bis != NULL)

/github/workspace/src/src/13466331.patch total: 1 errors, 0 warnings, 1286 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13466331.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3674637279174525852==--
