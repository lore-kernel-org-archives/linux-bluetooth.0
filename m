Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E328DB53
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151523; cv=none; b=TrG1TjJxFujS0764GeXAM3GmMCf4c00uEdI2IULnVDKJAQjUkJlBY4iNk7hn6GE1n1tAmjQ5SmgYuipEt85MQ+sZMN8035XaOiaVcBwX0WHZouuHl+/A4Pf4hDJ8gKIIK5CuYZHC81MvbSSeboLb7AxM/PqCJU+fW+Dh0NtTnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151523; c=relaxed/simple;
	bh=BNdxyCvLDRQFY+/5nJVZfB0rim5vXH27HzUpxS5HDDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1wOYzMUmPRl0RCTCl89VfZntPNhoTQfNUsospQ+jt76H+6PAyKe7OKRCMjf2CWfw0T39PhQBovmDkO2He03eXg5v3MTsbuoNMN3V+OSabhGbbpF0553zxNZ+7p/LBFfBAhLImVCWG0x7r4rUNpo+5vZU6fbvykwEcdQ8TegPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzn591bq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzn591bq"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30db3f3c907so55982411fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747151518; x=1747756318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRj2Lm+IMhZ84N90RZ0z3FDg/CWIxeOXjmmtKUjmb/c=;
        b=kzn591bqtc5xbQksQ245DzW5WEz3rsaNnfVGTAm855tJziQzd4USnuQeeYtoxFEGno
         /LXlWV59H/d/8K190rv9erGS0MPxXQdyVKpK7i5wjsNoTOfmojJecca6TY2/5TU6NMQO
         7JMmWXZp+NffhJFuWO5X8zvPQo04e0AoShkkTCMrZyUv0pfCKZKiNhqEesMuXDXdUIhm
         hygeg6hRmFBOGorrXJ4ZsXnpz2i0qsEswzOq1MqYZhsucfpo3NLeRieGltNi4k8vJ+VU
         vkJncaqJ0Jc47tEKK1uuMHNrncyHrdKV/DCQDuAMCIYZSWFh16QCTkaMpJBrBR/9R9+J
         5bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747151518; x=1747756318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRj2Lm+IMhZ84N90RZ0z3FDg/CWIxeOXjmmtKUjmb/c=;
        b=M7K0lF/KScmtwveo7ppg0dK7OvFv8mQj8HrXr3bCGlSHdAbCw+IWHvbyIwtTKbmUme
         iolENyUTRovQUfmWn/g4WGWOtXBTt8d4UxkXzYk2UcgB2kDFkhTrGzJ6e1F62REXKzpf
         LFSRS7TEl6p3nhD3HlHm+3gjy1hSRS7idJRzJC24R58FNnNxWDNIu6+BOxA/Y35foDur
         b1sFV21nvnzfXTYn/+Ouv1zs5FOVgM742YYJ+QtRQtQi8lH7jFu1VzV7kN1IYYzWmOp4
         gZ7AFF9VYKG5hu9XaSOi9VInyXCW6RSlzlP4dxh9w//YHmNarYDW7tKmdgjTBCNqRpJn
         5Pkg==
X-Gm-Message-State: AOJu0Yz8R/uinm8fHTNHl9Ce4bgck83WLqEERUFKGkfSktfo6no+RtAz
	rQB0JUwyA4Wdf7mgKb7yIkknneJirV6MpPYpO/domMJhtPtHhfsa8A2HO+ZrJN4iPEXMTxUbBwh
	0VReLQLxRffDMvcK7qiVENNDU8ALvQbSw
X-Gm-Gg: ASbGncsNByQQS2KUTiWSvOdU05sLPcCBehR06xDpg88um0YJTU7tZGCO8GyXw1i7LQ1
	LTrTh/O1NF8eCQDDgMmwe5ykYBOwtUFghp3vhaY7Gm0DhpLjyyqofZPN4o1xg+b2NU/WxVqE1+P
	SPSMla1xsxOqJjM1lOXvhM0lRN8g9KOcc=
X-Google-Smtp-Source: AGHT+IEHyX09N1XMPKJZ+WedAjvgeeox49XwPwMJmP9HfgzJdRHqUm33rw5P/PePHo9cJNTqUdlZpqSPKJpAC4yb//0=
X-Received: by 2002:a2e:a581:0:b0:30b:f469:47ef with SMTP id
 38308e7fff4ca-326c45d576cmr67662311fa.23.1747151518001; Tue, 13 May 2025
 08:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513093913.396876-1-hadess@hadess.net> <20250513093913.396876-10-hadess@hadess.net>
In-Reply-To: <20250513093913.396876-10-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 May 2025 11:51:44 -0400
X-Gm-Features: AX0GCFvPI-T6bYAlfVPvucll_PD7x6mduBH3zIsD8_sl6c3T8XhJQMYKebVUXXM
Message-ID: <CABBYNZK7HSXqq-Nch-81UT7zE-hGisLmby+Ecv56irrqkrJrvA@mail.gmail.com>
Subject: Re: [BlueZ v4 9/9] client: Port "assistant" menu to pre_run
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, May 13, 2025 at 5:58=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> ---
>  client/assistant.c | 11 +++++++++--
>  client/assistant.h |  1 -
>  client/main.c      |  2 --
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/client/assistant.c b/client/assistant.c
> index 555ac6feb048..6d172a8d8e81 100644
> --- a/client/assistant.c
> +++ b/client/assistant.c
> @@ -55,6 +55,8 @@ static DBusConnection *dbus_conn;
>
>  static GList *assistants;
>
> +static void assistant_menu_pre_run(const struct bt_shell_menu *menu);
> +
>  static char *proxy_description(GDBusProxy *proxy, const char *title,
>                                                 const char *description)
>  {
> @@ -384,6 +386,7 @@ fail:
>  static const struct bt_shell_menu assistant_menu =3D {
>         .name =3D "assistant",
>         .desc =3D "Media Assistant Submenu",
> +       .pre_run =3D assistant_menu_pre_run,
>         .entries =3D {
>         { "push", "<assistant>", cmd_push_assistant,
>                                         "Send stream information to peer"=
 },
> @@ -397,10 +400,12 @@ void assistant_add_submenu(void)
>         bt_shell_add_submenu(&assistant_menu);
>  }
>
> -void assistant_enable_submenu(void)
> +static bool pre_run_done =3D false;

Is the flag above really required though, I mean the bt_shell_run
shall only be run once and even if that is no the case the shell
itself could be doing the checking if the submenu.pre_run has been
called, anyway if that is required Id say we do this in a separate
patch, just let me know since I can drop the use of pre_run_done flag
while applying these changes.

> +static void assistant_menu_pre_run(const struct bt_shell_menu *menu)
>  {
>         dbus_conn =3D bt_shell_get_env("DBUS_CONNECTION");
> -       if (!dbus_conn || client)
> +       if (pre_run_done || !dbus_conn || client)
>                 return;
>
>         client =3D g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez"=
);
> @@ -408,6 +413,8 @@ void assistant_enable_submenu(void)
>         g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_remov=
ed,
>                                                         property_changed,=
 NULL);
>         g_dbus_client_set_disconnect_watch(client, disconnect_handler, NU=
LL);
> +
> +       pre_run_done =3D true;
>  }
>
>  void assistant_remove_submenu(void)
> diff --git a/client/assistant.h b/client/assistant.h
> index c304abea0515..418b0b84031f 100644
> --- a/client/assistant.h
> +++ b/client/assistant.h
> @@ -9,6 +9,5 @@
>   */
>
>  void assistant_add_submenu(void);
> -void assistant_enable_submenu(void);
>  void assistant_remove_submenu(void);
>
> diff --git a/client/main.c b/client/main.c
> index 06ae25c9d8e9..36a7446d52c1 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -3426,8 +3426,6 @@ int main(int argc, char *argv[])
>                 bt_shell_set_env("AUTO_REGISTER_ENDPOINT",
>                                         (void *)endpoint_option);
>
> -       assistant_enable_submenu();
> -
>         client =3D g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez"=
);
>
>         g_dbus_client_set_connect_watch(client, connect_handler, NULL);
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
