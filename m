Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118132DEA86
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983303; cv=none; b=HbC6NFH4hO4B1gUoxeyA9+01xCWPkJrY/piO1PamAtkaPoQl6VYeY73oj3P7zKuBatJXUTqwLa8aj/2gvBJQu787NrGsQ6/lwH2V4TbJTjTormQXlGXqdSelzLQnMg5SC5y6kZGhs9tCa5cQh67Ni4HC3ItljqmPwVtUzuzGRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983303; c=relaxed/simple;
	bh=Psf75kGZBN1bMx3NcBxARjcngBN7NUgMNgkIhj4wFm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuX4SNG5FyFBfCTox4H5c3FcZfuQtFnhKaV9+k6pmMEXRTAX5s9NT4Mx+dCid6rZoOQgIqMs/w6hPOKVXgwCwwL7FfDClB88BMAtwvQ6/MXvk7v/yju9vmQW7ATb4oy7PjMYp+3IrJTRiQRzQoBmVhht8u5LhWIUHDzEvPkVQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCQUgigM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCQUgigM"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so35820741fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751983300; x=1752588100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1uMpkXZjZSEULdSdWPChSfzO/Wu3UI1lxbyqAqDZuk=;
        b=OCQUgigMLQLKuJ45hDQ744tyCWP+fq9BqSKw6USUQWPlAqg77ynwFVYtlwharOsd0y
         00EbtP/Mg6slulM+1HfWh8d20hisXNcD6LoRY2d9fNn4lhiUBnuNxOaL3+p53MPgoKOG
         oZQT5+DtGLjXHHDGqSsYeIjHTVBilEs1y2WF0MdRMF8y7EDsSGujUhlj+NFNNa3rf4Xv
         TEuBBYyzcgz1nkRvVLUPYUMt+1STLYxltfAi+SfAcQKjpffg59e4zQDmsJ8t5WSexERH
         GmUxD7/gohOYX7298z2iQ1dF5Vgi4J9XCV06OwBdkdVyzoMP++1OXgrqqXFyPBXT4bwp
         AmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983300; x=1752588100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1uMpkXZjZSEULdSdWPChSfzO/Wu3UI1lxbyqAqDZuk=;
        b=D7hpK3mUwF1UZyx1oXgOgHIDiJANEb6V8lLpLhhWqiiQW1YqoRYpVW8v6AnJFC8Ydz
         /PYRbOYQ1E9+c8xwqrAiXEB6I4XDVurqHr2hlLEb8ht+RUYR7+FaYmm/7rJ8Y4hBfBof
         1wetZ6Ve1aYNeD7qGlC0fEfmDLKOEaMYkKfqQsfwpIBxYpCShcuhT2n65RW7jdZeq66K
         P+DSIRG02qcHbz3CxYXwgyeZuXtM5QCme71brk/D17e+n9lqZFDbRrqaLBUlSNUZNQ9P
         x0qebKE+QnWcCqZC68EUoD2cZrE6NViGwh990Cun10sV7ndJ9PF+OHBCxlbimj7AmCGp
         EuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1+ACBqKcOY83MJG1lt+nrMzPgfghB1HJsaKLlr5RSllo71j1JwcxQSP9G2IJQl70gwm59TWj3Qu2XrQb0R9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/PXdTqZ6WQ7MgvUf9kZi6UwzntXOqSo8il90Y98AL/X5flTQ5
	Z948DxZwGSJFadWChYs5TvYCr9+04nv/o7hRo1682ZeKMms3rhyZC3qdovn2BikhfdjsFHhYj9P
	iUH6BRopo53E2O1ZquD+dqPKcPI81B8+XTA==
X-Gm-Gg: ASbGncu1lqUpaX2CzeGlw5Ft3gssFrkd0vWGPTmyjyraKWaffSwudedl0bhAXRehZpI
	J5QO+TXKAJpnTXF8r5DggcfO2BkEV+qtf/c71da5XEk07KcPX9KSAztStcPFFVh4aBPh/qwvSVj
	7xRz4lY9YWp0Ki3QQCwqRceuimba/dJTyo8oidoTl23qwxRvUrWqOR
X-Google-Smtp-Source: AGHT+IFhbvFybZZUdgvGQGH/68Wm/nB03/u86HZFMujKlaTnLYwkYlxwKFVtCoEGPRMZu0j/YYtGQ/mnS8Xyd8GreE0=
X-Received: by 2002:a05:651c:f12:b0:32b:7111:95a4 with SMTP id
 38308e7fff4ca-32e676208a6mr52685661fa.37.1751983299469; Tue, 08 Jul 2025
 07:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708070822.185375-1-frederic.danis@collabora.com> <3afadd606d45927b75941cb94526327802fcab19.camel@hadess.net>
In-Reply-To: <3afadd606d45927b75941cb94526327802fcab19.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 10:01:25 -0400
X-Gm-Features: Ac12FXzDjhftBemhyXujGiqLKOskVQUAanxgK-ISDCaIYvBkXQgixHrz_FDS5ko
Message-ID: <CABBYNZ+0cSAgwH-irwsHcB_g74YDQgm1gtAhGxFewXM3HV--rw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/5] audio/avrcp: Fix crash with invalid UTF-8
 item name
To: Bastien Nocera <hadess@hadess.net>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien, Frederic,

On Tue, Jul 8, 2025 at 4:05=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Tue, 2025-07-08 at 09:08 +0200, Fr=C3=A9d=C3=A9ric Danis wrote:
> > As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
> > Displayable Name Length property, the target device may truncate the
> > item name:
> >
> >   Length of Displayable Name in octets. The name shall be limited
> > such
> >   that a response to a GetFolderItems containing one media player
> > item
> >   fits within the maximum size of PDU which can be received by the
> > CT.
> >
> > This truncatation may occur in the middle of a multi-byte character,
> > at least with Samsung Music app, which triggers a DBus assertion and
> > crashes bluetoothd:
> >
> >   profiles/audio/player.c:media_folder_create_item() Din Dhal Jaye
> >       Haye with lyrics | "=E0=A4=A6=E0=A4=BF=E0=A4=A8 =E0=A4=A2=E0=A4=
=B2 =E0=A4=9C=E0=A4=BE=E0=A4=8F
> >       =E0=A4=B9=E0=A4=BE=E0=A4=AF" =E0=A4=97=E0=A4=BE=E0=A4=A8=E0=A5=87=
 =E0=A4=95=E0=A5=87 =E0=A4=AC=E0=A5=8B=EF=BF=BD type audio uid 1
> >   profiles/audio/player.c:media_folder_create_item()
> >       /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
> >   profiles/audio/player.c:media_player_set_metadata() Title: Din Dhal
> >       Jaye Haye with lyrics | "=E0=A4=A6=E0=A4=BF=E0=A4=A8 =E0=A4=A2=E0=
=A4=B2 =E0=A4=9C=E0=A4=BE=E0=A4=8F =E0=A4=B9=E0=A4=BE=E0=A4=AF"
> >       =E0=A4=97=E0=A4=BE=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=87 =E0=A4=AC=
=E0=A5=8B=E0=A4=B2 | Guide | Dev Anand, Waheeda Rehman
> >   =E2=80=A6
> >   arguments to dbus_message_iter_append_basic() were incorrect,
> >       assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
> >       file dbus-message.c line 2775.
> >   This is normally a bug in some application using the D-Bus library.
> >
> > v1->v2:
> >   - Introduce new strtoutf8() util function to truncate a string
> > before
> >     the first non UTF-8 character.
> >   - Use strtoutf8() for AVRCP media element name
> >   - Use strtoutf8() for MCP player name and track title
> >   - Use strtoutf8() for Audio GAP device name
> >   - Use strtoutf8() for EIR device names
>
> Would be great to have a test case for that new function, with a bunch
> of the problems you ran into tested for.

Yep, we do have the likes of test-eir where we can add tests with
names for the devices, we probably want to try with strings where
there are invalid UTF-8 and also using other things like UTF16 and
other string formats to check that it doesn't crash at least.

> >
> > Fr=C3=A9d=C3=A9ric Danis (5):
> >   shared/util: Add strtoutf8 function
> >   audio/avrcp: Fix crash with invalid UTF-8 item name
> >   audio/mcp: Use strtoutf8 for player name and track title
> >   audio/gap: Use strtoutf8 for GAP device name
> >   eir: Use strtoutf8 for device names
> >
> >  profiles/audio/avrcp.c |  4 +++-
> >  profiles/audio/mcp.c   | 11 +----------
> >  profiles/gap/gas.c     | 11 +----------
> >  src/eir.c              | 11 +----------
> >  src/shared/util.c      | 42
> > ++++++++++++++++++++++++++++++++++++++++++
> >  src/shared/util.h      |  1 +
> >  6 files changed, 49 insertions(+), 31 deletions(-)
>


--=20
Luiz Augusto von Dentz
