Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B0CC001DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 14:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjHEOAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEOAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Aug 2023 10:00:21 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E225FD7
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Aug 2023 07:00:16 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-63d23473ed5so17946576d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Aug 2023 07:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691244016; x=1691848816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8TY7jpRH5KAxOpgiRWStjPnmPd4lBqipx5T8kiwEkmY=;
        b=oUqW6zmHs7uJP6P/C8xBVi6KbeEWa7NR4Jpz/JMzX/5UyB+yK7LmyDmUbFK2RnFHlB
         l1KmpbiftROQZusVuIu2tpgsWhpes6mRziTYh8C2EvK2MC5h0kBB94S4d2NxLqVggM1o
         WcVQr3ODB38laEiPVkY/9Kvu14Qr7y/jsbmqZDHdl8Ac1J1fpkCkKpRr2viaQmvQr/Gb
         YizhuBpx/rN/PzDXa/qZrXUjWiPDN99XYZm5EplgsPtqco78Qpof04xMNO2DfsCep929
         kwr3vDGsrIfDsF6wWrKpO6qEhXlqWaxKnMGOZ8m23UZQUcabFsuTq41tohKKWyEbm2sU
         z9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691244016; x=1691848816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TY7jpRH5KAxOpgiRWStjPnmPd4lBqipx5T8kiwEkmY=;
        b=gY8x0Vz0QWMVp5HYmlwIqUJvPRpzoz3fwYTpERqJGOFBPdae0/D4s/FoTuFuq7QPzv
         pGYLNDVXOwubbk8zncw7ERRrz1F0FXM7lcjzO+iGhxu8bhX9plFKoiyfVzlKXa01JpNS
         FCaFOPB+5GT+YdDKVSNlz4s36NaqjHcTh+2jGFzSFDKXV1W6k+HA15GbXxzuC0sqlL5j
         0tny0ijgrmGgF1fmwAIUMrencHvSyz52Vi7urkj4LFVI9zZEvWsnP49w15Q/sYKj/d1d
         Q4Ej6E2UQrxcE6pFfh0/oUsqEE4lJjt88bTLMok9Cxl54zh26T/xVJS/3GyO7P8G9RBZ
         wlXQ==
X-Gm-Message-State: AOJu0YwiXNPU7bDJFRH+9t7PGZtTF+Jyx3tfZJtdt1hk4/9ndBv/TVyo
        B7R8BhYhTC8uYUfeXlACoa5id///pag=
X-Google-Smtp-Source: AGHT+IHBr3/OjITePGVSx9KsXo5OkTgZSKCSWuubbx5RnIML4QBOh/JwN6YQpw8wTxXq8Kjlr75XvQ==
X-Received: by 2002:a05:620a:44c6:b0:765:5b54:93c8 with SMTP id y6-20020a05620a44c600b007655b5493c8mr5652782qkp.76.1691244015240;
        Sat, 05 Aug 2023 07:00:15 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.72.63])
        by smtp.gmail.com with ESMTPSA id y3-20020a37e303000000b0075b2af4a076sm1357005qki.16.2023.08.05.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 07:00:14 -0700 (PDT)
Message-ID: <64ce55ee.370a0220.2012f.648e@mx.google.com>
Date:   Sat, 05 Aug 2023 07:00:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8164197711521352707=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] btdev: fix CIG ID on Set CIG Parameters error response
In-Reply-To: <570f7e0427b35925c741118d397eb8bcbcb51efe.1691238245.git.pav@iki.fi>
References: <570f7e0427b35925c741118d397eb8bcbcb51efe.1691238245.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8164197711521352707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773356

---Test result---

Test Summary:
CheckPatch                    FAIL      1.33 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      27.37 seconds
BluezMake                     PASS      887.61 seconds
MakeCheck                     PASS      12.75 seconds
MakeDistcheck                 PASS      157.93 seconds
CheckValgrind                 PASS      259.09 seconds
CheckSmatch                   WARNING   347.36 seconds
bluezmakeextell               PASS      104.51 seconds
IncrementalBuild              PASS      1448.91 seconds
ScanBuild                     PASS      1077.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] iso-tester: test busy CIG error does not drop existing connections
WARNING:TYPO_SPELLING: 'explictly' may be misspelled - perhaps 'explicitly'?
#97: 
in hci_sync. So the test needs to check the error async and explictly
                                                            ^^^^^^^^^

/github/workspace/src/src/13342572.patch total: 0 errors, 1 warnings, 97 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13342572.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:420:29: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8164197711521352707==--
