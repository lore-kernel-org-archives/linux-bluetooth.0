Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C115C07E95
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jul 2021 11:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4C161CB9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jul 2021 11:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhGGL3Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jul 2021 07:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhGGL3Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jul 2021 07:29:25 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7E7C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 04:26:44 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id az11so1395184vsb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=uKTx0Hu6QFtGSSwpkRnFIPAMoek4UpWiH5jpyf2f4UA=;
        b=EiSzCNPMXlUVTQqSbcqmNUkwbAiaIzNfKx88POpk0PKYXHXnHkO86X0wKzoVZPY+Qr
         WhxH2fsleX/n/0AZQoTH9vsNNMC8sG0AqPipVcriFGp4uUNSTHQ3mZHmQIqxeAD0t4HJ
         JV/jKYUgWsdPO2pKzy2CfXiSfLMrBfqwfQoimKBJ2fMWG5vykZ5rAnrpZFE/USgCJAwh
         KqyRf3E85BozZ5dhOO0efgOd1wTKUjb1cbUNcITEU8+EMh3Qj606v4nScsC8po0Wla1h
         zB+9jmGdWcQ3UEGKn1z9N0xZpWVc92hvf6aqOSh/bLvRnvJ+hEKe2t3V3/2XGcI1NO5n
         b8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=uKTx0Hu6QFtGSSwpkRnFIPAMoek4UpWiH5jpyf2f4UA=;
        b=fEtRT5H8/kumEF6XFm/VPDQt4sQwbjprj6FA/rTxJMxOxpERP92k7xM9igxYm04X6b
         rrCajqIIJuaQJbq1/93NEMop1mHyE5ZFlVpcybrGDQQs11xNfFFmuHa9QdniN3Aj3YYd
         hbMzgQBk2fcC1RKeqUmRhGcv88EB8HmoSfKVvZ/M+rtCU8i6ciFtCdkLg3ASij+mMWpL
         1MCM6IUDHkHpbP8+2+uXXxkPmTv+02fbdVEA9jeO/mxPiLDZ3s75Mp/Oz8xhjDwOegzI
         lFJeffavsux6OaOWad5DiWJ/nscJsFKPDYxi99JuOmVEq229MwKXbq67JBVT2L7UrGCO
         L1qA==
X-Gm-Message-State: AOAM530ujV5a3x6safLKqZGfJpP3vxfoECV20OGQ+I5S//20e2ek3hW0
        gkANkHIiZBFGYFm7HagC5+vKKlbAnBaD/nkfO+cG/8IADAk8hw==
X-Google-Smtp-Source: ABdhPJy6FCFgylkGFSySPyP+n9DTT6GiifoxJ5MnmB/jXW8N7Id/m7Nxde26TM9Axkmqfyro16O/h5WnZeRq6T6mAsg=
X-Received: by 2002:a05:6102:206:: with SMTP id z6mr19767061vsp.3.1625657203250;
 Wed, 07 Jul 2021 04:26:43 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sameerfeb05@gmail.com
From:   "sameerfeb05@gmail.com" <sameerfeb05@gmail.com>
Date:   Wed, 7 Jul 2021 16:56:27 +0530
Message-ID: <CAJ9BmNjk6+3osDj0ac1H+eUnMP8fbEnY9mNsb=USXnxBGfVR4Q@mail.gmail.com>
Subject: Bluetooth 5.0 support
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear All,

In below link Bluetooth Core version supported is 4.2
http://www.bluez.org/profiles/
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/supported-features.txt

Any plan to upgrade BlueZ to support Bluetooth 5.0 and above ?

Thanks and regards
Sameer
