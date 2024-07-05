Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF913CFA8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720200049; cv=none; b=Nih6037LidsIFENF9l/AA4Rl0ly+TN85mkb2TnQsd9UbPfXxgg3KNwc1P1guGDHgoVbfzflm2A65MKgNcgkj3YuHxGRcz3qmdBnhPN5pDHq2bu1oEDYwLIMXz1VTBrBEmLyrSTT3CLC/E2zyHn/U3UADpBdK7sG/xpvAj7AB+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720200049; c=relaxed/simple;
	bh=IgyCCV5WbL33wKmI+6CLMVTX5m3tHWIqjflFlqrmY3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9P6KFZat+Ym9Va2l3cgyoTJDerbkfwAVNRYiQFe7xlvLQ57tdao9K2NHQ3891XRlrPoJn+t9awBYuKlt3M6tEuJI6267nq5eIHB+rXTns/lz5xukctNKBnhecLPg1UF2d3zi3E2s/62a3ajOAL2P7rOR8SchnFYtQA1c2YkfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7lOJPHS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7lOJPHS"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee90f56e02so15924781fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720200045; x=1720804845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP2ouiBzQgr6xw8rVZ9oaSKOTOw8uJbYpx8IB7bigZM=;
        b=l7lOJPHS/pxTD6Rmc2X+a9/Kcox4dSe0qHqEPDXV/zJP1vhiSkH0i1446+W1HSnUfC
         SWGN8a6Eg/grS99jnGGWNND0Ts/VGsXOt5PxdXRS0XjBK8d8G+VMY6fLpMRue0IRLixB
         KRicpS1Qj7MNs6uiqNm0areHdTqsWemIrTNNRK/bHLqEGLRTVsh+OwWS1UwAojw12nAo
         fInIs+kJPn6wusVZd3XKDCoDI8bA2s0wIZooMi0LgrbZuRFwRXP0TB2VgB1Uf3XFPJ+c
         6ONlnNRNkL7eBhVWiv7b6qR0+rTdoC6FDWD051rX5DpsNoWNk2bF6BgA4flkQ25DQ4VQ
         Evbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720200045; x=1720804845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP2ouiBzQgr6xw8rVZ9oaSKOTOw8uJbYpx8IB7bigZM=;
        b=jOFE8ge4gOKPLP9G4v/TAul3QYZRYHCVL+jY2AA4JlyvtByvCmxfqXr7LO9fMjzBXj
         s1OQym6/0PzLnXIJHlQBSFFrpLPv0fUhZOCXvg5oeP0JCmWwhBGATkGRgtkH6lfYl3wZ
         feF7LW0ljJChPyvmgB0ydmhgveepxb1CSduzsD7OttVNSNWWtsHyf2s9aavTgqa4Agzx
         juwYMfAbtS8nifnFkTMps660uHuqmiVa9ID3mooyWE1JHBuRRgJAvklMN7g5YSdABzv8
         6cS1O1Vh88Iv6U4TqGeYikRM3S0oZDVpHIYlrIoxA60w6v9K7/rHcTYqFxq0PWRQkFr4
         ATFA==
X-Gm-Message-State: AOJu0YxLpaCNDPtLte5MhgGV1mFmdkNTuyZFN9qYf23CBZCizue1ji09
	XT0Khj9iTSegoEi5In+Cucd3t+A3CkzdRUJOlUYFXYQ8deKvj4gODUaay2SxcsSjw5ptrlRnI7q
	N2vRVaWfpeMCrnB3IOvqBdSxt7aW6c12g
X-Google-Smtp-Source: AGHT+IFoinKxjWTh8SDo1gCLzcsOgVgfZn9Kqer/cv4el//z+egArBqBaBaX8MKyrVD+pfXkma0FqRwk4bAz8TUrUzo=
X-Received: by 2002:a2e:b55a:0:b0:2ec:5172:dbb8 with SMTP id
 38308e7fff4ca-2ee8ed69fb9mr32892901fa.7.1720200044059; Fri, 05 Jul 2024
 10:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073720.13504-1-quic_prathm@quicinc.com>
In-Reply-To: <20240705073720.13504-1-quic_prathm@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jul 2024 13:20:27 -0400
Message-ID: <CABBYNZKAG6Ygw+qGk8FfJEtRVUO3GjVW4aoYhJ5xaLoGb3Y3_w@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Set BREDR not supported bit in AD Flag when
 discoverable is off
To: quic_prathm@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de, 
	quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 5, 2024 at 3:37=E2=80=AFAM <quic_prathm@quicinc.com> wrote:
>
> From: Prathibha Madugonde <quic_prathm@quicinc.com>
>
> Fix for GAP/DISC/NONM/BV-02-C
> As per GAP.TS.p44 test spec
> IUT does not contain General Discoverable mode and Limited Discoverable
> mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
> case, thus set BR/EDR not supported bit in the AD Type Flag when
> discoverable is off.
>
> client/advertising.c:
> Allowing discoverable property to list in the parsing
> function when discoverable is off.
>
> Test steps:
> From DUT, bluetoothctl go to menu advertise
> set discoverable to off and then advertise on.
> In AD Flags BR/EDR not supported BIT shall be set.
>
> ---
>  client/advertising.c | 8 +-------
>  src/advertising.c    | 3 +--
>  2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/client/advertising.c b/client/advertising.c
> index a9b865a65..4a98121a4 100644
> --- a/client/advertising.c
> +++ b/client/advertising.c
> @@ -416,12 +416,6 @@ static gboolean get_data(const GDBusPropertyTable *p=
roperty,
>         return TRUE;
>  }
>
> -static gboolean discoverable_exists(const GDBusPropertyTable *property,
> -                                                       void *data)
> -{
> -       return ad.discoverable;
> -}
> -
>  static gboolean get_discoverable(const GDBusPropertyTable *property,
>                                         DBusMessageIter *iter, void *user=
_data)
>  {
> @@ -498,7 +492,7 @@ static const GDBusPropertyTable ad_props[] =3D {
>         { "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
>                                                 manufacturer_data_exists =
},
>         { "Data", "a{yv}", get_data, NULL, data_exists },
> -       { "Discoverable", "b", get_discoverable, NULL, discoverable_exist=
s },
> +       { "Discoverable", "b", get_discoverable, NULL, NULL },

Doesn't seems the above change have anything to do with the commit
description, perhaps you want to force it as non-discoverable in case
it is not set? I guess it makes sense but it should probably be made
into its own commit with proper description.

>         { "DiscoverableTimeout", "q", get_discoverable_timeout, NULL,
>                                                 discoverable_timeout_exis=
ts },
>         { "Includes", "as", get_includes, NULL, includes_exists },
> diff --git a/src/advertising.c b/src/advertising.c
> index 5d373e088..af3ed2b93 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -734,8 +734,7 @@ static bool set_flags(struct btd_adv_client *client, =
uint8_t flags)
>         /* Set BR/EDR Not Supported if adapter is not discoverable but th=
e
>          * instance is.
>          */
> -       if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
> -                       !btd_adapter_get_discoverable(client->manager->ad=
apter))
> +       if (!btd_adapter_get_discoverable(client->manager->adapter))
>                 flags |=3D BT_AD_FLAG_NO_BREDR;
>
>         if (!bt_ad_add_flags(client->data, &flags, 1))
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
