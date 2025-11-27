Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446F221FB1
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257341; cv=none; b=pjNnQvPzYzP2YOK1fF83GTakX8OrXUeo4c2vR2ilZdV0iyvGeJE6sIBUcTZ+5QChGmG9UyGg1Cy8agkHUYQmY95T8mQT0BppBzus9iK6Xn31zRtk+y5zuKfWKFbh7HCjSQ4ePwt6yPdznjSrpktYyzEgt1FwQzBT2THNQVVNl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257341; c=relaxed/simple;
	bh=cPWHdJto/XeNA8iNRFEyWBhjpU5ynMqxTB9fsaxXXq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3wpy8QqzdQRIv1ZkcV+L8y+DytIDK0K4UqWbfrhycBZOtj4mKyEA54jzD7MlNu9sNnhdO/pIMnorFNFVuf4/UwF0myjsItFiP9UlldQueXHhhWUhMHG9+ZfO3Ls/Gj/YUBJuNTQ27tb3MsspWOYcB0YzIOxA21fX+HRuHZLSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME/sbfXh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME/sbfXh"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b495ce059so8576061fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764257336; x=1764862136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx2p2w1ZOyNrRMNiDwXcZY6uzThG/vrkwDiOQg4W7Yw=;
        b=ME/sbfXhxJf3I0Yw9O3s4FPLot7VIz/xInMqFhkD+IyyUH2TYfHb6VxFb2L4bULlUo
         eqzWWcND5njCEIqvRDNAeEyoZltYACXTaX2Ur1WkzuVxedxL0PDaItOUVPVdgYA4TkA+
         qVWpyA4KPqr6Qsa6BMVraQM6txFvj8rn5awkpuvyHLjgfZ3XI45GIm4xAFdT9QhdOwKp
         MKceI2OhNsr7mByBjaILix4EJDZlrVmbGi6lF6Iys7rgGQlBEUwsut0Xg16AJG/bYvfn
         KnzHZ0eUcVMMThsaCot6fr1C9RqCa/mE3b4UoO7nARWZrHqepe/EjEwUmaChsJlrXvpL
         Ed+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257336; x=1764862136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kx2p2w1ZOyNrRMNiDwXcZY6uzThG/vrkwDiOQg4W7Yw=;
        b=OzWAoOYhaoZ1mG3QklG21iLtnW6UHc8HdpM9P0HaJSMelKlcUw56GTaNQveYWl+qJS
         /qxTkEj/X/xCXjSi0qlfPTBJKR7k1v63hPfGcT7tCE+8Uld3r/VWiKRQzSdxh3Y0r2wa
         FFEpVdb9MLZ2gSchFveVJ0n+2MwyeGmCzI9WL/JKfjMBJAQkBLg/Vu/3Kcd5gWmNqeew
         CDjfjr5I5qNup7pr7ymYHcWVQgzMnxlxOodwb+fOlknWkQLEfe+vvujLyeQWZ2Y6U2Oc
         42lw0ZzcZtWUAiTeVoe88yqfcIL8ieFjK6d2U4jip0HbBi1in2pUoQuYkh6Mf5ca4+ee
         Oktw==
X-Gm-Message-State: AOJu0YyiojgwR7NCUe1oGWNoFE29myUUuidT/ejs0GJzOp2kRVYOfixS
	ODQ+2vxk3cX/PAQyS0mI9TXcp628Ax9wOa5U+YLQkKnsvTNjt6HUH832SWHKLmcoA7FpPuzod/U
	AURR0MZbS+wlkyYPQ2zaPN5ydsmC+7UqBkojY
X-Gm-Gg: ASbGnctfM525wHshoIytG+W+Rm221ka4/fBsZMEYEH0ULxMw5vlrOXnUKW/1q4CEjAE
	l+RckBn8qmP9U2x3Qlahifm5Y569i5WBo6+SCfVyl1BtviyHjVoNrDEMg3OPFNdz36SwReumTNi
	rJi2d/tvlNmaFV4n8kUzNZz92m6bfPSXlhDQSqM7ZPCF2STx4GCcKRSta2pWxZEpGkknsIe42LE
	sD24NyJ5+IMeHPdc09hdw4rz9goX1TELsPcAnrihg9pBHFJB6/Swfj9RR6i7A83L7+k4Q==
X-Google-Smtp-Source: AGHT+IGxGauIZM2RoqhbVAulXMHvhQkZnwqdaaEHMO9yUe9GxuPHMy6DAOlUTe3PcCS4BKo1CcfvDZsWD+cyaE5QBTY=
X-Received: by 2002:a05:651c:3052:b0:37a:e149:5632 with SMTP id
 38308e7fff4ca-37d0770df73mr25845431fa.2.1764257335990; Thu, 27 Nov 2025
 07:28:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127-bearer-impl-v7-0-9a5b06468992@amlogic.com> <20251127-bearer-impl-v7-3-9a5b06468992@amlogic.com>
In-Reply-To: <20251127-bearer-impl-v7-3-9a5b06468992@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Nov 2025 10:28:43 -0500
X-Gm-Features: AWmQ_bnPMOzipiJT5WR03RFoAxt1GwadaA5ajCCAouFkzFW5OEazm8G33HcNZTg
Message-ID: <CABBYNZJQTfL250wDbW+ZbadU1b_Uufv3+VAD4W6=DfAZ5T+LRg@mail.gmail.com>
Subject: Re: [PATCH bluez v7 3/3] client: Add shell cmd for bearer connect/disconnect
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 27, 2025 at 4:54=E2=80=AFAM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch adds shell command for bearer connect/disconnect.
>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
>  client/bluetoothctl.rst |  49 ++++++++++++++++
>  client/main.c           | 152 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 201 insertions(+)
>
> diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
> index 0187e877d60b28eb1e735181b3203e60da821e6f..87aae8995a29749ffa09bbfef=
bd74c41f242fedc 100644
> --- a/client/bluetoothctl.rst
> +++ b/client/bluetoothctl.rst
> @@ -296,6 +296,55 @@ needed.
>
>  :Usage: **> disconnect <dev> [uuid]**
>
> +le-connect
> +----------
> +
> +Connect device over le.
> +
> +This command initiates a le connection to a remote device.
> +
> +An active scan report is required before the connection can be
> +established. If no advertising report is received before the timeout,
> +a le-connection-abort-by-local error will be issued.
> +
> +:Usage: > le-connect <dev>
> +:Example: > le-connect 1C:48:F9:9D:81:5C
> +
> +le-disconnect
> +-------------
> +
> +Disconnect device over le.
> +
> +By default this command disconnects all profiles/services associated wit=
h the le
> +connection, and then terminates the le link.
> +
> +:Usage: > le-disconnect <dev>
> +:Example: > le-disconnect 1C:48:F9:9D:81:5C
> +
> +bredr-connect
> +-------------
> +
> +Connect device over bredr.
> +
> +This command initiates a bredr connection to a remote device.
> +
> +By default, it establishes the bredr connection and then connects all pr=
ofiles
> +that marked as auto-connectable.
> +
> +:Usage: > bredr-connect <dev>
> +:Example: > bredr-connect 1C:48:F9:9D:81:5C
> +
> +bredr-disconnect
> +----------------
> +
> +Disconnect device over bredr.
> +
> +By default this command disconnects all profiles associated with the bre=
dr
> +connection, and then terminates the bredr link.
> +
> +:Usage: > bredr-disconnect <dev>
> +:Example: > bredr-disconnect 1C:48:F9:9D:81:5C

I really meant le and bredr submenus though, not just prefixes, so we
can later expand the bearer specific functionality as needed.

>  info
>  ----
>
> diff --git a/client/main.c b/client/main.c
> index 0a928efaa9bb0d2a806895ff8f8c0c7c0d2493bd..45ebea44f9eda80f939b9f832=
4fb60064f28eb50 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2303,6 +2303,106 @@ static void cmd_disconn(int argc, char *argv[])
>                                                 proxy_address(proxy));
>  }
>
> +static void bearer_connect_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +
> +       if (dbus_set_error_from_message(&error, message) =3D=3D TRUE) {
> +               bt_shell_printf("Failed to connect: %s %s\n", error.name,
> +                               error.message);
> +               dbus_error_free(&error);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("Connection successful\n");
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void bearer_disconn_reply(DBusMessage *message, void *user_data)
> +{
> +       DBusError error;
> +
> +       dbus_error_init(&error);
> +
> +       if (dbus_set_error_from_message(&error, message) =3D=3D TRUE) {
> +               bt_shell_printf("Failed to disconnect: %s %s\n", error.na=
me,
> +                               error.message);
> +               dbus_error_free(&error);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("Disconnection successful\n");
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_bearer_method_handler(int argc, char *argv[],
> +                                       const char *iface,
> +                                       const char *method)
> +{
> +       GDBusProxy *device;
> +       GDBusProxy *bearer;
> +
> +       if (!check_default_ctrl())
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +
> +       device =3D find_proxy_by_address(default_ctrl->devices, argv[1]);
> +       if (!device) {
> +               bt_shell_printf("Device %s not available\n", argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bearer =3D find_proxies_by_iface(default_ctrl->bearers,
> +                                       g_dbus_proxy_get_path(device),
> +                                       iface);
> +       if (!bearer) {
> +               bt_shell_printf("%s is not available on %s\n",
> +                               iface, argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (!g_dbus_proxy_method_call(bearer, method, NULL,
> +                                     strcmp(method, "Connect") =3D=3D 0 =
?
> +                                       bearer_connect_reply :
> +                                       bearer_disconn_reply,
> +                                     NULL, NULL)) {
> +               bt_shell_printf("Failed to call %s\n", method);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("Attempting to %s %s on %s\n",
> +                                       method,
> +                                       argv[1],
> +                                       iface);
> +}
> +
> +static void cmd_le_connect(int argc, char *argv[])
> +{
> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.LE1",
> +                                                               "Connect"=
);
> +}
> +
> +static void cmd_le_disconnect(int argc, char *argv[])
> +{
> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.LE1",
> +                                                               "Disconne=
ct");
> +}
> +
> +static void cmd_bredr_connect(int argc, char *argv[])
> +{
> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.BREDR1",
> +                                                               "Connect"=
);
> +}
> +
> +static void cmd_bredr_disconnect(int argc, char *argv[])
> +{
> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.BREDR1",
> +                                                               "Disconne=
ct");
> +}
> +
>  static void cmd_wake(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
> @@ -2789,6 +2889,47 @@ static char *dev_set_generator(const char *text, i=
nt state)
>         return set_generator(text, state);
>  }
>
> +static char *bearer_dev_generator(const char *text, int state,
> +                                       const char *iface)
> +{
> +       char *addr;
> +       GDBusProxy *device;
> +       GDBusProxy *bearer;
> +
> +       if (!iface)
> +               return NULL;
> +
> +       addr =3D dev_generator(text, state);
> +       if (!addr)
> +               return NULL;
> +
> +       device =3D find_proxy_by_address(default_ctrl->devices, addr);
> +       if (!device)
> +               goto failed;
> +
> +       bearer =3D find_proxies_by_iface(default_ctrl->bearers,
> +                                       g_dbus_proxy_get_path(device),
> +                                       iface);
> +       if (!bearer)
> +               goto failed;
> +
> +       return addr;
> +
> +failed:
> +       g_free(addr);
> +       return NULL;
> +}
> +
> +static char *le_dev_generator(const char *text, int state)
> +{
> +       return bearer_dev_generator(text, state, "org.bluez.Bearer.LE1");
> +}
> +
> +static char *bredr_dev_generator(const char *text, int state)
> +{
> +       return bearer_dev_generator(text, state, "org.bluez.Bearer.BREDR1=
");
> +}
> +
>  static char *attribute_generator(const char *text, int state)
>  {
>         return gatt_attribute_generator(text, state);
> @@ -3528,6 +3669,17 @@ static const struct bt_shell_menu main_menu =3D {
>         { "disconnect",   "[dev] [uuid]", cmd_disconn,
>                                 "Disconnect a device or optionally discon=
nect "
>                                 "a single profile only", dev_generator },
> +       { "le-connect", "<dev>", cmd_le_connect,
> +                               "Connect le on a device", le_dev_generato=
r },
> +       { "le-disconnect", "<dev>", cmd_le_disconnect,
> +                               "Disconnect le on a device",
> +                                                       le_dev_generator =
},
> +       { "bredr-connect", "<dev>", cmd_bredr_connect,
> +                               "Connect bredr on a device",
> +                                                       bredr_dev_generat=
or },
> +       { "bredr-disconnect", "<dev>", cmd_bredr_disconnect,
> +                               "Disconnect bredr on a device",
> +                                                       bredr_dev_generat=
or },
>         { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake su=
pport",
>                                                         dev_generator },
>         { "bearer",       "<dev> [last-seen/bredr/le]", cmd_bearer,
>
> --
> 2.42.0
>
>
>


--=20
Luiz Augusto von Dentz
