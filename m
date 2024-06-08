Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40641B966
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Jun 2024 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717885873; cv=none; b=MB6hKEF2xZP3zYpBnXpNN6sUMs9esQ+Ztqjqc3R9jJA8QVR/czeSYfReqGtbxVcf5zuQpqtEVdecWiQwvV15Ky3nQ40yWf7TDQ4LzDawYHAkZLaGI0BdqOPL/qjLhs4iTMCtDJWrMaMsfUMrVAaiXN72gJU9SV0i1vjpFg+8RpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717885873; c=relaxed/simple;
	bh=LfmeiH7ICyGcaHabTOg+8ZliUgnmeUq4K2hwwVvNcg0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YxpdVUlfRH/ts/3ZCoI+alRary/iu1MPqMvylRwcPhKHXnMZv02i2jT+apmtrnsdvGL1w2S+F/Oa48EG3KRiKfEiZWuJ8/8GRP3+Um1cPA/7oeJB6f88AhTOYmc+n9yz7P1+osJuS3xHEFNLxXxxBKgkw6v6wQobCbLBcM+Zd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi0c7dC9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi0c7dC9"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7951e96ee0dso217534085a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Jun 2024 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717885870; x=1718490670; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IF+00d7E4DCSip0XjwlEfHKvqFeb6EspeM1WSDgqNsc=;
        b=Mi0c7dC9cn/6boHRrHfUkioAwH4QuChHuxyd/ajQOnVrVrdGBB0WayQ7VwKJyowtFP
         CDOMTZvFDJpL5Lry2DRJDGJjZHmFvStxO0cPkxpsxCidNyLkvwZ3PMLFxADZDnNQJbPc
         7hi8HtIrmJ0k2UWFz23iBlxr0Nd/rsQjcrcvM1H7GJO6nMkxySL7RGoNKotAsUDUWnBi
         YIMWk88AAOArfT09Og+pvhk49dZOS1q7HACd+E/sY/t5wm5VhyvzIeSoVwHjQQD0lBXj
         hqbRpuBpubNL5II9o4gbq7faMU0qSnumBDATgVkwl/iCRdkkRfziFAUqEPMCbtmr7lvs
         /aXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717885870; x=1718490670;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IF+00d7E4DCSip0XjwlEfHKvqFeb6EspeM1WSDgqNsc=;
        b=CZwkADWY51JYU09Ku2XgHhkH11RTTxCJEUZpPtW7zGs4M6uE87mUN729zHSfVyerku
         hBfBlrqtuiKXT4acwLP4wpqtUsnC1w2TyI24xmOZ195EVze9m7B5747ruh7J+idaUNXD
         DJpWO7fR1kMGud8ji0v11y5CtWyNZooTy19/eatDvfnf4Ua8ElMzbJfddeXRPk3m6yF+
         n4oAYj1AOkwkbgm2D8S4Jw1CpvKAI5BkMjjPH4Ex6+VzYxoWkogBhghYD5qZbru9rpOv
         44Sww/E8jtMZETOD3eG2DoX1Aka27O0xABZM3EwCYfFyTBwYH5dam97DtxpT1T22pQPk
         Je5A==
X-Gm-Message-State: AOJu0YxMGP7elcb93kW/dz7/cK7NLldalb3gFkRiFBYXmu0XzEdoNBFI
	m9UuynmYMVNDbDElHPUYsOSS5w0N3pIzLamKyGqVL8DIxSyGHQFdkH22KA==
X-Google-Smtp-Source: AGHT+IEbFzYUgb+vnRczCAnYrWSKOx9uHnFXx8hHzu2Vr4q5L38zNyYoSF1C/NJ9fgeL9AKXFCdn1A==
X-Received: by 2002:a05:620a:2705:b0:795:2891:12df with SMTP id af79cd13be357-7953c4aadaemr643328485a.47.1717885870293;
        Sat, 08 Jun 2024 15:31:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.159])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795602e471bsm2550385a.106.2024.06.08.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 15:31:10 -0700 (PDT)
Message-ID: <6664dbae.050a0220.89110.01e5@mx.google.com>
Date: Sat, 08 Jun 2024 15:31:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0633178792067302827=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: fix connection setup in l2cap_connect
In-Reply-To: <de9169c3e607696a9430f5beb182c914c136edcf.1717883849.git.pav@iki.fi>
References: <de9169c3e607696a9430f5beb182c914c136edcf.1717883849.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0633178792067302827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=860197

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.74 seconds
CheckAllWarning               PASS      32.41 seconds
CheckSparse                   PASS      37.63 seconds
CheckSmatch                   FAIL      34.89 seconds
BuildKernel32                 PASS      28.75 seconds
TestRunnerSetup               PASS      521.46 seconds
TestRunner_l2cap-tester       PASS      18.29 seconds
TestRunner_iso-tester         FAIL      33.17 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        PASS      111.25 seconds
TestRunner_rfcomm-tester      PASS      7.33 seconds
TestRunner_sco-tester         PASS      14.90 seconds
TestRunner_ioctl-tester       PASS      7.75 seconds
TestRunner_mesh-tester        PASS      5.83 seconds
TestRunner_smp-tester         PASS      6.81 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PASS      27.66 seconds

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
ISO Connect2 Suspend - Success                       Failed       4.232 seconds


---
Regards,
Linux Bluetooth


--===============0633178792067302827==--
