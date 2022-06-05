Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE24FC43334
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 12:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbiFEMiq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 08:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiFEMip (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 08:38:45 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8995831226
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 05:38:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a30so2612974ybj.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jun 2022 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPBRQZit+frysiswJmW7l8KQz4Nt3cvgksLt6M1PHGc=;
        b=OfloKZSq4RGAqyqHoHtzPuMCmuMdR/0id7xESYd99+YAW4Yo3oFsR/tzwQyUcAtVTt
         WDrgm3PGPU4HKwlAEVwaw+pQmabbVMiuCSUsI0gGffI8euanbS461OW0K/2zoUVXN/4f
         gMrnBEYEV4WVf4I3+YlFsk/ANKarOMLQytzacUBvdr2r8zPPicLwXpSDvDj/IGBHggOS
         PL5Itsp1X13ZXXR0IEAmODVgZxl+cSPfnIR1d1AQggFhaVqmweuZva7F2iC7gEGffX6C
         BzRqJT6zYvqqwJlGdD//8HezsM7bpJqqcRRHN4dOxVE/iywTwYfYBPGuxo4ZLLr6K6kD
         oFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPBRQZit+frysiswJmW7l8KQz4Nt3cvgksLt6M1PHGc=;
        b=OKcPpTq+xMhqL4FYIUFUHQxAX4FflPGn6VqX+fsOaDRObh7sbO2v6skox2hdfZbcs2
         Hl3MhL6zioBzThSVQvRSb1uqwybsAvgpEa2YnQrsEqQKqDVjwnqHJ2R8jU0T9Bgx9P7E
         AepwCas0nRUhv7/WMde1GeK+zZ8qtq9BUBGHV3/X4aBctfuIvkaKOMA2nBkcxYJXzKOc
         5WUkpdX6c0gdBeroEJZjHtKg2l6HkQ4wjlQEjoZYPl5eYVMQramy0o1yJ5C1pFN5zWmQ
         H5gomWQU0/fhfMpp6mUfmX1WyvbgCComHOWeaTdzlr+oewi+wMzuhHwdAc5PAiVeN+TO
         2b1w==
X-Gm-Message-State: AOAM532GPgc9n6MXTjQhumVnCjtQPe1+NWO1A5HuNzL7msPPnj95IJz5
        3yna91oWXV0NbzpGDxjK9duvFEDm3fzybWBAGxX1gA==
X-Google-Smtp-Source: ABdhPJxBGQnupilQOyf9rrlU6c3WeJG8AAQAuDN8QRcjRs1QutMeyOSeLU0F84axDRQozVZa301nvX7xFaI8KUqhmWw=
X-Received: by 2002:a5b:691:0:b0:64d:ab44:f12e with SMTP id
 j17-20020a5b0691000000b0064dab44f12emr19698207ybq.533.1654432722820; Sun, 05
 Jun 2022 05:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220605065614.1332-1-linmq006@gmail.com>
In-Reply-To: <20220605065614.1332-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Jun 2022 14:38:31 +0200
Message-ID: <CACRpkdZ_9c44Vwg+1tbnnjgT_fr6A=GviKPVNanYm25yscsB5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btbcm: Fix refcount leak in btbcm_get_board_name
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Jun 5, 2022 at 8:56 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_node_by_path() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() in the error path to avoid refcount leak.
>
> Fixes: 63fac3343b99 ("Bluetooth: btbcm: Support per-board firmware variants")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Oops thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
