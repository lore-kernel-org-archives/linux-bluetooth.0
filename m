Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EB28DC1
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706785; cv=none; b=YltG1hkW3bvd+lizhP1uUm1x5+nZusUEyqvnlcT+Bfv/GH14H8FpkJ0T2caHCbAPH76KqE+gXIgxEeRxqwOcR2HEoAyLQzHOJrq0b1ZqU71sS81YsOLpbfapioHChUaWVlUOphgiF2bsxoV6CUQYySlkP5GrGNmq3bK6S2DfN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706785; c=relaxed/simple;
	bh=PxLsSiTXsPyDGXmiWDjv2zpzNcKFI4/SFUFhPSK+1EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbNIkxkxRIt7aWKi71pBbtHD6J7D+8JgNzZ/JWHdTVVw3CezB5dxb4uRkDVXVFe3WUSt3tZlmQ8MAkDXCuZngjXXUusFhhxFUX7xHFvjVC/9hngQz7sLzTrtmBBAKGkjJmk4Y6ZZU8Txv5emaXyIpW/oL6whFXWL8hNOzMwAafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXqgR0+A; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXqgR0+A"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3f07ac2dcso53166911fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724706782; x=1725311582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EbJ/cULufonvqvLkFJ1WIOLVmKRz6tp0l9WMUOXDJY=;
        b=mXqgR0+A7xXnT81zsykCrnM+G98PSJ9uOtKtLzAPHFQWf+tDW8Ll/jK3Eq1YSjz+75
         yudFEAQy1mhTlfuxIZCtdgwE3P73Fjmj2NSyD6pVgDKO4tXs5G5Csi0Sx0XSB/q+ki5s
         P3v5hdHrplJBhU1rq3JI4dnOUtYLiQIeDDsDN29epSoqXIi9B2Y4mDeMdl297taGNQgU
         eTJ2svxHv65oXzicy553p9IPhIRuBeEyfaLMNtQfy9YkW8MlzrF9Kfvsn8n8rDm/fxC0
         EsqBPJsfDkdPwlaLfi+QI7Fah0cFRiqi44Tv3mPwkaBQLu6OQdA9zLeOqxPsakl9RwGA
         p9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724706782; x=1725311582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EbJ/cULufonvqvLkFJ1WIOLVmKRz6tp0l9WMUOXDJY=;
        b=OAGe/veMoS2q8W3JM/udGdFja/dC2EyaFAcqs+ftP1YS+znUojf7OcRG7yfYPUcXmO
         AUuo2lty5HH+mvkFmmeMzzPjKZwKdOz7lO2xo2PFZpLCTP0fIX5bY4c5QzJZx1Lo3uB1
         zEZ4Xpm27yWh5SCOnLrzfcQzz8g/nZcl8BqSEUveqyzR/UKIhasOmpsgkGDHZIiuDgD1
         CtVuBDft5is2lxZVJnY1rkRWV0u5K0a06zYFpJB42q+UJAIIMIXO88PBNV2TLYK2i/rn
         GqVephY5Zf5jEcS5cuFITAvuCuazI+1+evvQohfQ8EfzxoP8RC0VFb6qLTzb1JCC/IGR
         9OoA==
X-Forwarded-Encrypted: i=1; AJvYcCWr5CGmGsQ4QWP00H+bO+PFGRfpPK4lv8Di/kK/tLBaNnh3PWJ0DGXcbAoYvoH4Ou0ZJ2ZhPJBw7S+pp+CHW2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnGiaGtThRY04OlqO0+hyrdGg5dsapoAF3pF/FTdG0xUK8m57
	8BpeXs/HWrFjZEmOf3pcJ3HZg9D1BXGauMO2JQ6bcVuPhAN1Io1WAnhRyrljWyYff5xPHK+dhux
	GTEyRTSAsOf2y91AvluKAkehRbmo=
X-Google-Smtp-Source: AGHT+IEdrFm009HrbPBUQdMOZ/9CWzSgv7DhkOAAnH3ta6hF/BrHBLOQZkargUFRnFx48Ni2HuF95zxLuKkqMnurE3Y=
X-Received: by 2002:a2e:bc25:0:b0:2ef:243b:6dce with SMTP id
 38308e7fff4ca-2f4f5728c0bmr84683291fa.10.1724706780906; Mon, 26 Aug 2024
 14:13:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211162729.1183207-1-xiaokeqinhealth@126.com> <55903fdb-e970-4b89-b620-daa93bad7811@archlinux.org>
In-Reply-To: <55903fdb-e970-4b89-b620-daa93bad7811@archlinux.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 26 Aug 2024 17:12:47 -0400
Message-ID: <CABBYNZ+X1gWovfui7Vyaag80PFz_1q4A_F7r=wpgF_gm9f9orA@mail.gmail.com>
Subject: Re: [PATCH 1/2] adapter: Fix addr_type for smp_irk/ltk_info/link_key
To: Robin Candau <antiz@archlinux.org>
Cc: Xiao Yao <xiaokeqinhealth@126.com>, linux-bluetooth@vger.kernel.org, 
	Xiao Yao <xiaoyao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiao,

On Fri, Dec 15, 2023 at 8:06=E2=80=AFPM Robin Candau <antiz@archlinux.org> =
wrote:
>
> On 12/11/23 17:27, Xiao Yao wrote:
>
> From: Xiao Yao <xiaoyao@rock-chips.com>
>
> According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 3,
> Part H, 2.4.24/2.4.25, The LE LTK and BR/EDR link keys can be
> converted between each other, so the addr type can be either
> BREDR or LE, so fix it.
>
> Signed-off-by: Xiao Yao <xiaoyao@rock-chips.com>
> ---
>  src/adapter.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 86fff72bc..ee70b00d2 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -170,6 +170,7 @@ static GSList *conn_fail_list =3D NULL;
>
>  struct link_key_info {
>   bdaddr_t bdaddr;
> + uint8_t bdaddr_type;
>   unsigned char key[16];
>   uint8_t type;
>   uint8_t pin_len;
> @@ -3964,7 +3965,9 @@ static bool is_blocked_key(uint8_t key_type, uint8_=
t *key_value)
>   return false;
>  }
>
> -static struct link_key_info *get_key_info(GKeyFile *key_file, const char=
 *peer)
> +static struct link_key_info *get_key_info(GKeyFile *key_file, const char=
 *peer,
> + uint8_t bdaddr_type)
> +
>  {
>   struct link_key_info *info =3D NULL;
>   char *str;
> @@ -3976,6 +3979,7 @@ static struct link_key_info *get_key_info(GKeyFile =
*key_file, const char *peer)
>   info =3D g_new0(struct link_key_info, 1);
>
>   str2ba(peer, &info->bdaddr);
> + info->bdaddr_type =3D bdaddr_type;
>
>   if (!strncmp(str, "0x", 2))
>   str2buf(&str[2], info->key, sizeof(info->key));
> @@ -4343,7 +4347,7 @@ static void load_link_keys(struct btd_adapter *adap=
ter, GSList *keys,
>   struct link_key_info *info =3D l->data;
>
>   bacpy(&key->addr.bdaddr, &info->bdaddr);
> - key->addr.type =3D BDADDR_BREDR;
> + key->addr.type =3D info->bdaddr_type;
>   key->type =3D info->type;
>   memcpy(key->val, info->key, 16);
>   key->pin_len =3D info->pin_len;
> @@ -4598,14 +4602,18 @@ static void load_conn_params(struct btd_adapter *=
adapter, GSList *params)
>   btd_error(adapter->dev_id, "Load connection parameters failed");
>  }
>
> -static uint8_t get_le_addr_type(GKeyFile *keyfile)
> +static uint8_t get_addr_type(GKeyFile *keyfile)
>  {
>   uint8_t addr_type;
>   char *type;
>
> + /* The AddressType is written to file only When dev->le is
> + * set to true, as referenced in the update_technologies().
> + * Therefore, When type is NULL, it default to BDADDR_BREDR.
> + */
>   type =3D g_key_file_get_string(keyfile, "General", "AddressType", NULL)=
;
>   if (!type)
> - return BDADDR_LE_PUBLIC;
> + return BDADDR_BREDR;
>
>   if (g_str_equal(type, "public"))
>   addr_type =3D BDADDR_LE_PUBLIC;
> @@ -4914,9 +4922,9 @@ static void load_devices(struct btd_adapter *adapte=
r)
>   g_clear_error(&gerr);
>   }
>
> - key_info =3D get_key_info(key_file, entry->d_name);
> + bdaddr_type =3D get_addr_type(key_file);
>
> - bdaddr_type =3D get_le_addr_type(key_file);
> + key_info =3D get_key_info(key_file, entry->d_name, bdaddr_type);
>
>   ltk_info =3D get_ltk_info(key_file, entry->d_name, bdaddr_type);
>
>
> Hello,
>
> It seems like the above commit introduced a regression where the initial =
auto-connect for Bluetooth devices doesn't work anymore.
>
> Indeed, at system startup, starting a Bluetooth device will cause it to g=
o in a "connected/disconnected" state loop, requiring to initialize a manua=
l connection first (with sometimes multiple attempts needed) before getting=
 it connected correctly and working as intended.
>
> `systemctl status bluetooth` reports the following error:
>
> [...]
> d=C3=A9c. 15 11:03:18 Arch-Desktop bluetoothd[592]: Failed to load link k=
eys for hci0: Invalid Parameters (0x0d)
> [...]
>
> I bisected the bug with `git bisect` and it pointed out this commit [1] a=
s the "faulty" one.
> I can confirm that reverting it solves the issue.
>
> I reported this bug including details in the GitHub repo [2].
>
> I remain available if any additional information are needed.
>
> [1] https://github.com/bluez/bluez/commit/d5536e0cd431e22be9a1132be6d4af2=
445590633
> [2] https://github.com/bluez/bluez/issues/686
>
> --
> Regards,
> Robin Candau / Antiz

Perhaps related to:
https://github.com/bluez/bluez/issues/875#issuecomment-2311100872?
--=20
Luiz Augusto von Dentz
