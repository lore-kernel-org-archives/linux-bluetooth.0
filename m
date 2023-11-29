Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvxR6msV"
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC81BC1
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:35:37 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4644564375eso253020137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 00:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701246936; x=1701851736; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FqbP6eNslyUTHB9UWxMcoN5y7W3LYhIeu+4J5+l/x64=;
        b=bvxR6msVXxFkr6XcUuoZ++QNR5F7iekvZAdsB/kLcqZlOrIVJiM92dhOuVvZ1eGEDL
         Pi7/9lTeDe7Bnog7lAluTaODmFAdwOT378bJU0OEMd/qxEKipJoq/I3Y7uRoYpyzMPZ8
         Gcnh4tBvb7FKdQmnSPV5pUrkqcx2N3328A5ta35OgOe/O94I0JVHUBZ7RcG3yszMi1UX
         Z6cnXyZhlu5ZYW14IvoeZzd5mk5VG7I4ST7+dF9TfPBB/87XsC7nKSH2Zdc4fSvtiH8i
         GdgZT66NGxzxqXes1MetWGy9MKkzblE6a3oq0S+LDVm1eT+ZdzEUWgz7xHmGjptYvdgO
         zaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701246936; x=1701851736;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqbP6eNslyUTHB9UWxMcoN5y7W3LYhIeu+4J5+l/x64=;
        b=r6CdJy6FzqSPi1ompfGukQbSs61VbSgk1ETxFual8ts7TVvNIvZbBTZE8feZhUi63I
         s/zA0gYbj9ZQss7EjP1oCMhPCvH2g7a3NjImqijh/KROOZ2Yv0W4BUEqZkTvDHnxf0Sr
         nn1/TMyV52ixfQtTdoZjZk2qVHYraVpkcGeVDCiU6njq00sALRE+Xwx8Rtnvgb8fvQCn
         dUywaeW8Dc/jiuLoxYDJthE+zYJfhOhyPhg7Ol92FTL/ib1FfIXkzTUQ7MKzYL/amvG4
         JbuoecpYK3mJN/4Qy/qmQRK5z1SfcjCQiif7USoIq5tRyV3Ns6rTiC3Wf6mM11c/w5Xa
         2h1g==
X-Gm-Message-State: AOJu0YwcD0XDW2lJieWY1Pl/uflH6hhLYOByCXaqFAePB3+tSFwWj5bg
	gXhiRMiSNYJcCcf56R15yVd+qkQCTrA=
X-Google-Smtp-Source: AGHT+IHKMJtGUyCkiU4rriRhVds+xVp4/IxUVSo0rt2+SmpRuMkPUMJ7ZaxalE4kbuBeEqaDw4hNPg==
X-Received: by 2002:a05:6102:3bc8:b0:464:4484:1de3 with SMTP id a8-20020a0561023bc800b0046444841de3mr2428824vsv.4.1701246936123;
        Wed, 29 Nov 2023 00:35:36 -0800 (PST)
Received: from [172.17.0.2] ([40.71.163.67])
        by smtp.gmail.com with ESMTPSA id e12-20020a05620a12cc00b0077dca8ed9a4sm536513qkl.133.2023.11.29.00.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:35:36 -0800 (PST)
Message-ID: <6566f7d8.050a0220.4655b.1c60@mx.google.com>
Date: Wed, 29 Nov 2023 00:35:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2379337752371647523=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: Bluetooth: Support SCO offload for QCA2066
In-Reply-To: <1701245255-12409-2-git-send-email-quic_zijuhu@quicinc.com>
References: <1701245255-12409-2-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2379337752371647523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=805140

---Test result---

Test Summary:
CheckPatch                    PASS      1.33 seconds
GitLint                       FAIL      0.89 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      27.02 seconds
CheckAllWarning               PASS      29.61 seconds
CheckSparse                   PASS      34.81 seconds
CheckSmatch                   PASS      97.72 seconds
BuildKernel32                 PASS      26.45 seconds
TestRunnerSetup               PASS      410.97 seconds
TestRunner_l2cap-tester       PASS      22.93 seconds
TestRunner_iso-tester         PASS      48.04 seconds
TestRunner_bnep-tester        PASS      6.91 seconds
TestRunner_mgmt-tester        PASS      166.21 seconds
TestRunner_rfcomm-tester      PASS      14.04 seconds
TestRunner_sco-tester         PASS      14.48 seconds
TestRunner_ioctl-tester       PASS      12.16 seconds
TestRunner_mesh-tester        PASS      8.81 seconds
TestRunner_smp-tester         PASS      9.77 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PASS      30.02 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (89>80): "[v2,1/2] Bluetooth: hci_conn: Check non NULL before calling hdev->get_codec_config_data()"


---
Regards,
Linux Bluetooth


--===============2379337752371647523==--
