Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32A0C76196
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 08:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC1IDR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1IDN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 04:03:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2437712F
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 01:03:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id r7-20020a17090b050700b002404be7920aso10303923pjz.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Mar 2023 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679990591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t9AWndJuDUyq8684oVVE0Rtuc9rmSh5UDqidImVRw3o=;
        b=G+zDuHNZp8vC6CDfWaf6+CPqW5FMxfJpPaoOnXEhEqcPyXlMckvnTgMmuE8w7fPSEf
         YDLlc5sp9vwaRGLNr3OhTGpGq9d5NgDnydwRttneML3DWxu7qAnr0X7dcOjwc27CzKDz
         H/jlcxxyrft+URzzJo13z7XfGXlHvalRugOkSiLBVtjPkMZXHHHqZMqU984abQmyBMWE
         vd34PfCyDjwElkAJZz1nWuXVc56BhniEoGYONgxYgFmZ8+fx63gmEvwWsRgNfKRE35gZ
         owhq7jIDuKv/+8L6Rt+UXVohdv41mN1iEMQHVYz9PhouXU+xBzkRqxfkw9zksTDdJeq0
         sgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679990591;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9AWndJuDUyq8684oVVE0Rtuc9rmSh5UDqidImVRw3o=;
        b=K443hK04sU0SsKb34MY5pjMLJ7l4d0OTmvrVGeHk3DXkNcrRXD9V9DIymSwXuNfCLe
         e6RBD6dJyTDrI9NIHH4/HtXj1syIzBftSQtZogoeY3qx8K7detoz4FKHyDo0zHgZAixW
         FqILnThOQ6G5S+wxBj4DcX1J7JJq7wzKDaksUJAVIxWiakUm95tGlA4YBPTVjYJdC2Kk
         usJwGoGwxiq+V+6qDUrNmlbluzVLxGHdWH18wHmppjX+OuO3m/5/79Ppu5Nm+7pBo+R/
         uE62qBEa9bCGY8wMLAvV0RlmW+o/55/zNlVggEnhxQjiZnOwV9RGLc7a81nOhQd6uFpZ
         VlVQ==
X-Gm-Message-State: AO0yUKX1dcwGcG8QF2DnckSvm3Vz20onRIj26uP108KSkeuhpIOqSjTK
        SKRrQ0TjAEB5EyMDMRD4MdkHz4kF+2g=
X-Google-Smtp-Source: AK7set8CYbrA/TMu260nQRHzVlOUU7xeU1GtIescFfzcP6FcWIhPzKsUtDdLdwh3Bi7E6sepftDkeA==
X-Received: by 2002:a05:6a20:4b10:b0:cc:50de:a2be with SMTP id fp16-20020a056a204b1000b000cc50dea2bemr12829671pzb.14.1679990591337;
        Tue, 28 Mar 2023 01:03:11 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.90.102])
        by smtp.gmail.com with ESMTPSA id a22-20020aa78656000000b005cc52ea452csm13522773pfo.100.2023.03.28.01.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 01:03:11 -0700 (PDT)
Message-ID: <64229f3f.a70a0220.65aba.9911@mx.google.com>
Date:   Tue, 28 Mar 2023 01:03:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5157485225101380392=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: Split bt_iso_qos into dedicated structures
In-Reply-To: <20230328072545.16876-2-iulia.tanasescu@nxp.com>
References: <20230328072545.16876-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5157485225101380392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734491

---Test result---

Test Summary:
CheckPatch                    PASS      1.94 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      44.08 seconds
CheckAllWarning               PASS      48.31 seconds
CheckSparse                   WARNING   53.70 seconds
CheckSmatch                   WARNING   144.02 seconds
BuildKernel32                 PASS      42.76 seconds
TestRunnerSetup               PASS      607.28 seconds
TestRunner_l2cap-tester       PASS      20.13 seconds
TestRunner_iso-tester         FAIL      19.69 seconds
TestRunner_bnep-tester        PASS      7.10 seconds
TestRunner_mgmt-tester        PASS      132.33 seconds
TestRunner_rfcomm-tester      PASS      11.07 seconds
TestRunner_sco-tester         PASS      10.00 seconds
TestRunner_ioctl-tester       PASS      11.91 seconds
TestRunner_mesh-tester        PASS      8.81 seconds
TestRunner_smp-tester         PASS      9.92 seconds
TestRunner_userchan-tester    PASS      7.40 seconds
IncrementalBuild              PASS      39.77 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_conn.c:2095:18: warning: incorrect type in assignment (different base types)net/bluetooth/hci_conn.c:2095:18:    expected restricted __le16 [usertype] skipnet/bluetooth/hci_conn.c:2095:18:    got unsigned short [usertype] skipnet/bluetooth/hci_conn.c:2096:26: warning: incorrect type in assignment (different base types)net/bluetooth/hci_conn.c:2096:26:    expected restricted __le16 [usertype] sync_timeoutnet/bluetooth/hci_conn.c:2096:26:    got unsigned short [usertype] sync_timeoutnet/bluetooth/hci_conn.c:2126:24: warning: incorrect type in assignment (different base types)net/bluetooth/hci_conn.c:2126:24:    expected restricted __le16 [addressable] [assigned] [usertype] timeoutnet/bluetooth/hci_conn.c:2126:24:    got unsigned short [usertype] timeoutnet/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 57, Passed: 10 (17.5%), Failed: 47, Not Run: 0

Failed Test Cases
Basic ISO Set Socket Option - Success                Failed       0.184 seconds
ISO QoS 8_1_1 - Success                              Failed       0.188 seconds
ISO QoS 8_2_1 - Success                              Failed       0.176 seconds
ISO QoS 16_1_1 - Success                             Failed       0.184 seconds
ISO QoS 16_2_1 - Success                             Failed       0.184 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.192 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.184 seconds
ISO QoS 24_1_1 - Success                             Failed       0.196 seconds
ISO QoS 24_2_1 - Success                             Failed       0.180 seconds
ISO QoS 32_1_1 - Success                             Failed       0.176 seconds
ISO QoS 32_2_1 - Success                             Failed       0.188 seconds
ISO QoS 44_1_1 - Success                             Failed       0.188 seconds
ISO QoS 44_2_1 - Success                             Failed       0.184 seconds
ISO QoS 48_1_1 - Success                             Failed       0.184 seconds
ISO QoS 48_2_1 - Success                             Failed       0.180 seconds
ISO QoS 48_3_1 - Success                             Failed       0.176 seconds
ISO QoS 48_4_1 - Success                             Failed       0.184 seconds
ISO QoS 48_5_1 - Success                             Failed       0.184 seconds
ISO QoS 48_6_1 - Success                             Failed       0.200 seconds
ISO QoS 8_1_2 - Success                              Failed       0.192 seconds
ISO QoS 8_2_2 - Success                              Failed       0.184 seconds
ISO QoS 16_1_2 - Success                             Failed       0.176 seconds
ISO QoS 16_2_2 - Success                             Failed       0.188 seconds
ISO QoS 24_1_2 - Success                             Failed       0.176 seconds
ISO QoS 24_2_2 - Success                             Failed       0.192 seconds
ISO QoS 32_1_2 - Success                             Failed       0.184 seconds
ISO QoS 32_2_2 - Success                             Failed       0.188 seconds
ISO QoS 44_1_2 - Success                             Failed       0.184 seconds
ISO QoS 44_2_2 - Success                             Failed       0.184 seconds
ISO QoS 48_1_2 - Success                             Failed       0.192 seconds
ISO QoS 48_2_2 - Success                             Failed       0.188 seconds
ISO QoS 48_3_2 - Success                             Failed       0.188 seconds
ISO QoS 48_4_2 - Success                             Failed       0.176 seconds
ISO QoS 48_5_2 - Success                             Failed       0.192 seconds
ISO QoS 48_6_2 - Success                             Failed       0.180 seconds
ISO Connect - Reject                                 Failed       0.180 seconds
ISO Connect2 CIG 0x01 - Success                      Failed       0.188 seconds
ISO Send - Success                                   Failed       0.176 seconds
ISO Defer - Success                                  Failed       0.180 seconds
ISO Defer Send - Success                             Failed       0.184 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.188 seconds
ISO Send and Receive - Success                       Failed       0.176 seconds
ISO Disconnect - Success                             Failed       0.172 seconds
ISO Reconnect - Success                              Failed       0.172 seconds
ISO Broadcaster - Success                            Failed       0.180 seconds
ISO Broadcaster BIG 0x01 - Success                   Failed       0.184 seconds
ISO Broadcaster BIG 0x01 BIS 0x01 - Success          Failed       0.188 seconds


---
Regards,
Linux Bluetooth


--===============5157485225101380392==--
