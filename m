Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2781AA790
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054090; cv=none; b=cR69x2lR4j0pkEKElNYEcH0GNTULzBNqYU6k2GG1GJDT+Z5AaFbwEPVxJ8g9maGt5YAsfBNrJQZ5CHKRUDibWNqgmMwnpdQo0trWcuejMKe8Lh0Dg5CbOKXwe8eZADEPBHf41nbl3M80gJoiNM8cmisMyCrYhWTbOPACw3rkGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054090; c=relaxed/simple;
	bh=pXr4Bk0E9uUMVzQFDfGWAmLohzfMwp0OlPtapvYwOLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgSVdqMExD7jxw62PkVvk2/Aeu9RPFayx8QKK15auYwr+kYSBV7sVbbwyfsKSF+crFSxEOOnw8e4Dn2kCnwhiFFrdxGdfLne78/wYYs2MjgEpDjIKinv856WSeul/K5SfmkC2tS0C5uOslcmceAYgn4fpR4UwqdsiA2nYEj86dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuOZ+T2O; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuOZ+T2O"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2facf48157dso24759401fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Oct 2024 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728054087; x=1728658887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA0ws/R71gvfZgwOmjNya3wmNYxMJ7cwDmDcuDOGk0o=;
        b=JuOZ+T2OyaaxBGRBzdRxwfRN+BbbIdcG+xLRP78V+/PVEq1KlGQhXNRaxIqqjOMnxf
         NOdLtaA15fjAbU1mpwsvvcectfNIfCmcAjRc4TQzeOL7ZwACEiklelQRYMSZhFX1OvkA
         hrlq3LdUgpJtG4ZWGgbFdHPx4Op7n3t09kQbA28cRcNOBwOG99UIugjXA04epCQz+Ls5
         cWFBr9HD2AlpqN/eWgwcBzvmdi7zlQQg3lyb/SABNgNYmPPtFmWcIftPdq8a4K9eTEIi
         f08CHVzteR2Dy+Rxy1yffsvWlkiKWNxGs5H99ZXpPXTpnzyY14iOHslSCxlJGqr0kuMy
         obIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054087; x=1728658887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA0ws/R71gvfZgwOmjNya3wmNYxMJ7cwDmDcuDOGk0o=;
        b=fHd83srmdYsfqsI71RThYWgAW85zFwy7YUuOE8bcUy2pJnE+V4sfRZl1phZ7zGRVUt
         47H4+0nBIDEzKY1ZLx/++3ZRUAfcLZk1qtWgN0vKSSHm/oolqT8nmdMjATBcA8yzzkpg
         eSXc9LM9hKPbRaB4MvzBmGKpP68y9/ssI7DfipoYdAZJVAzmcStzvoQyuwV7HiavS2iY
         mC+AqFtNAMx8CaUdKKvOYx0UwG3YYkaCJWClvzGY3wc/wKzrJQRdi9qOMwFJUkJf8SrN
         ZE8Q7+aFlBvl3Ka61kchzLyJco3HlaHqOuO+RyVoAMeu7ni1gkepScKQrQKZWxv+kVig
         J4Sg==
X-Gm-Message-State: AOJu0Yy+H7Lh9fz3wGJCLREFsbd8IURVkUK5FgJ0v2jkUIIxxHz8E/BQ
	jHw/7jzERQzV+u5nmiTD+VA/SNbThruO998LnUAsjYMetJqVgiDqLCzyNXu5zCDAXDOZXNQtb5o
	1CJuc7i0J+sGsviFp/MkP2nBs0p8=
X-Google-Smtp-Source: AGHT+IEvciuTAz7cP1AZii3VI6QX41SzZSonkpFgyaVYcTd40uFwJp9AsXjMXswIZ4uXba1c7cffYZRy0BjqyghQM54=
X-Received: by 2002:a2e:be9b:0:b0:2f6:62c3:4e0e with SMTP id
 38308e7fff4ca-2faf3bfee3bmr17259301fa.6.1728054086340; Fri, 04 Oct 2024
 08:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004123523.1012743-1-vlad.pruteanu@nxp.com> <20241004123523.1012743-5-vlad.pruteanu@nxp.com>
In-Reply-To: <20241004123523.1012743-5-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Oct 2024 11:01:13 -0400
Message-ID: <CABBYNZLpYe40jcS5a-wAR+JNy4cp0rCZHsHyiUVoBvEvacUP2A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/9] transport: Trigger transport release when
 syncing to multiple BISes
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Fri, Oct 4, 2024 at 8:35=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.com=
> wrote:
>
> In order to sync to multiple BISes from the same BIG, the existing
> sync must be destroyed and a new one created. This is accomplished
> by prompting the audio server to release the existing, active,
> transports (by moving them to the IDLE state). They will later be
> identified by the RELEASING state of their streams and the process
> for reacquirement (along with the new transport) will begin.
> ---
>  profiles/audio/transport.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index caa7287db..e68695c39 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -1366,6 +1366,7 @@ static DBusMessage *select_transport(DBusConnection=
 *conn, DBusMessage *msg,
>                                         void *data)
>  {
>         struct media_transport *transport =3D data;
> +       GSList *l;
>
>         if (transport->owner !=3D NULL)
>                 return btd_error_not_authorized(msg);
> @@ -1375,6 +1376,29 @@ static DBusMessage *select_transport(DBusConnectio=
n *conn, DBusMessage *msg,
>
>         if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
>                                                 BAA_SERVICE_UUID)) {
> +               /* Check if there are any ACTIVE transports, from the sam=
e
> +                * device. If there are, it means that this is a request =
to add
> +                * a new BIS to the active BIG sync. This is done by rele=
asing
> +                * the ACTIVE transports, and then reaquiring them along =
with
> +                * the new transport that needs to be added to the sync. =
To
> +                * release the transports, bt_bap_stream_release is calle=
d,
> +                * which will set the stream's state to
> +                * BT_BAP_STREAM_STATE_RELEASING. On bap_state_changed, t=
his
> +                * will be detected and transport_update_playing will be =
called,
> +                * with playing set to FALSE. This will move the transpor=
t to
> +                * IDLE, prompting the audio server to release it.
> +                */
> +               for (l =3D transports; l; l =3D g_slist_next(l)) {
> +                       struct media_transport *tr =3D l->data;
> +                       struct bap_transport *bap_temp =3D tr->data;
> +
> +                       if (tr->device =3D=3D transport->device &&
> +                                       tr->state =3D=3D TRANSPORT_STATE_=
ACTIVE) {
> +                               bt_bap_stream_release(bap_temp->stream,
> +                                                               NULL, NUL=
L);
> +                       }
> +               }

This seems a little counter intuitive, I don't think we should allow,
at least not by default, to sync BIS(s) one by one otherwise on every
select we would then need to do the release/reacquire logic that you
are proposing, instead what we should probably be doing is to list the
BIS(s) of the same BIG as Links:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.MediaTransport.rst=
#arrayobject-links-readonly-optional-iso-only-experimental

>                 transport_update_playing(transport, TRUE);
>         }
>
> @@ -1385,9 +1409,22 @@ static DBusMessage *unselect_transport(DBusConnect=
ion *conn, DBusMessage *msg,
>                                         void *data)
>  {
>         struct media_transport *transport =3D data;
> +       GSList *l;
>
>         if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
>                                                 BAA_SERVICE_UUID)) {
> +               for (l =3D transports; l; l =3D g_slist_next(l)) {
> +                       struct media_transport *tr =3D l->data;
> +                       struct bap_transport *bap_temp =3D tr->data;
> +
> +                       if (tr->device =3D=3D transport->device &&
> +                                       tr->state =3D=3D TRANSPORT_STATE_=
ACTIVE  &&
> +                               tr !=3D transport) {
> +                               bt_bap_stream_release(bap_temp->stream,
> +                                                               NULL, NUL=
L);
> +                       }
> +               }
> +
>                 transport_update_playing(transport, FALSE);
>         }
>
> @@ -1768,6 +1805,10 @@ static void bap_state_changed(struct bt_bap_stream=
 *stream, uint8_t old_state,
>                         bap_update_bcast_qos(transport);
>                 break;
>         case BT_BAP_STREAM_STATE_RELEASING:
> +               if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SOUR=
CE) {
> +                       transport_update_playing(transport, FALSE);
> +                       return;
> +               }
>                 if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST_SINK=
)
>                         return;
>                 break;
> --
> 2.40.1
>


--=20
Luiz Augusto von Dentz
