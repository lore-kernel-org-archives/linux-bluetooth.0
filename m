Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670C145341
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276232; cv=none; b=QhcIcpzVjORi2k4FxC+tQO+j2q90mUZ0B1XLa2sjOnp6AOvHVulCC18/1NGZGrhkqAdimaJNBAEDU7JhoesCribxRGIgZRVkq/odUdHTdfJ6sILsILwNFS6BJHmSOB6M41MOAISY8jRzDS83I2fta2E2EF/bjah8piiuCFTNts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276232; c=relaxed/simple;
	bh=X6op2gAZ7dIlIJjTFaJ9T6YPCBgl++iYYmlX5byOScc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BicUr6UNgz28rBiwWMn5NzF5in+xKjte/ScHbh2LdonpqcI+BXhMuxf2xGvAqUQMmxCNLBcJwHxm/aikdJ0Ve/D9Um4tOjaKi6txAMOSBLBv2biTGIuMlUd7+bmWC9ankC27KHX8+KCgy8Wek64RsdOZc2aOispMQK1SioISgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvTAQwXD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvTAQwXD"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so75601861fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727276229; x=1727881029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhsy5upB3mQAEAUrn4/rcfYst7rcdyaafnEXabWpdyM=;
        b=AvTAQwXDZDAS7CgTm7ICCFaScijiCiOZ3hIM83tufwCOr+JXmQQbIv9SM4VcJUSxiM
         57IMF7uwF74nlcv3VB2rWY4iMqLoEf5BP8tii0dy8+NtXmeQkF1vpnjLdefFjAo9M+fY
         qSUV31eUpTbl/Nmj1Rm+iDskmF9LeFp9/6PTM2grmDl80z1Mxf/Af/dZDQeDgZK1sW0o
         w1TDUVOddotFDkiQC4y+qxxnT43NIWiI34/KEOorWCCklmGRb7ievPX6IFDqzrJ76qdC
         /3u6p6SyCJna0UaPTMfaOxw5D1Fyu75aURo2J+S09wFHhCMznsSqajH+E62BU/tpIClD
         Hn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276229; x=1727881029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vhsy5upB3mQAEAUrn4/rcfYst7rcdyaafnEXabWpdyM=;
        b=RLJqLeiwu70o10obH22ssmaZkKrpKemY/00o4yAAJbCivkcK4bQiULEx4ftz37etMN
         wGf/6OzlORxl8qbybJWkHs98EnPqvgbWOE8ORO824DhZKYJDwqE67c1U5v6Yw6Mbg/B/
         DJQU7v8CgeytV9qRHibeCPW7yXV3t7qRtTi2Ya054OypNYKUyAlg2UiCY9HRKtvAvnhG
         QhwqYG9XFyrhd1bz8mM19N62pzEUTSXIeo1n/XRCmTpdZIPtrChjelep3a9wFUFO9ei3
         Rq8cqz86qui9wc+3Y72e4zpoyeWLQsOpiR9JCdNRZLtFX7Ot7tEyVwHUCoMmswPwVdU6
         vOsg==
X-Gm-Message-State: AOJu0YwakxXRXkd4LZz7MBqNEN2pmwpTDKc4u9565pDLxQXv+ltmKhiP
	xs5i9u3BqfSukc45ciye/RM/KZBGsZ3W+COMdOnuOK0i1q292J9r9lZ6SldoFcaEgpbmiX1MHdc
	rL17Ppm4ehxPgjjfj0NLIBV+yFo0=
X-Google-Smtp-Source: AGHT+IHIa0rx+Hj2jHE4YQEpj5+dobIOK7DuQ28TvfM0OHvtM0XZb1mx9dPk+INgH1dcboqzDuwa/JuvK+6LPSvW/No=
X-Received: by 2002:a2e:bc22:0:b0:2f7:5367:5c1b with SMTP id
 38308e7fff4ca-2f915fdb7dfmr21936261fa.11.1727276228531; Wed, 25 Sep 2024
 07:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925090948.1540589-1-quic_chejiang@quicinc.com>
In-Reply-To: <20240925090948.1540589-1-quic_chejiang@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Sep 2024 10:56:54 -0400
Message-ID: <CABBYNZJF0qMkEAE5rKz5GQB7ABkAHzSsMbn1Fdp3J8PdywOWtA@mail.gmail.com>
Subject: Re: [PATCH v3] device: Remove device after all bearers are disconnected
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_jiaymao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cheng,

On Wed, Sep 25, 2024 at 5:10=E2=80=AFAM Cheng Jiang <quic_chejiang@quicinc.=
com> wrote:
>
> For a combo mode remote, both BR/EDR and BLE may be connected.
> RemoveDevice should be handled after all bearers are dropped,
> otherwise, remove device is not performed in adapter_remove_connection.
> ---
>  src/device.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index f8f61e643..c25bf6b60 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3492,8 +3492,18 @@ void device_remove_connection(struct btd_device *d=
evice, uint8_t bdaddr_type,
>                 DBusMessage *msg =3D device->disconnects->data;
>
>                 if (dbus_message_is_method_call(msg, ADAPTER_INTERFACE,
> -                                                               "RemoveDe=
vice"))
> +                                                       "RemoveDevice")) =
{
> +
> +                       /* Don't handle the RemoveDevice msg if device is
> +                        * connected. For a dual mode remote, both BR/EDR
> +                        * and BLE may be connected, RemoveDevice should
> +                        * be handled after all bearers are disconnects.
> +                        */
> +                       if (device->bredr_state.connected ||
> +                                       device->le_state.connected)
> +                               break;

While this seems to make sense further down there is the same state:

line 3531: if (device->bredr_state.connected || device->le_state.connected)

So what this is doing is just to avoid removing the msg from
device->disconnects but perhaps I'm missing something.

>                         remove_device =3D true;
> +               }
>
>                 g_dbus_send_reply(dbus_conn, msg, DBUS_TYPE_INVALID);
>                 device->disconnects =3D g_slist_remove(device->disconnect=
s, msg);
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz
