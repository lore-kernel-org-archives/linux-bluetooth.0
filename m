Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F83C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 06:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2E0204EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 06:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/tfZEJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgFHGa1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGa0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 02:30:26 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9878C08C5C3
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jun 2020 23:30:26 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so17329559iow.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2020 23:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIEkGNlMo92hWMOkovqMjniPcuk8xtuifSzErW1LVyA=;
        b=c/tfZEJzyiAxAZPxIVLzl87TLcrlp0kROx8fI9PftAReFP+GacpZWLBFwKEEiFrPcZ
         D9wEp98c+u2AWgoaTF20CdoWjpQmhpxIuVpony9f9eE5/gGys/LF9OSDNS1xdjxwjtoO
         V5a35tdvXFiB5JSRHm0fMZ24UiBVBHC8LQATut5+aXVw7dp3NME0GfLOOwx1nQQavrZK
         Pj7RRLtcQfsvBhpgdInslpW36oTk/1YPpR6o7CIGD+yUk8irFkfrx7gVkJxb1lY/Jz0Z
         4Qf9EbZBKkyBAnh3lfhqxSLLm/87IzwBQtpg+hHy7nBWYO8svC8BREZZrtLCDZcT3C1/
         GQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIEkGNlMo92hWMOkovqMjniPcuk8xtuifSzErW1LVyA=;
        b=WWvjFbB3oBjHKXQicc6XCMUZ6sR9gMNcR+nfMBfhEIhQyDM+YUhsU2slJgsUoZBjg/
         bpx+jNxvo57Ls/oDEIoMDmP+USku1JiVilfI+wrwuSMx5RWMgF3c0t+cNa2fXW+kNNsN
         5h2fumY8hcUvHhQaTZcFC7fQrYwgfmdGYPWp6O2U0z5PPmnA8fmXiIvAlqfuy9UXOsYI
         rMwwwpJYf7O8VKDp9xvmpWWQoHf2c/01jHjL+bv3T+eQm3d7B3Eshs5n6oe1/Ohu2IjD
         b3+bdbzyagos/wt0zeUbzfsExPR+fyLET5UXealDgl6Glm3KZZlI/aOF7aLiqG8qIiZf
         +sKg==
X-Gm-Message-State: AOAM531vz8eSPh1Zu5422VR1o2caL4loJqJf6VkH7ck8I32BxovTdTQw
        Dy3tSlAHpIdER/QknU5IVWtlxoP/1/g2fgxDdgKGlQwk
X-Google-Smtp-Source: ABdhPJxf85+FZ29e1dok3rmDQP9FVs9SfNDadqUVhbjAPEiYpMN/l8dcXJ6WW2HtyuEsCxJ8vrlqo4oT5OYm9P+5MzQ=
X-Received: by 2002:a02:a805:: with SMTP id f5mr21258234jaj.130.1591597825953;
 Sun, 07 Jun 2020 23:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200603171713.9882-1-sathish.narasimman@intel.com>
In-Reply-To: <20200603171713.9882-1-sathish.narasimman@intel.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Mon, 8 Jun 2020 12:00:14 +0530
Message-ID: <CAOVXEJLCrZUi0VNJKMBMwhe4-SvhifParsWHXY3TQEuqG_H5Jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] LL Privacy support
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

On Wed, Jun 3, 2020 at 10:44 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> Based on the input the patches modified and verifed accordingly.
>
> Marcel Holtmann (3):
>   Bluetooth: Translate additional address type correctly
>   Bluetooth: Configure controller address resolution if available
>   Bluetooth: Update resolving list when updating whitelist
>
> Sathish Narasimman (4):
>   Bluetooth: Translate additional address type during le_conn
>   Bluetooth: Let controller creates RPA during le create conn
>   Bluetooth: Enable/Disable address resolution during le create conn
>   Bluetooth: Enable RPA Timeout
>
>  include/net/bluetooth/hci.h      |   8 ++-
>  include/net/bluetooth/hci_core.h |   3 +
>  net/bluetooth/hci_conn.c         |   6 +-
>  net/bluetooth/hci_core.c         |  17 +++++
>  net/bluetooth/hci_event.c        |  20 ++++++
>  net/bluetooth/hci_request.c      | 119 ++++++++++++++++++++++++++-----
>  net/bluetooth/hci_request.h      |   3 +-
>  net/bluetooth/mgmt.c             |   2 +-
>  8 files changed, 157 insertions(+), 21 deletions(-)
>
> --
> 2.17.1
>

Gentle Reminder
Also, the present approach will only work for the central role.

I am planning to work in a peripheral role.
need help with a design approach on the peripheral.


Regards
Sathish N
