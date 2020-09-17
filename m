Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15297C43464
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CFD21582
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P99vaB7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIQW1R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgIQW1P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 18:27:15 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1464DC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:27:15 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d20so4071692qka.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/9jdAMRjU/sKH6BoW5zvxbly3xZVYmRR5UC7HJNZphk=;
        b=P99vaB7D7AkdIWx83xM8k85/yJnEDoO24YXcNYYfbPOC5GwzDCZDjw2HsHywpduB38
         09i+Yssmg/dlgXeNNf1UALMHP1z2tNlVdPpU8L8zEkJJ87Kvguif9AV1CHdODIBiAo1o
         GlpdPMTaMix1C7ZfoLeCq5THw2bOOF2/0e2VEp53Dp6WxJ+5ZxpFruqeabZk6xKI5ZCy
         GiN6H8HzRm4fF6ulrlMePo/ejGgI2tvVxv7f/tAx/DpkI+vg+0z0tyJyOnwIoFTBzFEN
         vd5Z1Lusz87fCbthaXwuAJYhTERqZI7Db3+9kM+pkbGIwOoJF2dI8IbGxXvNeRDWt8CK
         Du0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/9jdAMRjU/sKH6BoW5zvxbly3xZVYmRR5UC7HJNZphk=;
        b=S1U76M4uBkZnTdTlVvNhqliOMAV70XyZsZllwGyGVpbSf0ZuoCuJiNTvhrluhn35uy
         ofyEEZNQS6Rg+PaFpz1aiQRkrZ0dF4d8gFk6kjiXU3O87DfbL2Xo0cDtjRhIva9Y50We
         j3abG/8Ty3i02aeq6FDnr6lZF9vpcew6GOEBLZIP8l/gFKwuSnknny+I8otMxaq6XvrL
         NR6U7d1cXitQeaXoDkVv6W0fJyIaaJ90nCe7/dVt38uniXGeiC2/T2j6zySfjQvB88rS
         5Z5/NwpxluqMue9lxSHMA5/tHijgbH/j7Hxc7twjL9Tw2gFSzs2FjsgmUicDjRbaAMbh
         PDnQ==
X-Gm-Message-State: AOAM532GfEt+oxh+mXP6++9sXviYe/NL8ISayPTFoeMZJPIelO2ZMvFX
        XDr5WNsi6NEtzO+NTdppNuHS9XiSUZ6E/g==
X-Google-Smtp-Source: ABdhPJxKOqj50PuwNkBzpDw1ekH2Wyh47BaOXrr2iGO8tqSbxYizZiZC3cY5x61WvFYE/8R5E4sGpA==
X-Received: by 2002:a37:9c4f:: with SMTP id f76mr30933802qke.250.1600381634064;
        Thu, 17 Sep 2020 15:27:14 -0700 (PDT)
Received: from [172.17.0.2] ([52.138.83.123])
        by smtp.gmail.com with ESMTPSA id o13sm812840qkm.16.2020.09.17.15.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 15:27:13 -0700 (PDT)
Message-ID: <5f63e2c1.1c69fb81.81a86.5be2@mx.google.com>
Date:   Thu, 17 Sep 2020 15:27:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0979735859871204913=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v2] a2dp: Keep track of ref ownership of a2dp_setup
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200917221034.154218-1-sonnysasaka@chromium.org>
References: <20200917221034.154218-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0979735859871204913==
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
28: B1 Line exceeds max length (81>80): "    frame #5: 0xf679523c libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3182"
32: B1 Line exceeds max length (85>80): "    frame #9: 0x0c65a7ea bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201"



---
Regards,
Linux Bluetooth

--===============0979735859871204913==--
