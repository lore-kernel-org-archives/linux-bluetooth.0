Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA9C76196
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 15:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCVPIb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCVPIa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 11:08:30 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8758DD30B
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 08:08:29 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id p20-20020a056830319400b0069f914e5c74so2261009ots.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlxq1tmznHFpoGh2GYKjdlf/7+Mh7HZywHWx+7ARsp4=;
        b=CiQ17xVeCqAXgZ00g4DLB5qVDr7nzPFUjoqdQVOm7DYTI9xcnRNZBQugqEQuk6pjOK
         HDLLV9rwY/X31ZylP5kELDtcTXlu2Car6F8iRNdCYC6VTOZ/s6+6CtbJzeciaG4Jm1R+
         UznuDyxY+66Euds5gl98wk8PBRLOt6JC8yG7gO5Yi1blgHRGrO3n3d8pMbjrBmdP6DJ+
         TfEzzqy3v5jM9ZpOV4Ga+zUPjKxhaiXooLNs4pP83yD1LBqJpj29lNk37KjpUxGVoqtD
         MyabZPjcCT6Dd65z3oj3WoBDKxbjSViwUTJ2TPDPtn9SxTkCsG9hpD/+mN6Dbj80nhIC
         gePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dlxq1tmznHFpoGh2GYKjdlf/7+Mh7HZywHWx+7ARsp4=;
        b=sCvL3X0apiR15wvz+rUSqs+T7cU3CMQ+bOF+Dz0k2la6hO0ewjUBLsIaHOpNg9EeQc
         YnH7nNWI/UxOcWtkXYJ1U+ijpg4MwzZGbVBubSDd3WbuNXWzC8jq3FESdJmX6jhFFSn7
         bBmYZWVY7iQJRSUd8lseko+4NztqPFZbnoIXOCf+kfQVeimcS7AJ9oM1QDonUVj95Vnl
         2BWpphDRXD0vYsEt7uUz/KEYXC/RMfjB3f/xBoWIbsvyaf8NyK30fwOvFZs+lpR6ERLv
         lnLIt7EgH/ogvAkrfmNVTGDygs9FfNjr3BQKmEmp1gnaAUVmfVaKv4PbQkcdwHwqOuKQ
         /ONA==
X-Gm-Message-State: AO0yUKX2a/b5xNuGvK/LGU9UmTGQjW44Rxfp2mY7MPKJEiHdgZJbk+bU
        /htoJNXwQkJFFB208cHvzAedLZJxHOpF1QBTx5w=
X-Google-Smtp-Source: AK7set/CIrWdOogpsKpNVZ1N7RYGw3uk0ponfm1hA8mSIWTaF5LSL2yKJupRAIzLMn+vu7VBfycWPZ/z/AaN1b9Apr8=
X-Received: by 2002:a05:6830:1198:b0:690:eb8c:bae0 with SMTP id
 u24-20020a056830119800b00690eb8cbae0mr1199238otq.6.1679497708539; Wed, 22 Mar
 2023 08:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230322012428.2662664-1-raul.cheleguini@gmail.com> <b48ef5be-a64e-48a1-2b43-6e72cc3a0f9f@molgen.mpg.de>
In-Reply-To: <b48ef5be-a64e-48a1-2b43-6e72cc3a0f9f@molgen.mpg.de>
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
Date:   Wed, 22 Mar 2023 12:07:52 -0300
Message-ID: <CACk7upz0sLrCeb8sm04PD8F0wxXm8yfBfpaXkRae=55F16EMig@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Partial support for Actions Semi ATS2851
 based devices
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Paul,

On Wed, Mar 22, 2023 at 5:00=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Raul,
>
>
> Thank you for your patch. You could make the summary a statement by
> adding a verb (in imperative mood):
>
> Add partial support for Actions Semi ATS2851 based devices
>

Thanks Paul, noted it.

> Am 22.03.23 um 02:24 schrieb Raul Cheleguini:
> > The ATS2851 advertises support for commands "Set Random Private Address
> > Timeout" and "Extended Create Connection" but does not actually impleme=
nt
> > them and reply with unknown HCI command.
> >
> > The failed first command blocks the device initialization, and the fail=
ed
> > second command blocks the start of the pairing process.
> >
> > Add these two quirks to unblock the device initialization and to skip
> > the extended create connection command when start pairing.
>
> =E2=80=A6 when start*ing* pairing.

Thanks Paul, noted it too.

>
> > v2: Move the extended create connection quirk to use_ext_conn, edit com=
mit
> > description and add btmon logs.
> >
> > < HCI Command: LE Set Resolvable Private... (0x08|0x002e) plen 2
> >          Timeout: 900 seconds
> >> HCI Event: Command Status (0x0f) plen 4
> >        LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 1
> >          Status: Unknown HCI Command (0x01)
> >
> > < HCI Command: LE Extended Create Conn.. (0x08|0x0043) plen 26
> >          Filter policy: Accept list is not used (0x00)
> >          Own address type: Public (0x00)
> >          Peer address type: Random (0x01)
> >          Peer address: DD:5E:B9:FE:49:3D (Static)
> >          Initiating PHYs: 0x01
> >          Entry 0: LE 1M
> >            Scan interval: 60.000 msec (0x0060)
> >            Scan window: 60.000 msec (0x0060)
> >            Min connection interval: 30.00 msec (0x0018)
> >            Max connection interval: 50.00 msec (0x0028)
> >            Connection latency: 0 (0x0000)
> >            Supervision timeout: 420 msec (0x002a)
> >            Min connection length: 0.000 msec (0x0000)
> >            Max connection length: 0.000 msec (0x0000)
> >> HCI Event: Command Status (0x0f) plen 4
> >        LE Extended Create Connection (0x08|0x0043) ncmd 1
> >          Status: Unknown HCI Command (0x01)
>
> The commit message summary/title says =E2=80=9Cpartial support=E2=80=9D. =
What is not
> working?

The pairing process is not working yet. There is some problem, related
to SMP I believe, that results in disconnection when pairing in Linux.

To give context, after I altered part of SMP code I managed to get my mouse
paired in Linux, but it needs more work to understand and isolate the probl=
em.
I plan to gather more details and start a new thread about it.

I chose to mark it as partial support to inform the readers that it is
work in progress, but at the same time leave the device support in a little
better state than before. Is it acceptable?

> I=E2=80=99d also split this commit into two. One for each quirk.

Thanks for suggesting this and reviewing everything else Paul.
I will split it in two and improve the commit messages.

> > Signed-off-by: Raul Cheleguini <raul.cheleguini@gmail.com>
> > ---
> >   drivers/bluetooth/btusb.c        |  2 ++
> >   include/net/bluetooth/hci.h      | 14 ++++++++++++++
> >   include/net/bluetooth/hci_core.h |  3 ++-
> >   net/bluetooth/hci_sync.c         | 10 +++++++++-
> >   4 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 7382b021f3df..8656ac491f13 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -4105,7 +4105,9 @@ static int btusb_probe(struct usb_interface *intf=
,
> >               /* Support is advertised, but not implemented */
> >               set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirk=
s);
> >               set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quir=
ks);
> > +             set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
> >               set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
> > +             set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
> >       }
> >
> >       if (!reset)
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 997107bfc0b1..3ff1681fd2b8 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -301,6 +301,20 @@ enum {
> >        * don't actually support features declared there.
> >        */
> >       HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
> > +
> > +     /*
> > +      * When this quirk is set, the HCI_OP_LE_SET_RPA_TIMEOUT command =
is
> > +      * disabled. This is required for the Actions Semiconductor ATS28=
51
> > +      * controller, which erroneously claim to support it.
>
> controller*s* or claim*s*

Thanks Paul.

>
> > +      */
> > +     HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT,
> > +
> > +     /*
> > +      * When this quirk is set, the HCI_OP_LE_EXT_CREATE_CONN command =
is
> > +      * disabled. This is required for the Actions Semiconductor ATS28=
51
> > +      * controller, which erroneously claim to support it.
> > +      */
> > +     HCI_QUIRK_BROKEN_EXT_CREATE_CONN,
>
> Ditto.

Thanks Paul.
