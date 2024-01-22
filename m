Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1F3FE5F
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947209; cv=none; b=WwFjQxi2ykui7WEhGgpRQ0YEbtt/t42/6xwSH60TrSJmxgkiB/EF7pQ9JLKMt9nG8C57OO+7qEB9l7o0NfEkHG71zldmkPhoy6IXSrwyj+6Qe2Bf6GOUysrT/RGciViNaOa1+XJFMo7nG7EvwkRcTeDgfHuX00LW2fl/pTMnMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947209; c=relaxed/simple;
	bh=X/MWVapnKECPrOFuewnARLQy7ZWpWMWoYpLeGXJjVIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XL170zd4IVqF2Pudosi8sirTSltDfVdn+PnAm7aXG/HhHrcJiaJOuymeYzFWYuUzhOmmHicdxRQi+yswomDA2MV/e5Xm2Tlv1m1HwzLrQU5g9Dxn0G70mIRnCd16oTGByEvbEAMOTLsHYp/Pjxe9nRkNrbBIxBF4d5ta+CjoqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws1Eyn3s; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws1Eyn3s"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cdb50d8982so38624501fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 10:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705947206; x=1706552006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyKWO9+64HdZEWzzhZ51lUvRiV4++MPt40wyIuE7Pf4=;
        b=Ws1Eyn3swwBoqvVDacY/XTg3pf0MJ4rSK3UydRCS2Nr+8hercTl/rfkbQPOay2jXkz
         O++uCJHSFhlNBWUV21o4vdMXgw7iC+ogSjBg4L/QrGF1z0y4j04Wx1HBotFLE2UFLBo0
         t459OOShgaeK4BqKKX+B21SToot8Yzb2xxeZSYKEZKJ8gNO8gAzaTpck3sBvOo/d3z8O
         vtkxnzV7GJhSNWx1V36wvyKPqC2aC2YbaQBRhOOAXyC5kwufSVOu+/alzHiLtNch5Q0p
         3LHTu75vggZ5NEDSUL0g4VtjEk3tfwtZTS2SZG6+M4WgEB2rfznMukba8pxUgvYY2Wmr
         0qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947206; x=1706552006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyKWO9+64HdZEWzzhZ51lUvRiV4++MPt40wyIuE7Pf4=;
        b=qo+iBF0QJw8yaRKZ6cs6PtyGNN1u1seftks42D2j/oKRwStcC804qCo0sgrKea1pOr
         hrS90b5/zjXsNfCaZGajaBfZnc4gttcbB8P4Moy/abykumWnSXRhFlTi6nCotIlH2OTO
         4nd/6FeIMfA/3AIsD3uM5PKEr6+0Gy4i+T7llF88+qY+5ozThpF+6VM5Ufn6Z3TESjd6
         XG1GVUaDpO8Xtc9W0xH+s5WOCxjupm+NV6g/R9kI9pGWeaI0q0BOri6VgGZmX0dwprVI
         YUfYWWnZU2EbyguGZ4G1BTKA/8K3q1yBEaXGhMwZi9slz9Q1nsSpROCPxXBLN8Ph//3j
         6pPw==
X-Gm-Message-State: AOJu0YxsrUvNkEVk3mmxbAHpohlxcztTzeOkqCgdy8/khI2bu64If8dh
	/K8xjrdP//9WHBt5veT24rkV0V8DDwXNUtzRO83elNJjahmIlNNa+q8Bx1Bx62OlnzahOCxewYB
	dDpd0Oxf5b2NfG0vhEzCtdj0X8sA2CsKR
X-Google-Smtp-Source: AGHT+IFWkL8fLv3N2KBHeUW2EdcqJKYkYYv/fvRQ/AfrICOtIXtA8VvhYeYX9wIAXnnPy/EyQ6X8MXeo0hVMhLUrxCM=
X-Received: by 2002:a2e:a416:0:b0:2cd:ebed:27e1 with SMTP id
 p22-20020a2ea416000000b002cdebed27e1mr1854161ljn.81.1705947205556; Mon, 22
 Jan 2024 10:13:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122165000.279381-1-frederic.danis@collabora.com> <20240122165000.279381-2-frederic.danis@collabora.com>
In-Reply-To: <20240122165000.279381-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2024 13:13:12 -0500
Message-ID: <CABBYNZJ3Wfdhf5fU6hLSZh1Sz0zZHr_Gf5anMqOyW+CoMedOow@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] gatt: Prevent security level change for PTS
 GATT tests
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Jan 22, 2024 at 12:43=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Some PTS GATT tests like GATT/CL/GAR/BI-04-C request to be able to get th=
e
> security error and do not try to change the security level.
>
> this commit adds a variable allowing to prevent to change the security
> level.
> ---
>  src/shared/att.c         | 14 ++++++++++++++
>  src/shared/att.h         |  1 +
>  src/shared/gatt-client.c |  9 +++++++++
>  src/shared/gatt-client.h |  2 ++
>  tools/btgatt-client.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 64 insertions(+)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 62c884b65..decc24314 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -87,6 +87,8 @@ struct bt_att {
>
>         struct sign_info *local_sign;
>         struct sign_info *remote_sign;
> +
> +       bool retry_on_sec_error;

Id use something like auto_retry, or perhaps just use
att_send_op->retry instead.

>  };
>
>  struct sign_info {
> @@ -786,6 +788,9 @@ static bool handle_error_rsp(struct bt_att_chan *chan=
, uint8_t *pdu,
>
>         *opcode =3D rsp->opcode;
>
> +       if (!att->retry_on_sec_error)
> +               return false;
> +
>         /* If operation has already been marked as retry don't attempt to=
 change
>          * the security again.
>          */
> @@ -1262,6 +1267,7 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
>         att =3D new0(struct bt_att, 1);
>         att->chans =3D queue_new();
>         att->mtu =3D chan->mtu;
> +       att->retry_on_sec_error =3D true;
>
>         /* crypto is optional, if not available leave it NULL */
>         if (!ext_signed)
> @@ -2042,3 +2048,11 @@ bool bt_att_has_crypto(struct bt_att *att)
>
>         return att->crypto ? true : false;
>  }
> +
> +void bt_att_set_retry_on_sec_error(struct bt_att *att, bool retry_on_sec=
_error)
> +{
> +       if (!att)
> +               return;
> +
> +       att->retry_on_sec_error =3D retry_on_sec_error;
> +}
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 4aa3de87b..8ed89ba80 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -110,3 +110,4 @@ bool bt_att_set_local_key(struct bt_att *att, uint8_t=
 sign_key[16],
>  bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
>                         bt_att_counter_func_t func, void *user_data);
>  bool bt_att_has_crypto(struct bt_att *att);
> +void bt_att_set_retry_on_sec_error(struct bt_att *att, bool retry_on_sec=
_error);
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 5de679c9b..b484db9db 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -3818,3 +3818,12 @@ bool bt_gatt_client_idle_unregister(struct bt_gatt=
_client *client,
>
>         return false;
>  }
> +
> +void bt_gatt_client_set_retry_on_sec_error(struct bt_gatt_client *client=
,
> +                                               bool retry_on_sec_error)
> +{
> +       if (!client)
> +               return;
> +
> +       bt_att_set_retry_on_sec_error(client->att, retry_on_sec_error);
> +}

I wonder if it wouldn't be better to just have it as
bt_att_set_retry(guint op) and then set it via att_send_op->retry !=3D
retry; so it can be used on a per operation basis that way we can try
to have a property over D-Bus to be able to pass such tests using
bluetoothctl.

> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index bccd04a62..fdb841df0 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -134,3 +134,5 @@ unsigned int bt_gatt_client_idle_register(struct bt_g=
att_client *client,
>                                         bt_gatt_client_destroy_func_t des=
troy);
>  bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
>                                                 unsigned int id);
> +void bt_gatt_client_set_retry_on_sec_error(struct bt_gatt_client *client=
,
> +                                               bool retry_on_sec_error);
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 58a03bd48..76c74c7a8 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -1295,6 +1295,42 @@ static void cmd_set_sign_key(struct client *cli, c=
har *cmd_str)
>                 set_sign_key_usage();
>  }
>
> +static void set_retry_on_sec_error_usage(void)
> +{
> +       printf("Usage: set-retry-on-sec-error <y/n>\n"
> +               "e.g.:\n"
> +               "\tset-retry-on-sec-error n\n");
> +}
> +
> +static void cmd_set_retry_on_sec_error(struct client *cli, char *cmd_str=
)
> +{
> +       char *argv[2];
> +       int argc =3D 0;
> +
> +       if (!bt_gatt_client_is_ready(cli->gatt)) {
> +               printf("GATT client not initialized\n");
> +               return;
> +       }
> +
> +       if (!parse_args(cmd_str, 1, argv, &argc)) {
> +               printf("Too many arguments\n");
> +               set_retry_on_sec_error_usage();
> +               return;
> +       }
> +
> +       if (argc < 1) {
> +               set_retry_on_sec_error_usage();
> +               return;
> +       }
> +
> +       if (argv[0][0] =3D=3D 'y')
> +               bt_gatt_client_set_retry_on_sec_error(cli->gatt, true);
> +       else if (argv[0][0] =3D=3D 'n')
> +               bt_gatt_client_set_retry_on_sec_error(cli->gatt, false);
> +       else
> +               printf("Invalid argument: %s\n", argv[0]);
> +}
> +
>  static void cmd_help(struct client *cli, char *cmd_str);
>
>  typedef void (*command_func_t)(struct client *cli, char *cmd_str);
> @@ -1329,6 +1365,8 @@ static struct {
>                                 "\tGet security level on le connection"},
>         { "set-sign-key", cmd_set_sign_key,
>                                 "\tSet signing key for signed write comma=
nd"},
> +       { "set-retry-on-sec-error", cmd_set_retry_on_sec_error,
> +                       "\tSet retry on security error by elevating secur=
ity"},
>         { }
>  };
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
