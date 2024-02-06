Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2612F382
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224622; cv=none; b=EjbbOg3RUtE4TOvaklkJpKGbj/dJBhM/LkgWhLMVwJCZkYjXWLNTlGCPf4EqS0OJy2W+ODZgWFJhBaPzTwLjmtRGkKq1PqlGd96BmxdRW5P0l+nlBQNn/YR2XLXgOIyeelKZWOfPPEewggSm96g4NPcWmb2T9dvrHw4wIrFp1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224622; c=relaxed/simple;
	bh=2REMK1/RY9OarpmMYAGpMal0CsmOPusXGOMonVAyaxo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z120r+oOmuLEJMk+VPaJCoOHtobaXXG0KLQ0cURKzukOi76vRJ1x2YEMUyZt4Na0vwvqzxrkAXu2BpTQ/80tVBQmk/KB/SbLqrVm5dPWPIznGNFqBFQomLr0UVUSY1Zg8ixYNEIDV3/mZyNbmGxqs2VM4X3J568qGL9gkcuUxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/TtjX/i; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/TtjX/i"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso4554215a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 05:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707224620; x=1707829420; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wC/u5psFI7Wk8RDWCBxWVgkYVxceebQtBFfqoDhdbFY=;
        b=K/TtjX/i1bSuKpk8ifnlLs6oKskY4Ug8494x6MBIgjW75HKW0fzsRyg2qaM/+1Gk1Z
         Qh7BFMlaQofK8MBkhC663SGa+iiXnGqqLTv2/33/tzono9ynSR/u7VQEVGvh232LemPq
         SpcvNBCBuQ91br6XtdrjFN1xdvI2cBuKSoUk7F8SHaPC9iFza83Ck+7T94rJTjKCBbYt
         73rXIwTHSibLjMn3dPxOTxR1qOOHUacL7QwC5f5FkArNA9xjuoDV0pd/BiWNUhkHfZMz
         sYoe8AD0NJ/dbjufTBYjWLhl9hMUOSknkl4fIj7W482jAWLPPvBxTrTohnFWsJ1KuiYH
         tViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224620; x=1707829420;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wC/u5psFI7Wk8RDWCBxWVgkYVxceebQtBFfqoDhdbFY=;
        b=oxJAlJ89l4TbrzR3pb7Az+1wAeoAamYXCZmwWDBMDrB8eIYV1h14IutLHyjRKSLm1H
         dDV3EQqVpsinwkOOkVqGDkhSTiVKct0CEuN5UsmeYZp3xbwHboJWLLuNtdClWrIrYD4s
         FJ9tZ5ZiEuOPs68ztYqEbFVzyPgHRluirQfMKJ1QVDsJIbEgmIifPF0ziXwQNGKfZavU
         Tv574IVicW81qeQmOx8B3razjEscaGq780IChv9BIgBNWGMY1PEu9NwH0+bvN3TFJHKd
         HYnGBgaTTDjd0VTzef0OGPpoQDf9giGi3IT/C0LDDvvvNoAl1lc38xR3xlO2qhNRziba
         X20g==
X-Gm-Message-State: AOJu0Yz5lvQeC2OKZlMDnA2LXpf/tVbq63rLSYodtZ1nT4PrT3qpUx1E
	nr4Qcs/0cnv+crMP6wEdq3g5kxl1ToL7qY3YYCyrsdXEthQxP+8gLhaXdtGq
X-Google-Smtp-Source: AGHT+IEejRPeSsmuTHvDeHWwjMr0vfSWSknom1sWzvMdjg7G95XVykRNtVTqD8gbUw1OJxZhTQCfyA==
X-Received: by 2002:a17:90a:cc0a:b0:296:4f7f:c3ca with SMTP id b10-20020a17090acc0a00b002964f7fc3camr2448373pju.21.1707224619417;
        Tue, 06 Feb 2024 05:03:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWShx3RtXdEhjVViCXmekv4iww6BLmwv2//97Eo4aMwMWfxu3g3hGG/biQh9MvffFrbTN64dATkZIyLstNPmg==
Received: from [172.17.0.2] ([20.172.5.47])
        by smtp.gmail.com with ESMTPSA id sb14-20020a17090b50ce00b0029082d10fc4sm1525206pjb.39.2024.02.06.05.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:03:38 -0800 (PST)
Message-ID: <65c22e2a.170a0220.1f1d8.3631@mx.google.com>
Date: Tue, 06 Feb 2024 05:03:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1569687541368704732=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Adjust tests for sequential conn establishing
In-Reply-To: <20240206112253.76446-2-verdre@v0yd.nl>
References: <20240206112253.76446-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1569687541368704732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823536

---Test result---

Test Summary:
CheckPatch                    FAIL      1.54 seconds
GitLint                       PASS      0.90 seconds
BuildEll                      PASS      23.89 seconds
BluezMake                     PASS      695.39 seconds
MakeCheck                     PASS      11.91 seconds
MakeDistcheck                 PASS      162.67 seconds
CheckValgrind                 PASS      226.45 seconds
CheckSmatch                   WARNING   331.05 seconds
bluezmakeextell               PASS      108.44 seconds
IncrementalBuild              PASS      2662.64 seconds
ScanBuild                     WARNING   988.49 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,3/4] emulator/btdev: Send page timeout after 5.12 secs delay
WARNING:LONG_LINE_COMMENT: line length of 81 exceeds 80 columns
#106: FILE: emulator/btdev.c:1328:
+		/* Send page timeout after 5.12 seconds to emulate real paging */

/github/workspace/src/src/13547070.patch total: 0 errors, 1 warnings, 44 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13547070.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,4/4] mgmt-tester: Add a test for connecting sequentially
WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#128: FILE: tools/mgmt-tester.c:12822:
+		if (pd_data->n_conn_failed_evts != pd_data->n_create_conn_cmds - 1) {

WARNING:LONG_LINE_COMMENT: line length of 93 exceeds 80 columns
#146: FILE: tools/mgmt-tester.c:12840:
+		0x31, 0xAB, 0xCD, 0x32, 0x34, 0x73, /* random bdaddr so we fail to connect */

/github/workspace/src/src/13547071.patch total: 0 errors, 2 warnings, 117 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13547071.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:420:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1084:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1365:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1487:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============1569687541368704732==--
