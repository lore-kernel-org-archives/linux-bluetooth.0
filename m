Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0634C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 22:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B086C2072C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 22:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbhAYWXq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 17:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732103AbhAYWTO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 17:19:14 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A18C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 14:18:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i187so9818835lfd.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/Q6Oc7PeuEcOpsoTdR6W8VQQNB+BX6FWqtQmvephYI=;
        b=TGVCNCPSNbUbsysH6Tox8d7pwWgph9ObN+6ge3dhPh5MKc6p7Z5wgPqQ2NNKfuCzZj
         L1KLMBgdwttsYm/V0TBJ8Czaru+RbXH1bym7El17fcwB/A0PYkUidXKrhSUaqWqNj/0p
         bM2jSpOBuiRZIfYYmyDd6ql/u6wBz7OOs5lcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/Q6Oc7PeuEcOpsoTdR6W8VQQNB+BX6FWqtQmvephYI=;
        b=s+bOnUR8JbUo56SxXUtKLSRLNcO+EmYwdgp4fnAGxvopNdX+bgjgOO99lJIfcKwi9B
         2CAunUhCHLo1V7FHhN9BOrApU/40/loFX1MKkTOQnKzRp1p+ZLleC3a4sSbiaM2zng9z
         3OyGcNidifq3MNDpm7e0jRA3qjUxT/XfFM/d2qsIzKzx+dZsHAQ0AbIwNe43TCkJdaed
         5ntTJ+SYsPesXKsPub3uxAdoILTE8sBBAc2y9UoT9zOImxCP3JJdjPzE7keiWiOpBN44
         kfjK0P7VWLROC/w/ke9K9BUZVXIUG+KrE0GYb4qo+FKzft4XvLaPQBdXnWYyf7rH5urz
         XfCA==
X-Gm-Message-State: AOAM533naca8Y2FiR/NYBv2gwWV0UnDqJaNUMhHUO0te4txzTHAnEqe2
        otAhhqJ7v9E1pP66hxeo6fCpFmc48TK/zwl5SwAkgQ==
X-Google-Smtp-Source: ABdhPJyai8NTk2KgZnwz2fp7w8KnZGavKufSHn1oqZr7KwEuq5/gI61Hrs6tOhwWfyUmve7sEMkTiksFvcUnNBIRE0I=
X-Received: by 2002:a19:644b:: with SMTP id b11mr1179908lfj.358.1611613112276;
 Mon, 25 Jan 2021 14:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20210121163801.v3.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
 <070E7413-A3E3-4FEB-80BC-D3DD922DA19B@holtmann.org>
In-Reply-To: <070E7413-A3E3-4FEB-80BC-D3DD922DA19B@holtmann.org>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 25 Jan 2021 14:18:22 -0800
Message-ID: <CABmPvSEtpmz5oK2ZshRm0+HhoLL6rig92v9d63ocpy6m7MvUdw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Keep MSFT ext info throughout ahci_dev's
 life cycle
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Jan 25, 2021 at 7:13 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Miao-chen,
>
> > This moves msft_do_close() from hci_dev_do_close() to
> > hci_unregister_dev() to avoid clearing MSFT extension info. This also
> > avoids retrieving MSFT info upon every msft_do_open() if MSFT extension
> > has been initialized.
> >
> > The following test steps were performed.
> > (1) boot the test device and verify the MSFT support debug log in syslog
> > (2) restart bluetoothd and verify msft_do_close() doesn't get invoked
> >
> > Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > ---
> > Hi Maintainers,
> >
> > This patch fixes the life cycle of MSFT HCI extension. The current
> > symmetric calls to msft_do{open,close} in hci_dev_do_{open,close} cause
> > incorrect MSFT features during bluetoothd start-up. After the kernel
> > powers on the controller to register the hci_dev, it performs
> > hci_dev_do_close() which call msft_do_close() and MSFT data gets wiped
> > out. And then during the startup of bluetoothd, Adv Monitor Manager
> > relies on reading the MSFT features from the kernel to present the
> > feature set of the controller to D-Bus clients. However, the power state
> > of the controller is off during the init of D-Bus interfaces. As a
> > result, invalid MSFT features are returned by the kernel, since it was
> > previously wiped out due to hci_dev_do_close().
>
> then just keep the values around and not wipe them. However I prefer still to keep the symmetry and re-read the value every time we init. We can make sure to release the msft_data on unregister.
This patch does exactly what you described - keep the values around
and not wipe them until unregistration of hdev. Since the only thing
that msft_do_close() does is to release msft_data and reset
hdev->msft_data it to NULL, and that's why I move msft_do_close() from
 hci_dev_do_close() to hci_unregister_dev() to release the msft_data.
If this is about naming, I am happy to change msft_do_close() to
perhaps msft_reset() or something similar. As for msft_do_open(), I
will change it to re-read the msft_data instead of skipping.

Regards,
Miao
