Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF83DBAC
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947373; cv=none; b=IUgfExzvqhNt7UwepHZFKCjECmxHEABB0ojlk0V09C7xmm9LZ5DmHq6h6Lpe4IyFvShabtKoMDc0qgDu7ARHU9K6sHrvHPLZ6Q4XZsb3N/agNwRC5FZrda4/MicRO54GLEPDFrIVkaEUDNzBeVZzpBhnyr8Pxf9Gmz0TpFvGklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947373; c=relaxed/simple;
	bh=CgvBRR+jChvee4h4sPhrhzRXxu9VmH2uaboa1J+z5Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTkm+iLmFeSV7fJ0b9NpCd0rOMl0nc75IreMVisbpVRCGigRt9RSM/FhJovW1SVDIOIkaOFK41lTqJArWSRbHF9SwjVv+l7tG5nNgY3v7JXHuNXK62XNn/6Z72bg7IC1HltN2kau17zT9Drl/JTWEzHMFYT3m2qFf1Ar/z3MjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqKqgkF3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqKqgkF3"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so35325721fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705947370; x=1706552170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1kZdGJTCHivmthHndoBG6ngHJY3feLsgZ+JIjWRhRY=;
        b=FqKqgkF3ONm2+JoPwx+p9AiOPV8tAMWrG9rFa/JSWGO1iVxLTYCF/Aed7rxsVDSVT1
         zlt1o/aO8xqPjvBwEHOea166bet2BIQwpwsqKNq1Vz5BfCk8TvWvFOTOe5y0O+T2F8N/
         LeQpsX9iBYNzcq2+Fr2ksDVzsB8dx3Q1lYbIcXnpZWRuOwH9PS6fSsBy3el/sF2c4P16
         yIw2CuHe2NrcZXleRd1eNoKfMow9KuH2FDepAUY8MCb+gKPQPI/JUxM9fGnhQyzqKt3Z
         /KK1z/gfYhGp5rYbDP2BUxdpthbpN3UZT0zg8xOctZ4BqWj1tedbs+HzSZ2kqiO/+h+t
         k7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947370; x=1706552170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1kZdGJTCHivmthHndoBG6ngHJY3feLsgZ+JIjWRhRY=;
        b=ME+tH14P44J626z9slTjRCU/eP8cbkZ6/7WVuZ/oDrxZPo7Os6R4irIDSK5/lg9LzX
         tPAKwQ1ArJb+qWE5NNCwk17GjBbnYl0VXzTRTXHPv9nxCFfuszTpTQf6iUS//kuzOMWY
         BWzCivIJgryV20COp8pWfxoFxvxYwa2LiCSwKPdMeVsootD+4Gez0o49sHZZ/l6D8Tk2
         1i8itZl/AgoQgCN0Xg0RbGGSTvhN0SCv1oioQcUeAaY12CA+Zgq6Sloj40mOsZGkk+MQ
         pFCtXssYhLeTZyy5N+ngpPG2c5ZNMQV5BZ0WQVrCoPLKQeS9LqvOWY3Y9MpjDaqlGEDl
         pz2w==
X-Gm-Message-State: AOJu0YzbYPsPTTrP+wBAWmqR42NwrxM6zD9XjEIbYWX9wc0DX/uiAi84
	o7pSDobv7xkN0bIxQBHoPs+HQ/P1r9zEdOE+LNgkGET4S1/Kn+EW6PzPHU5KuRBQgLPZfRHITUv
	L5lO3jws87tCeWAeJBNeje+hlXs/SXAjr
X-Google-Smtp-Source: AGHT+IFQiZoGUBwMhVu9IlzHYq6f6URzykkzShlHVLJ3WHwhZw9JTLb1AQs1q7Enk780LCfNHyG/uFBImBmpAyJTZq8=
X-Received: by 2002:a05:651c:1049:b0:2cd:3141:5d4f with SMTP id
 x9-20020a05651c104900b002cd31415d4fmr886667ljm.109.1705947369445; Mon, 22 Jan
 2024 10:16:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122165000.279381-1-frederic.danis@collabora.com> <20240122165000.279381-5-frederic.danis@collabora.com>
In-Reply-To: <20240122165000.279381-5-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2024 13:15:56 -0500
Message-ID: <CABBYNZL-uiQyss17OWRrgdpf2KdVLKmVdunO-Kd5WD1KepKw0A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/5] btgatt-client: Add function to search descriptors
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Mon, Jan 22, 2024 at 12:43=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This is requested to pass PTS GATT/CL/GAD/BV-06-C test.
> This search descriptors based on start and end handles.

Is this test mandatory though? Afaik if we do support the discovery of
all procedure this becomes useless, because the stack can perform
these operations locally by using its cache.

> ---
>  tools/btgatt-client.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index bb0822658..a7d5d76ba 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -1490,6 +1490,83 @@ static void cmd_search_characteristics(struct clie=
nt *cli, char *cmd_str)
>                                                 NULL);
>  }
>
> +static void search_descriptors_usage(void)
> +{
> +       printf("Usage: search-descriptors <start_hanlde> <end_handle>\n"
> +               "e.g.:\n"
> +               "\tsearch-descriptors 0x0001 0xFFFF\n");
> +}
> +
> +static void search_descriptors_cb(bool success, uint8_t att_ecode,
> +                                       struct bt_gatt_result *result,
> +                                       void *user_data)
> +{
> +       struct bt_gatt_iter iter;
> +       uint16_t handle;
> +       uint128_t u128;
> +       bt_uuid_t uuid;
> +       char uuid_str[MAX_LEN_UUID_STR];
> +
> +       if (!success) {
> +               PRLOG("\nDescriptors discovery failed: %s (0x%02x)\n",
> +                               ecode_to_string(att_ecode), att_ecode);
> +               return;
> +       }
> +
> +       if (!result || !bt_gatt_iter_init(&iter, result))
> +               return;
> +
> +       printf("\n");
> +       while (bt_gatt_iter_next_descriptor(&iter, &handle, u128.data)) {
> +               bt_uuid128_create(&uuid, u128);
> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
> +               printf("Found handle: 0x%04x UUID: %s\n", handle, uuid_st=
r);
> +       }
> +       PRLOG("\n");
> +}
> +
> +static void cmd_search_descriptors(struct client *cli, char *cmd_str)
> +{
> +       char *argv[3];
> +       int argc =3D 0;
> +       uint16_t start_handle, end_handle;
> +       char *endptr =3D NULL;
> +
> +       if (!bt_gatt_client_is_ready(cli->gatt)) {
> +               printf("GATT client not initialized\n");
> +               return;
> +       }
> +
> +       if (!parse_args(cmd_str, 2, argv, &argc)) {
> +               printf("Too many arguments\n");
> +               search_descriptors_usage();
> +               return;
> +       }
> +
> +       if (argc < 1) {
> +               search_descriptors_usage();
> +               return;
> +       }
> +
> +       start_handle =3D strtol(argv[0], &endptr, 0);
> +       if (!endptr || *endptr !=3D '\0') {
> +               printf("Invalid start handle: %s\n", argv[0]);
> +               return;
> +       }
> +
> +       end_handle =3D strtol(argv[1], &endptr, 0);
> +       if (!endptr || *endptr !=3D '\0') {
> +               printf("Invalid end handle: %s\n", argv[1]);
> +               return;
> +       }
> +
> +       bt_gatt_discover_descriptors(bt_gatt_client_get_att(cli->gatt),
> +                                               start_handle, end_handle,
> +                                               search_descriptors_cb,
> +                                               NULL,
> +                                               NULL);
> +}
> +
>  static void cmd_help(struct client *cli, char *cmd_str);
>
>  typedef void (*command_func_t)(struct client *cli, char *cmd_str);
> @@ -1530,6 +1607,8 @@ static struct {
>                                 "\tSearch service"},
>         { "search-characteristics", cmd_search_characteristics,
>                                 "\tSearch characteristics"},
> +       { "search-descriptors", cmd_search_descriptors,
> +                               "\tSearch descriptors"},
>         { }
>  };
>
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
