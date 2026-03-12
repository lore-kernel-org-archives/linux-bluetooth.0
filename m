Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BD3B2FFE
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321246; cv=pass; b=SsPDPlruWCIYJNmr4TIjLXeSOP3AkBoP/iAL+cROfJkFRxvJtZxwALPWXp/JGpy4DEAWg9r9qLn0LAtRrfu5ZeskLoY93InvCVgzFhkz8RfEJxLORCt2fkqaxzO2HYxpMjbwtUKkAyOsP2PxrXXkihYmhRObLkWArfF6B2Lnx6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321246; c=relaxed/simple;
	bh=T6rO7d65f41kMj6WQRUIVq6JGwMd1PCVYCu83/SL9HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNrtoaP/L+OGyheIKdS38zt3JOS8jMhD3pkohcm4OhIHW82kHc/zQMGc4D1mniNduFUUxD+lfBz1XWZutHjA1SpTvfJ83PPma2tHBB2dli32VMLIgpu4ZAcCTZRDyAaLM/Yf860XFaDSzs8VScBey0lhJl95jWrBLR34UQiS9Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY5MP9Tb; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY5MP9Tb"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64caaacb9bcso1099905d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 06:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773321242; cv=none;
        d=google.com; s=arc-20240605;
        b=VySGg+ojBZXi6nPMe4hcK0/hJyitsGW6SYKkEzDOSUNOQSBnCDuU957OhMiMNcs+6g
         LD8MofUW0JWepCVFbqsgdsRKadrlrAjUTkDZgBux1PqmvqLDi+Ch1gtlb+YArAdRyfuy
         SSRI035Jc00THWsBSdWsMQzxi9t9H8TU3ldziRHlLJpbmPX/GFcxMK2iPNkIWV3Awrdz
         m+SfUgs6UkKa2w899Xokyz2XRTnjIgLUJFKfSZ3hsNSnu6PFMZDBfFJIzLtRSSReYDB4
         vTqhgJAKyQHfVUR3QGONvY2Wy8eC3g07QaDRBh2x6BJhQ1IUJxqpRoM1vIKARMgUUZmx
         /E8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3tSuA+sGz5IXT2VFr0lP0RbCzL1+XTHpjx46nvlU3s0=;
        fh=YfIR0xVwKzmzUegeZomM0N7NpuXyo4CnoUmYcDIV87s=;
        b=gY8m8q9oahN0lo3THJM3b8VhtyUt73q8jcc+2z6U4w4YCTYPQU4IJAYhYQyZeFcud1
         i3K3FcjyGvMlGg5evIcx8ufwZ6Fls22K/rUYKBru+D2ga/Gah7XyWzA6lmon1XL0XGJh
         oIsyO/bEttgxWhLSMKaVA6YDztgsBxpYgB69jAERDowrdyest+U4CF3V0eB/kIRdWYCO
         7W/wpx+P2OvQ3sHNetnY4w27mfmxyGCG8g3tp0G1nx5d3xcwb5UcHuhSlOQJMPGssZYY
         Tgq5mnCZfRGFF8JIByXFh1issr19yITI+SMdNIiGLDiPTOfb4dSqd95Zv4a2BYkRVA6r
         1Aig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773321242; x=1773926042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tSuA+sGz5IXT2VFr0lP0RbCzL1+XTHpjx46nvlU3s0=;
        b=DY5MP9TbCTME1XbIRoUcwuoWmKEyZmF54kOXjIopsMCfew9KslAx6Pnc8MmIw5z9Ig
         0lE5NY60cTq36lMS3cueRW/E3fcblh3nJdpxz2CzXwjXSnqkEb+EFbwpLCeDPpvt+lQ+
         ZwIjM4gm5hftCNDiRBm6huwQVSfJqf7IPAT88Ya+K4uw/5wm3nNukw6rBJUI7tDsd1i0
         YpsC71uf+5cOl4UuIYNwJQ2cHs0AlTI4okl8MfgJN9F04cnwlj1ASkNL3+Y0UnJC3U9L
         1TbG7AHQcxAQ8ObbeROTG0kNLcqZNz4uJoLFYGIhUSdrt+SUpfxIPwMjVl0bGHE5Fa7e
         0HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773321242; x=1773926042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tSuA+sGz5IXT2VFr0lP0RbCzL1+XTHpjx46nvlU3s0=;
        b=EoLNffWSF4SKUZ2ZcvN8x8IGGHd31tSHdA5ubU+kHmGPgyyhUfAarXEvNyo1SKsfF/
         7UhDHXiXW+FgExCjJmkd0GlpcYJVvC9dfYVQNN6uKzmW/pgp9ZDh5dBMuH56Db9rIjcg
         XjOBjqc+DP5wr7GsPpdwHMolcTEXGw+VI5b6C+qcWCZI7qcHb+GbX2GxL/iAuTrlmO8M
         HOdhlsztFfh/5JiX/EeJy90AZZqKCUu0N7gZS15zZ3T8ItWCV+enCppYzcAvPEUlKyqp
         bd7WMb8FYg18nO0MVwKoWtJgcFfzHuIehK1I5/CLcbakYXIehAtJZzsQTVy92qyuUFa7
         aDzw==
X-Gm-Message-State: AOJu0Yy2fdWoTgqFQGSi6fODyKW3D+gHiZoDISpLulCM+1gtmzJFMAAN
	v+d7gz+A1FmCYxRp1PQpdZEQ6P8Q/UVBWXapIDDr4L5KYNuG6tzgawb8U5M3LF7uimEp7nyCqfD
	8+YTJw1c+tcEFy8SUl98FhDL2TdLWf34zWCOf
X-Gm-Gg: ATEYQzx5D2yImROIs54k9HhYjJE956hxlzsUlQatYUUx9lhQTxX2s9fU2rk0xN4JGIn
	WNWN+jzHKgT7/9GnYI2XaR45d4pNLCnlYWZBcG7EFiVtulZdU9FfMOXrOFbYgcsq68+QTtaefxi
	E+SPSfdHfhr/sg9ryMU9Id9jzoXnk/2vflw1qKNSmZ9upmayqOHkRgkDBo3sttT4U70vBiz8MeV
	HqJUcv60eAHXthb1ntmELRS8FpMdsNsPh0kmM92wPfgcNBkKbmvoSBXt/yZS8BTW1UsVB5LZX91
	Lw6YlPgWyALEdI7LLCYLUxcDydBSwl/Z0L4CrilACE/ThNuSCqUgNg1hGb8eJ4y7v45wkw==
X-Received: by 2002:a05:690e:2499:b0:649:f0e5:fab1 with SMTP id
 956f58d0204a3-64d656f7580mr4898956d50.23.1773321241796; Thu, 12 Mar 2026
 06:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309040136.159073-1-berend@deschouwer.co.za> <20260309040136.159073-2-berend@deschouwer.co.za>
In-Reply-To: <20260309040136.159073-2-berend@deschouwer.co.za>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Mar 2026 09:13:50 -0400
X-Gm-Features: AaiRm51Sn9WOgK00qvv33fm_rc6Fsnn9PkXyc33pIeekw2CBaRep1GnJwf0tGTU
Message-ID: <CABBYNZ+6mVQFhLBd6KaFfKLvOC2D8F-Pt6W+y5TT_hAC3Pu2sw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Stop and start some actions on suspend and resume
To: berend de schouwer <berend@deschouwer.co.za>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Berend,

On Mon, Mar 9, 2026 at 12:02=E2=80=AFAM berend de schouwer
<berend@deschouwer.co.za> wrote:
>
> Stop active device discovery on suspend and shutdown, and restart
> on device resume.  This uses dbus notifications, so needs a running
> login manager owner.

I guess this is implementing the following functionality:

https://systemd.io/INHIBITOR_LOCKS/

My question is, is this really necessary? The kernel already has
handling that detects if an active discovery is ongoing, pauses it,
and then resumes the discovery state upon resumption:

https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_sync.=
c#L6239
https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_sync.=
c#L6132
https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_sync.=
c#L6371
https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_sync.=
c#L6292

Maybe this is not working in your system for some reason?

> ---
>  src/adapter.c |  35 ++++++++
>  src/adapter.h |   2 +
>  src/main.c    | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 263 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 4e5ff219f..5456c7fc9 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -288,6 +288,7 @@ struct btd_adapter {
>         bool filtered_discovery;        /* we are doing filtered discover=
y */
>         bool no_scan_restart_delay;     /* when this flag is set, restart=
 scan
>                                          * without delay */
> +       bool discovering_before_sleep;  /* was discovery on before suspen=
d? */
>         uint8_t discovery_type;         /* current active discovery type =
*/
>         uint8_t discovery_enable;       /* discovery enabled/disabled */
>         bool discovery_suspended;       /* discovery has been suspended *=
/
> @@ -2083,6 +2084,40 @@ static void resume_discovery(struct btd_adapter *a=
dapter)
>
>         trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
>  }
>
> +void adapter_resume_discovery_sleep(void)
> +{
> +       GList *list;
> +
> +       for (list =3D g_list_first(adapter_list); list;
> +                                               list =3D g_list_next(list=
)) {
> +               struct btd_adapter *adapter =3D list->data;
> +
> +               if (adapter->discovering_before_sleep) {
> +                       DBG("Resuming discovery on: %s", adapter->name);
> +                       resume_discovery(adapter);
> +               }
> +               adapter->discovering_before_sleep =3D false;
> +       }
> +}
> +
> +void adapter_suspend_discovery_sleep(void)
> +{
> +       GList *list;
> +       bool was_discovering;
> +
> +       for (list =3D g_list_first(adapter_list); list;
> +                                               list =3D g_list_next(list=
)) {
> +               struct btd_adapter *adapter =3D list->data;
> +
> +               was_discovering =3D (adapter->discovery_list);
> +               if (was_discovering) {
> +                       DBG("Suspending discovery on: %s", adapter->name)=
;
> +                       suspend_discovery(adapter);
> +                       adapter->discovering_before_sleep =3D was_discove=
ring;
> +               }
> +       }
> +}
> +
>  static void discovering_callback(uint16_t index, uint16_t length,
>
>                                         const void *param, void *user_dat=
a)
>  {
> diff --git a/src/adapter.h b/src/adapter.h
> index 4e07f71ad..4843c04a9 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -320,3 +320,5 @@ unsigned int btd_adapter_send_cmd_event_sync(struct b=
td_adapter *adapter,
>                                         void *user_data,
>                                         btd_adapter_destroy_func_t destro=
y,
>                                         uint8_t timeout);
> +void adapter_suspend_discovery_sleep(void);
> +void adapter_resume_discovery_sleep(void);
> diff --git a/src/main.c b/src/main.c
> index 59df0ad4c..831733f55 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -67,6 +67,9 @@
>  struct btd_opts btd_opts;
>  static GKeyFile *main_conf;
>  static char main_conf_file_path[PATH_MAX];
> +static unsigned int prepare_sleep_id;
> +static unsigned int inhibit_lock =3D -1;
> +static DBusConnection *client_conn;
>
>  static const char *supported_options[] =3D {
>         "Name",
> @@ -1443,6 +1446,224 @@ static GOptionEntry options[] =3D {
>         { NULL },
>  };
>
> +static void obtain_inhibit_lock(void)
> +{
> +       DBusMessage *message
> , *reply;
> +       DBusMessageIter iter;
> +       DBusError error;
> +       int fd;
> +       const char *what =3D "sleep";
> +       const char *who =3D "bluetooth manager";
> +       const char *why =3D "stopping device discovery";
> +       const char *mode =3D "delay";
> +
> +       if (!client_conn || !dbus_connection_get_is_connected(client_conn=
))
> +               return;
> +
> +       message =3D dbus_message_new_method_call("org.freedesktop.login1"=
,
> +                                       "/org/freedesktop/login1",
> +                                       "org.freedesktop.login1.Manager",
> +                                       "Inhibit");
> +       if (!message) {
> +               dbus_connection_unref(client_conn);
> +               return;
> +       }
> +
> +       dbus_message_iter_init_append(message, &iter);
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &what);
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &who);
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &why);
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &mode);
> +       dbus_error_init(&error);
> +       reply =3D dbus_connection_send_with_reply_and_block(client_conn,
> +                                                       message, -1, &err=
or);
> +       dbus_m
> essage_unref(message);
> +
> +       if (dbus_error_is_set(&error)) {
> +               warn("Failed to register a suspend inhibitor (selinux?): =
%s",
> +                       error.message);
> +               dbus_error_free(&error);
> +               return;
> +       }
> +
> +       if (!reply)
> +               return;
> +
> +       if (dbus_message_iter_init(reply, &iter) =3D=3D FALSE) {
> +               dbus_message_unref(reply);
> +               return;
> +       }
> +
> +       if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_UNIX_FD)=
 {
> +               dbus_message_unref(reply);
> +               return;
> +       }
> +
> +       dbus_message_iter_get_basic(&iter, &fd);
> +       inhibit_lock =3D fd;
> +
> +       dbus_message_unref(reply);
> +}
> +
> +static void release_inhibit_lock(void)
> +{
> +       if (inhibit_lock < 0)
> +               return;
> +
> +       close(inhibit_lock);
> +       inhibit_lock =3D -1;
> +}
> +
> +static gboolean prepare_for_sleep(DBusConnection *conn, DBusMessage *msg=
,
> +                                 void *user_data)
> +{
> +       DBusMessageIter iter;
> +       dbus_bool_t entering;
> +
> +       DBG("preparing for sleep or resume");
> +
> +       if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
> +               return TRUE;
> +
> +       if (dbus_message_iter_ge
> t_arg_type(&iter) !=3D DBUS_TYPE_BOOLEAN)
> +               return TRUE;
> +
> +       dbus_message_iter_get_basic(&iter, &entering);
> +
> +       if (entering) {
> +               adapter_suspend_discovery_sleep();
> +               release_inhibit_lock();
> +       } else {
> +               adapter_resume_discovery_sleep();
> +               obtain_inhibit_lock();
> +       }
> +       return TRUE;
> +}
> +
> +int connect_login_manager(void)
> +{
> +       DBusError error;
> +       dbus_bool_t login_manager_exists;
> +
> +       client_conn =3D btd_get_dbus_connection();
> +
> +       if (!client_conn || !dbus_connection_get_is_connected(client_conn=
))
> +               return -1;
> +
> +       dbus_error_init(&error);
> +       login_manager_exists =3D dbus_bus_name_has_owner(client_conn,
> +                                               "org.freedesktop.login1",
> +                                               &error);
> +       if (dbus_error_is_set(&error)) {
> +               dbus_error_free(&error);
> +               return -1;
> +       }
> +
> +       if (!login_manager_exists)
> +               return -1;
> +
> +       return 0;
> +}
> +
> +int connect_prepare_for_sleep(void)
> +{
> +       guint sleep_id;
> +
> +       obtain_inhibit_lock();
> +
> +       client_conn =3D btd_get_dbus_connection();
> +
> +       sleep_id =3D g_dbus_add
> _signal_watch(client_conn,
> +                                       "org.freedesktop.login1",
> +                                       "/org/freedesktop/login1",
> +                                       "org.freedesktop.login1.Manager",
> +                                       "PrepareForSleep",
> +                                       prepare_for_sleep,
> +                                       NULL,
> +                                       NULL);
> +
> +       if (!sleep_id) {
> +               warn("Prohibited from watching suspend events.");
> +               return -1;
> +       }
> +       prepare_sleep_id =3D sleep_id;
> +
> +       return 0;
> +}
> +
> +static DBusHandlerResult login_manager_changed(DBusConnection *client_co=
nn,
> +       DBusMessage *message, void *_usr_data)
> +{
> +       const char *name;
> +       const char *old_owner;
> +       const char *new_owner;
> +
> +       if (!dbus_message_is_signal(message, "org.freedesktop.DBus",
> +                                   "NameOwnerChanged")) {
> +               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +       }
> +
> +       if (!dbus_message_get_args(message, NULL,
> +                                               DBUS_TYPE_STRING, &name,
> +                                               DBUS_TYPE_STRING, &old_ow=
ner,
> +                                               DBUS_TYPE_STRING, &new_ow=
ner,
> +                                               DBUS_TYPE_INVALID))
> +               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +
> +       if (strcmp(name, "org.freedesktop.login1"))
>
> +               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +
> +       if (!strcmp(new_owner, ""))
> +               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
> +
> +       if (connect_prepare_for_sleep() >=3D 0)
> +               dbus_connection_remove_filter(client_conn,
> +                                               login_manager_changed, NU=
LL);
> +
> +       return DBUS_HANDLER_RESULT_HANDLED;
> +}
> +
> +int connect_login_and_prepare_for_sleep(void)
> +{
> +       DBusError error;
> +
> +       client_conn =3D btd_get_dbus_connection();
> +
> +       if (connect_login_manager() < 0) {
> +               dbus_bus_add_match(client_conn,
> +                                       "type=3D'signal',"
> +                                       "sender=3D'org.freedesktop.DBus',=
"
> +                                       "interface=3D'org.freedesktop.DBu=
s',"
> +                                       "member=3D'NameOwnerChanged'",
> +                                       &error);
> +
> +               if (dbus_error_is_set(&error)) {
> +                       dbus_error_free(&error);
> +                       return -1;
> +               }
> +
> +               dbus_connection_add_filter(client_conn, login_manager_cha=
nged,
> +                                                               NULL, fre=
e);
> +               return -1;
> +       }
> +
> +       return connect_prepare_for_sleep();
> +}
> +
> +void disconnect_prepare_for_sleep(void)
> +{
> +       DBusConnection *conn =3D btd_get_dbus
> _connection();
> +
> +       if (!conn || !dbus_connection_get_is_connected(conn))
> +               return;
> +
> +       if (!prepare_sleep_id)
> +               return;
> +
> +       g_dbus_remove_watch(conn, prepare_sleep_id);
> +       prepare_sleep_id =3D 0;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         GOptionContext *context;
> @@ -1498,6 +1719,9 @@ int main(int argc, char *argv[])
>                 exit(1);
>         }
>
> +       if (connect_login_and_prepare_for_sleep() < 0)
> +               info("Cannot listen for suspend yet, trying again later."=
);
> +
>         if (btd_opts.experimental)
>                 gdbus_flags =3D G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
>
> @@ -1557,6 +1781,8 @@ int main(int argc, char *argv[])
>         btd_agent_cleanup();
>         btd_device_cleanup();
>
> +       disconnect_prepare_for_sleep();
> +       adapter_suspend_discovery_sleep();
>         adapter_cleanup();
>
>         rfkill_exit();
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz
