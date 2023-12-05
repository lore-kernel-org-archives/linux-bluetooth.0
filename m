Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft7AcjhD"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A730B4
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 19:33:23 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77d645c0e06so336436885a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 19:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701747202; x=1702352002; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2+sFrFBSi1wN+WYRqW7KS6uz3G2aq8qpC7ceWqV2avw=;
        b=ft7AcjhD+syUQpEQPpu7BhaAsY4LMFJtaUjslj8r8L+5ZEq/WPH6Aqr8ZCI9pYDWM0
         7OWqtVPSA4eY9qYqZA9LUXJnUHyNgRrhBbbXSaPNuzkWGZKnjfRTEr68hzZtHjaUzLhk
         Qb6njAcm/xqq/qTaaX/BMv1bktGIzEX/JHA9KHorgH/98cX5wQJqdpjGlXjreqwNl5yp
         jCTVKmaPM3VuRYeiTPAIhLXLGXeMu9vhmtLG/9vgxaEF1E20My7Xb4iTCMx+mIOe/Y+X
         HGBztx5xOv5RGCawZhE28Xim7BOiPs4GyISmyK3Efd+teG0lDa+RKQBihYzGMD0Fq6z+
         pJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701747202; x=1702352002;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+sFrFBSi1wN+WYRqW7KS6uz3G2aq8qpC7ceWqV2avw=;
        b=hY5APJq+pZMEUlC4yECfITOKyhLluVFFT8k2nUPjwraOrU0W4F8FTF0sn5NAcT6QA3
         3RcdqFyGvHFtkPL8nReFmRiSuZcnZOihb5Oj6BWszqH6iaKcX9440/lRvC4s1O0mZGoV
         4hNpZTyLN6z4vuV1IwvTnfL1Df4BSX8gl/6+Iwzu4xB9MMQmfZPjXBY9KCFRlgu+IBwG
         LclADVETLyFhVu0NPTCZC5yYs7JCUWkHAobg9wQ9T04Pk7JkI4XX/My6K/IgWNtuFB3N
         GjjrZXZLyhGx+G/NDHh4j8TR3QyiUuMpaqrMxATfORcanW8WpaKXSC9IBqrykRPeMRbA
         7gJA==
X-Gm-Message-State: AOJu0Yzo2Qyx06FDwVmLy7ys9v42FPvQkkFufiU5P3B+XvWSPZ1pcGOY
	T+NopPbnO8ByA23mPTObuGg6/xh/EBc=
X-Google-Smtp-Source: AGHT+IHSFChz49folOf42wZL7exaAb1POW/69J3tEeGqaF/Vz6rcpGrInclgx9YEXbzMFis1zeAt/A==
X-Received: by 2002:a05:622a:11c3:b0:425:4043:1d74 with SMTP id n3-20020a05622a11c300b0042540431d74mr859800qtk.71.1701747202582;
        Mon, 04 Dec 2023 19:33:22 -0800 (PST)
Received: from [172.17.0.2] ([20.55.14.147])
        by smtp.gmail.com with ESMTPSA id o26-20020ac872da000000b00423890096afsm4830100qtp.2.2023.12.04.19.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 19:33:22 -0800 (PST)
Message-ID: <656e9a02.c80a0220.83aa9.1c15@mx.google.com>
Date: Mon, 04 Dec 2023 19:33:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9117736412529349681=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 15013537245@163.com
Subject: RE: Bluetooth: hci_sync: fix BR/EDR wakeup bug
In-Reply-To: <20231205024137.601987-1-15013537245@163.com>
References: <20231205024137.601987-1-15013537245@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9117736412529349681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=806868

---Test result---

Test Summary:
CheckPatch                    FAIL      0.91 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.54 seconds
CheckAllWarning               PASS      29.97 seconds
CheckSparse                   PASS      35.47 seconds
CheckSmatch                   PASS      98.17 seconds
BuildKernel32                 PASS      26.70 seconds
TestRunnerSetup               PASS      413.42 seconds
TestRunner_l2cap-tester       PASS      22.97 seconds
TestRunner_iso-tester         PASS      44.84 seconds
TestRunner_bnep-tester        PASS      7.02 seconds
TestRunner_mgmt-tester        PASS      165.45 seconds
TestRunner_rfcomm-tester      PASS      10.99 seconds
TestRunner_sco-tester         PASS      14.56 seconds
TestRunner_ioctl-tester       PASS      12.14 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      9.89 seconds
TestRunner_userchan-tester    PASS      7.45 seconds
IncrementalBuild              PASS      25.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_sync: fix BR/EDR wakeup bug
WARNING: 'comming' may be misspelled - perhaps 'coming'?
#51: 
has hci mode change event comming,it cause controller can not enter
                          ^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13479332.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============9117736412529349681==--
