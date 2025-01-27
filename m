Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D838DD8
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990967; cv=none; b=SOB0kG8/AQm7ryIusuJQxQ3d5sov9NN8JUeJj5a8zsP1L5++eEzh51Ea2+kh95SVxiDQ2+5l5vvH3NLpAujHQZq0iplBX0b4xM0OSXU+3xVfSF3bNlElx8cEmdIhrMNX5dEujLvSfUW4Q8POPqWQQfmYP9BdAIMryLcfrNk494I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990967; c=relaxed/simple;
	bh=bH1thGd1K5aTMVqLdmDAtFS22ORQ47EQSVI3usCjvWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isCSP2p+0eh6tV8h6sSnPbcy7mj9+4AqSuUJnOfxkOFSoqRpnY2zvYo0TWCSpWqUF3eSwvelxXELcQp4cYvQ3cAozQSgU5yGioc1pNKfwOX9NY1D1nnuPhzyvomgFKX40u2xKOtaG32E/Ep33LxsmW7204+0EJKRaEHEDM35Jrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOscTEms; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOscTEms"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3072f8dc069so49270911fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 07:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990964; x=1738595764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMP97u0qPkZJMkDQpxgbbR4M3M2wiSiWD6CmOkZ+P9g=;
        b=kOscTEmsOPkxGZtzZlnbKZmQoD48nDUs48kNHrHNmNuUemrzXU8ii1cPhDsqG0eJ/T
         OBC6mTLWKZ5gL9hDSaEjy124ovvi/TKeWypo3XkbdyXLOoV9zYPdKkAnsh0czYA2LR9X
         NRkzg706cwjTPFkKKiIDVItFmi5CagdWP6EamaW6tETM/JduXRtI2Z+l/zc5n/oy4azS
         MrArkNgzUsjssirBE8L48ECMtgHl9p1tD3Y1Vr70gJ689SI7BcDuPLA01H/nV4HziipW
         Z7+mOqM4vmVZkxmbPMBjL6Dmb4Az4VWxR43Fjo9dNr9qx05JbzFFWyFgoEXkN9foxpei
         BZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990964; x=1738595764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMP97u0qPkZJMkDQpxgbbR4M3M2wiSiWD6CmOkZ+P9g=;
        b=Lp5md+uFhPJNla8NohJyoG1Idd++J4NVBV1lbNF4GWtJvX6KkdIWZh8L1ciioBRMj0
         ZEpa7ZTNDh7HJPp13Jj6Em/NY1bE+HBSgoddrbpySkwX+UIN9c6y4gGfoz4s82l+JfIq
         6T4/M40m1kh3uLc6+Ypo0iUsbiB64Q6zBdvr1S7b+aGljhKtftz1oe+iTEht1WaqXnM2
         tb9vza4Astx59NRBcJ4vvj7tEH9Ps+WCvzXSisFc11nYz1oZF7HN8Rz+P5Fc7AnoRUcR
         qAD53QnEX9Nz1TDCMyOS8VoB5PPeJPiVjXOVcx8TCcU9SGvCTu3l//k/xxxfaddAm6hE
         3GsA==
X-Gm-Message-State: AOJu0YzDILXpewvrqxK9tQJVYqacQ31cAsp0PRcAfnrM+8HEObSP1HaN
	jebLbXcRJZbrETRo9FeGVQozXlKJwPa2g+rKnIr09U8bv2J+rbY1wEiritHjxCXXk5LLopnKgyK
	odZaYco6HhE+XAVB6wH3B/LkpHRYkdEVA
X-Gm-Gg: ASbGncuXEv3NwHSjsRa5C/0MhtcM5l8Wk5n9CDwL+CeuPDCmXq5IMFwURT+0Rf0GupL
	I+9uFrC9vDX/1ri6OJL/L0mopcyPijnn6ICcI2qipsKxWUrxw2HqSqhmCFSgvrEI=
X-Google-Smtp-Source: AGHT+IGJ82bm21U/DYoeJs0IkBRTYz1d+w/0gJ487Bbi/R5Z2lm/kM04wWlbJofkLDBJsxjbDWQXxEK5XcYdSdxbgWg=
X-Received: by 2002:a05:651c:b27:b0:2ff:c86b:5b4f with SMTP id
 38308e7fff4ca-3072ca9c953mr157792061fa.21.1737990963604; Mon, 27 Jan 2025
 07:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06f0a1ed2fc2726b8dd46eef113e07ad742048c1.1737921917.git.pav@iki.fi>
In-Reply-To: <06f0a1ed2fc2726b8dd46eef113e07ad742048c1.1737921917.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jan 2025 10:15:50 -0500
X-Gm-Features: AWEUYZmJvKlIzUrWADT5V3JCZwvA8gQx7rgfaKq3OwfweGVYtZBgKxuzx1_nqVs
Message-ID: <CABBYNZLSae6QHGAcjTrM6n9kkRJD1tG4n5Vp=L-5xuwaHLyu5w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] shared/vcp: have only one volume change in
 flight at a time
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, Jan 26, 2025 at 3:09=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> If bt_vcp_set_volume() is called again before the previous operation has
> completed, the requests get the same change counter, and all except the
> first one fail.
>
> Fix by sending another volume set request only after the previous has
> either failed or generated a volume notification.
>
> Send only volume requests that change the value to a different one than
> last notification we have seen: in this case the request either fails,
> or succeeds and generates a new notification.  In all these cases, we
> exit the wait state correctly.
> ---
>
> Notes:
>     v2: reset pending_ops when attaching, needs to be cleared on reconnec=
t
>
>  src/shared/vcp.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> index 6b0f2f9db..2b5d186b8 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -203,6 +203,9 @@ struct bt_vcp {
>         uint8_t volume;
>         uint8_t volume_counter;
>
> +       uint8_t pending_volume;
> +       unsigned int pending_ops;
> +
>         void *debug_data;
>         void *user_data;
>  };
> @@ -2003,6 +2006,19 @@ done:
>         return vcp;
>  }
>
> +static void vcp_set_pending_volume(struct bt_vcp *vcp)
> +{
> +       /* Send pending request if any */
> +       if (vcp->pending_ops <=3D 1) {

Not following you here, why are you skipping peding_ops =3D=3D 1? Or 1
means the current one? Perhaps a comment would help here.

> +               vcp->pending_ops =3D 0;
> +               return;
> +       }
> +       vcp->pending_ops =3D 0;
> +
> +       DBG(vcp, "set pending volume 0x%x", vcp->pending_volume);
> +       bt_vcp_set_volume(vcp, vcp->pending_volume);
> +}
> +
>  static void vcp_vstate_notify(struct bt_vcp *vcp, uint16_t value_handle,
>                                 const uint8_t *value, uint16_t length,
>                                 void *user_data)
> @@ -2020,6 +2036,8 @@ static void vcp_vstate_notify(struct bt_vcp *vcp, u=
int16_t value_handle,
>
>         if (vcp->volume_changed)
>                 vcp->volume_changed(vcp, vcp->volume);
> +
> +       vcp_set_pending_volume(vcp);
>  }
>
>  static void vcp_volume_cp_sent(bool success, uint8_t err, void *user_dat=
a)
> @@ -2031,6 +2049,8 @@ static void vcp_volume_cp_sent(bool success, uint8_=
t err, void *user_data)
>                         DBG(vcp, "setting volume failed: invalid counter"=
);
>                 else
>                         DBG(vcp, "setting volume failed: error 0x%x", err=
);
> +
> +               vcp_set_pending_volume(vcp);
>         }
>  }
>
> @@ -2061,9 +2081,20 @@ static bool vcp_set_volume_client(struct bt_vcp *v=
cp, uint8_t volume)
>                 return false;
>         }
>
> -       vcp->volume =3D volume;
> +       vcp->pending_volume =3D volume;

Interesting, so the design is that we update the pending_volume so
only the last value is sent, I guess that should work but I probably
leave a comment that is the intended behavior since otherwise one
could assume that all intermediate volume changes would be sent (which
is probably a waste o time when setting an absolute rather than
relative volume).

> +       if (vcp->pending_ops) {
> +               /* Wait for current operation to complete */
> +               vcp->pending_ops++;
> +               return true;

This seems to assume we always will receive a notification that
completes the volume change? Id consider putting a timeout associated
with the request in case the server doesn't generate a notification
for some reason then we should consider proceeding to the next
pending_volume or fail and abort setting it.

> +       } else if (vcp->volume =3D=3D vcp->pending_volume) {
> +               /* Do not set to current value, as that doesn't generate
> +                * a notification
> +                */
> +               return true;
> +       }
> +
>         req.op =3D BT_VCS_SET_ABSOLUTE_VOL;
> -       req.vol_set =3D vcp->volume;
> +       req.vol_set =3D vcp->pending_volume;
>         req.change_counter =3D vcp->volume_counter;
>
>         if (!bt_gatt_client_write_value(vcp->client, value_handle, (void =
*)&req,
> @@ -2072,6 +2103,8 @@ static bool vcp_set_volume_client(struct bt_vcp *vc=
p, uint8_t volume)
>                 DBG(vcp, "error writing volume");
>                 return false;
>         }
> +
> +       vcp->pending_ops++;
>         return true;
>  }
>
> @@ -2896,6 +2929,8 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_ga=
tt_client *client)
>         if (!vcp->client)
>                 return false;
>
> +       vcp->pending_ops =3D 0;
> +
>         bt_uuid16_create(&uuid, VCS_UUID);
>         gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vcs_service,=
 vcp);
>
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
