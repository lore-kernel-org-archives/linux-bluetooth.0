Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5493BC77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 20:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjEVUs2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjEVUsZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 16:48:25 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C9FA
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 13:48:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2af2b74d258so37360251fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684788503; x=1687380503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXVgv6jQI5GiY8JyGncGEKRwolEw4/TvpIDgDrZ26yk=;
        b=TmaASgF/SEOekVlp22HX/Nn8EPWzk30Uk3Hz/IsfbhX6ogUTbvgJ/e6nxLM2H9sXI+
         itKLzDKLINIhJnj4/eh84ne+pTE6wYpxdvKaw0QzmeS7Q/LMeapGAD4YycWQnecTm522
         z2KP4HfM6qsGBAYYVqX8NQ9y4ZdnPBUmt0MaLpIcQgCAUlz6o0t4HlungGK2+A1dCKCT
         PPSqzRs+xNFrK56FBucGBn0LpmafrP9Ni24TmGhEHgon6kEeKnnm0bQXdur1XBvDGW9s
         bYzcDP7mTcxtcYnehVoJPiNzYsaZVNQUS7f0txLj1w/H4bfJs23DphmQVzEff7AS6sKE
         gYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788503; x=1687380503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXVgv6jQI5GiY8JyGncGEKRwolEw4/TvpIDgDrZ26yk=;
        b=QSxtMQn1c5vp9JNQO8t8L7rlzm76trJgS7/EcsxANPoKXNsg122OWdJNOv9qXUQmdo
         R43jCljoJQZ6S0z1k1NYSsgCg+mQh7NMOFwDB7p2djxzwee0XLJ/dGa/0SmSrOjsdQhi
         M7l5EII+h8FV/lJ7Gbd/uwq3r9nKOU+m/qFLvyQ8ovTuAbnZcfpZcHlAA6kmLoNdk/A8
         RhNvdKErNuxG5jasO7oSUXr6zt+e9gvcC+yu+4RJAiI3gVMHq5RKTX0T+spSy5vCnYsL
         U7kDOeHqhmafT2CVfk6s6n/nfnmZ7Lvtq6I/0rxtqQbYslY7hkTIU+HyqqvzOwzrUz7Y
         +J3w==
X-Gm-Message-State: AC+VfDwkvmVm9z6B2pwGPYsnV3JiHasL599EvYZmrVd3JviZB/VBXJ+h
        MfmIBV9VIBC+sIGlwOamXbS79enSXe/BRRpOPR0FVo/g4eg=
X-Google-Smtp-Source: ACHHUZ4PS+l7TKBJVLiGku6VVC2ersavDuhYRqN/feinPkOmxEOSBXPL/3Fm47hWc6kRTFk0ZyqaK+80mhuTnJmh6cA=
X-Received: by 2002:a2e:330e:0:b0:2ad:a12d:e458 with SMTP id
 d14-20020a2e330e000000b002ada12de458mr4481093ljc.41.1684788502579; Mon, 22
 May 2023 13:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
 <aa64f9c867330b2e691ee65ac30104b8757d7a4b.1684682575.git.pav@iki.fi>
 <CABBYNZJDw5fNq9fQ7b29WBpEdAypsG_fazp5M_-7430r7YVpSA@mail.gmail.com> <5f42d35bf0183db243f7cd577dc81a5322e61980.camel@iki.fi>
In-Reply-To: <5f42d35bf0183db243f7cd577dc81a5322e61980.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 May 2023 13:48:10 -0700
Message-ID: <CABBYNZJpT+vPp2JKhvnE1zgk0x-xoQ5OTYhyJfXC6xqZxKWAhg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] iso-tester: add tests for multiple simultaneous CIG
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, May 22, 2023 at 1:38=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2023-05-22 kello 11:28 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sun, May 21, 2023 at 8:32=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Add tests connecting two CIS using different CIG_ID, with fixed and
> > > auto-allocated IDs.
> > >
> > > ISO Connect2 CIG 0x01/0x02 Seq - Success
> > > ISO Connect2 CIG auto/auto Seq - Success
> > >
> > > The CIS are connected sequentially so that the first is closed after =
the
> > > second is connected. In the auto/auto case the kernel shall pick a ne=
w
> > > CIG_ID since the first CIG_ID is no longer in a configurable state.
> >
> > Is this somewhat similar to AC 7(i) but using different CIGs? I
> > suspect this is not covered on BAP, although it is a valid audio
> > configuration, perhaps we could use AC 7(i)-alt or something.
>
> Yes, AC 6(ii) but with the CIS in separate CIGs. I'll change the name
> then.
>
> I think BAP only specifies audio configurations with a single CIG. This
> seems to be valid configuration according to Core spec though, although
> does not appear to be required.

I did apply it already:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D06aa422145d=
e456ec153a0d062a7e7ef8630cdc0

Feel free to add more AC combinations so we can cover different QoS as
well rather than just 1 + 2.

> >
> > > ---
> > >
> > > Notes:
> > >     The second tests hits a bug in kernel CIG auto-allocation, which =
always
> > >     picks CIG_ID 0 even if it is not in a configurable state.
> > >
> > >     ISO Connect2 CIG auto/auto Seq - Success - setup complete
> > >     ISO Connect2 CIG auto/auto Seq - Success - run
> > >       Connecting to 00:AA:01:01:00:00...
> > >       Connect 0 in progress
> > >       Connecting to 00:AA:01:02:00:01...
> > >       Connect 1 in progress
> > >       Successfully connected
> > >       Step 1
> > >       Connect failed: Device or resource busy (16)
> > >       Expect error: Success (0) !=3D Device or resource busy (16)
> > >
> > >  tools/iso-tester.c | 48 ++++++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 48 insertions(+)
> > >
> > > diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> > > index 164cb465f..fc2a84215 100644
> > > --- a/tools/iso-tester.c
> > > +++ b/tools/iso-tester.c
> > > @@ -64,6 +64,11 @@
> > >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> > >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
> > >
> > > +#define QOS_2(_interval, _latency, _sdu, _phy, _rtn) \
> > > +       QOS_FULL(0x02, BT_ISO_QOS_CIS_UNSET, \
> > > +               QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> > > +               QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
> > > +
> > >  #define QOS_1_1(_interval, _latency, _sdu, _phy, _rtn) \
> > >         QOS_FULL(0x01, 0x01, \
> > >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> > > @@ -109,6 +114,7 @@
> > >  #define QOS_16_1_1 QOS(7500, 8, 30, 0x02, 2)
> > >  #define QOS_16_2_1 QOS(10000, 10, 40, 0x02, 2)
> > >  #define QOS_1_16_2_1 QOS_1(10000, 10, 40, 0x02, 2)
> > > +#define QOS_2_16_2_1 QOS_2(10000, 10, 40, 0x02, 2)
> > >  #define QOS_1_1_16_2_1 QOS_1_1(10000, 10, 40, 0x02, 2)
> > >  #define QOS_24_1_1 QOS(7500, 8, 45, 0x02, 2)
> > >  #define QOS_24_2_1 QOS(10000, 10, 60, 0x02, 2)
> > > @@ -546,6 +552,20 @@ static const struct iso_client_data connect_1_16=
_2_1 =3D {
> > >         .expect_err =3D 0
> > >  };
> > >
> > > +static const struct iso_client_data connect_2_16_2_1 =3D {
> > > +       .qos =3D QOS_1_16_2_1,
> > > +       .qos_2 =3D QOS_2_16_2_1,
> > > +       .expect_err =3D 0,
> > > +       .mcis =3D true,
> > > +};
> > > +
> > > +static const struct iso_client_data connect_2a_16_2_1 =3D {
> > > +       .qos =3D QOS_16_2_1,
> > > +       .qos_2 =3D QOS_16_2_1,
> > > +       .expect_err =3D 0,
> > > +       .mcis =3D true,
> > > +};
> > > +
> > >  static const struct iso_client_data connect_1_1_16_2_1 =3D {
> > >         .qos =3D QOS_1_1_16_2_1,
> > >         .expect_err =3D 0
> > > @@ -2126,6 +2146,25 @@ static void test_connect2(const void *test_dat=
a)
> > >         setup_connect_many(data, 2, num, funcs);
> > >  }
> > >
> > > +static gboolean iso_connect2_seq_cb(GIOChannel *io, GIOCondition con=
d,
> > > +                                                       gpointer user=
_data)
> > > +{
> > > +       struct test_data *data =3D tester_get_data();
> > > +
> > > +       data->io_id[0] =3D 0;
> > > +
> > > +       setup_connect(data, 1, iso_connect2_cb);
> > > +
> > > +       return iso_connect(io, cond, user_data);
> > > +}
> > > +
> > > +static void test_connect2_seq(const void *test_data)
> > > +{
> > > +       struct test_data *data =3D tester_get_data();
> > > +
> > > +       setup_connect(data, 0, iso_connect2_seq_cb);
> > > +}
> > > +
> > >  static void test_bcast(const void *test_data)
> > >  {
> > >         struct test_data *data =3D tester_get_data();
> > > @@ -2264,6 +2303,15 @@ int main(int argc, char *argv[])
> > >         test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered=
,
> > >                                                         test_connect)=
;
> > >
> > > +       test_iso2("ISO Connect2 CIG 0x01/0x02 Seq - Success", &connec=
t_2_16_2_1,
> > > +                                                       setup_powered=
,
> > > +                                                       test_connect2=
_seq);
> > > +
> > > +       test_iso2("ISO Connect2 CIG auto/auto Seq - Success",
> > > +                                                       &connect_2a_1=
6_2_1,
> > > +                                                       setup_powered=
,
> > > +                                                       test_connect2=
_seq);
> > > +
> > >         test_iso_rej("ISO Connect - Reject", &connect_reject, setup_p=
owered,
> > >                         test_connect, BT_HCI_ERR_CONN_FAILED_TO_ESTAB=
LISH);
> > >
> > > --
> > > 2.40.1
> > >
> >
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
