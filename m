Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99842EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jun 2023 19:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFVT6i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jun 2023 15:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjFVT6f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jun 2023 15:58:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8E1BF0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 12:58:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9b4a656deso65481041cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jun 2023 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687463913; x=1690055913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6acH81n4xJFIOExd9fcr1IsdKKmeivPgCIa+79+YfRU=;
        b=Ms7Yq5aZ24nI2bD73PnmSZ3ivUGKBen16y77bNht4peCw5pwIDzAVlsR7nK2SwOdkU
         nKSoMsWYc13IXJi0cGP2l0efufaX3yiXm8d7Z1kQOW41wCzAj5jOro1Eb+oh6eOacBKG
         mr4B+m3bGzQ1E5PajxaZJHDveddjfJ3QP+agt0eo4Qrz/iJ6LpryXLRIGPooz0QxHfUt
         cS813t6eWkwDvyvy64lThP1BjfuIu2uCBRB+ti9TZtD4eSFatXWJo/A/XMiYlNeb2WeO
         BgFYlJxtOCO30opHQrVdHphRPIND76pxRm9EZpFdnE6LkDE86QzmpXq3nWGZysKxsD0F
         Zybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687463913; x=1690055913;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6acH81n4xJFIOExd9fcr1IsdKKmeivPgCIa+79+YfRU=;
        b=X5aDMccEmu4VAJlh5mL2BSaPEITchNziMNuE4NI16YMq3b5wuMtOERZEhFOvGloF5l
         Rw8OT1LYAAe+QrW3WITYN/pwJENZ65v2OwfmEQ8ImMFotGgQQLQqnqDda4ZriiS01eDi
         E4wgUZ7tyoE1b1O91cvpglKYzywsHj6yhoZJ+GjJvuKb6TXD3jLqKWzZEkhUANGwK5fx
         /g9q8gLZVxtLjNsxJwbC+n5ORJGoqteqvKmZqE+1TZxqffb28RrdoQQp0aXHj26AFxUl
         xy3P0VN0uM3vQnO07qC2dQvYmgQhH9Y4t4j7lmVNl0/wL7q8+VL2faEMbE5ih9L98AIK
         i0Qw==
X-Gm-Message-State: AC+VfDylJkmTrT9b1bWjyls2+t7hOSD3MGJJlKXnnzSxdSOpgjgvtKdx
        M0qXeO+s/6EiNUCIrm6aoYanyvBiErM=
X-Google-Smtp-Source: ACHHUZ47f7hWDyIM15fObQJXaWD/4YZKH43n84UDUnNSTg0Xbz7uJWB4wxjNg7AQVTCI7U8Rn+HNKw==
X-Received: by 2002:ac8:5f95:0:b0:3fd:e5dc:adbb with SMTP id j21-20020ac85f95000000b003fde5dcadbbmr18363826qta.9.1687463913083;
        Thu, 22 Jun 2023 12:58:33 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.123.244])
        by smtp.gmail.com with ESMTPSA id v6-20020ac85786000000b003f7369c7302sm3978668qta.89.2023.06.22.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:58:32 -0700 (PDT)
Message-ID: <6494a7e8.c80a0220.56266.d4ac@mx.google.com>
Date:   Thu, 22 Jun 2023 12:58:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5939175498217142723=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: hci_event: Fix parsing of CIS Established Event
In-Reply-To: <20230622192722.1248374-1-luiz.dentz@gmail.com>
References: <20230622192722.1248374-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5939175498217142723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759615

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      34.35 seconds
CheckAllWarning               PASS      37.12 seconds
CheckSparse                   WARNING   42.75 seconds
CheckSmatch                   WARNING   114.46 seconds
BuildKernel32                 PASS      33.19 seconds
TestRunnerSetup               PASS      473.71 seconds
TestRunner_l2cap-tester       PASS      18.21 seconds
TestRunner_iso-tester         FAIL      25.78 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        PASS      138.21 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         PASS      8.90 seconds
TestRunner_ioctl-tester       PASS      10.30 seconds
TestRunner_mesh-tester        PASS      7.63 seconds
TestRunner_smp-tester         PASS      8.79 seconds
TestRunner_userchan-tester    PASS      6.43 seconds
IncrementalBuild              PASS      31.64 seconds

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
Total: 80, Passed: 75 (93.8%), Failed: 5, Not Run: 0

Failed Test Cases
ISO QoS 8_1_1 - Success                              Failed       1.142 seconds
ISO QoS 16_1_1 - Success                             Failed       0.227 seconds
ISO QoS 24_1_1 - Success                             Failed       0.228 seconds
ISO QoS 32_1_1 - Success                             Failed       0.224 seconds
ISO QoS 44_1_1 - Success                             Failed       0.243 seconds


---
Regards,
Linux Bluetooth


--===============5939175498217142723==--
