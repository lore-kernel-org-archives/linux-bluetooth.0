Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE19C3567B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 05:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4966320661
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 05:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Idn2hpvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBXFXw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 00:23:52 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43324 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBXFXv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 00:23:51 -0500
Received: by mail-il1-f193.google.com with SMTP id p78so6667358ilb.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2020 21:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8BrShjHlW88yKikMKJcKDuM+bGXPM3Ue+6OKXKGnVFY=;
        b=Idn2hpvLksA59Z9QtY/pe0KP4IW9aJzzFpzttwM5Ls5ZZSFrhg8q3Vr/+/ANV3W5ms
         Obhd9JvdecUOWv5hk7uYLVY28Cq8O0pd7bWyN8lQMI6iCF8nVZkniX9ffEKZ4gtaCDsn
         00QF3CXQZHGvaMXxYTeFAas0BqNKyfR8GIyvzO+qcSP+rBmkOR3yclBjjZKYWsMTWbB3
         Sl2HF56wXaqj/6NqvNAqsKWNK20yAjJRzHYxlzaoIwsN2QLSjrkDBiiovFBWH9eipNjS
         O8tMmsgLgjrubTv1AlmSETXpGsFk0lZRy0pHSRcYS7TV9gaJMZdLnyVzucexs0VakPvv
         I2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8BrShjHlW88yKikMKJcKDuM+bGXPM3Ue+6OKXKGnVFY=;
        b=b94WOmo05+yGAii8D4u8/BFdpCi+ywA6P/TlN8wR6GZ2Vkm3pO2nRr2Urow+dQJt02
         0PKsH1V8YhNbr5dhH+2rj5FBSEdznYnU11iy/KgayvEycAqcLoAnBJ1RcChzVqPMMaei
         kJBO8U8xgmW0Cl3liyKHhr/qq+T+3rLfYXruBFP+mvMLA0W8B3ZD7EqXfqcKFnz/Ex2S
         Im20YSpNlKlNMo/sf9duN+EyquAEK6JFCDx3GMMMz5Bh5DTusOPQoYMnaaDuCrY81lZN
         IRQTTIZ0RwyIQTC9n0GynOcru5/+DvpzQOn9ZOnXoP0dwM0Q95Ud5x8hBQLB1+df++eG
         ePdQ==
X-Gm-Message-State: APjAAAWy9qJeWp5yW23emYG3Hyk78/d3qetoYcuXqvyWcfFaOtonbcbR
        33/UL1GBTbSlq/IuAyVStSFLELlU0V4poYGiNlc=
X-Google-Smtp-Source: APXvYqyIGkgHcR0mwA1L/rdmu1nafM7U++x3nd/D9CdfblrP5wXbg9zH7lg0eD9bnjbFci2W7KyJjndZAcvg/GofRtM=
X-Received: by 2002:a92:c986:: with SMTP id y6mr58077296iln.186.1582521830378;
 Sun, 23 Feb 2020 21:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20200218144840.2854-1-sathish.narasimman@intel.com> <F347B999-AB83-4E11-BAD3-7FC08D40AB9B@holtmann.org>
In-Reply-To: <F347B999-AB83-4E11-BAD3-7FC08D40AB9B@holtmann.org>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Mon, 24 Feb 2020 10:55:30 +0530
Message-ID: <CAOVXEJLNS9hK8SxL+12mtvhe7CTPA3fZwYrtY7-x291+s9c45Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix - Remove adv set for directed advertising
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Thu, Feb 20, 2020 at 1:07 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Sathish,
>
> > Extended advertising Data is set during bluetooth initialization
> > by default which causes InvalidHCICommandParameters when setting
> > Extended advertising parameters.
> >
> > As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
> > advertising_event_property LE_LEGACY_ADV_DIRECT_IND does not
> > supports advertising data when the advertising set already
> > contains some, the controller shall return erroc code
> > 'InvalidHCICommandParameters(0x12).
> >
> > So it is required to remove adv set for handle 0x00. since we use
> > instance 0 for directed adv.
> >
> > Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> > ---
> > include/net/bluetooth/hci.h |  2 ++
> > net/bluetooth/hci_conn.c    | 10 ++++++++++
> > net/bluetooth/hci_request.c |  5 +++++
> > net/bluetooth/hci_request.h |  1 +
> > 4 files changed, 18 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 6293bdd7d862..0d7e36c54733 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1724,6 +1724,8 @@ struct hci_cp_le_set_ext_scan_rsp_data {
> >
> > #define LE_SET_ADV_DATA_NO_FRAG               0x01
> >
> > +#define HCI_OP_LE_REMOVE_ADV_SET     0x203c
> > +
> > #define HCI_OP_LE_CLEAR_ADV_SETS      0x203d
> >
> > #define HCI_OP_LE_SET_ADV_SET_RAND_ADDR       0x2035
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 65fa44cbe514..1887da39a93d 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -898,6 +898,16 @@ static void hci_req_directed_advertising(struct hc=
i_request *req,
> >               cp.peer_addr_type =3D conn->dst_type;
> >               bacpy(&cp.peer_addr, &conn->dst);
> >
> > +             /* As per Core Spec 5.2 Vol 2, PART E, Sec 7.8.53, for
> > +              * advertising_event_property LE_LEGACY_ADV_DIRECT_IND
> > +              * does not supports advertising data when the advertisin=
g set already
> > +              * contains some, the controller shall return erroc code =
'Invalid
> > +              * HCI Command Parameters(0x12).
> > +              * So it is required to remove adv set for handle 0x00. s=
ince we use
> > +              * instance 0 for directed adv.
> > +              */
> > +             hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(cp.hand=
le), &cp.handle);
> > +
> >               hci_req_add(req, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(cp)=
, &cp);
> >
> >               if (own_addr_type =3D=3D ADDR_LE_DEV_RANDOM &&
> > diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> > index 2a1b64dbf76e..63da7acbb48c 100644
> > --- a/net/bluetooth/hci_request.c
> > +++ b/net/bluetooth/hci_request.c
> > @@ -1550,6 +1550,11 @@ int hci_get_random_address(struct hci_dev *hdev,=
 bool require_privacy,
> >       return 0;
> > }
> >
> > +void __hci_req_remove_adv_set(struct hci_request *req, u8 handle)
> > +{
> > +     hci_req_add(req, HCI_OP_LE_REMOVE_ADV_SET, sizeof(handle), &handl=
e);
> > +}
> > +
> > void __hci_req_clear_ext_adv_sets(struct hci_request *req)
> > {
> >       hci_req_add(req, HCI_OP_LE_CLEAR_ADV_SETS, 0, NULL);
> > diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
> > index a7019fbeadd3..8dd40c6c33c8 100644
> > --- a/net/bluetooth/hci_request.h
> > +++ b/net/bluetooth/hci_request.h
> > @@ -84,6 +84,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev,=
 struct sock *sk,
> > int __hci_req_setup_ext_adv_instance(struct hci_request *req, u8 instan=
ce);
> > int __hci_req_start_ext_adv(struct hci_request *req, u8 instance);
> > int __hci_req_enable_ext_advertising(struct hci_request *req, u8 instan=
ce);
> > +void __hci_req_remove_adv_set(struct hci_request *req, u8 handle);
>
> I don=E2=80=99t get this part of the patch. It is actually not used.
>
> Regards
>
> Marcel
>

it is a mistake. corected and updated the right patch set v2

Regards
Sathish N
