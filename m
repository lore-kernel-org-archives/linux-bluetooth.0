Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F93C8182
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927206; cv=pass; b=F1d2kjTLNDWOts/DUF1pdxKTsgzZqV9dqEyL7HR594mqd1zafH8kwggOGTqXXMY+PKidYPT5mKn66qAET6VPkU2afDqFGn/DdiT21ksWqvpV5vhud2EOHBKn/SK8nTnKr/W1k3cLylRKpxpp30M7qr725ocO8qsNfrjcEw9KM9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927206; c=relaxed/simple;
	bh=QYOrnrujC4Rlitn5TbvKRjmq17KSpHwZqEeIzS6AWYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/WCrnn/ujBl2qTQ6TJNhiCZLSbVJ4Dsm4eY+ZDTTSOvYq3B6sL59ZhSTpK8sOyLA2/MjPtCDwz+RO71mjhhUZcZZjOOUwfmungspfUsEeSClCxWcLyjQzL0wS7G0/Nevr+6LXAtAYY1bNd3MvMoTM3pGg/IbcutP6otFAprkXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOAVuyY9; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOAVuyY9"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6603d8697d2so4360286d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 07:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780927203; cv=none;
        d=google.com; s=arc-20240605;
        b=d/eScR0abwNYyfbcTaqiWGWdsWD21Sqj+ugD9KD1DTwz8QC44eFR2ng/qfbetzOQV1
         Qy2PdsmUM9Xbz46ZKcFXWMgdkywgU7+n9wwG9XqHzH9xhvB7Jic4ENcxgOixrt98eyO9
         qpmGrtkOneSVFy7XUIlcOw1zdaHjt0vzjrrC63exMkQWmZ5/93nClJ3sgknCzJ325cBG
         k4fW2DZWqJhzuZlA3P3bnENy5RklKFBGBU1BLB2y+Hk2NygSRaZvwV/6ibwxdpR9VSqk
         rSftjoOB6YfoYNCq9irthO3PvzUs9EQ+CKUYg/DpDfdmUZeGE/ZntHbCRlhUTOIcfqtx
         7QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PIbO9vvCboVxAbkJlUXo/GZlnW7kNuHvY7NgvhZ0DEk=;
        fh=tyq0gYhA4cMcqn+bWakZSAdnDDyh/si+tlAcgOGyoy0=;
        b=K8E+U8Ff7xuomGZLKCRFSMSbmMKse2HgHJ+1KvJ667iqbs6xnI2/PZva8Czmk+Eeeu
         31Cqt09SmwE8U3QknFtkon1HQ33hrfnt7oWN55lqX6F+622zBklnwjqI9SNaIAf+JCdN
         kHGOsn2WuPpKDbUPgEXRu9KY2hNez+0nupUV5npNe3pn/3aIvUY+crhN+HT1FgImwDPq
         Gmm8Ooo0ipO+A2q8gshf4oiOlryPzmcdVe2X/TdsD67or5Xz08a1Jie1AmoiyJsqJCPu
         w8OypkiWiFnrHYolh8oLYhbjkuJbPQ5fwgyxDguQOa3E6dIWUFhrbhSkbEVE/F9cTFR0
         XRtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780927203; x=1781532003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIbO9vvCboVxAbkJlUXo/GZlnW7kNuHvY7NgvhZ0DEk=;
        b=mOAVuyY9yC0Om6+CUVr0glpcD3y8o2yNtecRKGkVkhZJqVDdBb5y8COpYq7OZKcOkx
         6Q8uGU20secUpZ45DDmjJaokVZ77iwflG/fke7m9YdgPFhEwWQcbDfBUZ9Ug3Nt60IW0
         CjUlujmXIFk3959ko7gL7yC2m2W7tVneMzTpWB54aGL27wK0SnWTAWQcfPQcOLDZ0Fm0
         KP3SGea/q5ZDXZ6reI9q8BCjs+IrSCeXjzxoldMnrlwYdzjZxWQblRh3gDQXdiO/lhac
         yveL6aWYKemHiixciM+JbsCDLXOyHBf5EpO2UaHryJNwVR06XSFp3+zW3ENW/4NAUPHK
         BWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927203; x=1781532003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIbO9vvCboVxAbkJlUXo/GZlnW7kNuHvY7NgvhZ0DEk=;
        b=THcGfSA/6QfnuVLWWSueeJJfMPW/EXj6rEsuFVb/6MRQij49rvFRlgUcRudv06nQuC
         J9yc/D61unDYmvXeuPxdK/M4ZFobzAgoPRDtfDHWFjuADcW/jHIQHGg+rjmQhK7pSHrb
         ExRpjne3iXdown9NjbfeGr2GjS+9qOF4XoW5pY7WvBEbucQqJymN+NM7u6nP/wEWrhcl
         KPUJMnWVvA/dLPKT/ngHLeoV3hnuRfPfPpEQ35xl/t3Fg5+5BuRPgIglltaK17zrbBzs
         iy504HxI852VJ53rfiyyB0qng4dEqXSM3oWfA2lZrd+81QT3GZfqDNtV2NBZZhmrhotW
         kxAQ==
X-Gm-Message-State: AOJu0YzMCDZGZ9LDPDTddhe+uXkEYibxLKejmRVXcyZ5YRtLJ/O4krHx
	BZ53jykeJQ5oIXxc4Bj8WTp4a+joQM9TI/GjdQu0x8MRJr7anbBFA6hp5BkPbU5ATZ1iML7XrsC
	Kwn2265pElkwtBLCaTUs7gm60Drrm+7AyqSFCtkWgzQ==
X-Gm-Gg: Acq92OEWzQDP0OEeoi+yGhDTA+baz8Oa1kfkdVF8/bRwACgCibseykcVC3yx1wVfCNl
	uVkMd8mMbO9niUVxrlU1x4q08D0T4IizWX4c9f1AwNl9Msre7dkuI3DigGg745RVt3xCVxtSUzq
	VaBclXp97tDGyFpyoRMn1wky85OLO0m1rrxBz3lJL8z34rOWNxtLZ9X0vIL6BrOfBWIfJgKMpbh
	9TgoC+OMsNQYgT9LrbVPlvDHGul9lUO8x2YbMVzeghSFy5syMwNpUUoOxQTBBSCLax+8jCCKa0M
	o/X0S9jelc+OOZQf2nzqlPXlccRAUoh6vcKNUMLsSOXIDFY9HslyR9jQDGHGJQr6EOxHLqzUrpc
	spDJI
X-Received: by 2002:a05:690e:1448:b0:660:a41d:d180 with SMTP id
 956f58d0204a3-66106f255bfmr13527411d50.21.1780927203102; Mon, 08 Jun 2026
 07:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608121226.3727101-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260608121226.3727101-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jun 2026 09:59:50 -0400
X-Gm-Features: AVVi8CeOO4TRVkcnNpzA0K8B3Lj62fHwgxRhlmiuZkfhwgTI-LfeO3zBZTAm0rQ
Message-ID: <CABBYNZKkiRaDQFUrMp65=DF-37gBnSJ0H__bj-iA4Nx2Y=Yhkw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] avdtp: Add GetConfiguration DBus function
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Mon, Jun 8, 2026 at 8:15=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> Change avdtp_get_configuration to accept remote SEP instead of stream a
> and add an async callback for response/reject handling; the old function
> was not used anywhere (unit-test just copied signature), so it was
> changed in place.
>
> Add a GetConfiguration async D-Bus method to the remote SEP interface tha=
t
> returns the retrieved configuration as a byte array.
>
> This can be used to pass: AVDTP/SRC/INT/SIG/SMG/BV-11-C
> ---
>  profiles/audio/a2dp.c  | 63 ++++++++++++++++++++++++++++++++++
>  profiles/audio/avdtp.c | 76 ++++++++++++++++++++++++++++++++++++++++--
>  profiles/audio/avdtp.h |  9 ++++-
>  3 files changed, 144 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index c7e0fc75c..8dcf510ca 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -2168,11 +2168,74 @@ static DBusMessage *set_configuration(DBusConnect=
ion *conn, DBusMessage *msg,
>         return NULL;
>  }
>
> +static void get_configuration_cb(struct avdtp *session, GSList *caps,
> +                               struct avdtp_error *err, void *user_data)
> +{
> +       DBusMessage *msg =3D user_data;
> +       DBusMessage *reply;
> +       DBusMessageIter iter, array;
> +       GSList *l;
> +
> +       if (err) {
> +               reply =3D btd_error_failed(msg, "GetConfiguration rejecte=
d");
> +               goto done;
> +       }
> +
> +       reply =3D dbus_message_new_method_return(msg);
> +
> +       dbus_message_iter_init_append(reply, &iter);
> +       dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +                                       DBUS_TYPE_BYTE_AS_STRING, &array)=
;
> +
> +       for (l =3D caps; l; l =3D g_slist_next(l)) {
> +               struct avdtp_service_capability *cap =3D l->data;
> +               uint8_t *ptr =3D (uint8_t *) cap;
> +               int i;
> +
> +               for (i =3D 0; i < cap->length + 2; i++)
> +                       dbus_message_iter_append_basic(&array,
> +                                                       DBUS_TYPE_BYTE,
> +                                                       &ptr[i]);
> +       }
> +
> +       dbus_message_iter_close_container(&iter, &array);
> +
> +done:
> +       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +       dbus_message_unref(msg);
> +       g_slist_free_full(caps, g_free);
> +}
> +
> +static DBusMessage *get_configuration(DBusConnection *conn,
> +                                               DBusMessage *msg, void *d=
ata)
> +{
> +       struct a2dp_remote_sep *rsep =3D data;
> +       struct a2dp_channel *chan =3D rsep->chan;
> +       int err;
> +
> +       if (chan->session =3D=3D NULL)
> +               return btd_error_not_available(msg);
> +
> +       err =3D avdtp_get_configuration(chan->session, rsep->sep,
> +                                       get_configuration_cb,
> +                                       dbus_message_ref(msg));
> +       if (err < 0) {
> +               dbus_message_unref(msg);
> +               return btd_error_failed(msg, strerror(-err));
> +       }
> +
> +       return NULL;
> +}
> +
>  static const GDBusMethodTable sep_methods[] =3D {
>         { GDBUS_ASYNC_METHOD("SetConfiguration",
>                                         GDBUS_ARGS({ "endpoint", "o" },
>                                                 { "properties", "a{sv}" }=
 ),
>                                         NULL, set_configuration) },
> +       { GDBUS_ASYNC_METHOD("GetConfiguration",
> +                                       NULL,
> +                                       GDBUS_ARGS({ "configuration", "ay=
" }),
> +                                       get_configuration) },

The configuration is already exposed via MediaTransport properties:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.MediaTransport.rst=
#arraybyte-configuration-readonly

So if this is only to satisfy PTS, maybe it should be hidden behind
main.conf:Testing, that said we do have a dedicated tool for passing
PTS testing, avdtptest, and if you had grepped for
AVDTP/SRC/INT/SIG/SMG/BV-11-C you would have found it is documented in
avdtp-pts.rst:

https://github.com/bluez/bluez/blob/7a0c8ebf91e69c3b2d2d48f8f4b0074fddde1fa=
4/doc/qualification/avdtp-pts.rst#L258

>         { },
>  };
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index d475a545e..5f0424c81 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -348,6 +348,11 @@ struct discover_callback {
>         void *user_data;
>  };
>
> +struct getconf_callback {
> +       avdtp_get_configuration_cb_t cb;
> +       void *user_data;
> +};
> +
>  struct avdtp_stream {
>         GIOChannel *io;
>         uint16_t imtu;
> @@ -406,6 +411,7 @@ struct avdtp {
>         char *buf;
>
>         struct discover_callback *discover;
> +       struct getconf_callback *getconf;
>         struct pending_req *req;
>
>         unsigned int dc_timer;
> @@ -1093,6 +1099,24 @@ static void finalize_discovery(struct avdtp *sessi=
on, int err)
>         session->discover =3D NULL;
>  }
>
> +static void finalize_getconf(struct avdtp *session, int err)
> +{
> +       struct getconf_callback *getconf =3D session->getconf;
> +       struct avdtp_error avdtp_err;
> +
> +       if (!getconf)
> +               return;
> +
> +       session->getconf =3D NULL;
> +
> +       avdtp_error_init(&avdtp_err, AVDTP_ERRNO, err);
> +
> +       if (getconf->cb)
> +               getconf->cb(session, NULL, &avdtp_err, getconf->user_data=
);
> +
> +       g_free(getconf);
> +}
> +
>  static void release_stream(struct avdtp_stream *stream, struct avdtp *se=
ssion)
>  {
>         struct avdtp_local_sep *sep =3D stream->lsep;
> @@ -1144,6 +1168,7 @@ static void avdtp_free(void *data)
>         g_slist_free_full(session->seps, sep_free);
>
>         g_free(session->buf);
> +       g_free(session->getconf);
>
>         btd_device_unref(session->device);
>         g_free(session);
> @@ -1162,6 +1187,7 @@ static void connection_lost(struct avdtp *session, =
int err)
>         session->streams =3D NULL;
>
>         finalize_discovery(session, err);
> +       finalize_getconf(session, err);
>
>         avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
>
> @@ -3008,6 +3034,20 @@ static gboolean avdtp_parse_resp(struct avdtp *ses=
sion,
>                                 next->signal_id =3D=3D AVDTP_GET_ALL_CAPA=
BILITIES)))
>                         finalize_discovery(session, 0);
>                 return TRUE;
> +       case AVDTP_GET_CONFIGURATION:
> +               DBG("GET_CONFIGURATION request succeeded");
> +               if (session->getconf) {
> +                       struct getconf_callback *cb =3D session->getconf;
> +                       GSList *caps;
> +
> +                       session->getconf =3D NULL;
> +                       caps =3D caps_to_list(((struct getcap_resp *) buf=
)->caps,
> +                                       size - sizeof(struct getcap_resp)=
,
> +                                       NULL, NULL, NULL);
> +                       cb->cb(session, caps, NULL, cb->user_data);
> +                       g_free(cb);
> +               }
> +               return TRUE;
>         }
>
>         /* The remaining commands require an existing stream so bail out
> @@ -3115,6 +3155,19 @@ static gboolean avdtp_parse_rej(struct avdtp *sess=
ion,
>                 error("GET_CAPABILITIES request rejected: %s (%d)",
>                                 avdtp_strerror(&err), err.err.error_code)=
;
>                 return TRUE;
> +       case AVDTP_GET_CONFIGURATION:
> +               if (!seid_rej_to_err(buf, size, &err))
> +                       return FALSE;
> +               error("GET_CONFIGURATION request rejected: %s (%d)",
> +                               avdtp_strerror(&err), err.err.error_code)=
;
> +               if (session->getconf) {
> +                       struct getconf_callback *cb =3D session->getconf;
> +
> +                       session->getconf =3D NULL;
> +                       cb->cb(session, NULL, &err, cb->user_data);
> +                       g_free(cb);
> +               }
> +               return TRUE;
>         case AVDTP_OPEN:
>                 if (!seid_rej_to_err(buf, size, &err))
>                         return FALSE;
> @@ -3536,18 +3589,35 @@ unsigned int avdtp_stream_add_cb(struct avdtp *se=
ssion,
>         return stream_cb->id;
>  }
>
> -int avdtp_get_configuration(struct avdtp *session, struct avdtp_stream *=
stream)
> +int avdtp_get_configuration(struct avdtp *session,
> +                                       struct avdtp_remote_sep *rsep,
> +                                       avdtp_get_configuration_cb_t cb,
> +                                       void *user_data)
>  {
>         struct seid_req req;
> +       int err;
>
>         if (session->state < AVDTP_SESSION_STATE_CONNECTED)
>                 return -EINVAL;
>
> +       if (session->getconf)
> +               return -EBUSY;
> +
>         memset(&req, 0, sizeof(req));
> -       req.acp_seid =3D stream->rseid;
> +       req.acp_seid =3D rsep->seid;
>
> -       return send_request(session, FALSE, stream, AVDTP_GET_CONFIGURATI=
ON,
> +       err =3D send_request(session, FALSE, NULL, AVDTP_GET_CONFIGURATIO=
N,
>                                                         &req, sizeof(req)=
);
> +       if (err < 0)
> +               return err;
> +
> +       if (cb) {
> +               session->getconf =3D g_new0(struct getconf_callback, 1);
> +               session->getconf->cb =3D cb;
> +               session->getconf->user_data =3D user_data;
> +       }
> +
> +       return 0;
>  }
>
>  static void copy_capabilities(gpointer data, gpointer user_data)
> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> index 10c8f496b..45c54086f 100644
> --- a/profiles/audio/avdtp.h
> +++ b/profiles/audio/avdtp.h
> @@ -267,8 +267,15 @@ int avdtp_set_configuration(struct avdtp *session,
>                                 GSList *caps,
>                                 struct avdtp_stream **stream);
>
> +typedef void (*avdtp_get_configuration_cb_t)(struct avdtp *session,
> +                                               GSList *caps,
> +                                               struct avdtp_error *err,
> +                                               void *user_data);
> +
>  int avdtp_get_configuration(struct avdtp *session,
> -                               struct avdtp_stream *stream);
> +                               struct avdtp_remote_sep *rsep,
> +                               avdtp_get_configuration_cb_t cb,
> +                               void *user_data);
>
>  int avdtp_open(struct avdtp *session, struct avdtp_stream *stream);
>  int avdtp_start(struct avdtp *session, struct avdtp_stream *stream);
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
