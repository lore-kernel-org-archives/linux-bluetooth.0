Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E1DC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jul 2022 15:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiGMPJV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiGMPJK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 11:09:10 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC3DD4
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 08:09:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b9so10477449pfp.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=HdMJSPN7gjv4RXalSgE84Iv1NSMZnooR4oJnSUVFrjo=;
        b=aYPIIihrX/+ypAYjXVkuC8uSWDJSqUhSoswtEwCTYVdxo2pqI3ybJFtAbqYz5zlhZY
         7hY/f1UZNz6S1c49WyjWtbjPUDJZO1DXOTocHiq3PbylksI4RzNt5WrBQzHfxRrAS6ij
         K4XjATXumEmljDsoHzqn6DinaJg4LJ11dabYRmlNer9nMpbtnfjYct+I0+e7E/zVzDF5
         iHAmwYuO9DzqMzBq/zGJ7SzWSd6IVNZvRll9yMeBt5wJ+0zbVnrN8xu4OlreUzV9/EsE
         Pvjp0g3q6ru9lDvJbteoqj4pwLJPirT1nTkeMJ+/Kod/GmDNQNUBmlWmBU2Zeso0Y1N/
         nUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=HdMJSPN7gjv4RXalSgE84Iv1NSMZnooR4oJnSUVFrjo=;
        b=aQz66AlnHvkjYQS73jal5HJ+lByvZrYViTBhmJ6YiOhc165FSH5khXosVWFZziptoK
         VZpFyu3YDnGtOF49pda5YWljBPjB96qLfwnBktMzLD5RgLMqe9f/Fa0t7fMv4acSzY0+
         foSaxBfSZiVavLkWo62/n783wHbNs33Ttt4iUb4wBagorYeiZ6N+nxvG8hy9EkfuPE3H
         64xjqk6GKtG2nhIijwUfaRZakDUBFmZ1QsuBivnYjRLdQbG94SsOtHGvo+PSFmXRwofW
         6MC+KGDvq4iVLQA5A/pHsMWQ4WPhGdpfiNIQlXOLs8v+1kFzBf9rQfY7oqBWMP0OD73W
         cU0w==
X-Gm-Message-State: AJIora+8mrN2MjH7GeY8ycxyaiEGYweYUFjUZxBhDmnxqAl8Cv4LzkyM
        ShFOIYhakrZbeMKmS7pDsf/kC2fiQdEN+w==
X-Google-Smtp-Source: AGRyM1vdh24aLD9BlLErJGTEA+gs7e82n4TQ6AVFApYOoHUfcXQxiU7z0EiY3JI17GVaUwzVepZ9aA==
X-Received: by 2002:a63:5c42:0:b0:412:b2e9:97e4 with SMTP id n2-20020a635c42000000b00412b2e997e4mr3495299pgm.36.1657724948746;
        Wed, 13 Jul 2022 08:09:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.204.141])
        by smtp.gmail.com with ESMTPSA id d21-20020a63fd15000000b0040ca587fe0fsm8031004pgh.63.2022.07.13.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:09:08 -0700 (PDT)
Message-ID: <62cee014.1c69fb81.2982f.bcd7@mx.google.com>
Date:   Wed, 13 Jul 2022 08:09:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4539856075852245133=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wavexx@thregr.org
Subject: RE: Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MTK
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220713140631.79775-1-wavexx@thregr.org>
References: <20220713140631.79775-1-wavexx@thregr.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4539856075852245133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659355

---Test result---

Test Summary:
CheckPatch                    FAIL      1.03 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      38.41 seconds
BuildKernel32                 PASS      34.29 seconds
Incremental Build with patchesPASS      44.56 seconds
TestRunner: Setup             PASS      563.69 seconds
TestRunner: l2cap-tester      PASS      18.75 seconds
TestRunner: bnep-tester       PASS      6.63 seconds
TestRunner: mgmt-tester       PASS      108.37 seconds
TestRunner: rfcomm-tester     PASS      10.53 seconds
TestRunner: sco-tester        PASS      9.90 seconds
TestRunner: smp-tester        PASS      9.95 seconds
TestRunner: userchan-tester   PASS      6.78 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.03 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for MTK\ERROR:MISSING_SIGN_OFF: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12916835.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4539856075852245133==--
