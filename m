Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpLkQ0nX"
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E310E
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 09:02:47 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d093265dfso19197186d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700586166; x=1701190966; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eNG/Z++een2Rj+jrSSxVKQSU+K4xJEXacsB5Smw/jyI=;
        b=RpLkQ0nXVq4nS3z+YLbXm5m0g4QFh/di262MWDGl9CS0A306aBm/3M/ST0nVEkTFpn
         RvMfdaudvknXLK791o1v5IplrRgRhB7ua6rUjvAeD809wHRLJ37skPzQSsPs1H18nlG2
         5aRBf0L8JRZiLUgHdwMMmS1r3nLPPGb75M3mynE0hUijWv3Py8W7bNFPfLcBSrcgsTOq
         kxq6+zXy/gh+AI7kdBkssmCpmPxzw9iezX9V9UhkCGHXXKEId5004OU/o6md3O/EYg4l
         skXSgBenZTeZBe0sMUJBDMzfEjLLMojShtEJksdIo68T5NOxIYMOEP1sg5iQiu9NcZdy
         ptwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586166; x=1701190966;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNG/Z++een2Rj+jrSSxVKQSU+K4xJEXacsB5Smw/jyI=;
        b=GUpGMe9NpLD37CqpZb/TF8UgOjJYTnhuStAp1xIGCrSKYZ/41PbVDwE2CP/L4+3AKx
         BdWC3vVaoIzLWVi3p0UuVv131f0tV7+nbsq8bdI+sDwZhniP90D4vQNrlHkiNthcjxWk
         VG5i8nTp3jfAffx908ank50DcTLXTDsw63Rw6cBepP1R3EV0utRBC9n4g45w1S2Eqm3S
         jo7IQk4gsDlR8eFvzO11Kmm4OpeGy8tsRvXu3C13jG+y2omvRv6RqDGlXatlSMgehKjV
         6reaWbqkCIDllDta9WABQEHsTMHkm8LhL9zsEKMLZI4Q2fZufPqhlh8kHrDDOdP7NMUK
         7YUQ==
X-Gm-Message-State: AOJu0YxMTx99uVUb8oTKByEfpLw22TRdrhvc28lc1s0Yf1a86meRQTex
	vozOPPg4P/aszyiUJMtVkAmdhr1EFMk=
X-Google-Smtp-Source: AGHT+IG+KF1b+lfCMWGpY386izO5REpqhlRJnCKeRUKYXIHfnrt0u1NPKkYjRLq6jXsa0Y9t1PlyZA==
X-Received: by 2002:a05:6214:500a:b0:66d:4018:da9c with SMTP id jo10-20020a056214500a00b0066d4018da9cmr13456701qvb.9.1700586166135;
        Tue, 21 Nov 2023 09:02:46 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.162])
        by smtp.gmail.com with ESMTPSA id p7-20020ad452c7000000b0066d20f29e5fsm4126718qvs.35.2023.11.21.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:02:46 -0800 (PST)
Message-ID: <655ce2b6.d40a0220.9e866.2e79@mx.google.com>
Date: Tue, 21 Nov 2023 09:02:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3016650883593684824=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yuran.pereira@hotmail.com
Subject: RE: Bluetooth: Add documentation to exported functions in lib
In-Reply-To: <GV1PR10MB6563B895FB2E3677DB984302E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563B895FB2E3677DB984302E8BBA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3016650883593684824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=802928

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.41 seconds
CheckAllWarning               PASS      30.28 seconds
CheckSparse                   PASS      35.15 seconds
CheckSmatch                   PASS      99.10 seconds
BuildKernel32                 PASS      26.73 seconds
TestRunnerSetup               PASS      415.21 seconds
TestRunner_l2cap-tester       PASS      23.16 seconds
TestRunner_iso-tester         PASS      42.91 seconds
TestRunner_bnep-tester        PASS      7.00 seconds
TestRunner_mgmt-tester        PASS      164.00 seconds
TestRunner_rfcomm-tester      PASS      10.97 seconds
TestRunner_sco-tester         PASS      14.51 seconds
TestRunner_ioctl-tester       PASS      12.10 seconds
TestRunner_mesh-tester        PASS      8.77 seconds
TestRunner_smp-tester         PASS      9.75 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PASS      25.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: Add documentation to exported functions in lib
WARNING: please, no space before tabs
#107: FILE: net/bluetooth/lib.c:36:
+ * ^I^I bd address.$

total: 0 errors, 1 warnings, 0 checks, 125 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13463374.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3016650883593684824==--
