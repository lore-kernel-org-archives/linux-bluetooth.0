Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78AEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jun 2022 20:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiFTUSu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jun 2022 16:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbiFTUSa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jun 2022 16:18:30 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A86277
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 13:18:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c30so13118334ljr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeN9XZYk4Nmmr2iNhCACELl+PcFCkbQTYUNEZaX26lg=;
        b=fDjhUAyWQWvonO5KZeAmYvPzgnrF9vCpla7+i2tn4uj48UhkdgjBgwa8hDRhiMF9qP
         zGDzVtQLepDw57RKIiqnAC/ypeRcMGWwisZ+7Oa16l69V6Yp14kg65mwUxUSIrfzCqWZ
         5zNXkGsUHty6k/Qc+sOS1CDrWDK+3C/iJPjtOIjD0cJy4KwlZxC7JabVfNq7kQdm1ufH
         Eij9f8vCwL6tRu7Jj015R4pAcUi/FZ1kcRm1DQ/6cSIeJmu7ek2A2GeVu65iVMsn8MlC
         Q/fdPYel43WkOrx3IJNS3+hVzVh9LFbH+D7vsUbaeVcPK6g4Z2aJMzwsjEHQUOy2ZLIH
         sTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeN9XZYk4Nmmr2iNhCACELl+PcFCkbQTYUNEZaX26lg=;
        b=dlbSUhEeb7fErqn0GiHtmG34rYS+7WNsimlfhcbNXd3vqw70SA54SauJ3BHf4b9iQC
         321S1m1NRbC9joiRu74w4CFzpWJ+p6m8sdQYxH0R7NNMww2A38STstXfY5Ou6iGF6pcR
         49EoTYTr6n39PtT6evZHOixDfp5f73++MQdgKqo+/jBcSxOLF9aXlAsZ0kGkZVu8wLMT
         D/OdNiXvL3fEcdV6EvYlrsVa18qdTL8rzDtInbvsuNceUaDNP9HhQgZIisYQikK1OHDl
         lRMc+UkKh5dPKbCsqBwTXitC+6n5QsDGxc8vSF+HfncM4p17HrBWXtTwGCLbY8EcBSrV
         BgWA==
X-Gm-Message-State: AJIora/mOVxBb3vJcYp1648yIKBtuZMlCRc4XmDMFIpWKU1cNfiI286G
        gF/7waUosVIs+b0SqudU9U5IPt/YeUiK//ohojA=
X-Google-Smtp-Source: AGRyM1vjnCahM/o0volSWGz/BC2SxrnGyhzjPfrSmV6brhEnr+9lcTj0CBa9Dd8YzZOSf/GJZoMhuEpDfuXLgctrVX8=
X-Received: by 2002:a2e:a16f:0:b0:25a:7527:95ce with SMTP id
 u15-20020a2ea16f000000b0025a752795cemr935288ljl.305.1655756304208; Mon, 20
 Jun 2022 13:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
 <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
 <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
 <8d5c4724-d511-39b1-21d7-116c91cada45@pengutronix.de> <b0cb4fb0-6b89-b9df-9ae6-421ac52b0100@pengutronix.de>
 <CABBYNZ+ubN2rc=zoN_53Pmp6kt3L5UcY3knbtjhhVOjPBpJv4Q@mail.gmail.com> <d5654901-6b1f-a1fa-0101-8b52b345af7b@pengutronix.de>
In-Reply-To: <d5654901-6b1f-a1fa-0101-8b52b345af7b@pengutronix.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Jun 2022 13:18:12 -0700
Message-ID: <CABBYNZ+8dpPBqaQMr-Hz_DJRxT-0ucCjgAJH50FUaN7Sn9H6rA@mail.gmail.com>
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ahmad,

On Mon, Jun 20, 2022 at 3:06 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hi Luiz,
>
> On 17.06.22 22:48, Luiz Augusto von Dentz wrote:
> > On Thu, Jun 16, 2022 at 3:38 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >> On 16.05.22 18:37, Ahmad Fatoum wrote:
> >>>>>> - Commit a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
> >>>>>>   fixes, despite the title, what event is waited on. First Pairing works now,
> >>>>>>   but the second pairing times out and crashes the kernel:
> >>>>>>
> >>>>>>   [   84.191684] Bluetooth: hci0: Opcode 0x200d failed: -110
> >>>>>>   [   84.230478] Bluetooth: hci0: request failed to create LE connection: err -110
> >>>>>>   [   84.237690] Unable to handle kernel read from unreadable memory at virtual address 0000000000000ca8
> >>>>
> >>>> That said the error -110 mean -ETIMEDOUT
> >>>
> >>> Yes, this issue remains still. I feel better about my revert
> >>> knowing that the crash is fixed, but I'd like this regression
> >>> here fixed upstream as well. I'll try to collect some more
> >>> information and report back.
> >>
> >> I've now found time to revisit this and sprinkle around some
> >> extra logging. This is the initial pairing that works:
> >>
> >>   Bluetooth: entered hci_le_create_conn_sync()
> >>   Bluetooth: hci0: opcode 0x200d plen 25
> >>   Bluetooth: hci0: event 0x0f (sent = 0x0a)
> >>   Bluetooth: hci0: BT: opcode 0x200d (sent: 0x0a)
> >>   Bluetooth: hci0: event 0x3e (sent = 0x0a)
> >>   Bluetooth: hci0: BT: subevent 0x0a (sent 0x0a)
> >>   Bluetooth: entered hci_le_meta_evt(event=0x0a) completion clause
> >>
> >> I unpaired on device side and then retried pairing:
> >>
> >>   Bluetooth: entered hci_le_create_conn_sync()
> >>   Bluetooth: hci0: opcode 0x200d plen 25
> >>   Bluetooth: hci0: event 0x0f (sent = 0x0a)
> >>   Bluetooth: hci0: BT: opcode 0x200d (sent: 0x0a)
> >>   Bluetooth: entered hci_abort_conn()
> >>   Bluetooth: hci0: opcode hci_req_add_ev 0x200e
> >>   Bluetooth: hci0: event 0x0e (sent = 0x00)
> >>   Bluetooth: hci0: event 0x3e (sent = 0x00)
> >>   Bluetooth: hci0: BT: subevent 0x0a (sent 0x00)
> >>   Bluetooth: __hci_cmd_sync_sk pending (event = 0x0a status=1, err=-110)
> >>   Bluetooth: hci0: Opcode 0x200d failed: -110
> >>   Bluetooth: hci0: opcode 0x2006 plen 15
> >>   Bluetooth: hci0: event 0x0e (sent = 0x00)
> >>   Bluetooth: hci0: opcode 0x200a plen 1
> >>   Bluetooth: hci0: event 0x0e (sent = 0x00)
> >>   Bluetooth: hci0: request failed to create LE connection: err -110
> >>
> >>
> >> But now it times out as reported. It looks like the
> >> intermittent hci_abort_conn() is at fault here. My theory is
> >> that replacing hci->sent_cmd is the problem here, as other
> >> events can't be matched anymore.
> >
> > Yep, unpair command uses hci_abort_conn when it should really be using
> > hci_abort_conn_sync, the problem is if we do that then it probably no
> > longer work because it would have to wait for sync queue to complete
> > so it would only be able to disconnect after the connect command
> > completes, well perhaps that is acceptable
>
> Disconnect of connection #1 being processed after new connection #2
> concluded sounds wrong. Would I be able to reconnect
> afterwards or would all connections, but the first, be directly
> disconnected...?

That depends on the order you have queued the commands, it will be
processed in the exact order it is received, that why I said it is
single queue design, and it is done like that to prevent messing up
with states since we know the exact order the commands will be sent.

> > otherwise we need a
> > different queue to handle command that abort/cancel other already in
> > the queue.
>
> Is the revert an acceptable interim solution or are there issues
> I am missing?

Afaik there were problem with concurrent connections request, so what
would really help us here is to have some tests to emulate this
scenario with our CI, in the meantime please check if the following
fixes your problem:

https://gist.github.com/Vudentz/b4fff292c7f4ad55ca3299fd5ab797ae

> Cheers,
> Ahmad
>
> >
> >> We've been deploying the revert for a while now and I just posted
> >> it to the mailing list[1]. There have been other reports
> >> of this issue with different hardware too and fixing sent_cmd
> >> would likely be too complicated/time intensive for me.
> >>
> >> I am happy to test future patches that fix this properly though.
> >>
> >> [1]: https://lore.kernel.org/linux-bluetooth/20220616092418.738877-1-a.fatoum@pengutronix.de/T/#t
> >>
> >> Cheers,
> >> Ahmad
> >>
> >>
> >>
> >>>
> >>> Cheers,
> >>> Ahmad
> >>>
> >>
> >>
> >> --
> >> Pengutronix e.K.                           |                             |
> >> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> >
> >
> >
>
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
Luiz Augusto von Dentz
