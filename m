Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2F7C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 17:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E5560E93
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 17:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhH0RGz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Aug 2021 13:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbhH0RGz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Aug 2021 13:06:55 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E54C061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 10:06:06 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id r20so3824263uat.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mzU7qmWvuN7RWY2+VxmfWsIgH+Y8NukagrSMVL1yhk=;
        b=h/JsghKe6eZpIpJD3NbqObgOhdJt4IQ7cJSZl47DYqdZZapYiEC4Rd0phMnFl8wRWI
         fK9RmSXM9XEfYngeejyanaEteF1hkZgwlyNS7koH5Qtdo+82B+cf5eQGnp5G4W0Pd12u
         woaOs3kWQwie6uEpZVr1u2JtM3FtrH/zK1LEbr7hlLCbup9JPBwe7O5T/aM9B9fx3/WA
         JnZEvpXfQvazN2vW3JfMaSo1iPPraSjXrFvNzIgxjCZWGyEwZCBE2jJf1xK/dyEP1d+/
         djBOBFEgYKklWv9vf8EOSbPvgPXMSeYJfnnxrkY268GX6RSSMIDW9niM+V2ZsAtutVhr
         SNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mzU7qmWvuN7RWY2+VxmfWsIgH+Y8NukagrSMVL1yhk=;
        b=iGm95GSbNk6wGuR65FjhS4wOh6IKaB4XYj1InHe3g7bW2Nw8j5ZPQaFkiaeIAJMPRp
         fo7a+WtuAJYycwxQwJwJLnoELAalVaUesotgToKUXPqW0EMDsJUGWQw7lpTWYXFFr3cS
         NPfEjoKnE7hit3C38JUw+cN02bWe/3GEkdG7cljGp7nLXBXtn5K0nSYuvK1LwjgOpNvH
         uNlI4Y984HUvrD+Ak4Df1krARqKo/PtSf8sfHOXBzLtg/NuQzmtFtZS9iYPD1GglPdjl
         ZC8+IiOFCD1NKzpDtiXzpVJTQojn3voA9wc1qDVbC2wyNh9q4CrcLhx2p5i1uEZ+zrdK
         m/Qw==
X-Gm-Message-State: AOAM531X1P5qlJifCDfbBimthMsIleGXSkWmvbni6wmn14Bw9kpvKF0q
        0l7S7D51BMIqERhVwBm6O5vwX1aWXRpZhD2iMqZ13v6G
X-Google-Smtp-Source: ABdhPJy/42oEDrY6/pDabSgDjIxH8qZLGq0sn76+zj2/PRSB8Ls9gJ94MdHYDuC9fTyKv9uBsJzg4Bt4loX9NP2cFlU=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr8161779uar.3.1630083965041;
 Fri, 27 Aug 2021 10:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
 <61191554.1c69fb81.89ead.b7d9@mx.google.com> <CABBYNZLcEctR6=ovTK_CABqkKgU8UCKQQ30VsVsAJkdEA+xY0A@mail.gmail.com>
 <CAHFy418ZxGDjGvr9RBkKAk1FJa9Lq6jB1D1esnJmX99eKadJbw@mail.gmail.com>
 <CAHFy418sMhHOc1SAZ01P0qOAcWVfUGo3=0TC_9KSqs-2xscNUw@mail.gmail.com>
 <CABBYNZJZrVv-kNFaV7RbEH8i3TGzuXMkcRU1Lt6tngs_qoAvFA@mail.gmail.com>
 <CAHFy419xvgeU7KUhXj7xDvOJ30KMJTWx7rc3d9uidNZFmEg6Eg@mail.gmail.com> <CAHFy41_mKZ+qaXbUoVgwCBQ9E-kmZabcn3hnVoswf1MOZ3CQnA@mail.gmail.com>
In-Reply-To: <CAHFy41_mKZ+qaXbUoVgwCBQ9E-kmZabcn3hnVoswf1MOZ3CQnA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 27 Aug 2021 10:05:54 -0700
Message-ID: <CABBYNZ+=UfXWgXQpGmvBs9HikYzauZ=jtvQK9VW=qDcAn-2omA@mail.gmail.com>
Subject: Re: [v9,1/5] Bluetooth: btusb: disable Intel link statistics
 telemetry events
To:     Joseph Hwang <josephsih@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Wed, Aug 25, 2021 at 5:02 PM Joseph Hwang <josephsih@google.com> wrote:
>
> (Resent in plaintext mode)
>
> Hi Luiz:
>
>   I have fixed the mgmt-tester on the bluez side. The "Read Exp
> Feature - Success" test passed on my local test setup.
>
>   Please let me know if there are any issues.

Applied, thanks.
