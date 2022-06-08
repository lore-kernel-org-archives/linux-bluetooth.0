Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 14:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbiFHOGP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240837AbiFHOGN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 10:06:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6B3C502C
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 07:06:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j8so12186725qtn.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jun 2022 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=kDCmYnl+Ne9rGpu9HNac7QC8rLeiU1sCjSGvhdFDDWg=;
        b=Tj29mKytBOmCr24zvDWFksgArk/yH6Nx2/yqrsQd2GavdWQR3Pj+iF+Ui6kLXU4Dqw
         LQLePpKqNnrt5f6z2BFbYY8NYQJ9UP+Xo3LqpWmK913pn47JXFqIFkUhgAzLywXswtGF
         4IVJrYHKzvnAIt39/URRmAiXAxsvHodTi6EYXBH3PHqL84YgYGfXyi4z4dJ+rBYnNLsb
         S0jy5ohk6vM/5wBpXOQ0cru2Q3NsZZyF3dtN1b6bUUr/OZCvOi+c/V5WHwVqI6D2jZVS
         vP4jbrUT5mz4iruu9pZK6yuF5eb7IaOtsiyKJuTlTkiLIs6Ei+WK7rFe337QGhG6FGkZ
         FNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=kDCmYnl+Ne9rGpu9HNac7QC8rLeiU1sCjSGvhdFDDWg=;
        b=CItuerJmHwIDiOIiaYB7cceeXCLdZpE2BWlF2TAGJ6nEPtsMVMlaEOMEf35bjvgUT3
         GQZQ4hDWYe9qnE0TRzeET9Lxt7Gg0rEK0FeRlIlFIcCQnDApr/80bZaxhlPxSvv8/aiQ
         7mlAwjNXcaEHtBgPaLUKBje64/AFIGSDuNXVo8g4q+STwPcJWQwoFjLVXNX9dDBvnLyx
         h4Yo5xcoha2BXaQK7EbaFYFJUccuazn9BbIOVVW7AJxv2A2/aLpuuOsvETyeEGgYL35a
         FEiAuobBB9V89jTjVEto9qkUPI0ml0fv1ks2xmTaVcMoUQkbLVOLlHOGlvpPK0YZ24MW
         Dctw==
X-Gm-Message-State: AOAM530v0TF/Gxne1UcOSHwFJ58F8CYzUqpzz/wMkvsw8vAEynSgvrZc
        Z7ni8P5LdMGAwvsESdN6NPzgI/Of8A9ZcQ==
X-Google-Smtp-Source: ABdhPJyjrUePk8+nwdtv0h7iGVJR7LjBrzHUChgoDP+5zRLRxOqwAKwsnNqviMtJedPJtpa9wxOkMQ==
X-Received: by 2002:ac8:5e12:0:b0:2f3:b9cb:887b with SMTP id h18-20020ac85e12000000b002f3b9cb887bmr27656617qtx.184.1654697170072;
        Wed, 08 Jun 2022 07:06:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.83.70])
        by smtp.gmail.com with ESMTPSA id m3-20020a375803000000b006a3696c4739sm16275008qkb.19.2022.06.08.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:06:08 -0700 (PDT)
Message-ID: <62a0acd0.1c69fb81.7a08f.ac8f@mx.google.com>
Date:   Wed, 08 Jun 2022 07:06:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7883502132874270896=="
MIME-Version: 1.0
Subject: RE: Bluetooth: fix an error code in hci_register_dev()
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@oracle.com
In-Reply-To: <YqCoJXuRV8MIDS2M@kili>
References: <YqCoJXuRV8MIDS2M@kili>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7883502132874270896==
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


--===============7883502132874270896==--
