Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeLRNETS"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0771183
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 09:01:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d075392ff6so25733575ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Dec 2023 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701795716; x=1702400516; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KkPsD6IaRakopVoTTU50Xx50T6Qx9xHddJGp8xvjOrw=;
        b=NeLRNETStOTZAFF961+kMHS5WgM6EATkLsbvpY1XjchhGByJpiQn2F96dIxSp1m8/7
         lTm0Gk32FeB+xbBdoI6LrwluZQRj6afiOadFOcTXN7CyO/6U8rsynps2fepS6C9vDc1Z
         u3QVzJPYDV+O55Q3ojemyixWCaQduTQ+IF7NPwXEXs8Wy7GxQcE6kPQ6C8qMvhZmpjQX
         dJYSTGZ+6Ur8zdKMGg6oN/D9BX7FwIrf2apP5q8iKH3Letnuve0zILpMv9B8RhMB6ATa
         jbyUObvWM161vxy8Ag7VfUJlnweQ3SWV4OAyiQX2sUaVAMu2JvjNQFPeGMnYKycb2Y1f
         lFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701795716; x=1702400516;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkPsD6IaRakopVoTTU50Xx50T6Qx9xHddJGp8xvjOrw=;
        b=VhIEWSDrzOnabrjYpAwYXBN0TxbJizA36eHYb7iyIcubyGjHQOFfm59Bj/vrAOF/C+
         KgnsPx2GvvuOKR9POdUeNRd9aQKe8u0eUdXJX0ibe2FKzhazmiC6JZAgWR3CH3JLRvhU
         /2w1GNkt1IES5j4aJInPY1AsVeDXyXYrxYNNcaPWNPJlivGEtPihCAAkB+HlFCCrjc9U
         z+3VpItFTDkWZa9CTT8tmHIJAeNx/jiKisgJZ6Jlx38DMfUNMIVBP/ZfOaKRGPSL0iXr
         N/uS7pvTKo7ZH3P6uLXZRZ1jBoIhbIsgT+drTq0woUlYuoR6sUxaWc5TUfzwje6GvxvZ
         i3Mg==
X-Gm-Message-State: AOJu0Yxb5hAt5d0zURr/jdzLhDUW4VyLJhc7DyEoTBfQJgWRtcVEcndC
	XXRqDr5eXcjxHPvA3oZf+ABL2aEXy9Q=
X-Google-Smtp-Source: AGHT+IHmDhuIsjfcQmy7VYuXKwZxItopgGe+fzBXNiyyxQdIgOOkTRR0XSTmLyMwSBUEyY9ZDpRDiw==
X-Received: by 2002:a17:902:c283:b0:1cf:b413:8baa with SMTP id i3-20020a170902c28300b001cfb4138baamr2039195pld.25.1701795716040;
        Tue, 05 Dec 2023 09:01:56 -0800 (PST)
Received: from [172.17.0.2] ([20.172.24.214])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001cc131c65besm10490090plg.168.2023.12.05.09.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 09:01:55 -0800 (PST)
Message-ID: <656f5783.170a0220.61e0a.dcea@mx.google.com>
Date: Tue, 05 Dec 2023 09:01:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4267264076040500892=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Avoid creating child socket if PA sync is terminating
In-Reply-To: <20231205161140.2855-2-iulia.tanasescu@nxp.com>
References: <20231205161140.2855-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4267264076040500892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807082

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      27.05 seconds
CheckAllWarning               PASS      29.91 seconds
CheckSparse                   PASS      35.22 seconds
CheckSmatch                   PASS      99.28 seconds
BuildKernel32                 PASS      26.59 seconds
TestRunnerSetup               PASS      419.94 seconds
TestRunner_l2cap-tester       PASS      22.85 seconds
TestRunner_iso-tester         PASS      47.07 seconds
TestRunner_bnep-tester        PASS      6.91 seconds
TestRunner_mgmt-tester        PASS      163.41 seconds
TestRunner_rfcomm-tester      PASS      10.87 seconds
TestRunner_sco-tester         PASS      14.35 seconds
TestRunner_ioctl-tester       PASS      13.59 seconds
TestRunner_mesh-tester        PASS      8.93 seconds
TestRunner_smp-tester         PASS      9.63 seconds
TestRunner_userchan-tester    PASS      7.26 seconds
IncrementalBuild              PASS      25.31 seconds



---
Regards,
Linux Bluetooth


--===============4267264076040500892==--
