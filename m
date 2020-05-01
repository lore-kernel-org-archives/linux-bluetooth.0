Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E4C4724C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 18:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593A82173E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 18:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzKZRuqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgEASgf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729721AbgEASge (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 14:36:34 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3ABC061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 11:36:33 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z90so8592223qtd.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:in-reply-to:references;
        bh=lLRYltO7kKO/XJPux1ntRSx5+cTGp9CaGE/ta4nazj8=;
        b=YzKZRuqH5zFQlnPiG5qvA9QiXgyz78P07eWh0tVddClA8KMsqqptq/VlU98i31jgQm
         1Y8yh0ruUkxnQh0I9sBB+fKYDOqXRj0Og+bgiN5DJgQfa68k/6N+PonV26je13Hdeqce
         jjcBl0TI0g5ypNQCvhPTcqRAGv1sVNqd1lyVQtJH9MoXAySKcHTMwl2bSE2WWyy3oORP
         1Auon5Aru26qS6ujaQ/XjKhWVBHLUr0eAL9NoRCLT8YLtzt5f3zbd3SbGA4TUfusQxLt
         ffb+HMp5h41RnA0sHhGuXRDWAfggCMHYRnbhnKPEBQSlnnLuLKNOqVzqxtpMgN0KIr8t
         Llbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :in-reply-to:references;
        bh=lLRYltO7kKO/XJPux1ntRSx5+cTGp9CaGE/ta4nazj8=;
        b=rtADQgY98CuZgaTRsUWJbmNTKSY+cRIS9+CwFFJN2B9UmuaXpFWTse3pbYwV9/5ySW
         rwokHZPQtK6E/GyinSeiAWUQqDTuEM9yegAT9/4lRN2thvDwXDT46MvP3SbfASzDvExN
         Dw5d8GEYsRuNzNpEwPYCTK5Gq3Ksc0ksEIxAaHN6KqR03T3q0704DeTy3k/C5kDn/MtD
         SBxRAtIoQzNfHV/I14FhRfBRHcEImUPO2P2RaAfCivisYvuXbodFLB4uYPdGNnFluNLH
         EwrwzVogHkaEllWi2E2PzuMGrWymSD3YMkbSst3bk7jJk+y4Lp614/aqBgmcnnJZHrVm
         xfeg==
X-Gm-Message-State: AGi0PubavW8sIp8CVEf5QFHZZrIDkcXyyjEiLxP7y68FYSvuUwIGLcXI
        CxLIDyWQe/JzodActbCeeQTHcqX8sc0=
X-Google-Smtp-Source: APiQypJpx2Z2ASnPDPU2OsDb5tljmxQcbPTkcKjuH6Y1D+D21QSyk1YRpVBG9aYgPjqP77rYS24SWw==
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr5381461qtp.338.1588358192244;
        Fri, 01 May 2020 11:36:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.68.185])
        by smtp.gmail.com with ESMTPSA id d26sm3243477qkk.69.2020.05.01.11.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 11:36:31 -0700 (PDT)
Message-ID: <5eac6c2f.1c69fb81.2a472.234d@mx.google.com>
Date:   Fri, 01 May 2020 11:36:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7689889905021841500=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: RE: doc: Add commands and event for experimental feature configuration
In-Reply-To: <20200501180711.115409-1-marcel@holtmann.org>
References: <20200501180711.115409-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7689889905021841500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.


Test Result:
Checkpatch Failed

Patch Title:
doc: Add commands and event for experimental feature configuration

Output:
WARNING:TYPO_SPELLING: 'Paramters' may be misspelled - perhaps 'Parameters'?
#56: FILE: doc/mgmt-api.txt:3181:
+	Command Paramters:	UUID (16 Octets)

- total: 0 errors, 1 warnings, 104 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



For more details about BlueZ coding style guide, please find it
in doc/coding-style.txt

---
Regards,
Linux Bluetooth

--===============7689889905021841500==--
