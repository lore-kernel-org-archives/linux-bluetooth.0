Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56D19AA63
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523299; cv=none; b=LfIYYJkLKG1qo4fjMq1vVXZ0U0cVbV1dma9Oe9QAA1Z2JC5jhfTF1wtXgG7AJ67nzT1sCmJLAqRIO4nVOWs+Z5mN6n1fDTODqr8xnG8m61k3FFyHTyrcLsmRR8gBJ4Lt7RoTbV2H4IbcWIYyTo8r/FIc40ZvNV0rmBn5frAET9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523299; c=relaxed/simple;
	bh=T02L6oeYaw1viFrkN6oG7SdvjeKqlgUgMv55MjJ++4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxk6IH8HXXh9ve8Az8Ifh5FQk36YUgLrJlGCQ+JG7B974DPHJ9YGRm1vW3swiIYy+m6pJl0HUH7CCBF0SuO4TW22Vw9Wnnn9viYPuRN8I41wGsX2YF4fsJ0X3+g1Dyptfu/oKVZr4BnEdEV4pjB9MhZCN7tBbeiY7R8KpHN9LNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+RjQAZU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+RjQAZU"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-306007227d3so15695811fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736523295; x=1737128095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpJIQH4+CEgzWuWnicbWpbAwk9Szd2tpSuyTh1rL0Ng=;
        b=O+RjQAZUVta8slvG5fHa6O6qVv7wvTIE+wT64oqmnrPSosnf0hytljMF519KjV+trl
         wuH3r7NxlMqAWHrO6u7mg6XhM+v2QGm1gosVSsPwVJwoscXt8t0TsS1ScNZlLtbo+WIF
         18vAWQRWiUrkH7kM4JQipVLAj2faLyRDzX5/Ig6G2MD68OGuGX30IcL7lYmH4xeUaIn/
         i6y4XDOZfyRHhirUsPAf6i8fXe/Pia0sgAk4OGUWa7Me5sAOjcAO5vCsTXmAyLuD9EMq
         Cj2Ub38dxxZre8H9Ka4ClELDrsIAxxxn9FnrC5rEzoXs9R3fsA9S05RnmtDmA87mZeKE
         eROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523295; x=1737128095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpJIQH4+CEgzWuWnicbWpbAwk9Szd2tpSuyTh1rL0Ng=;
        b=xHuAtrcIm9HF9UpFAQiN0mKqfHFBPz/MsZ6QF8H96twIp6n4jznL1aPvUTe/JlG975
         JcTii31+TBQZNNSDO50UnN6EVN3JEJjYZC7njxuCszbHTu/kvn8KVwyWo9Qpkr/c8pmE
         n2RJtIXec05WTvd2BfqKm8pgc22/cJpk2yJ+xwHpntKKS7KeSaSqWO65GcNoKzg7nh5n
         rtS6txth1CmaSQIlj1qdwgSdipGSuT347aI2JTchdaNix1JDIaovKxqfigl1S4H842NJ
         Nl+ysBlvNDFqZ/e8FdwhZoiJz/Tl2EPqkOTuO4KgSbdFjLrkmnFmm/RXhkfcBd5RTdYT
         nRHg==
X-Gm-Message-State: AOJu0YyyXTJvokzn9YG0LgPuxEDfNsIDb9EFetnWruFUBSgw+2C3ygmI
	keq3mznnzxCmjgS3lKB2L44A0ET+mcheLNlXVMGyRJTB7nVVVcv91+4Dp0jOTu4yFGv255+wo0R
	8bydaH5nC80L1nLqrT3spA9dG0C8=
X-Gm-Gg: ASbGncv8CJE2G91PVKTPyVuCU43Q7VQx0kPqG/7eeKgdchKD6MAB0u2DXkMVNLwU+z7
	FcNlNQuT++fBUvpCt2iMqzXigF+beUR/igtLv9Bc=
X-Google-Smtp-Source: AGHT+IGwZn7n4jcKc7a3e4oz/FcoWYDkvS3QFpBy1F4j1xmeU9UU1zvTmTEl2b1SX81ey+7kT+Pa41MyZgZO/iWFHnU=
X-Received: by 2002:a2e:a7ca:0:b0:302:3508:f4ab with SMTP id
 38308e7fff4ca-305f4594134mr38253511fa.21.1736523295125; Fri, 10 Jan 2025
 07:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110145019.2380299-1-michal.dzik@streamunlimited.com> <20250110145019.2380299-4-michal.dzik@streamunlimited.com>
In-Reply-To: <20250110145019.2380299-4-michal.dzik@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Jan 2025 10:34:43 -0500
X-Gm-Features: AbW1kvaeo96ZRNNaFEdp3Uu-9ZWDuI02UxnQF6EZ9N8cJIikel3PBdqeidQVykI
Message-ID: <CABBYNZ++V+qYpiBiNJdqjGouuo22RWiuv1qXgUvei6bzzDYpeA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] vcp: allow volume control when acting as a server
To: Michal Dzik <michal.dzik@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Fri, Jan 10, 2025 at 9:54=E2=80=AFAM Michal Dzik
<michal.dzik@streamunlimited.com> wrote:
>
> Local VCP chatacteristics are now connected to transport properties.
> ---
>  profiles/audio/vcp.c |   7 +--
>  src/shared/vcp.c     | 109 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 86 insertions(+), 30 deletions(-)
>
> diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
> index 0203673bf..07b227107 100644
> --- a/profiles/audio/vcp.c
> +++ b/profiles/audio/vcp.c
> @@ -186,7 +186,7 @@ bool bt_audio_vcp_set_volume(struct btd_device *devic=
e, int8_t volume)
>         return FALSE;
>  }
>
> -static void vcp_detached(struct bt_vcp *vcp, void *user_data)
> +static void vcp_remote_client_detached(struct bt_vcp *vcp, void *user_da=
ta)
>  {
>         struct vcp_data *data;
>
> @@ -201,7 +201,7 @@ static void vcp_detached(struct bt_vcp *vcp, void *us=
er_data)
>         vcp_data_remove(data);
>  }
>
> -static void vcp_attached(struct bt_vcp *vcp, void *user_data)
> +static void vcp_remote_client_attached(struct bt_vcp *vcp, void *user_da=
ta)
>  {
>         struct vcp_data *data;
>         struct bt_att *att;
> @@ -352,7 +352,8 @@ static int vcp_init(void)
>         if (err)
>                 return err;
>
> -       vcp_id =3D bt_vcp_register(vcp_attached, vcp_detached, NULL);
> +       vcp_id =3D bt_vcp_register(vcp_remote_client_attached,
> +                                           vcp_remote_client_detached, N=
ULL);
>
>         return 0;
>  }
> diff --git a/src/shared/vcp.c b/src/shared/vcp.c

Don't mix the changes of shared and plugins, they should be changed
independently since they may affect different parts e.g. shared can be
used for unit testing, tools, etc.

> index c92eb00d4..45d0f4485 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -379,7 +379,15 @@ static struct bt_aics *vcp_get_aics(struct bt_vcp *v=
cp)
>         return vcp->rdb->aics;
>  }
>
> -static void vcp_detached(void *data, void *user_data)
> +static void vcp_remote_client_attached(void *data, void *user_data)
> +{
> +       struct bt_vcp_cb *cb =3D data;
> +       struct bt_vcp *vcp =3D user_data;
> +
> +       cb->attached(vcp, cb->user_data);
> +}
> +
> +static void vcp_remote_client_detached(void *data, void *user_data)
>  {
>         struct bt_vcp_cb *cb =3D data;
>         struct bt_vcp *vcp =3D user_data;
> @@ -389,7 +397,6 @@ static void vcp_detached(void *data, void *user_data)
>
>  void bt_vcp_detach(struct bt_vcp *vcp)
>  {
> -       struct bt_vcs *vcs;
>         if (!queue_remove(sessions, vcp))
>                 return;
>
> @@ -399,7 +406,7 @@ void bt_vcp_detach(struct bt_vcp *vcp)
>         }
>
>         if (vcp->rdb) {
> -               vcs =3D vcp_get_vcs(vcp);
> +               struct bt_vcs *vcs =3D vcp_get_vcs(vcp);
>                 vcs->service =3D NULL;
>                 vcs->vs =3D NULL;
>                 vcs->vs_ccc =3D NULL;
> @@ -506,6 +513,7 @@ static void vcp_disconnected(int err, void *user_data=
)
>         DBG(vcp, "vcp %p disconnected err %d", vcp, err);
>
>         bt_vcp_detach(vcp);
> +       queue_foreach(vcp_cbs, vcp_remote_client_detached, vcp);
>  }
>
>  static struct bt_vcp *vcp_get_session(struct bt_att *att, struct gatt_db=
 *db)
> @@ -524,6 +532,8 @@ static struct bt_vcp *vcp_get_session(struct bt_att *=
att, struct gatt_db *db)
>         vcp =3D bt_vcp_new(db, NULL);
>         vcp->att =3D att;
>
> +       queue_foreach(vcp_cbs, vcp_remote_client_attached, vcp);
> +
>         bt_att_register_disconnect(att, vcp_disconnected, vcp, NULL);
>
>         if (!sessions)
> @@ -566,6 +576,10 @@ static uint8_t vcs_rel_vol_down(struct bt_vcs *vcs, =
struct bt_vcp *vcp,
>
>         vstate->vol_set =3D MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
>         vstate->counter =3D -~vstate->counter; /*Increment Change Counter=
*/
> +       vcp->volume =3D vstate->vol_set;
> +
> +       if (vcp->volume_changed)
> +               vcp->volume_changed(vcp, vcp->volume / 2);

What is this division by 2 for? If this is by the spec then Id suggest
adding a define, otherwise Id just store the actual value.

>
>         gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
>                                  sizeof(struct vol_state),
> @@ -605,6 +619,10 @@ static uint8_t vcs_rel_vol_up(struct bt_vcs *vcs, st=
ruct bt_vcp *vcp,
>
>         vstate->vol_set =3D MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
>         vstate->counter =3D -~vstate->counter; /*Increment Change Counter=
*/
> +       vcp->volume =3D vstate->vol_set;
> +
> +       if (vcp->volume_changed)
> +               vcp->volume_changed(vcp, vcp->volume / 2);
>
>         gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
>                                  sizeof(struct vol_state),
> @@ -645,6 +663,10 @@ static uint8_t vcs_unmute_rel_vol_down(struct bt_vcs=
 *vcs, struct bt_vcp *vcp,
>         vstate->mute =3D 0x00;
>         vstate->vol_set =3D MAX((vstate->vol_set - VCP_STEP_SIZE), 0);
>         vstate->counter =3D -~vstate->counter; /*Increment Change Counter=
*/
> +       vcp->volume =3D vstate->vol_set;
> +
> +       if (vcp->volume_changed)
> +               vcp->volume_changed(vcp, vcp->volume / 2);
>
>         gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
>                                  sizeof(struct vol_state),
> @@ -685,6 +707,10 @@ static uint8_t vcs_unmute_rel_vol_up(struct bt_vcs *=
vcs, struct bt_vcp *vcp,
>         vstate->mute =3D 0x00;
>         vstate->vol_set =3D MIN((vstate->vol_set + VCP_STEP_SIZE), 255);
>         vstate->counter =3D -~vstate->counter; /*Increment Change Counter=
*/
> +       vcp->volume =3D vstate->vol_set;
> +
> +       if (vcp->volume_changed)
> +               vcp->volume_changed(vcp, vcp->volume / 2);
>
>         gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
>                                  sizeof(struct vol_state),
> @@ -724,6 +750,10 @@ static uint8_t vcs_set_absolute_vol(struct bt_vcs *v=
cs, struct bt_vcp *vcp,
>
>         vstate->vol_set =3D req->vol_set;
>         vstate->counter =3D -~vstate->counter; /*Increment Change Counter=
*/
> +       vcp->volume =3D vstate->vol_set;
> +
> +       if (vcp->volume_changed)
> +               vcp->volume_changed(vcp, vcp->volume / 2);
>
>         gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate,
>                                  sizeof(struct vol_state),
> @@ -2023,34 +2053,59 @@ bool bt_vcp_set_volume(struct bt_vcp *vcp, int8_t=
 volume)
>  {
>         struct bt_vcs_client_ab_vol req;
>         uint16_t value_handle;
> -       struct bt_vcs *vcs =3D vcp_get_vcs(vcp);
>
> -       if (!vcs) {
> -               DBG(vcp, "error: vcs not available");
> -               return false;
> -       }
> +       vcp->volume =3D volume * 2;

Ditto, very odd to have to multiply by 2 and then divide when sending,
and I'm afraid we may have overflow problems as well.

>
> -       if (!vcs->vol_cp) {
> -               DBG(vcp, "error: vol_cp characteristics not available");
> -               return false;
> -       }
> +       if (vcp->rdb) {
> +               /* local gatt client */

Note that the fact that there is an rdb does _not_ guarantee we are
acting as a client, since the remote may support both roles e.g. bluez
vs bluez, instead you should really be checking if vcp->client has
been set.

> +               struct bt_vcs *vcs =3D vcp_get_vcs(vcp);
>
> -       if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL, &value_ha=
ndle,
> -                                                       NULL, NULL, NULL)=
) {
> -               DBG(vcp, "error: vol_cp characteristics not available");
> -               return false;
> -       }
> +               if (!vcs) {
> +                       DBG(vcp, "error: vcs not available");
> +                       return false;
> +               }
>
> -       vcp->volume =3D volume * 2;
> -       req.op =3D BT_VCS_SET_ABSOLUTE_VOL;
> -       req.vol_set =3D vcp->volume;
> -       req.change_counter =3D vcp->volume_counter;
> -
> -       if (!bt_gatt_client_write_value(vcp->client, value_handle, (void =
*) &req,
> -               sizeof(struct bt_vcs_client_ab_vol), vcp_volume_cp_sent, =
vcp,
> -                                                                       N=
ULL)) {
> -               DBG(vcp, "error writing volume");
> -               return false;
> +               if (!vcs->vol_cp) {
> +                       DBG(vcp, "error: vol_cp characteristics not avail=
able");
> +                       return false;
> +               }
> +
> +               if (!gatt_db_attribute_get_char_data(vcs->vol_cp, NULL,
> +                                       &value_handle, NULL, NULL, NULL))=
 {
> +                       DBG(vcp, "error: vol_cp characteristics not avail=
able");
> +                       return false;
> +               }
> +
> +               req.op =3D BT_VCS_SET_ABSOLUTE_VOL;
> +               req.vol_set =3D vcp->volume;
> +               req.change_counter =3D vcp->volume_counter;
> +
> +               if (!bt_gatt_client_write_value(vcp->client, value_handle=
,
> +                       (void *) &req, sizeof(struct bt_vcs_client_ab_vol=
),
> +                                       vcp_volume_cp_sent, vcp, NULL)) {
> +                       DBG(vcp, "error writing volume");
> +                       return false;
> +               }
> +       } else {
> +               // local gatt server
> +               struct bt_vcp_db *vdb =3D vcp_get_vdb(vcp);
> +               struct vol_state *vstate;
> +
> +               if (!vdb) {
> +                       DBG(vcp, "error: VDB not available");
> +                       return false;
> +               }
> +
> +               vstate =3D vdb_get_vstate(vdb);
> +               if (!vstate) {
> +                       DBG(vcp, "error: VSTATE not available");
> +                       return false;
> +               }
> +
> +               vstate->vol_set =3D vcp->volume;
> +               vstate->counter =3D -~vstate->counter; /*Increment Change=
 Counter*/
> +               gatt_db_attribute_notify(vdb->vcs->vs, (void *) vstate,
> +                               sizeof(struct vol_state), bt_vcp_get_att(=
vcp));

I'd recommend splitting these into their own functions to make it more
readable and you can name it according to the role as well.

>         }
>         return true;
>  }
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
