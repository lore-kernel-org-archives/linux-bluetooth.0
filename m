Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E81FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Feb 2022 20:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiBDUnr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiBDUnr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Feb 2022 15:43:47 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AAEC061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Feb 2022 12:43:45 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id e20so6304051qvu.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Feb 2022 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X8dCFaxWCifRnbgkEOPN10cymV2lKNJXYC3vbSye/+M=;
        b=Z2AiskItshrR7qDf/1j+uB1bCRSnqPixgVULAI2VSE/V3j7t5pVSmmmfYkwl75CSZi
         /CbNQxVgUhJwBIByifZt91lHMeFD4teMoRdLeP3aH4w2F1HOoKR69lt/Q9Pe5YTvrsDJ
         Ai92awXRJYLBED36ODlz5XUKGfZ3KGQa+sEK1CELm3ZZcHR/xby3h2RRRLqJAaYDLK5u
         IW+hGui2T6RU/PrUYbIm+fhoN2DxV8A9lJrtU/081NrvFsusjCc8K6oxMP5zq4OY7Ecr
         UTBNAFFFzouJSwmSSAzqHaRX3LirsN1/MRcb4POFLwvUxLM+FaXlR0B4JPz5vmhQExHk
         sXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X8dCFaxWCifRnbgkEOPN10cymV2lKNJXYC3vbSye/+M=;
        b=YQeur7Eq3RD3I2JBSHglQA2CHXUx0zAeBa2irv9KQLL5H7uiicpQoKzkckt84X6Qzg
         67TQYM4y9RXKojFKd7EoTwlldyb4Bfx1AcNXGMqEQECMvTEjfmZtFWKuvyRvboNXpvW7
         eOv7FYhzESN2bPAxGBj0YDNiy21bUI1XjjLnu1o1hgVjzQGO/9Y4G6YhHMu8H7u6xS1A
         8itpvY+xyh++yumISGVAfnbTXawwNgemJaHBXIG/+z4HQWIpSj4TKckktvxRkCstZwkT
         Iazq86dCyzdDQwC5wnwXWCamjEcErW/7khJZWfvj3YqW2JWWM7UbXTHI5CJ5AA8Eskmj
         7uyA==
X-Gm-Message-State: AOAM530Tj7qsq/zjiDOmkrL4q2TdkQ4f4FjTGs8Ocq03UWdDw9w8rBbq
        m9Z+oa3RWdPWAq2By4TTpQTeX1oFuI4=
X-Google-Smtp-Source: ABdhPJynOBCBvBPl9vkpxHDDB3SHAyNQEGWkshrpFeUZAkCIFJUnKE08yhXATa6VqtY1zprBT2tR2w==
X-Received: by 2002:a05:6214:19ce:: with SMTP id j14mr3451173qvc.43.1644007424977;
        Fri, 04 Feb 2022 12:43:44 -0800 (PST)
Received: from [172.17.0.2] ([52.225.232.112])
        by smtp.gmail.com with ESMTPSA id y18sm1740118qtj.33.2022.02.04.12.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 12:43:44 -0800 (PST)
Message-ID: <61fd9000.1c69fb81.b27d2.a5cf@mx.google.com>
Date:   Fri, 04 Feb 2022 12:43:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6989677377056968987=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] gdbus: Emit InterfacesAdded of parents objects first
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220204192619.2653955-1-luiz.dentz@gmail.com>
References: <20220204192619.2653955-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6989677377056968987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611401

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      1.02 seconds
Prep - Setup ELL              PASS      43.52 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      8.75 seconds
Build - Make                  PASS      1440.21 seconds
Make Check                    PASS      12.26 seconds
Make Check w/Valgrind         PASS      451.94 seconds
Make Distcheck                PASS      235.40 seconds
Build w/ext ELL - Configure   PASS      8.75 seconds
Build w/ext ELL - Make        PASS      1436.60 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============6989677377056968987==--
