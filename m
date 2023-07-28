Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6003CC0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 14:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjG1Of4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjG1Ofy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 10:35:54 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10713A99
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 07:35:53 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-346129c9512so5037435ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690554953; x=1691159753;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hyoLvY6RK5ve4re0ASoP47ubOHPx2GCVSET3TUOiSrg=;
        b=mA0So3jN8Zq80ew9m9OkTe8f1bsHFdIODK9ZqE6PMecQayNzmrWZVdTHB1JMt71H4Z
         srFYQZb9pYWKGbZzqiwbNQFia/SUOrZxrvaFOHzB877AghXjooz7sJ97DW2kRUEVk3ZU
         DkyAtyOIt4Dk3buJk/dUEuKv6AFClV3T/Xu62JjHg60ZnQp39TUwSAahiQkSJaLtDUFa
         IHbgTfExeOlbIGFAY2OurLOC4hjgy64W0zzAC5SKlgNWsPgMjtH2499+cRw9yeeWXi12
         CKJqUnWkm2qHohevBWG4dJCDUsrItRYU6dvqLZg3f7dQk+vAdXd5xuIz5iLetLk/N8L/
         Po4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554953; x=1691159753;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyoLvY6RK5ve4re0ASoP47ubOHPx2GCVSET3TUOiSrg=;
        b=ScUjQAX05n9ONFl4/otxLvqxkQB0y2dxpIc9JJCqi+ysMHzO+CVjucihOkEUB8D5zg
         txwxaz3s98vi+UlNfxHuclWWQSNdsTr/bY/7Y9RFAPmqvKJoa4QLh1Va/SE5dvYjsQVl
         NepzazUhB4E0qvv3IKLcKsVJvJ1tCNUsaJNDuJ9DXx5JpyV1ZXMmbZyPLZJ/oYhqklss
         m8CBEByIOXSXm+wbDq8dxVYUEC5YOIx98Vt9yOaE9560fP0j6RVzfq+47TGTnOEyYkRL
         E7CALPQEYzYNf9QpnLzHKlVpi+WEp4nPOP+qAIUMBlAyvaWdWxNsPBzHq6VJhU2FeEf7
         imMQ==
X-Gm-Message-State: ABy/qLZE7OLHXw0vNSTngmcx1n0zSvfKNy2ND7j9f/ZpMrlX8mbrtXVf
        M7Ww0pXsb3GKZmTbiD92yE2ub48CtKM=
X-Google-Smtp-Source: APBJJlH4nbix3hWBIGRQFjCzkvPsg9IrM+vTlbekXYPcwwLENebFYM1q5i58kTDML+0FcyvzSxza+Q==
X-Received: by 2002:a05:6e02:188c:b0:348:db55:28f1 with SMTP id o12-20020a056e02188c00b00348db5528f1mr6335287ilu.11.1690554953068;
        Fri, 28 Jul 2023 07:35:53 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.243.247])
        by smtp.gmail.com with ESMTPSA id u20-20020a02c054000000b0042b4f9ddecasm1137663jam.85.2023.07.28.07.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:35:52 -0700 (PDT)
Message-ID: <64c3d248.020a0220.a7eb2.1fbc@mx.google.com>
Date:   Fri, 28 Jul 2023 07:35:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4165768642806742116=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yuehaibing@huawei.com
Subject: RE: [-next] Bluetooth: Remove unused declaration hci_req_prepare_suspend()
In-Reply-To: <20230728133603.35112-1-yuehaibing@huawei.com>
References: <20230728133603.35112-1-yuehaibing@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4165768642806742116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770584

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.62 seconds
CheckAllWarning               PASS      36.45 seconds
CheckSparse                   PASS      41.65 seconds
CheckSmatch                   PASS      113.07 seconds
BuildKernel32                 PASS      32.31 seconds
TestRunnerSetup               PASS      498.38 seconds
TestRunner_l2cap-tester       PASS      23.29 seconds
TestRunner_iso-tester         PASS      44.71 seconds
TestRunner_bnep-tester        PASS      10.85 seconds
TestRunner_mgmt-tester        PASS      220.58 seconds
TestRunner_rfcomm-tester      PASS      16.17 seconds
TestRunner_sco-tester         PASS      17.05 seconds
TestRunner_ioctl-tester       PASS      18.11 seconds
TestRunner_mesh-tester        PASS      13.55 seconds
TestRunner_smp-tester         PASS      14.84 seconds
TestRunner_userchan-tester    PASS      11.47 seconds
IncrementalBuild              PASS      31.35 seconds



---
Regards,
Linux Bluetooth


--===============4165768642806742116==--
