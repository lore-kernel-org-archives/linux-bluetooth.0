Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F117CD612D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 19:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378451AbjJITml (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 15:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378443AbjJITml (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 15:42:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5601B6
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 12:42:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so61781251fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696880558; x=1697485358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUCAdcJRNl7fOVahEJi4wyoNXnCF3/Nv5hIB7ql4CN4=;
        b=cpaTsOBTNhHHWrLNaOLkmIhHwHXa2kRD65pVd3cbLwuKKpLWS8b1p4LBzUu3M+lzPy
         WjHKtAIz9Cq848yBVsq3ungjZY0OBQRhjrlvqg5PXCpuA8trrJQZAh35vJsGcH0YIM3y
         cJ+dbEz8e8o85vPPDVPDYoNU7om7Q56+FcFKwTYslDNzRHzU4K3gYDN8Yc0x/HBfV6/y
         33sMn+CgCa05f29s5TcFPZZ5WS+5kREYvmAWP7wMAfC9XGEDk2q2eyeEjuPOYtQ54YEy
         YPiPRHJKOA+6/rfpAp5TySYtiARYGewCqYUvuSL3kldZ4X8nvPjHL3RXOmCkB9yMQfC0
         iXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880558; x=1697485358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUCAdcJRNl7fOVahEJi4wyoNXnCF3/Nv5hIB7ql4CN4=;
        b=P1h4nxkdEkjZLuh8BGrxu2vzo2OR+2hW9KOslZO28fKDvz9TzjbQlk7Y+rYgcZRVMD
         w2Bo6b0DvWL3d1wCcdBgJ523dJckaTImC2zkpZledhblC+PvcWXb8nez2EKy0S8FAL0e
         DSiJfWucIsoKsPtmHZEzyJ2WocesQB5MDeAmBqGUjeA8ryPKCzPfsWqFZ2VT1B48dJbn
         Fqo25eZHXHEA0h/BiXhdiD2klIVv/CmgJEbdXv/4q3ttzfJIb1K+QzQfglO8z89rDIYS
         wBcawOZVP7L9a1DUmcI0yYwnIvEsFQa2QogPDIH9PYCK8XAiNaTFam+MzcVHiJtjeKf8
         bnbw==
X-Gm-Message-State: AOJu0YyxC6Z433oKknYMwo3NpnleBr/bI2c6rlyICG9sbv3zqWfcWfis
        LBzCUcU4tlbVzPuqPYqeJSpclRogBoFS7rDLgUc=
X-Google-Smtp-Source: AGHT+IEon7AbB/VEewfixxgGlYTyOfVioVBLzaD4HUKyYXkprSlaLlOMACJtDFinl8mBLDKswx+WJD7G2qu/S1dhWno=
X-Received: by 2002:a2e:9001:0:b0:2c1:7df1:14a6 with SMTP id
 h1-20020a2e9001000000b002c17df114a6mr15020668ljg.9.1696880557717; Mon, 09 Oct
 2023 12:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230928134517eucas1p296d2f03574a8948e642cfbfb5826539b@eucas1p2.samsung.com>
 <20230928134506.130545-1-a.bokowy@samsung.com> <CABBYNZ+=c_G9wRRw4BvzypSu980ThzzdcUz_jMthe5_UZnE9Ew@mail.gmail.com>
 <94802ffc-9949-c968-ab96-e63f98cb684a@samsung.com>
In-Reply-To: <94802ffc-9949-c968-ab96-e63f98cb684a@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Oct 2023 12:42:25 -0700
Message-ID: <CABBYNZJJE=WUbWck_2_MESEp=DOFxkL5nhdyjhaMs+1561VOHQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: Synchronize scan start and LE Meta events
To:     Arkadiusz Bokowy <a.bokowy@samsung.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Arek,

On Mon, Oct 9, 2023 at 2:25=E2=80=AFAM Arkadiusz Bokowy <a.bokowy@samsung.c=
om> wrote:
>
> Hi,
>
> >> +/* Wait for all pending HCI commands to complete.
> >> + */
> >> +void hci_cmd_sync_flush(struct hci_dev *hdev)
> >> +{
> >> +       flush_work(&hdev->cmd_sync_work);
> >
> > Afaik this will block waiting the work to complete which sounds a
> > little dangerous especially if hdev has been locked.
>
> Yes, this will block wait for all tasks queued on the cmd_synd_work.
> Unfortunately, I'm not very familiar (not yet) with BlueZ kernel
> component, so I'm not saying that this solution is correct. I hoped
> that someone with actual kernel knowledge will review it :)
>
> Anyway, my simple test case passes with such solution without any lockups=
.
>
> Alternatively, I can move this block wait before hdev lock in
> hci_le_*_adv_report_evt() functions.
>
> > Couldn't we just do:
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 195aea2198a9..78f0a8fb0a19 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -136,6 +136,7 @@ bool hci_discovery_active(struct hci_dev *hdev)
> >          struct discovery_state *discov =3D &hdev->discovery;
> >
> >          switch (discov->state) {
> > +       case DISCOVERY_STARTING:
> >          case DISCOVERY_FINDING:
> >          case DISCOVERY_RESOLVING:
> >                  return true;
>
> I'm not sure whether it will fix the issue... I've tested it and it does
> not pass my test with a delay added to the start_discovery_complete()
> function. The problem here is with synchronization. Since the LE meta
> event (device found) and start discovery completion might be processed
> simultaneously... Also, it will not be true that discovery is active if
> the state is "starting", because HCI might return error when enabling
> scanning.
>
> There is other solution to my problem, though. In a real world case
> scenario, it's not an issue that the LE meta event coming just after
> scan enabled signal will be dropped, because there will be more such
> events later. The problem is with btvirt, which does not "broadcasts" LE
> meta events when discovering is enabled. So, I can "fix" btvirt instead
> of patching the kernel, by repeatedly signaling LE meta events. This
> will slightly increase CPU load with btvirt, but will work. What do you
> think?

Yeah, I think it is more of an issue with btdev then, perhaps we need
to add a delay or something to generate the reports, or we keep
generating them based on the scan parameters that way it would emulate
a little bit better how it works with real controllers, that said keep
in mind that we need to cancel all timers properly as well if we go
ahead with this change.

> Regards,
> Arek



--=20
Luiz Augusto von Dentz
