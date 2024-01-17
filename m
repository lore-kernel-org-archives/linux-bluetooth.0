Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F331E515
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530988; cv=none; b=JJL7fiYvt3q2oOFshsC9NrgjdbjUfZLTawoQGy9q1Pe1aUdoQGYrOjNvqPS2bIONXaYJWKUkdpnuP0kmk0YDyKTKYUlct3NVbzENZH8iU2RR09JRZOfD/9rt0Kxj5Ux6+IT4+zx1j8G7dgn9wsyKuziavJdIYxAe/vCdiSINeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530988; c=relaxed/simple;
	bh=CH0y8MAAhRY687UfeoUG/V6ShK8dqvQ8T0G1nzAYAwM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hYaA+kw4NiXUpMY813sw7sh5iX4k0fntCSDnJAMiEXZ6GnfjCbJj+IgM9+rL9MbCQUH6unXy/iWTDstcIfhZNll1z9z01A/6TPnxY4edq6Q7bLPc/D/vS/LBNpD7KLmPjboLRuUR9Fgt42YYJvwXxGvf9kePSbcSCUqV7OS0wVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkkyDs7P; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkkyDs7P"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cdeb80fdfdso17929891fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 14:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705530984; x=1706135784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD7nSd70H8VrCsbOxz33MNZjCfpuaR5tZywEFEiClNw=;
        b=bkkyDs7Pwk3zNJV2DlBovltPcYpM5/lgVr/G8g/12eVmu3RUnsiwX7mlRaj6wPXw2y
         V3ztBsNoS1cnPm+tAKL7qxqm6c7g/mnQAsCncCR7IGS3/Y6i7+MspJfkALMeo9wo9ytU
         hzxWwyY2cb+fe/sluyJmly1g6t8ZYK5mwB4r2jI9+OSkVD9afQLVlwJJydQtKqTohssK
         ViJcMJkZkSVTKQk+aiVi88cX28kZkeY8DIcRtFImn3+HYhtLFrwLM9SOGnDXdQGYz3Em
         1R/QZvyPyOHiIvYpOSV46kVPyPDwWpy0EU6xxCsNmxFEWabMsjkOUVBNMzJmmoApNv8G
         XYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705530984; x=1706135784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JD7nSd70H8VrCsbOxz33MNZjCfpuaR5tZywEFEiClNw=;
        b=eLuRrj8rH1XzBVRhavhZsfncgMGWCA+FNvffC6fyHpXvFz7NL7nySq60sfSLeyq7+C
         VoI/8YZjVInNIrBf7s90hitiWwEueiR43h1HOMU9HFnatpIZAakZO64XN43GCZMAWCu5
         s/jcXcyj1QvDn6fU4lAN3crMvzRcdapSZYmavrDEEu4s1JNfA6qqhz/jFttbv5UyQfzR
         MjC+op8utAm7ew9hdcFPvB2joOf/PuHM8zEisKE4I3JUyQptalbwLxhLzOGO06Tb/o6s
         aiQxoNIDQXrM2Ht8aJVjO94yGNiX76tiLBLPb98TBrb2pdWvfUOkKgARwCNf4VkEFxBx
         X9UA==
X-Gm-Message-State: AOJu0YxuWbujTpn3A9/M3qhWXD9HMXB2aahTtWnB7WXeI4ve3K2Mp28M
	yHjMXK3Jhl87xR8M4HzG9yHVzwTG9kmEw9MjRJyWOy2POvI=
X-Google-Smtp-Source: AGHT+IFCTG+ptuvEPf4Kh5X9bEEY52D0NztR65W6yC8+XtuxHkmRQ5d43Hoxn5jDJ5Gz00dde5yH/+rneEqnqblB9tM=
X-Received: by 2002:a2e:b166:0:b0:2cc:6666:168d with SMTP id
 a6-20020a2eb166000000b002cc6666168dmr2573312ljm.69.1705530983745; Wed, 17 Jan
 2024 14:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117222317.1792594-1-luiz.dentz@gmail.com> <20240117222317.1792594-2-luiz.dentz@gmail.com>
In-Reply-To: <20240117222317.1792594-2-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Jan 2024 17:36:10 -0500
Message-ID: <CABBYNZK4ODoPDy20jk48tPW8rnAgLdOMrhdkgMPeanSLz-x-mA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/2] transport: Print owner information when it
 exit or release
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Jan 17, 2024 at 5:23=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This prints the owner name when it exits/quits/crash or releases a
> transport.
> ---
> - Looks like there is a bug/race on codec switch it appears the likes of
>   pipewire attempts to call Release in the process which stops the
>   acquire/resume:
>
>   bluetoothd[1774429]: profiles/audio/transport.c:transport_set_state() S=
tate
>   changed /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1/fd8: TRANSPORT_G
>   bluetoothd[1774429]: profiles/audio/transport.c:media_request_create()
>   Request created: method=3DAcquire id=3D50
>   bluetoothd[1774429]: profiles/audio/transport.c:media_owner_add() Owner
>   :1.133105 Request Acquire
>   bluetoothd[1774429]: profiles/audio/transport.c:media_transport_set_own=
er()
>   Transport /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1/fd8 Owner :1.5
>   bluetoothd[1774429]: profiles/audio/transport.c:release() Owner :1.1331=
05
>   bluetoothd[1774429]: profiles/audio/transport.c:media_owner_remove() Ow=
ner
>   :1.133105 Request Acquire

I wonder if we have a regression on BlueZ or PW for A2DP, since I
recall this used to work just fine while switching codecs back and
forth, but today it didn't work at all for me and I had to reconnect a
couple of times to get it working:

>pipewire --version
pipewire
Compiled with libpipewire 1.0.0
Linked with libpipewire 1.0.0

pw.node: (bluez_output.94_DB_56_F7_F2_88.1-70) running -> error
(Received error event)

>  profiles/audio/transport.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index a4696154aba5..5395985b990f 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -531,6 +531,8 @@ static void media_owner_exit(DBusConnection *connecti=
on, void *user_data)
>  {
>         struct media_owner *owner =3D user_data;
>
> +       DBG("Owner %s", owner->name);
> +
>         owner->watch =3D 0;
>
>         media_owner_remove(owner);
> @@ -742,6 +744,8 @@ static DBusMessage *release(DBusConnection *conn, DBu=
sMessage *msg,
>         if (owner =3D=3D NULL || g_strcmp0(owner->name, sender) !=3D 0)
>                 return btd_error_not_authorized(msg);
>
> +       DBG("Owner %s", owner->name);
> +
>         if (owner->pending) {
>                 const char *member;
>
> --
> 2.43.0

It seems you PW calls Release after Acquire, not sure if it didn't
like our response to Acquire or something.

--=20
Luiz Augusto von Dentz
