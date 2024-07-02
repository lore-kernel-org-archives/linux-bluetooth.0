Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1991BA86B
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932912; cv=none; b=BPMVNGg+Ljz/FEeFoXpoppo3ad0XIEJPlwFqi4IbDocSunQuh0brfmw/kG06NVFDBKyqJw7NEUNy9OQdVR5jkU0kg9ZG2gid9YW/I6UdCBLB6UMChO0RrtNo+EQ3nEDox4uorcH46zONVPOOSV6B4XvF1m3CabPbhnTYmaQgfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932912; c=relaxed/simple;
	bh=Mfq8gy1QfNr0ZF4yIoduPwALRGvQ8JEt4YMWTI/Zu84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiXxXECmxhCl8js4WBXXHT4/oJsVot3PQI7YyhJcec7CQxbUFtB2lbYavdAd3woqKHRBp1Eia0uFX3b0/+qHAz35n+HQmBj2G4zCdHm7nBS3j8HGyxXnZ1UQO41jae9r4NR7llTrHybWh2H45Gxa7A0+WL7QbS8bNXHoy46uFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy2Hyqup; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy2Hyqup"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so43411811fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932908; x=1720537708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diJ+CY4VyP21agB20fhWI903D0EUTuima93xT9+2/hk=;
        b=Hy2HyqupwSjb4uG8DyMCiKTkNee6048e9p1gGe7pFe4vOKDPz9CKnh0iNYsy4SHhny
         DqSxUReKet7gQKVh8Vai5qWN+OXHGmliyEq9pDygqZWyFk0HPkmKF60aehKb6uq7S+Ky
         CyjvINsxmSbCYZJoElYI/XFOaT0vgsq+ZVio7nCMJJwsjBOTxLPRuCg1ma03Uv7dqchW
         MzjfFXDBcLsCe8vyKAKgPM2AkNNlPFKpVPXlsKhLUhjCCXPaw0cWVLl21esgnVryIkjW
         3LVHlN057cPcXBCz4vOogACk/lZhYE7s4wrVBOjM/eUTQtATbessROLg8T00E6z2KLGp
         MQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932908; x=1720537708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diJ+CY4VyP21agB20fhWI903D0EUTuima93xT9+2/hk=;
        b=E3zwdET+36OxsSYeQU9ZYFOZ0NyPN4cf2qHm1ZvhPkwJGx8SDvVDwXXv8P28l067a1
         TPazW0RHIA2aNOsgdvH9VzWRoC5ckh5OfHs1Zu0TFffRqRHHK3xvy1A8TxPFeDZldSkx
         RDzwRENEynIxfH5u5AanRYVA5oqC0V3ocRWISbDNzOZZC02DHe9fScKJxXqo3iGcdPln
         eWyVZQXJ4ZDPBeaf9FqNjwChddgHjDjGk5z6tI5S7OQwmlxe3k0rcY6neqgkMBfMau0g
         XS2ceKgolZXxtRREDuhSdhAJwFYHCY4SuwpQPXwb2N5KhQ5jzlzyzExGQFtEOYXqNWCf
         zGCg==
X-Gm-Message-State: AOJu0YxrANjsG7wIG/NQakTeWPGVjxZD2+ywJQ3TCdvVvtK3qj4AeY+r
	oyfHxQ5WwhbtBFonX1EBcKT49rJ08DKr5kmhiLgGmBOc6wO2AJKShzNJ+ABsEw2K0Nr7KIqlhUf
	v6VzlQSujvPogLVidiU7xito/9R7uKQ==
X-Google-Smtp-Source: AGHT+IGhbvTnNR1YkIZWPGM+JxJkS9qk24ljqNTCYJIj6NwlD8jBFesfNsh+3E6SHvLZlM7XdwZXOOaHvAj8ty5vEpY=
X-Received: by 2002:a05:651c:b21:b0:2ee:4ab4:f752 with SMTP id
 38308e7fff4ca-2ee5e6cd8d4mr65181441fa.49.1719932908025; Tue, 02 Jul 2024
 08:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702142436.833138-1-hadess@hadess.net> <20240702142436.833138-2-hadess@hadess.net>
In-Reply-To: <20240702142436.833138-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jul 2024 11:08:15 -0400
Message-ID: <CABBYNZLu+kU0C63F_+GPj8k99t78HKU+aX46Y2sJB_dVQxuJ3A@mail.gmail.com>
Subject: Re: [BlueZ resend 1/9] main: Simplify parse_config_string()
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, Jul 2, 2024 at 10:25=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> The memory management done by parse_config_string() was quite
> complicated, as it expected to be able to free the value in the return
> variable if it was already allocated.
>
> That particular behaviour was only used for a single variable which was
> set to its default value during startup and might be overwritten after
> this function call.
>
> Use an intermediate variable to check whether we need to free
> btd_opts.name and simplify parse_config_string().
>
> Error: RESOURCE_LEAK (CWE-772): [#def39] [important]
> bluez-5.75/src/main.c:425:2: alloc_fn: Storage is returned from allocatio=
n function "g_key_file_get_string".
> bluez-5.75/src/main.c:425:2: var_assign: Assigning: "tmp" =3D storage ret=
urned from "g_key_file_get_string(config, group, key, &err)".
> bluez-5.75/src/main.c:433:2: noescape: Assuming resource "tmp" is not fre=
ed or pointed-to as ellipsis argument to "btd_debug".
> bluez-5.75/src/main.c:440:2: leaked_storage: Variable "tmp" going out of =
scope leaks the storage it points to.
> 438|    }
> 439|
> 440|->  return true;
> 441|   }
> 442|
> ---
>  src/main.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/src/main.c b/src/main.c
> index 62453bffaf57..9db8d7000490 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -420,9 +420,10 @@ static bool parse_config_string(GKeyFile *config, co=
nst char *group,
>                                         const char *key, char **val)
>  {
>         GError *err =3D NULL;
> -       char *tmp;
>
> -       tmp =3D g_key_file_get_string(config, group, key, &err);
> +       g_return_val_if_fail(val, false);

Nah, let's just use if (!val) return false as we normally do.

> +
> +       *val =3D g_key_file_get_string(config, group, key, &err);
>         if (err) {
>                 if (err->code !=3D G_KEY_FILE_ERROR_KEY_NOT_FOUND)
>                         DBG("%s", err->message);
> @@ -430,12 +431,7 @@ static bool parse_config_string(GKeyFile *config, co=
nst char *group,
>                 return false;
>         }
>
> -       DBG("%s.%s =3D %s", group, key, tmp);
> -
> -       if (val) {
> -               g_free(*val);
> -               *val =3D tmp;
> -       }
> +       DBG("%s.%s =3D %s", group, key, *val);
>
>         return true;
>  }
> @@ -1004,7 +1000,12 @@ static void parse_secure_conns(GKeyFile *config)
>
>  static void parse_general(GKeyFile *config)
>  {
> -       parse_config_string(config, "General", "Name", &btd_opts.name);
> +       char *str =3D NULL;
> +
> +       if (parse_config_string(config, "General", "Name", &str)) {
> +               g_free(btd_opts.name);
> +               btd_opts.name =3D str;
> +       }

Yeah, I skip this on purpose, I don't quite like the idea that we have
to do this for 1 specific entry, perhaps the better option is to
incorporate the default values into the table table so we avoid having
this problem of having to free like this.

>         parse_config_hex(config, "General", "Class", &btd_opts.class);
>         parse_config_u32(config, "General", "DiscoverableTimeout",
>                                                 &btd_opts.discovto,
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
