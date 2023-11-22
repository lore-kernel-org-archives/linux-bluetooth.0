Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMEzFYzb"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10053E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 10:45:14 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so113840b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700678712; x=1701283512; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+rXanb/3hZy7N0+x7T0NNcezUOUVXOjq2mHUQI46k4U=;
        b=KMEzFYzbCawFUT8dcoC6sUeaarpCcvFzubtmJctLmlvaSVgaePsYzMX8oiCs4IcAy1
         ezCbUfy4S/iDPtWc6Iq0VZCmWoupK/rR/Hffxulsk0EXkqnDwt/7xlWaE7yDTQ7XaLVj
         7vNJsRZc6G+N43qi6+tsMaA7ViqCcgJm11GWXIzPjPiWdJ26Hf0y9ely30ISldV2db50
         2i+8PLTiSGEKMsDOqZgG5ZbOxILwRBqrilhfFFIp84vuxhqpugg7Z8p1/MKXLTsCFtFc
         +/OnuyTa65RrrW0HtZcgfxbegUsLaHslI5GLAtSKv9ktGrQdnnBW9VdrYgyF3inXSdKK
         ushw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700678712; x=1701283512;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rXanb/3hZy7N0+x7T0NNcezUOUVXOjq2mHUQI46k4U=;
        b=Pnb+Aa3PIyHS+K2geIeF48j8qAnMGkdhyiW1M4qD2EezG5c7cR8p2OxTNTG+ICt8jt
         +cOfye3NJ0yXXxsoUiMj5ExCLZAArsmYRZt54to39VLk3TQIulpXt9z5hJRr9RqITZod
         CyxBLtA+0VIYSqDvn7uDcei7bt5xlraI1PpgQYfL/CvyT53DbMIvyR1w3H/KMtdpDvzI
         FTpJKpRUW2RIoBm+OcvmAgTUWR9RW5NjjH4f8zD+5s3cKJrz/9/HbmoT2Xug4bF+zCD5
         7RQJnh01uLC/K80rXhHQU9/dx5IVrDBy7ZaE9PzrHnmLSEDiNxWhG2meFuLYTH2i54Eh
         z4cg==
X-Gm-Message-State: AOJu0YyOWG3Nd7495P0z0Cob4GHewkuInnO31n50XrcSJSU9zmeGKBZX
	uajBek0frVaSldL+Qs9IFcCQqAWdG8Q=
X-Google-Smtp-Source: AGHT+IEPTgQjNRj3Mfaw+cGAq7BA6uxwrrxydeaj1NTjY7jjL3b6fQYCYrsPS1RLMQFM7zY8X2Gkrg==
X-Received: by 2002:a05:6a21:338d:b0:187:d8d7:5f00 with SMTP id yy13-20020a056a21338d00b00187d8d75f00mr3509686pzb.12.1700678712246;
        Wed, 22 Nov 2023 10:45:12 -0800 (PST)
Received: from [172.17.0.2] ([13.83.123.116])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006c31c0dfb69sm45274pfn.188.2023.11.22.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:45:12 -0800 (PST)
Message-ID: <655e4c38.a70a0220.2a0d8.0705@mx.google.com>
Date: Wed, 22 Nov 2023 10:45:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8121461253188579452=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND] Bluetooth: hci_core: Remove le_restart_scan work
In-Reply-To: <20231122175636.866900-1-luiz.dentz@gmail.com>
References: <20231122175636.866900-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8121461253188579452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803389

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      28.27 seconds
CheckAllWarning               PASS      31.23 seconds
CheckSparse                   PASS      36.70 seconds
CheckSmatch                   PASS      101.34 seconds
BuildKernel32                 PASS      27.83 seconds
TestRunnerSetup               PASS      432.11 seconds
TestRunner_l2cap-tester       PASS      23.97 seconds
TestRunner_iso-tester         PASS      40.21 seconds
TestRunner_bnep-tester        PASS      7.22 seconds
TestRunner_mgmt-tester        PASS      166.49 seconds
TestRunner_rfcomm-tester      PASS      13.10 seconds
TestRunner_sco-tester         PASS      14.69 seconds
TestRunner_ioctl-tester       PASS      12.21 seconds
TestRunner_mesh-tester        PASS      8.93 seconds
TestRunner_smp-tester         PASS      9.87 seconds
TestRunner_userchan-tester    PASS      7.40 seconds
IncrementalBuild              PASS      25.55 seconds



---
Regards,
Linux Bluetooth


--===============8121461253188579452==--
