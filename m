Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC15C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 20:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383377AbiFQUs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381762AbiFQUsz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 16:48:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97045DBCE
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 13:48:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m25so5883683lji.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvlmhjX5WrHl156XHjI+XlN+ZCT9UnRn+tpViHipDk4=;
        b=AQvbQNqjOh+vs7nV5O4ZkPwpwVG3IY/XB6qUsKlo+u+PXBU59U7UGX2SeOkfGtUFhe
         OGLyR7EAaHiOA5PfWmMV9H4KzkryFkxzdJuYgfRXa/59tlGXShywPbvDJszBRZ4Y4PmJ
         5Uh1/5YSEVpF9HtIFUpQl5jVL1LgshkzaXE8mTSaMAsJsVDYf1dznDACdEtMyavCHglw
         zLEBZkjGuJ3sck9feEMZr/8ui88ly3fhgPHM0P0etLAyf1Jnm423P+biHDflkD+4PGjq
         KuUI5Noeudu3KiO6beAYGEY0aG5QvAcdsLv9JT0D4EKsoIkZmf0WqC0GffegxYkKqatF
         kUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvlmhjX5WrHl156XHjI+XlN+ZCT9UnRn+tpViHipDk4=;
        b=vj66VqMNjELHBStc//BysPKpCae7/lI1wzeuoWPB9jCf306n10Pl5Wh/L+h8ZZSfXv
         MECmpmcwPnOD7UBtP/JSmLQ2VD2yAVlOAL+QwvS6JiIVgKDt7Co4g5rA7HJR4YglMqOa
         F3U6Mmvk/oHJS7qfvQ7/7Q8ZtqwBxnuSoR/61wfJTL2auXQpQo+HCKVQXN02tTk/DaV8
         6sZIYGwnu8i4itCe1tooj5wnO19CHH/3vaeGTbTktzkLAokqCQkjzhCAETw871FWFuyx
         JaX1/cWSdrCbNhcbriwDl9e+Y6lfMruRb+NgblpagXA2dJxtWkhKlL4OenVMdBN0m00C
         f5JQ==
X-Gm-Message-State: AJIora8nohoe6cH77eudA+F5lroK21cnW6yhaHo1L++8xQ1fBtqQoOqn
        hX79ZzS1DqCcPjZeYn2T0Tl6UqG0uhSk1F/X1NqJ6z+d
X-Google-Smtp-Source: AGRyM1sIFKriab8YwDUFvTn5R/ggwO4Y3nbrPnazNRow1Hj2WUYgE/JWWUOSKjHrCuDG+m3YpP66//FiqDgh8tckehc=
X-Received: by 2002:a05:651c:549:b0:255:bbd2:fb8 with SMTP id
 q9-20020a05651c054900b00255bbd20fb8mr5859838ljp.305.1655498928997; Fri, 17
 Jun 2022 13:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
 <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
 <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
 <8d5c4724-d511-39b1-21d7-116c91cada45@pengutronix.de> <b0cb4fb0-6b89-b9df-9ae6-421ac52b0100@pengutronix.de>
In-Reply-To: <b0cb4fb0-6b89-b9df-9ae6-421ac52b0100@pengutronix.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Jun 2022 13:48:37 -0700
Message-ID: <CABBYNZ+ubN2rc=zoN_53Pmp6kt3L5UcY3knbtjhhVOjPBpJv4Q@mail.gmail.com>
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

On Thu, Jun 16, 2022 at 3:38 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Luiz,
>
> On 16.05.22 18:37, Ahmad Fatoum wrote:
> >>>> - Commit a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
> >>>>   fixes, despite the title, what event is waited on. First Pairing works now,
> >>>>   but the second pairing times out and crashes the kernel:
> >>>>
> >>>>   [   84.191684] Bluetooth: hci0: Opcode 0x200d failed: -110
> >>>>   [   84.230478] Bluetooth: hci0: request failed to create LE connection: err -110
> >>>>   [   84.237690] Unable to handle kernel read from unreadable memory at virtual address 0000000000000ca8
> >>
> >> That said the error -110 mean -ETIMEDOUT
> >
> > Yes, this issue remains still. I feel better about my revert
> > knowing that the crash is fixed, but I'd like this regression
> > here fixed upstream as well. I'll try to collect some more
> > information and report back.
>
> I've now found time to revisit this and sprinkle around some
> extra logging. This is the initial pairing that works:
>
>   Bluetooth: entered hci_le_create_conn_sync()
>   Bluetooth: hci0: opcode 0x200d plen 25
>   Bluetooth: hci0: event 0x0f (sent = 0x0a)
>   Bluetooth: hci0: BT: opcode 0x200d (sent: 0x0a)
>   Bluetooth: hci0: event 0x3e (sent = 0x0a)
>   Bluetooth: hci0: BT: subevent 0x0a (sent 0x0a)
>   Bluetooth: entered hci_le_meta_evt(event=0x0a) completion clause
>
> I unpaired on device side and then retried pairing:
>
>   Bluetooth: entered hci_le_create_conn_sync()
>   Bluetooth: hci0: opcode 0x200d plen 25
>   Bluetooth: hci0: event 0x0f (sent = 0x0a)
>   Bluetooth: hci0: BT: opcode 0x200d (sent: 0x0a)
>   Bluetooth: entered hci_abort_conn()
>   Bluetooth: hci0: opcode hci_req_add_ev 0x200e
>   Bluetooth: hci0: event 0x0e (sent = 0x00)
>   Bluetooth: hci0: event 0x3e (sent = 0x00)
>   Bluetooth: hci0: BT: subevent 0x0a (sent 0x00)
>   Bluetooth: __hci_cmd_sync_sk pending (event = 0x0a status=1, err=-110)
>   Bluetooth: hci0: Opcode 0x200d failed: -110
>   Bluetooth: hci0: opcode 0x2006 plen 15
>   Bluetooth: hci0: event 0x0e (sent = 0x00)
>   Bluetooth: hci0: opcode 0x200a plen 1
>   Bluetooth: hci0: event 0x0e (sent = 0x00)
>   Bluetooth: hci0: request failed to create LE connection: err -110
>
>
> But now it times out as reported. It looks like the
> intermittent hci_abort_conn() is at fault here. My theory is
> that replacing hci->sent_cmd is the problem here, as other
> events can't be matched anymore.

Yep, unpair command uses hci_abort_conn when it should really be using
hci_abort_conn_sync, the problem is if we do that then it probably no
longer work because it would have to wait for sync queue to complete
so it would only be able to disconnect after the connect command
completes, well perhaps that is acceptable otherwise we need a
different queue to handle command that abort/cancel other already in
the queue.

> We've been deploying the revert for a while now and I just posted
> it to the mailing list[1]. There have been other reports
> of this issue with different hardware too and fixing sent_cmd
> would likely be too complicated/time intensive for me.
>
> I am happy to test future patches that fix this properly though.
>
> [1]: https://lore.kernel.org/linux-bluetooth/20220616092418.738877-1-a.fatoum@pengutronix.de/T/#t
>
> Cheers,
> Ahmad
>
>
>
> >
> > Cheers,
> > Ahmad
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
