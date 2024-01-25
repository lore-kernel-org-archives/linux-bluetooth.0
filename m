Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE871386B2
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208261; cv=none; b=HRbr1WXnj79Zm7jnBV0GQGTgPTB9FYZLgZ+5uvRg0D/MK/j7Qxkw1RME7/9SnYIa2Zjf92il0wlezQgz5LAwRjdCZ17sYASAeIWZ2rlUNrFUTHGY12kijzStaOiJ26I+RCk9tsPcWF6fMZmIKGxJJl1TaeWMjz/vKrUW9gH4HPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208261; c=relaxed/simple;
	bh=8/GH5ZIViYiQre5yfIfV/yJBFlN7W4t49qe+wXY5v6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNjrBjCYKjzBXdKEB93lbTXSxUAIGvUvmOKJFIcbUDPGNojzxYeytrhZVQ8IX6jkfrNQeDr/ULG98q5DFGRXIvamFK4zw16RGaIZpr7Uy0GIcysM5pKKMFSmQPc/aDekHjq3p3rFy2fYhY3ujVWKk7JoGuZb9X0Bo12ccOPw71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ancLeRlS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ancLeRlS"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf3ea86423so8231361fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 10:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208257; x=1706813057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irdmdnS9J8EWcj9KkfYJCd8rzaYtw4rSykJQVaW1yQE=;
        b=ancLeRlSacxDMBB1U1NfRtiBxosnoOc9MpGKHfXezNGTL6ic5hyJO6g1K3DfkOp8vE
         GeMhNdoWd0HLUTW4gEqHKqEuVjpAJ5hGl7xXC5r3skkXVy+7PEJ92R9z9Y0iwbaVkn85
         pUo084+rLXjciSeLyJlbPFJ6ZtU0U40Q+LdC2X8DaMYH88RhpP1wN1IQu6mSaA3kXSVl
         OQMN90zxduMYorL18t+me7NxAgsufvEZYAZ5DKlbX+xoLjF3mrx7WTECPB+bXz9toHf9
         OccUJvXr64Y0NM0WRlfkNj7Nkn5HNhi9Z7ajXUTV+J/HW5bV6cMKFS9dHoN3nJxPz4Mt
         pz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208257; x=1706813057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irdmdnS9J8EWcj9KkfYJCd8rzaYtw4rSykJQVaW1yQE=;
        b=pvl0NCwJeGJNblX+aSFti6wdMoXt8lSBErMJ1jINU4hhaTuzNBNH8KRdbOJ2NUMciG
         iHKHo+RCVLxQGKZwCw6LCBmaiyUL3EhGbUFDLyUjUwGWGHmq6v6Aqcz4ifcM9nQAPcMi
         0fG3quwfMjIDg1m0A3AxupB7ZZPlsJEndXNxBPqhLOzsd4UVDHP50tK/UDCHdTijhekb
         q2NPRtt81yhEcLZGMzhZZdTuo+DpaWN6ZsZZxmwWkbwzF2ssZz86wETiVjXcNvF3Qd67
         tqdhDugg4La+1MGXJnjC3RB2ou9iZWop6mnMGArZShH4xf6kP9y2NRumOFJxcLMCr0pU
         crjw==
X-Gm-Message-State: AOJu0YwxNnRsVQ8wh8cBk/ZokV35LkZrxUIFrTnhhl1XEMM26aiIBTpf
	mVVDhw2H32H/Mq/MNn1caC3BY7d3FRW5pWGyaWfroor8GWql7zjt2POq7SZ0T6YYuB9kq43n78J
	NWxaIEG80Tf8hcso3dJ14bwfQCOtyyVh0
X-Google-Smtp-Source: AGHT+IFfl2yTzQPZmoUefD5pPYysSUeGOLn0fxY4khxOBP9jsL/ertTATrQV9UMDbnXt3w/ZxL10R8MMLq0t6X2zsz0=
X-Received: by 2002:a2e:87d3:0:b0:2cf:4017:64ed with SMTP id
 v19-20020a2e87d3000000b002cf401764edmr65554ljj.4.1706208257097; Thu, 25 Jan
 2024 10:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123143151.541787-1-frederic.danis@collabora.com> <20240123143151.541787-2-frederic.danis@collabora.com>
In-Reply-To: <20240123143151.541787-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jan 2024 13:44:03 -0500
Message-ID: <CABBYNZ+KEpG-8_goV93epKEWn41hsVLGt7Xk5q5g+uMDwANJfQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/4] gatt: Prevent security level change for PTS
 GATT tests
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Jan 23, 2024 at 9:53=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Some PTS GATT tests like GATT/CL/GAR/BI-04-C request to be able to get th=
e
> security error and do not try to change the security level.
>
> This commit adds the ability to prevent to change the security level for
> an operation.
> ---
>  src/shared/att.c         | 26 +++++++++++++
>  src/shared/att.h         |  1 +
>  src/shared/gatt-client.c | 19 +++++++++
>  src/shared/gatt-client.h |  3 ++

Please have the changes to src/shared in a separate patch.

>  tools/btgatt-client.c    | 84 ++++++++++++++++++++++++++++++++++------
>  5 files changed, 121 insertions(+), 12 deletions(-)
>
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 62c884b65..485ef071b 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -2042,3 +2042,29 @@ bool bt_att_has_crypto(struct bt_att *att)
>
>         return att->crypto ? true : false;
>  }
> +
> +bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry)
> +{
> +       struct att_send_op *op;
> +
> +       if (!id)
> +               return false;
> +
> +       op =3D queue_find(att->req_queue, match_op_id, UINT_TO_PTR(id));
> +       if (op)
> +               goto done;
> +
> +       op =3D queue_find(att->ind_queue, match_op_id, UINT_TO_PTR(id));
> +       if (op)
> +               goto done;
> +
> +       op =3D queue_find(att->write_queue, match_op_id, UINT_TO_PTR(id))=
;
> +
> +done:
> +       if (!op)
> +               return false;
> +
> +       op->retry =3D !retry;
> +
> +       return true;
> +}
> diff --git a/src/shared/att.h b/src/shared/att.h
> index 4aa3de87b..6fd78636e 100644
> --- a/src/shared/att.h
> +++ b/src/shared/att.h
> @@ -110,3 +110,4 @@ bool bt_att_set_local_key(struct bt_att *att, uint8_t=
 sign_key[16],
>  bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
>                         bt_att_counter_func_t func, void *user_data);
>  bool bt_att_has_crypto(struct bt_att *att);
> +bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry);
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 5de679c9b..6340bcd85 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -3818,3 +3818,22 @@ bool bt_gatt_client_idle_unregister(struct bt_gatt=
_client *client,
>
>         return false;
>  }
> +
> +bool bt_gatt_client_set_retry(struct bt_gatt_client *client,
> +                                       unsigned int id,
> +                                       bool retry)
> +{
> +       struct request *req;
> +
> +       if (!client || !id)
> +               return false;
> +
> +       req =3D queue_find(client->pending_requests, match_req_id,
> +                                                       UINT_TO_PTR(id));
> +       if (!req)
> +               return false;
> +
> +       bt_att_set_retry(client->att, req->att_id, retry);
> +
> +       return true;
> +}
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index bccd04a62..63cf99500 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -134,3 +134,6 @@ unsigned int bt_gatt_client_idle_register(struct bt_g=
att_client *client,
>                                         bt_gatt_client_destroy_func_t des=
troy);
>  bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
>                                                 unsigned int id);
> +bool bt_gatt_client_set_retry(struct bt_gatt_client *client,
> +                                       unsigned int id,
> +                                       bool retry);
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 58a03bd48..3bcb7e1cf 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -57,6 +57,7 @@ struct client {
>         struct bt_gatt_client *gatt;
>
>         unsigned int reliable_session_id;
> +       bool sec_retry;
>  };
>
>  static void print_prompt(void)
> @@ -172,6 +173,7 @@ static struct client *client_create(int fd, uint16_t =
mtu)
>                 fprintf(stderr, "Failed to allocate memory for client\n")=
;
>                 return NULL;
>         }
> +       cli->sec_retry =3D true;
>
>         cli->att =3D bt_att_new(fd, false);
>         if (!cli->att) {
> @@ -488,6 +490,7 @@ static void cmd_read_multiple(struct client *cli, cha=
r *cmd_str)
>         char *argv[512];
>         int i;
>         char *endptr =3D NULL;
> +       unsigned int id;
>
>         if (!bt_gatt_client_is_ready(cli->gatt)) {
>                 printf("GATT client not initialized\n");
> @@ -514,9 +517,12 @@ static void cmd_read_multiple(struct client *cli, ch=
ar *cmd_str)
>                 }
>         }
>
> -       if (!bt_gatt_client_read_multiple(cli->gatt, value, argc,
> -                                               read_multiple_cb, NULL, N=
ULL))
> +       id =3D bt_gatt_client_read_multiple(cli->gatt, value, argc,
> +                                               read_multiple_cb, NULL, N=
ULL);
> +       if (!id)
>                 printf("Failed to initiate read multiple procedure\n");
> +       else if (!cli->sec_retry)
> +               bt_gatt_client_set_retry(cli->gatt, id, false);
>
>         free(value);
>  }
> @@ -558,6 +564,7 @@ static void cmd_read_value(struct client *cli, char *=
cmd_str)
>         int argc =3D 0;
>         uint16_t handle;
>         char *endptr =3D NULL;
> +       unsigned int id;
>
>         if (!bt_gatt_client_is_ready(cli->gatt)) {
>                 printf("GATT client not initialized\n");
> @@ -575,9 +582,12 @@ static void cmd_read_value(struct client *cli, char =
*cmd_str)
>                 return;
>         }
>
> -       if (!bt_gatt_client_read_value(cli->gatt, handle, read_cb,
> -                                                               NULL, NUL=
L))
> +       id =3D bt_gatt_client_read_value(cli->gatt, handle, read_cb,
> +                                       NULL, NULL);
> +       if (!id)
>                 printf("Failed to initiate read value procedure\n");
> +       else if (!cli->sec_retry)
> +               bt_gatt_client_set_retry(cli->gatt, id, false);
>  }
>
>  static void read_long_value_usage(void)
> @@ -592,6 +602,7 @@ static void cmd_read_long_value(struct client *cli, c=
har *cmd_str)
>         uint16_t handle;
>         uint16_t offset;
>         char *endptr =3D NULL;
> +       unsigned int id;
>
>         if (!bt_gatt_client_is_ready(cli->gatt)) {
>                 printf("GATT client not initialized\n");
> @@ -616,9 +627,12 @@ static void cmd_read_long_value(struct client *cli, =
char *cmd_str)
>                 return;
>         }
>
> -       if (!bt_gatt_client_read_long_value(cli->gatt, handle, offset, re=
ad_cb,
> -                                                               NULL, NUL=
L))
> +       id =3D bt_gatt_client_read_long_value(cli->gatt, handle, offset, =
read_cb,
> +                                                               NULL, NUL=
L);
> +       if (!id)
>                 printf("Failed to initiate read long value procedure\n");
> +       else if (!cli->sec_retry)
> +               bt_gatt_client_set_retry(cli->gatt, id, false);
>  }
>
>  static void write_value_usage(void)
> @@ -659,6 +673,7 @@ static void cmd_write_value(struct client *cli, char =
*cmd_str)
>         uint8_t *value =3D NULL;
>         bool without_response =3D false;
>         bool signed_write =3D false;
> +       unsigned int id;
>
>         if (!bt_gatt_client_is_ready(cli->gatt)) {
>                 printf("GATT client not initialized\n");
> @@ -740,10 +755,13 @@ static void cmd_write_value(struct client *cli, cha=
r *cmd_str)
>                 goto done;
>         }
>
> -       if (!bt_gatt_client_write_value(cli->gatt, handle, value, length,
> +       id =3D bt_gatt_client_write_value(cli->gatt, handle, value, lengt=
h,
>                                                                 write_cb,
> -                                                               NULL, NUL=
L))
> +                                                               NULL, NUL=
L);
> +       if (!id)
>                 printf("Failed to initiate write procedure\n");
> +       else if (!cli->sec_retry)
> +               bt_gatt_client_set_retry(cli->gatt, id, false);
>
>  done:
>         free(value);
> @@ -789,6 +807,7 @@ static void cmd_write_long_value(struct client *cli, =
char *cmd_str)
>         int length;
>         uint8_t *value =3D NULL;
>         bool reliable_writes =3D false;
> +       unsigned int id;
>
>         if (!bt_gatt_client_is_ready(cli->gatt)) {
>                 printf("GATT client not initialized\n");
> @@ -863,11 +882,14 @@ static void cmd_write_long_value(struct client *cli=
, char *cmd_str)
>                 }
>         }
>
> -       if (!bt_gatt_client_write_long_value(cli->gatt, reliable_writes, =
handle,
> +       id =3D bt_gatt_client_write_long_value(cli->gatt, reliable_writes=
, handle,
>                                                         offset, value, le=
ngth,
>                                                         write_long_cb,
> -                                                       NULL, NULL))
> +                                                       NULL, NULL);
> +       if (!id)
>                 printf("Failed to initiate long write procedure\n");
> +       else if (!cli->sec_retry)
> +               bt_gatt_client_set_retry(cli->gatt, id, false);
>
>         free(value);
>  }
> @@ -999,12 +1021,18 @@ done:
>                                                         value, length,
>                                                         write_long_cb, NU=
LL,
>                                                         NULL);
> -       if (!cli->reliable_session_id)
> +       if (!cli->reliable_session_id) {
>                 printf("Failed to proceed prepare write\n");
> -       else
> +       } else {
> +               if (!cli->sec_retry)
> +                       bt_gatt_client_set_retry(cli->gatt,
> +                                               cli->reliable_session_id,
> +                                               false);
> +
>                 printf("Prepare write success.\n"
>                                 "Session id: %d to be used on next write\=
n",
>                                                 cli->reliable_session_id)=
;
> +       }
>
>         free(value);
>  }
> @@ -1236,6 +1264,36 @@ static void cmd_get_security(struct client *cli, c=
har *cmd_str)
>                 printf("Security level: %u\n", level);
>  }
>
> +static void set_security_retry_usage(void)
> +{
> +       printf("Usage: set-security-retry <y/n>\n"
> +               "e.g.:\n"
> +               "\tset-security-retry n\n");
> +}
> +
> +static void cmd_set_security_retry(struct client *cli, char *cmd_str)
> +{
> +       char *argv[2];
> +       int argc =3D 0;
> +
> +       if (!bt_gatt_client_is_ready(cli->gatt)) {
> +               printf("GATT client not initialized\n");
> +               return;
> +       }
> +
> +       if (!parse_args(cmd_str, 1, argv, &argc) || argc !=3D 1) {
> +               set_security_retry_usage();
> +               return;
> +       }
> +
> +       if (argv[0][0] =3D=3D 'y')
> +               cli->sec_retry =3D true;
> +       else if (argv[0][0] =3D=3D 'n')
> +               cli->sec_retry =3D false;
> +       else
> +               printf("Invalid argument: %s\n", argv[0]);
> +}
> +
>  static bool convert_sign_key(char *optarg, uint8_t key[16])
>  {
>         int i;
> @@ -1327,6 +1385,8 @@ static struct {
>                                 "\tSet security level on le connection"},
>         { "get-security", cmd_get_security,
>                                 "\tGet security level on le connection"},
> +       { "set-security-retry", cmd_set_security_retry,
> +                       "\tSet retry on security error by elevating secur=
ity"},
>         { "set-sign-key", cmd_set_sign_key,
>                                 "\tSet signing key for signed write comma=
nd"},
>         { }
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
