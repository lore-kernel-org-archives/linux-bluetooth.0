Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9869D05
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526655; cv=none; b=RHSx31aM8I4/vbbW3Dcaq1qIBd/tMhHT16l35iT1Xj0zaGLNR2MXz3usEwFHYE+ty50hdO4BQlgdk6py4XhrPx/fRQYwWx5fz5OKoX68isOhbYICitpB/eaOKoxaAEqlHkwN6Nvps/aGQQuDA/Xd/4dWsT8xMdBrBtLn93wTu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526655; c=relaxed/simple;
	bh=jl4tiUfsSkKbOqtinw97nzboT4W7+Erqx6+h34g/WjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGZ5GdUT2nngcsyYm8ihNVTKmeiGKKwztZaVLNBgcNAJFU2YImeBI2cGvmn99BRDqK23LpmoIZr7bpxPAJU7ByKXMAPDhokr5X5W3fmiP2GEIurn6EESgDL/SGjLhr3PPnT6PvL8vi0+c1olFju/e2m6EKcnn+AvLn3EIXiRB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrJ0mO1q; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrJ0mO1q"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d24a727f78so22725981fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708526651; x=1709131451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zVdUIhmtGrIafe+FJN8JzIOB8U62Z7gWZTWASAVcXQ=;
        b=nrJ0mO1q1H7pqm8peWUURM9rZHj6B4gVxW6ojyNXGPv/wf9tTg7Hc3vQhZkL/FgieP
         Fx/7Q0d2ajzzLMoEQKjXr6tx0gifBwvnukqJ1+LhfhwwzkMRuhksSuZ9eBjWCP7DDYa/
         4Yvx+3Vt2UPp4L4nPYuGwVYTTyOkm035fY+Qg/6w60RZ8x9kZ855mf8OklfzGW3irlSa
         oZxQ+v4E6SSTm3IYSgR8tYVTyIEJ22Gzye79AAicZQLKjf8uvgC5X/cKVsusUIpuI8zG
         SK/bR4jAk6G8DOsz/qWAbNpRK9UqPpPA4ZJJp9U7ydA9Czka57MDFs6YZnApGYlVH4D7
         MSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526651; x=1709131451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zVdUIhmtGrIafe+FJN8JzIOB8U62Z7gWZTWASAVcXQ=;
        b=gwLjtRtUsbEKajj8T8T/E4ea61Wwk4XFegD2m4S8wfIYM9bMf6AFC/tPIqGhiVRbDC
         vJg8nealU1mxCwecxv9brAUJjIhtG9YR9cR33sZUm9I0649WJdeVa1Qs7aIXJefn/4tL
         U5dhss6+2+tAoOkxUqu2Kk6KrdVtvtLzjS4ocSTk8i18JPaEjNDMQvFHIkC6/XMCuNv0
         lnQxp3nl3r74DNBvcf1CyaxLZrL5WzTvSDXWHy0nThinYHwIvh7ekIG+oSizJsXqgzvy
         KK+ZFUomG2mKVtNhRqphHU4AuospJHrLNOV4sBDWeUuHgucFz1RO2NqOYRbhao28DKXK
         ULVg==
X-Gm-Message-State: AOJu0YylEksm1qF9YnTmamZoJKeltXjtCxh1iVXPow7ajlxLys2qXZxM
	LYOmrkPpmsplH4g7X/R5owqKoPiGZAu64aMKV7pYBjeuxnAt4+bX5RlJaXKCkj4rFehnRP15pBT
	vHKvPuBE/uewPcRdvE6ixvGWEyfY=
X-Google-Smtp-Source: AGHT+IHr5Kw3UZaAJnLlRIcxZiUcigp/Crq2JUlnXkPHGKUrsxQ1e2Z8JQmzwQqk+A+Tw6xPjAIFIMIL/UPi9yPZTto=
X-Received: by 2002:a2e:6a0b:0:b0:2d2:2c28:f174 with SMTP id
 f11-20020a2e6a0b000000b002d22c28f174mr9317651ljc.42.1708526651044; Wed, 21
 Feb 2024 06:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220163531.2900-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240220163531.2900-1-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Feb 2024 09:43:58 -0500
Message-ID: <CABBYNZKB5DVODNrqxKzJ4=G=gdwRZ+RM_S-hZFeii+VqAPadCA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: ISO: Reassemble fragmented BASE
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Tue, Feb 20, 2024 at 11:35=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> For a Broadcast Sink, this adds support for reassembling fragmented PA
> data. This is needed if the BASE comes fragmented in multiple PA reports.
> After all PA fragments have been reassembled, the BASE can be retrieved
> by the user via getsockopt.
>
> PA fragments could be reassembled inside hci_event.c and a complete PA
> report could be indicated to iso.c, or like it is currently, if PA
> fragments are indicated separately, reassembly would need to be done in
> iso.c.
>
> For a Broadcast Source, the user sets the BASE via setsockopt. The full
> PA data is built at bis bind, inside conn->le_per_adv_data. This array
> would be fit to hold the reassembled PA data on the Sink side as well,
> but a listening socket does not have an associated hcon...Currently for
> the Broadcast Sink, a hcon is created only after the first BIGInfo report=
,
> which arrives after the PA sync established event and all initial PA
> reports. The hcon is notified to iso.c, a child socket is created and it
> is notified to userspace, to mark the PA sync step as completed.
>
> I see 2 possibilities:
>
> 1. Keep a pa_data array inside the iso sock struct, use it to reassemble
> PA fragments, and extract BASE from it when needed.
>
> 2. Instead of creating the hcon after the first BIGInfo report, the hcon
> could be created when the PA sync established event is received. The
> le_per_adv_data can be used to reassemble the PA fragments, and the hcon
> will be notified to iso.c after the first BIGInfo report, when all
> information necessary to create and populate the child socket is
> available.
>
> In this patch I am showing the first idea, but I think the second one
> may provide a design more in line with the broadcast source scenario,
> when handling PA data and BASE.
>
> Are there any opinions about this?

I was actually going to ask about why we don't have an hcon at the
early stages of PA Sync, Im doing some optimizations so we scan based
on the QoS PHY which should be faster than scanning in all support
PHYs like we do today, but at that point there is no hcon and
therefore the is no visible QoS since the socket info is not public.

> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  include/net/bluetooth/hci.h |  7 +++-
>  net/bluetooth/iso.c         | 79 +++++++++++++++++++++++++++----------
>  2 files changed, 64 insertions(+), 22 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 08cb5cb249a4..a856e88719d2 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1,7 +1,7 @@
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> -   Copyright 2023 NXP
> +   Copyright 2023-2024 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> @@ -2037,6 +2037,7 @@ struct hci_cp_le_set_per_adv_params {
>  } __packed;
>
>  #define HCI_MAX_PER_AD_LENGTH  252
> +#define HCI_MAX_PER_AD_TOT_LENGTH      1650
>
>  #define HCI_OP_LE_SET_PER_ADV_DATA             0x203f
>  struct hci_cp_le_set_per_adv_data {
> @@ -2797,6 +2798,10 @@ struct hci_ev_le_per_adv_report {
>         __u8     data[];
>  } __packed;
>
> +#define LE_PA_DATA_COMPLETE    0x00
> +#define LE_PA_DATA_MORE_TO_COME        0x01
> +#define LE_PA_DATA_TRUNCATED   0x02
> +
>  #define HCI_EV_LE_EXT_ADV_SET_TERM     0x12
>  struct hci_evt_le_ext_adv_set_term {
>         __u8    status;
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 04f6572d35f1..e9a3b4f74e2f 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -3,7 +3,7 @@
>   * BlueZ - Bluetooth protocol stack for Linux
>   *
>   * Copyright (C) 2022 Intel Corporation
> - * Copyright 2023 NXP
> + * Copyright 2023-2024 NXP
>   */
>
>  #include <linux/module.h>
> @@ -70,8 +70,15 @@ struct iso_pinfo {
>         unsigned long           flags;
>         struct bt_iso_qos       qos;
>         bool                    qos_user_set;
> -       __u8                    base_len;
> -       __u8                    base[BASE_MAX_LENGTH];
> +       union {
> +               __u8            base_len;
> +               __u16           pa_data_len;
> +       };
> +       union {
> +               __u8            base[BASE_MAX_LENGTH];
> +               __u8            pa_data[HCI_MAX_PER_AD_TOT_LENGTH];
> +       };
> +       __u16                   pa_data_offset;
>         struct iso_conn         *conn;
>  };
>
> @@ -1573,7 +1580,7 @@ static int iso_sock_getsockopt(struct socket *sock,=
 int level, int optname,
>         struct sock *sk =3D sock->sk;
>         int len, err =3D 0;
>         struct bt_iso_qos *qos;
> -       u8 base_len;
> +       size_t base_len;
>         u8 *base;
>
>         BT_DBG("sk %p", sk);
> @@ -1612,13 +1619,20 @@ static int iso_sock_getsockopt(struct socket *soc=
k, int level, int optname,
>                 break;
>
>         case BT_ISO_BASE:
> -               if (sk->sk_state =3D=3D BT_CONNECTED &&
> -                   !bacmp(&iso_pi(sk)->dst, BDADDR_ANY)) {
> -                       base_len =3D iso_pi(sk)->conn->hcon->le_per_adv_d=
ata_len;
> -                       base =3D iso_pi(sk)->conn->hcon->le_per_adv_data;
> -               } else {
> +               if (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY)) {
> +                       /* For a Broadcast Source, the BASE was stored
> +                        * in iso_pi(sk)->base.
> +                        */
>                         base_len =3D iso_pi(sk)->base_len;
>                         base =3D iso_pi(sk)->base;
> +               } else {
> +                       /* For a Broadcast Sink, the complete data receiv=
ed in
> +                        * PA reports is stored. Extract BASE from there.
> +                        */
> +                       base =3D eir_get_service_data(iso_pi(sk)->pa_data=
,
> +                                                   iso_pi(sk)->pa_data_l=
en,
> +                                                   EIR_BAA_SERVICE_UUID,
> +                                                   &base_len);
>                 }
>
>                 len =3D min_t(unsigned int, len, base_len);
> @@ -1834,8 +1848,9 @@ static void iso_conn_ready(struct iso_conn *conn)
>                 bacpy(&iso_pi(sk)->dst, &hcon->dst);
>                 iso_pi(sk)->dst_type =3D hcon->dst_type;
>                 iso_pi(sk)->sync_handle =3D iso_pi(parent)->sync_handle;
> -               memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(par=
ent)->base_len);
> -               iso_pi(sk)->base_len =3D iso_pi(parent)->base_len;
> +               memcpy(iso_pi(sk)->pa_data, iso_pi(parent)->pa_data,
> +                      iso_pi(parent)->pa_data_len);
> +               iso_pi(sk)->pa_data_len =3D iso_pi(parent)->pa_data_len;
>
>                 hci_conn_hold(hcon);
>                 iso_chan_add(conn, sk, parent);
> @@ -1904,8 +1919,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>          * a BIG Info it attempts to check if there any listening socket =
with
>          * the same sync_handle and if it does then attempt to create a s=
ync.
>          * 3. HCI_EV_LE_PER_ADV_REPORT: When a PA report is received, it =
is stored
> -        * in iso_pi(sk)->base so it can be passed up to user, in the cas=
e of a
> -        * broadcast sink.
> +        * in iso_pi(sk)->pa_data so the BASE can later be passed up to u=
ser, in
> +        * the case of a broadcast sink.
>          */
>         ev1 =3D hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
>         if (ev1) {
> @@ -1961,16 +1976,38 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_=
t *bdaddr, __u8 *flags)
>
>         ev3 =3D hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
>         if (ev3) {
> -               size_t base_len =3D ev3->length;
> -               u8 *base;
> -
>                 sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
>                                          iso_match_sync_handle_pa_report,=
 ev3);
> -               base =3D eir_get_service_data(ev3->data, ev3->length,
> -                                           EIR_BAA_SERVICE_UUID, &base_l=
en);
> -               if (base && sk && base_len <=3D sizeof(iso_pi(sk)->base))=
 {
> -                       memcpy(iso_pi(sk)->base, base, base_len);
> -                       iso_pi(sk)->base_len =3D base_len;
> +
> +               if (!sk)
> +                       goto done;
> +
> +               if (ev3->data_status =3D=3D LE_PA_DATA_TRUNCATED) {
> +                       /* The controller was unable to retrieve PA data.=
 */
> +                       memset(iso_pi(sk)->pa_data, 0,
> +                              HCI_MAX_PER_AD_TOT_LENGTH);
> +                       iso_pi(sk)->pa_data_len =3D 0;
> +                       iso_pi(sk)->pa_data_offset =3D 0;
> +                       return lm;
> +               }
> +
> +               if (iso_pi(sk)->pa_data_offset + ev3->length >
> +                   HCI_MAX_PER_AD_TOT_LENGTH)
> +                       goto done;
> +
> +               memcpy(iso_pi(sk)->pa_data + iso_pi(sk)->pa_data_offset,
> +                      ev3->data, ev3->length);
> +               iso_pi(sk)->pa_data_offset +=3D ev3->length;
> +
> +               if (ev3->data_status =3D=3D LE_PA_DATA_COMPLETE) {
> +                       /* All PA data has been received. */
> +                       iso_pi(sk)->pa_data_len =3D iso_pi(sk)->pa_data_o=
ffset;
> +                       iso_pi(sk)->pa_data_offset =3D 0;
> +               } else {
> +                       /* This is a PA data fragment. Keep pa_data_len s=
et to 0
> +                        * until all data has been reassembled.
> +                        */
> +                       iso_pi(sk)->pa_data_len  =3D 0;
>                 }
>         } else {
>                 sk =3D iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NUL=
L, NULL);
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
