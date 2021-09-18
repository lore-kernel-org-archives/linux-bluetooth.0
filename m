Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3307C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Sep 2021 02:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4D6126A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Sep 2021 02:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240289AbhIRCeW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Sep 2021 22:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbhIRCeO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Sep 2021 22:34:14 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1400C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 19:32:50 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b64so23503166qkg.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Sep 2021 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=30uzhm6cUYIWTFlcNOtf1uXImSSDb4Ibvn1qdpDJN38=;
        b=MGoEC9KH/dp6gk+N4bYSV1g6Cj3f013ZZd28RD29T6w4/XRl1K826H17Kj9/4bC+lp
         6meEkBaLAzLK0Z5oE1qUzWYDXE8ZRrM0bZyln7/oYBCf6dC47yCl7Lku+XLOwhwcGt7q
         JQIbdArFo/qmWZw+XIggPk7WgfZu4OfzeMDA5L71m4zg4ygfJVA86JVa5Pl/3wVSgJam
         5xp9shjwU8/tNjAnnA6BRmKdGKO17KkXDgY5Dww//+Q6k9EL3KoAE1Fr5gT3k7uE9cra
         QOfx4gb72Ev6Jvs+ZnK5Yzte2gZx76llqrNA1/cbS5/PmepyUiKUv90YJKtCHxcjiUPk
         34gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=30uzhm6cUYIWTFlcNOtf1uXImSSDb4Ibvn1qdpDJN38=;
        b=cgynS3v+xLKAk/KUUSBM0cR31qeimwXGHnuT8aNNqDXqySL8os4RbSXHx8W9JnUY51
         OSLTpUKXOEu/MlcPVHu6BsXO/og4ctrRHc32niT1qpoKfNCfUlFT23rqiL3uSDnFaLq/
         EBe2q4oL2rewJS9jtEp4L7nNrQ9ZODeFlB+fyGVnVP3YJKinrv4Hil0mQ7b4XAw2cHll
         MlfZCHLhUb1Z0qzb28/EFRsDsQ2S+b3NQGduI2PoClBcq2+xb0DYz4ZuBmkbTHGnRrhm
         Z0TnS9eLJ6WuA/lLjVyQOStBWeQUSme65lMfklen8gr2sg6P1xyu3OmIcv1y0fyfua/r
         IPuQ==
X-Gm-Message-State: AOAM533fOZj9j9vgWHx9ctiODpGy57agifXmXtGrPe+/AY5FVdR6hYNp
        ETARE15UimAtRCu5dg+r79ros1alSBd8sQ==
X-Google-Smtp-Source: ABdhPJwroTaJANxrSwrRpRB3/ywiNrmtsn9PR6NUan9o/vsvPkn9yaHEXjC7nw3F1pRL7h1y0waCAg==
X-Received: by 2002:a37:9d96:: with SMTP id g144mr354780qke.23.1631932369998;
        Fri, 17 Sep 2021 19:32:49 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.86.114])
        by smtp.gmail.com with ESMTPSA id t194sm6552585qka.72.2021.09.17.19.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 19:32:49 -0700 (PDT)
Message-ID: <61454fd1.1c69fb81.70bdc.51b3@mx.google.com>
Date:   Fri, 17 Sep 2021 19:32:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5513002194769504307=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v2] Build: Test patch - Do Not Merge
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210915183136.384103-1-hj.tedd.an@gmail.com>
References: <20210915183136.384103-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5513002194769504307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=547527

---Test result---

Test Summary:
CheckPatch                    PASS      1.30 seconds
GitLint                       PASS      0.90 seconds
Prep - Setup ELL              PASS      47.06 seconds
Build - Prep                  PASS      0.51 seconds
Build - Configure             PASS      8.79 seconds
Build - Make                  PASS      200.32 seconds
Make Check                    PASS      9.11 seconds
Make Distcheck                PASS      243.11 seconds
Build w/ext ELL - Configure   PASS      9.18 seconds
Build w/ext ELL - Make        PASS      192.74 seconds



---
Regards,
Linux Bluetooth


--===============5513002194769504307==--
