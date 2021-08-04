Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65471C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4854B60F58
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 14:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbhHDOmk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:42:40 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:59890
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238027AbhHDOmj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 10:42:39 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 020733F34C
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628088146;
        bh=3wAPLTNTz+K6PssPvD29DSKcaFgyHs1tGU9uPv0wDys=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tIhCrUb+hAb/Tj75m9HH6bJCR5ye0RBkFgWTIhQa28FVkhCotj1N1EPbvZ1XZdJ1y
         CoAyrTyqubd8cZqdwR1qtlMyOKlTp2qENWVP/pL21iA6LVIfZTL0aqYPiNjNmtqGC1
         zfw5dJPz6aqzhMBNfRDlqoOLMc9ExDg9vEKX5Ai7+e68+lA9NUkdsxndosAvqiUzYu
         Kf5DlWE6mAj+fiYW5jsHv/SQ4v7xIbALNZoNCCJPzPwHgQTMMnWjies0Xe3cpSR2UR
         uvzMJ6Rr3GTInHpYk3vCl5ZxlnwE3vchQxQ8OcdUaLRdinjkUt/7j3t8gicY7sO7IR
         p5pnqR/GrcQGQ==
Received: by mail-ej1-f70.google.com with SMTP id k21-20020a1709062a55b0290590e181cc34so917737eje.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 07:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wAPLTNTz+K6PssPvD29DSKcaFgyHs1tGU9uPv0wDys=;
        b=IyQXHyK2uVNU65gRZl8RuBidcakg/kCleYpRrEAOZi6MXuqY4VO+XLYLsk35k28qLz
         /TtXR2aTDbDttkb3GsxAmDnxdG83fjPukpT1RBszCWePR5OQkLAdy/Ug22W4tNLLys+T
         IZ1TZW1VwbB/de0u18aT7dcLaV7JdRvTs5Hd13bK9K1NyS+g6X5LRVfpCfF3YSzir4QH
         FhQfElL8NXNqv5oW777d7YOkPxeQJbJTW+lltc6D+iIApiKZmD/AxjdlonugiJ2KdcDl
         SapnBReYOeg7UUwaBPtnOd5hzhbCPwNJX08sPTscbtqAOZAWxf1rhfkD5Y/XZ6tL3Dtp
         540A==
X-Gm-Message-State: AOAM530kR4u0S/8C3bk3maQYl6TqQTWBmY4bqpi4Fn/a6r0fjnaktlda
        iSC1eygJRGp5yLKFu4VQEe8wgEyWENFm6+i2CAdZIkAyggBt+0cEIiEapApSpqeKH6Zi3LRwuML
        y0QB5OHWt2r7owdPW4Lj5lMkAjCLGOnzBvcT9xgHoh+Y8MMwrSy7T+W7MJerpdQ==
X-Received: by 2002:a17:907:9d2:: with SMTP id bx18mr9112334ejc.117.1628088145473;
        Wed, 04 Aug 2021 07:42:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOaQSvCaKPRq4H/5+YCJPxGecpIdfcA+4DRu7m7wAnxxdu88WH23lia/jjgNqV7LJNX9GlmVz4ZA/+PeiS+gI=
X-Received: by 2002:a17:907:9d2:: with SMTP id bx18mr9112321ejc.117.1628088145254;
 Wed, 04 Aug 2021 07:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <576B26FD-81F8-4632-82F6-57C4A7C096C4@holtmann.org> <8735ryk0o7.fsf@baylibre.com>
 <CAAd53p7Zc3Zk21rwj_x1BLgf8tWRxaKBmXARkM6d7Kpkb+fDZA@mail.gmail.com>
 <87y29o58su.fsf@baylibre.com> <CAAd53p4Ss1Z-7CB4g=_xZYxo1xDz6ih6GHUuMcgncy+yNAfU4w@mail.gmail.com>
 <87a6lzx7jf.fsf@baylibre.com>
In-Reply-To: <87a6lzx7jf.fsf@baylibre.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 4 Aug 2021 22:42:09 +0800
Message-ID: <CAAd53p6T_K67CPthLPObF=OWWCEChW4pMFMwuq87qWmTmzP2VA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Aug 3, 2021 at 4:21 PM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Kai-Heng,
>
> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
>
> > Hi Mattijs,
> >
> > On Fri, Jul 30, 2021 at 7:40 PM Mattijs Korpershoek
> > <mkorpershoek@baylibre.com> wrote:
> >>
> >> Hi Kai-Heng,
> >
> > [snipped]
> >
> >> Thank you for your help. Sorry I did not post the logs previously.
> >>
> >> dmesg: https://pastebin.com/tpWDNyQr
> >> ftrace on btmtksdio: https://pastebin.com/jmhvmwUw
> >
> > Seems like btmtksdio needs shudown() to be called before flush().
> > Since the order was there for a very long time, changing the calling
> > order indeed can break what driver expects.
> > Can you please test the following patch:
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 2560ed2f144d..a61e610a400c 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1785,6 +1785,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
> >         aosp_do_close(hdev);
> >         msft_do_close(hdev);
> >
> > +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> > +           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> > +           test_bit(HCI_UP, &hdev->flags)) {
> > +               /* Execute vendor specific shutdown routine */
> > +               if (hdev->shutdown)
> > +                       hdev->shutdown(hdev);
> > +       }
> > +
> >         if (hdev->flush)
> >                 hdev->flush(hdev);
> >
> > @@ -1798,14 +1806,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
> >                 clear_bit(HCI_INIT, &hdev->flags);
> >         }
> >
> > -       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> > -           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> > -           test_bit(HCI_UP, &hdev->flags)) {
> > -               /* Execute vendor specific shutdown routine */
> > -               if (hdev->shutdown)
> > -                       hdev->shutdown(hdev);
> > -       }
> > -
> >         /* flush cmd  work */
> >         flush_work(&hdev->cmd_work);
>
> Thanks for the patch and your help.
> I've tried it, but it seems that it does not improve for me.
> I'm still observing:
>
> i500-pumpkin login: root
> root@i500-pumpkin:~# hciconfig hci0 up
> Can't init device hci0: Connection timed out (110)
>
> Logs for this session:
> dmesg:   https://pastebin.com/iAFk5Tzi
> ftrace:  https://pastebin.com/kEMWSYrE

Thanks for the testing!
What about moving the shutdown() part right after hci_req_sync_lock()
so tx/rx can still work:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2560ed2f144d4..be3113fb7d4b0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1727,6 +1727,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
        hci_request_cancel_all(hdev);
        hci_req_sync_lock(hdev);

+       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
+           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+           test_bit(HCI_UP, &hdev->flags)) {
+               /* Execute vendor specific shutdown routine */
+               if (hdev->shutdown)
+                       hdev->shutdown(hdev);
+       }
+
        if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
                cancel_delayed_work_sync(&hdev->cmd_timer);
                hci_req_sync_unlock(hdev);
@@ -1798,14 +1806,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
                clear_bit(HCI_INIT, &hdev->flags);
        }

-       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
-           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
-           test_bit(HCI_UP, &hdev->flags)) {
-               /* Execute vendor specific shutdown routine */
-               if (hdev->shutdown)
-                       hdev->shutdown(hdev);
-       }
-
        /* flush cmd  work */
        flush_work(&hdev->cmd_work);





>
>
> >
> > Kai-Heng
> >
> >>
> >> Mattijs
> >> >
> >> > Kai-Heng
> >> >
> >> >>
> >> >> Thanks,
> >> >> Mattijs Korpershoek
> >> >>
> >> >>
> >> >> >
> >> >> > Regards
> >> >> >
> >> >> > Marcel
