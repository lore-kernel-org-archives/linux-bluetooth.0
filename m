Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E71FC07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 21:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB629610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jul 2021 21:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhGTUVZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhGTUHz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jul 2021 16:07:55 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15FFC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 13:48:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h1so12024628plf.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jul 2021 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rYtnTxENdjJ34SFCoxNsoQB+p0RYlNrtOnkgj7JIs94=;
        b=vDPgpGjEo+y8pFMXrfOQKK4qW83SKL3WQZ/93bmI4HZZy9tmXHCKKnvhYlCYSEs8Hl
         orHA8CyHlPa/reKKulnulXMsgNjqZuKbRd9owGuIdtxAKX5I2ZYnYMOd+uQlXrjp7gwy
         1dbc6KUKNwsVE0I2RYVRmHj5MHOW043sb1Ru0CPRU2jZisIWtxudu2maUcMvDzF1nabQ
         FtbT1hWXRIardD23jDXBhW5H78SYgwjsL+GmE3CpjI5zMWoV5PPfNwo1udPWIi5SgHpy
         EFpicr7n6KYVy4fNiVc4GGQcV1qO6eaAaMd2XV6xqwB+HxR5QV78DNk0pSS1oRory6tk
         Eymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYtnTxENdjJ34SFCoxNsoQB+p0RYlNrtOnkgj7JIs94=;
        b=khu6Yl8wB8D8ZBHfdC8YhsW+LpbnvV5wKF3LDlh4wVLWxDQseL9i83jG2jt2USdrjx
         02v8D0GSFCbCEHJq/6K3LN+b+STKVLevkcDaLsvwbPtxmtMMywrUgPwTt5aUoyp6ow5K
         IdppBZt9OVScllYhRj1zglMt6Gb03Zg3kAs/IsoAuQS2BB/6fXm0xi+Nwjz68/K1VUE0
         7Tvn7wR3pBVvVE0Swvcf0wL/6GnZP35exAgpjpQ0zyhwsZGthRc3QSefisjQXpvoAyNp
         e7EwyxCguOODm4qt1VjQmRMk2BpL91xgb//EDtdbkTeHCsPZSuGyiCQ6UIg+8XOdZvOd
         7nMQ==
X-Gm-Message-State: AOAM5310dmbNgBsUmMX6pYdkxFBSdrG1xtk2R2LJOV1js4ji6ZrvVdew
        3r38LXUvUmcSwl19af1MBO1U26aemfFISA==
X-Google-Smtp-Source: ABdhPJyA1cx1cgXL8hfwVfk6b89Sz2uQjRJnm0HKzpx1fj6B7xOFtQ2EcCGyrV+WVh/H/Npw+3qgRg==
X-Received: by 2002:a17:902:c443:b029:12b:a0a5:78d3 with SMTP id m3-20020a170902c443b029012ba0a578d3mr2148042plm.18.1626814110836;
        Tue, 20 Jul 2021 13:48:30 -0700 (PDT)
Received: from zen.local (97-126-22-202.tukw.qwest.net. [97.126.22.202])
        by smtp.gmail.com with ESMTPSA id bf18sm20251614pjb.46.2021.07.20.13.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:48:30 -0700 (PDT)
From:   Trent Piepho <tpiepho@gmail.com>
To:     linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>,
        hildawu@realtek.com, marcel@holtmann.org
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support USB ALT 3 for WBS
Date:   Tue, 20 Jul 2021 13:48:29 -0700
Message-ID: <4778293.GXAFRqVoOG@zen.local>
In-Reply-To: <ca3adcf5fd1e7afa923f445d391aaa00f335c470.camel@iki.fi>
References: <20210514031901.2276-1-hildawu@realtek.com> <ca3adcf5fd1e7afa923f445d391aaa00f335c470.camel@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday, July 11, 2021 8:33:57 AM PDT Pauli Virtanen wrote:
> pe, 2021-05-14 kello 11:19 +0800, hildawu@realtek.com kirjoitti:
> > Because mSBC frames do not need to be aligned to the SCO packet
> > boundary. Using USB ALT 3 let HCI payload >= 60 bytes, let mSBC
> > data satisfy 60 Bytes avoid payload unaligned situation and fixed
> > some headset no voise issue.
> > 
> > USB Alt 3 supported also need HFP support transparent MTU in 72
> > Bytes.

> 
> This change seemed to break msbc audio on some non-realtek adapters I
> have. Tested Pipewire on BCM20702A1 (0b05:17cb), CSR8510A10 (0a12:0001)
> -> no sound output and input appears garbled. Reverting this patch
> makes it work again. Indeed these adapters report SCO mtu=64 which is
> less than 72. On the other hand, with RTL8761BU (0bda:8771) msbc audio
> works fine with this patch out of the box, indeed reading/writing 72
> byte packets to/from the sco socket

When I fixed WBS when previous patches from Intel and Realtek broke it for 
most adapters, I also tested alt 3.  I also found it didn't work for many 
adapters.

It is annoying that a chipset vendor can not be bothered to do the basic 
testing I am able to do by buying random bt adapters from amazon.  Nor 
respond when their patches, once accepted, cause problems.



