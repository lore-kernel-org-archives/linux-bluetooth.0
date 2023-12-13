Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huhlT/AH"
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28605185
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 08:35:25 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-425a84ed4bcso41319301cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485324; x=1703090124; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+FzqhYUO+1OWDZXNimeaVbR+hObioqfP7K/tRUTHzB0=;
        b=huhlT/AHEwFJesqwqFINZD2zdSNpshVJhJ1ZekzavnFniFPPJyDeITygoAuEnIpxzT
         DkZYDSIdC/dBzucs3tiopWTJZz8T+GNnoWoInbN6fbY/ozkq2TDG2pj6jwf+UXrbOeEh
         Xefpw24aU/Wg/KxmiBF1QhicLQEdHK0KTf4CZDZqLD4rRt5nPIS+jTtR76Syr1IdyZ0B
         bhjCz4gjmMA9nSEtDFKtNdFYsl7Gsv/681OORWo6ACKB2EM4H0IpGLqIh+ajfiwkxxBJ
         T9ZO0OXa24RWeGXKOROEy/11GQwx1/5fhUuAb6T1wcAxIr/S5YMwdHYKva4twHsViIQH
         DBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485324; x=1703090124;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FzqhYUO+1OWDZXNimeaVbR+hObioqfP7K/tRUTHzB0=;
        b=DNDZHmdx+ow5SqyiRKBH6w7ilkhbtqAYj80NuUZLwzrt3CExK4oKJeyLYDudrqHpUZ
         voi0t9mAYGzoxMFc8nysY7OoctlupSLsrkYsx5wlz3pxl7slA1VWxlSUH7HJLor0BgiT
         TedRkvqgzcO6sDdiHIlJX1Dys9n2CTiHyXjblwBHAFgxLeq9Dv0FzJBPb9bmBMn8Ij9B
         T8WrbE6kpEiy6guIRrLSrA/gSZR6GE4WK7rfDYswoygvPhsyeVQpdkexc8nrJq3eHxfI
         kEdKkdaC93JvaGh7c/qDUj0lJMCYwQLcNsAUofpPHtFJKG487ZIgKS4HJz/SWcCJr/yw
         5ZWw==
X-Gm-Message-State: AOJu0Yy+IQm1L/N/oPJSxj6UJjcBvxgNgQyaEXMtAX/bPAFuVjWFK/xb
	Dx2J05Ym2Uybxw+rdbAwvb/KYxcV820=
X-Google-Smtp-Source: AGHT+IGvfjDODgcgI3M97GMzonBnN3h/CvGFMmxypjS7BHEa1eUC0GP1gZQOlXOIgOU0V7jdODKQ3g==
X-Received: by 2002:ac8:59d3:0:b0:425:4043:1899 with SMTP id f19-20020ac859d3000000b0042540431899mr11355579qtf.76.1702485323846;
        Wed, 13 Dec 2023 08:35:23 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.39])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8455a000000b0042387bd254bsm5030951qtn.9.2023.12.13.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:35:23 -0800 (PST)
Message-ID: <6579dd4b.c80a0220.255a3.b03a@mx.google.com>
Date: Wed, 13 Dec 2023 08:35:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1404275335791529196=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: bluetooth: bnep: fix fortify warning
In-Reply-To: <20231213154303.159184-1-dmantipov@yandex.ru>
References: <20231213154303.159184-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1404275335791529196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=809736

---Test result---

Test Summary:
CheckPatch                    FAIL      1.01 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      27.56 seconds
CheckAllWarning               PASS      30.03 seconds
CheckSparse                   PASS      35.48 seconds
CheckSmatch                   PASS      99.17 seconds
BuildKernel32                 PASS      26.55 seconds
TestRunnerSetup               PASS      419.22 seconds
TestRunner_l2cap-tester       PASS      23.17 seconds
TestRunner_iso-tester         PASS      45.35 seconds
TestRunner_bnep-tester        PASS      6.93 seconds
TestRunner_mgmt-tester        PASS      161.37 seconds
TestRunner_rfcomm-tester      PASS      10.88 seconds
TestRunner_sco-tester         PASS      14.74 seconds
TestRunner_ioctl-tester       PASS      12.12 seconds
TestRunner_mesh-tester        PASS      8.76 seconds
TestRunner_smp-tester         PASS      12.01 seconds
TestRunner_userchan-tester    PASS      7.50 seconds
IncrementalBuild              PASS      25.79 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
bluetooth: bnep: fix fortify warning
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#61: 
declared with attribute warning: detected read beyond size of field (2nd parameter);

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13491578.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
bluetooth: bnep: fix fortify warning

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (82>80): "./include/linux/fortify-string.h:588:25: warning: call to '__read_overflow2_field'"
10: B1 Line exceeds max length (84>80): "declared with attribute warning: detected read beyond size of field (2nd parameter);"
21: B3 Line contains hard tab characters (\t): "	unsigned char	h_dest[ETH_ALEN];"
22: B3 Line contains hard tab characters (\t): "	struct_group(xxx,"
23: B3 Line contains hard tab characters (\t): "	        unsigned char	h_source[ETH_ALEN];"
24: B3 Line contains hard tab characters (\t): "	        __be16		h_proto;"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============1404275335791529196==--
