Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98834C4332D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4F665088
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbhCPOtH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbhCPOsk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:48:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975C7C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:48:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso1560049pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ocsiq8zq75cw5QfNVEYP8lB4RkOVujvkoshoED15GSI=;
        b=ST6HJM+32KkUYmwSThrlEG4hEQaBZcg7zKCgaPSQHvHS/Z0uf2YSgcKJEPYzoj9sIE
         ASir89RRNAR5o2io4xfeRxgYAhxqChtdJVuNoZgK2ksyPnllzy6E613Iq8Kt8PGLwxrb
         v1lA8KL5jnA63IZXWxSlPyUhdhUlRx9SLZ3HpMKZEY7foz4YpxVeq5FtmNoyS+ckBo48
         WhLC5G+KljyBWWTnpZ9hYgrc6V0pGEia9B7A5lWGnSVJAY7ll9so0wbZtCCr3jzBvqAV
         VP1hFxbdNLci4H8XviMKtDBlZ4uMvTEeobmkFtUDYkgUtmMphwuQ8r1dHTEY8yA+XYPg
         jxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ocsiq8zq75cw5QfNVEYP8lB4RkOVujvkoshoED15GSI=;
        b=t0mxwjm9jSnGaBfKDbSH01WptdRvMWMmfPNMfvvp2Zuwj5KzV0axDaWmnpmgn8Vf2M
         yEbl7MqnFbRUBcqyNP/EFWQ57rYXdA0pEI3j5gdG/MrQ2JWfs2A6bjy9/4CPQvLoKsh0
         yP64sKrc1yZljATJb8ZED3IoPiAakx8B9QYZG/IJX0ROf9voxp8OI/i/J0wy7scISvUu
         xMTCXO0a95aSs8HgKCxqDkPvUDAUcNTvtLrP+0r4z3a9yIZe14qW1yGBkj3L21lP9Lyo
         92UPvMiW1hMW0lE1AdbjcUrXZZepuk0Ij8FKxGFm6K6z0BkmN3p96+l05S4QWPmuWHy+
         7VUg==
X-Gm-Message-State: AOAM5328L+/TKvHS1D6PxQ0ZfdO5O3kePLitaLxGz7GRVN2P2ttmH/u9
        8fd8Lblp8VmgKx1xki71PmTdbhMRzgE=
X-Google-Smtp-Source: ABdhPJxmQDa8+FTpwAnQxXEs81A1//nDNYUNciY1whmz8iIMmi7My6lvOSgKD7PaXDGmn1rmKb5Lvw==
X-Received: by 2002:a17:902:d502:b029:e4:7755:89ad with SMTP id b2-20020a170902d502b02900e4775589admr16738490plg.14.1615906116888;
        Tue, 16 Mar 2021 07:48:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.32.227])
        by smtp.gmail.com with ESMTPSA id h19sm17598892pfc.172.2021.03.16.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:48:36 -0700 (PDT)
Message-ID: <6050c544.1c69fb81.4a472.b2a0@mx.google.com>
Date:   Tue, 16 Mar 2021 07:48:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8126637200532208639=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: adapter: Fix discovery trigger for 0 second delay
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316142627.23692-2-frederic.danis@collabora.com>
References: <20210316142627.23692-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8126637200532208639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=449115

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
src: Replace calls to g_timeout_add_seconds by timeout_add_seconds
3: B6 Body message is missing

plugins: Replace calls to g_timeout_add_seconds by timeout_add_seconds
3: B6 Body message is missing

profiles: Replace calls to g_timeout_add_seconds by timeout_add_seconds
3: B6 Body message is missing


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8126637200532208639==--
