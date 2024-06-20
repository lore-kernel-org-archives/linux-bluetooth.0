Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47D31E48B
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893682; cv=none; b=rxSDWb+3rhEKiI6mXf6vQofvpsPC/r7RDlgphPMrST/Wd0WzCF8suJKyqyhCBSPER72DqEPCmh6kT4ikLYCdA3Sj+HlOPHc9NkTOZ+j2O7GLY5M9OuWvEqHQcWJ/ffXAKNfj+JKyT1RRn8DIRIVFAx8cdk5oTOB7oTp+NqZeMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893682; c=relaxed/simple;
	bh=83Q/BKXWIZ+aMKVrwui4ZV/hJV5CIa1d9oLKU5XhlhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaSv3/Jvhz9C0uz6IrG6tgBO2Xj0QH7iPnIJlmeXnp1kV7B5heVGJnBqHg2N6uQGGSY+xZwI+LogzPTZvkyoclDTJplJD1FislgkQuvgY5MC/5xVd16h18kwTt1h5RDdnlZiHoRexl9pakwYVIqcP7GUtAEh+zm1chDZquYmwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG/q+/8H; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG/q+/8H"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso11056281fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718893678; x=1719498478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2S7XfuI678Rd0rpos2fDT+zEMw9InpOFOiBjrGjuAw=;
        b=bG/q+/8HIQVh6B5SwmmK8Qqy2IzxmAZedM0PLhjTnW6ujFxMi7/cwxj1Z/p7hRAxeA
         DXeuhcaJGBW4Sts0EBVcg08qH10KF7gsgFBaoNEp39RdVlpId0D6Vgnk3N8pH/+4d+AL
         FtWtEv6B9aw6mRBKurwYRsznXrS6+w6Z7ZvHspDT9RbUKDqEePdLBezCqcASnBDZau7I
         ACtVK1On1pmKFWoQwrr320Blv++YfTHPZEkmROYIJRhhVsmH8OWUN+gnDTox7v/ceneS
         oRXj+gBm9X7HHPVgLoxpVbBHW2XIUr72YpLiImhPOpJcvr0Kkr6Pc8d8foMr2HoKl2ko
         IwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893678; x=1719498478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2S7XfuI678Rd0rpos2fDT+zEMw9InpOFOiBjrGjuAw=;
        b=VnnncNFvIYHg8/dlwVIrui6fgLlGEpbVdcOoQHoHocfbPHJViyFWPhnSI44zqkjU+k
         jnJ+/LcMknZf9lpUTMA29Uy57nA1SCSmwZKaJGfTXpQhI+JZZeFspPDW5TUxUzHzGHjB
         bcYPWEZGd4Tn8PlRYjKs4nRu2rn9JsMkpCldcJ+F/fv4LE8PzgZzutfcKcoMliXO4yJJ
         ZLdgobY9lE5mO57wT9uD5tH1NNmZsp60dvnfaApU9ZLuyJAl6W+EMDNZmgBzTB1F9byl
         yRfUQbii+JCmbjIUyjepDdeK9PA0kaZGS/RU7EXyN8Fbtd1SNiGU+Ko/8Xl4z+giOdDg
         w8pw==
X-Forwarded-Encrypted: i=1; AJvYcCWDckGPJYqtQQNrNJEcI6hb2kQmypDPtF1Z3++Xzs6fkaoSEhrzqiFAh1tjonaywGjgWccCftyPhqB4K4+dcJNeTuGWNeJ2m0vvtc5eZicy
X-Gm-Message-State: AOJu0YxWFjHhqtQ4uYhI+IM5RKRCf0GVdkQlI+Ge4nV+VPfHvir9FR8f
	FYFovi8OyB3BQ6gp3g+PE+qkVuY7rH2EqguNU7bv6IBfdwIaLxZlVP9yw11Dli8RoK4qWQWy3Qw
	ny/2nGJBR85fuWbYmJoDyp4PAitU=
X-Google-Smtp-Source: AGHT+IEl85AqcOhDrbrFmFHO9I5gFlRS8bMTIFoYdJNPzTsez5t2ySEaNksUm75edFthEyu+f5fRkna2sOWOkxRlRKw=
X-Received: by 2002:a2e:9257:0:b0:2ec:1c95:ff02 with SMTP id
 38308e7fff4ca-2ec3ce7cf49mr36982031fa.7.1718893677800; Thu, 20 Jun 2024
 07:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZL5zp9+ieeVCSsaWQFVw_7qMM21yPNSjH1wV-ANV6Fd8A@mail.gmail.com>
 <20240620142229.21889-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240620142229.21889-1-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 20 Jun 2024 10:27:45 -0400
Message-ID: <CABBYNZL8PmQAzSQHLZH5DT77KoyZOQgAdsHw=1xSK6kiH5Q1LA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR MBIS tests
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: andrei.istodorescu@nxp.com, claudia.rosu@nxp.com, 
	linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Thu, Jun 20, 2024 at 10:22=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Iulia Tanasescu
> > Sent: Monday, June 10, 2024 10:24 AM
> > To: luiz.dentz@gmail.com
> > Cc: Andrei Istodorescu <andrei.istodorescu@nxp.com>; Claudia Cristina
> > Draghicescu <claudia.rosu@nxp.com>; Iulia Tanasescu
> > <iulia.tanasescu@nxp.com>; linux-bluetooth@vger.kernel.org; Mihai-
> > Octavian Urzica <mihai-octavian.urzica@nxp.com>; Vlad Pruteanu
> > <vlad.pruteanu@nxp.com>
> > Subject: Re: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR MBIS
> > tests
> >
> > Hi Luiz,
> >
> > > -----Original Message-----
> > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > Sent: Thursday, June 6, 2024 11:29 PM
> > > To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > > Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> > > <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> > > octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> > > Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > > Subject: Re: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR MBI=
S
> > > tests
> > >
> > > Hi Iulia,
> > >
> > > On Thu, Jun 6, 2024 at 6:26 AM Iulia Tanasescu
> > > <iulia.tanasescu@nxp.com>
> > > wrote:
> > > >
> > > > 4.14.3 Broadcast Audio Stream with Multiple BISes - Source
> > > >
> > > >      Test Purpose:
> > > >      Verify that a Broadcast Source IUT can stream multiple
> > > >      BISes to a Broadcast Sink.
> > > >
> > > >      Test Case Configuration:
> > > >      BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]
> > > >      BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]
> > > >      BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1]
> > > >      BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2]
> > > >      BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1]
> > > >      BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2]
> > > >      BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1]
> > > >      BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2]
> > > >      BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1]
> > > >      BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2]
> > > >      BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1]
> > > >      BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2]
> > > >      BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3]
> > > >      BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4]
> > > >      BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5]
> > > >      BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6]
> > > >      BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]
> > > >
> > > >      Pass verdict:
> > > >      If the Codec ID is LC3, the IUT sends encoded LC3 audio
> > > >      data in BIS Data PDUs on each synchronized BIS.
> > > >
> > > >      If the Codec ID is a vendor-specific Codec ID, the IUT
> > > >      sends BIS Data PDUs on each synchronized BIS. The parameters
> > > >      included in the Codec_Specific_Configuration data are as
> > > >      defined in TSPX_VS_Codec_Specific_Configuration.
> > > >
> > > >      If the Codec ID is LC3, each parameter included in
> > > >      Codec_Specific_Configuration data is formatted in an LTV
> > > >      structure with the length, type, and value specified in
> > > >      Table 4.83.
> > > >
> > > > Test Summary
> > > > ------------
> > > > BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1] Passed
> > > > BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2] Passed
> > > > BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1] Passed
> > > > BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2] Passed
> > > > BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1] Passed
> > > > BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2] Passed
> > > > BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1] Passed
> > > > BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2] Passed
> > > > BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1] Passed
> > > > BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2] Passed
> > > > BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1] Passed
> > > > BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2] Passed
> > > > BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3] Passed
> > > > BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4] Passed
> > > > BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5] Passed
> > > > BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6] Passed
> > > > BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]      Passed
> > > > ---
> > > >  unit/test-bap.c | 354
> > > > ++++++++++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 346 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/unit/test-bap.c b/unit/test-bap.c index
> > > > c37f7676f..30c223d16 100644
> > > > --- a/unit/test-bap.c
> > > > +++ b/unit/test-bap.c
> > > > @@ -6972,27 +6972,86 @@ static void test_bsnk_str(void)
> > > >                 NULL, test_bcast, &cfg_bsnk_str_vs_mbis, IOV_NULL);
> > > > }
> > > >
> > > > +static void stream_count_config(void *data, void *user_data) {
> > > > +       struct bt_bap_stream *stream =3D data;
> > > > +       uint8_t *streams =3D user_data;
> > > > +
> > > > +       if (bt_bap_stream_get_state(stream) =3D=3D
> > > BT_BAP_STREAM_STATE_CONFIG)
> > > > +               (*streams)++;
> > > > +}
> > > > +
> > > > +static void stream_count_enabling(void *data, void *user_data) {
> > > > +       struct bt_bap_stream *stream =3D data;
> > > > +       uint8_t *streams =3D user_data;
> > > > +
> > > > +       if (bt_bap_stream_get_state(stream) =3D=3D
> > > BT_BAP_STREAM_STATE_ENABLING)
> > > > +               (*streams)++;
> > > > +}
> > > > +
> > > > +static void stream_enable(void *data, void *user_data) {
> > > > +       struct bt_bap_stream *stream =3D data;
> > > > +
> > > > +       bt_bap_stream_enable(stream, true, NULL, NULL, NULL); }
> > > > +
> > > > +static void stream_start(void *data, void *user_data) {
> > > > +       struct bt_bap_stream *stream =3D data;
> > > > +
> > > > +       bt_bap_stream_start(stream, NULL, NULL); }
> > > > +
> > > >  static void bsrc_state_str(struct bt_bap_stream *stream, uint8_t
> > old_state,
> > > >                                 uint8_t new_state, void *user_data)=
  {
> > > >         struct test_data *data =3D user_data;
> > > > +       uint8_t streams =3D 0;
> > > >
> > > >         switch (new_state) {
> > > >         case BT_BAP_STREAM_STATE_CONFIG:
> > > > -               bt_bap_stream_enable(stream, true, NULL, NULL, NULL=
);
> > > > +               queue_foreach(data->streams, stream_count_config,
> > > > + &streams);
> > > > +
> > > > +               if (streams =3D=3D data->cfg->streams)
> > > > +                       /* After all streams have transitioned to C=
ONFIG
> > > > +                        * state, enable each one.
> > > > +                        */
> > > > +                       queue_foreach(data->streams, stream_enable,
> > > > + NULL);
> > > >                 break;
> > > >         case BT_BAP_STREAM_STATE_ENABLING:
> > > > -               data->base =3D bt_bap_stream_get_base(stream);
> > > > +               queue_foreach(data->streams, stream_count_enabling,
> > > &streams);
> > > >
> > > > -               g_assert(data->base);
> > > > -               g_assert(data->base->iov_len =3D=3D data->cfg->base=
.iov_len);
> > > > -               g_assert(memcmp(data->base->iov_base, data->cfg-
> > > >base.iov_base,
> > > > -                               data->base->iov_len) =3D=3D 0);
> > > > +               if (streams =3D=3D 1) {
> > > > +                       /* After the first stream has transitioned =
to ENABLING
> > > > +                        * state, bt_bap_stream_get_base will gener=
ate the
> > > > +                        * BASE from all previously configured stre=
ams.
> > > > +                        */
> > > > +                       data->base =3D bt_bap_stream_get_base(strea=
m);
> > > > +
> > > > +                       g_assert(data->base);
> > > > +                       g_assert(data->base->iov_len =3D=3D
> > > > +                                       data->cfg->base.iov_len);
> > > > +                       g_assert(memcmp(data->base->iov_base,
> > > > +                                       data->cfg->base.iov_base,
> > > > +                                       data->base->iov_len) =3D=3D=
 0);
> > > > +               }
> > > >
> > > > -               bt_bap_stream_start(stream, NULL, NULL);
> > > > +               if (streams =3D=3D data->cfg->streams)
> > > > +                       /* After all streams have transitioned to E=
NABLING
> > > > +                        * state, start each one.
> > > > +                        */
> > > > +                       queue_foreach(data->streams, stream_start,
> > > > + NULL);
> > > >                 break;
> > > >         case BT_BAP_STREAM_STATE_STREAMING:
> > > > -               tester_test_passed();
> > > > +               queue_foreach(data->streams, stream_count_streaming=
,
> > > &streams);
> > > > +
> > > > +               if (streams =3D=3D data->cfg->streams)
> > > > +                       /* Test is completed after all streams have=
 transitioned
> > > > +                        * to STREAMING state.
> > > > +                        */
> > > > +                       tester_test_passed();
> > > >                 break;
> > > >         }
> > > >  }
> > > > @@ -7225,9 +7284,288 @@ static void test_bsrc_str_1b(void)
> > > >                 NULL, test_bcast, &cfg_bsrc_str_vs, IOV_NULL);  }
> > > >
> > > > +#define BASE_LC3_8_1_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_8_1, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > >
> > > I wonder if we couldn't define these as part of lc3.h, in fact the
> > > LC3_CFG looks awful similar to LC3_CONFIG from lc3.h, so perhaps we
> > > could do just s/LC3_CFG/LC3_CONFIG and add something like LC3_BASE
> > for
> > > example then rename the existing LC3_BASE to LC3_TYPE(_id), anyway I
> > > can probably do that myself later after merging this just wanted to
> > > check first if you thought about that already.
> >
> > I added LC3_CFG because LC3_CONFIG from lc3.h defines a iovec struct,
> > while I needed some byte array to include in BASE_LC3. But I do think i=
t
> > would be useful to add the BASE defines to lc3.h, and they could be use=
d
> > for iso-tester as well.
> >
>
> Should I update this patch to move the BASE defines in lc3.h? Or should
> it be done in a separate patch?

Yes, please move the BASE defines to lc3.h.

> > >
> > > > +static struct test_config cfg_bsrc_str_8_1_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_8_1,
> > > > +       .qos =3D LC3_QOS_8_1_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_8_1_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_8_2_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_8_2, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_8_2_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_8_2,
> > > > +       .qos =3D LC3_QOS_8_2_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_8_2_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_16_1_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_16_1, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_16_1_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_16_1,
> > > > +       .qos =3D LC3_QOS_16_1_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_16_1_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_16_2_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_16_2, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_16_2_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_16_2,
> > > > +       .qos =3D LC3_QOS_16_2_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_16_2_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_24_1_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_24_1, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_24_1_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_24_1,
> > > > +       .qos =3D LC3_QOS_24_1_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_24_1_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_24_2_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_24_2, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_24_2_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_24_2,
> > > > +       .qos =3D LC3_QOS_24_2_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_24_2_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_32_1_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_32_1, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_32_1_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_32_1,
> > > > +       .qos =3D LC3_QOS_32_1_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_32_1_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_32_2_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_32_2, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_32_2_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_32_2,
> > > > +       .qos =3D LC3_QOS_32_2_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_32_2_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_44_1_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_44_1, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_44_1_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_44_1,
> > > > +       .qos =3D LC3_QOS_44_1_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_44_1_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_44_2_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_44_2, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_44_2_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_44_2,
> > > > +       .qos =3D LC3_QOS_44_2_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_44_2_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_48_1_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_1, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_48_1_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_48_1,
> > > > +       .qos =3D LC3_QOS_48_1_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_48_1_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_48_2_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_2, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_48_2_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_48_2,
> > > > +       .qos =3D LC3_QOS_48_2_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_48_2_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_48_3_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_3, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_48_3_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_48_3,
> > > > +       .qos =3D LC3_QOS_48_3_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_48_3_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_48_4_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_4, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_48_4_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_48_4,
> > > > +       .qos =3D LC3_QOS_48_4_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_48_4_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_48_5_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_5, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_48_5_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_48_5,
> > > > +       .qos =3D LC3_QOS_48_5_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_48_5_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_LC3_48_6_MBIS \
> > > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_6, 0x00, 0x01, 0x00, 0x02,
> > > > +0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_48_6_mbis =3D {
> > > > +       .cc =3D LC3_CONFIG_48_6,
> > > > +       .qos =3D LC3_QOS_48_6_1_B,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_LC3_48_6_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +#define BASE_VS_MBIS \
> > > > +       BASE(40000, 1, 2, 0xFF, 0x00, 0x00, 0x00, 0x00, \
> > > > +       VS_CFG, 0x00, 0x01, 0x00, 0x02, 0x00)
> > > > +
> > > > +static struct test_config cfg_bsrc_str_vs_mbis =3D {
> > > > +       .cc =3D UTIL_IOV_INIT(VS_CC),
> > > > +       .qos =3D QOS_BCAST,
> > > > +       .base =3D UTIL_IOV_INIT(BASE_VS_MBIS),
> > > > +       .src =3D true,
> > > > +       .state_func =3D bsrc_state_str,
> > > > +       .vs =3D true,
> > > > +       .streams =3D 2,
> > > > +};
> > > > +
> > > > +/* Test Purpose:
> > > > + * Verify that a Broadcast Source IUT can stream multiple BISes to
> > > > + * a Broadcast Sink. The verification is performed for each set of
> > > > + * parameters in turn, as specified in Table 4.82.
> > > > + *
> > > > + * Pass verdict:
> > > > + * If the Codec ID is LC3, the IUT sends encoded LC3 audio data in
> > > > + * BIS Data PDUs on each synchronized BIS.
> > > > + *
> > > > + * If the Codec ID is a vendor-specific Codec ID, the IUT sends BI=
S
> > > > + * Data PDUs on each synchronized BIS. The parameters included in
> > > > +the
> > > > + * Codec_Specific_Configuration data are as defined in
> > > > + * TSPX_VS_Codec_Specific_Configuration.
> > > > + *
> > > > + * If the Codec ID is LC3, each parameter included in
> > > > + * Codec_Specific_Configuration data is formatted in an LTV
> > > > +structure
> > > > + * with the length, type, and value specified in Table 4.83.
> > > > + */
> > > > +static void test_bsrc_str_2b(void)
> > > > +{
> > > > +       define_test("BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC=
3
> > 8_1]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_8_1_mbis, IOV_NULL)=
;
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC=
3
> > 8_2]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_8_2_mbis, IOV_NULL)=
;
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC=
3
> > > 16_1]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_16_1_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC=
3
> > > 16_2]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_16_2_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC=
3
> > > 24_1]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_24_1_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC=
3
> > > 24_2]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_24_2_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC=
3
> > > 32_1]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_32_1_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC=
3
> > > 32_2]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_32_2_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC=
3
> > > 44.1_1]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_44_1_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC=
3
> > > 44.1_2]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_44_2_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC=
3
> > > 48_1]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_48_1_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC=
3
> > > 48_2]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_48_2_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC=
3
> > > 48_3]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_48_3_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC=
3
> > > 48_4]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_48_4_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC=
3
> > > 48_5]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_48_5_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC=
3
> > > 48_6]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_48_6_mbis,
> > > > + IOV_NULL);
> > > > +
> > > > +       define_test("BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS=
]",
> > > > +               NULL, test_bcast, &cfg_bsrc_str_vs_mbis, IOV_NULL);
> > > > +}
> > > > +
> > > >  static void test_bsrc_str(void)
> > > >  {
> > > >         test_bsrc_str_1b();
> > > > +       test_bsrc_str_2b();
> > > >  }
> > > >
> > > >  int main(int argc, char *argv[])
> > > > --
> > > > 2.39.2
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> > Regards,
> > Iulia
>
> Regards,
> Iulia



--=20
Luiz Augusto von Dentz
