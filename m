Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3E9C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 16:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7B120866
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKX3NGBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgHaQwM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbgHaQwI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 12:52:08 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32113C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 09:52:08 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e14so3574257vsa.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2wssN0DfVl0Q5ulsK8rehD0qys9A1UTSyxawRAlJec=;
        b=PKX3NGBdootImldgizkUZ9JNq2aRTpLy+LDPXgaGjN67aJZcX5pKbxjF6UCyW/HP/1
         1xIphJEPk/1dlpzCnvwdr8psoRTZ4SQXSMEmtmvUrQlJjlhEMVNcqa79KrQe88WEXmBS
         Tu8vgti347fq8k6r++gj5T7TkTnDDswBF6FeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2wssN0DfVl0Q5ulsK8rehD0qys9A1UTSyxawRAlJec=;
        b=HlZq5u4jS48QwCwGskxHE71/vn6LKZ6/m7htwyWpirlFHddRBev+MJcP9G4xZj98v4
         BD2c00Ph62Iemx0x/hKo8FZf7zfXlHzkjJqjJAlkGOWABOEf4xls7q+zgnPW3HHof+4B
         a+xt/OZBa0C/ngSkwn6CxjshgAgKpa8W5Xk6gc/qMjG10Jrdu2cHgENZihuhqJO9TlzR
         l8xwzCvGg02S7S4AKcXESjCvfzXymph6kGvGT98o4hx8T9sp/szMtX6tPeShxnP6qgD+
         0/jvBPG0mvRZCdXqMBcD6ub+CkeUDUf69DzWe7fsrgAXojiPYk5vR166ZxqhtYwu2kUh
         CFdA==
X-Gm-Message-State: AOAM533AIwlkdy4wQ/nYsEvnMikuo2jC/uZWCdGmPN44MbWomscZ1Kzp
        q6kDhPVg0meRqPTLyATDYvYExnRwHaqAbwSMc8JOxA==
X-Google-Smtp-Source: ABdhPJzRl4IzM+/5e+TD8Pd7j+A6SmKTwYoGY5YNvdrKb+tJbT1J0kMH3uJc5Yi9i1lQvDnOm0uTXj7cCiaXUmoq3bo=
X-Received: by 2002:a05:6102:1045:: with SMTP id h5mr2083568vsq.42.1598892727414;
 Mon, 31 Aug 2020 09:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200826154719.1.I24fb6cc377d03d64d74f83cec748afd12ee33e37@changeid>
 <A69701BE-FBB3-4053-8187-618C0BD4B380@holtmann.org>
In-Reply-To: <A69701BE-FBB3-4053-8187-618C0BD4B380@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 31 Aug 2020 09:51:56 -0700
Message-ID: <CANFp7mXY7--Mziduq69gUj5cgCiZCZ-47JOpBNL6H0bLpN2bbQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Clear suspend tasks on unregister
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v2 sent with fix.

On Mon, Aug 31, 2020 at 8:49 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > While unregistering, make sure to clear the suspend tasks before
> > cancelling the work. If the unregister is called during resume from
> > suspend, this will unnecessarily add 2s to the resume time otherwise.
> >
> > Fixes: 4e8c36c3b0d73d (Bluetooth: Fix suspend notifier race)
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> > This was discovered with RT8822CE using the btusb driver. This chipset
> > will reset on resume during system suspend and was unnecessarily adding
> > 2s to every resume. Since we're unregistering anyway, there's no harm in
> > just clearing the pending events.
> >
> > net/bluetooth/hci_core.c | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 68bfe57b66250f..ed4cb3479433c0 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3442,6 +3442,16 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> >       }
> > }
> >
> > +static void hci_suspend_clear_tasks(struct hci_dev *hdev)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < __SUSPEND_NUM_TASKS; ++i)
> > +             clear_bit(i, hdev->suspend_tasks);
>
> I prefer i++ instead of ++i.
>
> Regards
>
> Marcel
>
