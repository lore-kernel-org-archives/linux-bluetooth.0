Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF134A1D
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656856; cv=none; b=eLbYK9QccjdT3Tb6U5foS7W+J5KP/wSl/o8oCDOfPyf7bpBAW7dawFq0K8A8DQs2uxFPqp6Qj2TYFFwRoQiANRGWx7XQ//LvIBv3OvM8fZ76Ot8Bk7y1fIapElP+vHH0ZeUGjYi40QoZt0gmqzsNqS6drHOzzOoIoy9DmMdpnJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656856; c=relaxed/simple;
	bh=07YP25FEA9zx6HL9STk+KVTlVCPGQFsb20czNJzGzBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOKcVgSn7CPz2Qc5DgKBiUIyrSYOL6e5c4me4sclQFgEfIFCecOlpKFySI99BVTB3E0a1LS/PzEEWy5PT2Jozl+LqFVkkwtpo16//Ihq9HAUotb1WDsgvi1qd6k8tPaqnTScRgIFe657M5tTcbCDQh56eYwbprAm2EtadsdDpPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt5fVD/I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt5fVD/I"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53f22fd6887so1408996e87.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 10:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737656852; x=1738261652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyIToWONFpkNRiW3LNq8ANLJaREEyOa7jg92gbcYfyw=;
        b=Lt5fVD/IXFKLK7OavCe1wgPb9ABJ6Q3u83rVfTpIwefRvR34AZah4oDDcS497pc11O
         Lu+iV4Yj/5/BwvxLl5I1SkoTO7FQ3NZImD6oqqj3ye9QPMxFHeV8SjBt0k5bCRNLJqM5
         YYQl4PfkZAGhSXH6gKxOCeIiv/nc5r7aU5yCG5t6BQ0Rahb1ReLWdsVIiUPTcGIDNTGB
         w0YnlvgM0kLyNN2xBEHwN2BFTX5RF+yMtMTMWJnTZuQfGZLCdYHWE4S+VN7G7M3HmIFV
         ljovCuZUKg5XfURP7c4DwbfIV6tmxva4CUuZdu/fJfn86Nwysa7BFy2boeXbRe50teFs
         IFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737656852; x=1738261652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyIToWONFpkNRiW3LNq8ANLJaREEyOa7jg92gbcYfyw=;
        b=CSB+BcHE0I5zBIRmQPCaZ6eI/JVqGmtV4/BBUAtseKMJpJIIv+E+Oo2agbRyCJPkyE
         xz6omI3u4nCeD/oNF9CJiD0hPi6xwt1T5UIB1uBMS0QlAGBJXGwg8blJTSJH8HgnDmgW
         aOtitfti2jx0nYVyV0ml2nf/yHdLMB+WNrdcMOLUAt1lwseeXUdUhE0ps0dxvZuwJFgJ
         pnqn5VxKFN1hQbv2lk3gTBivZyPP5S3mcJx/hCvHSYJcAfWvY7498Msld7Q9sgKg2RNj
         JHmmSASUC55NjcHLnqWFTx/ZBrmZqiRsVGXHtcra1lfbqbzdkMRHMn9JcGB2Hg74g6Vj
         Ly/g==
X-Gm-Message-State: AOJu0Yw6zeg3KFOc+OK2KNbCJuF+BcQ37+ZQ3Dy7T+tBi15TxE0Fwm01
	J+wUXf4Z9Ljc5vWjA/555gB8d0Bs5iNzaCPNbKyWHwprTaXWqD7T44Rht9AtrB44GsylBBvtlgV
	TLBLsQFZCDtbQg2vXY4QEBsF7DA0BNapu
X-Gm-Gg: ASbGncui5ek/8KqTxrLc08+AUNMU0DfDFAUGATzmu5vJAKiaCElKDcH61pB45jAGHlX
	lCKRcoUpRKLqQK9HSD+q8eBXlwqhdhg75VregUF2RvlcaEM6WlV6nxC0HIPu1
X-Google-Smtp-Source: AGHT+IGZqw3TJBG63kRJovizq7m/RfjC4FRzaQrVFQlINqbOkL6PPQ9+k5ROzTvlmc8KP0ZL2i+Ai74Brepf1b4Itjg=
X-Received: by 2002:a05:6512:3e1a:b0:542:98e9:63a9 with SMTP id
 2adb3069b0e04-5439c287e3dmr10745083e87.44.1737656852033; Thu, 23 Jan 2025
 10:27:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123132331.27435-1-iulia.tanasescu@nxp.com> <20250123132331.27435-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20250123132331.27435-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Jan 2025 13:27:19 -0500
X-Gm-Features: AWEUYZklr8TAWIRZ91HIAy8y3IJpyzspQ_91vEaaKRtv9fXrF1pNBlDRbWVbHDc
Message-ID: <CABBYNZ+sDUj-DVuvNzh7DWi1LDHQT-aP0881rdt5YppwQPVUJg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] client/player: Rework transport.select
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Thu, Jan 23, 2025 at 8:23=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Since the transport.select command should also work for transports
> created by audio servers, the transport should not be required to
> be associated with a local bluetoothctl endpoint, to avoid errors
> like below:

We may want to expand the documentation though to state the above in
the Select documentation:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.MediaTransport.rst

> [bluetoothctl]> scan on
> [bluetoothctl]> [NEW] Device 1C:F1:FA:E7:B0:3F 1C-F1-FA-E7-B0-3F
> [1C-F1-FA-E7-B0-3F]> [NEW] Transport
>                      /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis1/fd0
> [1C-F1-FA-E7-B0-3F]> [NEW] Transport
>                      /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis2/fd1
> [1C-F1-FA-E7-B0-3F]> transport.select
>                      /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis1/fd0
>                      /org/bluez/hci0/dev_1C_F1_FA_E7_B0_3F/bis2/fd
> Local endpoint not found
>
> This reworks transport.select to use a dedicated structure to hold
> information about the transport and its links, instead of using the
> local endpoint.
> ---
>  client/player.c | 160 +++++++++++++++++++++++-------------------------
>  1 file changed, 77 insertions(+), 83 deletions(-)
>
> diff --git a/client/player.c b/client/player.c
> index 464a9cc14..e58b42bec 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -4,7 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2020  Intel Corporation. All rights reserved.
> - *  Copyright 2023-2024 NXP
> + *  Copyright 2023-2025 NXP
>   *
>   *
>   */
> @@ -115,8 +115,6 @@ struct endpoint {
>         uint8_t iso_group;
>         uint8_t iso_stream;
>         struct queue *acquiring;
> -       struct queue *links;
> -       struct queue *selecting;
>         struct queue *transports;
>         DBusMessage *msg;
>         struct preset *preset;
> @@ -150,8 +148,14 @@ struct transport {
>         int num;
>  };
>
> -static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy);
> -static void transport_select(GDBusProxy *proxy);
> +struct transport_select_args {
> +       GDBusProxy *proxy;
> +       struct queue *links;
> +       struct queue *selecting;
> +};
> +
> +static void transport_set_links(struct transport_select_args *args);
> +static void transport_select(struct transport_select_args *args);
>
>  static void endpoint_unregister(void *data)
>  {
> @@ -2923,8 +2927,6 @@ static void endpoint_free(void *data)
>                 free(ep->preset);
>
>         queue_destroy(ep->acquiring, NULL);
> -       queue_destroy(ep->links, NULL);
> -       queue_destroy(ep->selecting, NULL);
>         queue_destroy(ep->transports, free);
>
>         g_free(ep->path);
> @@ -4891,28 +4893,45 @@ static void acquire_reply(DBusMessage *message, v=
oid *user_data)
>         return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  }
>
> +static void free_transport_select_args(struct transport_select_args *arg=
s)
> +{
> +       queue_destroy(args->links, NULL);
> +       queue_destroy(args->selecting, NULL);
> +       g_free(args);
> +}
> +
>  static void select_reply(DBusMessage *message, void *user_data)
>  {
>         DBusError error;
> -       struct endpoint *ep =3D user_data;
> +       struct transport_select_args *args =3D user_data;
> +       GDBusProxy *link;
>
>         dbus_error_init(&error);
>
>         if (dbus_set_error_from_message(&error, message) =3D=3D TRUE) {
>                 bt_shell_printf("Failed to select: %s\n", error.name);
>                 dbus_error_free(&error);
> +               free_transport_select_args(args);
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
>         bt_shell_printf("Select successful\n");
>
> -       if (queue_isempty(ep->selecting)) {
> +       if (queue_isempty(args->selecting)) {
>                 /* All links have been selected */
> -               queue_destroy(ep->selecting, NULL);
> -               ep->selecting =3D NULL;
> -
> +               free_transport_select_args(args);
>                 return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>         }
> +
> +       /* Select next link */
> +       link =3D queue_pop_head(args->selecting);
> +       if (link) {
> +               args->proxy =3D link;
> +               transport_select(args);
> +       } else {
> +               free_transport_select_args(args);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }

Seems like you could in fact remove the queue_isempty and only leave
queue_pop_head since if that is empty it would result in NULL link
anyway.

>  }
>
>  static void unselect_reply(DBusMessage *message, void *user_data)
> @@ -5174,22 +5193,23 @@ static void cmd_acquire_transport(int argc, char =
*argv[])
>
>  static void set_bcode_cb(const DBusError *error, void *user_data)
>  {
> -       GDBusProxy *proxy =3D user_data;
> +       struct transport_select_args *args =3D user_data;
>
>         if (dbus_error_is_set(error)) {
>                 bt_shell_printf("Failed to set broadcast code: %s\n",
>                                                                 error->na=
me);
> +               free_transport_select_args(args);
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
>         bt_shell_printf("Setting broadcast code succeeded\n");
>
> -       transport_select(proxy);
> +       transport_select(args);
>  }
>
>  static void set_bcode(const char *input, void *user_data)
>  {
> -       GDBusProxy *proxy =3D user_data;
> +       struct transport_select_args *args =3D user_data;
>         char *bcode;
>
>         if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
> @@ -5197,47 +5217,39 @@ static void set_bcode(const char *input, void *us=
er_data)
>         else
>                 bcode =3D g_strdup(input);
>
> -       if (g_dbus_proxy_set_property_dict(proxy, "QoS",
> +       if (g_dbus_proxy_set_property_dict(args->proxy, "QoS",
>                                 set_bcode_cb, user_data,
>                                 NULL, "BCode", DBUS_TYPE_ARRAY, DBUS_TYPE=
_BYTE,
>                                 strlen(bcode), bcode, NULL) =3D=3D FALSE)=
 {
>                 bt_shell_printf("Setting broadcast code failed\n");
>                 g_free(bcode);
> +               free_transport_select_args(args);
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
>         g_free(bcode);
>  }
>
> -static void transport_select(GDBusProxy *proxy)
> +static void transport_select(struct transport_select_args *args)
>  {
> -       struct endpoint *ep;
> -       GDBusProxy *link;
> -
> -       ep =3D find_ep_by_transport(g_dbus_proxy_get_path(proxy));
> -       if (!ep)
> -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> -
> -       if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
> -                                       select_reply, ep, NULL)) {
> +       if (!g_dbus_proxy_method_call(args->proxy, "Select", NULL,
> +                                       select_reply, args, NULL)) {
>                 bt_shell_printf("Failed select transport\n");
> +               free_transport_select_args(args);
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
> -
> -       /* Select next link */
> -       link =3D queue_pop_head(ep->selecting);
> -       if (link)
> -               transport_select(link);
>  }
>
> -static void transport_set_bcode(GDBusProxy *proxy)
> +static void transport_set_bcode(struct transport_select_args *args)
>  {
>         DBusMessageIter iter, array, entry, value;
>         unsigned char encryption;
>         const char *key;
>
> -       if (g_dbus_proxy_get_property(proxy, "QoS", &iter) =3D=3D FALSE)
> +       if (g_dbus_proxy_get_property(args->proxy, "QoS", &iter) =3D=3D F=
ALSE) {
> +               free_transport_select_args(args);
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
>
>         dbus_message_iter_recurse(&iter, &array);
>
> @@ -5253,7 +5265,7 @@ static void transport_set_bcode(GDBusProxy *proxy)
>                         if (encryption =3D=3D 1) {
>                                 bt_shell_prompt_input("",
>                                         "Enter brocast code[value/no]:",
> -                                       set_bcode, proxy);
> +                                       set_bcode, args);
>                                 return;
>                         }
>                         break;
> @@ -5264,7 +5276,7 @@ static void transport_set_bcode(GDBusProxy *proxy)
>         /* Go straight to selecting transport, if Broadcast Code
>          * is not required.
>          */
> -       transport_select(proxy);
> +       transport_select(args);
>  }
>
>  static void transport_unselect(GDBusProxy *proxy, bool prompt)
> @@ -5278,58 +5290,52 @@ static void transport_unselect(GDBusProxy *proxy,=
 bool prompt)
>
>  static void set_links_cb(const DBusError *error, void *user_data)
>  {
> -       GDBusProxy *proxy =3D user_data;
> -       const char *path =3D g_dbus_proxy_get_path(proxy);
> -       struct endpoint *ep;
> +       struct transport_select_args *args =3D user_data;
>         GDBusProxy *link;
>
> -       ep =3D find_ep_by_transport(path);
> -       if (!ep) {
> -               bt_shell_printf("Local endpoint not found\n");
> -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> -       }
> -
> -       link =3D queue_pop_head(ep->links);
> +       link =3D queue_pop_head(args->links);
>
> -       if (queue_isempty(ep->links)) {
> -               queue_destroy(ep->links, NULL);
> -               ep->links =3D NULL;
> +       if (queue_isempty(args->links)) {
> +               queue_destroy(args->links, NULL);
> +               args->links =3D NULL;
>         }
>
>         if (dbus_error_is_set(error)) {
>                 bt_shell_printf("Failed to set link %s: %s\n",
>                                                 g_dbus_proxy_get_path(lin=
k),
>                                                 error->name);
> +               free_transport_select_args(args);
>                 return bt_shell_noninteractive_quit(EXIT_FAILURE);
>         }
>
>         bt_shell_printf("Successfully linked transport %s\n",
>                                                 g_dbus_proxy_get_path(lin=
k));
>
> -       if (!ep->selecting)
> -               ep->selecting =3D queue_new();
> +       if (!args->selecting)
> +               args->selecting =3D queue_new();
>
>         /* Enqueue link to mark that it is ready to be selected */
> -       queue_push_tail(ep->selecting, link);
> +       queue_push_tail(args->selecting, link);
>
>         /* Continue setting the remanining links */
> -       transport_set_links(ep, proxy);
> +       transport_set_links(args);
>  }
>
> -static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy)
> +static void transport_set_links(struct transport_select_args *args)
>  {
>         GDBusProxy *link;
>         const char *path;
>
> -       link =3D queue_peek_head(ep->links);
> +       link =3D queue_peek_head(args->links);
>         if (link) {
>                 path =3D g_dbus_proxy_get_path(link);
>
> -               if (g_dbus_proxy_set_property_array(proxy, "Links",
> +               if (g_dbus_proxy_set_property_array(args->proxy, "Links",
>                                         DBUS_TYPE_OBJECT_PATH,
>                                         &path, 1, set_links_cb,
> -                                       proxy, NULL) =3D=3D FALSE) {
> +                                       args, NULL) =3D=3D FALSE) {
>                         bt_shell_printf("Linking transport %s failed\n", =
path);
> +                       free_transport_select_args(args);
>                         return bt_shell_noninteractive_quit(EXIT_FAILURE)=
;
>                 }
>
> @@ -5339,28 +5345,17 @@ static void transport_set_links(struct endpoint *=
ep, GDBusProxy *proxy)
>         /* If all links have been set, check is transport requires the
>          * user to provide a Broadcast Code.
>          */
> -       transport_set_bcode(proxy);
> -}
> -
> -static void endpoint_set_links(struct endpoint *ep)
> -{
> -       GDBusProxy *proxy =3D queue_pop_head(ep->links);
> -
> -       if (!proxy) {
> -               bt_shell_printf("No transport to set links for\n");
> -               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> -       }
> -
> -       transport_set_links(ep, proxy);
> +       transport_set_bcode(args);
>  }
>
>  static void cmd_select_transport(int argc, char *argv[])
>  {
>         GDBusProxy *link =3D NULL;
> -       struct queue *links =3D queue_new();
> -       struct endpoint *ep;
> +       struct transport_select_args *args;
>         int i;
>
> +       args =3D g_new0(struct transport_select_args, 1);
> +
>         for (i =3D 1; i < argc; i++) {
>                 link =3D g_dbus_proxy_lookup(transports, NULL, argv[i],
>                                         BLUEZ_MEDIA_TRANSPORT_INTERFACE);
> @@ -5375,26 +5370,25 @@ static void cmd_select_transport(int argc, char *=
argv[])
>                         goto fail;
>                 }
>
> -               /* Enqueue all links */
> -               queue_push_tail(links, link);
> -       }
> +               if (!args->proxy) {
> +                       args->proxy =3D link;
> +                       continue;
> +               }
>
> -       /* Get reference to local endpoint */
> -       ep =3D find_ep_by_transport(g_dbus_proxy_get_path(link));
> -       if (!ep) {
> -               bt_shell_printf("Local endpoint not found\n");
> -               goto fail;
> -       }
> +               if (!args->links)
> +                       args->links =3D queue_new();
>
> -       ep->links =3D links;
> +               /* Enqueue all links */
> +               queue_push_tail(args->links, link);
> +       }
>
>         /* Link streams before selecting one by one */
> -       endpoint_set_links(ep);
> +       transport_set_links(args);
>
>         return;
>
>  fail:
> -       queue_destroy(links, NULL);
> +       free_transport_select_args(args);
>         return bt_shell_noninteractive_quit(EXIT_FAILURE);
>  }
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
