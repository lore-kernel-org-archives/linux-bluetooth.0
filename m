Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B06EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 00:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiCVAea (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiCVAe3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 20:34:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5ED5EDD6
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 17:33:03 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k125so13000060qkf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 17:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Y8BT0zfkXy+WEv6zEYgtYKo5RXFbbkoQf//Vs/XblOo=;
        b=YpHIimqZ0XYuPSw7Gtxw4YNA+gRZJylfrpyWKDuyxTF+tSS1kueG6KuqBhWviWLgrV
         TAjs7SPwBlrw7EXGrrOC6eIQz7UdAoB6hbh3SMEmH53/GgDz6gOxTbpkFxYexJcGKQ49
         4EMnEfnUykR6NJtDISGzwfkm+jyQxgeHfqK/oGK1Fzd5OGbNNBdGEosljJb/0Wb1sl5T
         +jn7OChKASx6rfNkJkQzM+4ne9DceuqtFSPjCnJ66BwbrrtEaIInVbr5xT+NX5UqdY95
         K8U+eyLWC2YLNvYJk/u4MhOpA75R9sRIU/c7cN/Bby50JMiyidQ/IKV1KYgQRxOQnk4+
         eAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Y8BT0zfkXy+WEv6zEYgtYKo5RXFbbkoQf//Vs/XblOo=;
        b=VmqtCb0j+SvM/mvEuo+8OCGMwaHy6sV1kqqxRcMfa12ONRbdHZ44wWml/RqDdhnfh1
         iioHXfuxfCtXtzetBnfXeopSgyyvhWKycFhEd3Vr+Rt9xZkyKtRqpPyxgpOxV34FPR9t
         JAiCx3BMVlIbeizwLfBgQmmXQszAIpmkOTu50mDP64V8cDHz2wvoUfKrzqrVaRFOFKMn
         60n4f7aMHUzDO32UChDO9rUd5PorQ4NU05BaCPDBlJwuzP4L1RTfDjf12kwIm8zb5aGu
         v1CM082JT5lZ44XYi5MXK+evi/TuN5ceYYNYCAifT6zN66kibBqlBInjt4wxEiTXAkmN
         UTHQ==
X-Gm-Message-State: AOAM532MrO5UT+I4H7KV4rpGJG1bduOZt+2tymWTLG9DAWh0TM90uUtu
        NWLWNfpJiz8CW9UKUFnbm6HC6izQcjKvzg==
X-Google-Smtp-Source: ABdhPJwDzKBr2LNBaV67E1MrrxaP3ZjhSn7EAuadtZtJXYC8IYeXJeEoLlEKy9qpcmCKfq1FQmXxwA==
X-Received: by 2002:a05:620a:4450:b0:67c:258e:58d with SMTP id w16-20020a05620a445000b0067c258e058dmr14199623qkp.97.1647909181978;
        Mon, 21 Mar 2022 17:33:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.77.217])
        by smtp.gmail.com with ESMTPSA id f18-20020a05622a105200b002e1eb06ece3sm12578778qte.31.2022.03.21.17.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 17:33:01 -0700 (PDT)
Message-ID: <6239193d.1c69fb81.99c4f.209d@mx.google.com>
Date:   Mon, 21 Mar 2022 17:33:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1053072783660809218=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] att: Log file and function names
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220321205529.2469387-1-luiz.dentz@gmail.com>
References: <20220321205529.2469387-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1053072783660809218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625273

---Test result---

Test Summary:
CheckPatch                    PASS      7.48 seconds
GitLint                       PASS      5.00 seconds
Prep - Setup ELL              PASS      44.76 seconds
Build - Prep                  PASS      0.75 seconds
Build - Configure             PASS      9.00 seconds
Build - Make                  PASS      1526.60 seconds
Make Check                    PASS      11.54 seconds
Make Check w/Valgrind         PASS      461.85 seconds
Make Distcheck                PASS      264.50 seconds
Build w/ext ELL - Configure   PASS      9.28 seconds
Build w/ext ELL - Make        PASS      1521.31 seconds
Incremental Build with patchesPASS      7600.04 seconds



---
Regards,
Linux Bluetooth


--===============1053072783660809218==--
