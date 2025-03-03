Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE121B4247
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036453; cv=none; b=ONJLgZoMryCmvAOVmRrGJ9r45Qhi0nz2NQXEUECiHPdICB3Gov7h4QRyIAuTGL2LM88dPcwSyEjGz5x0hDrFB0VsIYDwN9IfxqPr3UlPEuou8TjiZ+zXk0pPa720VpLesR9yuEDLSJesuTNLXnMACpwvVyACKRjdW4Z4KWswMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036453; c=relaxed/simple;
	bh=BHQ9LxQG8lFWS+DVNXA/V76ZgosqfIHXfpuBjZh/f1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEBVIrbCXLlF/vSFssd3/C9efGxibBA5lRBxDU2JLxYnK82/83wCiRm50JeN+RUdkpoMiM/ZsK6z02A8t3XHIucLXe989TQhliUtgST/YnjlU8OO6CoKdtmdQWLL/xfdwZLOcHeIG5b6rWWFUkTmeDA4DaUbK21amvIqLJlcX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8hYSm2l; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8hYSm2l"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a303a656aso50858551fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Mar 2025 13:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741036449; x=1741641249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7pRLmFPEzTWIgpmKKF2BQwyf/jdju1iqRl7RleR1/k=;
        b=m8hYSm2lLvmwpFIoESyE4ed7hhIecCSE2x5hJYmxNABraXLRTIw+Dnd9Dl+h7JAcrm
         b0XrIToF0OaTpIjdz5aJodwznCKydzODgTj5JpqccRsPbZhVwJ5S00mgWalrDKTcxFHj
         4+W5XU9jcJvasxihmpOrY/JIuHxJ0orxWrH6fAqECh1hTkptMuKVV3eG2EqNb+4yUJ56
         RWe1X/vNqOCi7i8pdaz1O4+wyn5BBUxF+8iaLrotWRqiKqhtXu5UwPgneNVfVF8epuIx
         uSLIwHbUqgEs12noZYGiQ6K4jSA2hXQKgvWWShpl0fT0aGv6k2soi47UR4SFiDsMeNbU
         /LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741036449; x=1741641249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7pRLmFPEzTWIgpmKKF2BQwyf/jdju1iqRl7RleR1/k=;
        b=vXPZANC6Z9mxC9El+uULJZgNUNo5GqdDi94rZkb0sxAqo5y+eLScVJtJYJas+5xn3E
         wVhBfk+Ckoal7/VlTNGhfJ4zLgpkBsyHfYPMbqhba6krdrshNW7mQ4Lqi8hjfl9ZvGQM
         dtHl7JmThesDYxA1W01WJU4UNSTv+Hux4GrAgwPzY2uKfjA1NipggdfnN48XD8V3hctB
         cKuibdkG+mhbcK2jBzfh7mUD/u6j03an/Q7prl6KtE76hz7aIo2CSUl7a25E/3UVEQSr
         s5UYW3lzu8FUYOejMREwT7kreMuU0TXHdh10IJztjUeHB1EGy6vIzvXXQhSCluo++kxR
         f/VQ==
X-Gm-Message-State: AOJu0YxNyTclz38yMuJqgyjmHL+k8Fcw8NUW0B+IEsmgBGSvB7hYnzUN
	2OHAHpJqvmYLN3iG5+xgfrfVYZ032H+hzo2GR6tFWcN4YciWcL7R1lSXZ/sAWzGiSujT4HiSMRZ
	3GtAGsWQuJp0jAO3u0bUJE203nho=
X-Gm-Gg: ASbGncuq3zDtAtLNnHMfRmcdojFNfK4tFVwt1YN/DOcnqmMTA2RsDMZCT30qF09wVlR
	d/7HbbVQhyEiHpsooWZQ2i6AEmfNjssoKCDRUlQpTTC9BLzzmety9Z8EQ6e1kcTcTzkOhr7l6Nj
	loRejwcjA7nuYP2dx94EojIteg
X-Google-Smtp-Source: AGHT+IEvdO/WrH/7Ayaq207uFkWhw8cpU+dTACh9MT90joDOTfLooVNhMKr5DWK6ClzrcU+IoQBHrexTulhqGfS+6ls=
X-Received: by 2002:a05:651c:b0c:b0:30b:b7c3:949a with SMTP id
 38308e7fff4ca-30bb7c39f52mr33229191fa.18.1741036448877; Mon, 03 Mar 2025
 13:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJNHZ0RGA793bqhK_3VEyW-RQw+zwgLu7xgKNqpmMzYag@mail.gmail.com>
 <20250303195140.30908-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250303195140.30908-1-arkadiusz.bokowy@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Mar 2025 16:13:55 -0500
X-Gm-Features: AQ5f1Jow8Alilwjgx3iod_F5J5hOjVdvjVe9wWS7Ax3_-AxBgIB6Eei7_DVvOFI
Message-ID: <CABBYNZL3UsEQk7t2rff8gz7f=-=VbrbAvWGPkx5Kn5Mq79rfuQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] client: Support single profile connection/disconnection
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Mon, Mar 3, 2025 at 2:51=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> ---
>  client/bluetoothctl.rst | 20 +++++++--

Documentation shall be split into its own patch.

>  client/main.c           | 93 +++++++++++++++++++++++++++++++++++------

Same for uuid-helper.

>  src/uuid-helper.c       | 32 +++++++-------
>  3 files changed, 114 insertions(+), 31 deletions(-)
>
> diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
> index b6c2efa35..c60bf719f 100644
> --- a/client/bluetoothctl.rst
> +++ b/client/bluetoothctl.rst
> @@ -9,7 +9,7 @@ Bluetooth Control Command Line Tool
>  :Version: BlueZ
>  :Copyright: Free use of this software is granted under the terms of the =
GNU
>              Lesser General Public Licenses (LGPL).
> -:Date: November 2022
> +:Date: March 2024
>  :Manual section: 1
>  :Manual group: Linux System Administration
>
> @@ -262,6 +262,13 @@ Connect device.
>
>  This will initiate a connection to a device.
>
> +By default this commands tries to connect all the profiles the remote de=
vice
> +supports and have been flagged as auto-connectable. In case when the UUI=
D of
> +the remote service is given only that service will be connected. The UUI=
D can
> +be either a short form (16-bit UUID) or a long form (128-bit UUID). Ther=
e are
> +also some special values for well-known profiles like "a2dp-sink",
> +"a2dp-source", "hfp-hf", "hfp-ag", "ftp" or "spp".
> +
>  To connect with an LE device the controller must have an active scan rep=
ort of
>  the device it wants to connect to.
>
> @@ -269,17 +276,24 @@ If no advertising report is received before the tim=
eout a
>  le-connection-abort-by-local error will be issued. In that case either t=
ry
>  again to connect assuming the device is advertising.
>
> -:Usage: **> connect <dev>**
> +:Usage: **> connect <dev> [uuid]**
> +:Example: **> connect 1C:48:F9:9D:81:5C hsp-hs**
> +:Example: **> connect 1C:48:F9:9D:81:5C 00001108-0000-1000-8000-00805f9b=
34fb**
> +:Example: **> connect 1C:48:F9:9D:81:5C 0x1108**
>
>  disconnect
>  ----------
>
>  Disconnect device.
>
> +By default this commands disconnects all profiles and then terminates th=
e
> +connection. In case when the UUID of the remote service is given only th=
at
> +service will be disconnected.
> +
>  For LE when disconnecting from an active connection the device address i=
s not
>  needed.
>
> -:Usage: **> disconnect <dev>**
> +:Usage: **> disconnect <dev> [uuid]**
>
>  info
>  ----
> diff --git a/client/main.c b/client/main.c
> index 6b938da3f..3f2bfcf6b 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1981,13 +1981,44 @@ static void cmd_remove(int argc, char *argv[])
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
> @@ -2003,6 +2034,9 @@ static void connect_reply(DBusMessage *message, voi=
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
> @@ -2014,31 +2048,49 @@ static void cmd_connect(int argc, char *argv[])
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
> @@ -2046,19 +2098,31 @@ static void disconn_reply(DBusMessage *message, v=
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
> @@ -3253,10 +3317,13 @@ static const struct bt_shell_menu main_menu =3D {
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
>         { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake su=
pport",
>                                                         dev_generator },
>         { } },
> diff --git a/src/uuid-helper.c b/src/uuid-helper.c
> index f32ee0a85..640592fd2 100644
> --- a/src/uuid-helper.c
> +++ b/src/uuid-helper.c
> @@ -101,29 +101,31 @@ static struct {
>         const char      *name;
>         uint16_t        class;
>  } bt_services[] =3D {
> -       { "pbap",       PBAP_SVCLASS_ID                 },
> -       { "sap",        SAP_SVCLASS_ID                  },
> -       { "ftp",        OBEX_FILETRANS_SVCLASS_ID       },
> -       { "bpp",        BASIC_PRINTING_SVCLASS_ID       },
> +       { "a2dp-sink",  AUDIO_SINK_SVCLASS_ID           },
> +       { "a2dp-source",AUDIO_SOURCE_SVCLASS_ID         },
>         { "bip",        IMAGING_SVCLASS_ID              },
> -       { "synch",      IRMC_SYNC_SVCLASS_ID            },
> +       { "bpp",        BASIC_PRINTING_SVCLASS_ID       },
>         { "dun",        DIALUP_NET_SVCLASS_ID           },
> -       { "opp",        OBEX_OBJPUSH_SVCLASS_ID         },
>         { "fax",        FAX_SVCLASS_ID                  },
> -       { "spp",        SERIAL_PORT_SVCLASS_ID          },
> -       { "hsp",        HEADSET_SVCLASS_ID              },
> -       { "hsp-hs",     HEADSET_SVCLASS_ID              },
> -       { "hsp-ag",     HEADSET_AGW_SVCLASS_ID          },
> +       { "ftp",        OBEX_FILETRANS_SVCLASS_ID       },
> +       { "gnss",       GNSS_SERVER_SVCLASS_ID          },
>         { "hfp",        HANDSFREE_SVCLASS_ID            },
> -       { "hfp-hf",     HANDSFREE_SVCLASS_ID            },
>         { "hfp-ag",     HANDSFREE_AGW_SVCLASS_ID        },
> -       { "pbap-pce",   PBAP_PCE_SVCLASS_ID             },
> -       { "pbap-pse",   PBAP_PSE_SVCLASS_ID             },
> -       { "map-mse",    MAP_MSE_SVCLASS_ID              },
> +       { "hfp-hf",     HANDSFREE_SVCLASS_ID            },
> +       { "hsp",        HEADSET_SVCLASS_ID              },
> +       { "hsp-ag",     HEADSET_AGW_SVCLASS_ID          },
> +       { "hsp-hs",     HEADSET_SVCLASS_ID              },
>         { "map-mas",    MAP_MSE_SVCLASS_ID              },
>         { "map-mce",    MAP_MCE_SVCLASS_ID              },
>         { "map-mns",    MAP_MCE_SVCLASS_ID              },
> -       { "gnss",       GNSS_SERVER_SVCLASS_ID          },
> +       { "map-mse",    MAP_MSE_SVCLASS_ID              },
> +       { "opp",        OBEX_OBJPUSH_SVCLASS_ID         },
> +       { "pbap",       PBAP_SVCLASS_ID                 },
> +       { "pbap-pce",   PBAP_PCE_SVCLASS_ID             },
> +       { "pbap-pse",   PBAP_PSE_SVCLASS_ID             },
> +       { "sap",        SAP_SVCLASS_ID                  },
> +       { "spp",        SERIAL_PORT_SVCLASS_ID          },
> +       { "synch",      IRMC_SYNC_SVCLASS_ID            },
>         { }

These may need to go in a separate patch.

>  };
>
> --
> 2.39.5
>


--=20
Luiz Augusto von Dentz
