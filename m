Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B32C00140
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 17:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiHBRVt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Aug 2022 13:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbiHBRVr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Aug 2022 13:21:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED948E86
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 10:21:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i71so7356465pge.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Aug 2022 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=2xMuLa58iTHm6yu8jHDr9Gh173eFhq5RvSUvMgc9vUo=;
        b=bQS6BeiKfvqm52YIzl6HVjHGvy2DhWKXPblg2yqycJUTslaLDUgxbkDAmjN0rdee3I
         8m2WvabNfL/KadQ4cRUsirMwsKH7HggLzf2NacpPR54wPoXYtDJFihPEIlDZXxESDhk9
         GRoYUME500HnSlFitJLqQq5e/uCdh1stY6e3BmI7SjalU74JZYC+3R7dwyys9zcB8Gd7
         3Nnbp3UqNAocjHjcgURHsQLXIQj0NcBDVtsgZLZfZqO5p9I/8Hw9/ME68DL/KLmGbxab
         2T9Xxvb4umH4vw/iAagb/syhxGtlM5s8T+BPIhT/HdeAienvalKpk3G0ra3P2D40rTwt
         rDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=2xMuLa58iTHm6yu8jHDr9Gh173eFhq5RvSUvMgc9vUo=;
        b=gzcGTcWOoV/vjzg2Od4wkrMIHSS4INm2vpFzG8b8gECYuHpodcwa4FGiaYWF+FW1b6
         f5rEuvl/uEqCtCoXUE5371WaK9bK7uaVyqoLibhuzRIKZAPtVziEvCWNYg5vqMT6vyis
         bLbh/BICZe268IiWdbKS10fRJnMbRLtj6kYQqMEgnqhoqwlWsrcuF7d2Q+s18/fh53oy
         QdBbIG3I1KHLGtaRXyBUPnWHctoTy7pnHq10rfXFclKLssEjrxfs5cva0n7dZa3/9wTr
         vdi7eH2KfEWFQl81tkm8ERVw2RWBhFzWAVjtm/PMZ8oaK1yDQyeKIy4tAfmpgF9/dyP0
         9S5g==
X-Gm-Message-State: AJIora+0RXmEpS65QH1LBMmlACDRsgBQ6+LA6FxOJPI3LPL1dKk2dcV/
        JepUt2+Q/6N4y5dy67UPhwBcT1FBEIU=
X-Google-Smtp-Source: AGRyM1sIhhdVj6v2hq8CpSOXkuJK4hLhHGepGIrUSBHZh4Fh/nGGcTnSMUjKyt3AfZE+qY2hsmlJwg==
X-Received: by 2002:a63:4a41:0:b0:41a:a605:f07b with SMTP id j1-20020a634a41000000b0041aa605f07bmr18117416pgl.279.1659460904196;
        Tue, 02 Aug 2022 10:21:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.38.7.144])
        by smtp.gmail.com with ESMTPSA id i6-20020a626d06000000b0052c70770b24sm11173503pfc.40.2022.08.02.10.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:21:43 -0700 (PDT)
Message-ID: <62e95d27.620a0220.ee608.1eca@mx.google.com>
Date:   Tue, 02 Aug 2022 10:21:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4844019926134685531=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] device: Add btd_ prefix to device_is_trusted
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220802163441.2522333-1-luiz.dentz@gmail.com>
References: <20220802163441.2522333-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4844019926134685531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=664876

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       PASS      1.08 seconds
Prep - Setup ELL              PASS      27.37 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.50 seconds
Build - Make                  PASS      850.55 seconds
Make Check                    PASS      11.23 seconds
Make Check w/Valgrind         PASS      285.34 seconds
Make Distcheck                PASS      238.54 seconds
Build w/ext ELL - Configure   PASS      8.67 seconds
Build w/ext ELL - Make        PASS      82.08 seconds
Incremental Build w/ patches  PASS      195.11 seconds
Scan Build                    PASS      599.70 seconds



---
Regards,
Linux Bluetooth


--===============4844019926134685531==--
