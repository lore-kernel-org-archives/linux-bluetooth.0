Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B21E1DE8
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742236992; cv=none; b=sPMaYMDrl8DUtakHKcuKzytwuZjtsQ43MNn0/AzFDQQ7aYu3QlGynTfmQmZg6mics/EXFlq+X8oNEkf9jMir4WeAZInVyjPCzes9TgRDjneEkJuY6MNpQmfI++S/VKv65lAHUi1oI3fgu4+Ny2eEnzcHFoGPl3j8thp+Zub+ExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742236992; c=relaxed/simple;
	bh=rZy267QVzaHrzj+oPQKhxmdhpRbsSMxH1LmcHiDH6gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEakUCmB/yY6kLtpOaqyXius8VtCZsbmn0hM5Iwtdb6okQHfznM8bnWSqpJ2l0amKCqXMuSPkz8Bhl4Vdi8/E2Y0dbtqnU20Ru4iVOahILBKwMbaunwizzBzkpGbBf/A2LkMKVRxqGFlw22nOBgDkIApVcVmQfk4f0gTrCcsMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fULqOcIa; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fULqOcIa"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30c461a45f8so40132211fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742236989; x=1742841789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA1wszRs5T2ouUUFQ9msDMkStJoUCbF75LIILyXvWtY=;
        b=fULqOcIaSsnohN3+Ion7N6NjOxz4fiRqIuKO4zbna1eif25Nk5nRxXUSt6KlV1B0Uh
         Y9lP3SFXRxzGdg+JZjfygqs8nABZO/AHX+pB9c3cEUupfUrADVf40qtIgvAu/PaBC+Qi
         onHZ2Kkfj+NVuPzLXYjxwcb75XfRUqW67UAhE/qKLM0srPNweVCbfrKdwoVRYUvGgDeP
         y//yhxgwdxrN6HCz98TZORVjOvlDsREajuusdhPTFJW1DXeU5yCG2VFF93xXp8uFUZSZ
         htgEmOyy6SFKhEGgWds065/xBKC7vX8nRvKcxFnWrOM7tDunkjB941H0FOEbW2jiZbVG
         83eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742236989; x=1742841789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA1wszRs5T2ouUUFQ9msDMkStJoUCbF75LIILyXvWtY=;
        b=R0kN5EmTurNEkPtMcwjoCfJDPRaVLu79BF7Z7Ct1TNiwyEZJbIPmHoFfez6fhmJElJ
         UkeTfqEFEXdQYSXAcgvy3oCR3mOcviaUPOytdQKj694Rz6vKRKpsusR0Fd746Ic7/zNO
         vqmpSIB0m68+XbmQf2dzBAJDOEAEtljayJDpb3y2Ljh4NUE2HIkpTMPS+A1+D1E15lBe
         qX58GFwRJMhF04nZhHoXrp4SWxXmLP2qoQjNsZGMt5AQfs9sWV9QR114iFoJaGkHlYsl
         0+XSryrpO8k/tDhtZ9bL9hEuEFpCPjziqt6DiKFEfsWz2groZGk2F8q0go59ybGh4kqX
         9SSg==
X-Gm-Message-State: AOJu0YxF9cAljaJ0ri9kTcDay2zLb7pM4qFbcwaLFyMUIYRwj0gxoMlC
	x/yPgctRHTUBPNRQ+8hw3cZudsTGUxvxI2V1BoTkWMSgnSt9IGCX7Qip8GFLbjtiuYZJ47SeP5i
	QG0LRGGrtEqWYx8Xhmj+UUSzngq48YJOmBYU=
X-Gm-Gg: ASbGnct6cRFA61Bo7DBCXJuSJFdY0evYxW4UQ3a5nxPduFUvTQFsF4/ArhI4oNVQ+ei
	0nFB/da4iEoBpE6zGij66vaKhLOyZaTF02KNe0c7QK9t7VFjLDpItH7fS+FYVuqaBohFiOXgNAC
	MJ9ZysbR4mZqzms+N2ACrSzJkTo9g1Y/hHHDU=
X-Google-Smtp-Source: AGHT+IHE0zw9Hjq+ZwCvQL/ad5w1C42jY4Qt61UuZ6/eSIWVCWnYrDkITZeW5F4+0VTs68YcIUIlysl1Y03171DjySA=
X-Received: by 2002:a2e:a78a:0:b0:30b:f006:3f5 with SMTP id
 38308e7fff4ca-30c4a8672acmr70799911fa.15.1742236988393; Mon, 17 Mar 2025
 11:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740844616.git.pav@iki.fi> <5aff62c90e7e313b42f28cbc3c8c81788f74c8ce.1740844616.git.pav@iki.fi>
In-Reply-To: <5aff62c90e7e313b42f28cbc3c8c81788f74c8ce.1740844616.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Mar 2025 14:42:56 -0400
X-Gm-Features: AQ5f1Jrty4U7c5o9Tj871rN5oPkapMcU50Yrp7wnqY9Zl7yJYS6ED9UiBEenMJM
Message-ID: <CABBYNZLmZW7HgWoAH0Catej4532A5=2BT2osz8f7K1wX84dR9w@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 3/9] bap: add and use chainable future abstraction
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 1, 2025 at 10:58=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Multi-part operations will need to postpone things like DBus replies
> until all parts are complete. Make this a bit simpler with a chainable
> future.
> ---
>  profiles/audio/bap.c | 136 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 105 insertions(+), 31 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 37168e58c..8b9b89c70 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -80,7 +80,7 @@ struct bap_setup {
>         struct iovec *metadata;
>         unsigned int id;
>         struct iovec *base;
> -       DBusMessage *msg;
> +       struct future *qos_done;
>         void (*destroy)(struct bap_setup *setup);
>  };
>
> @@ -114,6 +114,17 @@ struct bap_data {
>         void *user_data;
>  };
>
> +typedef void (*future_func_t)(int err, const char *err_msg, void *data);
> +
> +struct future {
> +       unsigned int step, steps;
> +       const char *name;
> +       future_func_t func;
> +       void *data;
> +       int err;
> +       const char *err_msg;
> +};

This I'm not convinced is the right direction, it will be sort of hard
to make it generic enough besides I think this should actually be
handled directly by bt_bap instead, it is actually weird that the
testing spec doesn't capture stream reconfiguration from streaming
state for example, in any case we can come up with our on tests for it
to ensure the stream is properly released and CIS is closed before we
attempt reconfigure it for example.

>  static struct queue *sessions;
>
>  /* Structure holding the parameters for Periodic Advertisement create sy=
nc.
> @@ -155,6 +166,94 @@ struct bt_iso_qos bap_sink_pa_qos =3D {
>         }
>  };
>
> +static void future_clear(struct future **p, int err, const char *err_msg=
)
> +{
> +       struct future *h =3D *p;
> +
> +       if (!h)
> +               return;
> +
> +       DBG("future %p (%s) 0x%02x (%s) step %u/%u", h, h->name ? h->name=
 : "",
> +               err, (err && err_msg) ? err_msg : "", h->step + 1, h->ste=
ps);
> +
> +       *p =3D NULL;
> +
> +       if (err && !h->err) {
> +               h->err =3D err;
> +               h->err_msg =3D err_msg;
> +       }
> +
> +       if (++h->step < h->steps)
> +               return;
> +
> +       h->func(h->err, h->err_msg, h->data);
> +       free(h);
> +}
> +
> +static void future_dbus_callback_func(int err, const char *err_msg, void=
 *data)
> +{
> +       DBusMessage *msg =3D data;
> +       DBusMessage *reply;
> +
> +       if (err && !err_msg)
> +               err_msg =3D strerror(err);
> +
> +       switch (err) {
> +       case 0:
> +               reply =3D dbus_message_new_method_return(msg);
> +               break;
> +       case EINVAL:
> +               reply =3D btd_error_invalid_args_str(msg, err_msg);
> +               break;
> +       default:
> +               reply =3D btd_error_failed(msg, err_msg);
> +               break;
> +       }
> +
> +       g_dbus_send_message(btd_get_dbus_connection(), reply);
> +
> +       dbus_message_unref(msg);
> +}
> +
> +static void future_init(struct future **p, const char *name, future_func=
_t func,
> +                                                               void *dat=
a)
> +{
> +       struct future *h;
> +
> +       future_clear(p, ECANCELED, NULL);
> +
> +       h =3D new0(struct future, 1);
> +       h->steps =3D 1;
> +       h->name =3D name;
> +       h->func =3D func;
> +       h->data =3D data;
> +
> +       DBG("future %p (%s) init", h, h->name ? h->name : "");
> +
> +       *p =3D h;
> +}
> +
> +static void future_init_dbus_reply(struct future **p, const char *name,
> +                                                       DBusMessage *msg)
> +{
> +       future_init(p, name, future_dbus_callback_func, dbus_message_ref(=
msg));
> +}
> +
> +__attribute__((unused))
> +static void future_init_chain(struct future **p, struct future *h)
> +{
> +       future_clear(p, ECANCELED, NULL);
> +
> +       if (h) {
> +               h->steps++;
> +
> +               DBG("future %p (%s) init step %u", h, h->name ? h->name :=
 "",
> +                                                               h->steps)=
;
> +       }
> +
> +       *p =3D h;
> +}
> +
>  static bool bap_data_set_user_data(struct bap_data *data, void *user_dat=
a)
>  {
>         if (!data)
> @@ -740,24 +839,12 @@ static void qos_cb(struct bt_bap_stream *stream, ui=
nt8_t code, uint8_t reason,
>                                         void *user_data)
>  {
>         struct bap_setup *setup =3D user_data;
> -       DBusMessage *reply;
>
>         DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
>
>         setup->id =3D 0;
>
> -       if (!setup->msg)
> -               return;
> -
> -       if (!code)
> -               reply =3D dbus_message_new_method_return(setup->msg);
> -       else
> -               reply =3D btd_error_failed(setup->msg, "Unable to configu=
re");
> -
> -       g_dbus_send_message(btd_get_dbus_connection(), reply);
> -
> -       dbus_message_unref(setup->msg);
> -       setup->msg =3D NULL;
> +       future_clear(&setup->qos_done, code ? EIO : 0, "Unable to configu=
re");
>  }
>
>  static void config_cb(struct bt_bap_stream *stream,
> @@ -765,7 +852,6 @@ static void config_cb(struct bt_bap_stream *stream,
>                                         void *user_data)
>  {
>         struct bap_setup *setup =3D user_data;
> -       DBusMessage *reply;
>
>         DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
>
> @@ -786,14 +872,7 @@ static void config_cb(struct bt_bap_stream *stream,
>                 return;
>         }
>
> -       if (!setup->msg)
> -               return;
> -
> -       reply =3D btd_error_failed(setup->msg, "Unable to configure");
> -       g_dbus_send_message(btd_get_dbus_connection(), reply);
> -
> -       dbus_message_unref(setup->msg);
> -       setup->msg =3D NULL;
> +       future_clear(&setup->qos_done, EIO, "Unable to configure");
>  }
>
>  static void setup_io_close(void *data, void *user_data)
> @@ -872,7 +951,6 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
>  static void setup_free(void *data)
>  {
>         struct bap_setup *setup =3D data;
> -       DBusMessage *reply;
>
>         DBG("%p", setup);
>
> @@ -881,12 +959,7 @@ static void setup_free(void *data)
>                 setup->id =3D 0;
>         }
>
> -       if (setup->msg) {
> -               reply =3D btd_error_failed(setup->msg, "Canceled");
> -               g_dbus_send_message(btd_get_dbus_connection(), reply);
> -               dbus_message_unref(setup->msg);
> -               setup->msg =3D NULL;
> -       }
> +       future_clear(&setup->qos_done, ECANCELED, NULL);
>
>         if (setup->ep)
>                 queue_remove(setup->ep->setups, setup);
> @@ -1038,7 +1111,8 @@ static DBusMessage *set_configuration(DBusConnectio=
n *conn, DBusMessage *msg,
>
>         switch (bt_bap_stream_get_type(setup->stream)) {
>         case BT_BAP_STREAM_TYPE_UCAST:
> -               setup->msg =3D dbus_message_ref(msg);
> +               future_init_dbus_reply(&setup->qos_done, "set_configurati=
on",
> +                                                                       m=
sg);
>                 break;
>         case BT_BAP_STREAM_TYPE_BCAST:
>                 /* No message sent over the air for broadcast */
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
