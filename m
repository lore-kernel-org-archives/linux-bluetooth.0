Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7F44376
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Dec 2023 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuAPskTZ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-427e9ba503fso4157111cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Dec 2023 02:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703674634; x=1704279434; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x1elz+KJ7iBRtawEfnBv4LQHM4yHHnwT1VQ6cxZbQ4Y=;
        b=TuAPskTZcOjkhUms8uyGRrenRViHH/iIhSuSavdsG6u1XXFoXilK5J5+AaOldj3ORF
         s1M2WsQ9buB01VAHqsN/sIAfu6jt4p1CyKZwoSuoaasNWJwMdC4G7K6bsZcdEG5f51Zd
         FKlnLphCIiJR7TLovVVe3GfNY3jDD9ppYH2dIGMzK55DzspDt6WsluJuF23Dw93tcGdO
         reYyj0Zbbu1ly/P8FgUzRayIMi14okvoV3AFoxMY1IX+gO+JafOCbUv82egoFGPQn9FD
         TWlCkLd3wpJpn/RGlS6ewG5xqKfDhr/0rzjGOsL83zvdGmR6UoJHmr06jEMMgi/8Svte
         xZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703674634; x=1704279434;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1elz+KJ7iBRtawEfnBv4LQHM4yHHnwT1VQ6cxZbQ4Y=;
        b=CoqQUNgoIi3f5/8ELS9iOq3FUVJPLabuB0+aTHx05r3rBoLbZbEArss+mVcFfoqkI3
         WE40XTkKvpzpxl1q8/7fMEXjpBWj4G+Jz7t77AjGP1vj7M3qWRaMVSvOox3D+1L3CIO0
         fo9LOhaQwAoveNIDIZdjtAMM6dqfkp+asu9clIFOnvgrSaD8d+vpU7fOEf4tywVduNE4
         kboByghN8ENn+FFXIYTzCspdYIjqW7Fy99DKWXxVoLtXTbFh0C5uJaX00ek9BJf3FJh+
         7RlOHxCwJZ5U/3I/shVAGFrICFhgaT3FvyuReG+XVKo9pkCuFSTE//zf2yF0gyrewS04
         lkRQ==
X-Gm-Message-State: AOJu0YxS4ucVWDTBrLv0peZ4YE6MqRsJ/IYfZi/ezNH4roPl2MOknCDK
	5nsGupLsxrJmw0pY8Xwf1KWW4y7huSI=
X-Google-Smtp-Source: AGHT+IF4V4tmgm4H8v7+70PBsrFwAuK3FmYzHHF74BmjtGzkD3uo+3lQHZ6FzWKB2eDxOy6d10qkKw==
X-Received: by 2002:ac8:59cb:0:b0:427:ec41:36ee with SMTP id f11-20020ac859cb000000b00427ec4136eemr1009125qtf.106.1703674634414;
        Wed, 27 Dec 2023 02:57:14 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.65])
        by smtp.gmail.com with ESMTPSA id cn10-20020a05622a248a00b00427a4875c14sm6230090qtb.86.2023.12.27.02.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:57:14 -0800 (PST)
Message-ID: <658c030a.050a0220.9b0ec.232c@mx.google.com>
Date: Wed, 27 Dec 2023 02:57:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0383076714137925071=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid
In-Reply-To: <20231227101003.10534-1-johan+linaro@kernel.org>
References: <20231227101003.10534-1-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0383076714137925071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=813030

---Test result---

Test Summary:
CheckPatch                    FAIL      1.51 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      2.35 seconds
BuildKernel                   PASS      27.82 seconds
CheckAllWarning               PASS      30.14 seconds
CheckSparse                   PASS      35.81 seconds
CheckSmatch                   PASS      98.18 seconds
BuildKernel32                 PASS      27.09 seconds
TestRunnerSetup               PASS      429.15 seconds
TestRunner_l2cap-tester       PASS      22.65 seconds
TestRunner_iso-tester         PASS      44.40 seconds
TestRunner_bnep-tester        PASS      6.80 seconds
TestRunner_mgmt-tester        PASS      165.38 seconds
TestRunner_rfcomm-tester      PASS      10.63 seconds
TestRunner_sco-tester         PASS      14.27 seconds
TestRunner_ioctl-tester       PASS      11.72 seconds
TestRunner_mesh-tester        PASS      8.70 seconds
TestRunner_smp-tester         PASS      9.71 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PASS      25.58 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#73: 
Reported-by: Felix Zhang <mrman@mrman314.tech>
Link: https://lore.kernel.org/r/77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech/

total: 0 errors, 1 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13505281.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (93>80): "Link: https://lore.kernel.org/r/77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech/"


---
Regards,
Linux Bluetooth


--===============0383076714137925071==--
