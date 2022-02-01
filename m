Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD15C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 13:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiBANQh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 08:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbiBANQg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 08:16:36 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61574C061714
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Feb 2022 05:16:36 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id b5so14297027qtq.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Feb 2022 05:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=slOmYLA5bXHGpt32TI40+65OAAs+bPrQ1jE6HZbnVWg=;
        b=bned/vOaN+56yb4U9QnZysutqR+Ia7G+uAGhpEJi2z+DMWsgHupdanymVe2o3fQKbp
         r9Yl8V+XBR+wVoJB5CNX7Y5Ae1hSrkaXXw123OOUFjZE6yaNL7K70eJxnJroivLNFJRD
         svrGtB0LuFbFH1VrLjjCDcyGiGr1C+3+We+2uVruUQQP3HTdWLejeWrz5dbkum3FCFpw
         cguNUrWOkmIFvIE0zPGSg5BfiUCVhbiYwGgzptZUHYljIBpAgqVcZYz+wNXFRIfI25P1
         EVwK+sZHTKuASuqV8j5NTtJGhkDC9PpfvS9gHddyrSX8bTwBNlXY5RZthfVmYODWUxzb
         uNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=slOmYLA5bXHGpt32TI40+65OAAs+bPrQ1jE6HZbnVWg=;
        b=xHIM3eOffIobI/YDk4N6+xW8wUjs6sSOeeeF50P5Sk/RQqF0Ak7+0B/AFVRuj4DvQ6
         KBj5sMtuUf6j+Aqh+EGKbKhqGT/16duaCttXS96KImwimKdcPB2QfXwLvrZvSrGkOw4+
         06Gv27vtlBd9IqYlrqcpL68uTV8kaECMyjM21lv+/zLuRbubmib4z/dBUJ0J/SZL7rHd
         e7hibwQts2X4UnYr5/GtXiYqORnJJ39adOofmU6EN4BAJK7f4t9YWWTIOORbB9Qf0ZJ6
         5sxheL0emuQuf87A4XaSMJeQX/Ck8g7+zpUcsTm0Y+CZ2gCVqoDClp5jNduKEuX4EhN2
         1Myg==
X-Gm-Message-State: AOAM532U3T26G3EHR53SW8kakm0Uf8cbsgnp2SlppbcBE8iiy6IrUKzB
        x4YNoFR5beSW2xuX4SxOqXkuSiEkA+w0og==
X-Google-Smtp-Source: ABdhPJzhgiQuS3zElA2T+198tdoQL2ESFOY9tzjJuiSplblD0DtJak5w0ftX/Jx+01pXZEeLnMR5Qg==
X-Received: by 2002:a05:622a:14d4:: with SMTP id u20mr17454749qtx.262.1643721395317;
        Tue, 01 Feb 2022 05:16:35 -0800 (PST)
Received: from [172.17.0.2] ([13.82.125.74])
        by smtp.gmail.com with ESMTPSA id bj19sm6687042qkb.109.2022.02.01.05.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 05:16:35 -0800 (PST)
Message-ID: <61f932b3.1c69fb81.4c4f.cbbe@mx.google.com>
Date:   Tue, 01 Feb 2022 05:16:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2261091333680793794=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, joern.koerner@ijwo.de
Subject: RE: Bluetooth: btusb: Add support for Edup BT5.1 Class1 Adapter (RTL8761B)
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220201124134.806135-1-joern.koerner@ijwo.de>
References: <20220201124134.806135-1-joern.koerner@ijwo.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2261091333680793794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=610339

---Test result---

Test Summary:
CheckPatch                    FAIL      1.66 seconds
GitLint                       FAIL      1.03 seconds
SubjectPrefix                 PASS      0.82 seconds
BuildKernel                   PASS      32.94 seconds
BuildKernel32                 PASS      28.05 seconds
Incremental Build with patchesPASS      37.97 seconds
TestRunner: Setup             PASS      503.52 seconds
TestRunner: l2cap-tester      PASS      13.94 seconds
TestRunner: bnep-tester       PASS      6.56 seconds
TestRunner: mgmt-tester       PASS      108.08 seconds
TestRunner: rfcomm-tester     PASS      7.98 seconds
TestRunner: sco-tester        PASS      8.35 seconds
TestRunner: smp-tester        PASS      8.01 seconds
TestRunner: userchan-tester   PASS      6.75 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.66 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: btusb: Add support for Edup BT5.1 Class1 Adapter (RTL8761B)\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#51: 
 Prnt=02 Port=00 Cnt=01 Dev#=  7 Spd=12   MxCh= 0 D:  Ver= 1.10 Cls=e0(wlcon)

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12731685.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 1.03 seconds
Run gitlint with rule in .gitlint
Bluetooth: btusb: Add support for Edup BT5.1 Class1 Adapter (RTL8761B)
5: B2 Line has trailing whitespace: " Sub=01 Prot=01 MxPS=64 #Cfgs=  1 P:  Vendor=2550 ProdID=8761 Rev= 2.00 S: "
6: B2 Line has trailing whitespace: " Manufacturer=Realtek S:  Product=Bluetooth Radio S: "




---
Regards,
Linux Bluetooth


--===============2261091333680793794==--
