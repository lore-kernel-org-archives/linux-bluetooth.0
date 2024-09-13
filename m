Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073C36AF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243556; cv=none; b=Q5lK0vSRA6YLZMEgaQ7OWLzvLXXpFAyX47WpJPh9Nt7lqA17v8ky7Dzh4FLhvgDmBW7lldDrP+lN6KSRPYo6q7Or5rAeI7Xae6KX2UcbsdGxUOp3EqrovS0svo98ri4FKrTI+ZQevE0Vfco6kjKYeEgtyJFHFYna5HUVwcaP45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243556; c=relaxed/simple;
	bh=ERRwu6tYG5kW2/0ABN/z0BU+6X8HFWH8K6Xr6p7BL7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f337Z9P/DgQIW1i5sSdMAr3RvMTyTWHxtJuoZaWBIGLiYvT6MTPTB49w38Sbpj/KD2JXNeJQA+rJiKDILuHFnUC9TUv6HyRYt5ZusAPhi53Uty/a2D4AF2ljeSmOkuPzXxQ/DYeafgUcbZ6KQ1k9lrI3aKmVtCyt1Qzy9+IGVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsiohpD7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsiohpD7"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f74e613a10so17983651fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726243553; x=1726848353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAEhpFLOQ8mmeioPkZhQ5AeJBRdnB9yRxfIyAjmg2Q4=;
        b=JsiohpD7+vTPaEIG8yAPLkkcUi4nZCcsdLrKpNP6obdvb9rwtA4yZiczvLtdixSVcg
         ZEqYpPnznDt32lzXWtdZ0URdw5ncd6A+Gg4QQMSrSHLeS0TerU3DU4Z9JW2v3hj1HSnh
         acIrnQOJul3T8S+K5c/S1IEUH4LM3viFiIYQZddmLU0Qr4JgtjzkOfphegR5/O8odJWf
         ZOPXiDDzt8pvBxsefAutkncWTr2uSTXswPE+r0FCb/Lm8HSALJjTveGDbklZyhmKAs71
         dKIQ6ahVvl5HySkGMEp7SjEaASKpIZbnxswnNNCgIIjuFYTy18xHNqfM+6/cpoDxy9bP
         tWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726243553; x=1726848353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAEhpFLOQ8mmeioPkZhQ5AeJBRdnB9yRxfIyAjmg2Q4=;
        b=HGhfjdn+bW/JbCBueCMkxn7kLEA6Ph+WEnFEW68QnS0ZOB/u5EzqoAfoOboQwGYXik
         35fHgeD3AqszJppWu8dETzLgdMZTjXvtkWi/WjuhrDJ8cp+zjn6RGUUl0wrR2NaV3BFG
         8A6WoSLJq0yyJTVvNKdiKViIwbWZckyVztWRUIWV9dZNdLgN7jFeHeHkQBYpO0TCGF7J
         8nnz6V5djdV9+pB6o1EFZDbAR2fw/ox1TqdSObluRX/49XXG/hQ12rhKRQwFLiuLnLt8
         fZ56t3DGb7TCIvDYBDY+LBByEnD3eNodBjZUqgruAY/+I3d+qhbwOOj7L/05Q+8y/lN0
         Aw6w==
X-Gm-Message-State: AOJu0YwuS5WABAgdn4A/cL43cT5co9hSR8iT+i8VrtSK3SB/dGZzulfR
	oUOUanNZbNh2Q2Dkf2iix/HQfxwu/T0IZPD6ehxCnZFGuHeqyhyCAZR3vVQtb7TTJ/6qKywWlKw
	F3jtIKHqNO8N+ktYlQfdkAXuWVR0RRnKs
X-Google-Smtp-Source: AGHT+IFcPV/pAP90gZVj8LTfAceFJe2J47trTEVPp4OhV8cNmzBnctbsyvXEKRM9Cq90ezA1HFys0MOPsq2hgVSKuDo=
X-Received: by 2002:a05:651c:1505:b0:2ef:2422:dc21 with SMTP id
 38308e7fff4ca-2f791b66a93mr24866311fa.43.1726243552277; Fri, 13 Sep 2024
 09:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912174921.386856-1-frederic.danis@collabora.com> <20240912174921.386856-7-frederic.danis@collabora.com>
In-Reply-To: <20240912174921.386856-7-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Sep 2024 12:05:39 -0400
Message-ID: <CABBYNZ+e4Am88sD_Ss3KAaMV5R0RqwiKp_L=f9pFBpjf=9HK+A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 6/7] obexd: Add GetImage to bip-avrcp
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Thu, Sep 12, 2024 at 1:51=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Retrieves the image corresponding to the handle and the description,
> as one of the descriptions retrieved by GetImageProperties, and store
> it in a local file.
>
> If the "transform" property description exists it should be set
> to one of the value listed by GetImageProperties for this
> description.
> ---
>  obexd/client/bip-avrcp.c  | 155 ++++++++++++++++++++++++++++++++++++++
>  obexd/client/bip-common.c |  21 +++++-
>  obexd/client/bip-common.h |   5 ++
>  profiles/audio/avrcp.c    |  10 ++-
>  4 files changed, 186 insertions(+), 5 deletions(-)
>
> diff --git a/obexd/client/bip-avrcp.c b/obexd/client/bip-avrcp.c
> index 272a288b4..8f00ddf8d 100644
> --- a/obexd/client/bip-avrcp.c
> +++ b/obexd/client/bip-avrcp.c
> @@ -32,6 +32,14 @@
>  #define BIP_AVRCP_UUID "0000111A-0000-1000-8000-00805f9b34fb"
>
>  #define IMG_HANDLE_TAG  0x30
> +#define IMG_DESC_TAG    0x71
> +
> +#define EOL_CHARS "\n"
> +#define IMG_DESC_BEGIN "<image-descriptor version=3D\"1.0\">" EOL_CHARS
> +#define IMG_BEGIN "<image encoding=3D\"%s\" pixel=3D\"%s\""
> +#define IMG_TRANSFORM " transformation=3D\"%s\""
> +#define IMG_END "/>" EOL_CHARS
> +#define IMG_DESC_END "</image-descriptor>" EOL_CHARS
>
>  static DBusConnection *conn;
>
> @@ -175,11 +183,158 @@ fail:
>         return reply;
>  }
>
> +static gboolean parse_get_image_dict(DBusMessage *msg, char **path,
> +                                       char **handle, char **pixel,
> +                                       char **encoding, uint64_t *maxsiz=
e,
> +                                                       char **transform)
> +{
> +       DBusMessageIter iter, array;
> +
> +       DBG("");
> +
> +       *path =3D NULL;
> +       *handle =3D NULL;
> +       *pixel =3D NULL;
> +       *encoding =3D NULL;
> +       *transform =3D NULL;
> +
> +       dbus_message_iter_init(msg, &iter);
> +
> +       if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
> +               goto failed;
> +       dbus_message_iter_get_basic(&iter, path);
> +       *path =3D g_strdup(*path);
> +       if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
> +               goto failed;
> +       dbus_message_iter_next(&iter);
> +       dbus_message_iter_get_basic(&iter, handle);
> +       *handle =3D g_strdup(*handle);
> +       dbus_message_iter_next(&iter);
> +       if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY)
> +               goto failed;
> +
> +       dbus_message_iter_recurse(&iter, &array);
> +
> +       while (dbus_message_iter_get_arg_type(&array) =3D=3D DBUS_TYPE_DI=
CT_ENTRY) {
> +               DBusMessageIter entry, value;
> +               const char *key, *val;
> +
> +               dbus_message_iter_recurse(&array, &entry);
> +
> +               if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE=
_STRING)
> +                       return FALSE;
> +               dbus_message_iter_get_basic(&entry, &key);
> +               dbus_message_iter_next(&entry);
> +               dbus_message_iter_recurse(&entry, &value);
> +               switch (dbus_message_iter_get_arg_type(&value)) {
> +               case DBUS_TYPE_STRING:
> +                       dbus_message_iter_get_basic(&value, &val);
> +                       if (g_str_equal(key, "pixel")) {
> +                               if (!parse_pixel_range(val, NULL, NULL, N=
ULL))
> +                                       goto failed;
> +                               *pixel =3D g_strdup(val);
> +                       } else if (g_str_equal(key, "encoding")) {
> +                               if (!verify_encoding(val))
> +                                       goto failed;
> +                               *encoding =3D g_strdup(val);
> +                               if (*encoding =3D=3D NULL)
> +                                       goto failed;
> +                       } else if (g_str_equal(key, "transformation")) {
> +                               *transform =3D parse_transform(val);
> +                               if (*transform =3D=3D NULL)
> +                                       goto failed;
> +                       }
> +                       break;
> +               case DBUS_TYPE_UINT64:
> +                       if (g_str_equal(key, "maxsize") =3D=3D TRUE) {
> +                               dbus_message_iter_get_basic(&value, maxsi=
ze);
> +                               if (*maxsize =3D=3D 0)
> +                                       goto failed;
> +                       }
> +                       break;
> +               }
> +               dbus_message_iter_next(&array);
> +       }
> +
> +       if (*pixel =3D=3D NULL)
> +               *pixel =3D strdup("");
> +       if (*encoding =3D=3D NULL)
> +               *encoding =3D strdup("");
> +
> +       DBG("pixel: '%s' encoding: '%s' maxsize: '%lu' transform: '%s'",
> +                       *pixel, *encoding, *maxsize, *transform
> +       );
> +
> +       return TRUE;
> +failed:
> +       g_free(*path);
> +       g_free(*handle);
> +       g_free(*pixel);
> +       g_free(*encoding);
> +       g_free(*transform);
> +       return FALSE;
> +}
> +
> +static DBusMessage *get_image(DBusConnection *connection,
> +                                       DBusMessage *message, void *user_=
data)
> +{
> +       struct bip_avrcp_data *bip_avrcp =3D user_data;
> +       char *handle =3D NULL, *image_path =3D NULL, *transform =3D NULL,
> +               *encoding =3D NULL, *pixel =3D NULL;
> +       uint64_t maxsize;
> +       struct obc_transfer *transfer;
> +       GObexHeader *header;
> +       DBusMessage *reply =3D NULL;
> +       GString *descriptor =3D NULL;
> +       GError *err =3D NULL;
> +
> +       DBG("");
> +
> +       if (!parse_get_image_dict(message, &image_path, &handle, &pixel,
> +                                       &encoding, &maxsize, &transform))
> +               return g_dbus_create_error(message,
> +                               ERROR_INTERFACE ".InvalidArguments", NULL=
);
> +
> +       transfer =3D obc_transfer_get("x-bt/img-img", NULL, image_path, &=
err);
> +       if (transfer =3D=3D NULL)
> +               goto fail;
> +
> +       header =3D g_obex_header_new_unicode(IMG_HANDLE_TAG, handle);
> +       obc_transfer_add_header(transfer, header);
> +
> +       descriptor =3D g_string_new(IMG_DESC_BEGIN);
> +       g_string_append_printf(descriptor, IMG_BEGIN, encoding, pixel);
> +       if (transform !=3D NULL)
> +               g_string_append_printf(descriptor, IMG_TRANSFORM, transfo=
rm);
> +       g_string_append(descriptor, IMG_END);
> +       descriptor =3D g_string_append(descriptor, IMG_DESC_END);
> +       header =3D g_obex_header_new_bytes(IMG_DESC_TAG, descriptor->str,
> +                                               descriptor->len);
> +       obc_transfer_add_header(transfer, header);
> +       g_string_free(descriptor, TRUE);
> +
> +       if (!obc_session_queue(bip_avrcp->session, transfer, NULL, NULL, =
&err))
> +               goto fail;
> +
> +       return obc_transfer_create_dbus_reply(transfer, message);
> +
> +fail:
> +       reply =3D g_dbus_create_error(message, ERROR_INTERFACE ".Failed",=
 "%s",
> +                                                               err->mess=
age);
> +       g_error_free(err);
> +       return reply;
> +}
> +
>  static const GDBusMethodTable bip_avrcp_methods[] =3D {
>         { GDBUS_ASYNC_METHOD("GetImageProperties",
>                 GDBUS_ARGS({ "handle", "s"}),
>                 GDBUS_ARGS({ "properties", "aa{sv}" }),
>                 get_image_properties) },
> +       { GDBUS_ASYNC_METHOD("GetImage",
> +               GDBUS_ARGS({ "file", "s" }, { "handle", "s"},
> +                               {"properties", "a{sv}"}),
> +               GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }=
),
> +               get_image) },
>         { GDBUS_ASYNC_METHOD("GetImageThumbnail",
>                 GDBUS_ARGS({ "file", "s" }, { "handle", "s"}),
>                 GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }=
),
> diff --git a/obexd/client/bip-common.c b/obexd/client/bip-common.c
> index b93921df5..16a199977 100644
> --- a/obexd/client/bip-common.c
> +++ b/obexd/client/bip-common.c
> @@ -49,7 +49,7 @@ static const gchar *convBIP2IM(const gchar *encoding)
>         return NULL;
>  }
>
> -static gboolean parse_pixel_range(const gchar *dim, unsigned int *lower_=
ret,
> +gboolean parse_pixel_range(const gchar *dim, unsigned int *lower_ret,
>                                                 unsigned int *upper_ret,
>                                                 gboolean *fixed_ratio_ret=
)
>  {
> @@ -139,6 +139,18 @@ char *transforms[] =3D {
>         NULL
>  };
>
> +gboolean verify_encoding(const char *encoding)
> +{
> +       struct encconv_pair *et =3D encconv_table;
> +
> +       while (et->bip) {
> +               if (g_strcmp0(encoding, et->bip) =3D=3D 0)
> +                       return TRUE;
> +               et++;
> +       }
> +       return FALSE;
> +}
> +
>  static gboolean verify_transform(const char *transform)
>  {
>         char **str =3D transforms;
> @@ -151,6 +163,13 @@ static gboolean verify_transform(const char *transfo=
rm)
>         return FALSE;
>  }
>
> +char *parse_transform(const char *transform)
> +{
> +       if (!verify_transform(transform))
> +               return NULL;
> +       return g_strdup(transform);
> +}
> +
>  static char *parse_transform_list(const char *transform)
>  {
>         char **args =3D NULL, **arg =3D NULL;
> diff --git a/obexd/client/bip-common.h b/obexd/client/bip-common.h
> index 0fee54636..6e7aac375 100644
> --- a/obexd/client/bip-common.h
> +++ b/obexd/client/bip-common.h
> @@ -13,6 +13,11 @@
>
>  struct prop_object;
>
> +gboolean parse_pixel_range(const gchar *dim, unsigned int *lower_ret,
> +                                               unsigned int *upper_ret,
> +                                               gboolean *fixed_ratio_ret=
);
> +gboolean verify_encoding(const char *encoding);
> +char *parse_transform(const char *transform);
>  struct prop_object *parse_properties(char *data, unsigned int length,
>                                                         int *err);
>  gboolean verify_properties(struct prop_object *obj);
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index fe24b5a92..ee750f50b 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -415,10 +415,12 @@ static sdp_record_t *avrcp_ct_record(bool browsing)
>         uint16_t lp =3D AVCTP_CONTROL_PSM;
>         uint16_t avctp_ver =3D 0x0103;
>         uint16_t feat =3D ( AVRCP_FEATURE_CATEGORY_1 |
> -                                               AVRCP_FEATURE_CATEGORY_2 =
|
> -                                               AVRCP_FEATURE_CATEGORY_3 =
|
> -                                               AVRCP_FEATURE_CATEGORY_4 =
|
> -                                               AVRCP_FEATURE_CT_GET_THUM=
BNAIL);
> +                                       AVRCP_FEATURE_CATEGORY_2 |
> +                                       AVRCP_FEATURE_CATEGORY_3 |
> +                                       AVRCP_FEATURE_CATEGORY_4 |
> +                                       AVRCP_FEATURE_CT_GET_IMAGE_PROP |
> +                                       AVRCP_FEATURE_CT_GET_IMAGE |
> +                                       AVRCP_FEATURE_CT_GET_THUMBNAIL);

Changes to obexd and avrcp shall probably be split, also make sure the
versioning is proper, if I recall it correctly it was added on AVRCP
1.6 so we need to make sure that it is reflected correctly in the
record.

>         record =3D sdp_record_alloc();
>         if (!record)
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
