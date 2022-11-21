Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 19:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKUTjK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKUTjJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 14:39:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7C6FCE4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 11:39:08 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id w4so7991325qts.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 11:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFvOxIbP8uXV+8ZMqw3Q666qy47mMuK4Zf0O9tWPqzY=;
        b=Y39QwFxyX/7iRBzjHLEWWWjcvuX3zSK8/IucrBarZwFjWow0he3z4zReSaQDTG/hYc
         NSo5pPvpeYNTJeGjrDj/QaJ7DiaZf2FmTC2nbxwSMnhezMO8ViExmXrLMyN/ZMnc1MF/
         baTslUMEwkh1pDOaXx8/THE85qvfDtOmSmXvUv0jZhtNXF5KYo1M9AyllLdoqXiiDTfQ
         SAAyoVCGrUwvthZeA29aLARW+vLaBXSPtixEoJn1HpmNDy1kHuxXZ/54ZYiEa4X9Q5wc
         zEXKtgrNRXec6TZOou+q75BVDPxpHoUvZOLob0Vx9XErGte0s1YDlZhx7uJE8rJvkzfz
         2huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFvOxIbP8uXV+8ZMqw3Q666qy47mMuK4Zf0O9tWPqzY=;
        b=a9FfIf09UMB6s8GkiiIugUsxPSWfOUeNnHZs1QxRYU4HpiF01fb0YCL9TlnuBYF7M0
         O6QEH/qBWQbFRdjgKCj7U2rH3bAFrHixZQ/CdXqN9wEs8mAPxPl1a7I8bO+WQdWvR7SM
         ompUUKH9+No34F32atybUfKpgLja0EcYiFP8i6uyeRif8vcFkX3z+bAjkN2J6CVQQNKo
         R9Vat7WDsxlxrZzMDZ13kE2LfJ5o05JufknrNxrAEEYzWiYHyPquXuIx6F4XFCcnVXK0
         FyCWCXky9EY0C0x6Pn1/crHdSbtG9fymSVnir9K2XkelAS3c99Q0Vb7YsSzY2aPLf3tZ
         yFXA==
X-Gm-Message-State: ANoB5pmAiiGUJ8CGbeQgIj8fSam4RcshNbgssLb5hShB6RsMzEbZgjKD
        iPzPAZaxSQABVUmsdVBelZJ2bEY7kzC8DQ==
X-Google-Smtp-Source: AA0mqf7mVRLcOrh9XWLGhwAu+dpVKwi+9mAMkqwnh5llAkOKtcKCaktXC3iYU/BAzc7iqYlNQi+y1Q==
X-Received: by 2002:a05:622a:4117:b0:3a5:9be8:59f2 with SMTP id cc23-20020a05622a411700b003a59be859f2mr18703958qtb.297.1669059546196;
        Mon, 21 Nov 2022 11:39:06 -0800 (PST)
Received: from [172.17.0.2] ([20.119.195.20])
        by smtp.gmail.com with ESMTPSA id u20-20020a05620a0c5400b006cf8fc6e922sm8763378qki.119.2022.11.21.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 11:39:05 -0800 (PST)
Message-ID: <637bd3d9.050a0220.2d7f0.e6ea@mx.google.com>
Date:   Mon, 21 Nov 2022 11:39:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2810696396331900548=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v3,1/3] Bluetooth: btusb: mediatek: use readx_poll_timeout instead of open coding
In-Reply-To: <caf41c6a33b1ceeb36ec7261b0cc894082352c46.1669057170.git.objelf@gmail.com>
References: <caf41c6a33b1ceeb36ec7261b0cc894082352c46.1669057170.git.objelf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2810696396331900548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:3845
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2810696396331900548==--
