Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61887EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 20:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjFUUdi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFUUdh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 16:33:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624E619A6
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 13:33:35 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77faf29bdf1so108898939f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687379614; x=1689971614;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DkqMGN4Apv+x5q4TZuxrmvd3ARC5qmyqEZy8IJBr79M=;
        b=enRsckLpAwkHx3ZTjailwOEjcO3vMyWQ6sXTJhc7wH/jpOx8/PrPpWdJULy7LS02HE
         ZtKrEZEOrFm126dDkMIPffdbxwNEzZUJfvjp65r4QxEQvULZcMoL7g7KlOWRdTHaSsj9
         j8IKH5GPePJvl4GPZ7Iz0RwPI8E98O0L3RCeS9mQZ0Fx9kB4GhD+4kK5Y9J/hI8lBKVq
         qIbaShNOL7/rTBISRC0I/kG+derYpBrApHW+PfQy5Ncs/EXJ9csSc2atHT8TcVeAuaiQ
         QepexaNvS3xLqnviRN/P9syvUFcvB1r9kKTxXl7XRjbmTk5H01eQP3FqvZeI+fchLgN4
         oeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687379614; x=1689971614;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkqMGN4Apv+x5q4TZuxrmvd3ARC5qmyqEZy8IJBr79M=;
        b=fBiF7C9O40lG/2FqvrqHa3+sMLKxS+PQn8S1qZnoQbwJm22Nwbpy+R90BUcdgbQ2YM
         hNo6vStg+uW1uxteTOJW9L65O7cjEYANVzvr5fqxw9vzL+KEG1b5dqqLFPK7yUgqMw6t
         j1/okYxtc6Mz0N4SH8qo29HlPxoVQrGnoSrEmgJIe2LJDttdCKxVa9a5eQ2d3TxdTM3F
         HRxppofnpb5KSsdIryeZAXpjZqcjzI1xl5R0PYJnPpL7woxs+4660Q3mcuHo+//p2Ti3
         69rLcKZPktcO+w3DbPudiRIjA/tCBjgU10cvNdpej+zrnniUCGp6zHY/rTGRZE1NK+K2
         gI8g==
X-Gm-Message-State: AC+VfDxdDCpCxxR9+nZmRMGl54goRk/8EvXZf7cTwT67X1XaOlUf84x1
        qKmx3rX+aFokxXcFNbYjcGKAzL9q7WI=
X-Google-Smtp-Source: ACHHUZ4Y+MmyQTJ/K7weHrhMp3ovhHh9UQEV6gRB/yAyMNJa6OFZRkV2IhXHEXRVC/y39oVn0vQFAA==
X-Received: by 2002:a92:4b02:0:b0:33d:136f:249f with SMTP id m2-20020a924b02000000b0033d136f249fmr16053990ilg.22.1687379614453;
        Wed, 21 Jun 2023 13:33:34 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.243.95])
        by smtp.gmail.com with ESMTPSA id o8-20020a92dac8000000b003358f4eb209sm1564632ilq.60.2023.06.21.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:33:34 -0700 (PDT)
Message-ID: <64935e9e.920a0220.aea31.2390@mx.google.com>
Date:   Wed, 21 Jun 2023 13:33:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4537512983550511069=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_event: Fix parsing of CIS Established Event
In-Reply-To: <20230621195407.977001-1-luiz.dentz@gmail.com>
References: <20230621195407.977001-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4537512983550511069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759261

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.43 seconds
CheckAllWarning               PASS      35.86 seconds
CheckSparse                   WARNING   40.37 seconds
CheckSmatch                   WARNING   112.71 seconds
BuildKernel32                 PASS      31.55 seconds
TestRunnerSetup               PASS      449.78 seconds
TestRunner_l2cap-tester       PASS      16.88 seconds
TestRunner_iso-tester         FAIL      31.32 seconds
TestRunner_bnep-tester        PASS      5.38 seconds
TestRunner_mgmt-tester        PASS      129.16 seconds
TestRunner_rfcomm-tester      PASS      8.76 seconds
TestRunner_sco-tester         PASS      8.00 seconds
TestRunner_ioctl-tester       PASS      9.41 seconds
TestRunner_mesh-tester        PASS      6.80 seconds
TestRunner_smp-tester         PASS      8.00 seconds
TestRunner_userchan-tester    PASS      5.66 seconds
IncrementalBuild              PASS      30.47 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 17 (21.2%), Failed: 63, Not Run: 0

Failed Test Cases
ISO QoS 8_1_1 - Success                              Failed       1.140 seconds
ISO QoS 8_2_1 - Success                              Failed       0.207 seconds
ISO QoS 16_1_1 - Success                             Failed       0.211 seconds
ISO QoS 16_2_1 - Success                             Failed       0.205 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.208 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.206 seconds
ISO QoS 24_1_1 - Success                             Failed       0.208 seconds
ISO QoS 24_2_1 - Success                             Failed       0.210 seconds
ISO QoS 32_1_1 - Success                             Failed       0.206 seconds
ISO QoS 32_2_1 - Success                             Failed       0.202 seconds
ISO QoS 44_1_1 - Success                             Failed       0.205 seconds
ISO QoS 44_2_1 - Success                             Failed       0.197 seconds
ISO QoS 48_1_1 - Success                             Failed       0.197 seconds
ISO QoS 48_2_1 - Success                             Failed       0.208 seconds
ISO QoS 48_3_1 - Success                             Failed       0.207 seconds
ISO QoS 48_4_1 - Success                             Failed       0.206 seconds
ISO QoS 48_5_1 - Success                             Failed       0.199 seconds
ISO QoS 48_6_1 - Success                             Failed       0.198 seconds
ISO QoS 8_1_2 - Success                              Failed       0.208 seconds
ISO QoS 8_2_2 - Success                              Failed       0.205 seconds
ISO QoS 16_1_2 - Success                             Failed       0.209 seconds
ISO QoS 16_2_2 - Success                             Failed       0.205 seconds
ISO QoS 24_1_2 - Success                             Failed       0.207 seconds
ISO QoS 24_2_2 - Success                             Failed       0.206 seconds
ISO QoS 32_1_2 - Success                             Failed       0.207 seconds
ISO QoS 32_2_2 - Success                             Failed       0.206 seconds
ISO QoS 44_1_2 - Success                             Failed       0.202 seconds
ISO QoS 44_2_2 - Success                             Failed       0.206 seconds
ISO QoS 48_1_2 - Success                             Failed       0.207 seconds
ISO QoS 48_2_2 - Success                             Failed       0.198 seconds
ISO QoS 48_3_2 - Success                             Failed       0.199 seconds
ISO QoS 48_4_2 - Success                             Failed       0.207 seconds
ISO QoS 48_5_2 - Success                             Failed       0.199 seconds
ISO QoS 48_6_2 - Success                             Failed       0.210 seconds
ISO Send - Success                                   Failed       0.203 seconds
ISO Receive - Success                                Failed       0.194 seconds
ISO Receive Timestamped - Success                    Failed       0.185 seconds
ISO Defer Connect - Success                          Failed       0.205 seconds
ISO Defer Connect2 CIG 0x01 - Success                Failed       0.295 seconds
ISO Defer Send - Success                             Failed       0.207 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.209 seconds
ISO Defer Receive - Success                          Failed       0.187 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.184 seconds
ISO Send and Receive - Success                       Failed       0.209 seconds
ISO Disconnect - Success                             Failed       0.208 seconds
ISO Reconnect - Success                              Failed       0.202 seconds
ISO AC 1 & 4 - Success                               Failed       0.200 seconds
ISO AC 2 & 10 - Success                              Failed       0.199 seconds
ISO AC 3 & 5 - Success                               Failed       0.203 seconds
ISO AC 6(i) - Success                                Failed       0.230 seconds
ISO AC 6(ii) - Success                               Failed       0.307 seconds
ISO AC 7(i) - Success                                Failed       0.231 seconds
ISO AC 7(ii) - Success                               Failed       0.289 seconds
ISO AC 8(i) - Success                                Failed       0.237 seconds
ISO AC 8(ii) - Success                               Failed       0.299 seconds
ISO AC 9(i) - Success                                Failed       0.236 seconds
ISO AC 9(ii) - Success                               Failed       0.287 seconds
ISO AC 11(i) - Success                               Failed       0.234 seconds
ISO AC 11(ii) - Success                              Failed       0.297 seconds
ISO AC 1 + 2 - Success                               Failed       4.292 seconds
ISO AC 1 + 2 CIG 0x01/0x02 - Success                 Failed       4.287 seconds
ISO Reconnect AC 6(i) - Success                      Failed       0.296 seconds
ISO Reconnect AC 6(ii) - Success                     Failed       0.294 seconds


---
Regards,
Linux Bluetooth


--===============4537512983550511069==--
