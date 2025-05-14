Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAE170A37
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234392; cv=none; b=HoJ5d0T6ea+FWGA8Apkg7w7H/mUOkpTPyaGDTLOvRWoduO5uu3em+kNdur2xgE026yTHJfWyDlnQYs430iQv0llRtqf80BGicrkVpaXcyxOrW7ccuWgRyUkaioWzG7jpWXr5pBn8P0L0ZUep4/Mu8vXnUnc+vVHUeJXV8cqoAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234392; c=relaxed/simple;
	bh=1XpigPrS9wJP31ZKScNYK8fxp3mtRupanUhnY1ha+M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlDRUl1I2AwVrP1PN9IOH4HhCGo+u/oS9A4ZIgXLvfx+ptR9mpuS+RNdK9UBFBrGS73dP6vVLjrr8N/E9pOZZtLWgQVlW38sp9+OGzc7L1Q27rPqMJEkVeh2DXCc+//rqj9sz/TIBOlBRaS1gzQUkFd/vMbKl7lO9nU3GuJnzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCF61KE/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCF61KE/"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bef9b04adso65562261fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747234388; x=1747839188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDQDyTE2KWxQza5qq6rGZPPsF3TYPDPi+DCpGvSEwlw=;
        b=jCF61KE/v36zdvOZT1lW9Gu51wdhpju06srA1BeRIgovHWirlrHDRMe4B4IdLjuMqd
         kIjIPMhBclCHGn8AxL2KmivvN87KbzNi3jkKx3hRpN+CNrquwdrpsByOzRL05bCKlO2j
         91C5mR1dCMdkQveyQFvZ0X0yShM/+ho9+8xQNDbwTeyOl9gi7OUgd8gnBcfX2NEHPJUH
         8EL5i+SurHMhAkyn4ZKEK9o7OF3PQnMG1C6Zlg1IjNft7v65JrGGVklH3PcaiXcFrXEo
         wBxx91QElEYUkTj+wxSqbiJOKU5S4Onxun2hWs4hlqqPXMG+D8edrpwVaQAE0ZX++nRo
         JaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747234388; x=1747839188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDQDyTE2KWxQza5qq6rGZPPsF3TYPDPi+DCpGvSEwlw=;
        b=XeVJEcALz1IlZR2w03AAXbvxaf5BMJ9TvUFHEsdei9L9u8xqMAtQ9AroBuVvv7gB8O
         uC71LAuF50Cb7gS2Hja5+Syw9AMg8ww7NBBYFBURpxv5Q0l3Y4KZVs0ACCpdlK0rIudn
         KLEhfKMKhxH3sS/PfSYbQqVMAQcqwnfXWYA+JbvWsviwoVBH+zRwXl9TafgzESyQAUYr
         npTcUR+kjUUfctKkl9fKu1VrmYVcln3wOWgKSSWVhzwSID7YsBZFZYsiZcFhhiEQEf77
         3nF0e8fEdG5JQFROoh/PV96NX54tvqg7uAmrYACJtFfNxgDAkVJrolVsvFLUDNT9CXw8
         Xawg==
X-Gm-Message-State: AOJu0YzI5sdhwKTL/yNidFl8tCnzsU56DviVVhSzerDWGEeBD72wJ/hj
	dNQHgx9YA/2k/EGvaPpX5lLQvvu3uvIVVFynZ84Ip7HQqoOaAK8iqrljz3UiS/m1TmGqURlGneC
	oHyyF/sk5XRamk+Lb8sTaX11pXannpJOn
X-Gm-Gg: ASbGnctNS0XkCDVSMd1BQ+U3AbpY9l5910azR/z+fxOZLty19IQw334SORueBk+l7I6
	go9Frva/MKi1S75xEDn04fVekUtGjwgmdAVrYS/AtIMeaC4FkSDd8XV65RyKlkU3cDxDZxzdz0w
	IiZUJOAppZzk8lbFfGLz214Cj0oWx0iJU=
X-Google-Smtp-Source: AGHT+IGOV2kPV4h/+1yJAHPUUTIxfbhgnVonLmrSaZhx31GnalVY8rLB1+ATpXSzZxhOugviuzI5YgbnLvNvfUdNGCc=
X-Received: by 2002:a2e:a5c3:0:b0:31e:261a:f3d6 with SMTP id
 38308e7fff4ca-327ed1186bfmr17014691fa.23.1747234387974; Wed, 14 May 2025
 07:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514112050.17438-1-frederic.danis@collabora.com>
In-Reply-To: <20250514112050.17438-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 May 2025 10:52:55 -0400
X-Gm-Features: AX0GCFu7rlt5gZARAY7zS6reukecQcM4nkuaZ_kvvSpvPUWbZ6_6a6V2KE7wdls
Message-ID: <CABBYNZKEP8uPuCLkXoms5MKMoiFwJmoB-tZ6xHX5tGCtnDsFYA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Reply br-connection-key-missing on
 connection bonding error
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Wed, May 14, 2025 at 7:21=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> Currently when connection is removed while the client is waiting for
> Connect() the failed message is br-connection-canceled, even if this
> is due to bonding error.
>
> This commit reply br-connection-key-missing when connection request
> fails due to bonding error, allowing the client to differentiate
> connection failure reasons.
> ---
>  src/device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index c364d72c3..816282eab 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -246,6 +246,7 @@ struct btd_device {
>         struct browse_req *browse;              /* service discover reque=
st */
>         struct bonding_req *bonding;
>         struct authentication_req *authr;       /* authentication request=
 */
> +       uint8_t         bonding_status;
>         GSList          *disconnects;           /* disconnects message */
>         DBusMessage     *connect;               /* connect message */
>         DBusMessage     *disconnect;            /* disconnect message */
> @@ -3636,6 +3637,7 @@ void device_remove_connection(struct btd_device *de=
vice, uint8_t bdaddr_type,
>         DBusMessage *reply;
>         bool remove_device =3D false;
>         bool paired_status_updated =3D false;
> +       uint8_t bonding_status =3D device->bonding_status;
>
>         if (!state->connected)
>                 return;
> @@ -3643,6 +3645,7 @@ void device_remove_connection(struct btd_device *de=
vice, uint8_t bdaddr_type,
>         state->connected =3D false;
>         state->initiator =3D false;
>         device->general_connect =3D FALSE;
> +       device->bonding_status =3D 0;
>
>         device_set_svc_refreshed(device, false);
>
> @@ -3658,6 +3661,7 @@ void device_remove_connection(struct btd_device *de=
vice, uint8_t bdaddr_type,
>         if (device->connect) {
>                 DBG("connection removed while Connect() is waiting reply"=
);
>                 reply =3D btd_error_failed(device->connect,
> +                               bonding_status ? ERR_BREDR_CONN_KEY_MISSI=
NG :
>                                                 ERR_BREDR_CONN_CANCELED);

Hmm, we shouldn't really be assuming that if status !=3D 0 then it must
be a key missing error.

>                 g_dbus_send_message(dbus_conn, reply);
>                 dbus_message_unref(device->connect);
> @@ -6763,6 +6767,8 @@ void device_bonding_complete(struct btd_device *dev=
ice, uint8_t bdaddr_type,
>
>         DBG("bonding %p status 0x%02x", bonding, status);
>
> +       device->bonding_status =3D status;

I also wonder if we should reply directly here in case the bonding
fails, but perhaps that depends on the error.

>         if (auth && auth->agent)
>                 agent_cancel(auth->agent);
>
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
