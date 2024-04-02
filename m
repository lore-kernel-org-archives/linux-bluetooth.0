Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD781E480
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073214; cv=none; b=XJv2kDJGU6aPc6q7Jwy5+jOYjWolTNJN1bfMHKHfcQg38M0/yvNaVG7t8bXxP2KV/lDkrkI5pH/iJPzMzKmwg7dGFXNvT3kucU6px/LE6gTLtDcRKYLECaRf+pajwQ9waa1dTcQfvl10dT4Ou/WANTAb92eScA0SWncDPfMaZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073214; c=relaxed/simple;
	bh=+HNPQ6Z7n9wLxk648WN1twuqrR6ZaDsrS2Ef5bzoAQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlkVWBU/kmt6X9v4XXhlsi5rYgiyMJxXoJGHZRN+4rrihCY+JLEUS2tYkxtmSKZGLjh6oMsQQi66GU3Qd8zIVdAKCIpLXzdQnIbWKF1R+xngt6OEWIbwwVtoKX4R4PvgpBufMbP3B1HlEec/ki6lGPU2teyRQYZOtoLUvivXsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blRuv0M8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blRuv0M8"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso69683751fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712073210; x=1712678010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXNk4Q4mvytvhm8U2GXCz4dv3YODuoCIYa2DVPXxvgU=;
        b=blRuv0M8MGDqcOPLErK9arPXlYmWBC8EGup3fYDugGLN2wL8cnw8pyhVecHeB/owkC
         SHiDxIDMBDhaNKwgLYmYsZGuRi2RlSV9CRm7s5azmqwxUTLAjl/l6yfgF0oxdQHgTHAZ
         RXeg5xmse+63tmN7M//fhhmb2tkqCoqf9HFulp+HU50i1qq4eWjwAUQ2qk4lNwL9j6zJ
         dIx+o3x1vGaWUMDdDcuRaGmTqtOFTbWtWlsHI42oq19EFtrzhyE/sde2puVcuywG+hz8
         wAWEbKlCJOjU35H8aFllTxctrWGJV+ZcPQzwIMI7sbN/5L2OkksFy1QT1ZfWYjmzWVm9
         Qnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712073210; x=1712678010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXNk4Q4mvytvhm8U2GXCz4dv3YODuoCIYa2DVPXxvgU=;
        b=S100rc6zIWw2PPKXM5nGtPTKkTnr8ssbln/lx1ddeJi9/mbRREJayZWluFN93cyd5F
         E9cULR7zY4HmC3GS53f1jx58WLana/rTujs/42Y6OvF412BvAeXlY+RJ3Rqm+Kt6C4ec
         jK4cm1VwA0JcaE++Lbiuuy30vWr2cy2kvnzzJbajC2UdIPEetcNFWlAmDgGnfArzLwQk
         3eRgs3srtsdquPtNUXTtedb0lVFVau7oHMDU3OK3KPdDQewcIsIopYfPFowzaFBFR1u0
         I9agGkmXMhROj/p+bTZjyRHx2Gl7/zBR6rEK5Q5Ab/gMWfD14xsorCUPmJFDrpmlBq3+
         f9CA==
X-Gm-Message-State: AOJu0YxSXMuone5qlNTHrMG+PX/YR3Dy3p7EIvEp656e4NaNa5TbnlFo
	zr47vDEa3OhE/si3YJeeyyR0KRPvDdFNtEN97mTPFUYrG9A5fvx0s6lL4Mp97ji2/dWVcGq3GN2
	6n0wPOKcq2lvufDCY57QrURa14uP7xDRY
X-Google-Smtp-Source: AGHT+IEw9xgZc08gFBB9lDRh4T9GyzWqpgc1whYzvRRNyuZG4pRVubwohJXo4K4/uQIjjYEPceHosgim+Kkq+ZGOBMM=
X-Received: by 2002:a2e:a704:0:b0:2d8:c64:ffe5 with SMTP id
 s4-20020a2ea704000000b002d80c64ffe5mr4729039lje.29.1712073210325; Tue, 02 Apr
 2024 08:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402114326.3330-1-iulia.tanasescu@nxp.com> <20240402114326.3330-4-iulia.tanasescu@nxp.com>
In-Reply-To: <20240402114326.3330-4-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Apr 2024 11:53:17 -0400
Message-ID: <CABBYNZLsV_1+GZ139bOpk7jPFFMx-bFedj-zOk2Ns5QmiGgBAQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] iso-tester: Add test for Broadcast Receiver Get BASE
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Tue, Apr 2, 2024 at 7:43=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> This adds a new Broadcast Receiver test, to validate that a Broadcast
> Sink is able to sync to the PA transmitted by a Source (when no BIG
> is active) and is able to successfully detect the BASE:
>
> ISO Broadcaster Receiver Defer Get BASE - Success
> ---
>  tools/iso-tester.c | 70 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index 60afef301..67d698291 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -23,6 +23,7 @@
>  #include "lib/bluetooth.h"
>  #include "lib/iso.h"
>  #include "lib/mgmt.h"
> +#include "lib/uuid.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/vhci.h"
> @@ -34,6 +35,8 @@
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
>
> +#define EIR_SERVICE_DATA_16    0x16
> +
>  #define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
>  { \
>         .interval =3D _interval, \
> @@ -487,6 +490,7 @@ struct iso_client_data {
>         size_t base_len;
>         bool listen_bind;
>         bool pa_bind;
> +       bool big;
>  };
>
>  typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *i=
o);
> @@ -1301,6 +1305,7 @@ static const struct iso_client_data bcast_16_2_1_re=
cv =3D {
>         .recv =3D &send_16_2_1,
>         .bcast =3D true,
>         .server =3D true,
> +       .big =3D true,
>  };
>
>  static const struct iso_client_data bcast_enc_16_2_1_recv =3D {
> @@ -1309,6 +1314,7 @@ static const struct iso_client_data bcast_enc_16_2_=
1_recv =3D {
>         .recv =3D &send_16_2_1,
>         .bcast =3D true,
>         .server =3D true,
> +       .big =3D true,
>  };
>
>  static const struct iso_client_data bcast_16_2_1_recv_defer =3D {
> @@ -1319,6 +1325,7 @@ static const struct iso_client_data bcast_16_2_1_re=
cv_defer =3D {
>         .bcast =3D true,
>         .server =3D true,
>         .listen_bind =3D true,
> +       .big =3D true,
>  };
>
>  static const struct iso_client_data bcast_16_2_1_recv_defer_no_bis =3D {
> @@ -1327,6 +1334,7 @@ static const struct iso_client_data bcast_16_2_1_re=
cv_defer_no_bis =3D {
>         .defer =3D true,
>         .bcast =3D true,
>         .server =3D true,
> +       .big =3D true,
>  };
>
>  static const struct iso_client_data bcast_16_2_1_recv_defer_pa_bind =3D =
{
> @@ -1336,6 +1344,17 @@ static const struct iso_client_data bcast_16_2_1_r=
ecv_defer_pa_bind =3D {
>         .bcast =3D true,
>         .server =3D true,
>         .pa_bind =3D true,
> +       .big =3D true,
> +};
> +
> +static const struct iso_client_data bcast_16_2_1_recv_defer_get_base =3D=
 {
> +       .qos =3D QOS_IN_16_2_1,
> +       .expect_err =3D 0,
> +       .defer =3D true,
> +       .bcast =3D true,
> +       .server =3D true,
> +       .base =3D base_lc3_ac_12,
> +       .base_len =3D sizeof(base_lc3_ac_12),
>  };
>
>  static const struct iso_client_data bcast_ac_12 =3D {
> @@ -1498,9 +1517,28 @@ static void setup_powered_callback(uint8_t status,=
 uint16_t length,
>                 if (isodata->bcast) {
>                         bthost_set_pa_params(host);
>                         bthost_set_pa_enable(host, 0x01);
> -                       bthost_create_big(host, 1,
> -                                       isodata->qos.bcast.encryption,
> -                                       isodata->qos.bcast.bcode);
> +
> +                       if (isodata->base) {
> +                               uint8_t eir[HCI_MAX_PER_AD_LENGTH] =3D {0=
};
> +                               uint16_t eir_len =3D 0;
> +
> +                               eir[eir_len++] =3D EIR_SERVICE_DATA_LENGT=
H - 1 +
> +                                                       isodata->base_len=
;
> +                               eir[eir_len++] =3D EIR_SERVICE_DATA_16;
> +                               put_le16(BAA_SERVICE, &eir[eir_len]);
> +                               eir_len +=3D 2;
> +                               memcpy(&eir[eir_len], isodata->base,
> +                                                       isodata->base_len=
);
> +                               eir_len +=3D isodata->base_len;

I'd use util_iov helpers to generate this instead of manually
generating it like above.

> +
> +                               bthost_set_pa_data(host, eir, eir_len);
> +                       }
> +
> +                       if (isodata->big)
> +                               bthost_create_big(host, 1,
> +                                               isodata->qos.bcast.encryp=
tion,
> +                                               isodata->qos.bcast.bcode)=
;
> +
>                 } else if (!isodata->send && isodata->recv) {
>                         const uint8_t *bdaddr;
>
> @@ -2183,6 +2221,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCond=
ition cond,
>         socklen_t len;
>         struct bt_iso_qos qos;
>         bool ret =3D true;
> +       uint8_t base[BASE_MAX_LENGTH] =3D {0};
>
>         sk =3D g_io_channel_unix_get_fd(io);
>
> @@ -2211,6 +2250,27 @@ static gboolean iso_connect(GIOChannel *io, GIOCon=
dition cond,
>                 return FALSE;
>         }
>
> +       if (isodata->bcast && isodata->server && isodata->base) {
> +               len =3D BASE_MAX_LENGTH;
> +
> +               if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_BASE,
> +                               base, &len) < 0) {
> +                       tester_warn("Can't get socket option : %s (%d)",
> +                                               strerror(errno), errno);
> +                       data->step =3D 0;
> +                       tester_test_failed();
> +                       return FALSE;
> +               }
> +
> +               if (len !=3D isodata->base_len ||
> +                               memcmp(base, isodata->base, len)) {
> +                       tester_warn("Unexpected BASE");
> +                       data->step =3D 0;
> +                       tester_test_failed();
> +                       return FALSE;
> +               }
> +       }
> +
>         len =3D sizeof(sk_err);
>
>         if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
> @@ -3383,6 +3443,10 @@ int main(int argc, char *argv[])
>                                         &bcast_16_2_1_recv_defer_pa_bind,
>                                         setup_powered,
>                                         test_bcast_recv_defer);
> +       test_iso("ISO Broadcaster Receiver Defer Get BASE - Success",
> +                                       &bcast_16_2_1_recv_defer_get_base=
,
> +                                       setup_powered,
> +                                       test_bcast_recv);
>
>         test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_p=
owered,
>                                                         test_bcast);
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
