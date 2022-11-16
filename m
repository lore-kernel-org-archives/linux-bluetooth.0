Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F04CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 15:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiKPPD4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 10:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiKPPDz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 10:03:55 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591D262FD
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 07:03:54 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id b124so18783298oia.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 07:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5zaPE8sR1x+nFOZYnxt6MwFgs1TGatY6qor38Gt7Izc=;
        b=C1D8K2O5tesEQ5N6JqzOXX9hGIaxesniQphFE4Ud1ywCqT2RX3XCBiFay5zKh8pTh1
         3Vb7NVXAuCC1DRbiEyH5HxYxAgCYWI+MCF+NuKRHPQngYjC+Tg4esgpe+jdEdbeYAlww
         XHBTkTXK1Vspirrw3e7f3Wl0xN7wXVZQTfl0/XoomRgG+MaFVeJ5J9B60H0SHfGoEMpz
         ySQan1k0qJWWrjEUH6ZI63oU5IzQZu/BxwWGXW8zv3pR7H0iSxdxEUg24mUjpDakx7GP
         4eNcPzP555pV7Q3ZQKEXden1tquAL8hpmcQ8NyN9G8xrg20hDrVWa1FBovUWUJ9oa1pq
         gw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zaPE8sR1x+nFOZYnxt6MwFgs1TGatY6qor38Gt7Izc=;
        b=toMpItA5ptOmJMeNLy/fW/Z5knSA55FTbDpWaSpDDqZDI4E7HVGOSXtkEJglB2icPK
         rITt9HQAi899X7R5gAmY9n700PnKsrqkeSXAOuDI6kI5xpljstOAG4shoz2kjoyDnmDA
         ynKvtOB66o354OeuLdZl5LEke4bxxmezOlxtGPq8eY2w75W9mmkkEkdfClIVVKfrqnyw
         aLQHlrav8E1m9kvBhzU7FyEntka2knrwqcGIShtsTpGj7nKkm2QSG+4eWdD7i+Hc3W27
         Nwb4q6lf3I/wAoxePAARU9CpIknjH+zcTk8GiFz8wbHSMnwtHyxXJDUcC+xmDucAbpPZ
         giUg==
X-Gm-Message-State: ANoB5pnnhmhWBbqTCxS35vMJSRBa7w6etWzqs0LB1+TyQnWYtnQoJe2Y
        SRhoqtniecpq+QxEHGT2L2AkwHenN3U=
X-Google-Smtp-Source: AA0mqf5B+OgVwIFxlJ3e66CSwHj60AWoJc7hZI/BC0P9CvYzpoxZPP34jcIo6Ug0VBX9JL8o91qsRA==
X-Received: by 2002:aca:170d:0:b0:35a:7e8d:8ad6 with SMTP id j13-20020aca170d000000b0035a7e8d8ad6mr1703616oii.171.1668611033178;
        Wed, 16 Nov 2022 07:03:53 -0800 (PST)
Received: from [172.17.0.2] ([20.225.90.252])
        by smtp.gmail.com with ESMTPSA id s15-20020a4ae48f000000b0049ded99501bsm6096371oov.40.2022.11.16.07.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:03:52 -0800 (PST)
Message-ID: <6374fbd8.4a0a0220.48530.6d2f@mx.google.com>
Date:   Wed, 16 Nov 2022 07:03:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4812054528915779636=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: hci_event: handling CIS QoS
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
References: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4812054528915779636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696036

---Test result---

Test Summary:
CheckPatch                    PASS      1.33 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 FAIL      0.59 seconds
BuildKernel                   PASS      33.54 seconds
BuildKernel32                 PASS      31.34 seconds
Incremental Build with patchesPASS      45.63 seconds
TestRunner: Setup             PASS      513.97 seconds
TestRunner: l2cap-tester      PASS      16.64 seconds
TestRunner: iso-tester        FAIL      16.78 seconds
TestRunner: bnep-tester       PASS      6.58 seconds
TestRunner: mgmt-tester       PASS      101.31 seconds
TestRunner: rfcomm-tester     PASS      10.44 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: ioctl-tester      PASS      11.12 seconds
TestRunner: mesh-tester       PASS      7.99 seconds
TestRunner: smp-tester        PASS      9.90 seconds
TestRunner: userchan-tester   PASS      6.81 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.59 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject

##############################
Test: TestRunner: iso-tester - FAIL - 16.78 seconds
Run test-runner with iso-tester
Total: 55, Passed: 11 (20.0%), Failed: 44, Not Run: 0

Failed Test Cases
ISO QoS 8_1_1 - Success                              Failed       1.977 seconds
ISO QoS 8_2_1 - Success                              Failed       0.152 seconds
ISO QoS 16_1_1 - Success                             Failed       0.151 seconds
ISO QoS 16_2_1 - Success                             Failed       0.150 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.150 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.150 seconds
ISO QoS 24_1_1 - Success                             Failed       0.149 seconds
ISO QoS 24_2_1 - Success                             Failed       0.152 seconds
ISO QoS 32_1_1 - Success                             Failed       0.150 seconds
ISO QoS 32_2_1 - Success                             Failed       0.150 seconds
ISO QoS 44_1_1 - Success                             Failed       0.150 seconds
ISO QoS 44_2_1 - Success                             Failed       0.156 seconds
ISO QoS 48_1_1 - Success                             Failed       0.151 seconds
ISO QoS 48_2_1 - Success                             Failed       0.150 seconds
ISO QoS 48_3_1 - Success                             Failed       0.150 seconds
ISO QoS 48_4_1 - Success                             Failed       0.149 seconds
ISO QoS 48_5_1 - Success                             Failed       0.150 seconds
ISO QoS 48_6_1 - Success                             Failed       0.148 seconds
ISO QoS 8_1_2 - Success                              Failed       0.150 seconds
ISO QoS 8_2_2 - Success                              Failed       0.149 seconds
ISO QoS 16_1_2 - Success                             Failed       0.150 seconds
ISO QoS 16_2_2 - Success                             Failed       0.150 seconds
ISO QoS 24_1_2 - Success                             Failed       0.150 seconds
ISO QoS 24_2_2 - Success                             Failed       0.150 seconds
ISO QoS 32_1_2 - Success                             Failed       0.148 seconds
ISO QoS 32_2_2 - Success                             Failed       0.150 seconds
ISO QoS 44_1_2 - Success                             Failed       0.148 seconds
ISO QoS 44_2_2 - Success                             Failed       0.150 seconds
ISO QoS 48_1_2 - Success                             Failed       0.149 seconds
ISO QoS 48_2_2 - Success                             Failed       0.148 seconds
ISO QoS 48_3_2 - Success                             Failed       0.150 seconds
ISO QoS 48_4_2 - Success                             Failed       0.149 seconds
ISO QoS 48_5_2 - Success                             Failed       0.149 seconds
ISO QoS 48_6_2 - Success                             Failed       0.151 seconds
ISO Connect2 CIG 0x01 - Success                      Failed       0.191 seconds
ISO Send - Success                                   Failed       0.153 seconds
ISO Receive - Success                                Failed       0.167 seconds
ISO Defer Send - Success                             Failed       0.156 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.158 seconds
ISO Defer Receive - Success                          Failed       0.154 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.150 seconds
ISO Send and Receive - Success                       Failed       0.157 seconds
ISO Disconnect - Success                             Failed       0.162 seconds
ISO Reconnect - Success                              Failed       0.163 seconds



---
Regards,
Linux Bluetooth


--===============4812054528915779636==--
