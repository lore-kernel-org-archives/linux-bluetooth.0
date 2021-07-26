Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D1CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 21:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6EC60F11
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jul 2021 21:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhGZUps (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jul 2021 16:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGZUpr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jul 2021 16:45:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19437C061757
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 14:26:15 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z18so17170331ybg.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jul 2021 14:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDJFBfopYrkvxeBLtOdwkq9/bXmvF9dVSYrN/WVwglM=;
        b=Ui8obqmQCR80fWRhJPcjAw/0AZ2S8LErXzO7DDCrDXisjfzvZOgZRfTuA/OpuPMxYp
         OjDg09WSDlRbXlLNx+QGvlLvCH9CcFLYxfwssG43vWzDik1NkmmmzPUfUQ6ZOEvUCKAl
         P5dWsXiP0nEJwdtf/O0n6r5WqQeEM+Is2UTTmpmpjv/E5ES0mmXmqna2UKyIohMMApoN
         ufgNeY1tjC8/ldrD+DaImqFf2pp6RCuc1X0rvbSgbHRFjc70Vuo8qBIwpxd+cR118EQ0
         de4Z9tQicZqMEBWgATxUd55I0z1svt4Z/eQSaqYfsL5oCKb1THMkYrfVHSRvc6lJ8F3i
         rC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDJFBfopYrkvxeBLtOdwkq9/bXmvF9dVSYrN/WVwglM=;
        b=RujgwIff84qWT/E7qsX49sfE4q6HNCfylF9hXgenvtxdaP+b7OiZ4sOjCnukGGS92Z
         FVT1u5bDn7pkKpq433GrHJ2twy6vr/91BS4LU6PBEWZXGfKZHanp5f1Q00g+tPgfeHCr
         e1xckBhqBz39KMkLkdfLiZA62M/uE5WjOLFpkvj6QW9wz3uTgqlBMS7cSwFPo/2t/L5y
         vby7+19mcPbH+WKc/WoMQYKT6O2a2Pgyx0PTHLLwC9qi2z40LReiWcygwjncYizNGehr
         Rs0k530oMCWDYTlTBlhUZqJS/nO0K9VDf+Cz8n1huvtrPE79qiyJwr2E90N+gRaBrVFr
         SApw==
X-Gm-Message-State: AOAM531FjCFslKkq4k1hddHo6MZ1nHNqN+hgaj33xbU1auQkiAMhEsQW
        TQixTnMGbMBdswt8slIB/WjAMQ5qBJNiW0tRFoY=
X-Google-Smtp-Source: ABdhPJwfKvftDo97eeU1EdXy5vBiV3uBmJUOSaFwba/zi3+ntSI7o4t1EOwtrFkDd2JHqezaE1+VhcLJUS2uB31iSME=
X-Received: by 2002:a25:9b03:: with SMTP id y3mr25012807ybn.264.1627334774251;
 Mon, 26 Jul 2021 14:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210724140331.3465-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CABBYNZLw-1xofLwsNYEcb7auN6KorPTLh3ZOWFR4V6n4knOT-g@mail.gmail.com> <e51b7339-a432-de99-89a9-d97be776ee5d@i-love.sakura.ne.jp>
In-Reply-To: <e51b7339-a432-de99-89a9-d97be776ee5d@i-love.sakura.ne.jp>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 26 Jul 2021 14:26:03 -0700
Message-ID: <CABBYNZLk2sYggimVfBx1vcYbG7-sBsVKS1+SujaR054DjVSaHA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: use helper function for monitor's open/close notifications
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tetsuo,

On Mon, Jul 26, 2021 at 1:40 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/07/27 2:40, Luiz Augusto von Dentz wrote:
> >> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> >> index 786a06a232fd..fc2336855dab 100644
> >> --- a/net/bluetooth/hci_sock.c
> >> +++ b/net/bluetooth/hci_sock.c
> >> @@ -295,6 +295,11 @@ void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> >>         read_unlock(&hci_sk_list.lock);
> >>  }
> >>
> >> +static void __hci_send_to_monitor(struct sk_buff *skb)
> >> +{
> >
> > We can probably have the checks of NULL skb added directly here and
> > perhaps kfree_skb as well since it seems it is always a copy that is
> > sent here,
>
> The NULL skb check is in hci_monitor_ctrl_open() and hci_monitor_ctrl_close().
> The purpose of __hci_send_to_monitor() is to hide common arguments.

All instances that call into it do seem to have the NULL check and
kfree, in fact hci_monitor_ctrl_open and hci_monitor_ctrl_close do
exactly the same thing:

+       if (skb) {
+               __hci_send_to_monitor(skb);
+               kfree_skb(skb);
+       }

Perhap we can call it hci_send_ctrl_to_monitor:

static void hci_send_ctrl_to_monitor(struct sk_buff *skb)
{
       if (!skb)
           return;

       hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED, NULL);

       kfree_skb(skb);
}

>
> >            the hci_send_to_monitor don't have __ prefix so I wonder
> > why you have chosen to use it?
>
> Only to avoid name conflict with hci_send_to_monitor(). I thought that
> the __ prefix is fine because hci_send_to_monitor() also calls this function.
> Please suggest whatever name you want to use.
>
> >
> >> +       hci_send_to_channel(HCI_CHANNEL_MONITOR, skb, HCI_SOCK_TRUSTED, NULL);
> >> +}
> >> +
> >>  /* Send frame to monitor socket */
> >>  void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
> >>  {
>


-- 
Luiz Augusto von Dentz
