Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579285958
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548319; cv=none; b=glJENRJaURpbEdw7a+5iswCgDQv2lsdl7O47xOaH6Wzx3mafX96Hziq7weN1C7pM03Herv/LtRSesuFt6vxzZ7fRzQhRokCD4C5tGFooVO859sorJ5CKpPpCTV2UabwbFEfpEpGBQVIUTxgKP68wgBCQ6KP5vhqvz0FSQDMzIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548319; c=relaxed/simple;
	bh=EjUlc1K9gzS4JLOvABSTeP9L3uoNoLd5SUD1vsYiCrA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T37ULMquzEge6fo8Ck1vwFA98NpDnxtbnKAVjFh6bzQSc2les8V3L7JMhPGmYnt+UrIAzQiV//eNWKq/ZfdUCulIknlEHafoEL8p/DhqObpeaKJFbCQiQZP5f9zhGyYCID2lnj+dbRWGXt1UU2GIuapI6UGdMZq4ZYqZrkYgwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyW1sWH+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyW1sWH+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9d0671dfaso3980556b6e.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 03:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716548317; x=1717153117; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y724jEFNp1RRsSJg3XmKDRs1mKho0BAxGV7bqh7Awis=;
        b=EyW1sWH+51gKR/T/SciHV9h+yMzb9G5CzfV6KUL4wI2sBS73FssAccwT0Ca+wVutNA
         WB6E8oo504+HrSsAFSzttYj0QYb0GH4xxAZwGRvYaDqaezM+w5SOCNYYAx9AwN//4mcA
         O6kENkjsfK92wPZZ2Me/S3GUlOD5cNyIYdU84i8Arqq12yNjA7auA40JtRx4lu8LfuDa
         vOfc/x8h4Gm3rQzlks2rlku1RKY9qOOWfc+9o9m9YYFl6iNCgkkW+1oWRILI7iv+8fqr
         JUlrZkcarlBfnImqICCqOXTNim4QuvNPeKurhX4zqbpTKujEYR/i04WCs7nIPdOzE2NY
         zygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716548317; x=1717153117;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y724jEFNp1RRsSJg3XmKDRs1mKho0BAxGV7bqh7Awis=;
        b=aJZILD9ITHqVftN2L58a8pSso/Kgv7G6v8teS0vxrZ2przVQzFwo+4KMVH0BQaVVFn
         yFBNcWc6GW0ZW9Kw7n3Zf7XBGYRmjB3t61KBpnZbRurW1hGh/Dfxmbtjwbp/jNH9Eqg2
         sxJrFpMBIvl+JdeS1WNEbnVgYdCopgpHkdTiBiYMRpx3aTgCWtL5EpXTCCF0ng/CDy8K
         2MRmdSn2uL9TUywi/PT9dCmZlBpK2oqHa4CLvBgfXdJes8xN37I3tYxLslYXqdpO/uOT
         17jNOYQ8EkApctTyN1cLufR9yscZobRVE29nkVqEyWhln5zseOcUMCIikgjgA9jPtIls
         mMIg==
X-Gm-Message-State: AOJu0YyFy0MIFaSa5wu7pXhCz/1U9qlJj0kSK8RTC2A1NRq5zTiP9DcV
	YXn+cD9kSJ019hpUNM1lok61ux5gGxzPuJ3DBv7VH8mSuvXLCKIduLsq1A==
X-Google-Smtp-Source: AGHT+IFHObUJJ1gJkfPx7juj96zZZyae+aZeArYd6/0a2xn3L/tg3op4+2p2988MjN18/R0mZnQdCw==
X-Received: by 2002:a05:6808:df1:b0:3c9:70bf:6824 with SMTP id 5614622812f47-3d1a538ed9dmr1878921b6e.7.1716548317213;
        Fri, 24 May 2024 03:58:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.232.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17fb02esm6753151cf.47.2024.05.24.03.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:58:37 -0700 (PDT)
Message-ID: <665072dd.050a0220.91a75.1caf@mx.google.com>
Date: Fri, 24 May 2024 03:58:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5146820119931924067=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: Bluetooth: MGMT: Uninitialized variable in load_conn_param()
In-Reply-To: <819ed9b8-8790-4d15-b2a0-20929328d582@moroto.mountain>
References: <819ed9b8-8790-4d15-b2a0-20929328d582@moroto.mountain>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5146820119931924067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855655

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.45 seconds
CheckAllWarning               PASS      32.97 seconds
CheckSparse                   PASS      39.63 seconds
CheckSmatch                   FAIL      37.07 seconds
BuildKernel32                 PASS      31.80 seconds
TestRunnerSetup               PASS      531.78 seconds
TestRunner_l2cap-tester       PASS      20.30 seconds
TestRunner_iso-tester         FAIL      30.59 seconds
TestRunner_bnep-tester        PASS      4.82 seconds
TestRunner_mgmt-tester        PASS      109.62 seconds
TestRunner_rfcomm-tester      PASS      7.37 seconds
TestRunner_sco-tester         PASS      15.00 seconds
TestRunner_ioctl-tester       PASS      7.82 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PASS      27.90 seconds

Details
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.222 seconds


---
Regards,
Linux Bluetooth


--===============5146820119931924067==--
