Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65F7C6FD20
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjCXVia (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCXVi3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 17:38:29 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99F3C0B
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 14:38:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id qh28so2560229qvb.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679693907;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NRYiEuCufBCl7qehY78aU7pl1dvqyHxFrmo+xAca9VM=;
        b=d56IeGYpHB1dKlnoWkJ+RrMinhBqFjApGs0h7trqXgi7Of4/b4ajscemKqj7pD/v3P
         5cjkaXGlFp/ZyVf8yRcDH17x93SgRDGdLUgEQYx8jDOlA5tn99QE1r+reiKNwK4F7KdY
         z0yyg0eIn+RjaIW5ye+73ZGxxUYgEISYPVyKR1mrHUsxWTPq01BwfXLvoDSaiPdBjTuY
         wPo2MqUmmsB8/bkW0TgMgWGezb+jyaBU+7oH6lGOwRJ7w8CP0S5tOaPUPIaM5UJa+EZa
         08jV8QrcGkxn5BE/OWfWGlOn2Y4mSsMNDw5fkB32GBmv4AV0nT0du7b1ySf9Aec41S5+
         m5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693907;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRYiEuCufBCl7qehY78aU7pl1dvqyHxFrmo+xAca9VM=;
        b=UIhyxybdC2HdmE8tUQZ21ki1NioAM1sZ8m7rz/VpmW0leZzh2YvSa3o6ChFScMl5IM
         zhwsIT7c6vq0tUarI2FC1Mjq1Y+o3RohfRhWRc7cNCRUOLS5bdM1Zl3F/VrUnaEDS1/w
         a1x7mSETthyJSDtGBhl2UoxEYlncqedfhuuY45aqRDIdME0L/GGOvT5PQKolWtrw0Ns9
         K5Z3ructOfdXIkPLd6SX/UzR0XjXSiOjLU1gekjV7tjNUGOyLTm5VAFNDjK2TwmCMgs6
         f21jEfvOpmPOHT3Yu+EATL4C6mVuXgwAKcRxEuMu0SBeRW3FPpbgdx/9ZHn7ctx/oCGN
         Mryg==
X-Gm-Message-State: AAQBX9dyXAmfUTaqwNA9Rr7HrHtBRQaIXfuXj906b9tDhi36bp+sMI1m
        1z7TLa4RgiMNgllq4eW+4a8/QB4gFNA=
X-Google-Smtp-Source: AKy350YdVP3loYvr7vWNidWHgF4B6sJL7Wnov54OTzix2BhmBQSSmDzXzzJa3StM9JwGawduopWkdQ==
X-Received: by 2002:a05:6214:1c81:b0:5cc:97fa:eec9 with SMTP id ib1-20020a0562141c8100b005cc97faeec9mr6616510qvb.25.1679693907054;
        Fri, 24 Mar 2023 14:38:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.24])
        by smtp.gmail.com with ESMTPSA id do8-20020a056214096800b005dd8b9345dasm996774qvb.114.2023.03.24.14.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 14:38:26 -0700 (PDT)
Message-ID: <641e1852.050a0220.7005f.4da5@mx.google.com>
Date:   Fri, 24 Mar 2023 14:38:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7194111756637748026=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: hci_conn: Fix not cleaning up on LE Connection failure
In-Reply-To: <20230324204525.3630188-1-luiz.dentz@gmail.com>
References: <20230324204525.3630188-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7194111756637748026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733699

---Test result---

Test Summary:
CheckPatch                    PASS      2.34 seconds
GitLint                       PASS      0.77 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      44.46 seconds
CheckAllWarning               PASS      48.86 seconds
CheckSparse                   WARNING   55.16 seconds
CheckSmatch                   WARNING   146.37 seconds
BuildKernel32                 PASS      43.09 seconds
TestRunnerSetup               PASS      612.31 seconds
TestRunner_l2cap-tester       PASS      20.91 seconds
TestRunner_iso-tester         PASS      22.25 seconds
TestRunner_bnep-tester        PASS      7.47 seconds
TestRunner_mgmt-tester        PASS      136.93 seconds
TestRunner_rfcomm-tester      PASS      11.60 seconds
TestRunner_sco-tester         PASS      10.57 seconds
TestRunner_ioctl-tester       PASS      12.56 seconds
TestRunner_mesh-tester        PASS      9.31 seconds
TestRunner_smp-tester         PASS      10.44 seconds
TestRunner_userchan-tester    PASS      7.80 seconds
IncrementalBuild              PASS      76.85 seconds

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


---
Regards,
Linux Bluetooth


--===============7194111756637748026==--
