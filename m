Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C46EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 05:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiFXFtA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFXFs6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 01:48:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D8450B1E
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 22:48:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s185so1464778pgs.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 22:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=TPeSez3gd5Ea0yxZ6QHric9/VM4L7281hrXhSLMsYV8=;
        b=P8IDPZ7zoaaE4kn3+Csg6pAZ0uUhMod5JKXinCI0xrbfWFKHIUz0pYS9elgj/2lu/4
         hSSqdMEBAHsNyUY9eyEpII1JGtf0X6VgYvBL5gMFm9dAhqrxoM5GEmok1iGie2my0a7D
         F+hUJhfoexNT0zAonkloa3y/I5wMOtLMPZ2/6jDXp9R+3kiCi1I+WGt1qpP5OPSVa8vq
         UBfMmrrGED89KynLdHHnPJL07P3RiOMINWc4njmnHnSOvTiIyfgzKs0NydQMVOjIIRur
         QYkI9nP6IkCbcZprLn7Nby4sxVZUGASlqNSZZqJ+fVhgy9ulxHdrn5fu8fGnRosFQ8s2
         Sw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=TPeSez3gd5Ea0yxZ6QHric9/VM4L7281hrXhSLMsYV8=;
        b=xz2h7+MXTIHZjn+wZ4BVBFQ68Luoh1oPXkapn/Ko6qnZHNIf2tPxvwq73bCnqr+IGo
         lw3PKgEF0+6Ql/GyfbXDanxoX3cJtNbBR/hX+qMCYFlljhRuh2wf7o9MxQKCH+33kbBR
         lXQKOqM4/ozsYfmfY6EU2etc6brlLR+Orore9Cp7GSML/tUFd80jQ/2TcwDnuGCgHKC/
         BGbxx25ScAmcrg/6Ose1En4BQnYW3aAQq8I18PDAczeQTZ1l0s84dm+T5wswWJsShlos
         JIvD7WOHotMySeQHL7FQsb9EOThYWj/nl2zsMPrv/zcWaPnMBTDHw7tCA+GmHD5lVnut
         IFHQ==
X-Gm-Message-State: AJIora9NYytX2QuXquNzRrIV1KsdYtnw/GEiUooPHttVxL9TOMO2ZXdC
        q1p26v4FKToifDX8rWh7EIx0Qggr7pM=
X-Google-Smtp-Source: AGRyM1uYFrB0X+/pqXqTkyQccZGxbxMzzOm8VSxAYC5vthkiLX7U5yCWfrYkGW2vEOcgG0/H5Cm5gA==
X-Received: by 2002:a63:7d58:0:b0:40c:995f:2b3d with SMTP id m24-20020a637d58000000b0040c995f2b3dmr10391701pgn.601.1656049737375;
        Thu, 23 Jun 2022 22:48:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.69.63])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b0052534ade61dsm664449pfr.185.2022.06.23.22.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 22:48:55 -0700 (PDT)
Message-ID: <62b55047.1c69fb81.dd665.12f7@mx.google.com>
Date:   Thu, 23 Jun 2022 22:48:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3189551599924234268=="
MIME-Version: 1.0
Subject: RE: Bluetooth: btusb: Add a new VID/PID 0489/e0e2 for MT7922
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, xw897002528@gmail.com
In-Reply-To: <20220624052703.32067-1-xw897002528@gmail.com>
References: <20220624052703.32067-1-xw897002528@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3189551599924234268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/bluetooth/btusb.c:477
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3189551599924234268==--
