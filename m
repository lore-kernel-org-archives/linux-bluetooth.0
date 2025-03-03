Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE022C355
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026226; cv=none; b=cyeKmcIL41n+l8tJrP2WU8GgK1Lgj1rJxJjAc6NuRcl48YAq+Nj0DcqEHzAUSCcqG82EODNgcYNuTy58ejeg6cgaXxMsFmuq/Y5FZ2CUn0J1aM/Tndyh4TBR7tc2r+tmIIHkp8zkrMgOykQVdmeCTgnVA2FTgSeG/VEXQUCyUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026226; c=relaxed/simple;
	bh=ZlQHrUNMZhwQTFr8PoPMcdDYjDRcfzVj5ScOpSA2GlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyyunvVqJaKJKYuZsr5egBKbtPzC+pBjGqZj02I6Bl8j2xui+N2Hd7r/SEklx33TPXKa81WpxBhrNqUOpoQX3lF/MD0XMD2k/5zPrgnQIKNRvQtrGsS44oEePhJ4aUEbQaEorn+xcX3rAEXx9kRrxACOWUXJY1ZQWGNQPSno85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFMonOG7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFMonOG7"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bb2fdbb09so16068971fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741026223; x=1741631023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hI/bZWcoKrGpVTdd16TdcggCvFJzllgm4asrFtmfeTk=;
        b=CFMonOG76Eble+uIQpUvFj0CyLLDmh1mDVP14XOUDMmUj5WP/kbEcl2LqQSNPDSOWm
         wdlTiHVVekxCKvw1rQ81jPQFDmdhJKdam0L1tKRrheNgtfsGrwWUNUuk75bhWC2LLpnq
         hwm4IOWBGDfnSLU2RdIJnMBB1U08n18FkUbL4YC7JrY9ExiPqKve6r3Vio3+tsppu637
         X88DAjEaFtM9mR/NWrjfLtGseen3L6Woxmsp6wCzSRsiJ2u5yN5zqC1qb96/dEjSYtxq
         8zaPZEDPshJdcK4gXV1IbklsjQni8VnK1UJiD0UQJPFFsU4qTwzgyATeuv10MRSRuz8e
         wOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026223; x=1741631023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hI/bZWcoKrGpVTdd16TdcggCvFJzllgm4asrFtmfeTk=;
        b=WwvDBYA4pIB2WEmL4uPG6Pb7hIsXZZmFIpy+YPSYCftPc8CdvgbUGE0EMzJRtNcQ9A
         mE5uNJpv3oTlIWZ9dhUMYxkPXYycKHDzzRp4f0N7u6xP9syB/TJs/JNZH9R1tGng5AZw
         U4qeyeYR3tQ1qeC9RrtMnHNBgUCpDkO790zu9U5OdviHFylQi3q8c4pGmbLuOfOzhV9J
         SZkWh51zX2WqOn40kEAFrFZEFe80ZPJSwawjRFngx5NkJTIy8CSiAkgxEdMhDttG5kxz
         lS2uCYeVUzTL8oyLw44ftzp89SE+atrameqDleNenkIgENLd8azcicLaIJZgDMNXAIJQ
         956A==
X-Gm-Message-State: AOJu0YxZAf8/l/mMFxU2BqBjOgSK1UVrQhuZWEvZ+M0DOcHuOnK4p6o0
	GfUm90Iu3dJ+TialfsaJj33I7BBCMDsGpICXf+C09iPpTWqQ6t6m1j6reHGtVEJJZA2mltGbqit
	Azln9mzsfITcrTB63FAMlLsgRc/M=
X-Gm-Gg: ASbGncuVBOhWj9N2c0SpGEBKQZWyzv4RwUHQoiAxrbjkGjL8CJ2N5GAFm+XYmklU7pr
	AXiOFvTZxjSsaVS4vNVJMkEPWDbpHOt2ymAJDa5natp5T04Ml6BYLnSvohoKdk445jcN8CnTCCu
	VUdgIoPhTPzF3MnI61th9cAa0i
X-Google-Smtp-Source: AGHT+IGMmm85G7BuGsWL4rnds9CzR6puWOEEm0TUPz5B0eVurKuvXxcx7EEIIsieeliFFeC4jEdOKTY+oAYBA44Qy9g=
X-Received: by 2002:a2e:bc18:0:b0:30b:b7c3:ea71 with SMTP id
 38308e7fff4ca-30bb7c3ef87mr23078051fa.15.1741026222602; Mon, 03 Mar 2025
 10:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302164736.22101-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250302164736.22101-1-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Mar 2025 13:23:30 -0500
X-Gm-Features: AQ5f1JoyXNT5OW5gCt4zd17G-mxyNwE2nPKhhvsdGmAVJBdpsKdTWTdhKPo_o6s
Message-ID: <CABBYNZJNHZ0RGA793bqhK_3VEyW-RQw+zwgLu7xgKNqpmMzYag@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client: Support single profile connection/disconnection
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Sun, Mar 2, 2025 at 11:47=E2=80=AFAM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> ---
>  client/main.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 13 deletions(-)
>
> diff --git a/client/main.c b/client/main.c
> index feb21a116..e4ed692ec 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1969,13 +1969,44 @@ static void cmd_remove(int argc, char *argv[])
>         remove_device(proxy);
>  }
>
> +struct connection_data {
> +       GDBusProxy *proxy;
> +       char *uuid;
> +};
> +
> +static void connection_setup(DBusMessageIter *iter, void *user_data)
> +{
> +       struct connection_data *data =3D user_data;
> +
> +       if (!data->uuid)
> +               return;
> +
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &data->uui=
d);
> +}
> +
> +static void format_connection_profile(char *output, size_t size,
> +                                                       const char *uuid)
> +{
> +       const char *text;
> +
> +       text =3D bt_uuidstr_to_str(uuid);
> +       if (!text)
> +               text =3D uuid;
> +
> +       snprintf(output, size, " profile \"%s\"", text);
> +}
> +
>  static void connect_reply(DBusMessage *message, void *user_data)
>  {
> -       GDBusProxy *proxy =3D user_data;
> +       struct connection_data *data =3D user_data;
> +       GDBusProxy *proxy =3D data->proxy;
>         DBusError error;
>
>         dbus_error_init(&error);
>
> +       g_free(data->uuid);
> +       g_free(data);
> +
>         if (dbus_set_error_from_message(&error, message) =3D=3D TRUE) {
>                 bt_shell_printf("Failed to connect: %s %s\n", error.name,
>                                 error.message);
> @@ -1991,6 +2022,9 @@ static void connect_reply(DBusMessage *message, voi=
d *user_data)
>
>  static void cmd_connect(int argc, char *argv[])
>  {
> +       struct connection_data *data;
> +       const char *method =3D "Connect";
> +       char profile[128] =3D "";
>         GDBusProxy *proxy;
>
>         if (check_default_ctrl() =3D=3D FALSE)
> @@ -2002,31 +2036,49 @@ static void cmd_connect(int argc, char *argv[])
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       if (g_dbus_proxy_method_call(proxy, "Connect", NULL, connect_repl=
y,
> -                                                       proxy, NULL) =3D=
=3D FALSE) {
> +       data =3D new0(struct connection_data, 1);
> +       data->proxy =3D proxy;
> +
> +       if (argc =3D=3D 3) {
> +               method =3D "ConnectProfile";
> +               data->uuid =3D g_strdup(argv[2]);
> +               format_connection_profile(profile, sizeof(profile), argv[=
2]);
> +       }
> +
> +       if (g_dbus_proxy_method_call(proxy, method, connection_setup,
> +                                       connect_reply, data, NULL) =3D=3D=
 FALSE) {
>                 bt_shell_printf("Failed to connect\n");
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       bt_shell_printf("Attempting to connect to %s\n", argv[1]);
> +       bt_shell_printf("Attempting to connect%s to %s\n", profile, argv[=
1]);
>  }
>
>  static void disconn_reply(DBusMessage *message, void *user_data)
>  {
> -       GDBusProxy *proxy =3D user_data;
> +       struct connection_data *data =3D user_data;
> +       const bool profile_disconnected =3D data->uuid !=3D NULL;
> +       GDBusProxy *proxy =3D data->proxy;
>         DBusError error;
>
>         dbus_error_init(&error);
>
> +       g_free(data->uuid);
> +       g_free(data);
> +
>         if (dbus_set_error_from_message(&error, message) =3D=3D TRUE) {
>                 bt_shell_printf("Failed to disconnect: %s\n", error.name)=
;
>                 dbus_error_free(&error);
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       bt_shell_printf("Successful disconnected\n");
> +       bt_shell_printf("Disconnection successful\n");
>
> -       if (proxy =3D=3D default_dev)
> +       /* If only a single profile was disconnected, the device itself m=
ight
> +        * still be connected. In that case, let the property change hand=
ler
> +        * take care of setting the default device to NULL.
> +        */
> +       if (proxy =3D=3D default_dev && !profile_disconnected)
>                 set_default_device(NULL, NULL);
>
>         return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> @@ -2034,19 +2086,31 @@ static void disconn_reply(DBusMessage *message, v=
oid *user_data)
>
>  static void cmd_disconn(int argc, char *argv[])
>  {
> +       struct connection_data *data;
> +       const char *method =3D "Disconnect";
> +       char profile[128] =3D "";
>         GDBusProxy *proxy;
>
>         proxy =3D find_device(argc, argv);
>         if (!proxy)
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>
> -       if (g_dbus_proxy_method_call(proxy, "Disconnect", NULL, disconn_r=
eply,
> -                                                       proxy, NULL) =3D=
=3D FALSE) {
> +       data =3D new0(struct connection_data, 1);
> +       data->proxy =3D proxy;
> +
> +       if (argc =3D=3D 3) {
> +               method =3D "DisconnectProfile";
> +               data->uuid =3D g_strdup(argv[2]);
> +               format_connection_profile(profile, sizeof(profile), argv[=
2]);
> +       }
> +
> +       if (g_dbus_proxy_method_call(proxy, method, connection_setup,
> +                                       disconn_reply, data, NULL) =3D=3D=
 FALSE) {
>                 bt_shell_printf("Failed to disconnect\n");
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
> -       bt_shell_printf("Attempting to disconnect from %s\n",
> +       bt_shell_printf("Attempting to disconnect%s from %s\n", profile,
>                                                 proxy_address(proxy));
>  }
>
> @@ -3241,10 +3305,13 @@ static const struct bt_shell_menu main_menu =3D {
>                                                                 dev_gener=
ator },
>         { "remove",       "<dev>",    cmd_remove, "Remove device",
>                                                         dev_generator },
> -       { "connect",      "<dev>",    cmd_connect, "Connect device",
> -                                                       dev_generator },
> -       { "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
> +       { "connect",      "<dev> [uuid]", cmd_connect,
> +                               "Connect a device and all its profiles or=
 "
> +                               "optionally connect a single profile only=
",
>                                                         dev_generator },
> +       { "disconnect",   "[dev] [uuid]", cmd_disconn,
> +                               "Disconnect a device or optionally discon=
nect "
> +                               "a single profile only", dev_generator },

Great idea, but let's update the documentation as well so it reflects
this change (client/bluetoothctl.rst), also it is probably worth
adding a few examples like connect/disconnect all/hfp/a2dp, etc.

>         { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake su=
pport",
>                                                         dev_generator },
>         { } },
> --
> 2.39.5
>
>


--=20
Luiz Augusto von Dentz
