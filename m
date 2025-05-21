Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCA2957AC
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 May 2025 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859213; cv=none; b=q5ROUMkQwY3NPCEyvrB1lFYwOu5bTG/qKMpPTyr7SMnQMCF3i6kZ/kZklhyo8jKB7fIDG64mMEt4RR7sDihm+FlfRqtHWTVifLrxUulWZshMFrgG5Ws2eiizTV/KPnHyhBEBtSG/0QwFSxqbD/T2EHVzevAacCNc2xQqm8Kt+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859213; c=relaxed/simple;
	bh=YQBCK7SDaIwpo/lMHZJ5QX3JT6xHGtdw23hjg0aybN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARgsoRyJ4w8QhcALU/OywtbkgHpgjOQojDiW6rPWzXKe50+C5GwR5DQTzCnHwRndlHHvPZza2M3pk/arZpZyNvOxLd1pMWOfrSn29JZh8AmlmKM0Du5Ul9FAnZGHm4E3sOILQUHd2B8YISfZHuZEg02MTbzBlUWY62ogeamOUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsF9Zfva; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsF9Zfva"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-329107e3f90so44339061fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 May 2025 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747859210; x=1748464010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR53ao2AFoeZ/KVwtUA3XL196FAon3W5U6KRe4cSaIU=;
        b=HsF9ZfvaXw/Krf9P6n23Cwaa4wZH+OBUOs49LsJBdOseqzRYb5OIq11oQ2eb5p48iS
         /CwI9eeFQUy8hR1MXUVIKf+OZU8uPzbZGN49ganNuxKMfKWINpww8blmWkmQD5k1a/yf
         wPvfO8mjSemQHfaPGyf7640egt+Hxre584h+PpVtbo4arkAigFITp0wxwVMI0N0uS40X
         tetJ9F09bRzz3VbsWpfGz9aaF5uQgtIVcAS1Vu59C3MfFla7+MPA6IrOf1mZWoI7ixDa
         9ZvviFTBqXsym1qELihJ2E23XsNt7g6mzTr47wuZYvRcVu1Omw8ULscpy7G6I7njRzwt
         FK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747859210; x=1748464010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR53ao2AFoeZ/KVwtUA3XL196FAon3W5U6KRe4cSaIU=;
        b=sAMT8MwKQ17IsvciC7SGGLs84TTDtwOFH6MoUHNTJNVp+AX5Sp7izsqrydAsEmrIsE
         v1pnPaglXXXXADPulX5oHm29x2wMLbJtsuZT1/GFLNrCUlElHUiUuwK0jIZCrS+1b+Gy
         SMN3VYz7r4cZqdmCb3Mrq77IqXjFCVG8u5Fvs05Zho2XsMORS9f5lK1XAdnhsl0aK/90
         MJflrH9khehIJLpzmDRKhTnpjJqYzfC/JztzUhcgYRtDB0W0ohLxEB2neSZwbNcOwv4E
         8D73PwbTAK68aRStHvD4VhOpSR2GWtG7zWMtLHHN5YioCFR135uo8Fh4m7UmYjFTzI90
         K5VQ==
X-Gm-Message-State: AOJu0YxW3emIqjkdEpjLi4bVT2tORhuROEZPE9IfJlZMeqrOFNtBNvAZ
	dfYiRINbwYIyEVRJmyFjiqlEpvSZg/6aq69w0UhdF+8nvoZKrW/QAuJcpW8xMzhaTjMOdpIqoj1
	3wdi/9WOaCgv6fvsJDtZ+vfnaqTAY7bg=
X-Gm-Gg: ASbGncs7fg5yVBoRqWwzQdPL48wXD+Zfazna6HoRex/4e4Gt9PlWWci3n0zU2XqUAVw
	XpMTRkca4uhxuwYS7QNcfWR9ILYD+zpjbT99H4DJEvAUUjdwifFq8lJg92kyTRbE+DZT7olQcSr
	w8kLjrs7m8MBqLJ2Xlqd6fJG4ilbD3GBo=
X-Google-Smtp-Source: AGHT+IFZN0C/0ZRfNMcY/beALNmxarz49bEoklSknJ9dREF8PU/t1lWpKBwmFYFB7AOqhKlzhmENALybZLHWmXVNaN0=
X-Received: by 2002:a05:651c:e18:b0:30c:2590:124c with SMTP id
 38308e7fff4ca-328096b5d66mr63144361fa.11.1747859209275; Wed, 21 May 2025
 13:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520162621.190769-1-frederic.danis@collabora.com>
 <20250520162621.190769-2-frederic.danis@collabora.com> <CABBYNZ+jMjs2Nj-9LiREM31cwhhT4O9Fv0nay_qFY4JfJKszuw@mail.gmail.com>
 <edf37243-acd4-493c-9074-f3bcfe6dc05a@collabora.com>
In-Reply-To: <edf37243-acd4-493c-9074-f3bcfe6dc05a@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 May 2025 16:26:36 -0400
X-Gm-Features: AX0GCFuoFl9uUqwj25FPN5s-9sKDOkQUl9Ek-ABHGBoTGT2MAMNrggzG_VSF77Q
Message-ID: <CABBYNZK7ik+ut0D7dydkMzDz6uMkc4MxKXUOV0R3S93oEhS5aA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] src/device: Add Disconnected signal to
 propagate disconnection reason
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Wed, May 21, 2025 at 4:49=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Hi Luiz,
>
> On 20/05/2025 18:41, Luiz Augusto von Dentz wrote:
>
> Hi Fr=C3=A9d=C3=A9ric,
>
> On Tue, May 20, 2025 at 12:26=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
> <frederic.danis@collabora.com> wrote:
>
> Currently a client application is informed of the disconnection by the
> update of the Connected property to false.
> This sends a Disconnected signal with the disconnection reason before
> the property is updated.
>
> This helps client application to know the reason for the disconnection
> and to take appropriate action.
> ---
> v1->v2: Propagate numerical reason instead of text one
>
>  src/adapter.c | 13 ++++++++-----
>  src/device.c  | 16 ++++++++++++++--
>  src/device.h  |  3 ++-
>  3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index fd425e6d2..a10721489 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7549,7 +7549,8 @@ struct agent *adapter_get_agent(struct btd_adapter =
*adapter)
>
>  static void adapter_remove_connection(struct btd_adapter *adapter,
>                                                 struct btd_device *device=
,
> -                                               uint8_t bdaddr_type)
> +                                               uint8_t bdaddr_type,
> +                                               uint8_t reason)
>  {
>         bool remove_device =3D false;
>
> @@ -7560,7 +7561,7 @@ static void adapter_remove_connection(struct btd_ad=
apter *adapter,
>                 return;
>         }
>
> -       device_remove_connection(device, bdaddr_type, &remove_device);
> +       device_remove_connection(device, bdaddr_type, &remove_device, rea=
son);
>
>         device_cancel_authentication(device, TRUE);
>
> @@ -7601,9 +7602,11 @@ static void adapter_stop(struct btd_adapter *adapt=
er)
>                 struct btd_device *device =3D adapter->connections->data;
>                 uint8_t addr_type =3D btd_device_get_bdaddr_type(device);
>
> -               adapter_remove_connection(adapter, device, BDADDR_BREDR);
> +               adapter_remove_connection(adapter, device, BDADDR_BREDR,
> +                                               MGMT_DEV_DISCONN_UNKNOWN)=
;
>                 if (addr_type !=3D BDADDR_BREDR)
> -                       adapter_remove_connection(adapter, device, addr_t=
ype);
> +                       adapter_remove_connection(adapter, device, addr_t=
ype,
> +                                               MGMT_DEV_DISCONN_UNKNOWN)=
;
>         }
>
>         g_dbus_emit_property_changed(dbus_conn, adapter->path,
> @@ -8551,7 +8554,7 @@ static void dev_disconnected(struct btd_adapter *ad=
apter,
>
>         device =3D btd_adapter_find_device(adapter, &addr->bdaddr, addr->=
type);
>         if (device) {
> -               adapter_remove_connection(adapter, device, addr->type);
> +               adapter_remove_connection(adapter, device, addr->type, re=
ason);
>                 disconnect_notify(device, reason);
>         }
>
> diff --git a/src/device.c b/src/device.c
> index d230af0a8..00a0fbfc7 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3417,6 +3417,12 @@ static const GDBusMethodTable device_methods[] =3D=
 {
>         { }
>  };
>
> +static const GDBusSignalTable device_signals[] =3D {
> +       { GDBUS_SIGNAL("Disconnected",
> +                       GDBUS_ARGS({ "reason", "y" })) },
>
> Ive changed my mind regarding this, this should actually have the same
> format as Device.Connect error reply, so we use the same domain of
> errors org.bluez.Error.{Name} followed by its message.
>
> I'm not sure to understand this point as some of the possible reason are =
not errors
> like MGMT_DEV_DISCONN_LOCAL_HOST or MGMT_DEV_DISCONN_REMOTE, and so org.b=
luez.Error.{Name}
> seems inappropriate to me here.

We can do something like org.bluez.Error.None for these, or use a
different domain like org.bluez.Reason.Local, that still is a fixed
string that client can match, rather than a free format string, note
that sometimes an error can cause a clean disconnect but in that case
we want to capture the error not the disconnect reason.

> To be more similar to other methods, the Disconnected signal may provide =
the reason as text
> and numerical value, which can be useful in case of 'disconnection-unknow=
n' text.

But we are already masking the numerical reason, besides for D-Bus it
sort of makes more sense to use a domain name to describe errors.

--=20
Luiz Augusto von Dentz
