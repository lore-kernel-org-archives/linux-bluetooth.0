Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872DBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 21:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696ED61242
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 21:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbhIWVFq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbhIWVFq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 17:05:46 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40074C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 14:04:14 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id f73so3148447vkf.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBvhhleKp1K0/C7xC8Ic0X0Vda3XkzefmUrMq40BeQc=;
        b=pTAFsww0nD//wFjzhdQbWi9sjmtX44O+PReWs4QGsQEyghaG3Ku9EzAX0FgFc6Pe9A
         uPyy9p/tf1Ktm/JfhmKPX0oSv44hSv587MxouoEbI7VnhvcagDdA5CMBJXS2iJm9qbLO
         YHR7GPg84yIvs9uroYLf7Z5kXIQTkuJ00JNDrh+gOIlaeC4KT2U5JDpAPJNFGXvuMzuw
         0/hDxxk5iS2l4QwIaoK2UncUM85iHd4wTVfHdwhpfAfy+jUxBeSXFdhv4qQjPttylEY2
         2o/zG6Ax/FKb2cCZxzSXZHPquERK9Okh2a4hQ67SCCydDEiq7S1dZgbw0/E0e5kBede7
         Ll+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBvhhleKp1K0/C7xC8Ic0X0Vda3XkzefmUrMq40BeQc=;
        b=dCJAf+wxXp7ykExCHpeyBhwPJw/pFHXwNx3PwWyt/WjxxSYgUlB4XZOja93phEP9+u
         IzLBp/PfRzCYsSSQlaBp0l8CJDVDJRyaCOaQmKypTm3sWwXf79UpFsq1HigZuJWDmu1c
         wGf6hyWlzRd9/qwLAuWdYniNGZq8P7yrLW/bFv+tOTJWyDdtYpmNOsiQynLjzQxoUg0h
         oabdU1W/HIs6Jx8DtNnPauiPJs9rrRJzhXVZ1uTO4aF0GivA923wFj0QbSKN9k9/AtQI
         tbF6xshvUMadDQYA6X6ITfSQv19y8YB3/h82VbwjDIrfapHBlrPgSZpcDrfuTDNkWpgD
         ByWw==
X-Gm-Message-State: AOAM530VFIfHRYWuveZuUUENnPd5DDh19vkKf92tx8q17Pid/DCuuln6
        MsBDAV+jgNF0hiKyoOwnYJ+zqn5gOeVvChNMuo69aLqscS4=
X-Google-Smtp-Source: ABdhPJxIXRVKZnUrc0ikjQt72cn8xAdonXFH56jUrrGgBsYF1A+zOnff5zp2+aZQh4R0FQixioeJamOt5MDtZhR55co=
X-Received: by 2002:a1f:a9c4:: with SMTP id s187mr5073874vke.9.1632431053295;
 Thu, 23 Sep 2021 14:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210916201049.114392-1-luiz.dentz@gmail.com> <1F53E938-77D3-4520-B119-11F81C991D44@holtmann.org>
 <CABBYNZJhaJGvbuvydtdBa7mHK7kM1Rt+KxKQ9PyNGPM4thwFuA@mail.gmail.com> <53BDC874-DDC8-4700-BB26-2BAF21403D73@holtmann.org>
In-Reply-To: <53BDC874-DDC8-4700-BB26-2BAF21403D73@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Sep 2021 14:04:02 -0700
Message-ID: <CABBYNZ+ubDjUpm21BesXmm1oH08KH_d=QppZu_iZnY==ArDsrA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] Bluetooth: hci_sock: Add support for BT_{SND,RCV}BUF
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Sep 22, 2021 at 7:19 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> >>> This adds support for BT_{SND,RCV}BUF so userspace can set MTU based on
> >>> the channel usage.
> >>>
> >>> Fixes: https://github.com/bluez/bluez/issues/201
> >>>
> >>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> ---
> >>> net/bluetooth/hci_sock.c | 102 ++++++++++++++++++++++++++++++++++-----
> >>> 1 file changed, 91 insertions(+), 11 deletions(-)
> >>
> >> so I applied patches 1, 3 and 4 to bluetooth-next tree.
> >>
> >> The patch 2 needs a more details review when I have time since I remember there were cases where the SKB copy was really needed.
> >
> > Is that something not covered by CI testing? Note we still have a copy
> > done internally with create_monitor_ctrl_command.
>
> there are cases where the SKB handed down is in hdev->send() and that one is owned by the driver to make whatever modifications to headroom it pleases. So if the stack needs to send it out via other sockets, it needs a copy.
>
> We can optimize here, but need to be careful.

I guess you are referring to instances of hci_send_to_channel, which
appears there only one instance that is changed in the diff bellow:

        if (chan->channel == HCI_CHANNEL_CONTROL) {
-               struct sk_buff *skb;
+               struct sk_buff *cmd;

                /* Send event to monitor */
-               skb = create_monitor_ctrl_command(sk, index, opcode, len,
-                                                 buf + sizeof(*hdr));
-               if (skb) {
-                       hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
+               cmd = create_monitor_ctrl_command(sk, index, opcode, len,
+                                                 skb->data + sizeof(*hdr));
+               if (cmd) {
+                       hci_send_to_channel(HCI_CHANNEL_MONITOR, cmd,
                                            HCI_SOCK_TRUSTED, NULL);
-                       kfree_skb(skb);
+                       kfree_skb(cmd);
                }
        }

Ive only changed the variable name since the original code use skb
which is now used as the original data instead of buf (extra copy), so
nothing has changed in this regard, also running this with KSAN, etc,
doesn't seem to produce any traces nor there seems to be anything
wrong in btmon either.

Note with this we are eliminating the extra copy on buf:

msg -> skb (new) vs msg-> buf -> skb (old)

> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
