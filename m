Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC792C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 22:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiBPW5l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:57:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiBPW5k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 17:57:40 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FACA1BAC67
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:57:26 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id bs32so3112059qkb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Hfah5rd32Yu5xB0aufl2cci2ZjEdWzQbMbISU8ysf64=;
        b=CfGQoX/WxloxuP85Ucoqkk/5rheCPsJNC4h/0od/jZe0ek2oa+NpoIMwJSebk/S56u
         XOSxdQWXJP6izuSlP6IUttlQlj0h3cP1vD4kpM+B4/4liEKLwuXcPdnp7+SAzdd/O2ut
         vAiTuSKYtXNoCxx+0J2EjaBj3EzmCsov/xTKCVEbB3dM7jlQoTauH01282OiPwmLd+Jl
         JRJMWB1cepS6o2yfssY+KhIqV0bPZwGw8BnxbaaKw4BJGL9Ynw3Mj7qqvMS84aTIupON
         SVfIhE4VjzuqFmzqO3lsYi552uj/lIiO4txMbF1Wl/evjoPpPZguBI9LrTdePvfAU9cF
         /Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Hfah5rd32Yu5xB0aufl2cci2ZjEdWzQbMbISU8ysf64=;
        b=e9qak1s3r9tMQ3p/aZ3lAm04EnnnhgCtsie8QvI9sa8dW0wQuPcN/uFfQJmVxOg9jh
         JQgU9BnIi2XGjTQcOsBgCyH6LpE/8tsW8ZP8sCSDAWuuSPodYPAFjTczQsqHf+0BBf+m
         A3w5ZskX5svJZVFVer9/1NgYULFuy4o0kgFaniPpkx2PjABa7c3uRTIxBLRfu801FMnp
         sL5LVzTuLfFJ8H8/L6yC+PdQ+nF3ZoUlFizVke15DtRiVaM98/twJYuNZaGstg/S/IUG
         Cn+wcjaq9Jnmzr0hnJ+y9msrjHd+AWx76+CZX7Du82PFFnt7c5FnzdjyeW6IBe4i0vOT
         qabg==
X-Gm-Message-State: AOAM532rQrGOhFuS9eJyPeGrO/Cv9Ez3t9kYAuDsXyWQ4TcXizF9K4iC
        568n/va4BFlOkbYqkyg/Y8Kz0/Dnud9L8A==
X-Google-Smtp-Source: ABdhPJzTXSXN776ezvJU9H+gP7z+GOBRi4/DQ7yJlsPAatEmFl7zZHdVOOh8d4DQ/MidzMY9ZrMJDA==
X-Received: by 2002:a37:e312:0:b0:5e9:57ac:76f5 with SMTP id y18-20020a37e312000000b005e957ac76f5mr67895qki.204.1645052245322;
        Wed, 16 Feb 2022 14:57:25 -0800 (PST)
Received: from [172.17.0.2] ([20.41.26.240])
        by smtp.gmail.com with ESMTPSA id j13sm19973955qko.46.2022.02.16.14.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:57:25 -0800 (PST)
Message-ID: <620d8155.1c69fb81.6c718.0196@mx.google.com>
Date:   Wed, 16 Feb 2022 14:57:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3595100753087754866=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix not using conn_timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220216221822.2694867-1-luiz.dentz@gmail.com>
References: <20220216221822.2694867-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3595100753087754866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615150

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.92 seconds
BuildKernel                   PASS      30.38 seconds
BuildKernel32                 PASS      27.06 seconds
Incremental Build with patchesPASS      36.25 seconds
TestRunner: Setup             PASS      468.40 seconds
TestRunner: l2cap-tester      PASS      15.64 seconds
TestRunner: bnep-tester       PASS      6.13 seconds
TestRunner: mgmt-tester       PASS      102.87 seconds
TestRunner: rfcomm-tester     PASS      7.85 seconds
TestRunner: sco-tester        PASS      7.69 seconds
TestRunner: smp-tester        PASS      7.54 seconds
TestRunner: userchan-tester   PASS      6.35 seconds



---
Regards,
Linux Bluetooth


--===============3595100753087754866==--
