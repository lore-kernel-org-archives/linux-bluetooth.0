Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE42101F2
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447540; cv=none; b=C6mH9sjru9tyKuB26VVvGNamaYVVeCIFgrAiDSp+Q8sZC1Y4Rhes2IEeUbHjVbszyHsL+Q2Q5dEHtaG3Yh+WfTZTCAaUvA5xE+jz/2V0SVUNbj6fJvWpQsMX5qGmTapK/bjiHcPgaUuQHGEaV9N5N9ahPGl6hfLW7rWaCf6JOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447540; c=relaxed/simple;
	bh=UeP5wWeY/PHDdEMJ7xb10F6uNp+1NcHjzBLUz+QEBoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VkqqwGF9aVBXb320j09LukH6qqpYpiBso30ZfoQM1Pev70aAanXVAwmUtI7zeEtwTumYmIQ2oESgLaSg9kmLSK60iwJx7xXYw2gWLjdtDJY90G7ucWAyM7yYZerr1DiEmv6wX9cM/i4xKslzKPwpcZJCSjRT5NYhwE6QYQDW81E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5nk5WCe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5nk5WCe"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-208ccde82e6so18426915ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727447538; x=1728052338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGshuMhUi31rLD3vo8imJhAfUbp4AQprUmb56tDp1wI=;
        b=d5nk5WCemtIg03JJlyaDZTfyxPd7ckrSba1b3Y+piFxStQvhgVX00CGPVpmQEvuR8U
         jvetbuj4eVvml7gZvYGr1dI3sh0Gjv5rqH+Hr7721Zu62xk4U+SCAJ8tYDE6caqTeMFr
         pv54m9grN04Gy1ixCTpTyLh/sp8vm/5fl54rB4fEaS+r9zpFVviy7blSvUNaZFYomRBg
         nEhGs/j5ydCv5gYmyRrNvSpEc6jLqKDeqXVojVsdl25FAXkj9tHYccUCg+gNfjF7Ngln
         wQnLi0szN5Un19H8libzdVVUV7fCOE3399WFY6E8jG+hXnEh3whdMrBDM+0h79Gq5uqs
         WFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727447538; x=1728052338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGshuMhUi31rLD3vo8imJhAfUbp4AQprUmb56tDp1wI=;
        b=flCgYsiOdr9SPY7Q/tt1zOQyRf+ATWYz9SKvOp9YoBdtSdc180hgUvtQGFctlKIewN
         k6OwqkQReP81SgZLhNpXTkHGbPVRuUuJRj5lWUHTeA04GO1KWXaR0KJm8uNwamHmwdHw
         hrmhDYhD9SILnVbgP1SSjXrtCjPtARKteClEaQc6Hio3V4V/MvPZylv3FBGtLT2qfxkg
         2J0tNTuhfdy4K67G9UUY8NychWPUAWVCmQdggsqnT1078F4SlCnPSA4ie7A0FHCHK1rx
         T69cml3f4xPzmG3/tVxGkZCROB1JpFpkCWS+SbrCpWsTpJmWhviZD52JAlG6IwEOeSW2
         POmg==
X-Gm-Message-State: AOJu0YxTPkMBuSGZQLAQk9Nofq5+XBXOaBt1x2nssal9F64XO/y7/DXM
	yHd9c8nR2cATB5+MY//eQiW+p71NYz6jsnNZfw1QZTRSxYheY+6E5GMwdor8pcOClUGzaPgEk06
	2CptjpF8q36uGYUsjFgmAbv23kdFVyoin
X-Google-Smtp-Source: AGHT+IHdcl7ver1hyUqDfTUqlpU1y3z70kUZkNmQiiD45Tc0K4Iypj5sSfzt7Eo1TgHOjPkXznehIfF9mmMzNPv9qT0=
X-Received: by 2002:a17:90a:f404:b0:2d8:dd14:79ed with SMTP id
 98e67ed59e1d1-2e0b8ea5e93mr3798993a91.31.1727447537913; Fri, 27 Sep 2024
 07:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927131441.2617450-1-quic_chejiang@quicinc.com>
In-Reply-To: <20240927131441.2617450-1-quic_chejiang@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Sep 2024 10:31:51 -0400
Message-ID: <CABBYNZJVVTqw=rz3ndWvak6=9PaQe0H1uwzT5qT+BK5D0R+_yg@mail.gmail.com>
Subject: Re: [PATCH v1] Client: Fix the list_attributes command returning
 nothing for a dual-mode remote
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Fri, Sep 27, 2024 at 9:16=E2=80=AFAM Cheng Jiang <quic_chejiang@quicinc.=
com> wrote:
>
> When a dual-mode device is paired first on BR/EDR and
> then on BLE through RPA, the RPA changes to a public
> address after receiving the IRK. This results in two proxies
> in default_ctrl->devices with the same public address.
> In cmd_list_attributes, if the BR/EDR proxy is found first,
> it prints no attributes.

This seems to be a bug then, if we resolve the address and there is
already a device object for it then that shall be used instead of
keeping 2 different objects paths, fixing bluetoothctl to allow
multiple proxies with the same device won't do anything for other
clients so this is just a workaround.

There seems to be some code for detecting and merging the objects:

/* It is possible that we have two device objects for the same device in
 * case it has first been discovered over BR/EDR and has a private
 * address when discovered over LE for the first time. In such a case we
 * need to inherit critical values from the duplicate so that we don't
 * ovewrite them when writing to storage. The next time bluetoothd
 * starts the device will show up as a single instance.
 */
void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup)

But it doesn't seem to carry over the services, etc, as it seems we
can't really just use one object at this point then both need to
interact with each other, perhaps by storing the duplicate into
btd_device so the right object can be used depending on the bearer,
etc.

> Modify cmd_list_attributes to search all proxies in
> default_ctrl->devices and display the related attributes.
> ---
>  client/main.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/client/main.c b/client/main.c
> index 50aa3e7a6..17c1fb278 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -768,6 +768,29 @@ static GDBusProxy *find_proxy_by_address(GList *sour=
ce, const char *address)
>         return NULL;
>  }
>
> +static GList *find_all_proxy_by_address(GList *source, const char *addre=
ss)
> +{
> +       GList *list;
> +       GList *all_proxy =3D NULL;
> +
> +       for (list =3D g_list_first(source); list; list =3D g_list_next(li=
st)) {
> +               GDBusProxy *proxy =3D list->data;
> +               DBusMessageIter iter;
> +               const char *str;
> +
> +               if (g_dbus_proxy_get_property(proxy, "Address", &iter) =
=3D=3D FALSE)
> +                       continue;
> +
> +               dbus_message_iter_get_basic(&iter, &str);
> +
> +               if (!strcasecmp(str, address))
> +                       all_proxy =3D g_list_append(all_proxy, proxy);
> +       }
> +
> +       return all_proxy;
> +}
> +
> +
>  static gboolean check_default_ctrl(void)
>  {
>         if (!default_ctrl) {
> @@ -2051,7 +2074,9 @@ static void cmd_disconn(int argc, char *argv[])
>
>  static void cmd_list_attributes(int argc, char *argv[])
>  {
> -       GDBusProxy *proxy;
> +       GList *all_proxy =3D NULL;
> +       GList *list;
> +       GDBusProxy *proxy =3D NULL;
>         const char *path;
>
>         if (argc > 1 && !strcmp(argv[1], "local")) {
> @@ -2059,11 +2084,33 @@ static void cmd_list_attributes(int argc, char *a=
rgv[])
>                 goto done;
>         }
>
> -       proxy =3D find_device(argc, argv);
> -       if (!proxy)
> +       if (argc < 2 || !strlen(argv[1])) {
> +               if (default_dev) {
> +                       proxy =3D default_dev;
> +                       path =3D g_dbus_proxy_get_path(proxy);
> +                       goto done;
> +               }
> +               bt_shell_printf("Missing device address argument\n");
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       } else {
> +               if (check_default_ctrl() =3D=3D FALSE)
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>
> -       path =3D g_dbus_proxy_get_path(proxy);
> +               all_proxy =3D find_all_proxy_by_address(default_ctrl->dev=
ices,
> +                                                               argv[1]);
> +               if (!all_proxy) {
> +                       bt_shell_printf("Device %s not available\n", argv=
[1]);
> +                       return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
> +               }
> +               for (list =3D g_list_first(all_proxy); list;
> +                                               list =3D g_list_next(list=
)) {
> +                       proxy =3D list->data;
> +                       path =3D g_dbus_proxy_get_path(proxy);
> +                       gatt_list_attributes(path);
> +               }
> +               g_list_free(all_proxy);
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +       }
>
>  done:
>         gatt_list_attributes(path);
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
