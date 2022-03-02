Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 00:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiCBApC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiCBApC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 19:45:02 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595B5E776
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 16:44:20 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id 11so266854qtt.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 16:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=PrX/VrRQrt9kxfexIos3FT+CR5p4DXW3HCcahCZxMCI=;
        b=hIWDAZzSyDX8o6UFV6iN9LL4yD16qLIs97UKs7cJ4iPGrBjLwlnOm9pHfaPkYN+E22
         d8hhXlIfz5tJyPgMVIyYT8UtVTWBkmBqcQjOVZsh3iPM5wOcpQI4aSxLDsmed68qVVIt
         i3mNpY2rePMuPlB2c1cb5KQtlDlPlkPD9uosv8miw3SjP1tpObyTih90ubczUcwSfUzK
         5vyDI6SRTavbl1dB9/iRE/HEKdDrPh9gOca5o47HVoURRlXWhybYbLGlotBQMbgXmcZr
         L1mTtSV8EMCbP74RNa7tnvJW14mU4h9xcUG8H0xONHs9ap/x3oSB5ujQAw2OyrNqVVfv
         p6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=PrX/VrRQrt9kxfexIos3FT+CR5p4DXW3HCcahCZxMCI=;
        b=d/WXAI4LcVtT3xv64yc7Zhx3qWuYJZxZFYhx+AMGfeWPzZk8HBKhoqQfzRicqvj10g
         XLOM00WsV8ckqmMRy/8L8ftaOy3NwPuZEpP9FwLHM94iiJkqR3r0EIoslVCtEV5jkdAk
         8+Usrr815yzPDy1M67Iet/nZ48WL3FyeYgM57rwv71ExLom1cqCLQLOL2EDOyHAan5Ug
         sRHAVANjjt3kzj3gQCDmoYf/2yEFaTuKw8VU1MZcq5e7cntm1uimZIMTbZKx9znNv7GN
         GQUzx8qp3vJw/a4ivSChTD2UJO/pyR0tUpmzg3Rc4NLSCGfF7wn7yFvkzs/uqmjiD/SI
         zHLQ==
X-Gm-Message-State: AOAM532W0TL/IE/ukEerWlbhbvTMNXnb/129F3an6V1pt6Wk8ZVxjq8U
        pRPwqgAKNOK7fmAWi59OuUoXdykkNzlT4w==
X-Google-Smtp-Source: ABdhPJxRwRK93ZsWxSQiD2ytZ51rzgN9cSGyIzV3//SmfvCg3VfPqH1sS+Abs1jUQByYeYx+BRRDFw==
X-Received: by 2002:ac8:5809:0:b0:2de:a097:98ca with SMTP id g9-20020ac85809000000b002dea09798camr21367435qtg.252.1646181859162;
        Tue, 01 Mar 2022 16:44:19 -0800 (PST)
Received: from [172.17.0.2] ([20.122.121.54])
        by smtp.gmail.com with ESMTPSA id d77-20020ae9ef50000000b00649555ce936sm7864644qkg.83.2022.03.01.16.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:44:19 -0800 (PST)
Message-ID: <621ebde3.1c69fb81.4f0e1.a85e@mx.google.com>
Date:   Tue, 01 Mar 2022 16:44:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0720909529738729393=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/shell: Introduce bt_shell_exec
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220301233045.109794-1-luiz.dentz@gmail.com>
References: <20220301233045.109794-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0720909529738729393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619349

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      1.07 seconds
Prep - Setup ELL              PASS      51.80 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      10.43 seconds
Build - Make                  PASS      1500.30 seconds
Make Check                    PASS      12.38 seconds
Make Check w/Valgrind         PASS      533.05 seconds
Make Distcheck                PASS      278.20 seconds
Build w/ext ELL - Configure   PASS      10.45 seconds
Build w/ext ELL - Make        PASS      1473.77 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0720909529738729393==--
