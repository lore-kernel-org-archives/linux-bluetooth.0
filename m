Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96545C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Oct 2022 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiJNUUH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiJNUUD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Oct 2022 16:20:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1021286C8
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Oct 2022 13:19:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso5762765pjk.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Oct 2022 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G9Im6Z9+bf/pm2LlXzgDUX2h+L9laDVyj/AXVc6SQh4=;
        b=WtzUPsi1TVdnasyh7EWBVvlnuZNg/vH+JQaZxlbdU4xu0q650+mClXgGj4wiSKzgcD
         2TZVLV4zwiCdKmh1BH0kcnwraoeTkKmgJMa4tPALHlMrW6SzPyFhsL8+h6HhVux1wAg5
         b2y0Js+z1phvNU+CVKX+0NQ2IxYQLs4wsZPXp7YbUqsj3BYDRS/ERdy/8rRdfxor9oFI
         MxuJxO+m3Q31P5OzauPEIfWk4vAvO74lNt2aEgdTEPwaj43EfjmZ947lPafONtuvSDDX
         JMF9IiB2O+TqG6pJH9Dc5jRITaZbZb5/3YiIkh0HDcrl6TXDYS8An1IlATrm1JoOp5sP
         MpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9Im6Z9+bf/pm2LlXzgDUX2h+L9laDVyj/AXVc6SQh4=;
        b=dGLKO20XGlsjq+yVLRAz7p3yIQdPx6jlv/DRH0bwo+Bd5qM6j+ctM34qOlJQ4mTU1Q
         y+0CsX8liFzgfzdGZT+NnX+7CSjiGYXbfs3Yaz0WCGFYVQkEU4BSIteFbB4tDhETbHKh
         DiHp8GwViRa1Uzn6z1BWVqDuN0bEKmbKhOwq/SlF6pY71Ph543w2RGZJ+fhaJfdqCszy
         S8paNliFMnDYWw/xdgzNOwzdi+s+Od2kU/7uHnnuWa5eaLBzobsj+gOgaQ+zWjyijA82
         nJHXNH6EEDF+pU6/JHbrKWVVUXnzu5VGV3Xo6TfQEcHPJxRP5ypeyOfzRE/mYLYq6zCy
         rtDg==
X-Gm-Message-State: ACrzQf11/vZGNANlRSnEoOocWKdQFGs1Gq2HtEAgBY4SwvxoyNK4kRb5
        J1YScq8Lbdn5fbDLYqA7RKXYVmGWhyQ=
X-Google-Smtp-Source: AMsMyM6fI/PmY6mXyQuI8zyztBavyuGCeQOwXI0alYmwJKxBbXk1WeQl4MfZpMdZBIlVYO34HdkX0g==
X-Received: by 2002:a17:90b:4c04:b0:20d:4ef6:aacc with SMTP id na4-20020a17090b4c0400b0020d4ef6aaccmr19463182pjb.199.1665778798635;
        Fri, 14 Oct 2022 13:19:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.102.168])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090aa08200b0020b7de675a4sm1826885pjp.41.2022.10.14.13.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:19:58 -0700 (PDT)
Message-ID: <6349c46e.170a0220.8cae2.3c9e@mx.google.com>
Date:   Fri, 14 Oct 2022 13:19:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3253123992764616455=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] monitor: Fix incorrect vendor name for vendor cmd and evt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221014185720.1132417-1-hj.tedd.an@gmail.com>
References: <20221014185720.1132417-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3253123992764616455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=685453

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.49 seconds
Prep - Setup ELL              PASS      36.16 seconds
Build - Prep                  PASS      0.92 seconds
Build - Configure             PASS      12.32 seconds
Build - Make                  PASS      1245.81 seconds
Make Check                    PASS      13.27 seconds
Make Check w/Valgrind         PASS      389.89 seconds
Make Distcheck                PASS      332.00 seconds
Build w/ext ELL - Configure   PASS      11.34 seconds
Build w/ext ELL - Make        PASS      117.60 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      807.95 seconds



---
Regards,
Linux Bluetooth


--===============3253123992764616455==--
