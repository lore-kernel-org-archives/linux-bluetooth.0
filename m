Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DDC1E32D3
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766087398; cv=none; b=iJ/ck3MtusinuHJokO9G2h+wn0KiNyATa8/zmuMMAEo0PE1ri/IAi58HCg8cAKrpsC7Uwr7zN8c3aHPjrJsuuH+G2N/1jjKrpBEujRjpxSq32vV0FlOqXFh37AsBUw9x+3KgUBEKaDkDv1m3OhqjYurtgazSCiN6pJjyKyXo5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766087398; c=relaxed/simple;
	bh=hVL31YTnuu6RnvMB736Qu5bThBdxj6P1aeQ+q1XKuzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcfv48vv0XpLnDP2kThyCx2NGbQUWvC2gjuINFn0woAROTPpUsM/g3ZxRwErdrX6f+NELeH3yLUsQdc1Mivvm1kgbpGHP4e/UTiH9uR8YaKd+n78yOGRGG+1kWnkpXk9MhhyqpQp9GRUyKFx3s6dusJ0yBpPjEPY0Lqc9Ux7XdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiIyIIjE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiIyIIjE"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b99da107cso10395831fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766087395; x=1766692195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzPx4jrOoO5aWpQljA0RuFIStrwbBg476AfZHcLOn3s=;
        b=FiIyIIjEY1VZfQy7Se2ujFRHQYzeDQ3ump0sKbaEopqiFQ1RJmakhr/QYrzq9y6Bic
         6niJHkAO7omX0yJskAAP0MdmZS1c4OqF8bD4q988D1btQMcavxi0oqGcKbyw66NzShXE
         WsaiZ6QBn7Y80Ws4t8igy1ovWCoKOnnOZERKKeXrACV+mC5NnR7FwMp6qxee/hDmVMNz
         kWRnO5UboiFqJafn3kTwYpPBhBGcj2vi6Qo01AdA22ZSF1jMNbvooCAtQl6lZ6j9iXef
         cGmucvD50DnIPBJr2l+GEKDmMCxhIAg5FNcDrxDW9aZvo2MOaPMrG00BaYlwaamM0d6W
         XLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766087395; x=1766692195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzPx4jrOoO5aWpQljA0RuFIStrwbBg476AfZHcLOn3s=;
        b=oXMM/7aQGlny+/xHSWmTHGdlJagJ3K60vPE78pedjZEVmb9Hng9/6AszHX63Nnm1J+
         QA6OFx1J1AmUvnIdk4UzZvZBLxPsZL0bNW/Ma+6yA/LF7XFI16n3sq2n50h3wInux8UA
         jfNmeE32sZ3lbq9P0+WS591x598wJR5D/PNMzTDUkSKgsZ7zEvhELMUhBwO2FoVd47k0
         74jcm39astA3AyA/IMCvVIL4eK5f3bS0siJllyu0nXWSKQeHoHsqd98IDgyS+R1iUyky
         5Lg34MjSXozCo6V5UDKaWQaKTQ84EBNnKhVU5JDOsXoeebxAD6cESrw9UWNwhdO/IkDB
         go+g==
X-Gm-Message-State: AOJu0YztUnVynxcPKw3/WiAvZYjVAbCSfyYyL7l4xgR/vBaTxq8awEMl
	tl9mk/YkaWcK7yBLJpuESckVV8sndpKTraW0wt7cOiDH7cklUPdlQ/jVu4dLw4kEHm40vJVHPj8
	bc56Qw3GxqH6S5ram51oPtZ/hd0xbDcbUtalnJOY=
X-Gm-Gg: AY/fxX5BNaFZbUU8tzITT/3HEjaXt30BPlxLZQCzp+oj6SaFRu4mR5YIeEbbV005W6k
	8AOzrgHYAq+mQj0NdW+uNhU6mdG8R6ltJ+8IbcrnAt3Hb0sNZ1XZczEgXUsYTJUSK+USLqGI/rv
	YE0gh9NpJ/DFDziWY8UIwZzpKgABjf/gLL3zl7M7kr2ZgL+wHIlAe9W920jJd2vMaoDNJS3cyV9
	ke+L1tigzI88HGfh3cbonaieBYD74cN0NElzvzQG7YWBoEsm5ddkveUcGFU0nmFog+bew==
X-Google-Smtp-Source: AGHT+IF2S0BzgSJulQQLfHgIpj87nKd84piKXQT76BUPtMhL/4CMrb6cpRlln1KrApgYxksW447+XLTThiktAGPkKqA=
X-Received: by 2002:a05:651c:325b:b0:37f:cc09:3197 with SMTP id
 38308e7fff4ca-381216426ffmr1319581fa.23.1766087394897; Thu, 18 Dec 2025
 11:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765925485.git.pav@iki.fi> <83084652378b7e6e7aa8ff271408fc91da1212d1.1765925485.git.pav@iki.fi>
In-Reply-To: <83084652378b7e6e7aa8ff271408fc91da1212d1.1765925485.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Dec 2025 14:49:42 -0500
X-Gm-Features: AQt7F2p4SDHfn1amMMME2sFKCaOlJ7QoQDZ4Ci125vvsMMBczxCpnVGPZ60qg0c
Message-ID: <CABBYNZLBEWK0C7Rgu5WvfrWT80s9YR2DdCCJhoZCreQfK3jA+g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] tools/mpris-proxy: allow selecting which
 adapter to use
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Dec 16, 2025 at 5:54=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> mpris-proxy by default uses the first adapter it sees over DBus.  Add
> option for selecting a specific one.
> ---
>  tools/mpris-proxy.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
> index 2774bcc1a..c01c6af77 100644
> --- a/tools/mpris-proxy.c
> +++ b/tools/mpris-proxy.c
> @@ -62,6 +62,7 @@ static GSList *obex_sessions;
>
>  static gboolean option_version =3D FALSE;
>  static gboolean option_export =3D FALSE;
> +static gchar *option_adapter;
>
>  struct tracklist {
>         GDBusProxy *proxy;
> @@ -753,6 +754,8 @@ static GOptionEntry options[] =3D {
>                                 "Show version information and exit" },
>         { "export", 'e', 0, G_OPTION_ARG_NONE, &option_export,
>                                 "Export remote players" },
> +       { "adapter", 'a', 0, G_OPTION_ARG_STRING, &option_adapter,
> +                               "DBus path of the adapter to use" },

It might be easier to the users to do based on the index (-i/--index)
like most our tools do so the user don't have to copy/paste the whole
path, that said Id still allow it enter the full path if that is known
which probably result in doing a suffix matching logic so things like
0, hci0 or path/hci0 all match.

>         { NULL },
>  };
>
> @@ -2349,8 +2352,11 @@ static void proxy_added(GDBusProxy *proxy, void *u=
ser_data)
>         path =3D g_dbus_proxy_get_path(proxy);
>
>         if (!strcmp(interface, BLUEZ_ADAPTER_INTERFACE)) {
> -               if (adapter !=3D NULL)
> +               if ((option_adapter && strcmp(path, option_adapter)) ||
> +                                                       adapter !=3D NULL=
) {
> +                       printf("Bluetooth Adapter %s ignored\n", path);
>                         return;
> +               }
>
>                 printf("Bluetooth Adapter %s found\n", path);
>                 adapter =3D proxy;
> --
> 2.51.1
>
>


--=20
Luiz Augusto von Dentz
