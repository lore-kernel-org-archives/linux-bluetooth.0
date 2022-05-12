Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC71C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 22:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359020AbiELWBb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348898AbiELWB3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 18:01:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4657F6222A
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:01:28 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id w3so5839314qkb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WQ2O4rtfSE0+nfVvOT6o7WBA7FT7qC1hINZ/Yf5a+zA=;
        b=gdbaBF1fabrNt5gZx9gyf29EqdURE84WDnSkg+zEX2x4w1Z+mxhE2wOjEDbB8MNOe8
         waFWFpf2PLoi3gJHs6thQX0RDSEdylpF3YNrZC7G0wbaAw4thnGhHSDXXU56k8CNsaDs
         +StAY7U8f3pj85r95kNqhmcbvZTj5+5HX44rG8jcQhFaUzXjTx8eHxAa65fD3R5oztIm
         TBPhOf7IfEzPvfPleW9PgL11gv642pjfY9gyN3f45gmFddzYPA5pVU0i/m8moK6LSLuv
         dtoKr0W9VKvvx28Rs8tbpwDoGR10bu0h8oGmMOG1yrHxgz1fvtkdTt6HABc2XkmF029Z
         W6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WQ2O4rtfSE0+nfVvOT6o7WBA7FT7qC1hINZ/Yf5a+zA=;
        b=upxYYNqKIDOi6CtaU4y6sPwsVwhggUZeYu1A8LICqg5PWk3fTE9NZxHqi1hlrrtzw5
         6gfRI6wDeu+vzRWhfZ9eqdNl/mGAKAlFV5Cl/sJpNkl+gVuO1XKMN7ARa4B8148QlE+O
         dinKK+bcvaUmbnDxBnMNtjAThteAiL/Fbtr35gHdZ07tWpHb+/yDTYf4a0TcG5QMqR53
         naxIMjW78X+2Hyk0KfIT4ioK9OAVcvI+9Yz1uE55yyhmMVAcrAo3D5IgpNzSB1sx+hZ8
         9ywuf4sxF9wZpFsooUAefRidVjMeZSKpV9akfQDbAzUG3WQemkhbPNlzMzG7c/8xpWOi
         udDA==
X-Gm-Message-State: AOAM533dpSmCZKkOXabxghUBaXeJvU4nN3UqrMWh6Vdsx7WROwQbLyVF
        wI36y60oesgbr9JbIz/5JOyslH/fJKs=
X-Google-Smtp-Source: ABdhPJyikVzhXa7R/BxKMYpTlcfWjWEyx1jYBIUdIUyWW23juoV8+0LCc2+raDuWT/aBulm3Rc9aBA==
X-Received: by 2002:a37:a4c5:0:b0:69f:dde1:89c0 with SMTP id n188-20020a37a4c5000000b0069fdde189c0mr1690691qke.178.1652392887165;
        Thu, 12 May 2022 15:01:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.96.98])
        by smtp.gmail.com with ESMTPSA id r144-20020a37a896000000b0069ff8ebec64sm376502qke.103.2022.05.12.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 15:01:26 -0700 (PDT)
Message-ID: <627d83b6.1c69fb81.adfe1.271b@mx.google.com>
Date:   Thu, 12 May 2022 15:01:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7219908043503552656=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [1/2] Bluetooth: btmtksdio: fix the reset takes too long
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <e26167a3fcefdeae1151162e8676c9a467a8100d.1652390894.git.objelf@gmail.com>
References: <e26167a3fcefdeae1151162e8676c9a467a8100d.1652390894.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7219908043503552656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641161

---Test result---

Test Summary:
CheckPatch                    PASS      3.34 seconds
GitLint                       PASS      2.14 seconds
SubjectPrefix                 PASS      1.72 seconds
BuildKernel                   PASS      30.44 seconds
BuildKernel32                 PASS      30.25 seconds
Incremental Build with patchesPASS      45.84 seconds
TestRunner: Setup             PASS      493.42 seconds
TestRunner: l2cap-tester      PASS      17.46 seconds
TestRunner: bnep-tester       PASS      6.12 seconds
TestRunner: mgmt-tester       PASS      106.15 seconds
TestRunner: rfcomm-tester     PASS      9.66 seconds
TestRunner: sco-tester        PASS      9.65 seconds
TestRunner: smp-tester        PASS      10.44 seconds
TestRunner: userchan-tester   PASS      7.15 seconds



---
Regards,
Linux Bluetooth


--===============7219908043503552656==--
