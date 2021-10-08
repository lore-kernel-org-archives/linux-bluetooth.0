Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D664C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BBA61027
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 19:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhJHTcO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJHTcN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 15:32:13 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161AC061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Oct 2021 12:30:17 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id ay35so1757253qkb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Oct 2021 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sbkda7znewMvG+QDgUoVCsXwnIPhPNCzoVdFfmEJfp4=;
        b=qPIw01viFODdvJYksWPvjJZS2ovyAe7Ioakp514H5orSpnSPnMNGd/GwgJT4efy5VI
         UMIrtJbTpNfTAdDMwZAHnU/LobTtEjU8xkwr2uduM6qQCA7Ar5ZG+Uh0sf8ut4+syzIQ
         k4CUE4cnmQv3RQPOVClg1R9OLN1lhhDlO97DsdjX61V7icWraoRUjSXW7wC1gvTLF+L7
         k9U4iiri3wjFpVFuhh7XRvrBFZLgbQNhmtu0FtaETTOExcJ/pHLo2SFspwSw5WwM1XT/
         2ttSOdg9kRy1S3rvmDkhxkkeufVR6mcELzP6bgNPxtk5py+Sg8AsmobNZT3pyZuU5PmD
         +LTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sbkda7znewMvG+QDgUoVCsXwnIPhPNCzoVdFfmEJfp4=;
        b=fgDlXewPl++pg2JMzuU2F6RxSrpHmGP8IjG8OZ6Jbd9pBbupijirJVuF2pd7WXSwxV
         OeGuHVXoVqM6NKt/gXSyzLeancNg3k9inQ23Fr/efKZGlVCyWGcC5177uuRlg05Nszmc
         4qLvAjPhuP+Znql/Dr/Xet8W7J1Cz+XjcFsxhETvl6crJI0GEpHKwMmqnRtwGN3GHpUA
         F/KAZ0IqqUIGXv/yjN/ckPlh28rXA4sRHtWNqsK45GuSzQRQRa6Ojq1G1dfLKhpGcT7M
         ZSsfqREfHHAA/C+unF81AqStKGobnxYWJVNP6V8TD5NdW6xpqDHBLGZFnvEeIoUNWagQ
         mWuQ==
X-Gm-Message-State: AOAM531jhwoTSmGgPTUuRSCTHkApDiY7NseeA5XnwqipAXzfYO5bjk0A
        aY4z6gPyC9RI/6fzZN5o7k63U2VcrldtLQ==
X-Google-Smtp-Source: ABdhPJzNUARIGzttdGOwPp5IKKooPJ7SyqLWlcgYUJoCE0n4tDqbE3uZ5EV5QmbgVCjrktf5ww1h1w==
X-Received: by 2002:a37:40d1:: with SMTP id n200mr4465920qka.488.1633721416920;
        Fri, 08 Oct 2021 12:30:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.98.225])
        by smtp.gmail.com with ESMTPSA id a16sm237923qkn.16.2021.10.08.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:30:16 -0700 (PDT)
Message-ID: <61609c48.1c69fb81.532d.20fe@mx.google.com>
Date:   Fri, 08 Oct 2021 12:30:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1146132008662351787=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] tools/mesh-cfg-client: Fix NULL pointer dereferencing
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211008184830.24276-1-inga.stotland@intel.com>
References: <20211008184830.24276-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1146132008662351787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=560133

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      0.91 seconds
Prep - Setup ELL              PASS      42.04 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      7.84 seconds
Build - Make                  PASS      178.80 seconds
Make Check                    PASS      8.90 seconds
Make Distcheck                PASS      214.84 seconds
Build w/ext ELL - Configure   PASS      7.99 seconds
Build w/ext ELL - Make        PASS      171.15 seconds



---
Regards,
Linux Bluetooth


--===============1146132008662351787==--
