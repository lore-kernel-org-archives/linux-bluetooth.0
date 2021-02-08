Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FFAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 22:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5387D64E8C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 22:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhBHWIz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBHWIw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 17:08:52 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBCCC061786
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Feb 2021 14:08:12 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t11so7469269pgu.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Feb 2021 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfGJM1B9OIrbuPlkv98uDVFWRd1DV0wM9reH2v8c/Co=;
        b=kXrIaAK+nULmMEool5khncbyj62V605Wy8lXRfH8z0wdtraZtOZzEKTmYPzIXZe2ij
         hmTdKzOxRsazUWJdXb/76ttwX5yX9vtqMUWizruqsMKpWJSYBE2j5IEGhb/v2EeIw2mk
         Y9Fh1wj9rSpphY34+70cXDlbBI8RloIgBdqvYrfQZQg8Nyob3sSk4jFI9LmjaW7UaJnD
         3G3BYqmONVI+QSGUNeBFoAJxj94YVRTnJX0ectE68uzMQTX+e/3L+Xk5gD+/U09ZG+Cf
         B9XP0x7e3ZGKe5uKL5Acmbxd4jxvjhAxXR0FAQCek31Txe4pSD8imqQ1C2Wn5TEBbByb
         vWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfGJM1B9OIrbuPlkv98uDVFWRd1DV0wM9reH2v8c/Co=;
        b=fg3wM6XROX7T6ObKKsgqf07l6IV07kaRijOrCk6RxykndxhtkNFxjLc1Hij1ZOQyvf
         I4ItVztg2BX5FP71ex9wGeGNFUE2uqNstUaJpnx1o/0ZBzOP2GWvSZbOEFH49aM62MXv
         qyw6vY9qcuKeNRfN6j5FCYeG+kvHcu62h3jEQX/+lEEFipZgk8gw9zg6jEwBctVeCHE+
         /RkXizcf6427IQQIGL2RMxABt1MAxzHyiSfNyYB7oAjF4hruGgRomTJ0GDAwlPfii7X5
         kMVmpxxWdMZpkefM2KqQPyQyUMiUHS0TIrhg7i/0vsid2ij1QpRDBmv1WVkJkiX3GV1m
         0LTQ==
X-Gm-Message-State: AOAM533PGDSjfDR3dcsFzS3Z2VEohQcxUh0yyGbvFTMhR+ka/IdT+LTK
        dU3aOA7DKiuYiCd86Jyxag+zrbIF7v7P9sLXnPY=
X-Google-Smtp-Source: ABdhPJzX2uZjHHgk4utD1wL4He9/ktcXcx5FlNB9DIzCuBkb5wOiWGVl8IfhsiVtAo8VOLEAM5Zox1nVgRLAAdrepik=
X-Received: by 2002:a05:6a00:7c7:b029:1de:80cd:46b8 with SMTP id
 n7-20020a056a0007c7b02901de80cd46b8mr4892095pfu.63.1612822091793; Mon, 08 Feb
 2021 14:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20210206141423.13593-1-matias.karhumaa@gmail.com>
 <20210206141423.13593-2-matias.karhumaa@gmail.com> <1F3AE31B-17F0-4FEA-AC75-472DC7C8E1B0@holtmann.org>
In-Reply-To: <1F3AE31B-17F0-4FEA-AC75-472DC7C8E1B0@holtmann.org>
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
Date:   Tue, 9 Feb 2021 00:08:00 +0200
Message-ID: <CAMCGoNwZe+veGUpa-A3W-4y_t2A6f7ovtnmzre3P8NnLQn7iiQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: Fix Just-Works re-pairing
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> I have a concern if we just remove such a comment. I think the commit message needs a bit more explanatory and this needs a few more reviews.

Thanks for taking time to look into this. I have just sent v2
addressing your comments.

Best regards,
Matias Karhumaa
