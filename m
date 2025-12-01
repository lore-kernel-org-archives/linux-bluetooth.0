Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA9279DC3
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764628178; cv=none; b=EIET3Bu1O67Xsa8+4GcSu0v9eyjaxgUzjWdBbL96bl5D0z0VG3wZ+lBsBVMRYWGycd4pwhFydV6EV4f48INXeLZ111viU39v3AJGsLbYlKpdK+ahOgZuSSLFGvvPGbP7JlCxFUs2MeulbywaxxM5R4pjlCZKfedKwBTlDEj4blA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764628178; c=relaxed/simple;
	bh=BMCPfXsczalKD5lcsJVfoJeSDrUhQTUswbasNh46mSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNaUpUiM99ZEk6qU0dDr/Evf4elZCjIcnndACPRtcuxf2BFq88UDM92T5pIH5ea6O2szFSH8rK/sOVEr67Btr7pvUrxPlafdlWxvNw7CqHiOUI2ZRSBAyXfXuLXTftfGYz8MM9Lu0+ds9vMW4/z/B05Fbkukyn29RBX5OgVSDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrEpXvHm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrEpXvHm"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37b935df7bfso44902161fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Dec 2025 14:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764628174; x=1765232974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRRVPZrPQcOHpo4i+meDE5/iDJWcZH/sDBtsB92sHqU=;
        b=QrEpXvHmcOQxIw680BxsoJLVtV8UAuOSplAk3vQpOAmQJFdg/YE2ARU5rwzHj1viIM
         /XMC3G48zOYg9UFQ/FEio3RprxmUGn+GmqIo89HV2UAKNEmXb1c4ypvc53WEjVmmAyld
         kAuehoMcf98STi06SCPxsJyPHl3k+jib58cYers17O+5/nfph52B0lFTAQR6mDWdwRB4
         VYHpGQJd8EN1ieyjg4KqzKkjgj8E4nUi/l+9EghheW0T64Op7Uv/T6E/iM5cIa0bTReC
         rj/zFCVCBgQwcj7cb5Pxj/oRNcsttKjlF3XwfEXs8nzvPS7S7UQyvo0fFaJIzVov0GOT
         lqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764628174; x=1765232974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tRRVPZrPQcOHpo4i+meDE5/iDJWcZH/sDBtsB92sHqU=;
        b=b+hFIYeya7wo/PLNFTCcMR1FlDxJ38nNU4ieE8mAFweDLo1SDuMvgMNN94tqgwb+gt
         5ItMtpq0Tl45WAtd2ZAhHTIm+vN0tj3jeiHZrjUEvvKJZeNKO7/MSYBNFAhES52MzBu7
         2zYk+xU+lVnXzeoOIYWvTMLtStKUb6iPJ5wzu3+C9sXMsF+KSh2Tb1IjRHn6IZOCMkSV
         KJ1qgcBlVMLDd5hKvqg+to0iM7vnBPs37xiIwUiqkTlIQNHSM1mO5DjbiLoH4v/QIUKS
         5zsGUkmQw9JKBMcrX5gm3YDnT4c12VYyUzZz6ccBCM7je/8xX/af/0/uLHeS6u1Odk79
         mnOQ==
X-Gm-Message-State: AOJu0YyyEBXEliT8jX1ofDvkNPXVCH64t5MCEQlpmqbonZCgjU3B3Nm5
	5QbDPV8HXBCTEgbog6ZGMii36aldM36qtp3TrN1C7CjjHJMVFl1UgbTUfv0TIstMo4v2VogGEMm
	68ykmYK0GRG7FK5GrPxLioC8G/ptZ+TqcZOoj
X-Gm-Gg: ASbGnctI+jRRbCVngwC2W3nr2H3DZNKrhsDZgkm7Pj33FNrMAtdkjEXLU19gbnR5LYh
	Z+yAWA27FL1J6awbAxJED1cfDrIUHCnshEmy8JYSGXOqfPpve6BYH2NYn/i4OuZ1dO7SMI7OGNk
	GOOTWePcSMGuSFTfcgtrhdH04/0j9unp7if6PdZscLaNoKlFYm2FgDo4+rCYsVm6VyQb04P2ZCP
	fowN/bRNCAObOs8WKW6EgFHFIHTbdoHES/1gIi2E0GvnRGjbEk0+ycR/D//OMNzUxYWGw==
X-Google-Smtp-Source: AGHT+IG1YUPM1WCWuStrSMvg4JUpbvDz/ocbpOQzmO6L9ziXCpMUluh3eTkRCpsk0UBl4xO6xlovONBG/a4egSOiToM=
X-Received: by 2002:a2e:91c4:0:b0:37a:3963:cec5 with SMTP id
 38308e7fff4ca-37cd92b2e33mr76423751fa.43.1764628174198; Mon, 01 Dec 2025
 14:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-bearer-impl-v8-0-f944b6f9f201@amlogic.com> <20251201-bearer-impl-v8-3-f944b6f9f201@amlogic.com>
In-Reply-To: <20251201-bearer-impl-v8-3-f944b6f9f201@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Dec 2025 17:29:22 -0500
X-Gm-Features: AWmQ_bnW_AeggosJZASm-BkqcYs6DuumMb8EPwaAEfswBLkFME3JwkZlPBoB1wM
Message-ID: <CABBYNZLNvKPHmJAtybnXHP29kMgeJ6v2fF7OT+5e6QBCUdvLqg@mail.gmail.com>
Subject: Re: [PATCH bluez v8 3/3] client: Add shell cmd for bearer connect/disconnect
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 1, 2025 at 3:29=E2=80=AFAM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch adds shell command for bearer connect/disconnect.
>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
>  client/bluetoothctl-bredr.rst |  70 +++++++++
>  client/bluetoothctl-le.rst    |  71 +++++++++
>  client/bluetoothctl.rst       |  10 ++
>  client/main.c                 | 324 ++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 475 insertions(+)
>
> diff --git a/client/bluetoothctl-bredr.rst b/client/bluetoothctl-bredr.rs=
t
> new file mode 100644
> index 0000000000000000000000000000000000000000..3ec702a59ff35261f6eb71cf7=
7b3267229bbad8b
> --- /dev/null
> +++ b/client/bluetoothctl-bredr.rst
> @@ -0,0 +1,70 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl-bredr
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +-------------
> +BREDR Submenu
> +-------------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under the terms of the =
GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: December 2025
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [--options] [bredr.commands]
> +
> +BREDR Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +list
> +----
> +
> +List available bredr devices.
> +
> +:Usage: **> list**
> +
> +show
> +----
> +
> +Show bredr bearer information on a device.
> +
> +:Usage: **> show [dev]**
> +
> +connect
> +-------
> +
> +Connect device over bredr.
> +
> +This command initiates a bredr connection to a remote device.
> +
> +By default, it establishes the bredr connection and then connects all pr=
ofiles
> +that marked as auto-connectable.
> +
> +:Usage: > connect <dev>
> +:Example: > connect 1C:48:F9:9D:81:5C
> +
> +disconnect
> +----------
> +
> +Disconnect device over bredr.
> +
> +By default this command disconnects all profiles associated with the bre=
dr
> +connection, and then terminates the bredr link.
> +
> +:Usage: > disconnect <dev>
> +:Example: > disconnect 1C:48:F9:9D:81:5C
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl-le.rst b/client/bluetoothctl-le.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..808d5786ee805a61228a5195c=
c731a5f46de9201
> --- /dev/null
> +++ b/client/bluetoothctl-le.rst
> @@ -0,0 +1,71 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +bluetoothctl-le
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +----------
> +LE Submenu
> +----------
> +
> +:Version: BlueZ
> +:Copyright: Free use of this software is granted under the terms of the =
GNU
> +            Lesser General Public Licenses (LGPL).
> +:Date: December 2025
> +:Manual section: 1
> +:Manual group: Linux System Administration
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**bluetoothctl** [--options] [le.commands]
> +
> +LE Commands
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +list
> +----
> +
> +List available le devices.
> +
> +:Usage: **> list**
> +
> +show
> +----
> +
> +Show le bearer information on a device.
> +
> +:Usage: **> show [dev]**
> +
> +connect
> +-------
> +
> +Connect device over le.
> +
> +This command initiates a le connection to a remote device.
> +
> +An active scan report is required before the connection can be
> +established. If no advertising report is received before the timeout,
> +a le-connection-abort-by-local error will be issued.
> +
> +:Usage: > connect <dev>
> +:Example: > connect 1C:48:F9:9D:81:5C
> +
> +disconnect
> +----------
> +
> +Disconnect device over le.
> +
> +By default this command disconnects all profiles/services associated wit=
h the le
> +connection, and then terminates the le link.
> +
> +:Usage: > disconnect <dev>
> +:Example: > disconnect 1C:48:F9:9D:81:5C
> +
> +RESOURCES
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +http://www.bluez.org
> +
> +REPORTING BUGS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +linux-bluetooth@vger.kernel.org
> diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
> index 0187e877d60b28eb1e735181b3203e60da821e6f..f8d6c345797722aeb1550d903=
a268c7d756545f9 100644
> --- a/client/bluetoothctl.rst
> +++ b/client/bluetoothctl.rst
> @@ -371,6 +371,16 @@ Assistant Submenu
>
>  See **bluetoothctl-assistant(1)**
>
> +LE Submenu
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +See **bluetoothctl-le(1)**
> +
> +BREDR Submenu
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +See **bluetoothctl-bredr(1)**
> +
>  AUTOMATION
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Two common ways to automate the tool are to use Here Docs or the program=
 expect.
> diff --git a/client/main.c b/client/main.c
> index 0a928efaa9bb0d2a806895ff8f8c0c7c0d2493bd..464243ea3b7247f4ae2be4796=
43c44380af82917 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2789,6 +2789,47 @@ static char *dev_set_generator(const char *text, i=
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
> @@ -3296,6 +3337,253 @@ static void cmd_adv_monitor_get_supported_info(in=
t argc, char *argv[])
>         adv_monitor_get_supported_info();
>  }
>
> +static void print_le_properties(GDBusProxy *proxy)
> +{
> +       GDBusProxy *device;
> +
> +       device =3D find_proxies_by_path(default_ctrl->devices,
> +                                       g_dbus_proxy_get_path(proxy));
> +
> +       if (!device)
> +               return;
> +
> +       bt_shell_printf("Device %s\n", proxy_address(device));
> +
> +       /* New properties may add to org.bluez.Bearer.LE1. */
> +       print_property(proxy, "Paired");
> +       print_property(proxy, "Bonded");
> +       print_property(proxy, "Connected");
> +}
> +
> +static void print_le_bearers(void *data, void *user_data)
> +{
> +       GDBusProxy *proxy =3D data;
> +
> +       if (!strcmp(g_dbus_proxy_get_interface(proxy),
> +                                     "org.bluez.Bearer.LE1"))
> +               print_le_properties(data);
> +}
> +
> +static void print_bredr_properties(GDBusProxy *proxy)
> +{
> +       GDBusProxy *device;
> +
> +       device =3D find_proxies_by_path(default_ctrl->devices,
> +                                       g_dbus_proxy_get_path(proxy));
> +
> +       if (!device)
> +               return;
> +
> +       bt_shell_printf("Device %s\n", proxy_address(device));
> +
> +       /* New properties may add to org.bluez.Bearer.BREDR1. */
> +       print_property(proxy, "Paired");
> +       print_property(proxy, "Bonded");
> +       print_property(proxy, "Connected");
> +}
> +
> +static void print_bredr_bearers(void *data, void *user_data)
> +{
> +       GDBusProxy *proxy =3D data;
> +
> +       if (!strcmp(g_dbus_proxy_get_interface(proxy),
> +                                     "org.bluez.Bearer.BREDR1"))
> +               print_bredr_properties(data);
> +}
> +
> +static void cmd_list_le(int argc, char *argv[])
> +{
> +       GList *l;
> +       GDBusProxy *device;
> +
> +       for (l =3D default_ctrl->devices; l; l =3D g_list_next(l)) {
> +               device =3D l->data;
> +               if (find_proxies_by_iface(default_ctrl->bearers,
> +                                     g_dbus_proxy_get_path(device),
> +                                     "org.bluez.Bearer.LE1"))
> +                       print_device(device, NULL);
> +       }
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_list_bredr(int argc, char *argv[])
> +{
> +       GList *l;
> +       GDBusProxy *device;
> +
> +       for (l =3D default_ctrl->devices; l; l =3D g_list_next(l)) {
> +               device =3D l->data;
> +               if (find_proxies_by_iface(default_ctrl->bearers,
> +                                     g_dbus_proxy_get_path(device),
> +                                     "org.bluez.Bearer.BREDR1"))
> +                       print_device(device, NULL);
> +       }
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_show_le(int argc, char *argv[])
> +{
> +       GDBusProxy *device;
> +       GDBusProxy *bearer;
> +
> +       /* Show all le bearers if no argument is given */
> +       if (argc !=3D 2) {
> +               g_list_foreach(default_ctrl->bearers, print_le_bearers, N=
ULL);
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +       }
> +
> +       device =3D find_proxy_by_address(default_ctrl->devices, argv[1]);
> +       if (!device) {
> +               bt_shell_printf("Device %s not found\n", argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bearer =3D find_proxies_by_iface(default_ctrl->bearers,
> +                                     g_dbus_proxy_get_path(device),
> +                                     "org.bluez.Bearer.LE1");
> +       if (!bearer) {
> +               bt_shell_printf("LE bearer not found on %s\n", argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       print_le_properties(bearer);
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void cmd_show_bredr(int argc, char *argv[])
> +{
> +       GDBusProxy *device;
> +       GDBusProxy *bearer;
> +
> +       /* Show all bredr bearers if no argument is given */
> +       if (argc !=3D 2) {
> +               g_list_foreach(default_ctrl->bearers, print_bredr_bearers=
,
> +                                                                       N=
ULL);
> +               return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +       }
> +
> +       device =3D find_proxy_by_address(default_ctrl->devices, argv[1]);
> +       if (!device) {
> +               bt_shell_printf("Device %s not found\n", argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bearer =3D find_proxies_by_iface(default_ctrl->bearers,
> +                                     g_dbus_proxy_get_path(device),
> +                                     "org.bluez.Bearer.BREDR1");
> +       if (!bearer) {
> +               bt_shell_printf("BREDR bearer not found on %s\n", argv[1]=
);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       print_bredr_properties(bearer);
> +
> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
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
> +       bt_shell_printf("Attempting to %s %s with %s\n",
> +                                       method,
> +                                       argv[1],
> +                                       iface);
> +}
> +
> +static void cmd_connect_le(int argc, char *argv[])
> +{
> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.LE1",
> +                                                               "Connect"=
);
> +}
> +
> +static void cmd_disconnect_le(int argc, char *argv[])
> +{
> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.LE1",
> +                                                               "Disconne=
ct");
> +}
> +
> +static void cmd_connect_bredr(int argc, char *argv[])
> +{
> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.BREDR1",
> +                                                               "Connect"=
);
> +}
> +
> +static void cmd_disconnect_bredr(int argc, char *argv[])
> +{
> +       cmd_bearer_method_handler(argc, argv, "org.bluez.Bearer.BREDR1",
> +                                                               "Disconne=
ct");
> +}
> +
>  static const struct bt_shell_menu advertise_menu =3D {
>         .name =3D "advertise",
>         .desc =3D "Advertise Options Submenu",
> @@ -3469,6 +3757,40 @@ static const struct bt_shell_menu gatt_menu =3D {
>         { } },
>  };
>
> +static const struct bt_shell_menu le_menu =3D {
> +       .name =3D "le",
> +       .desc =3D "LE Bearer Submenu",
> +       .entries =3D {
> +       { "list", NULL, cmd_list_le, "List available le devices" },
> +       { "show", "[dev]", cmd_show_le,
> +                                       "LE bearer information",
> +                                       le_dev_generator },
> +       { "connect", "<dev>", cmd_connect_le,
> +                                       "Connect le on a device",
> +                                       le_dev_generator },
> +       { "disconnect", "<dev>", cmd_disconnect_le,
> +                                       "Disconnect le on a device",
> +                                       le_dev_generator },
> +       {} },
> +};
> +
> +static const struct bt_shell_menu bredr_menu =3D {
> +       .name =3D "bredr",
> +       .desc =3D "BREDR Bearer Submenu",
> +       .entries =3D {
> +       { "list", NULL, cmd_list_bredr, "List available bredr devices" },
> +       { "show", "[dev]", cmd_show_bredr,
> +                                       "BREDR bearer information",
> +                                       bredr_dev_generator },
> +       { "connect", "<dev>", cmd_connect_bredr,
> +                                       "Connect bredr on a device",
> +                                       bredr_dev_generator },
> +       { "disconnect", "<dev>", cmd_disconnect_bredr,
> +                                       "Disconnect bredr on a device",
> +                                       bredr_dev_generator },
> +       {} },
> +};
> +
>  static const struct bt_shell_menu main_menu =3D {
>         .name =3D "main",
>         .entries =3D {
> @@ -3593,6 +3915,8 @@ int main(int argc, char *argv[])
>         bt_shell_add_submenu(&advertise_monitor_menu);
>         bt_shell_add_submenu(&scan_menu);
>         bt_shell_add_submenu(&gatt_menu);
> +       bt_shell_add_submenu(&le_menu);
> +       bt_shell_add_submenu(&bredr_menu);
>         admin_add_submenu();
>         player_add_submenu();
>         mgmt_add_submenu();
>
> --
> 2.42.0

Just tried something simple:

[bluetoothctl]> le.connect 88:92:CC:54:B8:FD
Attempting to Connect 88:92:CC:54:B8:FD with org.bluez.Bearer.LE1
[bluetoothctl]> le.connect 88:92:CC:54:B8:FD
Attempting to Connect 88:92:CC:54:B8:FD with org.bluez.Bearer.LE1
Failed to connect: org.bluez.Error.InProgress In Progress
Failed to connect: org.freedesktop.DBus.Error.NoReply Did not receive
a reply. Possible causes include: the remote application did not send
a reply, the message bus security policy blocked the reply, the reply
timeout expired, or the network connection was broken.

Looks like it doesn't handle things like connection timeout, etc, so
bearer.connect is never cleanup, nor any reply is generated.

>
>


--=20
Luiz Augusto von Dentz
