Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14A4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 17:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE5D2075E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 17:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrLmiZ74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHZR0e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZR0c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 13:26:32 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE6C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 10:26:32 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o64so2669887qkb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=R6Td+eEsQ4sKJ7qKWIutZh8XijaZ4gH+hXQd/s0GbWs=;
        b=OrLmiZ74Fyim8TquXRIIBHBl3qXIxOqFboo3CmWQY+WuIpMqjitN0/D8j2gdGF/LyG
         u8xqqD9jkPRPMLkIzAbM4s79N0Fo/Xgds11UKC1gb7MBgPd1mMT4Zg6B/7Fzh+bC0B7n
         V+v0Ee1nqBhJfMZ00Mwwh0LBu3w/VHKAyYn+6tylRhaLPHf7j+uWsgxG1rBANqFLefoK
         EV0U7pr+BCjTa5gPqvLL1fbimpThmqb9VGAVmvFimPcm3DXVxoaGH1kfFP/DXnhUsh7O
         juLqsB4Dod0pkAbDtYZT+i1GGkAjetihSmcZJF9idMMzZVOHeyAFCdU9GfuX1ahUSDvl
         rolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=R6Td+eEsQ4sKJ7qKWIutZh8XijaZ4gH+hXQd/s0GbWs=;
        b=QrNyQQpeoWVzEJOTdhOHTeR4JBO6yVmA1ZhCNAJbtwKhWfnLWlSFoGV5mvgAwI3Q+T
         GfzsAr/yr+hbCbcY/mgCYLVv6AevLrUvWK/2mtEhZB3hK0/nEbuouU9ZsQs6Wm3UVZfq
         i5zjtl5vNNVuE3kRMUzeZ1pM3H+srglTb0yTbNg4/afuDayBeffk+kZnDTwnA5Kel8d6
         pJmYMOKThp42JjvhaHXdz43wOp0DKAhrJlQvKEbIa36+waDDBeTrDIrvLM9MXwlyV0AI
         ApRkXRgH0lMxNkXzywNs4sINE5jMPNDKWJOctbyK33NvXSfgZAaj3b5++mOie19UksMk
         pWYg==
X-Gm-Message-State: AOAM5334laJzHw37MiqEwaoIT3jMgLaLS1LJGNxE03/nkqGumijK+Q1P
        03aZqEC2UAX96IJmbVDD+dd8tJBNnKKVqw==
X-Google-Smtp-Source: ABdhPJyXnvo3ikWoiW/ycXQxEaHjiGpxFlQuH0bmLzSNVncMtQglASEahyi980BqL5zrTHwk0lwMOQ==
X-Received: by 2002:a37:680e:: with SMTP id d14mr6100066qkc.234.1598462790527;
        Wed, 26 Aug 2020 10:26:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.161.243])
        by smtp.gmail.com with ESMTPSA id v202sm2169710qka.5.2020.08.26.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 10:26:30 -0700 (PDT)
Message-ID: <5f469b46.1c69fb81.4207.bfcf@mx.google.com>
Date:   Wed, 26 Aug 2020 10:26:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3014515499409848566=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v3,1/4] doc/mesh-api: Add "options" dictionary to Send/Publish
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200826165420.563822-2-brian.gix@intel.com>
References: <20200826165420.563822-2-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3014515499409848566==
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
8: B3 Line contains hard tab characters (\t): "    		      one-segment messages"



---
Regards,
Linux Bluetooth

--===============3014515499409848566==--
