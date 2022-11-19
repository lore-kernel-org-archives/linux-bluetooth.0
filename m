Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79959C43217
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiKSFCQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiKSFCO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:02:14 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE28BB9DB
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:02:13 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id p18so4848466qkg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F3Igft3JcfgTVWmy0lmxeKnvldaIpmFtCMDF6kEj29A=;
        b=Tm1zpUE+onT+2XsRBpcuCL6Et6KRSLw122abd7phgQgT9vBBYF/EIeXjx16ez6AMkA
         n2BLwyo/AZuZpDkgdcOfPBqAT56E6InouxgxYxTylrKttXMBpfWPHM7Fz3+jhSwirG6K
         3ThwBAk1PW4anziNPisX/C8cqixaWmFsdNsqpr3vEmPwy5Ii/V3mnqchuewnh6C7AmOM
         /cIYlTfLLX5gKbeDVFcCZi5Lh9ZD6uUgVmnu42Y3siFQ/px+FXijpnsRuurQ6Q2BJ3DX
         EH7qeesQVTgNgeyOc8G22t06RmoctDIp1o/uHnuWLxTWuSWlfoVkrjKhlBo9uLnP0FW0
         YX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3Igft3JcfgTVWmy0lmxeKnvldaIpmFtCMDF6kEj29A=;
        b=JqEBsNW7mKOHgqSwsA8ZKmXSuYs8HpsVylQtk69IUykqH8DbnAhekNu3hS9IXxTLYL
         41xdqaq78AcpcMt0GOcpXWxoFQrj4rAqqeQqhSArUhqxT5pqkRfM1VaUUbB8EBFjfxvB
         lm1GOQkC/aW3gERPwOaCnpl51EBded6vaww8HfrgdOfXQBYz8rhy7jyTILD26HuXUvqO
         y3nDEwXSMAYEIQkhYcgZGMUSXC6KRw6czImvwUVJsKq3nPyMLd9s5gpHgOAnWsJtB3qt
         T4ri6nJhWabEMprd5Ei1rOYHiQQQgPPyjfCS9CMXJGa7DaIbuuwV2EIEtG8jmrFnWZwM
         tc4w==
X-Gm-Message-State: ANoB5plewShGxG76KiB/XlUdzep6B1gRjr0l3yHcA+UTXF9fIPDyqbga
        l7nh9tdHD2wA7XBEeTFgXWjBQMKI1aup9Q==
X-Google-Smtp-Source: AA0mqf5GdudhiGyQAbWxM19KaBHE+mW0YbELgCVRPkf3bTMFW63kr8ZYj+VUVJtOUPw4I+dFissYcg==
X-Received: by 2002:a05:620a:4590:b0:6fa:91f9:e54e with SMTP id bp16-20020a05620a459000b006fa91f9e54emr8657245qkb.53.1668834132774;
        Fri, 18 Nov 2022 21:02:12 -0800 (PST)
Received: from [172.17.0.2] ([20.172.200.138])
        by smtp.gmail.com with ESMTPSA id f5-20020a05620a280500b006ce76811a07sm3923335qkp.75.2022.11.18.21.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:02:12 -0800 (PST)
Message-ID: <63786354.050a0220.91b5a.1ba9@mx.google.com>
Date:   Fri, 18 Nov 2022 21:02:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7703769238576392839=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7703769238576392839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.96 seconds
BuildKernel32                 PASS      30.77 seconds
TestRunnerSetup               PASS      424.89 seconds
TestRunner_l2cap-tester       PASS      16.10 seconds
TestRunner_iso-tester         PASS      15.93 seconds
TestRunner_bnep-tester        PASS      5.56 seconds
TestRunner_mgmt-tester        PASS      107.17 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         PASS      8.91 seconds
TestRunner_ioctl-tester       PASS      10.31 seconds
TestRunner_mesh-tester        PASS      7.06 seconds
TestRunner_smp-tester         PASS      8.76 seconds
TestRunner_userchan-tester    PASS      5.85 seconds
IncrementalBuild              PASS      31.77 seconds



---
Regards,
Linux Bluetooth


--===============7703769238576392839==--
