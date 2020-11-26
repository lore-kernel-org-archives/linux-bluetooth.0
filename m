Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10D1C6379D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 00:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6159D20DD4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Nov 2020 00:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IkVo0vBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgKZAAX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgKZAAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 19:00:23 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217BAC0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 16:00:23 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id hb22so34921ejb.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 16:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cp3XtvMYP1ONxD1/gH7wPTDyUI7+riu9vnsjYjRg5ws=;
        b=IkVo0vBIiiWyfSkA/G5uKhHL2J9yjsRyR8ISwvcjhrASZ9PZhL8bAhoX8nnyz95/xw
         YemSKdjwZa8tqbdyG+/GOwtHtFsrTiz+NRXpBiKNVYm612k0smKaSUQNBv0FqTKTr1Pa
         FkbSQ1+miZ71XOdnhS1d9FvZFfOB/n4uW4nK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cp3XtvMYP1ONxD1/gH7wPTDyUI7+riu9vnsjYjRg5ws=;
        b=Z+30elR4gyFRR4gjMTngmNINJk1CW3ocKkUqQfCz1gbWte9ZUMV3tBkj5WiuVchVAm
         gCB6jdSRuTxRnAJ2DWJgmmeTlJSdelzFqDw61slL/o9K1rnn478c3rvBI0+H7rdaRM8y
         j4zwt5L4irjTm7CaOTM98vswhBc6I3QJjyBo7vXEbVymU0ZgLo3TPfjKYt4vSTFQZP7z
         8LNq/DIKlwcdXySIEXpPLHebCGhnSXnFe5S6pzax6jZA1N7p0I63e76ABmoRiUdlmWEq
         X1EihNsCFIjcWMPExoqpYTVhxQM349OL1ntmDT5azn1OG907hUoIMAniWxR9DX6aCv0F
         xmUg==
X-Gm-Message-State: AOAM530St+dhbMAx4NWtChZJmVt1LtohZha+qoCOVxYCaVSyZ7np39xG
        InAXTPPLMgMa4kF77otRCal6XTu/z/1+0g==
X-Google-Smtp-Source: ABdhPJxfTQLP/N0hX/BvudxSLJdz7tEohWVw6zQlC0GlOx5+9U00TPHZfxH5AveA4vrTPnrwaLfSoQ==
X-Received: by 2002:a17:906:ae8d:: with SMTP id md13mr405321ejb.300.1606348821255;
        Wed, 25 Nov 2020 16:00:21 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a10sm2181168edn.77.2020.11.25.16.00.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 16:00:20 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id 23so185319wrc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 16:00:19 -0800 (PST)
X-Received: by 2002:adf:a451:: with SMTP id e17mr376051wra.99.1606348819469;
 Wed, 25 Nov 2020 16:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20201124010906.340433-1-sonnysasaka@chromium.org> <92C0EFAB-EDF1-4EDB-ADE7-FF734928C8AE@holtmann.org>
In-Reply-To: <92C0EFAB-EDF1-4EDB-ADE7-FF734928C8AE@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 25 Nov 2020 16:00:07 -0800
X-Gmail-Original-Message-ID: <CAO271m=geLEUjtPhFETfqsYTsxDQoe+=c3WeYPbDuNjwc+4idA@mail.gmail.com>
Message-ID: <CAO271m=geLEUjtPhFETfqsYTsxDQoe+=c3WeYPbDuNjwc+4idA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Cancel Inquiry before Create Connection
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,


On Wed, Nov 25, 2020 at 6:43 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Sonny,
>
> > Many controllers do not allow HCI Create Connection while it is doing
> > Inquiry. This patch adds Inquiry Cancel before Create Connection in this
> > case to allow the controller to do Create Connection. User space will be
> > aware of this Inquiry cancellation and they may issue another discovery
> > request afterwards.
> >
> > Sample Command Disallowed response of HCI Create Connection:
> > < HCI Command: Inquiry (0x01|0x0001) plen 5
> >        Access code: 0x9e8b33 (General Inquiry)
> >        Length: 10.24s (0x08)
> >        Num responses: 0
> >> HCI Event: Command Status (0x0f) plen 4
> >      Inquiry (0x01|0x0001) ncmd 2
> >        Status: Success (0x00)
> > < HCI Command: Create Connection (0x01|0x0005) plen 13
> >        Address: XX:XX:XX:XX:XX:XX
> >        Packet type: 0xcc18
> >        Page scan repetition mode: R2 (0x02)
> >        Page scan mode: Mandatory (0x00)
> >        Clock offset: 0x0000
> >        Role switch: Allow slave (0x01)
> >> HCI Event: Command Status (0x0f) plen 4
> >      Create Connection (0x01|0x0005) ncmd 1
> >        Status: Success (0x00)
> >> HCI Event: Connect Complete (0x03) plen 11
> >        Status: Command Disallowed (0x0c)
> >        Handle: 65535
> >        Address: XX:XX:XX:XX:XX:XX
> >        Link type: ACL (0x01)
> >        Encryption: Disabled (0x00)
> >
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
> >
> > ---
> > net/bluetooth/hci_conn.c | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 4f1cd8063e720..b41ad08f8d411 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -233,6 +233,17 @@ static void hci_acl_create_connection(struct hci_conn *conn)
> >       else
> >               cp.role_switch = 0x00;
> >
> > +     /* Many controllers disallow HCI Create Connection while it is doing
> > +      * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
> > +      * Connection. This may cause the MGMT discovering state to become false
> > +      * without user space's request but it is okay since the MGMT Discovery
> > +      * APIs do not promise that discovery should be done forever. Instead,
> > +      * the user space monitors the status of MGMT discovering and it may
> > +      * request for discovery again when this flag becomes false.
> > +      */
> > +     if (test_bit(HCI_INQUIRY, &hdev->flags))
> > +             hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
> > +
>
> while this seems acceptable, what happens when we have interleaved discovery where we toggle between BR/EDR inquiry and LE scanning. Are you sure we not better cancel the mgmt discovery completely.
Only Inquiry is preventing Create Connection, so we don't need to
overcomplicate it by stopping the mgmt discovery completely. In the
case of interleaved discovery, the LE discovery will linger for a
little bit before eventually being disabled and the situation restarts
at a good state. Not perfect but simple, clean, and fixes the issue.

>
> Regards
>
> Marcel
>
