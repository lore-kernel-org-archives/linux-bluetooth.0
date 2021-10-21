Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C20FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 21:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F27604DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 21:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhJUV64 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 17:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJUV6z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 17:58:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895CC061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 14:56:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 193-20020a1c01ca000000b00327775075f7so1132553wmb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8/WzqVKsA/pF7x/EvFRKZUIUCmf5u87XsdIABM+z/rE=;
        b=tngvLlpG5vvkzKa5fL/PmCdT7FVJN518qalSTmFfxO3187lPG7xuprhKoCbTwoEBKj
         FZ9+16uzEKHwqEbV3pe35G2La8nCIbYnkNo/apDDq61GGMbHQqyszNI3dLVqzqOCxrYh
         9nnG4faD7V4uuNpg0ClO8gEW2w/mAuMbcdOd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8/WzqVKsA/pF7x/EvFRKZUIUCmf5u87XsdIABM+z/rE=;
        b=6jOUudnCfHgFJFIcc75RcTNf0ECLuWQnFZ2v2SO08EYwKT6Ie6KpDvSjZJ9dOVbm+v
         Ov4dbPAL/8XkUV3WtWOWRjAkMSlT/WYQql+C1pAAYjuimO7B55uRKbm4i0YgSFLgnSmD
         KvgzoMpi3p/+kUCRoQADxVEYCP5brtzrJoxOUR751T1Hc3ffISLKvRMDMUspSkc7lFFb
         03ezC/Z/L9GEN/GYztcUIw8CvDR0rZvk5kWOxw+5GNaM1gggGCsjikvS+c5MpNz/18w7
         joJlWWGZ3krvpsA5tHLXdyjzj3cnsiFtfLAx02J8xw/d37p2QVemY+mlrlIaSGHZdTwQ
         wgcg==
X-Gm-Message-State: AOAM533I0iJiImFdSqgDFQG7zRehjMiGZ7UlGBXMvTApBBb7NSwkUGYE
        FVeA88+TTUZ8WhRYENS0Wyhjv2fnBRUzil4K
X-Google-Smtp-Source: ABdhPJx037Q92fRIt6nIgwR80Qad8pAk5cs14iwWfLaGqK96vB6wm13kxGyAunQQ4jGoQhhQBUkL3Q==
X-Received: by 2002:a05:600c:378f:: with SMTP id o15mr9560006wmr.63.1634853397517;
        Thu, 21 Oct 2021 14:56:37 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:9962])
        by smtp.gmail.com with ESMTPSA id n11sm5975864wrw.43.2021.10.21.14.56.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 14:56:37 -0700 (PDT)
Date:   Thu, 21 Oct 2021 22:56:36 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-bluetooth@vger.kernel.org
Subject: DBus assertion failures after upgrade to BlueZ 5.62
Message-ID: <YXHiFKv+RamKGkCi@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi folks,

After upgrading to BlueZ 5.62 on Arch Linux, intermittently bluetoothd crashes 
like this:

     bluetoothd[161733]: dbus[161733]: arguments to dbus_message_new_method_call() were incorrect, assertion "destination == NULL || _dbus_check_is_valid_bus_name (destination)" failed in file dbus-message.c line 1364.
     bluetoothd[161733]: This is normally a bug in some application using the D-Bus library.
     bluetoothd[161733]: profiles/audio/media.c:release_endpoint() Couldn't allocate D-Bus message
     bluetoothd[161733]: Stopping SDP server
     bluetoothd[161733]: Exit

This behaviour started after upgrading from 5.61. No upgrade to dbus, which is 
still at 1.12.20 and has been for some time.

Any ideas?

Thanks,

Chris
