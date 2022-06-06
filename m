Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FBCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jun 2022 14:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiFFOD0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jun 2022 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiFFODX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jun 2022 10:03:23 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453125C1ED
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jun 2022 07:03:22 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y17so11976681ilj.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jun 2022 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=/gFsJknE67k5HHvndvkZmRswaGbAKK0EXtQiNJnEsHs=;
        b=bob33QY0zIg2yRcOjDVlMF7ohlfoWZfLTAL9k1pOzQSOTd6CQ0p5btuF6xkFX8blHF
         VZMWFU4YsDy6aF6taehLIwDGPaR7Nldso4ZzQ4Ck/L5NduorYSOcsMVN+EKElUrsnrVT
         V+SzV79FDT2qGjDPHPqGBn7hj1JUV+CvHxXhpLDT++u/0omHW1cQ+djWJNdMSKE33w6p
         7vZhtCVlZU5GidYiPzOn/pgSNEDuaJZob7FDxFpKOwaBVIcb6Nhib+RbhmsuH8R5OXNy
         mlSvA6CxvfZeS4DWyjeEwT4p4mwjsSqVCoAgGaf/YNdlru1DGxV0X2a7IPSNExtSKQ4s
         LBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=/gFsJknE67k5HHvndvkZmRswaGbAKK0EXtQiNJnEsHs=;
        b=HhP4gNdSjWrhNwQxPVCj7tBcCarFQdgBQ4kd8mxlBdML2zUGV/6PdFAo/wEl5jsadf
         nPE1OOoGFiivQv7ZdPbf1bjyw9EMp3IHax2RCZdSw43IBOnuBvS/PIjgxcHiQeeQ01hp
         uQtoxrkP2i9zpQggncxM79D0o5FhpdE4iPm7cknFuTghIT7divaAaVXP81ExetMB8o3b
         aOflFIJaz2k1J/KDO+XVXwdehD7MHGBEABHyuz7d2Ki6ELOJgflnsWcfQz8FupBq3Ejj
         YtNmpZZpQCVwW5y3tgIzh8wiGPfIw5YVup24pEmQ4X7sLljyg/N+1F3wKZZN2/7XO6Hz
         sHGw==
X-Gm-Message-State: AOAM530AOqHNmM+NIeNNGyXQZ/JMsWIPE8KryyejhHVOAr+qV/4sqUnP
        udjLzcTq1lLfeeX5oLvotCV00OhDWxU=
X-Google-Smtp-Source: ABdhPJwlOKhECmkZDEi4gyXAtNFeLuK8NgwYuUlBVvopzFIyblYSK9VrxMBUbPqIPlbPly/jWVZ2vA==
X-Received: by 2002:a05:6e02:158a:b0:2d3:f1c0:6b68 with SMTP id m10-20020a056e02158a00b002d3f1c06b68mr11838996ilu.38.1654524201647;
        Mon, 06 Jun 2022 07:03:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.46.86])
        by smtp.gmail.com with ESMTPSA id r8-20020a02aa08000000b003314d1acddesm5651475jam.152.2022.06.06.07.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:03:21 -0700 (PDT)
Message-ID: <629e0929.1c69fb81.5d2d0.c993@mx.google.com>
Date:   Mon, 06 Jun 2022 07:03:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0625560437185422099=="
MIME-Version: 1.0
Subject: RE: [-next] Bluetooth: hci_core: Fix error return code in hci_register_dev()
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yangyingliang@huawei.com
In-Reply-To: <20220606134807.4102807-1-yangyingliang@huawei.com>
References: <20220606134807.4102807-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0625560437185422099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_core.c:2646
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0625560437185422099==--
