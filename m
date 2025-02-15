Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21304144304
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739594747; cv=none; b=Bu2sqF0qj+/pDrkBxsFmMDCM3fJiGlalwaCdg/KJb5S33/LafcXRK6rxdeHMiNHF4kh84z53dEi8P4cnvv79SQSjFHL8hGFF6lVmdLg/qHDU6QjPvYBX5t0UXU00f5d8J/iud96OA7CmRVlRu/JqkX7T7RjIYOQEtkW99coQqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739594747; c=relaxed/simple;
	bh=oeuDEdhjCwhnl4O6TxNnUaeGy9veqFQmhZsnIcBNSyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BxmYEVRR44CyK1+O60H+sLLun/f5nD3D6itFBz+kT1OnFWGb5Od2bMGD5YoQS6EHKGcdekboDxbjK4KKniaHGH7nH61Zu6IKaOtPT0Od/maWOrid2gdsHOU0BTbufFQGeJCCdjbpIY49kmxcoma3fDRf5c790Qw9AeHRQeTFAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3LmHQI3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3LmHQI3"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f8c58229f1so23380547b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 20:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739594745; x=1740199545; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCNngLYtfyRNnXtSO/kF84i6jWrVfgHwZntyGPCERcg=;
        b=J3LmHQI3fldobaCVLki0abPhjku58UL8LvjyYdzE7a7rxN/XQ82dXqxyk6k0B6x1qN
         w6puKxuEH+ra0Uecn4mn5CpNBpygU5b1AcUB9IbJi9Yg/dneUp2kMeJ/w2MwV1lA9+Jg
         JfA847A4R6W3t8DiXnyO8xEh4zwVaJ+4KG79c3cn2Au8aDGOCVfPk6fFKH7vyJluR7f8
         YqkJv4++yibBiiaSBi88XPKr7hFGegVLubvWtTfxc0QP4MjP2mCsC/K6h+FxmLyM+xI6
         CltlQt58XhJ/JW47Nd3arEKOvTjhGWxqbKThF8KCMO9Ckx7D489FhmDUMcY7MW63emED
         /DrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739594745; x=1740199545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCNngLYtfyRNnXtSO/kF84i6jWrVfgHwZntyGPCERcg=;
        b=YqTvvs/7b6gXo0LrZPFvrXuozRywFad/fgaSbWjTAYl7xZYQ0DlhSFi+JxHqssjqic
         E0TrtPKmS7mL49hVhBF4bhVvufJ1Yt0FYRgaYEAMFgB+a68l4/FPD8CzslBgCAoIOsPg
         O0B7fzmT8YQnhdLw31fZZaJ8aDgr2aXTIiK/LbaQ8asaRa2ezTgJBrHIoyE6mHjjnVC+
         w9fHtIfYeKIUARwxd0gH9JfFyqxl4d+8fwwByvOoFo3Auu9Zi+flwzEL2XC3zFzpTpUI
         FQCulTbyqA3j+BYQ+MydzHdlo7j2V5lEotnUCDzSjkvSWjaWvEOASlbU4Qs+pIz6gUvF
         UvVg==
X-Gm-Message-State: AOJu0YyVWYeY4+F9mb80JgnSMR3U8D9cZCXvQY7OJz+6km9VA2F6wqQ9
	ZFmqoriovpuyXh42j97pUeZ/nUFu8cDS02OP6edWOHyx6OBjoij9K+RUpUqXoxSQrN7iSCvG77A
	fwtcIVBsgAZxr/h4m70Nyh4PGSHnGtA==
X-Gm-Gg: ASbGncvps6t/hMOj0dW9jNN8Av1qk4W4Gn8wM8dtb4d/qsqkjQUA5RDFPk4m+FPvmGT
	4HUqpxMplNsFshNutYe93941YFnXTCU95awRYeG6hklX06MP9u7DHgku9QwR1AobaTAaNE4b2z+
	td6MA8aO2O/ywpoy4SLJ9/YsML3lo=
X-Google-Smtp-Source: AGHT+IGEdOu9vFurqtpV18E3wZrc/B/Tezn1K2Rdh+WBXcI40/vh7fnipClgPzCDLn/uviQGQrEV2uW3HxkdeolQzBQ=
X-Received: by 2002:a05:690c:7087:b0:6e5:2adf:d584 with SMTP id
 00721157ae682-6fb58bb3863mr13626497b3.14.1739594744684; Fri, 14 Feb 2025
 20:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739026302.git.pav@iki.fi> <4449644d9883f313fc6ad883f56fe07420815bf1.1739026302.git.pav@iki.fi>
In-Reply-To: <4449644d9883f313fc6ad883f56fe07420815bf1.1739026302.git.pav@iki.fi>
From: Victor Yeo <victoryeo1974@gmail.com>
Date: Sat, 15 Feb 2025 12:45:33 +0800
X-Gm-Features: AWEUYZmZZs8nxn0JctCZXCdzEU1nyP2V5RgFgEYghAX7JtzpApUjPy8VPLvfFB8
Message-ID: <CADX0rsaiTVYnWFGJGVacs2j+mKJKp-4oZck5iqZfmVBrKFQWYg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] tools/tester: test COMPLETION timestamps
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

unsubscribe

On Sun, Feb 9, 2025 at 6:40=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add support for SOF_TIMESTAMPING_TX_COMPLETION also in cases where
> errqueue.h is old and doesn't define it.
>
> Support timestamps of different types arriving out of order, as multiple
> SND may well arrive before COMPLETION.  Also allow TX timestamp arriving
> before bthost receives data, as that may well happen.
>
> Remove tests SCHED timestamps, as those won't be generated for now.
>
> Don't test COMPLETION for SCO, since it's not supported now either.
> ---
>  configure.ac         |  7 +++++++
>  tools/iso-tester.c   | 36 +++++++++++-------------------------
>  tools/l2cap-tester.c | 14 ++++++++------
>  tools/sco-tester.c   |  8 ++++----
>  tools/tester.h       | 42 +++++++++++++++++++++++++++++++++++-------
>  5 files changed, 65 insertions(+), 42 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 6a19487f6..75841e4c9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -389,6 +389,13 @@ AC_ARG_ENABLE(testing, AS_HELP_STRING([--enable-test=
ing],
>                                         [enable_testing=3D${enableval}])
>  AM_CONDITIONAL(TESTING, test "${enable_testing}" =3D "yes")
>
> +if (test "${enable_testing}" =3D "yes"); then
> +   AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMPLETION=
],
> +       [], [], [[#include <time.h>
> +               #include <linux/errqueue.h>
> +               #include <linux/net_tstamp.h>]])
> +fi
> +
>  AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
>                         [enable experimental tools]),
>                                         [enable_experimental=3D${enableva=
l}])
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index c30c44ce9..b5e638808 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -1066,20 +1066,10 @@ static const struct iso_client_data connect_send_=
tx_timestamping =3D {
>         .send =3D &send_16_2_1,
>         .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
>                                         SOF_TIMESTAMPING_OPT_ID |
> -                                       SOF_TIMESTAMPING_TX_SOFTWARE),
> -       .repeat_send =3D 1,
> -       .repeat_send_pre_ts =3D 2,
> -};
> -
> -static const struct iso_client_data connect_send_tx_sched_timestamping =
=3D {
> -       .qos =3D QOS_16_2_1,
> -       .expect_err =3D 0,
> -       .send =3D &send_16_2_1,
> -       .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
>                                         SOF_TIMESTAMPING_TX_SOFTWARE |
> -                                       SOF_TIMESTAMPING_OPT_TSONLY |
> -                                       SOF_TIMESTAMPING_TX_SCHED),
> +                                       SOF_TIMESTAMPING_TX_COMPLETION),
>         .repeat_send =3D 1,
> +       .repeat_send_pre_ts =3D 2,
>  };
>
>  static const struct iso_client_data connect_send_tx_cmsg_timestamping =
=3D {
> @@ -1087,7 +1077,8 @@ static const struct iso_client_data connect_send_tx=
_cmsg_timestamping =3D {
>         .expect_err =3D 0,
>         .send =3D &send_16_2_1,
>         .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
> -                                       SOF_TIMESTAMPING_TX_SOFTWARE),
> +                                       SOF_TIMESTAMPING_OPT_TSONLY |
> +                                       SOF_TIMESTAMPING_TX_COMPLETION),
>         .repeat_send =3D 1,
>         .cmsg_timestamping =3D true,
>  };
> @@ -1097,7 +1088,7 @@ static const struct iso_client_data connect_send_tx=
_no_poll_timestamping =3D {
>         .expect_err =3D 0,
>         .send =3D &send_16_2_1,
>         .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
> -                                       SOF_TIMESTAMPING_TX_SOFTWARE),
> +                                       SOF_TIMESTAMPING_TX_COMPLETION),
>         .repeat_send =3D 1,
>         .no_poll_errqueue =3D true,
>  };
> @@ -2241,10 +2232,10 @@ static gboolean iso_recv_errqueue(GIOChannel *io,=
 GIOCondition cond,
>         err =3D tx_tstamp_recv(&data->tx_ts, sk, isodata->send->iov_len);
>         if (err > 0)
>                 return TRUE;
> -       else if (!err && !data->step)
> -               tester_test_passed();
> -       else
> +       else if (err)
>                 tester_test_failed();
> +       else if (!data->step)
> +               tester_test_passed();
>
>         data->io_id[2] =3D 0;
>         return FALSE;
> @@ -2289,7 +2280,7 @@ static void iso_tx_timestamping(struct test_data *d=
ata, GIOChannel *io)
>         int err;
>         unsigned int count;
>
> -       if (!(isodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK)=
)
> +       if (!(isodata->so_timestamping & TS_TX_RECORD_MASK))
>                 return;
>
>         tester_print("Enabling TX timestamping");
> @@ -2336,7 +2327,7 @@ static void iso_tx_timestamping(struct test_data *d=
ata, GIOChannel *io)
>         }
>
>         if (isodata->cmsg_timestamping)
> -               so &=3D ~SOF_TIMESTAMPING_TX_RECORD_MASK;
> +               so &=3D ~TS_TX_RECORD_MASK;
>
>         err =3D setsockopt(sk, SOL_SOCKET, SO_TIMESTAMPING, &so, sizeof(s=
o));
>         if (err < 0) {
> @@ -2374,7 +2365,7 @@ static void iso_send_data(struct test_data *data, G=
IOChannel *io)
>                 cmsg->cmsg_len =3D CMSG_LEN(sizeof(uint32_t));
>
>                 *((uint32_t *)CMSG_DATA(cmsg)) =3D (isodata->so_timestamp=
ing &
> -                                       SOF_TIMESTAMPING_TX_RECORD_MASK);
> +                                       TS_TX_RECORD_MASK);
>         }
>
>         ret =3D sendmsg(sk, &msg, 0);
> @@ -3645,11 +3636,6 @@ int main(int argc, char *argv[])
>         test_iso("ISO Send - TX Timestamping", &connect_send_tx_timestamp=
ing,
>                                                 setup_powered, test_conne=
ct);
>
> -       /* Test schedule-time TX timestamps are emitted */
> -       test_iso("ISO Send - TX Sched Timestamping",
> -                       &connect_send_tx_sched_timestamping, setup_powere=
d,
> -                       test_connect);
> -
>         /* Test TX timestamping with flags set via per-packet CMSG */
>         test_iso("ISO Send - TX CMSG Timestamping",
>                         &connect_send_tx_cmsg_timestamping, setup_powered=
,
> diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
> index 1780c9fbd..7f3be6c0f 100644
> --- a/tools/l2cap-tester.c
> +++ b/tools/l2cap-tester.c
> @@ -381,7 +381,8 @@ static const struct l2cap_data client_connect_tx_time=
stamping_test =3D {
>         .data_len =3D sizeof(l2_data),
>         .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
>                                         SOF_TIMESTAMPING_OPT_ID |
> -                                       SOF_TIMESTAMPING_TX_SOFTWARE),
> +                                       SOF_TIMESTAMPING_TX_SOFTWARE |
> +                                       SOF_TIMESTAMPING_TX_COMPLETION),
>         .repeat_send =3D 2,
>  };
>
> @@ -594,7 +595,8 @@ static const struct l2cap_data le_client_connect_tx_t=
imestamping_test =3D {
>         .data_len =3D sizeof(l2_data),
>         .so_timestamping =3D (SOF_TIMESTAMPING_SOFTWARE |
>                                         SOF_TIMESTAMPING_OPT_ID |
> -                                       SOF_TIMESTAMPING_TX_SOFTWARE),
> +                                       SOF_TIMESTAMPING_TX_SOFTWARE |
> +                                       SOF_TIMESTAMPING_TX_COMPLETION),
>  };
>
>  static const struct l2cap_data le_client_connect_adv_success_test_1 =3D =
{
> @@ -1345,10 +1347,10 @@ static gboolean recv_errqueue(GIOChannel *io, GIO=
Condition cond,
>         err =3D tx_tstamp_recv(&data->tx_ts, sk, l2data->data_len);
>         if (err > 0)
>                 return TRUE;
> -       else if (!err && !data->step)
> -               tester_test_passed();
> -       else
> +       else if (err)
>                 tester_test_failed();
> +       else if (!data->step)
> +               tester_test_passed();
>
>         data->err_io_id =3D 0;
>         return FALSE;
> @@ -1362,7 +1364,7 @@ static void l2cap_tx_timestamping(struct test_data =
*data, GIOChannel *io)
>         int err;
>         unsigned int count;
>
> -       if (!(l2data->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK))
> +       if (!(l2data->so_timestamping & TS_TX_RECORD_MASK))
>                 return;
>
>         sk =3D g_io_channel_unix_get_fd(io);
> diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> index 6fc26b7af..130ab526d 100644
> --- a/tools/sco-tester.c
> +++ b/tools/sco-tester.c
> @@ -665,10 +665,10 @@ static gboolean recv_errqueue(GIOChannel *io, GIOCo=
ndition cond,
>         err =3D tx_tstamp_recv(&data->tx_ts, sk, scodata->data_len);
>         if (err > 0)
>                 return TRUE;
> -       else if (!err && !data->step)
> -               tester_test_passed();
> -       else
> +       else if (err)
>                 tester_test_failed();
> +       else if (!data->step)
> +               tester_test_passed();
>
>         data->err_io_id =3D 0;
>         return FALSE;
> @@ -682,7 +682,7 @@ static void sco_tx_timestamping(struct test_data *dat=
a, GIOChannel *io)
>         int err;
>         unsigned int count;
>
> -       if (!(scodata->so_timestamping & SOF_TIMESTAMPING_TX_RECORD_MASK)=
)
> +       if (!(scodata->so_timestamping & TS_TX_RECORD_MASK))
>                 return;
>
>         sk =3D g_io_channel_unix_get_fd(io);
> diff --git a/tools/tester.h b/tools/tester.h
> index b6de084a4..82770014f 100644
> --- a/tools/tester.h
> +++ b/tools/tester.h
> @@ -20,6 +20,15 @@
>  #define SEC_NSEC(_t)  ((_t) * 1000000000LL)
>  #define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
>
> +#if !HAVE_DECL_SOF_TIMESTAMPING_TX_COMPLETION
> +#define SOF_TIMESTAMPING_TX_COMPLETION (SOF_TIMESTAMPING_LAST << 1)
> +#endif
> +#if !HAVE_DECL_SCM_TSTAMP_COMPLETION
> +#define SCM_TSTAMP_COMPLETION          (SCM_TSTAMP_ACK + 1)
> +#endif
> +#define TS_TX_RECORD_MASK              (SOF_TIMESTAMPING_TX_RECORD_MASK =
| \
> +                                               SOF_TIMESTAMPING_TX_COMPL=
ETION)
> +
>  struct tx_tstamp_data {
>         struct {
>                 uint32_t id;
> @@ -59,6 +68,13 @@ static inline int tx_tstamp_expect(struct tx_tstamp_da=
ta *data)
>                 pos++;
>         }
>
> +       if (data->so_timestamping & SOF_TIMESTAMPING_TX_COMPLETION) {
> +               g_assert(pos < ARRAY_SIZE(data->expect));
> +               data->expect[pos].type =3D SCM_TSTAMP_COMPLETION;
> +               data->expect[pos].id =3D data->sent;
> +               pos++;
> +       }
> +
>         data->sent++;
>
>         steps =3D pos - data->count;
> @@ -77,6 +93,7 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data =
*data, int sk, int len)
>         struct scm_timestamping *tss =3D NULL;
>         struct sock_extended_err *serr =3D NULL;
>         struct timespec now;
> +       unsigned int i;
>
>         iov.iov_base =3D buf;
>         iov.iov_len =3D sizeof(buf);
> @@ -89,7 +106,7 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data=
 *data, int sk, int len)
>
>         ret =3D recvmsg(sk, &msg, MSG_ERRQUEUE);
>         if (ret < 0) {
> -               if (ret =3D=3D EAGAIN || ret =3D=3D EWOULDBLOCK)
> +               if (errno =3D=3D EAGAIN || errno =3D=3D EWOULDBLOCK)
>                         return data->count - data->pos;
>
>                 tester_warn("Failed to read from errqueue: %s (%d)",
> @@ -147,18 +164,29 @@ static inline int tx_tstamp_recv(struct tx_tstamp_d=
ata *data, int sk, int len)
>                 return -EINVAL;
>         }
>
> -       if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
> -                               serr->ee_data !=3D data->expect[data->pos=
].id) {
> -               tester_warn("Bad timestamp id %u", serr->ee_data);
> +       /* Find first unreceived timestamp of the right type */
> +       for (i =3D 0; i < data->count; ++i) {
> +               if (data->expect[i].type >=3D 0xffff)
> +                       continue;
> +
> +               if (serr->ee_info =3D=3D data->expect[i].type) {
> +                       data->expect[i].type =3D 0xffff;
> +                       break;
> +               }
> +       }
> +       if (i =3D=3D data->count) {
> +               tester_warn("Bad timestamp type %u", serr->ee_info);
>                 return -EINVAL;
>         }
>
> -       if (serr->ee_info !=3D data->expect[data->pos].type) {
> -               tester_warn("Bad timestamp type %u", serr->ee_info);
> +       if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
> +                               serr->ee_data !=3D data->expect[i].id) {
> +               tester_warn("Bad timestamp id %u", serr->ee_data);
>                 return -EINVAL;
>         }
>
> -       tester_print("Got valid TX timestamp %u", data->pos);
> +       tester_print("Got valid TX timestamp %u (type %u, id %u)", i,
> +                                               serr->ee_info, serr->ee_d=
ata);
>
>         ++data->pos;
>
> --
> 2.48.1
>
>
