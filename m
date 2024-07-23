Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCB2F32
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721703326; cv=none; b=Ixf0YV21ZH9A+Ti2E01zVIl4D7SdJhBcnx2wpIsHW0nbObkd9eZWkbYeKVqKif8WsDxZlvcu1vkATQJq9wwfkJaGoQGHukybmdCS9n89/mFmnTPAEeO1vpPByavroz+fH6p8Jp1T2A5P6fJU7gBpvMt6cQfrFp6Z12AOoUNOFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721703326; c=relaxed/simple;
	bh=TL5y3Zf8KChZH5hQpWV2bCXwWmdaai4dXJnlsQRGtqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVnaGIBBu8c+fa7sxXdArTCMMOw2jLeyeIVIDoEdIOmws4lyDbyJADF23VZ5WAGj/Pr8aq8RLTj6q3OCFunN2LTExvku0gEdT767QVI14jHAHgaCwSZojOoZUJWTnu9AdpAcwEjXm6WuAj9ryhQwjKcsr3tzXtaUbg3msNS/Prw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWtNqkJl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWtNqkJl"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso16880551fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 19:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721703323; x=1722308123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/kY53in09JwGj5BtNjOJIHgDbr6pNJT6xTIRR6ENSw=;
        b=EWtNqkJlr6kQlt8JOba5ZQxjpZP28VMCfpdFz7CHShqib+33sN8uXMRyDvOKLDT8O3
         p7dk+3v7vUU+6chxdATQiuMjBFXb3UMDUD5gsF76diZt1+4G5jfYU4DQtHceBu8mCq2G
         6bKfG6okH4L7ZRWhbnOOPtASllHA0rVeSvoBIxktEh/Sp3bsQKr5itaLNVSiRiuwH8HO
         vfO+Ej5rdwkrDCBbwcvLA880ZAZRuaA8Y9IPMJRi1OECRogKVqMYoGIgAOjl+hahj1Al
         atb7YX1xa3Vht/YtBVBNB/KUXxorISELtzFpl+Fm1Nl9kuNz+GTaTwIcGNdzqU1xGvbG
         nd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721703323; x=1722308123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/kY53in09JwGj5BtNjOJIHgDbr6pNJT6xTIRR6ENSw=;
        b=Vh7bJQVBvdPFmRNglBn1kvY1xK4ICEq7aMkVvSlLKYcPsgk+H8glshNZOHSqPNl9aU
         vccTkKrLFPzsuUsx9d59KfIlXGulsdIa5H+IJ2LIkjTmXI0o70FglQz3lBU0iVLuE3AG
         oeXZk0GARUAQtnDCVMuHKG6gkGPbw/1ZS7xfl7OFkiPuzLG3T1XN2De8zR/J2fPnyQgm
         DYKMxg9vEYULtkqhcoLhdujBy81mZTyhbptTT2UfBJrBSmdTrfjuc9l+349h8snVxcuj
         b6zuk7xpix996qcr/u7qU7xXXzo+qeeNLd/zOgKt/SevujDoyBwrvT8VJ7ecGl4bFGfQ
         M0vQ==
X-Gm-Message-State: AOJu0Yz/TRUHUTqryg5/0orSATDxcXcENltD/c/lvM4myGuFdzA+wlUY
	kHWPfz4BBl83j+RyakcVQb08zh0h0Nni2JVEKhs5TnRa/5sIQ+aC2JsiSDffevmCrv7KfxzfKW5
	8avp/mohT9XkEvMMNFKeb59klzOM=
X-Google-Smtp-Source: AGHT+IEHsm7rPm1JlOuZapgduTkETh2MkzfsvzAlX1J0IWE8/fbuYkyWWvkr3U0z0s79tPzvmQ3QziNGOkLMa72SJw4=
X-Received: by 2002:a05:651c:1052:b0:2ef:2fc9:c8b2 with SMTP id
 38308e7fff4ca-2ef2fc9ca5amr30520381fa.37.1721703322634; Mon, 22 Jul 2024
 19:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722075626.3050334-1-clancy_shang@163.com>
 <CABBYNZKFEBuW2OeU4uOSfku=-jCnn3oXJENDMBGmkqP-4rybDA@mail.gmail.com> <1c525ed7.13cb.190dd367dda.Coremail.clancy_shang@163.com>
In-Reply-To: <1c525ed7.13cb.190dd367dda.Coremail.clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jul 2024 22:55:04 -0400
Message-ID: <CABBYNZKPF=gOdybx+3y867v5RG=MDUK9p4ONKug5+_P3G+-_Zg@mail.gmail.com>
Subject: Re: Re: [PATCH] [BlueZ] adapter: Fix execute "LE Add Device To
 Resolving List" command fail
To: clancy_shang <clancy_shang@163.com>
Cc: linux-bluetooth@vger.kernel.org, Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 22, 2024 at 9:31=E2=80=AFPM clancy_shang <clancy_shang@163.com>=
 wrote:
>
> Hi,
>
>
> I have replied the test steps in another email. the device are the same d=
eviece which different is the privace statitc address .
>
> details as follows:
>
>
>
>

Ok, how about collecting the HCI with btmon so we can actually check
other traces as well, from the looks of it this sounds like a kernel
issue though, where it is attempting to program an IRK already in the
list.

> At 2024-07-22 22:57:18, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com> w=
rote:
> >Hi,
> >
> >On Mon, Jul 22, 2024 at 3:56=E2=80=AFAM <clancy_shang@163.com> wrote:
> >>
> >> From: Clancy Shang <clancy.shang@quectel.com>
> >>
> >> According to BLUETOOTH CORE SPECIFICATION Version 5.4 | Vol 4, Part E,
> >> 7.8.38, If there is an existing entry in the resolving list with the s=
ame
> >> non-zero Peer_IRK, the Controller should return the error code Invalid
> >> HCI Command Parameters (0x12), so fix it.
> >>
> >> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> >
> >Ok, what is really going on? Why is the IRK left behind? Or are there
> >2 distinct devices with the same IRK? Perhaps the better fix would be
> >the kernel to detect if there is already the same IRK just ignore it,
> >since for the purpose of resolving the address that should work, that
> >said we should have detected if the device has the same IRK then it
> >shall have the same identity address so something doesn't add up here.
> >
> >> ---
> >>  src/adapter.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 72 insertions(+)
> >>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index 85ddfc165..495c9f631 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -8901,6 +8901,76 @@ static void store_irk(struct btd_adapter *adapt=
er, const bdaddr_t *peer,
> >>         g_key_file_free(key_file);
> >>  }
> >>
> >> +static void delete_exist_irk_from_directory(
> >> +                                               struct btd_adapter *ad=
apter,
> >> +                                               const unsigned char *k=
ey)
> >> +{
> >> +       char dirname[PATH_MAX];
> >> +       GError *gerr =3D NULL;
> >> +       DIR *dir;
> >> +       struct dirent *entry;
> >> +
> >> +       create_filename(dirname, PATH_MAX, "/%s",
> >> +                               btd_adapter_get_storage_dir(adapter));
> >> +
> >> +       dir =3D opendir(dirname);
> >> +       if (!dir) {
> >> +               btd_error(adapter->dev_id,
> >> +                               "Unable to open adapter storage direct=
ory: %s",
> >> +                                                               dirnam=
e);
> >> +               return;
> >> +       }
> >> +
> >> +       while ((entry =3D readdir(dir)) !=3D NULL) {
> >> +               struct btd_device *device;
> >> +               char filename[PATH_MAX];
> >> +               GKeyFile *key_file;
> >> +               struct irk_info *irk_info;
> >> +               uint8_t bdaddr_type;
> >> +
> >> +               if (entry->d_type =3D=3D DT_UNKNOWN)
> >> +                       entry->d_type =3D util_get_dt(dirname, entry->=
d_name);
> >> +
> >> +               if (entry->d_type !=3D DT_DIR || bachk(entry->d_name) =
< 0)
> >> +                       continue;
> >> +
> >> +               create_filename(filename, PATH_MAX, "/%s/%s/info",
> >> +                                       btd_adapter_get_storage_dir(ad=
apter),
> >> +                                       entry->d_name);
> >> +
> >> +               key_file =3D g_key_file_new();
> >> +               if (!g_key_file_load_from_file(
> >> +                                                               key_fi=
le,
> >> +                                                               filena=
me,
> >> +                                                               0,
> >> +                                                               &gerr)=
) {
> >> +                       error("Unable to load key file from %s: (%s)",
> >> +                                       filename, gerr->message);
> >> +                       g_clear_error(&gerr);
> >> +               }
> >> +
> >> +               bdaddr_type =3D get_le_addr_type(key_file);
> >> +
> >> +               irk_info =3D get_irk_info(key_file, entry->d_name, bda=
ddr_type);
> >> +
> >> +               if (irk_info) {
> >> +                       if (!memcmp(irk_info->val, key, 16)) {
> >> +                               DBG("Has same irk,delete it");
> >> +                               device =3D btd_adapter_find_device(ada=
pter,
> >> +                                                       &irk_info->bda=
ddr,
> >> +                                                       irk_info->bdad=
dr_type);
> >> +                               if (device)
> >> +                                       btd_adapter_remove_device(adap=
ter,
> >> +                                                                     =
  device);
> >> +                       }
> >> +               }
> >> +               g_key_file_free(key_file);
> >> +       }
> >> +
> >> +       closedir(dir);
> >> +
> >> +}
> >> +
> >>  static void new_irk_callback(uint16_t index, uint16_t length,
> >>                                         const void *param, void *user_=
data)
> >>  {
> >> @@ -8950,6 +9020,8 @@ static void new_irk_callback(uint16_t index, uin=
t16_t length,
> >>         if (!persistent)
> >>                 return;
> >>
> >> +       delete_exist_irk_from_directory(adapter, irk->val);
> >> +
> >>         store_irk(adapter, &addr->bdaddr, addr->type, irk->val);
> >>
> >>         btd_device_set_temporary(device, false);
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
> >--
> >Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
