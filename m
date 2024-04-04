Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2211BC46
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242756; cv=none; b=cxNnKDc68QtaCP1XGddzhMoqo8eBC4Co2yUvyvQuP9VFs3L3P2JQdGrhsTh/M8bcLy8uRXmiITXPWMOH1mdNHN7tDkmBG7/WcY+QoMSuzxuTDq7RA1oDBcUI8GKEyLMOh2JNf7FAmlbIJrRwUOj6z6DI65BJYvLxHiF3KHLLXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242756; c=relaxed/simple;
	bh=SbnHO41/mqL5szyrnVGV8VFEptIH0oJcbUyGQSikPz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9/a1QNtk4ZHlErXxEL46ISNVv0wtvdmeT2t1kcW3HjhywgJ0NjemWZMhzrati9ffuOhGJxWq/dJz2KH2Kf2rpf5lxUpQR8GNrVqDbNS5kYv6DFeCcIrOJN1V1fLdEEDpiBFA9uCXnKo2crDy6WVYYhb5vSCatrzGdJxsDkwxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apSSwOvx; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apSSwOvx"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8129797fcso14653481fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712242753; x=1712847553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iExl5yWgF6ewZTVDUwxjdktgzpPueh1+2u16rTUnNDc=;
        b=apSSwOvxEGL5jR3a7VbLeff//ET4CiIh2CZXp5bsDFPgPqNKJxc01IUZrkLqCtSnm6
         y15MfpwnnvnhJsGF6HZg2jf+nSYB1kciEpnugH2Sar8kRO3j0us+wY+3I00BprqMs09Q
         QM7ZbjnWNSBSv6adbUByVo/MwV00OAMn0SDDkAR0ENTZ1DBTID2JkYNKex1F58XzP3Xr
         q0CErVC23xjnmvsXNp0V7WGYaohRRmpGQxxoqhCKMUusUogviYj3uc4ab7yj9qi6u1J1
         Su8p2brn8eUwA/FqoFC+0JdcXb3+Ysa70bXWtJXh/yaTG4R50wy7TEfeP4w5Vpky5hTN
         F4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242753; x=1712847553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iExl5yWgF6ewZTVDUwxjdktgzpPueh1+2u16rTUnNDc=;
        b=pVfaYMSoaBgaVBFl0bD0AmID9UcdB/LaPp/4XfHtVJYkuUPlP+smx6tqtIjQKoG859
         AhSG+BRdqDiVqje8W+vS1WaF8OmNHlOUTKCS9qOtDnsF44AAA6T7GzkfrSIg0UMgZrEP
         09YV4s9HAqTzCPG3phR2aAH4CUuaILP6+jacnEsli7tm1ZZXHjS2trDG5/zkKNvyfPE7
         I1Z7ko+zi8TlNncxScIwmKbnejMEzCXAgEmZ3fUSdcc9wAtMCLaFeVsjPru6nALGnJ42
         XCVFTx93XhOOZsc5v04eH1mXD4hVhRAnKuPwO6q1W/hB/6svQfxQp0LS8YujBamTLQv9
         kxXw==
X-Gm-Message-State: AOJu0YyhUFWEyAH+NtnTNdVXnte3oAifxYgataSdCSD1VulUQLQzJwBZ
	o6bHRuYHddWuXV85Oq9ozoB49a5HoPNks06fFqYUcGGceoR+kXbDj9TrDZrPTJdQVWdJrpaJy6b
	lPIp8Du8vFjJhaAlEqfx0zVcKVFk=
X-Google-Smtp-Source: AGHT+IHvyklYW5K/JfA2bEumY/h2zVHFVx0B6+wKplpd9m6o68iTLFwl0gERpgX+N5wKZ1ctoB2exqn9XO07sK6c9cc=
X-Received: by 2002:a2e:9d05:0:b0:2d6:ec1b:ee06 with SMTP id
 t5-20020a2e9d05000000b002d6ec1bee06mr2210727lji.11.1712242752612; Thu, 04 Apr
 2024 07:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
 <20240404024521.120349-1-dimitris.on.linux@gmail.com> <20240404024521.120349-2-dimitris.on.linux@gmail.com>
In-Reply-To: <20240404024521.120349-2-dimitris.on.linux@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Apr 2024 10:59:00 -0400
Message-ID: <CABBYNZJjSp74CoJU2RYCft_nQi85EWnk9JOvyxMH8YmAtON+8w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Refactor btd_device_is_connected
To: Dimitris <dimitris.on.linux@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dimitris,

On Wed, Apr 3, 2024 at 10:46=E2=80=AFPM Dimitris <dimitris.on.linux@gmail.c=
om> wrote:
>
> Splitting the service state test out of btd_device_is_connected
> and using the state-specific test from adapter_remove_connection.
>
> This intends to fix a busy loop that happens when BT is disabled
> from userspace with e.g. "rfkill block bluetooth".
> ---
>  src/adapter.c | 2 +-
>  src/device.c  | 7 ++++++-
>  src/device.h  | 1 +
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 4bcc464de..0b7aab4b5 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -7486,7 +7486,7 @@ static void adapter_remove_connection(struct btd_ad=
apter *adapter,
>                 device_cancel_authentication(device, TRUE);
>
>         /* If another bearer is still connected */
> -       if (btd_device_is_connected(device))
> +       if (btd_device_state_is_connected(device))

Perhaps btd_device_bearer_is_connected would be a better name.

>                 return;
>
>         adapter->connections =3D g_slist_remove(adapter->connections, dev=
ice);
> diff --git a/src/device.c b/src/device.c
> index 5e74633c6..123b1b796 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -3273,13 +3273,18 @@ uint8_t btd_device_get_bdaddr_type(struct btd_dev=
ice *dev)
>
>  bool btd_device_is_connected(struct btd_device *dev)
>  {
> -       if (dev->bredr_state.connected || dev->le_state.connected)
> +       if (btd_device_state_is_connected(dev))
>                 return true;
>
>         return find_service_with_state(dev->services,
>                                                 BTD_SERVICE_STATE_CONNECT=
ED);

I guess the problem is that some service is indicating it is still
connected though?

>  }
>
> +bool btd_device_state_is_connected(struct btd_device *dev)
> +{
> +       return dev->bredr_state.connected || dev->le_state.connected;
> +}
> +
>  static void clear_temporary_timer(struct btd_device *dev)
>  {
>         if (dev->temporary_timer) {
> diff --git a/src/device.h b/src/device.h
> index d4e70b7ef..e3191f2a4 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -104,6 +104,7 @@ void device_set_rssi(struct btd_device *device, int8_=
t rssi);
>  void device_set_tx_power(struct btd_device *device, int8_t tx_power);
>  void device_set_flags(struct btd_device *device, uint8_t flags);
>  bool btd_device_is_connected(struct btd_device *dev);
> +bool btd_device_state_is_connected(struct btd_device *dev);
>  uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
>  bool device_is_retrying(struct btd_device *device);
>  void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_t=
ype,
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
