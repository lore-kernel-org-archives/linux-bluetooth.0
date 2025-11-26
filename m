Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3237303A09
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167750; cv=none; b=WIq1+yajaRx16tnj81iZd0TR9ynbGjjltsyRKWrQ7wVeUJbMETiW7B4Tb5vfFhy/Qq5/8dUdyz0V/J5CCIlvGCF/IXRbOwJwJ57S1+q6GgTLi4wTyE/N02u6BAtaJPpiST0nWf5h0Hilx1pCEvqVxdQNNM6rO/GzhqVgAG9TWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167750; c=relaxed/simple;
	bh=TcmZ+wAAS5tQPJBEU4QTypkW3RYLdTotD0Od7/PF/+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aghY6ZbDBlQlQmW4aeGuY0NyswJwhLEFmjuY/d9jdBSeJQ41ZfviVp3kNP03cCdfHCikYTWbJBkzLQiBOaLw4wHL68HDMizTxv3C1HoGCjD9DLeGDrCyATfB2ZjE01/nAWbE1vCidJtBIUH+m8dis08y374Czpv5HM7rU3JIHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOikbPG1; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOikbPG1"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37ba5af5951so30342191fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 06:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764167747; x=1764772547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VRS2l7H8ouVUtHWgzfDZd/58q1aZUMQoCsBc03FOIs=;
        b=GOikbPG1zI40Gic1uuBTM++wlcjqS4TOUNgttQISzwCarVlxTyZc8DFi545uqWP1fm
         O0+ebTMpG4OjeFHFAS5q6QrL8b7wg1AH6QyA7t7yGl1lRnC/yjB1gf0IX0OX6YBZu5Mb
         bISKAzPZpfgVNzcZ4Fg7TqX5f1sfkvaYjVe0paCej7zEczquX4gUzcWHHHkVAszRPJpr
         k+vKVH14DplFHRAz/j8pKcqmwQC/gVESL+sQV4LrxSb/15LfR6TIfNm431CxqJkLz/Sy
         /DKZk3zUQNVLgswm9gUGgEgG8f+KpxEUPYFFI8Cq5wZAnn0TuCpMrC8UkrH3FHC21TQy
         IjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764167747; x=1764772547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3VRS2l7H8ouVUtHWgzfDZd/58q1aZUMQoCsBc03FOIs=;
        b=LOwXyEZWuP6Ivho2MNMDlwXjzP/EuPVuhZYTAAgJaAAlBav4qxJYp9IO+3mhnwUsHw
         17DiSL5pbF6tqgqzj37DMRxeL0dBW72WIBOlL55mBk5syvTx3mH6b+bM9lE6ygmHwM/F
         QxhsXkKEO5YeNpKoujYykoxYXkxKzQb1LrBEowCWKBjDfFMgVUpi+ijgyJl1PrJhsAUL
         E8iNEZgDBtTVdUnDxUBDi3Gqu5eHAcAWAAxudzVuooOnrymSw0gg1y7OYSrjbm6MBA42
         NUmXc0DOZOe+RzfXp2pXP2F56jO59ALIQpBXlSP70mPoIy3il0VJyJzs0fPdLkuv4iVm
         3VLw==
X-Gm-Message-State: AOJu0YwBImIPw4ryFlMgBEgkwxCc46rQh3Ad8gi/6vuzPVBpk7Aw6MMl
	vDgYTR11oAXo63Dj3Bh58WtHFqrvmtdUS5DpQAFIhdXCf2QZlhcFN1cCeIFy7ws5rRz3KKT/epS
	fbWrr2dJcgNmVDOkKrmcZvofu76i18GZbIDuH
X-Gm-Gg: ASbGnctwZOH/8su0Am6aWf290slmWU+egXd/dhi92ypRVqW6zTB/inOrg0gc2dmAj5Z
	rmc+xvVwVz5L07SBgQdm83qAaDBu289GTDZynIqCyqRthDUJQrZMRdZWMHmxq1Imv+yh2rzYcOF
	1x0Pfl2wqJ4mpIrZ8seqsR+sElCSnfZjCUHydReq/nqovpz3uy8BAh3JCMVOTTahbFqyLnUQao0
	M9RtJthInUpewskcpOqHb/xoSTGUiIT2obHWlByorjxmVs6xVBRcveY5iG/IaFi9Yu8eQ==
X-Google-Smtp-Source: AGHT+IFsof0B4JCXWUkjJ7onCps2y/VCyThij8PR80z1G5EAQmSaKKgx34yM4vH22QL94q1vf+Y0ZzPqTeuuHhYHMpk=
X-Received: by 2002:a2e:9d4f:0:b0:37b:b952:5e2 with SMTP id
 38308e7fff4ca-37cd919c5aamr40383431fa.16.1764167746530; Wed, 26 Nov 2025
 06:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126-bearer-impl-v6-0-e93fd41f10b6@amlogic.com> <20251126-bearer-impl-v6-3-e93fd41f10b6@amlogic.com>
In-Reply-To: <20251126-bearer-impl-v6-3-e93fd41f10b6@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 26 Nov 2025 09:35:34 -0500
X-Gm-Features: AWmQ_blBhb_wBtHQz5J18wO7qAVc0QjEkh-0H1NSwOcYZdePLR5riVZcvVsvLyg
Message-ID: <CABBYNZK2TpPjdraCC+WuY5u-yvAiyCJZAf-FrjtoLO7Qntp8uQ@mail.gmail.com>
Subject: Re: [PATCH bluez v6 3/3] client: Add shell cmd for bearer connect/disconnect
To: ye.he@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 26, 2025 at 12:21=E2=80=AFAM Ye He via B4 Relay
<devnull+ye.he.amlogic.com@kernel.org> wrote:
>
> From: Ye He <ye.he@amlogic.com>
>
> This patch adds shell command for bearer connect/disconnect.
>
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
>  client/bluetoothctl.rst |  34 ++++++++++++
>  client/main.c           | 141 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 175 insertions(+)
>
> diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
> index 0187e877d60b28eb1e735181b3203e60da821e6f..e10933eb90e9d1ab830ebba6d=
210d940b2d91d35 100644
> --- a/client/bluetoothctl.rst
> +++ b/client/bluetoothctl.rst
> @@ -296,6 +296,40 @@ needed.
>
>  :Usage: **> disconnect <dev> [uuid]**
>
> +connect-bearer
> +--------------
> +
> +Connect device with specified bearer.
> +
> +This command initiates a bearer-level connection to a remote device.
> +
> +By default this command connects the specified bearer (LE or BREDR)
> +and all profiles that are associated with that bearer and marked as
> +auto-connectable. Only the profiles bound to the selected bearer
> +will be considered, profiles on the other bearer are not affected.
> +
> +For LE connections an active scan report is required before the connecti=
on
> +can be established. If no advertising report is received before the time=
out,
> +a le-connection-abort-by-local error will be issued.
> +
> +:Usage: > connect-bearer <dev> <le/bredr>
> +:Example: > connect-bearer 1C:48:F9:9D:81:5C le
> +:Example: > connect-bearer 1C:48:F9:9D:81:5C bredr
> +
> +disconnect-bearer
> +-----------------
> +
> +Disconnect device with specified bearer.
> +
> +By default this command disconnects all profiles associated with the spe=
cified
> +bearer (LE or BREDR) and then terminates that bearer's link. Only profil=
es
> +bound to the selected bearer are affected, profiles on the other bearer =
remain
> +connected.
> +
> +:Usage: > disconnect-bearer <dev> <le/bredr>
> +:Example: > disconnect-bearer 1C:48:F9:9D:81:5C le
> +:Example: > disconnect-bearer 1C:48:F9:9D:81:5C bredr


I think it would be better if we do something like
le.connect/bredr.connect instead of having to pass the bearer as
parameter, this should also help with tab completion since in that
case we can make it list just the devices that support the given
bearer.

>  info
>  ----
>
> diff --git a/client/main.c b/client/main.c
> index 0a928efaa9bb0d2a806895ff8f8c0c7c0d2493bd..ea551498f5d09879f87b8c77d=
7de2f0668b53fa6 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2303,6 +2303,141 @@ static void cmd_disconn(int argc, char *argv[])
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
> +static void cmd_connect_bearer(int argc, char *argv[])
> +{
> +       const char *type;
> +       GDBusProxy *device;
> +       GDBusProxy *bearer =3D NULL;
> +
> +       if (argc < 3) {
> +               bt_shell_printf("Usage: connect-bearer <dev> <le/bredr>\n=
");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       device =3D find_device(argc, argv);
> +       if (!device) {
> +               bt_shell_printf("Device %s not available\n", argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       type =3D argv[2];
> +
> +       if (strcmp(type, "le") !=3D 0 && strcmp(type, "bredr") !=3D 0) {
> +               bt_shell_printf("Invalid bearer type: %s, "
> +                       "Usage: connect-bearer <dev> <le/bredr>\n", type)=
;
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (!strcmp(type, "bredr"))
> +               bearer =3D find_proxies_by_iface(default_ctrl->bearers,
> +                                       g_dbus_proxy_get_path(device),
> +                                       "org.bluez.Bearer.BREDR1");
> +       else if (!strcmp(type, "le"))
> +               bearer =3D find_proxies_by_iface(default_ctrl->bearers,
> +                                       g_dbus_proxy_get_path(device),
> +                                       "org.bluez.Bearer.LE1");
> +
> +       if (!bearer) {
> +               bt_shell_printf("No bearer(%s) on device %s\n", type, arg=
v[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (g_dbus_proxy_method_call(bearer, "Connect", NULL,
> +                               bearer_connect_reply, NULL, NULL) =3D=3D =
FALSE) {
> +               bt_shell_printf("Failed to call bearer Connect\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("Attempting to connect bearer(%s) to %s\n",
> +                       type, argv[1]);
> +}
> +
> +static void cmd_disconnect_bearer(int argc, char *argv[])
> +{
> +       const char *type;
> +       GDBusProxy *device;
> +       GDBusProxy *bearer =3D NULL;
> +
> +       if (argc < 3) {
> +               bt_shell_printf("Usage: disconnect-bearer <dev> <le/bredr=
>\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       device =3D find_device(argc, argv);
> +       if (!device) {
> +               bt_shell_printf("Device %s not available\n", argv[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       type =3D argv[2];
> +
> +       if (strcmp(type, "le") !=3D 0 && strcmp(type, "bredr") !=3D 0) {
> +               bt_shell_printf("Invalid bearer type: %s, "
> +                       "Usage: disconnect-bearer <dev> <le/bredr>\n", ty=
pe);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (!strcmp(type, "bredr"))
> +               bearer =3D find_proxies_by_iface(default_ctrl->bearers,
> +                                       g_dbus_proxy_get_path(device),
> +                                       "org.bluez.Bearer.BREDR1");
> +       else if (!strcmp(type, "le"))
> +               bearer =3D find_proxies_by_iface(default_ctrl->bearers,
> +                                       g_dbus_proxy_get_path(device),
> +                                       "org.bluez.Bearer.LE1");
> +
> +       if (!bearer) {
> +               bt_shell_printf("No bearer(%s) on device %s\n", type, arg=
v[1]);
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       if (g_dbus_proxy_method_call(bearer, "Disconnect", NULL,
> +                               bearer_disconn_reply, NULL, NULL) =3D=3D =
FALSE) {
> +               bt_shell_printf("Failed to call bearer Disconnect\n");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }
> +
> +       bt_shell_printf("Attempting to disconnect bearer(%s) from %s\n",
> +                       type,
> +                       argv[1]);
> +}
> +
>  static void cmd_wake(int argc, char *argv[])
>  {
>         GDBusProxy *proxy;
> @@ -3528,6 +3663,12 @@ static const struct bt_shell_menu main_menu =3D {
>         { "disconnect",   "[dev] [uuid]", cmd_disconn,
>                                 "Disconnect a device or optionally discon=
nect "
>                                 "a single profile only", dev_generator },
> +       { "connect-bearer", "<dev> <le/bredr>", cmd_connect_bearer,
> +                               "Connect a specific bearer on a device",
> +                                                       dev_generator },
> +       { "disconnect-bearer", "<dev> <le/bredr>", cmd_disconnect_bearer,
> +                               "Disconnect a specific bearer on a device=
",
> +                                                       dev_generator },
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
