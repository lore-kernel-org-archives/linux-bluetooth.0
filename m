Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B740205ABD
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428913; cv=none; b=cn1dEDiO7etRRe3GETEMFVrLnCYnMLcMuBtiGHST9l9UTT/u18IzUkhy9DAGlJRf4N+ZoVc9cnWkYn1RD/B5f5k9BL3NYTtnefvREg5r3xYTE7ynL3yZzR2M4ecif0OLRU31Xe4tGsGX+vF/utZ6G4c4wh//PsvMxgm+2MMahA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428913; c=relaxed/simple;
	bh=nqV14aOJ5rb5HqMc9gkuOLOKkwyL3Xh4SuH1gAyJ+04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDG3IH0ZVZi7vV+mkpZ4ZU2cQcqT1czS8jRM/e6AkPVfXkTHBeQcxmM1+MmNZ2OkwvRL9chUBQRfBLoW7jjhg+jpCdgL9E05m9vbd13YUKRUp+PrfEVUOZu7qabT3i/NjPKSvPaHdrj4ThkTbZp0xxB6XYu5aZO+kbDOeKeN+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0muXCCd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0muXCCd"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso52430321fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731428909; x=1732033709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0fBFb7SA9rAIeAD2TgsP+BSfV0K5OYm7/cjolFd9+4=;
        b=D0muXCCd3TI5NdPxsR7ZqCXhzhpiATIpPh8A0t63FbLqlMAGFO7gr6KsgcXi6SRsnO
         VdtVNT719uOFBuVI3MeESXa+GZeeE04lhRRIPFgBIYqHrz1+53FDAXuaVrh4mRSnmyge
         JOOLnPJtsFDgkmS/wFaImW1E4zuYE5qJFKdzNAsyZr1Q1sv6gEa3Ctsozkr11V7qFVMf
         30+DRpPK6vWaT4YJTytYkWrbcpjr7eDD0IXpvfgV7BlcXYzdTBUm4b8xakduHZzLd/fG
         KqbCw6XbdrIESF6HKfLC79RcUULbotz9dWFDByh9/ULWF/H9nXwOz8jcs+k51EkBSTAC
         XB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428909; x=1732033709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0fBFb7SA9rAIeAD2TgsP+BSfV0K5OYm7/cjolFd9+4=;
        b=KUgxGCXrxBVlBwizHgNpDQUsPOBHjRfXfU1itPEt7/1/r9mNt7WLHk/ylyXbxkil/U
         cih16h/DiSNxB3Obsvs1IKFQsSFu+B0nMAhho3u9vL04v7YgnuMGnyfNYamuJrJdZ8tW
         GQCeLD3x2Mufw0PSiX/KJQfsoE2xBvuc/3snUFTV0lvn58TrCuyHiDSyILlhY6i3EBid
         loQp4+Cbd6To0GnGkV4wxUokvocqxZnIfQ7W8YRaBXJRKH+6amJNI+KiVVmAyg4jKvLG
         nm9xp6A9MwzMBl2WbCnjKg52NrU+7BHgaxgF6vDESuUwpWf2BX7m7HkwqtnQUCd30cqI
         rGMw==
X-Gm-Message-State: AOJu0YyH6Oz6hKThkX+SXWcY+0N/hI0srTURY+lNys83dEUQs/JNiaYC
	mpNOGf8u4NiLma9MGA9GcofFPZcCgfnJuXY3ygnd+NICqXU5XFge5u8uCdD2X3tP7yTm+ufbFsK
	lXpD+UHZlkaUd+41O4fEECBWPDbLaZA==
X-Google-Smtp-Source: AGHT+IGMFHvfPhPdMAVQkPlPH/iCsAwhp0YW5BnJnHP9cbk3Vh5WUgVkQ7hMySIWwMcTb+evNyiDLGDQEVXeoWq3wk0=
X-Received: by 2002:a2e:bc07:0:b0:2fb:2f7c:28dd with SMTP id
 38308e7fff4ca-2ff426ba550mr20368501fa.18.1731428909214; Tue, 12 Nov 2024
 08:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112045022.2743723-1-quic_dgangire@quicinc.com>
In-Reply-To: <20241112045022.2743723-1-quic_dgangire@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 Nov 2024 11:28:17 -0500
Message-ID: <CABBYNZLC1X-uPcH+nk=zWzny+CePFgvjobfrn1FVwNcaHQZ1eg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] tools/obexctl: Add command line options to
 support session/system bus
To: quic_dgangire@quicinc.com
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 11, 2024 at 11:50=E2=80=AFPM <quic_dgangire@quicinc.com> wrote:
>
> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
>
> Currently obexctl only uses session bus.
> As obexd has been enabled support for both session and system bus.
> Configuring obexctl to use session/system bus during the runtime
> with command line options.
> ./obexctl --bustype=3Dsystem or --bustype=3Dsession.
> By Default session bus will be used.

I think we should probably attempt to detect at runtime if the name is
available over session or system.

> ---
>  tools/obexctl.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/tools/obexctl.c b/tools/obexctl.c
> index a398b095b..d88ffc9fe 100644
> --- a/tools/obexctl.c
> +++ b/tools/obexctl.c
> @@ -2149,16 +2149,42 @@ static void property_changed(GDBusProxy *proxy, c=
onst char *name,
>                 session_property_changed(proxy, name, iter);
>  }
>
> +static const char *help[] =3D {
> +               "Configures either session or system bus.By Default sessi=
on bus is used",
> +};
> +
> +static const char *bustype_option;
> +
> +static const char **optargs[] =3D {
> +               &bustype_option
> +};
> +
> +static const struct option options[] =3D {
> +               { "bustype", required_argument, 0, 'b' },
> +               { 0, 0, 0, 0 }
> +};
> +
> +static const struct bt_shell_opt opt =3D {
> +               .options =3D options,
> +               .optno =3D sizeof(options) / sizeof(struct option),
> +               .optstr =3D "b",
> +               .optarg =3D optargs,
> +               .help =3D help,
> +};
> +
>  int main(int argc, char *argv[])
>  {
>         GDBusClient *client;
>         int status;
>
> -       bt_shell_init(argc, argv, NULL);
> +       bt_shell_init(argc, argv, &opt);
>         bt_shell_set_menu(&main_menu);
>         bt_shell_set_prompt(PROMPT, NULL);
>
> -       dbus_conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
> +       if (bustype_option && !(strcmp(bustype_option, "system")))
> +               dbus_conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NUL=
L);
> +       else
> +               dbus_conn =3D g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NU=
LL);
>
>         client =3D g_dbus_client_new(dbus_conn, "org.bluez.obex",
>                                                         "/org/bluez/obex"=
);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
