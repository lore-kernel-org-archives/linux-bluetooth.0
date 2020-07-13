Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D004EC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BAE20791
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eocS2KjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgGMGRe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGRe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:17:34 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E892DC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:17:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k23so12203294iom.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gj7c2u/6Xj4mWnH3j6aEe5TRH2mmbMZCrZufKif45fA=;
        b=eocS2KjVFzniq451GRWftEmQK0Rziw1optkroY/jV85O4iAYswEGWXkdg5Ac6xOhi7
         zWeGq5u5BxHcuOdZNMjKPJjhQxS91XkaHO1ZJXgMQlZgw7cTsixvT7BnlX83PmIVFCCx
         e2alrWDAafkQb9FuE86qNRrrxPbWZ7UlSdId6fwnZIsING613+jCUQSeIJOvfUAyR1wo
         BTp+FfUzPQHuZKWbgxt1IMFJY1AE9CYNnKDpCe8UfSppwk8N2/hlBjbHzlto9D0A8+E9
         notOoZLe8/T1ANJg09o/WurYi7PCy8MciE0OvM0nbxYjNZZE+wm6t6IxLk2RTL7rCmgh
         grOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gj7c2u/6Xj4mWnH3j6aEe5TRH2mmbMZCrZufKif45fA=;
        b=rTA8jByAsWMRzAO22GaXf2EI0J2TkLLN4InkjcZrcNG5GU2ZUewtCC+WY1P2Cx+Hu8
         AgeSVfFFY6aYkRHJ1SgAdpIF8AvCYgeesVN0hCEhfN7kzj6KXTO/F99NUpp47TZU8cFH
         RLtEyKD82i0zA2JloS3Gt1DF6qNa6m6KyHLXEuyDJcNSY9APQbSiZHkwRkxUELqg9hAJ
         1WKlh1vley1fdoHmgj0psE69bq5TuSYrZhKrsrFcwGcXM1zd73beXBnI5wXGUUjCUuR0
         x8/ssR5UFaBTP5JVsTfMIxIuVWupCzpwRU8/ekoYJW88QsypUS0gHkuQCoNRA1DualYE
         y3WA==
X-Gm-Message-State: AOAM533BqM+2Dv9NnNPPFzFWkbAnfm5Xjt7m3yEETFwfVSa+eI9Awqtx
        EsH4+UqfE9dwcCGCUMYpaTXaQxdpjejmfEWOkAk4705O
X-Google-Smtp-Source: ABdhPJzS5UktmnrkldUOpvqq5Zlx+xxS6td3Bvics4XsH2o9MOoVWGC91pR5BUDKb4VQZYhvfyw+kAqbT3E/gt7VqDg=
X-Received: by 2002:a05:6602:21c7:: with SMTP id c7mr59628814ioc.1.1594621053137;
 Sun, 12 Jul 2020 23:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200713061220.3252-1-sathish.narasimman@intel.com>
In-Reply-To: <20200713061220.3252-1-sathish.narasimman@intel.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Mon, 13 Jul 2020 11:47:22 +0530
Message-ID: <CAOVXEJJfx367B3M=+nBYztJ1-OMX-Xkj8BknmZ2tQZurJuTyZA@mail.gmail.com>
Subject: Re: [PATCH 0/8] LL Privacy Support
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Please Ignore this version as failed to mention the Version in the Subject

On Mon, Jul 13, 2020 at 11:38 AM Sathish Narasimman
<nsathish41@gmail.com> wrote:
>
> V4: patches are rebased
> Added support to use set Experimental feature to enable controller
> address resolution
>
> Marcel Holtmann (3):
>   Bluetooth: Translate additional address type correctly
>   Bluetooth: Configure controller address resolution if available
>   Bluetooth: Update resolving list when updating whitelist
>
> Sathish Narasimman (5):
>   Bluetooth: Translate additional address type during le_conn
>   Bluetooth: Let controller creates RPA during le create conn
>   Bluetooth: Enable/Disable address resolution during le create conn
>   Bluetooth: Enable RPA Timeout
>   Bluetooth: Enable controller RPA resolution using Experimental feature
>
>  include/net/bluetooth/hci.h      |   9 ++-
>  include/net/bluetooth/hci_core.h |   3 +
>  net/bluetooth/hci_conn.c         |   7 +-
>  net/bluetooth/hci_core.c         |  17 +++++
>  net/bluetooth/hci_event.c        |  21 ++++++
>  net/bluetooth/hci_request.c      | 120 ++++++++++++++++++++++++++-----
>  net/bluetooth/hci_request.h      |   3 +-
>  net/bluetooth/mgmt.c             |  54 +++++++++++++-
>  8 files changed, 213 insertions(+), 21 deletions(-)
>
> --
> 2.17.1
>
