Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1518C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7572073A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 20:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au20gHVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgA1Ub0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:31:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43318 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgA1UbZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 15:31:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so13325290oth.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2020 12:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rzSJ/zEsxngI3ZUM6NCNQhN1RyuO520Wvkse8L9qrE=;
        b=au20gHVhidJI4KZeMASQYwCQ25MY8z7jAWl2eDhO9yvwfN0Q4iU3X2vTyw9DozLg3S
         vjrx7z0lsW6adSHzj0HJkOl6uQ6oo9vFlkbB5aK/tm3+NQ9O2yAG+yoMPFlQ6layxpLH
         NXYVf1QCeFaflqvC0brfWMPS9yEqlFpZnSR5OjceGXbbCbJFhAJ1fUvu7BYqNzz9U5M3
         sO4OZ2hebiPO5/JKXVCNEW9eWvoh0Si8nwe8lTHxJY6yUezh8t+nv2AILCtYR4hgRtBC
         7JO47sAih1/QEeBUzxMY5MMxt+0KUJN/L0UL1D8/gGpidHcMZ3e80DmCDq0EXm1nY1Hc
         cgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rzSJ/zEsxngI3ZUM6NCNQhN1RyuO520Wvkse8L9qrE=;
        b=uD2P9qv35bTWNWxySRJ/ul46X+/630RrobYFYlOA4zz0/382uLucCYKGu8BDV0LOEk
         97OWesMAg9/Kj1CJBew0BGJ3PwaM7HPszsu0RZEAmadE1lUgTSPNnh2AIUckhqsZVNnN
         QnjavFVxiROPSAn1lTyZZYM1yXlYiPI4GIqBkbemELoEui1Aapcbt2Spqifqu6CLugcp
         KQ7jbagLDky5kS3Eha49RPKfwzIqq3hxsSttYsU341UPqasKdUL2A4tovhoEFv7arC+y
         j/nOn6J/2Rkf2uKNjvvZqohi5oDY3DMP+6L1c8jTR2mMpeTATALm9zX/X0hiEU8uvWOi
         hZeg==
X-Gm-Message-State: APjAAAWKApxbCFpsDWO1iyENY/yXkzmnzNsK5+NFjJ8dK1UFnO0570vA
        4mGyHauT2jdasQaBqH0clG3bbKNKekAEnS+AqME=
X-Google-Smtp-Source: APXvYqxEWI8Xz612olrLuwE8ui28upYioCKurVrZ613rXrSQ8W+8MHzwh0/VoWylgDEuIG44k0GrA09kYWrRjdj2xOw=
X-Received: by 2002:a05:6830:1498:: with SMTP id s24mr10474045otq.79.1580243484938;
 Tue, 28 Jan 2020 12:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
In-Reply-To: <20200128020505.239349-1-abhishekpandit@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Jan 2020 12:31:12 -0800
Message-ID: <CABBYNZ+fRVSBxbX-3D-WxK=Z4TxnkHbWMPusv+owrRAsKdEOkw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3 0/5] device: Allow devices to be marked as wake capable
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Mon, Jan 27, 2020 at 6:05 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
>
> Hi bluez maintainers,
>
> This change accompanies changes in the kernel to mark HID devices as
> wake capable so they can wake the system from suspend. The
> implementation depends on the Set Wake Capable management operation. It
> is currently a separate management operation but it may be added as an
> extension to an exiting operand like add_device (need some feedback
> regarding this).
>
> Per request on the last patch, I've moved docs/mgmt-api.txt into its own
> patch so we can continue discussions on it.
>
> This change was tested with appropriate kernel changes on v4.19
> (verified that HID devices were being marked as wake capable in the
> kernel).
>
> Thanks
> Abhishek
>
> Changes in v3:
> * Added profile_wake_support and made wake_capable dependent on it
> * Added documentation for WakeCapable
> * Mark HID device to support wake from suspend
>
> Changes in v2:
> * Separated docs/mgmt-api.txt into its own patch
> * Added dbus api "WakeCapable" to set value
> * Update device_set_wake_capable to be called by
>   adapter_set_wake_capable_complete so we can emit property changed
> * Newly added to show whether device is wake capable
> * Removed automatically setting wake capable for HID devices
>
> Abhishek Pandit-Subedi (5):
>   mgmt: Add docs for Set Wake Capable
>   device: Allow device to be marked as wake capable
>   client: Display wake capable property with info
>   doc/device-api: Add WakeCapable
>   input: Make HID devices wake capable
>
>  client/main.c           |   1 +
>  doc/device-api.txt      |   5 ++
>  doc/mgmt-api.txt        |  19 +++++++
>  lib/mgmt.h              |   9 ++++
>  profiles/input/device.c |   1 +
>  profiles/input/hog.c    |   1 +
>  src/adapter.c           |  65 ++++++++++++++++++++++
>  src/adapter.h           |   2 +
>  src/device.c            | 116 ++++++++++++++++++++++++++++++++++++++++
>  src/device.h            |   5 ++
>  10 files changed, 224 insertions(+)
>
> --
> 2.25.0.341.g760bfbb309-goog

Other than the small comments I had this set is quite good, does the
kernel support has already been merged?

-- 
Luiz Augusto von Dentz
