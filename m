Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F343EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 01:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiENBBq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 21:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiENBBo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 21:01:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C08934219C
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 17:37:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v66so12078855oib.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 17:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDw2EF76bFWlKcTGV1GJw+KjAOlIdVUgMjVyObR6IxQ=;
        b=m2IJNQSqV8ZtytcWwjcL8T+UFI2hCAn+ImvKgKrwV7KnLjRwyS6sJeLkQITZNRgst9
         FXp9FfKuWgv99fqIbj4JVJY2xLQSeBv+Wq4aaPPl0+WH6pvyVvi+pbAm2bFsOqa3Ub3O
         OfDUL70xfoep22Bbb49T+qXvvb9IQJGgi9LYeH9eEjlAPBtvgz56fDalW74xpN+W5PYF
         mX7VTPvTrtHD0s/2mTZSCaeK4aIgp6Nf4/gmR/1gaA2BDkX9yNOL3T3XZYRv5C3yAvsZ
         XkKgkYMBAS4y2DXPhtWcmiCm7BQCkO7udpk/SBtJ6aDGgRomsCjNxszzvrLrTD2kRqvQ
         j3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDw2EF76bFWlKcTGV1GJw+KjAOlIdVUgMjVyObR6IxQ=;
        b=RJ8MYcLN3QPW5MhjxS0Xe/INKgKJyCIuoLaXlrAfwZoACC0jgXpP8Of17XJqS3I7HT
         vmHLM6OlVpVMCHGqWFMpt488it3+OG2xrsvYVqbzMPJWAVYFYbDd8sh+e8G+JOVBaAoR
         JntfoA+KLGp5OSPgcVgu4CxpPHnBTsKa2NIl6ggzrAzYNBiJkYi5WdbWfEoLYuGHSt3s
         VL8A628gaqWY2kKNiBtixMctYuzPu1KhAmacaJ/HkfYEnLzdbtvJ6J8RXh15vc3TrkmN
         v1X5OFfuGlcfu2Ey/pAImuKUxM/PUJIRt894EhBcBcgdXqXQQHH4tbpaJNcnMjti9td9
         bPvg==
X-Gm-Message-State: AOAM5303EpiwXpbe5jzGJrTohRaDZ2qsZXUs/Y5WNs1FBGTpoEqtezom
        XTxbBTxhBRzbYYo30w3foXaXD7EvuftMRuysbG+M13CU
X-Google-Smtp-Source: ABdhPJyuKC8Ns+pNRJDYiqswUb2AE7azGoZ3Dn231AOWbsE5rJKHE6RMVQAjyzIGjGn+llIh94pfgYn4ZrZ8PfYbc8g=
X-Received: by 2002:a17:90b:4b83:b0:1dc:4cc8:16d9 with SMTP id
 lr3-20020a17090b4b8300b001dc4cc816d9mr7395293pjb.4.1652486277357; Fri, 13 May
 2022 16:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
 <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com> <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
In-Reply-To: <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 May 2022 16:57:45 -0700
Message-ID: <CABBYNZJHOyv-z31hNWBJ_fd=CX-S6J_GQyOquO-TEiLWAEoS+A@mail.gmail.com>
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, May 13, 2022 at 4:52 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ahmad,
>
> On Fri, May 13, 2022 at 1:14 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Ahmad,
> >
> > On Fri, May 13, 2022 at 7:10 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> > >
> > > Hello,
> > >
> > > On Linux v5.18-rc5, I can reliably crash the kernel on the second (un)pairing
> > > with a customer's BLE device. I have bisected the issue and found two commits:
> > >
> > > - Commit 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events when
> > >   connecting LE") causes previously working pairing to time out, presumably
> > >   because it keeps waiting for the wrong event.
> >
> > Can you describe in more details what is the second pairing, are you
> > pairing 2 devices concurrently? I recall someone for nxp having
> > similar problem, at least the traces look pretty similar, the problem
> > seems to be the expected event don't match the event the controller
> > send, in this case hci_le_enh_conn_complete_evt, so hci_event process
> > it and frees the hci_conn instead of first running the callback.
>
> Looks like my memory failed me on this one, the sync callback is run
> last so we shouldn't cleanup the hci_conn at that point, perhaps
> something like the following should fix the crash:
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0270e597c285..c1634af670b8 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5632,10 +5632,8 @@ static void le_conn_complete_evt(struct hci_dev
> *hdev, u8 status,
>                 status = HCI_ERROR_INVALID_PARAMETERS;
>         }
>
> -       if (status) {
> -               hci_conn_failed(conn, status);
> +       if (status)
>                 goto unlock;
> -       }
>
>         if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
>                 addr_type = BDADDR_LE_PUBLIC;
>
> > > - Commit a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
> > >   fixes, despite the title, what event is waited on. First Pairing works now,
> > >   but the second pairing times out and crashes the kernel:
> > >
> > >   [   84.191684] Bluetooth: hci0: Opcode 0x200d failed: -110
> > >   [   84.230478] Bluetooth: hci0: request failed to create LE connection: err -110
> > >   [   84.237690] Unable to handle kernel read from unreadable memory at virtual address 0000000000000ca8
>
> That said the error -110 mean -ETIMEDOUT

We might want to incorporate some test to the likes of mgmt-tester to
check this behavior, afaik the crash can be triggered by just causing
a le_conn_complete event with status != 0 which perhaps we need to
extend bthost.c to be able to reject connections.

>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
