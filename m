Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488A5C7EE2A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 23:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjEVXIW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 19:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEVXIT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 19:08:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7430E10D
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 16:08:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3af4295ddso4202777e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684796895; x=1687388895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpXEeQOFAfH7VXiVwLDf0nx3J38hqatI4C00+bQ/P4I=;
        b=MJXOeBnkoJU6vvFltflGDvce0Nl2+enOJbA19aDV9qhDTmEUl/OkzhYSSxlfUxCPy9
         L6uAnlF5BHlmp5r8oRaY2lcGeaIo0NOlsR3KaDUDDkfboHbQqRd8XNsyoEG/A4Abwrms
         wPadymTXOhhbpJiEVR4hD0sYdGhT1N6nyG96alHMWa3Cxi/PYoRE4gVUYrCDnWWBKa0U
         RzOtm0HH2qW/wr33U6mchQjlw3LlZtJ2lhIe/BlBiBnt1qX/m5uIffyGbhIlW6e0Ug2O
         54jNK4K/xBhAhUh8KIz3oRnYGGz6GkTgWNyH3+dcYPf2UNXusRFueUdnbp7oSceuHfgg
         o5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684796895; x=1687388895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpXEeQOFAfH7VXiVwLDf0nx3J38hqatI4C00+bQ/P4I=;
        b=eSa6HiiB+ddmWipAz3hlJwv6J/J5GhsqrGxBKwgoYxDbGm012HPmeAgGaf21Z6n1lj
         le9uFBN8Q75w5tcgtpQhLTjwreiYkfVftRHyVmFr/jFgv3E027JocGBeSfzqnUPyRsau
         1YL7ggsNgFOxdvRErEGCbwo5fRBIKjL+DuWjgyxl75v1AmZP+JDxkNjzKtro0Jh9ypRG
         YqLqo5VzWVvFBpmmOkPk3Vam4eIkL2KpIgQTV1qBNi/F6+O4giNUssFkSDItwqLzc88h
         LGgA/uSsNoi92lW+51GYW6fBqkaEMyabXKh/IG407mlr+ffv+ipOVtIuS4nLbhn8RFiH
         ++FQ==
X-Gm-Message-State: AC+VfDyfBxNYSDrX5pA50XQSVmumqMwxtZd/+E6Ef8Zd43sate3sV+Bf
        aFNtFTOkPLMJd3XkU20wYC5+c9I8bjp36lmPUhUadUMw
X-Google-Smtp-Source: ACHHUZ5vLpy6PWmt+KWjAqeZIGRCbEP3DaiuI4jWHYnflaUecDJ/R+rnoJaOPZWxFwKhSidHiqC+p7kvCHa4wMVkCb0=
X-Received: by 2002:a05:651c:231:b0:2ac:80cd:6c0d with SMTP id
 z17-20020a05651c023100b002ac80cd6c0dmr4477170ljn.19.1684796895125; Mon, 22
 May 2023 16:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
 <aa64f9c867330b2e691ee65ac30104b8757d7a4b.1684682575.git.pav@iki.fi>
 <CABBYNZJDw5fNq9fQ7b29WBpEdAypsG_fazp5M_-7430r7YVpSA@mail.gmail.com>
 <5f42d35bf0183db243f7cd577dc81a5322e61980.camel@iki.fi> <CABBYNZJpT+vPp2JKhvnE1zgk0x-xoQ5OTYhyJfXC6xqZxKWAhg@mail.gmail.com>
In-Reply-To: <CABBYNZJpT+vPp2JKhvnE1zgk0x-xoQ5OTYhyJfXC6xqZxKWAhg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 May 2023 16:08:02 -0700
Message-ID: <CABBYNZL=YB77P3cg=3HboojGr7-kZ5AfF8-ijP9qwsFm7Gp5Jg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] iso-tester: add tests for multiple simultaneous CIG
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, May 22, 2023 at 1:48=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pauli,
>
> On Mon, May 22, 2023 at 1:38=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >
> > Hi Luiz,
> >
> > ma, 2023-05-22 kello 11:28 -0700, Luiz Augusto von Dentz kirjoitti:
> > > Hi Pauli,
> > >
> > > On Sun, May 21, 2023 at 8:32=E2=80=AFAM Pauli Virtanen <pav@iki.fi> w=
rote:
> > > >
> > > > Add tests connecting two CIS using different CIG_ID, with fixed and
> > > > auto-allocated IDs.
> > > >
> > > > ISO Connect2 CIG 0x01/0x02 Seq - Success
> > > > ISO Connect2 CIG auto/auto Seq - Success
> > > >
> > > > The CIS are connected sequentially so that the first is closed afte=
r the
> > > > second is connected. In the auto/auto case the kernel shall pick a =
new
> > > > CIG_ID since the first CIG_ID is no longer in a configurable state.
> > >
> > > Is this somewhat similar to AC 7(i) but using different CIGs? I
> > > suspect this is not covered on BAP, although it is a valid audio
> > > configuration, perhaps we could use AC 7(i)-alt or something.
> >
> > Yes, AC 6(ii) but with the CIS in separate CIGs. I'll change the name
> > then.
> >
> > I think BAP only specifies audio configurations with a single CIG. This
> > seems to be valid configuration according to Core spec though, although
> > does not appear to be required.
>
> I did apply it already:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D06aa42214=
5de456ec153a0d062a7e7ef8630cdc0
>
> Feel free to add more AC combinations so we can cover different QoS as
> well rather than just 1 + 2.

Btw, I just confirmed that our firmware only supports 1 CIG and 2 CIS
per peer, so if you were planning to use 2 CIGs separately that is
unfortunately not supported currently as that probably requires a lot
more resources, and scheduler changes, to support all the combinations
I'm afraid we will need a pretty strong argument to change that.

> > >
> > > > ---
> > > >
> > > > Notes:
> > > >     The second tests hits a bug in kernel CIG auto-allocation, whic=
h always
> > > >     picks CIG_ID 0 even if it is not in a configurable state.
> > > >
> > > >     ISO Connect2 CIG auto/auto Seq - Success - setup complete
> > > >     ISO Connect2 CIG auto/auto Seq - Success - run
> > > >       Connecting to 00:AA:01:01:00:00...
> > > >       Connect 0 in progress
> > > >       Connecting to 00:AA:01:02:00:01...
> > > >       Connect 1 in progress
> > > >       Successfully connected
> > > >       Step 1
> > > >       Connect failed: Device or resource busy (16)
> > > >       Expect error: Success (0) !=3D Device or resource busy (16)
> > > >
> > > >  tools/iso-tester.c | 48 ++++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 48 insertions(+)
> > > >
> > > > diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> > > > index 164cb465f..fc2a84215 100644
> > > > --- a/tools/iso-tester.c
> > > > +++ b/tools/iso-tester.c
> > > > @@ -64,6 +64,11 @@
> > > >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> > > >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
> > > >
> > > > +#define QOS_2(_interval, _latency, _sdu, _phy, _rtn) \
> > > > +       QOS_FULL(0x02, BT_ISO_QOS_CIS_UNSET, \
> > > > +               QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> > > > +               QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
> > > > +
> > > >  #define QOS_1_1(_interval, _latency, _sdu, _phy, _rtn) \
> > > >         QOS_FULL(0x01, 0x01, \
> > > >                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> > > > @@ -109,6 +114,7 @@
> > > >  #define QOS_16_1_1 QOS(7500, 8, 30, 0x02, 2)
> > > >  #define QOS_16_2_1 QOS(10000, 10, 40, 0x02, 2)
> > > >  #define QOS_1_16_2_1 QOS_1(10000, 10, 40, 0x02, 2)
> > > > +#define QOS_2_16_2_1 QOS_2(10000, 10, 40, 0x02, 2)
> > > >  #define QOS_1_1_16_2_1 QOS_1_1(10000, 10, 40, 0x02, 2)
> > > >  #define QOS_24_1_1 QOS(7500, 8, 45, 0x02, 2)
> > > >  #define QOS_24_2_1 QOS(10000, 10, 60, 0x02, 2)
> > > > @@ -546,6 +552,20 @@ static const struct iso_client_data connect_1_=
16_2_1 =3D {
> > > >         .expect_err =3D 0
> > > >  };
> > > >
> > > > +static const struct iso_client_data connect_2_16_2_1 =3D {
> > > > +       .qos =3D QOS_1_16_2_1,
> > > > +       .qos_2 =3D QOS_2_16_2_1,
> > > > +       .expect_err =3D 0,
> > > > +       .mcis =3D true,
> > > > +};
> > > > +
> > > > +static const struct iso_client_data connect_2a_16_2_1 =3D {
> > > > +       .qos =3D QOS_16_2_1,
> > > > +       .qos_2 =3D QOS_16_2_1,
> > > > +       .expect_err =3D 0,
> > > > +       .mcis =3D true,
> > > > +};
> > > > +
> > > >  static const struct iso_client_data connect_1_1_16_2_1 =3D {
> > > >         .qos =3D QOS_1_1_16_2_1,
> > > >         .expect_err =3D 0
> > > > @@ -2126,6 +2146,25 @@ static void test_connect2(const void *test_d=
ata)
> > > >         setup_connect_many(data, 2, num, funcs);
> > > >  }
> > > >
> > > > +static gboolean iso_connect2_seq_cb(GIOChannel *io, GIOCondition c=
ond,
> > > > +                                                       gpointer us=
er_data)
> > > > +{
> > > > +       struct test_data *data =3D tester_get_data();
> > > > +
> > > > +       data->io_id[0] =3D 0;
> > > > +
> > > > +       setup_connect(data, 1, iso_connect2_cb);
> > > > +
> > > > +       return iso_connect(io, cond, user_data);
> > > > +}
> > > > +
> > > > +static void test_connect2_seq(const void *test_data)
> > > > +{
> > > > +       struct test_data *data =3D tester_get_data();
> > > > +
> > > > +       setup_connect(data, 0, iso_connect2_seq_cb);
> > > > +}
> > > > +
> > > >  static void test_bcast(const void *test_data)
> > > >  {
> > > >         struct test_data *data =3D tester_get_data();
> > > > @@ -2264,6 +2303,15 @@ int main(int argc, char *argv[])
> > > >         test_iso("ISO QoS - Invalid", &connect_invalid, setup_power=
ed,
> > > >                                                         test_connec=
t);
> > > >
> > > > +       test_iso2("ISO Connect2 CIG 0x01/0x02 Seq - Success", &conn=
ect_2_16_2_1,
> > > > +                                                       setup_power=
ed,
> > > > +                                                       test_connec=
t2_seq);
> > > > +
> > > > +       test_iso2("ISO Connect2 CIG auto/auto Seq - Success",
> > > > +                                                       &connect_2a=
_16_2_1,
> > > > +                                                       setup_power=
ed,
> > > > +                                                       test_connec=
t2_seq);
> > > > +
> > > >         test_iso_rej("ISO Connect - Reject", &connect_reject, setup=
_powered,
> > > >                         test_connect, BT_HCI_ERR_CONN_FAILED_TO_EST=
ABLISH);
> > > >
> > > > --
> > > > 2.40.1
> > > >
> > >
> > >
> >
> > --
> > Pauli Virtanen
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
