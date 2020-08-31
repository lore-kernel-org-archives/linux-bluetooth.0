Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1351C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 16:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8972073A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 16:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOJbznAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgHaQWj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHaQWi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 12:22:38 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D062C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 09:22:37 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v69so5455682qkb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=i5Ogqg2VyQTNNv++3yisqgKyfKOopi3chCdAdD44Hzk=;
        b=LOJbznAoM3Fed20IrO6FkRQz27mRoH6hsOAp0+8mTKJMICznfBfziZZKP55RMl9IjM
         D4ySrjTQvJTu2rpz3mNSeRPwDzpxjmAmJ4Q++MSXY1POqXHeEJ0z3g+8NaPxf4i5ClPd
         R2UpOYlOljCD4DT2CrdPNUzU1jZsp9Wk5pHrz4b//us4CD7dzgbzK1Tbm01H75m1Nb4e
         7jPskDxv2g6kDoO7JLSLicvfdlkOFJn+9qDcBy4E0hJi5Bp2RDJ+9rd2Mp6uq9Hp6DA5
         ivgYnHjAZSB166OD9gpBiWUVcp7EahuMfJJN158jEDW2fIO2H44LZPzsMPKTIe1JMWR/
         vnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=i5Ogqg2VyQTNNv++3yisqgKyfKOopi3chCdAdD44Hzk=;
        b=tJ6DUsursW68lZgyBCLuLLawMLoDzfuYpe1SBMrVL7wo90VjkvapqNzNXkH/H3/Thp
         k1TBMzyJAdUy1emXBBHaQfDrXg6EKa1RxHJv1Tl7NjLvsJk+l1Iw1sLtiLYBncyioDak
         k+jBlhIxzk647F61iPfnpYb98Pbjj8eHfz8oEu5M46oqP/vlnai+ewYdVToPBlUByzfY
         bsjBQSC3krn8MXxkbbFJwI0SewbyPtgpC6czyZgwwbRG4p24wVGji7gjfPPCjEFqSGml
         PQJsGah1sHKjnbD72AGIkcP3yN1jE2rYsAwF8MryRkyJ0p8iWmfURubAPs/q+7L9eqvI
         Erfg==
X-Gm-Message-State: AOAM531QGTJAPPMEmxk9zGMxNzteg25JGksz1Je+jZBHc2htEeBCE0/N
        j4ETtxfTZtr7TqdcM5jSXYn/LRWEK07/Rg==
X-Google-Smtp-Source: ABdhPJy8fO5GYyr3x29TBggmDcbrBqUPA5eCD86Hg4rnWgHUxzwFog8FX/nLxTmHUWIZVCputEuFMQ==
X-Received: by 2002:ae9:e8c2:: with SMTP id a185mr2133165qkg.435.1598890955127;
        Mon, 31 Aug 2020 09:22:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.41.23.82])
        by smtp.gmail.com with ESMTPSA id s184sm9612029qkf.50.2020.08.31.09.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 09:22:34 -0700 (PDT)
Message-ID: <5f4d23ca.1c69fb81.2cc03.2119@mx.google.com>
Date:   Mon, 31 Aug 2020 09:22:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0515897717102264515=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, daan@dptechnics.com
Subject: RE: [BlueZ,1/1] Mesh HCI interface init scan interval fixed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200831161116.15975-2-daan@dptechnics.com>
References: <20200831161116.15975-2-daan@dptechnics.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0515897717102264515==
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
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============0515897717102264515==--
