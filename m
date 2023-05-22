Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5085C77B75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 May 2023 18:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjEVS2l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 May 2023 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjEVS2k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 May 2023 14:28:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977C012B
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 11:28:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3b5881734so3249832e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 May 2023 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684780116; x=1687372116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3BUnIse4XpIguUjz9qDWD9DlcWFkt2RaMopnw4xGdA=;
        b=smK+7lnTrURKLQW/yETMbsLStOanLDicDopSRp5iHhZ6dSfAMYFgGiLUN06qIziaEQ
         lTSQVd0v3bBfTiMj29LZJrlwnnSjWdUv33HzDU/qbC7i0GedW/O5a5pL58D/Vk/U+EZL
         bG33+olWyn3m7uLh2qZVnxm1QElnsMFMN4uqdBZ+ZswhL2S4N+ULGmCqQXHZkiF7c46J
         ieDaW16nLVdTG2ubJqHuySHmPWH9hHhFrCC4XR33gB8mhSkx4iyQ9coEA+5ZmWdser6+
         sw40z9ENPdJ+1G6tPNGhSGUFD5zq0yNpOzN88ZV2N+FBoSodz7u9ND884DvqlqgzY+Z5
         /Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780116; x=1687372116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3BUnIse4XpIguUjz9qDWD9DlcWFkt2RaMopnw4xGdA=;
        b=avxZxaBpI+Tv0g6AckwJBIwkq6hG90++x006TVWb2qNNDH+sKGi56b2sL1kBHPzn5V
         3r8oGEJdGi4HdddgloDxrIWvyeSltuaAL4jgzULdpWlE4EnC+W4I4ivHBxclq5M9poR/
         LtWwRRU77E5nslXiAmbYa0/ZNsEmH8cBfRFHKgMTcVAg5OTQzMbxJ7qJ9t8f73aUALcT
         PftkUpM68F3VykBQC0DI6ILM88dd093fsA8EzeXCxDrAEOrrMOjdLse8+2g+5xUtEPbg
         AqihiVfJvsw0menjABejC2rElrAjHFw0XBQ2twOIuDEZ6eFnsP3NmVpMQMJGwZdlIC/W
         t2Ww==
X-Gm-Message-State: AC+VfDwNVyMUCdmJG+cr4mlsPtsv7jM9Bb52kZ3URBXFunCjPpq514wX
        diQvcR8V4S7GMPKs8pSKKJjgtyYBG+5/of7bSsyo1Edm
X-Google-Smtp-Source: ACHHUZ43DzjyNh+8lhLdMCfk6gSG5cqg5ZF73uPnjyWFCxckcZ27ElQe3p3mDdxXKFKpLjd4jgl7VULkJ3BJEDpr+oU=
X-Received: by 2002:a2e:98d4:0:b0:2af:1c91:d712 with SMTP id
 s20-20020a2e98d4000000b002af1c91d712mr4353225ljj.39.1684780115357; Mon, 22
 May 2023 11:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
 <aa64f9c867330b2e691ee65ac30104b8757d7a4b.1684682575.git.pav@iki.fi>
In-Reply-To: <aa64f9c867330b2e691ee65ac30104b8757d7a4b.1684682575.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 May 2023 11:28:23 -0700
Message-ID: <CABBYNZJDw5fNq9fQ7b29WBpEdAypsG_fazp5M_-7430r7YVpSA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] iso-tester: add tests for multiple simultaneous CIG
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, May 21, 2023 at 8:32=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add tests connecting two CIS using different CIG_ID, with fixed and
> auto-allocated IDs.
>
> ISO Connect2 CIG 0x01/0x02 Seq - Success
> ISO Connect2 CIG auto/auto Seq - Success
>
> The CIS are connected sequentially so that the first is closed after the
> second is connected. In the auto/auto case the kernel shall pick a new
> CIG_ID since the first CIG_ID is no longer in a configurable state.

Is this somewhat similar to AC 7(i) but using different CIGs? I
suspect this is not covered on BAP, although it is a valid audio
configuration, perhaps we could use AC 7(i)-alt or something.

> ---
>
> Notes:
>     The second tests hits a bug in kernel CIG auto-allocation, which alwa=
ys
>     picks CIG_ID 0 even if it is not in a configurable state.
>
>     ISO Connect2 CIG auto/auto Seq - Success - setup complete
>     ISO Connect2 CIG auto/auto Seq - Success - run
>       Connecting to 00:AA:01:01:00:00...
>       Connect 0 in progress
>       Connecting to 00:AA:01:02:00:01...
>       Connect 1 in progress
>       Successfully connected
>       Step 1
>       Connect failed: Device or resource busy (16)
>       Expect error: Success (0) !=3D Device or resource busy (16)
>
>  tools/iso-tester.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index 164cb465f..fc2a84215 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -64,6 +64,11 @@
>                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
>                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
>
> +#define QOS_2(_interval, _latency, _sdu, _phy, _rtn) \
> +       QOS_FULL(0x02, BT_ISO_QOS_CIS_UNSET, \
> +               QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> +               QOS_IO(_interval, _latency, _sdu, _phy, _rtn))
> +
>  #define QOS_1_1(_interval, _latency, _sdu, _phy, _rtn) \
>         QOS_FULL(0x01, 0x01, \
>                 QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
> @@ -109,6 +114,7 @@
>  #define QOS_16_1_1 QOS(7500, 8, 30, 0x02, 2)
>  #define QOS_16_2_1 QOS(10000, 10, 40, 0x02, 2)
>  #define QOS_1_16_2_1 QOS_1(10000, 10, 40, 0x02, 2)
> +#define QOS_2_16_2_1 QOS_2(10000, 10, 40, 0x02, 2)
>  #define QOS_1_1_16_2_1 QOS_1_1(10000, 10, 40, 0x02, 2)
>  #define QOS_24_1_1 QOS(7500, 8, 45, 0x02, 2)
>  #define QOS_24_2_1 QOS(10000, 10, 60, 0x02, 2)
> @@ -546,6 +552,20 @@ static const struct iso_client_data connect_1_16_2_1=
 =3D {
>         .expect_err =3D 0
>  };
>
> +static const struct iso_client_data connect_2_16_2_1 =3D {
> +       .qos =3D QOS_1_16_2_1,
> +       .qos_2 =3D QOS_2_16_2_1,
> +       .expect_err =3D 0,
> +       .mcis =3D true,
> +};
> +
> +static const struct iso_client_data connect_2a_16_2_1 =3D {
> +       .qos =3D QOS_16_2_1,
> +       .qos_2 =3D QOS_16_2_1,
> +       .expect_err =3D 0,
> +       .mcis =3D true,
> +};
> +
>  static const struct iso_client_data connect_1_1_16_2_1 =3D {
>         .qos =3D QOS_1_1_16_2_1,
>         .expect_err =3D 0
> @@ -2126,6 +2146,25 @@ static void test_connect2(const void *test_data)
>         setup_connect_many(data, 2, num, funcs);
>  }
>
> +static gboolean iso_connect2_seq_cb(GIOChannel *io, GIOCondition cond,
> +                                                       gpointer user_dat=
a)
> +{
> +       struct test_data *data =3D tester_get_data();
> +
> +       data->io_id[0] =3D 0;
> +
> +       setup_connect(data, 1, iso_connect2_cb);
> +
> +       return iso_connect(io, cond, user_data);
> +}
> +
> +static void test_connect2_seq(const void *test_data)
> +{
> +       struct test_data *data =3D tester_get_data();
> +
> +       setup_connect(data, 0, iso_connect2_seq_cb);
> +}
> +
>  static void test_bcast(const void *test_data)
>  {
>         struct test_data *data =3D tester_get_data();
> @@ -2264,6 +2303,15 @@ int main(int argc, char *argv[])
>         test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
>                                                         test_connect);
>
> +       test_iso2("ISO Connect2 CIG 0x01/0x02 Seq - Success", &connect_2_=
16_2_1,
> +                                                       setup_powered,
> +                                                       test_connect2_seq=
);
> +
> +       test_iso2("ISO Connect2 CIG auto/auto Seq - Success",
> +                                                       &connect_2a_16_2_=
1,
> +                                                       setup_powered,
> +                                                       test_connect2_seq=
);
> +
>         test_iso_rej("ISO Connect - Reject", &connect_reject, setup_power=
ed,
>                         test_connect, BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH=
);
>
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
