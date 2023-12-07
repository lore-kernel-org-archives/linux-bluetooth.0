Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwNsYWNE"
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21FFD53
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 01:33:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6ce6caedce6so333371b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 01:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701941588; x=1702546388; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EAEi3yoLeJTHmPMIVvJeoXPUzp7nk7pomoDmo6VrgTM=;
        b=CwNsYWNEf2d23bTv5viT1qfTrWieCGJgxAtVrmbtvfFB3on/xWOTlMyf9kaWoFURGX
         JqLFhYZlBJcJgP8Wdvn45HPjGqDBVjUjiKV6JtOBLjHdggjCdj18Fh8EJlELdrFratCj
         AH8ui5pVqiMDBSSc8pkMabezz9feH8ygd2Jb1/MpmwPHCmO+hNCv7mIXK2rrAoUAl3od
         yV7/Lt+PDXFJpqLz98TlIm6Tf3wVfY1UMXgLpNp50IF7fdWU2bzd6B2YS7WUaidphYYN
         l7qBorC60jYCRyViGvONEo63sgHfYvOkh726tB4jLhWu44qvd81DHiKessVGtRJCs3Gg
         SRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701941588; x=1702546388;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAEi3yoLeJTHmPMIVvJeoXPUzp7nk7pomoDmo6VrgTM=;
        b=vzsG+VLyScvv7DigVYveTksupfe7+gcxsOxzye6QW6njJvzwJ7eWmYXvw6raX3JLlW
         JdgSPcKP0fI58bEqGn6vyIY3O1Z5CMSU4foI7HLOcVUdgIRQI8sSvDIFAa5myB69hlk1
         uxUKKeURcxwCZ2EwrCoDMycpNmM8k2uJo33cnDDuQX8gMx/OZKtgfrQOulMHLkWRf0xm
         bFXZTRQal8l0o27IPkVFUmlobYQlRUyLhGfyveNHnYzMWFZOHEbO2LHk1XtCY+4SPDye
         8LayZFDuh5832fCsRnfIbf0e/vCXYUknHUENxefCbtX18dUSht0up1LUB/6/z3DE1FNx
         JdpA==
X-Gm-Message-State: AOJu0YwCKF4Xu+MBjkhdFVRsi0HoLQn+2RaULPrMZesn2yEX6V6RsV88
	rA/oCKHPPJ+akrLGQ+76FvM0M4PXBRp6rQ==
X-Google-Smtp-Source: AGHT+IEvrTVYwEppraalxuJhA9IDJilpp5NC4g/CqrW04O3pUNeOlfeSD7/mfunswQ+or6+MFOWpAA==
X-Received: by 2002:a05:6a00:9387:b0:6ce:53f6:1eee with SMTP id ka7-20020a056a00938700b006ce53f61eeemr2078783pfb.31.1701941587896;
        Thu, 07 Dec 2023 01:33:07 -0800 (PST)
Received: from [172.17.0.2] ([20.172.28.128])
        by smtp.gmail.com with ESMTPSA id du20-20020a056a002b5400b006cdda10bdafsm851983pfb.183.2023.12.07.01.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:33:07 -0800 (PST)
Message-ID: <65719153.050a0220.7ccbe.1e28@mx.google.com>
Date: Thu, 07 Dec 2023 01:33:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6087882715523249690=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: Bluetooth: power-on QCA6390 correctly
In-Reply-To: <20231207091202.19231-2-brgl@bgdev.pl>
References: <20231207091202.19231-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6087882715523249690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=807781

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 FAIL      0.53 seconds
BuildKernel                   PASS      27.14 seconds
CheckAllWarning               PASS      30.14 seconds
CheckSparse                   PASS      38.64 seconds
CheckSmatch                   PASS      97.95 seconds
BuildKernel32                 PASS      26.25 seconds
TestRunnerSetup               PASS      414.38 seconds
TestRunner_l2cap-tester       PASS      23.75 seconds
TestRunner_iso-tester         PASS      52.14 seconds
TestRunner_bnep-tester        PASS      7.04 seconds
TestRunner_mgmt-tester        PASS      159.16 seconds
TestRunner_rfcomm-tester      PASS      11.00 seconds
TestRunner_sco-tester         PASS      14.60 seconds
TestRunner_ioctl-tester       PASS      12.05 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      9.85 seconds
TestRunner_userchan-tester    PASS      7.60 seconds
IncrementalBuild              PASS      34.10 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6087882715523249690==--
