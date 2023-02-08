Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79200C05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Feb 2023 06:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBHGRu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 01:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHGRt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 01:17:49 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780D823861
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Feb 2023 22:17:48 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id cr22so19683496qtb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Feb 2023 22:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RBQgD7aXFFCKlL0zyK3IxesO7JDnr5g4ZfhF4q/mZLw=;
        b=XxHtSK7c5dhe+/Wonsfk/1S5dNLvVQa0AEiTKEQu7yoCLbAN4fxjSc4tri54Plrqkq
         gPPwYFvilflqqIsSzmwxnOqsXFgNzKqIvI/vRxST86LcFz6W4Kv/fDYFZ+IyMwL8MgYq
         uyTD/O87DNEVRYC8+cIo+pgVETKK6GcisGj7BnFh9hselv7R3D8JFNpGrsCiQLEdBjie
         cqzNzlR7MgD5MZPUzDISZ9Jy3sDDn3RUNeo21XfLadJi7vWoehg2FuZhTEAvuMGRuRX1
         jX0vjyUbSyuvvN+Zb8efD2XEQXXH8uYwTEJ19Pl50mlu/+6KNctUqOtvHVU7lIh8HckE
         zE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBQgD7aXFFCKlL0zyK3IxesO7JDnr5g4ZfhF4q/mZLw=;
        b=kQH+27pcrBb7MUDwIkUiXWp/DZU4osesLUolrM+82TyzxX7Jc6kD1oU42oCnA6J/4x
         KWDJPg7q7OpC0Tq3KDD4scuvZooFLYITOupDkWRj/knWSvRojd0R9fQ7EGsBj1xPztpu
         6QGUBKme6iiPxIniIp6mYEJdRQMOsX3gUPo+drZ/q/BJ+n1tfR4QBhfQaGoMpacJuln0
         HXH/3PVGFCu0wNcS/xrozZ7rkDQvsZ2SATSv9wmEypQwf4opRovWS59xzj0cJx0nXMNS
         M7wnZZBQwZyOo/csWx5GTHljlI1xihH3OgaaJHwmS0VX+TGWTkcWpiIRX5KG+pMUnizf
         OmVA==
X-Gm-Message-State: AO0yUKX+VUmB1XARIBJNTg5VKKEWlTnlqICX8xtCzEA5ksVtDAHoJHNg
        eutJbRsgTtb7XDrHI/o4KTtMSKdI9FU=
X-Google-Smtp-Source: AK7set8BWf6k9saVNg3KQ8p5XzJYRLaycm/4siJ7tBZzS/qxGBXpjP1JTfyjJUypQyW16mcpRPBsKA==
X-Received: by 2002:a05:622a:4399:b0:3b9:bc8c:c214 with SMTP id em25-20020a05622a439900b003b9bc8cc214mr21031572qtb.31.1675837067503;
        Tue, 07 Feb 2023 22:17:47 -0800 (PST)
Received: from [172.17.0.2] ([20.185.156.81])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a410600b0070383f1b6f1sm10879841qko.31.2023.02.07.22.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 22:17:47 -0800 (PST)
Message-ID: <63e33e8b.050a0220.1a683.12bc@mx.google.com>
Date:   Tue, 07 Feb 2023 22:17:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6015701228106689303=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, herbert@gondor.apana.org.au
Subject: RE: [v2,10/17] crypto: api - Use data directly in completion function
In-Reply-To: <Y+M6FDVFcXRNQtwi@gondor.apana.org.au>
References: <Y+M6FDVFcXRNQtwi@gondor.apana.org.au>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6015701228106689303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: crypto/ahash.c:240
error: crypto/ahash.c: patch does not apply
error: patch failed: crypto/cryptd.c:285
error: crypto/cryptd.c: patch does not apply
error: patch failed: crypto/essiv.c:166
error: crypto/essiv.c: patch does not apply
error: patch failed: crypto/rsa-pkcs1pad.c:210
error: crypto/rsa-pkcs1pad.c: patch does not apply
error: patch failed: include/crypto/algapi.h:305
error: include/crypto/algapi.h: patch does not apply
error: patch failed: include/linux/crypto.h:176
error: include/linux/crypto.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6015701228106689303==--
