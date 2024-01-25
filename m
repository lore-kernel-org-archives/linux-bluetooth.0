Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F44F203
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187747; cv=none; b=fNs0C0yBleUq21trwUa5KUAnGL949OeN08z58xyCc7EE0L9ogRLNBGcF6XXAd5DKoFTBEmtTkLTKDFUhr3pOmqvvVRViFgydFkzjyMp5VJvEUDj0XxUZ3KyYC0ixjxLjBlgcKxkGLkK1cDxEb+6eyX5+fkk/FONRfAX782gbtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187747; c=relaxed/simple;
	bh=joBV6NNGxgY8RVN04013+KSlP+BbdEu8LHlxp1RjQ+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mboGb7UGGYomtDz3edC3kvHUWXFv1yHO8yRF09TpaVDV4ld0teWfJ9zhwwbaQa5ElWSmTmtibosiH2VjJexmeLbhTSReXBxkunV2EJjmABEISfMdDCurNP81sxyyIzudKClKeTt6YdcbHnTFf/KKawmO3fdm+4C9jQtxmLhd1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl; spf=pass smtp.mailfrom=codecoup.pl; dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b=3BVSgx2b; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codecoup.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20230601.gappssmtp.com header.i=@codecoup-pl.20230601.gappssmtp.com header.b="3BVSgx2b"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7976634a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 05:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20230601.gappssmtp.com; s=20230601; t=1706187744; x=1706792544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wD8BUOt42IzQ9M8MH1y9RdGgGge6Y2n7cmwrb73yikQ=;
        b=3BVSgx2bXnzcLdXhaQ6HaOE52b1HXc4aKih8Z7x62kYX/KkG/UWBdV/tGC5DLMqZRz
         FFIR+Z3ke5Hh+qB6JvOqgsTG8MUf5rWb/1L4VlrcSkcXOrvqh1T6oVX/x4OZ6aW32rtT
         4cDsU5drbchlcRAlJQHkRrY3N9GPNtV95bjMrwb8HqGtnJ9MZIW3pxRPGYkeGd5U5iGq
         3waeOq/43qjfPZuoTd1h+LJLYcCzpY7dbtwwEcS/V8y6f4CDL3+ypAIEAfJ5bMLHe9k3
         gRJwwM79jV4+XW5FXYbrm3aImPJib4WmUk6AlOK4G8Q2YzY2VQwLGpS0HsZBFtudIGgL
         +Mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187744; x=1706792544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wD8BUOt42IzQ9M8MH1y9RdGgGge6Y2n7cmwrb73yikQ=;
        b=UnWPOHT49yVg68SXxUO83IkjlW69GBkoMBaCq1efIRMWHIkre6dWHSxuL5NupvEeu5
         LELF4nhJl+EouqTPTwCd2w7PgU+fTaOgstRy8YSQZ+hg3hVOMehvBFu02YTm8TTPnmTT
         oYT5ypRWUJlgubxk2s01W5J3CCSVx159iTCiXH3+mjRUIBpUkus2f1TMVeD8gGy+96Qm
         q/5nkyigB/djM1GOakrHXjtHHPxK89QASZcU+CLC+0CwzmHB94tzYVJfkp/F0otkLMwK
         bo+EEm5Kmce4hz1dQzLCYVyzL7QMmDtLq3NBcpwuYiPuX3LCQotDkNSHOzbMaBPatUdT
         vECA==
X-Gm-Message-State: AOJu0Yw7IMlmbMLpp8tv7OEKzriL4alMukIW4xznUuxY/puU1C7zm3pv
	agpz0b/XzpfgMyGRcr8MaziV/VNvQbohk5YOsm7+9z4VPpTeeTLC9uMq7aTqM1VJ/RKJeHue4Kb
	8PWDMlLufxxxReacvJ0uzExT25/SlIqV6aNZwa2QgLzolVJHR
X-Google-Smtp-Source: AGHT+IFhLvHce3/EHDNtKB8w/kKWmoE7gw9aDGx9csaoyjwJJE9LHR00UfbDvWDFW1mETHaBhz6hPKYMrSHcRGTrWsw=
X-Received: by 2002:a50:8d1c:0:b0:55c:fae1:5f4a with SMTP id
 s28-20020a508d1c000000b0055cfae15f4amr515036eds.6.1706187743720; Thu, 25 Jan
 2024 05:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Thu, 25 Jan 2024 14:02:12 +0100
Message-ID: <CAAEJBhKW3XZCZiz6MZ8NbCW61iU0gxL_LGru5y0Ubb_hbGAt_g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/8] Remove support for external plugins
To: emil.l.velikov@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 25 Jan 2024 at 01:07, Emil Velikov via B4 Relay
<devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
>
> Hello everyone,
>
> Here's v3 fixing a small bug with the previous patches, which was
> tripping the CI.
>
> Link to the previous revision can be found below.

Just a comment that external plugins support was added to avoid udev
dependency (from sixaxis) in bluetoothd.
(not that I have strong opinion on this, just a note, I don't remember
exactly why it was done, maybe Marcel recalls?)

>
> Thanks
> Emil
>
> - Link to v2: https://lore.kernel.org/r/20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com
>
> ---
> Emil Velikov (8):
>       configure, README: introduce --enable-external-plugins
>       obexd: factor out external plugin support
>       bluetoothd: remove external-dummy plugin
>       bluetoothd: convert external sixaxis plugin to builtin
>       bluetoothd: factor out external plugin support
>       bluetoothd: don't export internal API
>       bluetoothd: change plugin loading alike obexd
>       android: export only (android) entrypoint from the modules
>
>  Makefile.am              |  17 ++----
>  Makefile.obexd           |   2 +
>  Makefile.plugins         |   8 +--
>  README                   |  13 +++++
>  android/Makefile.am      |   3 +
>  android/hal-audio.c      |   1 +
>  android/hal-bluetooth.c  |   1 +
>  android/hal-sco.c        |   1 +
>  configure.ac             |  10 ++++
>  obexd/src/obexd.h        |   2 +-
>  obexd/src/plugin.c       |  93 +++++++++++++++++++++----------
>  obexd/src/plugin.h       |   4 ++
>  plugins/external-dummy.c |  28 ----------
>  src/btd.h                |   2 +-
>  src/plugin.c             | 140 +++++++++++++++++++++++++++++------------------
>  src/plugin.h             |  16 ++++++
>  16 files changed, 209 insertions(+), 132 deletions(-)
> ---
> base-commit: a9d1f6f6a625607de6c3f5b7a40a3aac5f36c02b
> change-id: 20240116-rm-ext-plugins-ba0b852a492b
>
> Best regards,
> --
> Emil Velikov <emil.l.velikov@gmail.com>
>
>


--
pozdrawiam
Szymon K. Janc
