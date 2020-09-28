Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18585C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 19:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80712074B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 19:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf1S720q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgI1Tao (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgI1Tao (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 15:30:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E3C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 12:30:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c18so1710121qtw.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nlLNs8/ibPb0lXjxMWPuPw2HrkGFXGoe4shehDdQdTk=;
        b=Xf1S720qHmYkdrv7gy8gFLuFB8PDA9K/c+UTznOHDUvM+frjbEvAN5vlEhBb9MtgRq
         alZvSUaUX1/vDIW3yiIT/c5xDs4GkjB1dc1NKoRvf/k0ps9RUYPUsSmoRS/u+hK7lTPf
         POpBZLmX5GXngSIOxyHZrIE04hd/CX0FihpMnvmQiE0HGnGRQ3mr3nlFuHBPJPZOb/FH
         vk6aAA8gRzieYxIcFcLKfBwdeHtCz5kvvZANfjlvn28Nv0YRFoaTT0uPyzVj9KjyNuSY
         +m6zNjzJR8xGr99XmnlBQUAfIJ+zyq7DPNWuLJwTzyYnKQ4+H47YyQ+cqcILdfCLP//k
         P8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nlLNs8/ibPb0lXjxMWPuPw2HrkGFXGoe4shehDdQdTk=;
        b=MArGFxk740K1/33vCyYC7skOnJOx9KFVSs8dbDjLFBZDtQi562nLTPkYh+p+NQXgMa
         js9e3YOj+dCBtIHwHO8GOXC4Q3Aa1ulO0B9P/dRJLeLPrqmox3Bad2LawNpDmE4Q95D4
         NLgQUy+odXmvIMxtWpmGFVRPXmEI4zqgzgqbQRaPishpGzFaFcHMYsuBPC6ZmeAddDyP
         9o83BIEC4KI8VlkyOOpOn9lwxbWnjWq1j+6tGDV/CQydlcboLiY38QadXv3Hb51w1lJO
         WiNztbBvyBY5656F/Ldm4hRtr7fsStYjlsz8c7p7Q/4j4MzP7o6ZPnKJgtAIr03PAUNl
         3wRQ==
X-Gm-Message-State: AOAM531FSeiQnAeBPZOKkkRQKuvnxQxXzuFD7aU1ls2H1/FGyKpYkxaT
        BEl3GzXbXLFAejsqXM7N6rupJuxKzrfgVw==
X-Google-Smtp-Source: ABdhPJyw7kZKzbUcmqLmLBXm4r4Nkr/5VkMzGWn94nDoIyywfafLcMtzq5XhpYczSs92J1XdcmPi3A==
X-Received: by 2002:aed:3591:: with SMTP id c17mr2350328qte.96.1601321442945;
        Mon, 28 Sep 2020 12:30:42 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.95.62])
        by smtp.gmail.com with ESMTPSA id o188sm1989864qke.83.2020.09.28.12.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:30:42 -0700 (PDT)
Message-ID: <5f7239e2.1c69fb81.dfa65.87a7@mx.google.com>
Date:   Mon, 28 Sep 2020 12:30:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0082312085609201364=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, machiry@cs.ucsb.edu
Subject: RE: [BlueZ] lib: Replace malloc/memset(..0..) with malloc0
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200928192002.22733-1-machiry@cs.ucsb.edu>
References: <20200928192002.22733-1-machiry@cs.ucsb.edu>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0082312085609201364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356715

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


--===============0082312085609201364==--
