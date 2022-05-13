Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B134BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 01:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiENBxy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 21:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiENBxx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 21:53:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0B3E5F90
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:55:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n10so9340918pjh.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbLxl33dnNUr+TfDuWRFuOGQ2ZUPcmVlTIUSDlM0UtY=;
        b=LvtLnKdSQtIB/h9rHwla9pGnn6N0ZEdEyvepL2LfW2VFElLW6Til2qwJC+KSXazcci
         d8MnCvcg5UrV29AkYPedleERALvTUaDfBCmFuD9FcaY6DSRoTmi9vVyCcSBsN8v4pGJ6
         SK451D4v0E+Q9zPgmqa99IbKp55zpPqo1mIynYK0qNP720tJJ8LKiuujm8FUXtv1MLPn
         I7paDihgFHXG7xpJNm2Flq33FDnwhC69gPt273M/vaOzdBGCefiYA739SyOpoeUjxSV5
         fRoEkSzx6VZaOBZgQzUv8ugJLc5LsKkhP9aECMxHso8D0HulXg7hJAewSNrghIbNqOin
         fQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbLxl33dnNUr+TfDuWRFuOGQ2ZUPcmVlTIUSDlM0UtY=;
        b=4OPYMG+zFXTxudG8EC5tBY+KQlvNPFPydhlcpMF5+J6x4Sx5jTmFmWgKKBGXS+5KOg
         yfrHP3btJCLe1Z+vz1IBerGYx03ggL0Evi49PK7r9sG0wi8JpKz5mZfRxWZ0wlct1CgI
         nuRtl63CJKPtk8r7J+sxa5Fo+pa6EmKfquITbDHZpu1uA4eDkLjWGG95l7OowWpd0E9a
         C39hvsiW0MeITdmW1Mw8rG4a1HXGfJfUg0vrQlyBtips6FxAS292Is29fzQfDhJchWr+
         JTO8XMeX/R34kPjRlev+LXLHlqxD2+Z1e0KrnrL+UU7mjTzWen7lLS5YwVgxkd7dDCzP
         UV0w==
X-Gm-Message-State: AOAM531mn49STExqNQjGgjdxBe4u1/Tz2+8gWUVKpEKwx34aE9jHs/mn
        nnYAGOnIk3U9ut9H7F27mj8t5+jxZqFDLw8weWueW7Yd
X-Google-Smtp-Source: ABdhPJxod8TJZrh+tnAE7g6NarDMwEyTFMdZu3pNgPIb3/P2wLbP4GlL359WHn++m6K2GAv+djW4wHm3Ub6YSHUXq60=
X-Received: by 2002:a17:90a:528f:b0:1dc:9a7c:4a3 with SMTP id
 w15-20020a17090a528f00b001dc9a7c04a3mr7194958pjh.112.1652485962851; Fri, 13
 May 2022 16:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de> <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
In-Reply-To: <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 May 2022 16:52:31 -0700
Message-ID: <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ahmad,

On Fri, May 13, 2022 at 1:14 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ahmad,
>
> On Fri, May 13, 2022 at 7:10 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >
> > Hello,
> >
> > On Linux v5.18-rc5, I can reliably crash the kernel on the second (un)pairing
> > with a customer's BLE device. I have bisected the issue and found two commits:
> >
> > - Commit 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events when
> >   connecting LE") causes previously working pairing to time out, presumably
> >   because it keeps waiting for the wrong event.
>
> Can you describe in more details what is the second pairing, are you
> pairing 2 devices concurrently? I recall someone for nxp having
> similar problem, at least the traces look pretty similar, the problem
> seems to be the expected event don't match the event the controller
> send, in this case hci_le_enh_conn_complete_evt, so hci_event process
> it and frees the hci_conn instead of first running the callback.

Looks like my memory failed me on this one, the sync callback is run
last so we shouldn't cleanup the hci_conn at that point, perhaps
something like the following should fix the crash:

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0270e597c285..c1634af670b8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5632,10 +5632,8 @@ static void le_conn_complete_evt(struct hci_dev
*hdev, u8 status,
                status = HCI_ERROR_INVALID_PARAMETERS;
        }

-       if (status) {
-               hci_conn_failed(conn, status);
+       if (status)
                goto unlock;
-       }

        if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
                addr_type = BDADDR_LE_PUBLIC;

> > - Commit a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
> >   fixes, despite the title, what event is waited on. First Pairing works now,
> >   but the second pairing times out and crashes the kernel:
> >
> >   [   84.191684] Bluetooth: hci0: Opcode 0x200d failed: -110
> >   [   84.230478] Bluetooth: hci0: request failed to create LE connection: err -110
> >   [   84.237690] Unable to handle kernel read from unreadable memory at virtual address 0000000000000ca8

That said the error -110 mean -ETIMEDOUT



--
Luiz Augusto von Dentz
