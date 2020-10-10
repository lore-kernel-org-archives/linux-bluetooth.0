Return-Path: <SRS0=53yU=DR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED74C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Oct 2020 23:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52427207BC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Oct 2020 23:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD+ObALX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgJJXdE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 10 Oct 2020 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgJJXdD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 10 Oct 2020 19:33:03 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B50CC0613D0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2020 16:33:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c5so10978114qtw.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2020 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IXO8s1FSJPFYxMSzOK1b5Mo6OFU8qq0Dsu04m7ZMRYs=;
        b=pD+ObALXldoyjJbXh36qa5TdIEOGEIZYka5IMF4U4mkFBmgWT/xcz/Csd8XNcQGNbT
         wYZ5hwpEm02ruGSkGZ5R6spuLQnJ9fytekEAd2riOy/0Tf6XRKGnPc+V+APPNjC84jlf
         O97Wvwv3DalFmMxwKf0QSsjru2BqrQTccbFl5qX3EOt/w/SW3Gj7J4kpXcXUFy5RBQ05
         azHw6J+a0WzKZMk95KDmq8dY/aWDeyZMbRSOboXl0vKSxElLrwyG0vhBwqyig9aZreo3
         /wO6BhHtaptnuNuIiQ8RVUDxrFfz0FkPGd+XbJoPDAkfnOApB/lX5wgRfL8k+18IMqy3
         1Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IXO8s1FSJPFYxMSzOK1b5Mo6OFU8qq0Dsu04m7ZMRYs=;
        b=KVGiy6P88x62aD4rni1Kf3k0Ju3SA3OrP8Qp6hILPmoWxIpR4xTE6AQ4wWrmsByYGe
         U/NrQ7fsot+79y8hxlDB5YY953IA3XtaX7loR/wtzFOPO3s0LUen9zLxJo9qs9v7v9lb
         mZ+KMdQzHxd3ls6eFjdGfKdb5jus+XQBMyRFX3F5wClnB6C0iPVpbQGFfBY5v0z19keW
         n4HosaUbYbh0ER46sSMjAUbFd1TeUj4t+3vg82SyPigHxdYs+nfxLV2v7YN5bmCAcZr6
         R0wjCcDI89iUSOkn2X00IaxdiCIJrwAHY4TeP1AtYG1uFGuFzlL/ST9Aj9UBvH71FLtN
         DZHg==
X-Gm-Message-State: AOAM530h5nhotFf3lrmb6ZbMkK1ss0QdgICKjmpjIN0xLWOJjpKnxguE
        SrqjqBA8viOFwtSFaCdIfryND68EkIMfxQ==
X-Google-Smtp-Source: ABdhPJwnzir/hX9GsrcQ54ZzbqLoCxqTNKWvJc3tQBdqaP77cozeuyUpqG9+UOYSDKc1UwMVnLVRTQ==
X-Received: by 2002:aed:35cb:: with SMTP id d11mr4240119qte.324.1602372783044;
        Sat, 10 Oct 2020 16:33:03 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.162.52])
        by smtp.gmail.com with ESMTPSA id l12sm9269950qkg.54.2020.10.10.16.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 16:33:02 -0700 (PDT)
Message-ID: <5f8244ae.1c69fb81.ce543.bf05@mx.google.com>
Date:   Sat, 10 Oct 2020 16:33:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5792907437120680591=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, daniel@simko.xyz
Subject: RE: [BlueZ] profiles: Fix segfault when using headset controls
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201010222719.439956-1-daniel@simko.xyz>
References: <20201010222719.439956-1-daniel@simko.xyz>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5792907437120680591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=362639

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5792907437120680591==--
