Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14489CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 02:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbjILCqA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 22:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240211AbjILCpy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 22:45:54 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD38150D07
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 19:10:22 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-49352207f33so1917396e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 19:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694484622; x=1695089422; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=spWauZt6/Nt26jwodK+m6L5WRwuoRwteLfcwraUT7xo=;
        b=JjabSEOIDBOMFNGBCKXmfg5P3ECp5mz2M4l5ODA2TwluocPmvoFP1+MKh2l6IjmSiV
         Q61LQ0x8fGQzXxgojl9ZM+XGV5x8ZKpu/m9e4jrvblH1hZPYUcxfa6C7G/Qq5wj5h4bX
         Wk0MAnQdpK2A2YFPou5bjjd3PCvvxaP6xvIatTJTKYuIGcnLVXT4Qe8FqjbNEj8kCS9A
         UBcsRXPGuEXRi6YhRTgT0HupEP4YKKJjG/fNJEkBOfINnKS/GcDmYmeBkqPe6hE8GaoE
         Lt4a3OTxB/8AAPG4XC4jzV1Yhc99YVxykqGNHvOle2gy8ez61bwyfXlMuQAzAfMjxKB+
         cjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694484622; x=1695089422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spWauZt6/Nt26jwodK+m6L5WRwuoRwteLfcwraUT7xo=;
        b=azL2skTHs+KkZcEODhdZeGkyazGFZ7VwYHkH7gFtj4J/sfmNV9TmxDqixIIiyP3W8S
         4HX1Mce1kqOU9YxAO0hxoE8wkp0f6PPIyGtFYRW2EMLfscFOUvrFUlSA4QGuoKVZP3+J
         I43k3AtGonJaGOgKZSaHo/TOj9TRRKTfNa65dLtd2K18BzcpCrQjPeMTaqHQ4eySjl5e
         oUonpwG5QU6J31VFbyL0aXknZ9VOrrEaUzZOSs9NCOyNMLCxbefAz6zaWTOLkGgS/OEs
         R9zQWXO5o9ejJXGNlBESREz0N66S4iQ5plLCmmoGLMS0bWkqbrxXvgqEV365u1t19uFj
         v/oA==
X-Gm-Message-State: AOJu0YyiiuSzEqWCYhOKAZPKnmj4tBJ2wTQ3et3d8yjYmg+RTc5uO6nw
        pLhX/LTxZbDmILjn9Lt+afte0yFXbMs=
X-Google-Smtp-Source: AGHT+IEf8uy8TZ6f1hp7g6hwXKeq+F7yMI1igdYm7epGvugzqCC+hg7NlpLjcvSZ3Cg1lDtXli4JDQ==
X-Received: by 2002:a1f:ebc2:0:b0:495:bf04:89f8 with SMTP id j185-20020a1febc2000000b00495bf0489f8mr6839938vkh.6.1694484621810;
        Mon, 11 Sep 2023 19:10:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.137.36])
        by smtp.gmail.com with ESMTPSA id em26-20020a0566384dba00b004290fd3a68dsm2479717jab.1.2023.09.11.19.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 19:10:21 -0700 (PDT)
Message-ID: <64ffc88d.050a0220.4192f.3502@mx.google.com>
Date:   Mon, 11 Sep 2023 19:10:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5412304563154303905=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Fix not handling initiator properly
In-Reply-To: <20230911223341.2701182-1-luiz.dentz@gmail.com>
References: <20230911223341.2701182-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5412304563154303905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783190

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      32.21 seconds
BluezMake                     PASS      1114.35 seconds
MakeCheck                     PASS      12.42 seconds
MakeDistcheck                 PASS      185.98 seconds
CheckValgrind                 PASS      310.03 seconds
CheckSmatch                   PASS      436.18 seconds
bluezmakeextell               PASS      130.22 seconds
IncrementalBuild              PASS      983.51 seconds
ScanBuild                     PASS      1371.65 seconds



---
Regards,
Linux Bluetooth


--===============5412304563154303905==--
