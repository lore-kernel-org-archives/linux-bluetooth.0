Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21914C8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738096444; cv=none; b=rBJAPxmDi/Loa5yew0nS0c16sLgpQ4Uz3E9tMaPi0cQ2/nd29C3RnPP5hvneNrOgvKqvbJ9Mr4EmVU2k0CJaTHK/Ms/u/UTc/bXBTWZ/meeXLOXa6K39glBkT2/pI0AFu1OuUiPqHgppTgjsIjXRiwGTf8SRMLPM9/nnKVsMkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738096444; c=relaxed/simple;
	bh=LcG6RmxLzFIylSNbEUMhaudpLMZp8H1oQP0EYNv1PCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obhoRSmn6/fsaoxk6gAL9GpYNE2gKAUp0Bqz6N2i6+2COSKyXy54w9zktURjel80BDProOGycxemPmxursWDGAv6NcbveNh/4lYAfGbXKEF4bUiZdvPwosHmd1ryu/IAFTGIgzBzkj9MsY1Kr/Z45y+ZOMshh029dPvjoI/jheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crXDmzKj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crXDmzKj"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5426fcb3c69so5044089e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 12:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738096441; x=1738701241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8btvaydnPfzUyuIDK4m8O0kOplkehjETNVtlsv1ZzE=;
        b=crXDmzKjZhCXhz4wl7+9w5kEA4q/IFVRKE8AsP32PM38BkUmgHFWHNTcLgzaqLxX9g
         j15AD9Z1q26fLZ5cPwYH7UY+FxLDpJ7FuQTWDsglBtAx080OaNBPT1SQVkJET532qen9
         hjQmTTH4XbRx2szgFJIZ90BKqw09GwyZdqJwajCIdIUsBbeSp/j2V7fXxL6AnnKo9xMS
         0mrwbMAzY9MgKoFRAiXIzmOA8f71zRNIHMpMpkyfuusHbR1xN1rLcoUsSYf0UenGlAMY
         TI4v65MwfWPrk7GlgzjBSfqshDlTsbZlPVFRNadvK22uUm80Pyh7/ls9H/b3OOiP5SUc
         HVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738096441; x=1738701241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8btvaydnPfzUyuIDK4m8O0kOplkehjETNVtlsv1ZzE=;
        b=ofumg1TJ344y1+KBDtA+2La3Omqi4wS09pXqDSMdOclbgkdk+NNKhrBgkcOR4ndlzu
         rOpHk8wqPhicfB3AqadlSST+YpUEuXrkJxBsbDJ3fw5owA//2p+YJ8sTO1fo2VnJKQje
         JOtv4N+6wp4Q3rlozL3RWP9Hr0aKIgFzPGzCDEDLZPhll296/ed67/xdcxL797Uk1edy
         NRePjzADC4QFDXMpDN2YBo9wdx7u9pPZK5lb45Dj24wNmgNf0GzsjNE3dSWKd/smpCbQ
         re4odSZUpaA8QGwf2LrF2MkfnUuJl/iJXTmVTxpEpPXy4wbJEFGhqzHhML7rLmtdFnU0
         EKjw==
X-Gm-Message-State: AOJu0Yz/Y9sEld98ok/HlkJbPMnRlVQ4v0RIjDnBsUsZ1IkxbZ69syzO
	xK/F+jRjiJRcHxaxTftvwrNGu9WhtLOsmasWEQ4UAT6qYXG0u0NRzFhR/mu3G+ns/t5S/LOeqiT
	AUovzFGb9CTcH4HtM3Thbzk9j+SmskTdX
X-Gm-Gg: ASbGnctvZ/IhECQAspFwy5ATbpBBn9X8wK2jFmJ0ndO4pfxtedV802uizH67sLlod9b
	p+yKCcIlCrBrSlaVqa8xsCtW5NSjYMsgvRsiVB1b0TGIqW6eBkcAUfOBGdn8mSgwLJXEsWdofmg
	==
X-Google-Smtp-Source: AGHT+IEANFwUD3SV+Eyz16Pxx5I84QKUwZniJea7lOXhtNUmPP7NEEh7jc28K7aoTI2ZVWjsf1cHRY64Os++D9vrEYA=
X-Received: by 2002:a05:6512:3b99:b0:542:2a8b:d56f with SMTP id
 2adb3069b0e04-543e4be0021mr125283e87.4.1738096440794; Tue, 28 Jan 2025
 12:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128102937.16215-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250128102937.16215-1-ludovico.denittis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 28 Jan 2025 15:33:48 -0500
X-Gm-Features: AWEUYZkNSYcxY9NUXKWkMYw9Mb7zs39bZN-XGKYgLBZop64Ytv2ZpHryX_z6QSY
Message-ID: <CABBYNZJ8NUAGpmmaezy=4KJD4uM8f7J1pkMgZnDoOoFkdRSRqA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Include pending flags in device_flags_changed_callback
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Tue, Jan 28, 2025 at 5:30=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> When signalling the new device flags, we need to include the pending
> ones. Otherwise, the eventual non-zero `pending_flags` will be wiped out
> in `btd_device_flags_changed()`, and we'll lose the pending changed
> flags.
>
> Fixes https://github.com/bluez/bluez/issues/1076
> ---
>  src/adapter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 5d4117a49..cbc0f678f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -5727,6 +5727,7 @@ static void device_flags_changed_callback(uint16_t =
index, uint16_t length,
>         struct btd_adapter *adapter =3D user_data;
>         struct btd_device *dev;
>         char addr[18];
> +       uint32_t changed_flags =3D 0;
>
>         if (length < sizeof(*ev)) {
>                 btd_error(adapter->dev_id,
> @@ -5744,7 +5745,9 @@ static void device_flags_changed_callback(uint16_t =
index, uint16_t length,
>                 return;
>         }
>
> -       btd_device_flags_changed(dev, ev->supported_flags, ev->current_fl=
ags);
> +       changed_flags =3D ev->current_flags | btd_device_get_pending_flag=
s(dev);
> +
> +       btd_device_flags_changed(dev, ev->supported_flags, changed_flags)=
;

This doesn't sound right, it would be as if the pending flags always
succeed which I don't think it is always the case, perhaps we should
something like the following:

diff --git a/src/device.c b/src/device.c
index e8bff718c201..4959f36542fb 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7413,7 +7413,7 @@ void btd_device_flags_changed(struct btd_device
*dev, uint32_t supported_flags,

        dev->supported_flags =3D supported_flags;
        dev->current_flags =3D current_flags;
-       dev->pending_flags =3D 0;
+       dev->pending_flags &=3D ~changed_flags;

        if (!changed_flags)
                return;

That way we clear pending_flags based on the changed_flags.

>  }
>
>
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
