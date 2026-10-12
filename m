Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9B39FCB4
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835148; cv=pass; b=MBwUzhp/ARZXa4QkIFYjT5BzkS7U44KgKgVMnCY/ziO29B7dOOkJN5AJXDfid8qgr874gU6jN1VC18xY0xRH6lh3U8k2lpeDwOgliM65+mfzzdGlJ/NZTYPbP5lWqOkXDyVVnN7C0EpzH/6wlhD9PJo/KrttIB82dX7geIp8yK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835148; c=relaxed/simple;
	bh=gzskIchdTK6kBnuhYBgkhYMLohKRsGNXe035o/7VUl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSqwJk0pubG0iKm2/7eT5YHfskM24T+3kbCw7k50DI4diqyV0drC3Er6ONpvtTEn/NNQQd5tFP6QOPvrcRmY8clm4vtJlYHT3417cFXfbBBqACW+5cwjbheTEzU7iCrGD/H1XbX1gLSRtbF5pUwVNrUcBO6M/m99zp6FC9D8bn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laTu5YiX; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laTu5YiX"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8871ada1a26so13613867b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 12:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791835146; cv=none;
        d=google.com; s=arc-20260327;
        b=KVuKw30mo75rYDg378r5ThioC4i3XJLt9ZDhRqWxENoekNDV7o3hfn7eg1R/5Rrz2E
         YEHrpQq0h/aYi5N1TlbJ2RbpBiGga6y4sYp60QtkR6XIfMUwoWiWXjnQ2zbGqGo2hRH/
         Y3eYyGLrzi7XUVQEG2X+QAuhyYHvpe0Aj7iof0o3Ds0XD5JroB+rwq0DmXE06y0oqEPl
         VJRlgRw4ID+BRWumNGFrLx/MRAG115cJLci7hXCjZUVVDp5cT0GX5Ce9hB6j3Zsyabz+
         vNGOznYCRQCmu5snr0+uTWxl1Ar9XFPolIw0eLgdTf4KYWjQDjUcnoZdHPJOVnhfO3EZ
         EGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gxuZz9uSRUHRzOHkp++5ChOmVvuffCYCJtHjaTlU+HA=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=Aq2JyqHW9VzxzPl3/5dHqD+9pnfwFd7+jJ4ZuUCneqPpy3iI3p/PLSAVHvs9NDJ/Jx
         JZQJQMEOgn40D9HP/2knVLabaHicPkHj5NyCrduR2vdm/Dr59XIIIg1SElkNHChJgoVI
         m3SJBJPXiYdb3sXQbuIVMGSba9PQrfegeUgFPlR2jfxVGRVKQpIdwFSYBJ9AGGq1p5Uq
         Z2PcjXsscQP/fj0ESVDen2pfrG1dsVeSWKO+IdqlcX6Q2L9qkjMKwGi1vuS/OigCZJrX
         YpsqnMh+/v+Z7r9EAazoqwQjTV+NdcmdO9dS3FXUCfM7OCZBC5Aa1Y87R2ZQJJt889Tz
         xegw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791835146; x=1792439946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gxuZz9uSRUHRzOHkp++5ChOmVvuffCYCJtHjaTlU+HA=;
        b=laTu5YiXZgeIMV6IGoNTd6cdGys03afzm71XAsKrzR2IwXiV9togvfZoeGZuBM+Ex0
         nTchb+3dNQMcZ7JzjXnoLIBE9aLTd4Dt/TZjmJ2eKycG133+s3MR7JEuTqTzl1s0DuOU
         fajld3CAl1jY9DlE+6OTWTMf25M2BM++P1ilbMgudjbioj3Q7tVhzh6Mv0Nodr+tqaQ/
         VOz1dglNCfgQhMxXl4OT/TZ0xxCTUy0965cJyxN3F0sOHowVeno4JgKxYQJA4hvDLdlO
         TtvF45XVTUIaDqKtogNwV7eyDVmZWnDSMlkg3yGPPG9m5GpMRw/PKXhzIvEfJgD9zCy2
         a5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835146; x=1792439946;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxuZz9uSRUHRzOHkp++5ChOmVvuffCYCJtHjaTlU+HA=;
        b=KeBp8d5TgL3AWC5N7AOUh1mOZY4Zs5MbPxVil1IPTzsHoGBsvLGSEaKOGNI1WpNw6r
         ZuDkKkLvM8REgWGKvGZjcEAgip0gMZ3lRUbyox0/CZsPnEVYhJtHObLIULm7Rrq3eWFq
         euQhVfDUQWfF5AKW1lg2AdCeltAD2L9m0Z7mWIjzoavcW63fJms38IcKxqNTccCBgIM1
         /nG+t4TOuB0UO2UNYpsJbO4izgGhIqCMleJYtMB4y1Ggtp4HhJVasGf6mf8m6qlYTXyD
         i2mo9fqI7slgl1dv6HfBw8XUSIduB9ISlPVZ/PsAab0Uvlp/WbjLciAeKXAGiKkH5TKL
         2CNg==
X-Gm-Message-State: AFq9FYIs73Ldh7oFFYzizhpIw+iZsMwz8CpFXss6Yok28hxmU1Ze5Z7c
	2OVb6LDRawsHaQ5oz0z6bTgcV4s0alX9AJOcSOklIBZObd6c79TVRMfeSQb+h5MUc1MGwl+AoKw
	D0S6Q1i4waxFsnSSk+wLzKkeev6JyQlRBzyi5
X-Gm-Gg: AYBFou0IyipSXoHPqTFXp7XklZHyba/81BPbFdRaJYg54Bpsb3ThnHvjmi1JIkHbw8X
	18AhfIDo7Fwflr15Ck8pL05RmdnYz6OPBz6/4/dZlNW9ANf1GEaXtAzUqsUoduDJZSyxbL5EaT6
	Hh0N+wGMc7yJxiPiZ68V+UHAvGXAbOt6RaPUL4pXJHLkLfcP8k6v4R2+P5irpQVGp/ojVecCXJQ
	6X+ILHPZpUhqhW8u6uJ21jpqgvYy29cMtREpAjgxYqz3GH8YxdtqyTheKq/hlZeAKeSko/4Umqc
	E9d/vw/CUDmsy2HzmgZCUpJnsb9BtwRC8y9zXrxzxdC/7RuDmWYel+tJbcdIUOgX114Vvt/psim
	Z9DPhyyafwWFvtzGSUUTxVKoKQzQI1FEmKvkvWG1NVudditLnYg==
X-Received: by 2002:a05:690c:f09:b0:8a8:85d7:265 with SMTP id
 00721157ae682-8b07edb5942mr33016357b3.36.1791835145652; Mon, 12 Oct 2026
 12:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791750393.git.pav@iki.fi> <5b5a8c1ebfe761606affcca1437c8a352fa0502a.1791750393.git.pav@iki.fi>
In-Reply-To: <5b5a8c1ebfe761606affcca1437c8a352fa0502a.1791750393.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Oct 2026 15:58:53 -0400
X-Gm-Features: AclHuK_AoL3D6Rw2_P4VTXjiTakgA6N2j-5ayuJ9hLs4tyIkQRRWIHN4Fh8nUe8
Message-ID: <CABBYNZJ94rHYZ74GLyX7O4oTAbsWYSMccx6bzpods+BAQ=BwVA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] bass: wait for PAST listener readiness
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Oct 11, 2026 at 4:42=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Defer SYNC_INFO_RE until the PA sync listener signals POLLOUT, so the
> Assistant cannot start PAST before receiver setup completes.
>
> Check kernel support via BT_ISO_PAST_POLLOUT, otherwise skip waiting.
>
> Fixes test_bass_past_transport_* test failures.
>
> Assisted-by: LLM
> ---
>  profiles/audio/bass.c | 66 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 7 deletions(-)
>
> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> index fd05195f3..90e758c08 100644
> --- a/profiles/audio/bass.c
> +++ b/profiles/audio/bass.c
> @@ -146,7 +146,9 @@ struct bass_delegator {
>         struct queue *bcode_reqs;
>         struct queue *setups;
>         unsigned int io_id;
> +       unsigned int io_ready_id;
>         GIOChannel *io;
> +       bool past;
>  };
>
>  struct bass_setup {
> @@ -751,6 +753,11 @@ static void confirm_cb(GIOChannel *io, void *user_da=
ta)
>
>         DBG("");
>
> +       if (dg->io_ready_id) {
> +               g_source_remove(dg->io_ready_id);
> +               dg->io_ready_id =3D 0;
> +       }
> +
>         /* Close the listen io */
>         g_io_channel_shutdown(dg->io, TRUE, NULL);
>         g_io_channel_unref(dg->io);
> @@ -1528,11 +1535,28 @@ static bool delegator_match_device(const void *da=
ta, const void *match_data)
>         return dg->device =3D=3D device;
>  }
>
> +static gboolean pa_sync_ready_cb(GIOChannel *io, GIOCondition cond,
> +                                                       gpointer user_dat=
a)
> +{
> +       struct bass_delegator *dg =3D user_data;
> +
> +       dg->io_ready_id =3D 0;
> +
> +       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
> +               return FALSE;
> +
> +       bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
> +
> +       return FALSE;
> +}
> +
>  static void delegator_attach(struct bt_bap *bap, struct btd_device *devi=
ce,
>                                 struct btd_service *service)
>  {
>         struct bass_delegator *dg;
>         GError *err =3D NULL;
> +       socklen_t len;
> +       int sk, past_pollout;
>
>         dg =3D queue_find(delegators, delegator_match_device, device);
>         if (!dg)
> @@ -1570,6 +1594,30 @@ static void delegator_attach(struct bt_bap *bap, s=
truct btd_device *device,
>
>         /* Take ownership for the service by setting the user data. */
>         btd_service_set_user_data(service, dg);
> +
> +       if (!dg->past)
> +               return;
> +
> +       sk =3D g_io_channel_unix_get_fd(dg->io);
> +       len =3D sizeof(past_pollout);
> +
> +       if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_PAST_POLLOUT,
> +                                               &past_pollout, &len) < 0)=
 {
> +               if (errno !=3D ENOPROTOOPT) {
> +                       error("Unable to query PAST readiness support: %s=
",
> +                                                       strerror(errno));
> +                       return;
> +               }
> +
> +               past_pollout =3D 0;
> +       }

While I agree it needs fixing since not only it can create problem for
testing but it may be possible to hit this over the air as well, the
solution though is a little bitter to my taste, perhaps we could use
to indicate when HCI_OP_LE_PAST_PARAMS has been completed (with
status=3D0) then we notify with flags changed. If that is still a little
too much perhaps we can issue right away when setting upon receiving
MGMT_OP_SET_DEVICE_FLAGS(HCI_CONN_FLAG_PAST) and somehow makeup for
the qos arguments if conn->iso_qos is not set yet, either way that
should gate the response of BT_BASS_SYNC_INFO_RE by indicating
HCI_CONN_FLAG_PAST is actually programmed in the controller via
HCI_OP_LE_PAST_PARAMS.

> +       if (past_pollout)
> +               dg->io_ready_id =3D g_io_add_watch(dg->io,
> +                               G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVA=
L,
> +                               pa_sync_ready_cb, dg);
> +       else
> +               bt_bass_set_pa_sync(dg->src, BT_BASS_SYNC_INFO_RE);
>  }
>
>  static void bap_attached(struct bt_bap *bap, void *user_data)
> @@ -1645,6 +1693,9 @@ static void delegator_free(struct bass_delegator *d=
g)
>         if (dg->io_id)
>                 g_source_remove(dg->io_id);
>
> +       if (dg->io_ready_id)
> +               g_source_remove(dg->io_ready_id);
> +
>         if (dg->io) {
>                 g_io_channel_shutdown(dg->io, TRUE, NULL);
>                 g_io_channel_unref(dg->io);
> @@ -1906,7 +1957,7 @@ static void bass_detached(struct bt_bass *bass, voi=
d *user_data)
>
>  static struct bass_delegator *
>  bass_delegator_new(struct btd_device *device, struct bt_bcast_src *src,
> -                       uint8_t sid)
> +                       uint8_t sid, bool past)
>  {
>         struct bass_delegator *dg;
>
> @@ -1917,6 +1968,7 @@ bass_delegator_new(struct btd_device *device, struc=
t bt_bcast_src *src,
>         dg->device =3D device;
>         dg->src =3D src;
>         dg->sid =3D sid;
> +       dg->past =3D past;
>         dg->bcode_reqs =3D queue_new();
>         dg->setups =3D queue_new();
>
> @@ -1945,6 +1997,7 @@ static int handle_add_src_req(struct bt_bcast_src *=
bcast_src,
>         struct btd_adapter *adapter =3D device_get_adapter(data->device);
>         struct btd_device *device;
>         struct bass_delegator *dg;
> +       bool past =3D false;
>
>         /* Detect if PAST can be used then it can be used as destination =
since
>          * PAST Receiver uses the ACL connection itself.
> @@ -1957,6 +2010,7 @@ static int handle_add_src_req(struct bt_bcast_src *=
bcast_src,
>                 if (btd_adapter_has_settings(data->adapter,
>                                                 MGMT_SETTING_PAST_RECEIVE=
R)) {
>                         device_set_past_support(data->device, true);
> +                       past =3D true;
>                         device =3D data->device;
>                         goto done;
>                 }
> @@ -1980,16 +2034,14 @@ done:
>          * autonomously probed inside BAP.
>          */
>         if (!btd_device_get_service(device, BCAAS_UUID_STR)) {
> -               dg =3D bass_delegator_new(device, bcast_src, params->sid)=
;
> +               dg =3D bass_delegator_new(device, bcast_src, params->sid,=
 past);
>                 if (!dg)
>                         return -ENOMEM;
> +
> +               if (past)
> +                       return 0;
>         }
>
> -       /* Set PA sync state, this has to be done after probing otherwise=
 there
> -        * is a race where the remote may receive BT_BASS_SYNC_INFO_RE an=
d start
> -        * PAST before the kernel has sent PAST Parameter command that en=
ables
> -        * receiving it.
> -        */
>         if (params->pa_sync =3D=3D PA_SYNC_PAST) {
>                 if (btd_adapter_has_settings(data->adapter,
>                                                 MGMT_SETTING_PAST_RECEIVE=
R))
> --
> 2.56.0
>
>


--=20
Luiz Augusto von Dentz
