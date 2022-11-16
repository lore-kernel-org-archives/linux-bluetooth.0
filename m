Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiKPV2i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiKPV2g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 16:28:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757B26F
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 13:28:31 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id be13so31702266lfb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 13:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mOZR/swktbfkYrzvqgzNcV2PJeCytCjBT2cONnEn1QA=;
        b=c349DGnYJ/qtuh5UzuVyTRiQME+inrbaQuGP2XT+StL3us9zDaUcn+ieyDc5PjLcd4
         H7DJlzhZtqpGxaPXwPi76hX7GzUFg70HGII35aQMe/nWFpIMqTKp1JiwQkmotanlyc0F
         AuAVtz2s+3QutXUOHvyLPL1AvyIj7p2TrZKQO9+BLP5+9J/OYiGUlz93Sc9UL1jN6fK3
         1SqGUQzHblgdVXchLLeSovIzI/RA2SGvwMPc3eNoVCBLcUV4Ka+ViycvSJXecMk6V64C
         HQoMeOc7RhOJDnrY9x7AbfJd+sklzeikqDD6pscLDuR6mnHTHSkd/YPgjZeTfThHHzXg
         WC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOZR/swktbfkYrzvqgzNcV2PJeCytCjBT2cONnEn1QA=;
        b=x8KyYJG9rJ4SmEiedw7P4DudxcxFBTCtXD4T950qdxcSapa1l0l8aHHK++QO8Hq7vj
         FmlHPGaV0mktlpUwuS4tK/fZV+UV87fUZfB6D9F3V/+7xvVuTbr/KSE/v/ZPXTnOexH/
         6ORbcYZYOnD9V3MgPE/P+gy8vfYiqmWTie9kovz79bts/rvpARVwalWOwz9VXgc1XnwZ
         DBbksmPzsnrfzSsvjGssvX1WpBWdZv0YSUrvKR708dWvelETkFHaARh0cZW9+WHzeGPZ
         KExSSTZFWq0ZXJu9n69Sh3M+tYO8+mz3NQUeoTpBMusSWHvDyo31JQY8izZQb7LOH3TI
         ZfmA==
X-Gm-Message-State: ANoB5pk63tjE/luQSD5D/LLD+Vffaj5cNeQxikooUwGkrJI13iSJ8MKI
        TF/9khvQDNCS+sAcS+xYToibh+rP3maC/7Mf+ZmLNHMS5Lk=
X-Google-Smtp-Source: AA0mqf5sSNx9FGuOc0UfRmusmFdYJI/16tUDiQA9DcJCxWnJ3XY2JvL4nfCOfIsre/v6eHy+/AYbJI8Ln6hQ+Y0pBSg=
X-Received: by 2002:a19:2d48:0:b0:4a2:2d7b:838 with SMTP id
 t8-20020a192d48000000b004a22d7b0838mr7221325lft.251.1668634109583; Wed, 16
 Nov 2022 13:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com> <6374fbd8.4a0a0220.48530.6d2f@mx.google.com>
In-Reply-To: <6374fbd8.4a0a0220.48530.6d2f@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Nov 2022 13:28:18 -0800
Message-ID: <CABBYNZK5m+rvUfSPNMM7qYUHDRBkU-ONXxhLwL-3ofWx7hWXaA@mail.gmail.com>
Subject: Re: hci_event: handling CIS QoS
To:     linux-bluetooth@vger.kernel.org
Cc:     abhay.maheshbhai.maheta@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhay,

On Wed, Nov 16, 2022 at 7:11 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696036
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.33 seconds
> GitLint                       PASS      0.95 seconds
> SubjectPrefix                 FAIL      0.59 seconds
> BuildKernel                   PASS      33.54 seconds
> BuildKernel32                 PASS      31.34 seconds
> Incremental Build with patchesPASS      45.63 seconds
> TestRunner: Setup             PASS      513.97 seconds
> TestRunner: l2cap-tester      PASS      16.64 seconds
> TestRunner: iso-tester        FAIL      16.78 seconds
> TestRunner: bnep-tester       PASS      6.58 seconds
> TestRunner: mgmt-tester       PASS      101.31 seconds
> TestRunner: rfcomm-tester     PASS      10.44 seconds
> TestRunner: sco-tester        PASS      9.29 seconds
> TestRunner: ioctl-tester      PASS      11.12 seconds
> TestRunner: mesh-tester       PASS      7.99 seconds
> TestRunner: smp-tester        PASS      9.90 seconds
> TestRunner: userchan-tester   PASS      6.81 seconds
>
> Details
> ##############################
> Test: SubjectPrefix - FAIL - 0.59 seconds
> Check subject contains "Bluetooth" prefix
> "Bluetooth: " is not specified in the subject
>
> ##############################
> Test: TestRunner: iso-tester - FAIL - 16.78 seconds
> Run test-runner with iso-tester
> Total: 55, Passed: 11 (20.0%), Failed: 44, Not Run: 0
>
> Failed Test Cases
> ISO QoS 8_1_1 - Success                              Failed       1.977 seconds
> ISO QoS 8_2_1 - Success                              Failed       0.152 seconds
> ISO QoS 16_1_1 - Success                             Failed       0.151 seconds
> ISO QoS 16_2_1 - Success                             Failed       0.150 seconds
> ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.150 seconds
> ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.150 seconds
> ISO QoS 24_1_1 - Success                             Failed       0.149 seconds
> ISO QoS 24_2_1 - Success                             Failed       0.152 seconds
> ISO QoS 32_1_1 - Success                             Failed       0.150 seconds
> ISO QoS 32_2_1 - Success                             Failed       0.150 seconds
> ISO QoS 44_1_1 - Success                             Failed       0.150 seconds
> ISO QoS 44_2_1 - Success                             Failed       0.156 seconds
> ISO QoS 48_1_1 - Success                             Failed       0.151 seconds
> ISO QoS 48_2_1 - Success                             Failed       0.150 seconds
> ISO QoS 48_3_1 - Success                             Failed       0.150 seconds
> ISO QoS 48_4_1 - Success                             Failed       0.149 seconds
> ISO QoS 48_5_1 - Success                             Failed       0.150 seconds
> ISO QoS 48_6_1 - Success                             Failed       0.148 seconds
> ISO QoS 8_1_2 - Success                              Failed       0.150 seconds
> ISO QoS 8_2_2 - Success                              Failed       0.149 seconds
> ISO QoS 16_1_2 - Success                             Failed       0.150 seconds
> ISO QoS 16_2_2 - Success                             Failed       0.150 seconds
> ISO QoS 24_1_2 - Success                             Failed       0.150 seconds
> ISO QoS 24_2_2 - Success                             Failed       0.150 seconds
> ISO QoS 32_1_2 - Success                             Failed       0.148 seconds
> ISO QoS 32_2_2 - Success                             Failed       0.150 seconds
> ISO QoS 44_1_2 - Success                             Failed       0.148 seconds
> ISO QoS 44_2_2 - Success                             Failed       0.150 seconds
> ISO QoS 48_1_2 - Success                             Failed       0.149 seconds
> ISO QoS 48_2_2 - Success                             Failed       0.148 seconds
> ISO QoS 48_3_2 - Success                             Failed       0.150 seconds
> ISO QoS 48_4_2 - Success                             Failed       0.149 seconds
> ISO QoS 48_5_2 - Success                             Failed       0.149 seconds
> ISO QoS 48_6_2 - Success                             Failed       0.151 seconds
> ISO Connect2 CIG 0x01 - Success                      Failed       0.191 seconds
> ISO Send - Success                                   Failed       0.153 seconds
> ISO Receive - Success                                Failed       0.167 seconds
> ISO Defer Send - Success                             Failed       0.156 seconds
> ISO 48_2_1 Defer Send - Success                      Failed       0.158 seconds
> ISO Defer Receive - Success                          Failed       0.154 seconds
> ISO 48_2_1 Defer Receive - Success                   Failed       0.150 seconds
> ISO Send and Receive - Success                       Failed       0.157 seconds
> ISO Disconnect - Success                             Failed       0.162 seconds
> ISO Reconnect - Success                              Failed       0.163 seconds

I suspect we will need to fix the emulator to make these test pass first:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/emulator/btdev.c#n5889

>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
