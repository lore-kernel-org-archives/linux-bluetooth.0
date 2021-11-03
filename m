Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC1FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 17:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB060F58
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 17:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhKCRsh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhKCRsZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 13:48:25 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B9C06120B
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 10:45:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id om14so1789521pjb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Nov 2021 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ii83+DHe6HlRNsKYfq+c0Z3BZ6cWA7+o+awBm6fG3AE=;
        b=nJ1imoSGEIPwBIU1cp4JhiNbV8UEr81Gok1hRm0H75ST8y6p69q2selH9xTz2tkGji
         lM7SvlDI1sGRo62zXTi5J01YcuEyx8G5bCa2i2DOue13VygbfRBafkw+NpMpiRl39Kgq
         jOdaeBfQVt74Fdm/q/p4h105GbLHxEcqnG5IwhP4qhlo7yTxn6RfKZ2vzZHFPXdIpXpf
         djVinl0C7/9F5YayCT6728QDs9kChODT7SDFHxRYwckyo3ymtqjX5+eBXykFBWkmsBnP
         md0gMTKsAeszAeLjV6DRkY87w8D04SqQz7yju+UY+M6TTl4dPt40pzL6dG7bNXzxqz85
         yxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ii83+DHe6HlRNsKYfq+c0Z3BZ6cWA7+o+awBm6fG3AE=;
        b=y9Jdrh6r2jjvftfVCu0vHIuQhZLrOHT6qQc58IJPw0zsbqJUaxIymmex9MHD5yVWXS
         TgnC9+pde3TXb92dHKhNajF0rZm0yE/iAEGS5NKP4dCMaEdAcEE7Gdb4cAP7otCWGjNz
         FM9pg1GzAvEh6z1wCDCAAUltuddjbpBgK0fUL2jM1ujZMKmaQal2HAkYwVuLhZaQ2xwY
         3POfmTEUAuUX5ahO2tnetZCUpGYt55wjSM03Mxe0uj4MsytSE/eSOpRR8qK/96n+IFwt
         /7cSxuC9VzMA5MxcqGGlvY4cxYegg9xqFEhUbVy+nOKYER9oaTdQ1WafdlC+SuDnzBmJ
         yQyA==
X-Gm-Message-State: AOAM532BIr1qxVslMt/17zMvOa1U8gBiejBYmSNYSAlUZFcfyQRwofy5
        Y2SbGMKy39Hr/vADKwmJFTNZZ4Rf89E=
X-Google-Smtp-Source: ABdhPJxIBe3pBJBD+pxWuRE8SwRpI1+dCaqWHexoFhZfQdUq448r8802FU9Uz8sdStta3PAZzlyxQA==
X-Received: by 2002:a17:902:b097:b0:141:ec7d:a055 with SMTP id p23-20020a170902b09700b00141ec7da055mr20020839plr.3.1635961547555;
        Wed, 03 Nov 2021 10:45:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.112.94.170])
        by smtp.gmail.com with ESMTPSA id p9sm2904799pfn.7.2021.11.03.10.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:45:47 -0700 (PDT)
Message-ID: <6182cacb.1c69fb81.7541.9135@mx.google.com>
Date:   Wed, 03 Nov 2021 10:45:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0459110713513536903=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] btdev: Add support for LE Set Privacy mode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211102054952.2898328-1-luiz.dentz@gmail.com>
References: <20211102054952.2898328-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0459110713513536903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=573885

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.56 seconds
Prep - Setup ELL              PASS      39.92 seconds
Build - Prep                  PASS      0.18 seconds
Build - Configure             PASS      7.64 seconds
Build - Make                  PASS      168.24 seconds
Make Check                    PASS      9.04 seconds
Make Distcheck                PASS      204.89 seconds
Build w/ext ELL - Configure   PASS      7.26 seconds
Build w/ext ELL - Make        PASS      157.88 seconds



---
Regards,
Linux Bluetooth


--===============0459110713513536903==--
