Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE78657BD
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535658; cv=none; b=qHrqhFiBnkI6Ufm1A4VfwCj7k2zojk3sUTd48HwaxaP+xUaCmb31aeOMlG+Yz2WrHphjznln993/cHUX5d+tjLpsE4H83kqpPm51Q52GOxZkPiEkBvSP6l1V8FCpslomeEmUTstZW+4QDpJj4PjW66yz4iL3SwXPFX27n+e5zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535658; c=relaxed/simple;
	bh=sfpUGPI+JlgAxVTRV+fuWLxkXyd1dAGJh5UumsXmMeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAlSJoDeV9XkTVm1UycNd2McXJBR+5+6E9TdBgR4J0BgaT8yGQOxZwBcWvwwKb8bauUXVpkZYBZ7EfHd9HivDQlmL1ukrkQFkhzkNTT5tsD6ppvMllH0e+4XL4rh9C8yg1NRzYwjSk0Z5WCuNpc9LWv6rl4RsZXCoWmKvtwEvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNpSDXJi; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNpSDXJi"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf5917f049so16235101fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706535654; x=1707140454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnonFnGrGl9nW1xVA7rBYUoF0PZtWUh5WnjNvjCt+yg=;
        b=fNpSDXJiCEgIv/NPLlXz6g4EfkUs5HNqHYdTw1hs1TML7Mv18qvUULvbQzV4rzWnPt
         CigSXcb7xBGce2FHKyVJNMcrRN7+yuCCgdI7XW0/M1CCx9XwpopXilfaphHwtI30MydR
         7xRWJUVvRkBzEvcgDRdrN8XEgDyPielvtQt1yB0VGds+zObOrK0dhJXLreUDNPFDYSiW
         qe6i5nj/EDQvFMAQ1NcCW4Iu2sexmxwlVWEfs/9VXAleL5Y6k7TvscRV5tgArB6ybQSk
         19184YtAjDJ6HhGeZ1JTNbotr6x6jT7R5Xj3DeotRCyNWDe/RjLrh66S6CBA6EyY6v36
         PdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706535654; x=1707140454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnonFnGrGl9nW1xVA7rBYUoF0PZtWUh5WnjNvjCt+yg=;
        b=MJEHPP89f6VrGq7B75LXKUJgJjGRxujg9e8fmcArFip34Yg6gq7tstlqZtuK9xM/07
         /OezWTPEFZjODU6HrmZNlqLs7tEe/Bp/BhJh9QItWHDQ2m/l3bAz66cn6wU/tcRA3Wdy
         c+YjjaJUtWytM7/NzQx9P9ybtbYZ7HPR3jrYujylKmu7vnAizkHLMs4KHReeZRkhS9Cu
         px2rNdUWoBqrrvyFN+Iv42HVgtAc3v6wnaxYKvfbhizAf4w+wBiLnoksI7+xA7DVlVg+
         QE0em/X1LjBZwVRvnV6E/CY0aukG4yE1FEknrAifk80MYSg6mND3RZWKTW9Eo/AxXhgO
         +B/Q==
X-Gm-Message-State: AOJu0Yyz60nHNk5cCUpRJ4IT0C2Sk9ZJXas4zQOitLCLFpKXFM0cwtqL
	nSrUkV5ZFusGRJ9T+atp3aMcvEazxu+44NzI9pOmIrhN1oK9V78G7etD5HS5R6zLWT0716ngahN
	dbedaXbQ/lcW+A22OyK9FWEXfWMAdi0Se
X-Google-Smtp-Source: AGHT+IFU36ZLPPAkCBg+ngUapnRHcLQV08s+uvNpkmU5HqiskB02s1MDcjFOVrGP9TSDFiAl7//sO3F32szdYaBXqrM=
X-Received: by 2002:a2e:88cf:0:b0:2d0:5470:ce6a with SMTP id
 a15-20020a2e88cf000000b002d05470ce6amr201965ljk.14.1706535654138; Mon, 29 Jan
 2024 05:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129114900.92919-1-verdre@v0yd.nl> <20240129114900.92919-2-verdre@v0yd.nl>
In-Reply-To: <20240129114900.92919-2-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jan 2024 08:40:41 -0500
Message-ID: <CABBYNZKpUr+EZtKzPo-it3oojG2jrYT4iJMugZ2Y9LATrWPQag@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] mgmt-tester: Add a 0-opcode to expect_hci_list lists
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Jan 29, 2024 at 6:49=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.nl>=
 wrote:
>
> In add_expect_hci_list() we iterate through the entries of the
> expect_hci_list as long as there is an opcode, which means currently
> this relies on overflowing the buffer to detect the end of the list.
>
> This is not great and when running with address sanitizer, the
> out-of-bounds read gets detected and mgmt-tester aborts. Fix it by
> adding a trailing 0-opcode to all those lists.
> ---
>  tools/mgmt-tester.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 7dfd1b0c7..ee12ed7d5 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -8798,6 +8798,9 @@ static const struct hci_cmd_data multi_ext_adv_add_=
second_hci_cmds[] =3D {
>                 .len =3D sizeof(le_set_ext_adv_enable_inst_2),
>                 .param =3D le_set_ext_adv_enable_inst_2,
>         },
> +       {
> +               .opcode =3D 0,
> +       },

Normally the compiler would put a NULL term when last member has ',',
but we should either use {} to properly terminate the list or perhaps
it would have been better to have a something like
.expect_hci_list_len =3D ARRAY_SIZE(list) to ensure we never access past
the end of the list.

>  };
>
>  static const struct generic_data multi_ext_advertising_add_second_2 =3D =
{
> @@ -8845,6 +8848,9 @@ static const struct hci_cmd_data multi_ext_adv_remo=
ve_adv_hci_cmds[] =3D {
>                 .len =3D sizeof(advertising_instance1_param),
>                 .param =3D advertising_instance1_param,
>         },
> +       {
> +               .opcode =3D 0,
> +       },
>  };
>
>  static const struct generic_data multi_ext_advertising_remove =3D {
> @@ -8877,6 +8883,9 @@ static const struct hci_cmd_data multi_ext_adv_remo=
ve_all_adv_hci_cmds[] =3D {
>         {
>                 .opcode =3D BT_HCI_CMD_LE_CLEAR_ADV_SETS,
>         },
> +       {
> +               .opcode =3D 0,
> +       },
>  };
>
>  static const struct generic_data multi_ext_advertising_remove_all =3D {
> @@ -8913,6 +8922,9 @@ static const struct hci_cmd_data multi_ext_adv_add_=
2_advs_hci_cmds[] =3D {
>                 .len =3D sizeof(set_ext_adv_data_test1),
>                 .param =3D set_ext_adv_data_test1,
>         },
> +       {
> +               .opcode =3D 0,
> +       },
>  };
>
>  static const struct generic_data multi_ext_advertising_add_no_power =3D =
{
> @@ -10378,6 +10390,9 @@ static const struct hci_cmd_data ll_privacy_add_d=
evice_3_hci_list[] =3D {
>                 .param =3D set_resolv_on_param,
>                 .len =3D sizeof(set_resolv_on_param),
>         },
> +       {
> +               .opcode =3D 0,
> +       },
>  };
>
>  static const struct generic_data ll_privacy_add_device_3 =3D {
> @@ -10495,6 +10510,9 @@ static const struct hci_cmd_data ll_privacy_add_d=
evice_9_hci_list[] =3D {
>                 .len =3D sizeof(le_add_to_resolv_list_param),
>                 .param =3D le_add_to_resolv_list_param
>         },
> +       {
> +               .opcode =3D 0,
> +       },
>  };
>
>  static const struct generic_data ll_privacy_add_device_9 =3D {
> @@ -10823,6 +10841,9 @@ static const struct hci_cmd_data ll_privacy_set_d=
evice_flags_1_hci_list[] =3D {
>                 .param =3D set_resolv_on_param,
>                 .len =3D sizeof(set_resolv_on_param),
>         },
> +       {
> +               .opcode =3D 0,
> +       },
>  };
>
>  static const uint8_t device_flags_changed_params_1[] =3D {
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
