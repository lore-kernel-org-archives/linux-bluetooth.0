Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C02C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 14:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjE3Ohx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjE3Ohw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 10:37:52 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763EC9C
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:37:51 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7606d460da7so110060039f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685457470; x=1688049470;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:mime-version:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Hnjr4+1gAZa7wUgoWmoTCE3SgoYSA068e6UXfAtOWU=;
        b=acJRhxa2xADkEWsbRMRvmRCF9VxNxI8HcjimDHp0r62bN27a2UUSbSkZ3BisbMsRj5
         O7LmEx15+dU8qtAds0AfzRH1v7E5NH4B+bW0c24UPoFHaYuyL8Ia7JYgkD3ZJMhvk9Ue
         pCURKrutu6uzpmdiV7vAdpPur+K2cGG+kB9viQ4nMipxx/gvQGNsLSb8J9/WfchzpC5V
         3/fnqESp6Z7PtjWL1dmCpTybWBHdoItOhoYc6Q5VdZ6LWb3517TVOVizd3invZA3Ghf+
         h0EaXxBhoXpCo7z9dlckD4luV6Yn/VPQTf7rgL7gDDabDkriYkRnnWaTJpmk49bHUEzH
         Trsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457470; x=1688049470;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:mime-version:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hnjr4+1gAZa7wUgoWmoTCE3SgoYSA068e6UXfAtOWU=;
        b=O87viJFQK68h/yFVk7rhudJkvIciWvKXn0tmM9idtdLw19KbkMvEwzdfWugVmuEeWh
         hw8NwWwE6SuyDpVUP597YUtVJ81yEOsn+OvQmm9c0duyt45lwYIlEvHXAo8chrq0ed+F
         54XioZC8vJdwbdrSUAOIHW6KcjJzQ3IfmwCVXRmNXIbp6l2+Ncs6h35ENMrbU3cTXmTO
         w2T3XuRcPFEEpNbcorv/eUWDRReqTNAdqcIKIth+SxQDKWeAGRVcxlQ6LZSVi2tREWhY
         TpGKf7xNNp+rcYFGDqZ8VaVhLvpBoB9ql5pQdIT1Fd38lil1I7u8neRWOK9paaMnQZs1
         lxCg==
X-Gm-Message-State: AC+VfDwY0KhI9/wH28e6+OKsxF8Z8CVgtFqqRdpTJqZcx0ugk8bgLMpp
        1L9e28FkMJbw752HBBsmCKTU9u7YxcQ=
X-Google-Smtp-Source: ACHHUZ7xPlCdXV00M70O0HyNq2kWmrs9QJT7ACzLq0tK5tbBYRGLUuboj7DCigFDYVBqDkw2tg83tg==
X-Received: by 2002:a05:6602:3314:b0:76f:f79e:78aa with SMTP id b20-20020a056602331400b0076ff79e78aamr793043ioz.17.1685457470702;
        Tue, 30 May 2023 07:37:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.50.164])
        by smtp.gmail.com with ESMTPSA id h21-20020a0566380f1500b0041889152a61sm744683jas.97.2023.05.30.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:37:50 -0700 (PDT)
Message-ID: <64760a3e.050a0220.75bd1.1000@mx.google.com>
Date:   Tue, 30 May 2023 07:37:50 -0700 (PDT)
From:   bluez.test.bot@gmail.com
Content-Type: multipart/mixed; boundary="===============0661426631292108982=="
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: [6.3,1/1] bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()
In-Reply-To: <20230530141730.310580-1-dragos.panait@windriver.com>
References: <20230530141730.310580-1-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: [6.2,1/1] bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()
In-Reply-To: <20230530141804.310745-1-dragos.panait@windriver.com>
References: <20230530141804.310745-1-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0661426631292108982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:987
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0661426631292108982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:987
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0661426631292108982==--
