Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E145AC00144
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 03:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiHBDSe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiHBDSd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 23:18:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0CF422CE
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 20:18:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so12406763pjn.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=59uMZjIIVegWR6ceI5VjrnELKHLnpH+99gAI/fDLOt8=;
        b=MY7GtrrJ2PTFBfB9eRa7TPDfVTagcZQOoYE0QALJXo7vZE0tyXzAs23ZDv+uFbOaY7
         b93Qr304ddg3XcBKVfiEBoRSaYZfEINM//QjlSlvC3YWP2sfukNTDU58lrJ/C8HLh1Gm
         FlZBAONZxKVJXqXDxoHp+FNX7uJb+xV8M3TJGPcHCKq6H5mmv37z9t5BInnILbT+6wlH
         RLpOMr2mk12v6oWaA12RDvWJ0iAGzHRVjpGA6OXONAVRQ2Pbpo9L62ninkYs7fMcRUF2
         5+V4Ze1SoKN9VHfSilPU/JI6hKegsGgUhi4BGSn2G403dhp7fNkeHQGdxECJZKZctizi
         buhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=59uMZjIIVegWR6ceI5VjrnELKHLnpH+99gAI/fDLOt8=;
        b=yS371O2N+xfil85EGBh+Jo7PHpj8qb+MHEX6P7YbX8ITJhEu444OUAfZw6SNj+EpZC
         8No+sUpN8OQJlh10OBRnH2tIMeAEo0gL+h6LfeEFOTF3gsOutv9rVQE7+U+ksIliJJFF
         IUht9g+R8XFOeQLIUDAI2/IB9ycsxF1igPsGg3JZ7CHRMnfEz67SrnxXGyPUSKub87Pu
         RgbzDb9LLrr8rb5NVmAAYRi82z+rNTQPaUUmlZQRMgqp5LL0HYfY/V3DBWB0WJr/GG6h
         d3wUThOvAyItuZhR5sfIqGTJyPsUssYiV8+BWja75GFukCnxH0MouTKYE0QCRzkcTp0c
         sxWg==
X-Gm-Message-State: ACgBeo2ZkF5mGMa5O99w1e+8ZdJQtlDD+QWPkoAh/a9m1m7BjHfKCoGc
        Q/+q5marJDRdBdLVhhl1vdh0zgWWtrM=
X-Google-Smtp-Source: AA6agR5TsTg6eugh+e+aUaoruKU7KRWmKkMLSv46QRcVwIm6ARjsBcPhmAxBEdQ7+0PD+A4KjUla+A==
X-Received: by 2002:a17:90a:d585:b0:1f4:f9a5:22a9 with SMTP id v5-20020a17090ad58500b001f4f9a522a9mr9864802pju.49.1659410309189;
        Mon, 01 Aug 2022 20:18:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.53.211])
        by smtp.gmail.com with ESMTPSA id n14-20020a654cce000000b0041229183c8esm8447314pgt.8.2022.08.01.20.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 20:18:28 -0700 (PDT)
Message-ID: <62e89784.650a0220.f5e8e.c4fd@mx.google.com>
Date:   Mon, 01 Aug 2022 20:18:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5371629238493676208=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] sixaxis: Fix fliping device.trusted automatically
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220802001157.2308559-1-luiz.dentz@gmail.com>
References: <20220802001157.2308559-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5371629238493676208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664649

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.54 seconds
Prep - Setup ELL              PASS      26.23 seconds
Build - Prep                  PASS      0.62 seconds
Build - Configure             PASS      8.08 seconds
Build - Make                  PASS      740.98 seconds
Make Check                    PASS      11.09 seconds
Make Check w/Valgrind         PASS      282.33 seconds
Make Distcheck                PASS      234.63 seconds
Build w/ext ELL - Configure   PASS      8.17 seconds
Build w/ext ELL - Make        PASS      80.51 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      584.10 seconds



---
Regards,
Linux Bluetooth


--===============5371629238493676208==--
