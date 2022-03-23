Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFA0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbiCWWZI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239488AbiCWWZI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:25:08 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324186E29B
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:23:33 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id k7so2399892qvc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wNGqnvIFxYHfY1tznP+q4blzTjyLh2WoLB7gTwKbd6o=;
        b=jrCOg5WCOk4XzCsKPMHJk67RZIi2r9i/Jqdr3g3mZ2Q6RlZrKx8WIyPxrisluuvmIW
         vYxsWICpUq7vZL8Fw5k2lmS++OPFA/OiRn8z9rNex0161Q4O0/CpS1wO69ZUFnl4aXP1
         AMkTZ8QrVIHWGrpBKqpnzGLi5OeuQ86F+mG+9sCV/6yPqYrP+amo0lofcJeGoM3ONSov
         0H8C66bqEThtLjtjJuZMiUh5PK8JA8ymt9ruboUUA/mO9+YA+b0ank8Z+uyVaVcL7zyT
         lKooAwypmAWxLoCHLFVrVtTdeZetwEALhCN2Xufb94xwCT8llaC4hDXNbxaClRdno/E5
         uXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wNGqnvIFxYHfY1tznP+q4blzTjyLh2WoLB7gTwKbd6o=;
        b=vly9Eh4Rjz8CJ71dxZL2wSqrBjx81QsOhO52AGsFmdxF5QsfDZ3KWnhY2I2s+fnC9k
         tOMXvepCNfRFQ9P3nlWPPb4nAnMprr24DW7UvA0iP2tI9LgApG2QrTB7xj/7YeppaEM1
         LRTK5F0doIS4X9rSQfti+EIiPITyY5zQs3797kXcU8pl6FR0U2xS/vIIfNae22KWxtUB
         3YTX60Hn7UX6Vi3jn7xqY8ntLZNPSCD6Av073zLiiF9G9pIs6pDDt+LZV1dK6aNHN0Cs
         tO4rpRVNHQhxDyfx2Hpj6yWJKqwm/IRoMfkIR+sUGZ1ltOSMuK9b6J8S6H+I/737BNmG
         sCjQ==
X-Gm-Message-State: AOAM530r/boAnmUr7kUvG/wBlWKE2xbqEXz8lnM0B4hVUXYnQwcN4Xej
        NINsAecsuEzWfWAhZ/vyAIUBhvAYgkBGpg==
X-Google-Smtp-Source: ABdhPJyI7CEL2Vzo3vUmREKElvjQg9bgya1GNY94UVlE+LWyE6OPEQMH7nnqmi9FiZJyfoHNqhidRw==
X-Received: by 2002:a05:6214:194e:b0:441:130d:7fd1 with SMTP id q14-20020a056214194e00b00441130d7fd1mr1890978qvk.130.1648074212286;
        Wed, 23 Mar 2022 15:23:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.60.124])
        by smtp.gmail.com with ESMTPSA id x6-20020a376306000000b0067b32a8568esm708769qkb.101.2022.03.23.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:23:30 -0700 (PDT)
Message-ID: <623b9de2.1c69fb81.d4493.5bcc@mx.google.com>
Date:   Wed, 23 Mar 2022 15:23:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1807308688823282535=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Fix address overrun error in rx filter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323210629.17274-1-inga.stotland@intel.com>
References: <20220323210629.17274-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1807308688823282535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625860

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      50.56 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      10.09 seconds
Build - Make                  PASS      1477.30 seconds
Make Check                    PASS      12.21 seconds
Make Check w/Valgrind         PASS      512.91 seconds
Make Distcheck                PASS      267.49 seconds
Build w/ext ELL - Configure   PASS      9.94 seconds
Build w/ext ELL - Make        PASS      1445.32 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1807308688823282535==--
