Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830637147
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660377; cv=none; b=sH/3dhDmpodTQdLLU8rBPagkySV62gcrawa6keoTNEnGIN4cKzEjWVL3v33q0cyXx1vaZro8yrcyl0wmiKdGmWIBa3tcfXNQqWyDIHy7YqUX40JJXiaMrFjXZJ//rMIuTSKr9kdv4trnGJo8Eb0UC1w6r6lSaxTDjSZUtPczBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660377; c=relaxed/simple;
	bh=fqEhDpKhmF5Ewu+BjtHk8rKdRfS3FcG1uHiQ2ysSRH4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a7p6ElCj1qja3WNn1A2limd1oU4YIirq87xLrh7mxU5wTZBSEjRN943pldx3iXy9nTgO4GOgg5+znvo/sEiMAqnMgICQeEypocVHk5P7ODvVq7jlzodPk+AOeAS92HqkEr8ZoVweDVtabg2LNhpx6hYTn3Kck6utXSjSyHkiXuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWDvn+o6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWDvn+o6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ece8991654so7258893b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714660375; x=1715265175; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=93bMVuL6mpb54T4Ou+um9c0gtuFhV2NkeLP6h7+14CA=;
        b=MWDvn+o6R5WdLS2wZH0ZisYdtEKQCJ/hzWH5jySRa7QF2M4feupato0TDbaF2D+JDW
         BDuQCqY0UPzEfKGvtf8gcVeIAsIipVaINmqY7qkOsef/ashiVwZo0TxRf6ZGBEYHufVF
         yaqYU6um1bVoEXWhWpyDT8DbFcNxOIbimJVCbFi4Qd4a504B0zRTPe8oAiU9hOlDXV73
         m7u/YN0DJIP0wUtixFplWjRMCxNSpN8dxqX0J+ndWi052/W04JV45yUI7ATwB1OPXta3
         30zX88RifUPgs31mTboW85cHSOvrbZlO1sMHPkt/gDZ3sUgt4J9Yb/qil0M01dNC44Rn
         Ef3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714660375; x=1715265175;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93bMVuL6mpb54T4Ou+um9c0gtuFhV2NkeLP6h7+14CA=;
        b=DfF2ZSY+91kQ8O0iJEovus6Hd2hpr10mEu5ZyKjQVv8ElPV492e0OL2QJxige4UqoJ
         NEDnHfRrurwDkE85nR7eTR9HOhVn+id+AM4wwiK0lhaA0V2Rq04hYjlfEkbakkRSnw3J
         QN8Tg4sxjFfQuBOBT7aDUZpH2UkmEEX8qQCMi4fILYqhExVo39CjTlHNF/KyIA9t8zVA
         URsOJbygAnmAehi9Wk+kw4A2vwR0/NMwAWJ7BCwFDXSvEQyGcnuIplPvYPpKAmuOsYEv
         0JONNkg7rmesYXpXBgS3JcYv+dDnbVtj7Ao8xBaTWYIjoMEV9bT6H1VPDGgK/v0v5Qvr
         ZHzg==
X-Gm-Message-State: AOJu0Yy4CqxoFhILEHNT+oHeWEaClLSUU+x2eJft/NMgStSZjmQfDOcq
	8nfYZ4AmWkQNKnNVjvoVui7EzsOwvzaS1OAXdSGijeYPRY3AYZmzFMvywA==
X-Google-Smtp-Source: AGHT+IFiTralGpl/ZJjQJb34w+VXpiqRH1K3DKlY4LpnWS4tx6w/RhaWWZras++r89ejKmD7GPLu+g==
X-Received: by 2002:a05:6a00:2e1d:b0:6ea:9252:435 with SMTP id fc29-20020a056a002e1d00b006ea92520435mr2852044pfb.30.1714660374954;
        Thu, 02 May 2024 07:32:54 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.28.69])
        by smtp.gmail.com with ESMTPSA id c26-20020aa781da000000b006eadc87233dsm1271913pfn.165.2024.05.02.07.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 07:32:54 -0700 (PDT)
Message-ID: <6633a416.a70a0220.e7a01.3244@mx.google.com>
Date: Thu, 02 May 2024 07:32:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4716576393805493406=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot
In-Reply-To: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4716576393805493406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=849912

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.19 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      30.95 seconds
CheckAllWarning               PASS      34.14 seconds
CheckSparse                   PASS      43.14 seconds
CheckSmatch                   FAIL      37.86 seconds
BuildKernel32                 PASS      29.85 seconds
TestRunnerSetup               PASS      546.06 seconds
TestRunner_l2cap-tester       PASS      18.60 seconds
TestRunner_iso-tester         PASS      31.83 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      113.61 seconds
TestRunner_rfcomm-tester      PASS      7.43 seconds
TestRunner_sco-tester         PASS      15.15 seconds
TestRunner_ioctl-tester       PASS      7.94 seconds
TestRunner_mesh-tester        PASS      5.89 seconds
TestRunner_smp-tester         PASS      6.74 seconds
TestRunner_userchan-tester    PASS      4.87 seconds
IncrementalBuild              PASS      28.61 seconds

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
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============4716576393805493406==--
