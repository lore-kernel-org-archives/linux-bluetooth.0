Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE77C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 12:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiHLMB4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 08:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHLMBz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 08:01:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B89A97A
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 05:01:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p125so781742pfp.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 05:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=GKOXfXtqDhsdCfF/5fF7OAXx+2oVLOnLoL8fgErHCuQ=;
        b=SmlwEfswbZ1IO+ikdj6jAOk+kSDbKopI6PvkUDjjjtIRV4VErslTBQteMhqC/mCRIW
         yaKaTgN5CFrbjdZtsNY8JlVUsfhIeoF1sKwDtcZjPWo8VUBNagPmoo9rvTGSTdephUHO
         hgt+NjZUiXP/WElHtxYPZ1rbXcyUQ1EmU09cZQtbxcITUWvqR7MdS5TnqfX51kiqxaps
         R4X8ED+NUTQq1do45WTX+Nm7JHQVQRnwvjR/yodwJ3mW0aYgnKohzcWvgOp2c9FRIIbK
         AH7+eP4Y68lgvoTYQGOvXY4VFg+jS0ECjJMELWnUZ70PCKvWRZnDnz0y9lVQp+RYdDMb
         tHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=GKOXfXtqDhsdCfF/5fF7OAXx+2oVLOnLoL8fgErHCuQ=;
        b=aR5IIqU7FlH2Xq1P/k2lLff2C0OAwh2LyUtaLlaHpnjLFkytcbzQP4KMZhPQcbYtrT
         V4om1JHlALjEEjE+hRzxOVuN6uTDbsFZtf7wAubm1TP2VPHHesrw3DdqRlDwhuxe0Aau
         f/Ay2j0+e/lzQTdeWDj8ZlEgCg87tyBu2OUVadcUX+MBpLTi8KdIV4hlbJrgrhlXExjD
         OVCy4zzNoxF+PoZzcA4A5JnBBo2YW/kl4w+ehExczan8glBQLaIeL0ZY1xcEafhO0ENB
         vDb2wklgxlXTNATzXxXozyoaph71JHyWpCrOn/7XTUhuXulFA08k6VG9wMzuKIxowS+z
         OlKg==
X-Gm-Message-State: ACgBeo0FDHlyhnRNOE8em0R8Pp/OHgpQ8z1sjEUEVbxqHPVaXID8tWwu
        EJ5cLkQjxwB83JTcTWpg3hzy18/ysGA=
X-Google-Smtp-Source: AA6agR4ITWs/9RI+B8ObUb/DRdLRDH0TCqEqNg+f4E8i9FDJjNi7kldskzW1noBIZo3sC4X5BH9bww==
X-Received: by 2002:a65:45cb:0:b0:41b:87ad:2a75 with SMTP id m11-20020a6545cb000000b0041b87ad2a75mr2844089pgr.604.1660305712932;
        Fri, 12 Aug 2022 05:01:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.176.44])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0016bd8fb1fafsm1518989plg.307.2022.08.12.05.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 05:01:52 -0700 (PDT)
Message-ID: <62f64130.170a0220.6c642.27b0@mx.google.com>
Date:   Fri, 12 Aug 2022 05:01:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0756950658337741147=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wimvanboven@gmail.com
Subject: RE: drivers/bluetooth: add vendor and device id for liteon WCN685x device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220812113824.13168-1-wimvanboven@gmail.com>
References: <20220812113824.13168-1-wimvanboven@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0756950658337741147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667162

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 FAIL      0.33 seconds
BuildKernel                   PASS      39.50 seconds
BuildKernel32                 PASS      34.34 seconds
Incremental Build with patchesPASS      48.60 seconds
TestRunner: Setup             PASS      576.76 seconds
TestRunner: l2cap-tester      PASS      19.15 seconds
TestRunner: bnep-tester       PASS      7.46 seconds
TestRunner: mgmt-tester       PASS      116.36 seconds
TestRunner: rfcomm-tester     PASS      11.35 seconds
TestRunner: sco-tester        PASS      11.00 seconds
TestRunner: smp-tester        PASS      10.91 seconds
TestRunner: userchan-tester   PASS      7.88 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.33 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0756950658337741147==--
