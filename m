Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDFEC433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4900720715
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AEy766Lo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbgERSNN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgERSNM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 14:13:12 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05274C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 11:13:12 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g7so3810759uap.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YR1d4UXEmFjNR7Y1gBIt8dbUg7S85JgRbyJVZPiIUNk=;
        b=AEy766LoSKCS9tRJqLmQ8eXHjd6CTGkG13kkjyRfr8RerSWhhwwtAQutlNvpijGw+g
         tAyMZi/q4UPtECrrPB7WdElU6oPs6M7zJdUK6GJXj2vTn5iRSEbnwcWAZ0OlhiuZv+Po
         1dwYV7bHLxCqNFwps10f6CT7PHXDI0v7N6MeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YR1d4UXEmFjNR7Y1gBIt8dbUg7S85JgRbyJVZPiIUNk=;
        b=Y+ApqduGCCxqSRiaAyEA3x1PeG/Ha3CiOn9uCaZOVFGpX/+57p91ffeGsSwycXdheb
         z+FX4e5mr7gwK7/61nyoSxr4Y1SWCtddrAYi8SrlRl76LuEnJX0Ph4qVZ5+8yvCm5VvP
         TJ992gIvfhrTkoKD6oQCXo+n8Z0DU06W0rJT6rvIunwM+qedRuP5LhrAfeipoh7MX7bi
         OsUq/5L8ROPF5EauhWkr+jEHhF3FTF88/W7PMKQvRempeRWlbWfhlNY1c6NUPws9mFFY
         uhSf0XtbAcvvLFMjHgja82hhggeahmDwWqh40vjlM5H+SCxcGr5hBYpVexnkmQrvBwPf
         jXCg==
X-Gm-Message-State: AOAM532lE+WvCgJPsbzcmeSY2dj58aZ6EjebDbjtsax/eBKTs6h//Kbj
        VguKAAzJ6FuyF2PMlK99df1fPF7g+Sh4SzI6OVUX2Q==
X-Google-Smtp-Source: ABdhPJwfNlsAPqdUXufA61B/Ydm/oJiD59x98ZHXZ4VEeSGl7nby7Ozpmih+bLDyGLq7VRWMT69tGjfOcWtFRuhNFVg=
X-Received: by 2002:ab0:6605:: with SMTP id r5mr4696251uam.115.1589825591243;
 Mon, 18 May 2020 11:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200514131338.v2.1.I68404fc395a3dbc57c8a89ca02490013e8003a87@changeid>
 <8BFF0708-07AF-4034-8FEF-C1D95975404B@holtmann.org>
In-Reply-To: <8BFF0708-07AF-4034-8FEF-C1D95975404B@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 18 May 2020 11:12:59 -0700
Message-ID: <CANFp7mUUJS9kxz5U+EMetfmDb=-Vn+Foz2G0ZuHTyuLCJmtDuQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Enable WBS support for wcn3991
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>, bgodavar@codeaurora.org,
        Alain Michaud <alainm@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel.

On Mon, May 18, 2020 at 1:03 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > WCN3991 supports transparent WBS (host encoded mSBC). Add a flag to the
> > device match data to show WBS is supported.
> >
> > This requires the matching firmware for WCN3991 in linux-firmware:
> >        1a8b0dc00f77 (qca: Enable transparent WBS for WCN3991)
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Rename struct to qca_capabilities and fix enum naming
> >
> > drivers/bluetooth/hci_qca.c | 23 +++++++++++++++++------
> > 1 file changed, 17 insertions(+), 6 deletions(-)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
