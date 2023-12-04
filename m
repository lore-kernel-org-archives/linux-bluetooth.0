Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2TjxS1O"
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69560CB
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 14:12:26 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso13700341fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701727944; x=1702332744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xVhVmrxuCJ/G4r+tPgWlTU9BM/7xdXt7jEBnmEO76Q=;
        b=P2TjxS1O0T/k3Vej4+dd0Zyg302dA7v2W3/MpxsaI494drvxyL0L1xWkTn+0cUDL/o
         /xzO/UZSqKhHR1JLN8rzvaaApFopkSbnPbDb2P4hI9OB+YFwBgMGFUgfNX+IulmaAC/1
         0ilYHVbrRfwkUEVioCQJVSRgwwcCKNWTsUpyDbK3A57TeHd8QzPrYX90TlEbbji6pFgf
         5AzJmoyTr8YeFeqpLWhYEtcQRQKUxdWBl5hL81590epmiTsA9ya5IP7zYQJxsaC2cF2O
         OE2oUryfvn3FwxnxEOUK/eqhT2hnfUi2ow607MmuWIJxq8lHrbA784pvziGAmbLS7eTO
         0Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727944; x=1702332744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xVhVmrxuCJ/G4r+tPgWlTU9BM/7xdXt7jEBnmEO76Q=;
        b=dXsMozgg7blZOi0VEn5ZUCQQlc1VwPCy/gJ3W5HdWBSiXJbA+Pp9EFnotx1ibiheJ3
         WqEO1ObE3vYRAd92oy++2bmfFfQfdH+78c1TYyeezco39IwlsPohVUso7hUErmW4GFAC
         p/yhbL2SjhjTrHUbnxhQX5dfanahyj56Qe4i+xW8rQlmOhixQxCxhcUWI12ny6du1QxJ
         34aCkiwZX5eEdj4fVedrWbwwDkoJlOjQQver2JZaxcbFwh7nqbKW/Lebo+pctRfEIp4n
         E/C6dJQmE2JoU+tHMnntFpKTkkl29utPz4yFJjE54dIcPLaK3uBuyOUfFi+vbCfk1unP
         7wLA==
X-Gm-Message-State: AOJu0YwBCwuW1CiRiBftq2clRNyTgvpWgW+/TkyHmKnBMG/Y1A0rmdot
	dnWUVRiRSjRNg7dA/qZVtMCqaDI5Ce501gZs/+o=
X-Google-Smtp-Source: AGHT+IEoScHhmHhqkL4aXT6MqoWZKj4CglMDN07aQpVaXPN+vmF6UQVZsw7Jm8KgFhOko2MHschD2oAgYCV+VOhLM3o=
X-Received: by 2002:a2e:9902:0:b0:2c9:f696:4510 with SMTP id
 v2-20020a2e9902000000b002c9f6964510mr1380009lji.43.1701727944321; Mon, 04 Dec
 2023 14:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130195750.1732-1-sebastif@axis.com>
In-Reply-To: <20231130195750.1732-1-sebastif@axis.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Dec 2023 17:12:11 -0500
Message-ID: <CABBYNZ+eZyQhqBePiG60xworabUKFoX8AmS+bA0R+vpucZhKhQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Pattern match on service- and manufacturer data
To: "sebastif@axis.com" <sebastian.david.forslund@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Sebastian Forslund <sebastif@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Thu, Nov 30, 2023 at 2:58=E2=80=AFPM sebastif@axis.com
<sebastian.david.forslund@gmail.com> wrote:
>
> From: Sebastian Forslund <sebastif@axis.com>
>
> When advertisement monitoring, manufacturer data and service data was
> not being matched against. This made it so that advertisement monitoring
> with or_patterns did not work that type of data.
>
> We must start matching against the data in the manufacturer_data and
> service_data queues. Run a different match-function depending on the
> type of monitor that is being matched against.
>
> Fixes: https://github.com/bluez/bluez/issues/652
> ---
>  src/shared/ad.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 src/shared/ad.c
>
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> old mode 100644
> new mode 100755
> index 951c56c60..a95079dc1
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -1324,6 +1324,72 @@ struct bt_ad_pattern *bt_ad_pattern_new(uint8_t ty=
pe, size_t offset, size_t len,
>         return pattern;
>  }
>
> +static void pattern_manufacturer_data_match(void *data, void *user_data)
> +{
> +       struct bt_ad_manufacturer_data *manufacturer_data =3D data;
> +       struct pattern_match_info *info =3D user_data;
> +       struct bt_ad_pattern *pattern;
> +       uint8_t all_data[BT_AD_MAX_DATA_LEN];
> +
> +       if (!manufacturer_data || !info)
> +               return;
> +
> +       if (info->matched_pattern)
> +               return;
> +
> +       pattern =3D info->current_pattern;
> +
> +       if (!pattern || pattern->type !=3D BT_AD_MANUFACTURER_DATA)
> +               return;
> +
> +       /* Take the manufacturer ID into account */
> +       if (manufacturer_data->len + 2 < pattern->offset + pattern->len)
> +               return;
> +
> +       memcpy(&all_data[0], &manufacturer_data->manufacturer_id, 2);
> +       memcpy(&all_data[2], manufacturer_data->data, manufacturer_data->=
len);
> +
> +       if (!memcmp(all_data + pattern->offset, pattern->data,
> +                                                       pattern->len)) {
> +               info->matched_pattern =3D pattern;
> +       }
> +}
> +
> +static void pattern_service_data_match(void *data, void *user_data)
> +{
> +       struct bt_ad_service_data *service_data =3D data;
> +       struct pattern_match_info *info =3D user_data;
> +       struct bt_ad_pattern *pattern;
> +
> +       if (!service_data || !info)
> +               return;
> +
> +       if (info->matched_pattern)
> +               return;
> +
> +       pattern =3D info->current_pattern;
> +
> +       if (!pattern)
> +               return;
> +
> +       switch (pattern->type) {
> +       case BT_AD_SERVICE_DATA16:
> +       case BT_AD_SERVICE_DATA32:
> +       case BT_AD_SERVICE_DATA128:
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       if (service_data->len < pattern->offset + pattern->len)
> +               return;
> +
> +       if (!memcmp(service_data->data + pattern->offset, pattern->data,
> +                                                       pattern->len)) {
> +               info->matched_pattern =3D pattern;
> +       }
> +}
> +
>  static void pattern_ad_data_match(void *data, void *user_data)
>  {
>         struct bt_ad_data *ad_data =3D data;
> @@ -1363,7 +1429,20 @@ static void pattern_match(void *data, void *user_d=
ata)
>
>         info->current_pattern =3D pattern;
>
> -       bt_ad_foreach_data(info->ad, pattern_ad_data_match, info);
> +       switch (pattern->type) {
> +       case BT_AD_MANUFACTURER_DATA:
> +               queue_foreach(info->ad->manufacturer_data, pattern_manufa=
cturer_data_match,
> +                                                       info);

I'd use queue_find instead so you can stop the lookup earlier if there
is a match, also for the match function you can use something like
match_manufacturer.

> +               break;
> +       case BT_AD_SERVICE_DATA16:
> +       case BT_AD_SERVICE_DATA32:
> +       case BT_AD_SERVICE_DATA128:
> +               queue_foreach(info->ad->service_data, pattern_service_dat=
a_match, info);

Ditto, Id also suggest to use something like match_service.

> +               break;
> +       default:
> +               bt_ad_foreach_data(info->ad, pattern_ad_data_match, info)=
;
> +               break;
> +       }
>  }
>
>  struct bt_ad_pattern *bt_ad_pattern_match(struct bt_ad *ad,
> --
> 2.39.2
>
>


--=20
Luiz Augusto von Dentz
