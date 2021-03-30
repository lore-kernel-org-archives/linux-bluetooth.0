Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346BAC433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 04:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6EA461957
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 04:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhC3EsK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 00:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC3Ers (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 00:47:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B905C061762
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 21:47:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7035818pjv.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 21:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=oTsK1SCJWaIkbBJ3gH6K+J+4mfKKrqyNnywMUnT656o=;
        b=X9h7q0dZ/ob62ob1JfdD/qGrFy5KN7omCmsrCKzPAqZX67BvDwghenoNOHTVB83XhN
         3GMxI9XKTI0joEigy8dWThA6eR6bhrrMGko0bqwa47STYoBdyI5ei1fiaGi2lW46Rjoo
         8IBQaXLa6TP9ieqBpvPJKbojvrPrBM4SdHdBF5Ae/QK21SeQ0mNFANRxvCAHm/o1o78H
         F2MWv6u9EOcixYykqnCJbeA1je9GLoAhmU1i09Tc1lJFaDzr0hBJWIreonRaVw1UoKFZ
         9VvB7p5Y+e5KB3GDpiibVhJI1a8pLCHOxVtb3fSrdIoGivctepL9ajvGvoZccxQDUdhw
         hFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=oTsK1SCJWaIkbBJ3gH6K+J+4mfKKrqyNnywMUnT656o=;
        b=idtzSRaYJcYssFvT9TlNJek6eYRA95OSJbXFEqv2bvJtINT03t+mZD3aRbfeX19pt9
         uyVxhv1nwUURqDuWQlJLCGnIWWvmBbWF3gGOB8CTh439tkwwdqG0Inwpcy0QHMmRJ6F6
         n57x/N59/XRMX2MiKsFRfoGSJlFeYGzY4qR2C/gWTAksW3X17FHJjnViukwqoxyS98LS
         ioA1HPRsPUtg5rEKWfy7rpq37deYclzI9WEe5rIvQeMp1EAHNZdMZ6N5rJdP+IC5GLgZ
         5sbXLfh3N98PomZSENYV3gvXCa4SPkh8rODaWzil6XcJUJFQJs26nHAq1VGfFj+WT3QS
         ilGg==
X-Gm-Message-State: AOAM532OeyWaZb8uYda2gKZEgpjta/7FTRucHr9dmcqPOJ0QiGDePAdn
        GvTvp+fk+MXGIDy5qwnpeBLNoosLRfg=
X-Google-Smtp-Source: ABdhPJzZkVbg+/KP3hxWWenbisyxADwJJjgx2Sbpg7GnHh+b0mZddzLVWDo5CxEQ9mldrfhCo7yQDA==
X-Received: by 2002:a17:903:31cc:b029:e4:bd48:c8e3 with SMTP id v12-20020a17090331ccb02900e4bd48c8e3mr31323664ple.40.1617079667701;
        Mon, 29 Mar 2021 21:47:47 -0700 (PDT)
Received: from [172.17.0.2] ([51.143.92.38])
        by smtp.gmail.com with ESMTPSA id z192sm18394687pgz.94.2021.03.29.21.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 21:47:47 -0700 (PDT)
Message-ID: <6062ad73.1c69fb81.63adf.df98@mx.google.com>
Date:   Mon, 29 Mar 2021 21:47:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5680447450872005963=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v6,1/2] adv_monitor: split rssi_parameters into its own struct
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210330121204.Bluez.v6.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
References: <20210330121204.Bluez.v6.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5680447450872005963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=457783

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============5680447450872005963==--
