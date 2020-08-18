Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E03C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36422065D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtjwGElD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHRWu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHRWu2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:50:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96B5C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:50:26 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i20so5717927qkk.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QNciXq1K04EUWNgTRLRsyw4jITsDyOiX1UyGmAA6u0w=;
        b=RtjwGElDX+E9fD+wN6kTQ/bSkcBZrP/jHbiULSwArQpmEdBBodnXaeKCQT4CNfU/an
         F2bB+5yr4mBmTSqese7laQyRQzrGsn05hb1rW6BR/SFyMXtmgV0bERYGfFq4koJI9okX
         DRLrOqPA3QmvCcWupbFYTnIfBD2n03sbeRJXlGRUJJUVQchzc0/UUBcW6oPVaofZB46s
         O4R4IhnR2ffGvi0ycehOq27ZLesAyr2SERadPI6/BbbG2SM4aBLwxpUsDD7M8WfJHTT+
         w54ABFR8YPrZm72yjtKPAsskXuu4UTF3Q67bgTWPR90EcItsVqoljFfObApA8f38bBFN
         6t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QNciXq1K04EUWNgTRLRsyw4jITsDyOiX1UyGmAA6u0w=;
        b=NoObDhR0KFz63GwUe45mR+Io6iOkDGj0pnrf0YhQOSt9pNcaPPLSsUAgok7RHzXLA6
         f5Yer+Q2153JG1g6P0ztxtK/cB6BrRTeOcAC5f8rqbxuawp2s5DGmealzqLJLU2Yz3s/
         QvOQJB3GddrnsaHtUmumAEtq7wd8GFdpop3hXg1Zp3gXNwrXECT+I313+QOYIKySm26x
         cX/TJ+FyBHXoqsAVuyNAlbBpTepVN3RYwE/GsH1pmpkv5WuE6vancmSqexAp/loxbERK
         s+0H8H2gPm2if+zXO+xFXppzBCUPUvsL3VHxClZA2ETgJdxsMMgFGzPint6tbbE6VJgE
         G7XA==
X-Gm-Message-State: AOAM530rJ0V0k8l8WF3MUbJuR7F/0fjHGTnlFs4QzdF79/ExPG4T7H+A
        s/90G5AS8eVMymt7jq6//e/KE0nAzJnDvQ==
X-Google-Smtp-Source: ABdhPJzlgpbW/7/L1rvJwg3D9JnvNzTrLnzPbXVuQkHRle5KKrTmzQVULiFkQXfy0ncQ+t3mbPlBpw==
X-Received: by 2002:a37:9c58:: with SMTP id f85mr18284567qke.345.1597791025308;
        Tue, 18 Aug 2020 15:50:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.53.181])
        by smtp.gmail.com with ESMTPSA id i7sm25191657qtb.27.2020.08.18.15.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:50:24 -0700 (PDT)
Message-ID: <5f3c5b30.1c69fb81.6bc90.79ea@mx.google.com>
Date:   Tue, 18 Aug 2020 15:50:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2803597289067355322=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1,7/7] doc/advertisement-monitor-api: Update Advertisement Monitor API description
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200818152612.BlueZ.v1.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
References: <20200818152612.BlueZ.v1.7.Iee7e9d13c78dd02c5b283a203dea11a4a4ffa7cc@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2803597289067355322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T1 Title exceeds max length (75>72): "doc/advertisement-monitor-api: Update Advertisement Monitor API description"



---
Regards,
Linux Bluetooth

--===============2803597289067355322==--
