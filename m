Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394531598F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660254; cv=none; b=iFaCxe3KWJ8+fs1qAsYLa6Ou9XnSwfazqGIXvxRzurve+ry3b0ZioLnn+W8Y46s/qb9Ku/cpbstVDtvG4AszGpsfSZkXasHD+O3ExzxDwfce+XlxQNOUF7ED7ObiY8MZRNweM+gfboYjiDPFt0KkoCxJ21OJL4gJu/BEOc/VyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660254; c=relaxed/simple;
	bh=fj3PCXA2jZmVfs2HT02DMJGlkXx4ZvZAWTyMF7K9adE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M56BvrMgKWvvOVLUmbhVPAiHMkPDkEDJjGYwgGU0WALSOyBJsH1t05ig/052lCIMhTtRyvNx93+mkNkA7dxFpgL7xKl8pA/arR/59uNG0+6EG2TMcFSnSUdcwSUc1eKZQtTJ13ryUhnA1YoeI0WUy0jHCkdrhgVlPbwNp8yJxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI4lHf9j; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI4lHf9j"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f01e9f53ebso360241fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721660251; x=1722265051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzdUhg7pE18Wpt/jHbWaUudxUGdJWj0mX0Sy2zp+duA=;
        b=VI4lHf9jg0kmss/3TVaKoIbXLkT5OGq+PkmbQ04zHv6hUMfszsoJg+009TxSNBe6dA
         WnqqRZVV4kANimx/jcxs7YOjzUccQEtaJi9j4leHYn+hkSOa0lOZd6+9pAB0jopok7Hx
         G8Y0leLBA3iovtA4cGwRM4F5NN93hM1IkSbHymbqxuuSPqqAM1w8p9lHLZURwLoqr9v0
         ypqkNiPBaeEUMbt08K0l42CXcF1gAIZ7BT1bgI2lFkZCkSkRl2NLP7xILaJnvl/xesln
         ilGO+IRRqufLey38HWYA/YphME0rFBldpqAobU7TsKxizn9YjzBmCFVxditsvpJVDrlG
         mJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721660251; x=1722265051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzdUhg7pE18Wpt/jHbWaUudxUGdJWj0mX0Sy2zp+duA=;
        b=GY9ERHL49OMleh2dzWXIcTRnAp7aRZvF4yHLEijYAc4gVCE75111HGLDviPkoSECou
         Qh3ZAq41iSEa1TB1YFqX1J2lK/RWdggukxGi4OaJXjbRBxxjnKw8AjLZ+TBYFQaCrBMx
         jU8dh+2S3JcT5MwoJYy5Aat2nJmSMzPjz7Lghig5MUrOTUEK5vJ/UdXiIUxnWqpBA2CD
         ruSYemgzCyV3ZvRYgQ+mh31ef2JR07mHEvq9NyGgaWXxLqE8kZChSpbW2sK5WHPreawK
         7NwTYPv0HtVIXEe/PplvPY2GCdwqlZwyPrnWnMJBPYw0RNKax2w8/uy18Sqa6nBN8VB8
         MBgQ==
X-Gm-Message-State: AOJu0Yx2JwHsA8tdZWGnFFI7IhwfeFgyJGwjWtB2Dq6hoNwXZ4rmHnHI
	FwwINaw4i/+iIPAfoOEftPoLrrr/HUuB9qUAwFYRDWcv/bBWOd9nwrUsWR8z1AbYjlj2w0OlqN/
	vufKvYVYUZWTJgcniTIhtVqfj6SFbQA==
X-Google-Smtp-Source: AGHT+IGDpQCiFG6yybrnkgRhowQgwzT519kugeMTOTa7qA4rsd5Tlb12M2be4JKWlg7A3TEQzb1f8ZvzKFQkNQDNwUE=
X-Received: by 2002:a2e:a54b:0:b0:2ef:2f4b:deeb with SMTP id
 38308e7fff4ca-2ef2f4c1181mr29078501fa.23.1721660251075; Mon, 22 Jul 2024
 07:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722075626.3050334-1-clancy_shang@163.com>
In-Reply-To: <20240722075626.3050334-1-clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jul 2024 10:57:18 -0400
Message-ID: <CABBYNZKFEBuW2OeU4uOSfku=-jCnn3oXJENDMBGmkqP-4rybDA@mail.gmail.com>
Subject: Re: [PATCH] [BlueZ] adapter: Fix execute "LE Add Device To Resolving
 List" command fail
To: clancy_shang@163.com
Cc: linux-bluetooth@vger.kernel.org, Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 22, 2024 at 3:56=E2=80=AFAM <clancy_shang@163.com> wrote:
>
> From: Clancy Shang <clancy.shang@quectel.com>
>
> According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E,
> 7.8.38, If there is an existing entry in the resolving list with the same
> non-zero Peer_IRK, the Controller should return the error code Invalid
> HCI Command Parameters (0x12), so fix it.
>
> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>

Ok, what is really going on? Why is the IRK left behind? Or are there
2 distinct devices with the same IRK? Perhaps the better fix would be
the kernel to detect if there is already the same IRK just ignore it,
since for the purpose of resolving the address that should work, that
said we should have detected if the device has the same IRK then it
shall have the same identity address so something doesn't add up here.

> ---
>  src/adapter.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 85ddfc165..495c9f631 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8901,6 +8901,76 @@ static void store_irk(struct btd_adapter *adapter,=
 const bdaddr_t *peer,
>         g_key_file_free(key_file);
>  }
>
> +static void delete_exist_irk_from_directory(
> +                                               struct btd_adapter *adapt=
er,
> +                                               const unsigned char *key)
> +{
> +       char dirname[PATH_MAX];
> +       GError *gerr =3D NULL;
> +       DIR *dir;
> +       struct dirent *entry;
> +
> +       create_filename(dirname, PATH_MAX, "/%s",
> +                               btd_adapter_get_storage_dir(adapter));
> +
> +       dir =3D opendir(dirname);
> +       if (!dir) {
> +               btd_error(adapter->dev_id,
> +                               "Unable to open adapter storage directory=
: %s",
> +                                                               dirname);
> +               return;
> +       }
> +
> +       while ((entry =3D readdir(dir)) !=3D NULL) {
> +               struct btd_device *device;
> +               char filename[PATH_MAX];
> +               GKeyFile *key_file;
> +               struct irk_info *irk_info;
> +               uint8_t bdaddr_type;
> +
> +               if (entry->d_type =3D=3D DT_UNKNOWN)
> +                       entry->d_type =3D util_get_dt(dirname, entry->d_n=
ame);
> +
> +               if (entry->d_type !=3D DT_DIR || bachk(entry->d_name) < 0=
)
> +                       continue;
> +
> +               create_filename(filename, PATH_MAX, "/%s/%s/info",
> +                                       btd_adapter_get_storage_dir(adapt=
er),
> +                                       entry->d_name);
> +
> +               key_file =3D g_key_file_new();
> +               if (!g_key_file_load_from_file(
> +                                                               key_file,
> +                                                               filename,
> +                                                               0,
> +                                                               &gerr)) {
> +                       error("Unable to load key file from %s: (%s)",
> +                                       filename, gerr->message);
> +                       g_clear_error(&gerr);
> +               }
> +
> +               bdaddr_type =3D get_le_addr_type(key_file);
> +
> +               irk_info =3D get_irk_info(key_file, entry->d_name, bdaddr=
_type);
> +
> +               if (irk_info) {
> +                       if (!memcmp(irk_info->val, key, 16)) {
> +                               DBG("Has same irk,delete it");
> +                               device =3D btd_adapter_find_device(adapte=
r,
> +                                                       &irk_info->bdaddr=
,
> +                                                       irk_info->bdaddr_=
type);
> +                               if (device)
> +                                       btd_adapter_remove_device(adapter=
,
> +                                                                       d=
evice);
> +                       }
> +               }
> +               g_key_file_free(key_file);
> +       }
> +
> +       closedir(dir);
> +
> +}
> +
>  static void new_irk_callback(uint16_t index, uint16_t length,
>                                         const void *param, void *user_dat=
a)
>  {
> @@ -8950,6 +9020,8 @@ static void new_irk_callback(uint16_t index, uint16=
_t length,
>         if (!persistent)
>                 return;
>
> +       delete_exist_irk_from_directory(adapter, irk->val);
> +
>         store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
>
>         btd_device_set_temporary(device, false);
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
