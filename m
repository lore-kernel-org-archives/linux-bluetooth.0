Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4D3E7150
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173032; cv=pass; b=DB3Q6kAUZ7B3zYmL5MFDbD5hmBG6mVp0pPhsK7e/muU6TPYSacDOr1OM8R1rqSlHUql2iRHXm5uET6KwXoO1DGzb73kKtc6rOC117amWraHiJSmiMJxQecdYuzs+hqzIpPilwvIjDGyFQGlce+DTRAom5rFrXrLD2nOtIgCMrFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173032; c=relaxed/simple;
	bh=3pvbwqrSQCHstd3zjhq3FJd+DljYBCZEt5jPpFQpVnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLSC6L0k4Wco3pcq4uE81bNPI1XDacm+Lat0SYm1mztOkSS55rfHRlWH/F+/QDPKXwEHFGgyFDW/kKcxhuaUccZ3Gq2NvAITPrIUSW/OJIITxgr38aCmremTa5y0PBnUeGok6G69RoGVpHiHLQ5GZDxWDT1dUYwibb9sXWylCYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc0Qr46l; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc0Qr46l"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64e87a81639so1198642d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 09:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778173030; cv=none;
        d=google.com; s=arc-20240605;
        b=WWRoK7kbHkhgSbZ5VE/dzamwp+gCoe5/WmvfD6CN1m7Rz/RWHsvVOHsvcYuVa1p5NM
         dz0gDXWYA35GG2bzJzMQkn3SbIw964neuIDVhPD0KvlEePBoRd3gbIKg60cqmwJcqxXg
         g+P8Thp4weG4WLXZlPNc8EUAKZVXabOCGMJEKgdFfeHOtkTc3U6VqffbaNgIPgkAxSYV
         OJ2y+vZc7ltiHLHpxDT8bJkHq62r3cSSAhNV2NXdaVsFtVwy4wLw0UVf4H1zccmXmvLC
         bMB0MDUdn+2ts/T+s4FUZ7Ok79/6LUF6S9TTSW6vrcXP79TeCynCuB6ZEVPNaQcn3whJ
         CfhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bjfNv7qyKVTKgj/qV9Ej6P2+ef16A/kBd7RAVYDFD0s=;
        fh=ImHaVp9LKIGjD0tRyxgUyPXd5WNSYdKgZ1TGxuDzvzM=;
        b=lZM39gIZQhGKcjCHFvJdoKlBrpdJEP6fPFTlDAAMZALmt+JmL2F9KC1b1SNZ67krk9
         S5g1C2Zqao26Sf6ZOSSi/veyAWxtZODBo4TPuKBgYAPhdQs2veQNSFtx1i23cKCGbZlw
         Dq3B4MRfED37X8bspo182fgKC0h10LkxoG8KvKitI70x9ZVuunM0XBghvKG96kwYvtjI
         Qf8ZKAMyI4FYpDdSFN/Xlp1WJqAKQYYMtxlbXDNILELXH9M+0Gt5c5l/vOXJyGx17q2F
         M/Bl+CrUpJKBXK7qmuttmdL7rjbyLx5uCYEOdqKjlFmhd0VdDAPTa5hvqDzFc5fiN2mX
         Ek6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778173030; x=1778777830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjfNv7qyKVTKgj/qV9Ej6P2+ef16A/kBd7RAVYDFD0s=;
        b=nc0Qr46lspsE+uU3gGePLj+vVeYdm204IJOTkqn9uLj+iFi5ss4RHbjK29J/UQPvm0
         2kDpSfXnhptBhWIWgzY6rMdbb043flH8WoKFENiC8FVLk7l4jqusF2Rf/2pj2U+MZMV+
         zynwo0BL600aWQlWnurpFwBNt6zH+YPgklZQ23sCtaJQz8mLbHAiNHYR3xogvsT4yY5P
         7H3nMRma36QUzpKyVNmMlBA7aAVxmJ7K9AmeQCsjDd21N4HyIdftgLH0hFXN0g1uTmTU
         fE2fPpEeGuvnn6ujPEaZmOtdsHDV8c0Ryl9LY0suHlWEcw4z4q2pUK1jc0ZsuKz+rzil
         8Qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173030; x=1778777830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjfNv7qyKVTKgj/qV9Ej6P2+ef16A/kBd7RAVYDFD0s=;
        b=aux+lIKbulJJ8Z8+c+Gpdw/DmqUR9OaFv8x6KGV86irmniFL5VjCB1Ywaj5FJMy0Ec
         i/YqVlXAZoUWPnTQJDdh5hJskRcjdqnrqm/35ph3jTD630IyuF6vxmgzZK4LbRE4EB8x
         ahnPIPFhf/l21pSpapdXtgHeV7pUQLA0/9ct+ziiakEen0uYTm+RId3jBL1RwQTdxFhI
         X4zxTsFD3/iXmpUmPiwXn8/ZVxJN1ZSxuYIA/V2j2tblMfpB6olEQsLsndVM6Ua9J/1o
         X+G0oizsi9C+8pQ1FVGftYfw8Do3d9lLS24+EIZ6TnZZJAku6OKtqk6xr8Q3ClkjikXV
         Y49Q==
X-Gm-Message-State: AOJu0Ywy71j5tNNt4geXQVCAxx0W9TEHZKx7YXos5+xbQZtns4j1w7QQ
	TI/4rdKLndXqCNTvoW+PVzuWoknuEjOQLa9LvXmJibqN3oA8UGAskB8C/Q6Biua5bWStqDHvHQY
	zXml0HLpOrXIR3F624Vei9ejMXbm2tjQJrWh8
X-Gm-Gg: Acq92OHBXjguulz6unNdf0k9EO6GEg7GFZgxHnar9437yMsO4lktwZko+9/FgmT06of
	4QJ8NI89NjM1hBdZEObEbzpCs0rSKxNVG4N7g4nItt3dkr//W99KunE58QX1A27r7eRx+3Lb5G9
	o7FWJVYrZGQBUmcLRmu4nJREF2JIrcow7haxR2t6cRwc7lGIrYCx///dIEphsfFS0iKxFyCy3zT
	R/+71wPcd89ePy738uuEn4frHKJBZrxEk0HlYpESMS17RmhWDEXrVptc5bR0Y4pkR1vrMveQ2Do
	xUm+jMNAWi6WYbYUt239imkG2Wp8yFKX994RLItwdx8jbshXujlOCuYMYmy2xorwsADdKg==
X-Received: by 2002:a05:690e:4192:b0:65d:823f:3c97 with SMTP id
 956f58d0204a3-65d823f4295mr2808517d50.53.1778173029668; Thu, 07 May 2026
 09:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507161633.437600-1-frederic.danis@collabora.com>
In-Reply-To: <20260507161633.437600-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 May 2026 12:56:58 -0400
X-Gm-Features: AVHnY4IgqUmZZUDP_h5HWngScGH0BZWtdRDwg3CTisnwvaCkfeKSBA5x_-x_bnk
Message-ID: <CABBYNZKVPuthzegSwFUDGrBaFP8FnGjmz-Z__5G3Pb1qXpwf8g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Thu, May 7, 2026 at 12:23=E2=80=AFPM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> This allows reduces connection time for the BAP tests.
> ---
>  client/btpclient/gap.c | 22 ++++++++++++++++++++++
>  src/shared/btp.h       | 11 +++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
> index 68e029dcc..1a6c2c2f0 100644
> --- a/client/btpclient/gap.c
> +++ b/client/btpclient/gap.c
> @@ -2538,6 +2538,21 @@ static void btp_gap_device_connection_ev(struct l_=
dbus_proxy *proxy,
>         }
>  }
>
> +static void btp_security_changed_ev(struct l_dbus_proxy *proxy, bool pai=
red)
> +{
> +       struct btp_device *dev =3D find_device_by_proxy(proxy);
> +       struct btp_adapter *adapter =3D find_adapter_by_device(dev);
> +       struct btp_gap_sec_level_changed_ev ev;
> +
> +       /* TODO: get real security level */

I guess it wouldn't hurt to expose the security level somehow, not the
key itself just the level.

> +       memcpy(&ev.address, &dev->address, sizeof(ev.address));
> +       ev.address_type =3D dev->address_type;
> +       ev.sec_level =3D BTP_GAP_SEC_LEVEL_AUTH_ENC;
> +
> +       btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_SEC_LEVEL_CHANGED,
> +                                       adapter->index, sizeof(ev), &ev);
> +}
> +
>  static void btp_identity_resolved_ev(struct l_dbus_proxy *proxy)
>  {
>         struct btp_device *dev =3D find_device_by_proxy(proxy);
> @@ -2709,6 +2724,13 @@ void gap_property_changed(struct l_dbus_proxy *pro=
xy, const char *name,
>                          */
>                         if (!prop)
>                                 btp_gap_device_connection_ev(proxy, prop)=
;
> +               } else if (!strcmp(name, "Paired")) {
> +                       bool prop;
> +
> +                       if (!l_dbus_message_get_arguments(msg, "b", &prop=
))
> +                               return;
> +
> +                       btp_security_changed_ev(proxy, prop);
>                 } else if (!strcmp(name, "AddressType")) {
>                         /* Address property change came first along with =
address
>                          * type.
> diff --git a/src/shared/btp.h b/src/shared/btp.h
> index b99ad3a28..4d3c4ec6f 100644
> --- a/src/shared/btp.h
> +++ b/src/shared/btp.h
> @@ -286,6 +286,17 @@ struct btp_gap_identity_resolved_ev {
>         bdaddr_t identity_address;
>  } __packed;
>
> +#define BTP_GAP_SEC_LEVEL_UNAUTH_ENC           0x01
> +#define BTP_GAP_SEC_LEVEL_AUTH_ENC             0x02
> +#define BTP_GAP_SEC_LEVEL_AUTH_SC              0x03
> +
> +#define BTP_EV_GAP_SEC_LEVEL_CHANGED           0x89
> +struct btp_gap_sec_level_changed_ev {
> +       uint8_t address_type;
> +       bdaddr_t address;
> +       uint8_t sec_level;
> +} __packed;
> +
>  struct btp_gatt_service {
>         uint16_t start_handle;
>         uint16_t end_handle;
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
