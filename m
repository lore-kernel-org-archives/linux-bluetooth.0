Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A31CF81
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430439; cv=none; b=rKSiwODnqJlAwkmaHxYR9zJQkTFWtKnSKfJMzYGlRHs017TX6m/ToLrNgnaPJ3Btsx5n3YutEdb4aTQddvfOywLp3+d8cwOd+F9fyTgRgLEzlD+uncWn1eOffPuMQGyX4+oPMlSfOLDunlL+e75i/MDoZ8urzt5a+LoBVS9yMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430439; c=relaxed/simple;
	bh=1BHOt7He+u+tbnUcMfolqXf8l76AzqFKuWjPH1mTGDs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=WoaacQ9hiiZ/0FNQ72YbLAmwJy2oZqURrBG5q8CFmWVKAt06/aXVY2XreTKutbXF1Y/cqYs5NcgeIYvHXRNHLzJ93FBVnBbQ747EG88CgkNxjYJWgShtMt9+X2V483tQ3VW+Po0gOMn07qpAy0eeYud9qwLzajteiG3AL2xn88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms9t02Jm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms9t02Jm"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd33336b32so134311071fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 10:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705430435; x=1706035235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V0sbPruW9V8Ihsal5GfWaFDPkmcJFgeaVmWeTVJubY=;
        b=Ms9t02JmNCPY/oxHWK/GvDS9s7YiBNpEcaY0CBKMV6Tigaj+rcfUF7yj6uq9nU9C4N
         BLx/opYIvm/ZP7hksqiLsZ+t1fMI6FkGeifjMWenR54uSZejj1Aoo/KNKhPHGJYrI8QH
         oT2cb/FhhNHIs1iMHWRD1vNu7xEDDfwONbJzRUVuUeCaZy7MQhvTWqQi8OMR0N9Sd5d3
         Or6kwvF5LYDZRZI3tPuPQZS33FddjyM5uKgjQE3hwcaBTasuHB8ZM3bVHoQXSr/3uC9p
         dX7JEzS+FOyh7JL0KMVFjC8/lMMNeTwneMUj6vcrbcT3xz7X48JY7OqKiZmb8vQRKCRM
         3twQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430435; x=1706035235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V0sbPruW9V8Ihsal5GfWaFDPkmcJFgeaVmWeTVJubY=;
        b=Gn9l7a8qvgeziuWvzPw67S+1dbH8fS0OmcykPv1JPpcgU1NwonYBB0PP3LPU8lMGSe
         1X9U1yGmrpGGKlHqWshOzSaaV4+qZ3sEhKWIkHQwigrWJ2kfGmFbXduNQ8fiswRI6VGS
         IoYDew/6imYOeJG3PICwVzbWjXou/1/cmmkQlj5mdvWYygTgi0qJWkUkXnyW+HR5FVsb
         NtkKQ42aQ9/J2fIiJx5SXmyraoKSTDEYu6uq6YpoKTvcP3oal49YHAt0k1zDXBDqGuMe
         8Xv3kkk+zXQKP1P5o78gAzvgCIq4018GqZqMgVEAtdDefdM+Dld/h2CSXGyA/5rkhxMv
         sa1w==
X-Gm-Message-State: AOJu0YwjTqXK0l0kU3/eYq8RCQI1USIXq/uzJS9bDzEqn/2tLGc/IuFb
	pZcua/E7+jvdLyCdZrVDjxK9ruFrGgaChjZwysQ=
X-Google-Smtp-Source: AGHT+IGvQTu85a8RsCuXiIp5Yi0Pv5XMReFc8mkdbe6ri04nggadeXZCzv2WgLSjrk1083v2aKJFmV9waqb59XzzGiY=
X-Received: by 2002:a05:651c:150c:b0:2cd:db72:7615 with SMTP id
 e12-20020a05651c150c00b002cddb727615mr1443697ljf.104.1705430430878; Tue, 16
 Jan 2024 10:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com> <20240116-autofoo-v1-4-626f6b54bd06@gmail.com>
In-Reply-To: <20240116-autofoo-v1-4-626f6b54bd06@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Jan 2024 13:40:18 -0500
Message-ID: <CABBYNZJUhmVUNGTsqspc3S802pDwikFf2YOPupESD1m5T-GsJw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 04/10] build: remove dummy {conf,state}{dir,_DATA}
To: emil.l.velikov@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Tue, Jan 16, 2024 at 8:52=E2=80=AFAM Emil Velikov via B4 Relay
<devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
>
> From: Emil Velikov <emil.velikov@collabora.com>
>
> The project does not install anything in the respective confdir and
> statedir(s). Since no files are installed, the respective folders are
> not created either - systemd will create them prior to starting the
> service(s).
>
> The *dir variables themselves are no longer used in *service.in, so
> remove everything.
> ---
>  Makefile.am | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index e738eb3a5..16d6bf160 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -28,15 +28,9 @@ AM_CFLAGS =3D $(MISC_CFLAGS) $(WARNING_CFLAGS) $(UDEV_=
CFLAGS) $(LIBEBOOK_CFLAGS) \
>                                 $(LIBEDATASERVER_CFLAGS) $(ell_cflags)
>  AM_LDFLAGS =3D $(MISC_LDFLAGS)
>
> -confdir =3D $(sysconfdir)/bluetooth
> -statedir =3D $(localstatedir)/lib/bluetooth
> -
>  if DATAFILES
>  dbusdir =3D $(DBUS_CONFDIR)/dbus-1/system.d
>  dbus_DATA =3D src/bluetooth.conf
> -
> -conf_DATA =3D
> -state_DATA =3D
>  endif
>
>  if SYSTEMD
> @@ -747,9 +741,7 @@ MAINTAINERCLEANFILES =3D Makefile.in \
>
>  SED_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
>                 $(SED) -e 's,@pkglibexecdir\@,$(pkglibexecdir),g' \
> -                      -e 's,@libexecdir\@,$(libexecdir),g' \
> -                      -e 's,@statedir\@,$(statedir),g' \
> -                      -e 's,@confdir\@,$(confdir),g' \
> +                      -e 's,@libexecdir\@,$(libexecdir),g'
>                 < $< > $@
>
>  if RUN_RST2MAN
>
> --
> 2.43.0

This one seems to be causing some build regression, when trying to
apply it breaks the builds.

--=20
Luiz Augusto von Dentz
