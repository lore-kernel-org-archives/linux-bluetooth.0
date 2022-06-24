Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ADFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 07:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiFXHK4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXHK4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 03:10:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9E63631
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 00:10:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s124so2613492oia.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lkt1rDb+XZ4gzbG6YwhGbLn6On3BGG33SuNf81qcStM=;
        b=Slgx6eyYaZLRhQ0dZePJFYSHpSp2X4ucaahwAtuhM9NCIU1w9F0dttsjRSQW2EPuMH
         r3TMPSJgHNJfSbBhy9eTfD43LZ72YJcVFcawvPEuXFy1q72yQ+Yt5SLIB3G2XHShSKZf
         56e2siw+1EUZmqQ6f2f9TQFvJCLo/eRJCPRq1qvZ8df6C5heCD0WuS4zy+WMWutcIXay
         O2/UnKVnPz8ReCET6bxwyo5nOiplTwhyQcPnjFT4xV/KjqxKLQempfkZ7RRXxrtY355p
         F//qNrHnWlLZJz8/iPt8gLyaXpUesq2zA/E4vDR2CkR4wPVYk8zPKmAu0rMcz1HKV3UK
         NRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lkt1rDb+XZ4gzbG6YwhGbLn6On3BGG33SuNf81qcStM=;
        b=4iG1jJ1Le7wOAKqw8QmV2K/9VdwL36Jhjm5RET4g5vUhnEO8UlghbKK+eLPtNiRPXF
         pRzyhJjQlCgACn6fQOYupI9xFZbMYBkacqqIe/ToeCb5myruAas3qKZmL2dhDrS1ty4e
         Hkol/1FUCn4wJBAXlVL4v/oFWnNzlxEeAvmn5qk8GTC5wHTabIqjVJiSiQYRJMZMfTBD
         kyd5IXEbWlhx7VmSJZ3sMLkkXk8S7JMnr5FAArEhMenE6rrzHFmghRWToDV+NFIBYPP7
         wPzoYqlIPuSIX3uQj4Z/UoVu3yqMfkXHIIi+iy/b0p+fOGFvEvu4o/6QaH7NT5/BAw3Y
         L1gg==
X-Gm-Message-State: AJIora9BxcmMwuJ8OaDwC21OplBPm2axLIINsWOHwMMKC0ZBqUQ3xAfQ
        vqhF5NK/bCiXh+pf1WIeq3BzMEhyDXk=
X-Google-Smtp-Source: AGRyM1vBNMzuF52NAXtsoBT3EPszeGQnfhperYy9Hoi6UmqOxLWmUWh2J9o69A1MVHy5Cu7yewbGFw==
X-Received: by 2002:a05:6808:1204:b0:325:73cc:867c with SMTP id a4-20020a056808120400b0032573cc867cmr1092633oil.95.1656054652883;
        Fri, 24 Jun 2022 00:10:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.174.9])
        by smtp.gmail.com with ESMTPSA id w12-20020a056870a2cc00b000f33624baa4sm1389240oak.18.2022.06.24.00.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 00:10:52 -0700 (PDT)
Message-ID: <62b5637c.1c69fb81.cee1a.35b6@mx.google.com>
Date:   Fri, 24 Jun 2022 00:10:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7271160955307018485=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, xw897002528@gmail.com
Subject: RE: [v2] Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220624061639.36230-1-xw897002528@gmail.com>
References: <20220624061639.36230-1-xw897002528@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7271160955307018485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653443

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
GitLint                       PASS      0.73 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      38.69 seconds
BuildKernel32                 PASS      34.28 seconds
Incremental Build with patchesPASS      46.64 seconds
TestRunner: Setup             PASS      580.79 seconds
TestRunner: l2cap-tester      PASS      19.41 seconds
TestRunner: bnep-tester       PASS      7.08 seconds
TestRunner: mgmt-tester       PASS      115.38 seconds
TestRunner: rfcomm-tester     PASS      11.00 seconds
TestRunner: sco-tester        PASS      10.73 seconds
TestRunner: smp-tester        PASS      10.74 seconds
TestRunner: userchan-tester   PASS      7.33 seconds



---
Regards,
Linux Bluetooth


--===============7271160955307018485==--
