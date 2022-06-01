Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75700C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jun 2022 22:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiFAWjY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jun 2022 18:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiFAWjX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jun 2022 18:39:23 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD47644D7
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jun 2022 15:39:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a10so3204755ioe.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jun 2022 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EqXLixQgtnRFX8PH7h1uma12auczCmVJFEKzm7IfDgw=;
        b=GFNn9ej3/5A8slq6ahp8o2V/OQ+knqZMAUFbqi9DQ6dBUdeUlR5QdL3zDFzCjE6jDi
         eD2vVgQjfzItiod4c0pIPxjXbcrpAfjsK/zA6MbF/EWaRKTbuBR2PPLs1fOlDtx1JeDM
         hB0jAyxTzuDqk5zf+hriozF5zHm0tenhi899Jnsm9XtX6GEjP/onTpkVWOYiXDHezYll
         2hv2QBJioEPSNSwSiAHCAFDhsZxXFSFQuYwqYCBhcVtsqT1bB53015Pb2nXGR73UhPlD
         PSSYIDqDSlNO5j6t7HMMQ6e0tKH26bDcSQD5gHsRRAlLYpD2JKSxsmdKlLDpJKSGCCoE
         o/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EqXLixQgtnRFX8PH7h1uma12auczCmVJFEKzm7IfDgw=;
        b=rCle5BRAasrlLwUKQVekVnnJ+HimmVlIrUoM/9l3FWIOyiu0BOQ5THoeZqyd+E3CzP
         K7m8H+AUJv7G/XS0pXF8SjdiTIJ0bfSuaVGL47fSlKCvu79+dccI6GOD17YxC0+d28sK
         Fl4Taxy2qdbNiQXnLgeSe3+IWKnVLoMHTh8kPVktltMfkd/K+qt989us7i1ezFQe+h8+
         dyONlUBSTucCkbIqWVgRMOhZcgnD+f+Xe0OB1WjyBLFnyz+H9bna8ANrVN3++6H7PH0W
         USbBV1mVW1hQauz7m5oFWz+iq3dzS0ntQWN8W4F1zyUZuvQYqfnKgKGfIo6AiAGEvd6s
         rAKg==
X-Gm-Message-State: AOAM533prjWy5decebRS+ohOR2KbR7W+GgMnkTVrqqZctlujIFRiblkw
        P5DPHxSjQfnm1DUK1N+PdUlZCeMzAIQ=
X-Google-Smtp-Source: ABdhPJz8qWVVj67VXzM/YN1JQcDWcZ8PpRXCkL4A4AkA4juR2lWQw/+mRVvEz8TTE/o1/C4YjpBbWg==
X-Received: by 2002:a05:6602:3c9:b0:65a:f371:a65b with SMTP id g9-20020a05660203c900b0065af371a65bmr1130195iov.21.1654123161422;
        Wed, 01 Jun 2022 15:39:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.105.182])
        by smtp.gmail.com with ESMTPSA id a13-20020a92d34d000000b002d3de4c1ecbsm482065ilh.68.2022.06.01.15.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 15:39:21 -0700 (PDT)
Message-ID: <6297ea99.1c69fb81.af138.2158@mx.google.com>
Date:   Wed, 01 Jun 2022 15:39:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1490470151488292711=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] test-runner: Enable BT_HCIUART and BT_HCIUART_H4
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220601212255.1356507-1-luiz.dentz@gmail.com>
References: <20220601212255.1356507-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1490470151488292711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646685

---Test result---

Test Summary:
CheckPatch                    PASS      1.14 seconds
GitLint                       PASS      0.79 seconds
Prep - Setup ELL              PASS      41.66 seconds
Build - Prep                  PASS      0.60 seconds
Build - Configure             PASS      8.05 seconds
Build - Make                  PASS      1208.89 seconds
Make Check                    PASS      11.86 seconds
Make Check w/Valgrind         PASS      438.43 seconds
Make Distcheck                PASS      226.28 seconds
Build w/ext ELL - Configure   PASS      7.99 seconds
Build w/ext ELL - Make        PASS      1167.79 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1490470151488292711==--
