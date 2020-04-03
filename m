Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C3FC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0FC2077D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 18:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2nFSLdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404212AbgDCSI6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:08:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40362 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgDCSI5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 14:08:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so7871682ljj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EiqS1cpCoNakgz+V9OjVJVKBwDP9abWkyart37dFgaQ=;
        b=W2nFSLdpN/UGXfhG51ZZvmsZxh5hp17QGBV0slNzgYQQ2anAa2dFU2/EnzER3GIAlj
         rH8m0i/NgtGsP6OzecJplZ9xxNMRlKkAVaopTmkgIj9FxLDvVSc9Rs5Z1W7gVqd4peK3
         Q/uomW7JPGpm7TlQKnkhWS4Le3RvpJhHJ3o5J6eOG/aQw4RU4elX4w1zojwDFB90qpgc
         88GGWYOidbIhzwzb/feqUFidm1dj2AI/J8jIne/Q3+KYR7th8HRSxzxY+BnDoJ+cRDvD
         7rOTJk9zw7tVUzGKeMHXmZwVzRD2i1G/6ZTVTUwdM4QH/UHT84gkcekVKNRJgg12dZHh
         encg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EiqS1cpCoNakgz+V9OjVJVKBwDP9abWkyart37dFgaQ=;
        b=ALmYPYeGsUWM2bohFVRkaGlhG01siLlMa4RdnESbJ/BRrgqfaXd66YlfLATAmqil77
         FE+a9rfeRMhMe3lOXZcbQewnqNg+5c42PCl09VIrt5DFx4Kkuv6ZSD5v5r85WOXklDVy
         7W5fkXS3eoD4VpSGoUcYpeyW/mjwah/2dV/pQqB5QEfYOwNMjjwyzy0JECpUR1nN7p3Z
         Hj4SKhern2J4hXIJujFhOKWIIfQs4y4EJHwTZ2eRkwbvLDDZLIJHMkiQ05F5zaS5wC2N
         MTEHSTsEZxjUWTE9wQqBIB4WDLHi/XbqxkXwCEBOMAivO8HwSlzJf/SIpmY6Aty1hKbh
         lEaQ==
X-Gm-Message-State: AGi0PuabjmGv2DjpPzULtWsKfaVmpwmhriWRBJVfY2r/5dKbIiKbGJoI
        cGffF5dd2ixy+KHn3tnd4ZtdDTfpKL8bBx9NQPfdhg==
X-Google-Smtp-Source: APiQypJ0wbXBg6YtXsOs4IS/cr7cPW25IjK4bSv7DPiiz42Jfj5pqQbfmU0WH60E6I9ivkMGxRHrEqryCOog3Gvnb6w=
X-Received: by 2002:a2e:3a16:: with SMTP id h22mr5187353lja.81.1585937335056;
 Fri, 03 Apr 2020 11:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200403133806.246918-1-alainm@chromium.org> <D3C05492-13B9-447C-982B-26B681C9EF8C@holtmann.org>
 <CALWDO_Xy0m4PyAACDAHmf9wmPGwKoW6keYWHy8UKjNcsLF5SDQ@mail.gmail.com>
 <BF96E348-7D97-4FF8-A888-4B8338ACF6CA@holtmann.org> <CALWDO_XOkASZd=YXbLt+otyjtmVcSQtwDai0HjkuA_X-RCor4g@mail.gmail.com>
 <F1BE9BA5-9260-4312-9605-1B225CD08327@holtmann.org>
In-Reply-To: <F1BE9BA5-9260-4312-9605-1B225CD08327@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Fri, 3 Apr 2020 14:08:43 -0400
Message-ID: <CALWDO_Xba=A9bHMQ0m7PWWXxueKqGFGQ=ki5kCJwr3m+3KbXrA@mail.gmail.com>
Subject: Re: [PATCH v1] bluetooth:Adding driver and quirk defs for multi-role LE
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Apr 3, 2020 at 2:04 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> >>>>> This change adds the relevant driver and quirk to allow drivers to
> >>>>> report that concurrent roles are well supported by the controller.
> >>>>>
> >>>>> This has historically been disabled as controllers did not reliably
> >>>>> support this. In particular, this will be used to relax this condit=
ion
> >>>>> for controllers that have been well tested and reliable.
> >>>>>
> >>>>>     /* Most controller will fail if we try to create new connection=
s
> >>>>>      * while we have an existing one in slave role.
> >>>>>      */
> >>>>>     if (hdev->conn_hash.le_num_slave > 0)
> >>>>>             return NULL;
> >>>>>
> >>>>> Signed-off-by: Alain Michaud <alainm@chromium.org>
> >>>>> ---
> >>>>>
> >>>>> drivers/bluetooth/btusb.c   | 2 ++
> >>>>> include/net/bluetooth/hci.h | 8 ++++++++
> >>>>> 2 files changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >>>>> index 3bdec42c9612..22e61a502d40 100644
> >>>>> --- a/drivers/bluetooth/btusb.c
> >>>>> +++ b/drivers/bluetooth/btusb.c
> >>>>> @@ -58,6 +58,8 @@ static struct usb_driver btusb_driver;
> >>>>> #define BTUSB_CW6622          0x100000
> >>>>> #define BTUSB_MEDIATEK                0x200000
> >>>>> #define BTUSB_WIDEBAND_SPEECH 0x400000
> >>>>> +#define BTUSB_LE_CONCURRENT_ROLES_SUPPORTED \
> >>>>> +                             0x800000
> >>>>>
> >>>>> static const struct usb_device_id btusb_table[] =3D {
> >>>>>     /* Generic Bluetooth USB device */
> >>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hc=
i.h
> >>>>> index 5f60e135aeb6..b2c76cde7cd4 100644
> >>>>> --- a/include/net/bluetooth/hci.h
> >>>>> +++ b/include/net/bluetooth/hci.h
> >>>>> @@ -214,6 +214,14 @@ enum {
> >>>>>      * This quirk must be set before hci_register_dev is called.
> >>>>>      */
> >>>>>     HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
> >>>>> +
> >>>>> +     /* When this quirk is set, the controller has validated that
> >>>>> +      * concurrent LE roles are supported.  This mechanism is nece=
ssary
> >>>>> +      * as many controllers have been seen has having trouble init=
iating
> >>>>> +      * a connectable advertisement after at least one connection =
in
> >>>>> +      * central had already been established.
> >>>>> +      */
> >>>>> +     HCI_QUIRK_LE_CONCURRENT_ROLES_SUPPORTED,
> >>>>> };
> >>>>
> >>>> lets do this the other way around. Lets remove the limitation we hav=
e in our HCI core code. And then we see which controllers report errors. Tr=
ying to enable each controller individually is cumbersome. I rather later o=
n blacklist the one or two historic controllers that don=E2=80=99t support =
it.
> >>>>
> >>>
> >>> I agree it's cumbersome but given we don't have much data or existing
> >>> tests around this, we don't have too many options.  I strongly
> >>> disagree with the approach of simply enabling it and seeing what
> >>> breaks as scenarios using this functionality are expected to scale ou=
t
> >>> quickly, likely before we have time to fine all controller issues.
> >>>
> >>> My team is building test infrastructure to help collect data with
> >>> this, we already know it's already problematic on a range of
> >>> controllers and we have a good idea on which controllers which will b=
e
> >>> set.  We will contribute to the cumbersome part of this.
> >>
> >> can we at least do something a bit smarter based on the LE Read Suppor=
ted States command?
> >>
> >> If that command in general indicates that central and peripheral mode =
is supported concurrently, we provide the support for advertising. If it is=
 not supported, we just don=E2=80=99t indicate support for advertising.
> > In an ideal case I'd say yes, but that's also proven not to be a
> > reliable metric.  Unfortunately it doesn't seem to be covered by
> > qualification program and as a result, it is largely not trustworthy.
> >
> >>
> >> So I have a really bad experience with the move from Bluetooth 1.0b to=
 1.1 and the HCI Reset on init. We got that wrong by whitelisting
> > hardware and it came to bite us badly when the number of controllers
> > increased that just got the spec right.
> > I'm afraid I don't have a good exit plan for this at the moment.  It
> > may be something we either need to have some sort of extention for the
> > hardware to report the appropriate support or better, fix the
> > compliance gap so after a particular HCI version the bit field becomes
> > trustworthy.
>
> why do we always end up in these rock vs hard-place situations ;)
This is, IMO, a direct result of poor quality of the qualification
program, especially around HCI contract validation.

>
> You might realize that I am really reluctant with whitelisting of behavio=
r that should be default. Do you happen to have a bit more data that you ca=
n share?
We are still collecting the data.  We can share the data around when
we'd be ready to set the driver flag :)

>
> Or can we do at least something like QUIRK_VALID_LE_STATES and if that qu=
irk is not set, then only central mode gets enabled. We can then provide a =
debugfs setting for that quirk.
I'm happy to change this into QUIK_VALID_LE_STATES, but I admit that
testing some of the directed advertisement states are beyond the scope
of what I'm comfortable signing up for.

>
> Regards
>
> Marcel
>
