Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF2EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 00:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFUAVg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUAVf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 20:21:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3D1A8
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 17:21:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666ecf9a081so3897292b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687306894; x=1689898894;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LrOQaZGVBuuZ7Fw6iqNmzG96hEHVj1JekXwhKRNhYYQ=;
        b=n2JKxMDPyerx2vfpv6Wo6s1UBhSOLYCIZFbeKrK36JTdr6EBUYuy3hdRTj1EQ5O8ky
         0DiZbWRCNA0S48PCvldI/VQ3Skhf+iUTgMkcViWJ7bj4dzXyn75TkaG62zzvCrBeao4t
         urrUfpXcYA0S6f8H0UzWLcJ26FHbKwE4QUwd2I8aJ0L2H+Q4TSQeh5S8WnyusjLHNjp2
         SSEXmyz/HdIotESQPzzdgFizF5gS1Ukd/BgmjIaVN4EW1NXVS4Y+ZOp+9GzubzWFBOC9
         FzRE2Sw38LGn4usCna7jozC+l1h4Lqohgz5jHfyDChIPPhS2AHbPjcyPXKxBy7DS0CiF
         XUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687306894; x=1689898894;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrOQaZGVBuuZ7Fw6iqNmzG96hEHVj1JekXwhKRNhYYQ=;
        b=XM4ZNgug9nyGj0RXPj4vQMkHUun+ORWvVHq68kc1dirg76xMScIvP5EtcLbf8ckU+q
         mdcRqOJMWbPplv2bVPC9cBreb4vjhqLuP9JiUWAuiXazx0TJyj9NCsws1bMYE3Rnluzj
         4GKA6ElGLQr8KgYycwDX/pFzoD3nLVhy72FMjiRHkxIgniKE7w503qFofd/ElskDv/5W
         WoYHTbA8S63iUJQeG1IphB9/oBDVX22ADkyrws6WIo+OPr0gywhwVuciSzwo+lj0kcdT
         0b/e9boe4cMOtE9ZwENWnw67tMT9AgDTe61NLUSadHenquidLNeN+XpzN6bn+2M5akAz
         hNxQ==
X-Gm-Message-State: AC+VfDwMAY7Xf47lTDMY5KN14JViA+CLUbfgx9lWrIO83/tOJux9Lb5T
        0mUEJS7lHhFs6EO1rnyr+aATU/outEE=
X-Google-Smtp-Source: ACHHUZ4MgNfoot95J3tSVUKjRkg7IPJPFKDtHvN0MFp4CAdY+skXQeWuR1mDJ2zGzWaY6H76tAX46g==
X-Received: by 2002:a05:6a20:3d02:b0:121:f863:67f9 with SMTP id y2-20020a056a203d0200b00121f86367f9mr8053537pzi.18.1687306894053;
        Tue, 20 Jun 2023 17:21:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.134.182])
        by smtp.gmail.com with ESMTPSA id c25-20020a62e819000000b00666d7ef2310sm1853902pfi.94.2023.06.20.17.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:21:33 -0700 (PDT)
Message-ID: <6492428d.620a0220.ffbd4.4a20@mx.google.com>
Date:   Tue, 20 Jun 2023 17:21:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9002224349431630374=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor: Fix decoding of HCI CIS Established Event
In-Reply-To: <20230620224354.729781-1-luiz.dentz@gmail.com>
References: <20230620224354.729781-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9002224349431630374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758879

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.52 seconds
BuildEll                      PASS      26.96 seconds
BluezMake                     PASS      786.35 seconds
MakeCheck                     PASS      11.94 seconds
MakeDistcheck                 PASS      156.16 seconds
CheckValgrind                 PASS      249.75 seconds
CheckSmatch                   WARNING   337.65 seconds
bluezmakeextell               PASS      102.01 seconds
IncrementalBuild              PASS      1316.00 seconds
ScanBuild                     PASS      1018.60 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structuresemulator/btdev.c:417:29: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============9002224349431630374==--
