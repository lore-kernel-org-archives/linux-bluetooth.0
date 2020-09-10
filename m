Return-Path: <SRS0=wtMD=CT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9F1C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DD6207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Sep 2020 04:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7py7RlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgIJEsP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIJEsA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Sep 2020 00:48:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6B6C061573
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2020 21:47:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id k25so3907618qtu.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 21:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dRJXS6ZKSWz+MF1RiAgo9X2u0aseXPtPiJ6GHIkJpRk=;
        b=I7py7RlJ2hGlvd86wNvkon657dwVWoj5Ct/TlH8OdVDVOcT53GkQBbqyv7X7VEAVH+
         Z+vsen4QSfNqeMVXj2brnhJQlUwxOcCwDbpbPA9jejd9AJmb/WKukuXn8IExp30S9DSp
         NGPZIBug2O/b7VTjcw6AvxR8Wed5CkH1efxICbf3xwnWngUqbZVOX8HZ6wGkGiNT5WAx
         VXIfcwgPr3byuw2S181hv4ZSqvTr1vEcYQNtQ6DA+NKfafcuBcEhGO9rBGurX3CtQEzx
         A3NvC4ShZhhBQaZgNAVu2vb2u6bUtdwcGzMysNHEJBHeAPCLbOqJDd50BpNX4ZVb+nOX
         WTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dRJXS6ZKSWz+MF1RiAgo9X2u0aseXPtPiJ6GHIkJpRk=;
        b=pSqkGm7UNx/XtJ80BJ9/5Q2SdUDGNolnJIv5pxAhFM3XT5iiblO/MOFNBY7DlAvw4i
         1pZtLI0F3FTSbFl7aMb/Ucu6N0vEJUZM/+OQguMGheVHyBIwMjyaJD04WbJgDzDd3rSV
         UyK49hBLRMcQi1o4hLq73Q6U9eUIJbSBQ1DxhgEcIm1/kwGstCiBOIOogEOy1nkw9Qze
         kz4z3NzA3NBXO7kLigGOz5kYAe3Gi237NUh+fD6XUCNuowH14y8VluY5YPmEQuEVtosF
         HpQCE+lgK3ZOzydTUoXCnivrHx4wSNV8O9/EP7OOkN8n1cf4JwMKRA4FxHxGCEpTR7cs
         Cpiw==
X-Gm-Message-State: AOAM531c+EJrPTXU4nJGL3sNf6ZGp8wU00B0tAwCydEnmURrFRCNfn/W
        hL+TiUzvFLKGcCQsj/1w9TM6hm502qHOeA==
X-Google-Smtp-Source: ABdhPJxOABUD0h+HZGeunL2TheQnMt82LLsHZhS5+wFMZ3pLtKXBFo3Y03D5Xx5b9vV5zPdXEW7Lxg==
X-Received: by 2002:ac8:4d07:: with SMTP id w7mr6434161qtv.243.1599713278438;
        Wed, 09 Sep 2020 21:47:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.25.207])
        by smtp.gmail.com with ESMTPSA id g37sm5667580qtk.76.2020.09.09.21.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 21:47:58 -0700 (PDT)
Message-ID: <5f59affe.1c69fb81.298d4.accb@mx.google.com>
Date:   Wed, 09 Sep 2020 21:47:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8446680284482479787=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v2,1/7] PRE-UPSTREAM: adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
References: <20200909213423.BlueZ.v2.1.I205718871f4e636958904f3cfb171cfd381c54b1@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8446680284482479787==
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
1: T1 Title exceeds max length (85>72): "PRE-UPSTREAM: adv_monitor: Introduce org.bluez.AdvertisementMonitorManager1 interface"



---
Regards,
Linux Bluetooth

--===============8446680284482479787==--
