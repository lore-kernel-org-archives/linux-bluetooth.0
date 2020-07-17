Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5237C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12A62064C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 19:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtyIn7f0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGQTX5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTX5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 15:23:57 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3852C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:23:56 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e11so9789702qkm.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=L1YHYdUHVzgnkj9au54L/SIq6grLodhZXXb3pQoKLck=;
        b=JtyIn7f0kwcUBnflhCkzX6F1D/rifT/AvuXvo4Muq/9Jxr7iouX+yAM0OLCB1AT5Qb
         aPu9BB4muQxTgJ/ngekszTPFu70yZZ11xa8f/POgIdhlHJ1tRt4k99HDElRSsADW469M
         1W5Rx1CgmuuAJAkaEglW6C53GijcEIRIlxAWenys+7Vmt3KAl0ye7TIpCWL9GqucOvxl
         AikYHVU14B1HGG8fWsF9JXzGasQrFdewCsrRk1jq8YXPFrGbH9bQwDwZ17aRvykkce25
         bSXz2Mrw2sTlM8N7+J2Pnj6E0CbhrpLCNqAYxFUw+x+kS2vV2p3d2kgdK89Dd5zNqH0w
         vEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=L1YHYdUHVzgnkj9au54L/SIq6grLodhZXXb3pQoKLck=;
        b=LpM3LzUaOMD2G11rBwFauoHLCwH71+JhJAMG70q4C3AsaUatWxkNCgohmFOZsifMiC
         rzPVe+WXevVz/6EA8SS3AbC0mLaEVOHMQ/vsEqjR3s9p1qEXabpoWKNuROSUD4BV+Zdh
         ktNqYdUeEwew9HFMGNFOQhecnbl167Lo/8Bfo08ks3b9mdrckkfF7CJoXPF0nfI8HhQT
         IqlZs78Uoz+jit4O10duMBz3ypedKwwl2p7LKo5AlK65QZkgM1wjDi2K3jtQWX+cp5rP
         QSxxlOhWMNOg0hHFa0ikf+AoDMywz1VVha4RCAKgLqpPB4bVtGs31Sh/ObuFBVBGujQM
         NwNg==
X-Gm-Message-State: AOAM5306DZH0rxtlS98nrxaW7/p2T8Q7B5m879146nR6vXGmidDI5s6b
        vKXkqtcQ1PYr06DwWf1OBiqC4Wvo0F8=
X-Google-Smtp-Source: ABdhPJy9Q/sMhoel8A5AESzEKSVg19OeRK4BaYE9scLR5mdi7dWEXx6/Dy9LQmE8g7Zs4y8jeh+www==
X-Received: by 2002:ae9:e212:: with SMTP id c18mr10544877qkc.348.1595013835838;
        Fri, 17 Jul 2020 12:23:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.1.183])
        by smtp.gmail.com with ESMTPSA id o18sm9991034qkk.91.2020.07.17.12.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:23:55 -0700 (PDT)
Message-ID: <5f11facb.1c69fb81.6f815.57f7@mx.google.com>
Date:   Fri, 17 Jul 2020 12:23:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4762856199470095268=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] shared/att: Fix possible crash on disconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200717191515.220621-1-luiz.dentz@gmail.com>
References: <20200717191515.220621-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4762856199470095268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
makecheck Failed

Outputs:
./test-driver: line 107: 14830 Bus error               (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:9726: test-suite.log] Error 1
make[2]: *** [Makefile:9834: check-TESTS] Error 2
make[1]: *** [Makefile:10228: check-am] Error 2
make: *** [Makefile:10230: check] Error 2



---
Regards,
Linux Bluetooth

--===============4762856199470095268==--
