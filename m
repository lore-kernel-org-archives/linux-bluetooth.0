Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054026B760
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899273; cv=none; b=ko/WQ13TnCx0fSUkLYwlSSJEgXaxEn7ZhWohbIYC50WW/ZbSHq4GM1+9nRlmSsfPUAdXv8n3mESzgivL3c2x9/hqOf4UYpBUlgSukSBrialFxgpnCpmk/sFZUXJdzv6w9C2WJzCV5EIZmZg0dT1IYQhzxFfU34OjNdFF13C8YHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899273; c=relaxed/simple;
	bh=bKIKnnydUHGAh0UCzU6nMe7r8TyfZnMx9lDzmHXkhoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdAXspPRzDgntKRgXqiuE1nWnbT823ykXh3oksmPOkg2IK3ADQgcMy9ehc5OF2YNUwKVIe3R1OhLwKgOC8nZse9FDDkJ9o4kjdrrnp+rrWy69zHHjDU5L7C7qjufKWLC6hfDZcfjOgoy9a8zi/zXM/GPI9HWyCMlDTpW2RMDcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrUJMX4l; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrUJMX4l"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37a2dced861so1066201fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762899270; x=1763504070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibGzwwW91orPOZXp9hubnD+WlBoLJhFYpmOYeJP6Em4=;
        b=SrUJMX4l4922fTV0rRs2MlB+1RoAIJVlWAjKjhPKQ/1279O43mqu8o/j+N8qioExWR
         1gEh024kKE8UaHlZk9Pke3wYUSe7JkKVNwo90tKAfbnrXe47MGTO0ZWpUFnqZfRyDLYI
         ilDf0ww7XwrJGaSV6srN9QymTN0WIIEEstmAWSSPjRxUqRoxXGlknSTG2xKWyO+f8ZGT
         XhGa/sYOaCwaZ+BO6WOYTQ5Kc6xWRpOU1Twb3LVt96iyLfArk0i3yRDYcuQeNGs4CyDY
         1iSOKo8+Mp9r07DJc1XvGLON7Zp/jOajdvhj+vzYFAvYRK9BibCfHlXR7MotlmhgZQFN
         vnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762899270; x=1763504070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibGzwwW91orPOZXp9hubnD+WlBoLJhFYpmOYeJP6Em4=;
        b=EjfS5YgR95nW4V/MQQoq3IzLHq950yiWI2ALqxKYSa0YEIMQc4bXbp87ROhIA1uCvf
         7BzFOETYd257AwfQtMNdZNMHNTz/Ehn3T9hY3o/PkiqxsooC+igWDhQA/f9dKWeqsXeC
         sBWGy+M9SuvJk7KqJTkmDOBBHRKfEKhY5cMxX1T4MRExNEF3Uru0x7kWstvXZgKz4obW
         HjMrAVPJw0uB7MVCG7jaLLOZ60YuPHjvYpB9iJH83gW/9i0M+rcA3u4Qn9JmbsByBNHj
         ruVsmFt+ywuDDC2gR7XiOzJbSlHimoh1iteqSweyTPKyMxw9sw/EaBq4HHd5wEXCB9aI
         yu5w==
X-Gm-Message-State: AOJu0YxOXL8zhbd2WpU2TVaZULSiDvoRE8gnbA6JhBvQb9frKEfT6MF/
	htNMhJE15X4cNMGB79BmzXHcwc0QVrTqlS0PI/Ox5hRntvnhQLkjNs1C8hsLAPoqNeXYg4xuTWM
	0IKWYtEK3s5ID3exqi3kFzmJySQ3CkL+sdg==
X-Gm-Gg: ASbGnctHvf6ciQ4m1gnN4G2GW0o/bwncM69Owdllxc21hnNtHSWbrRyCjW7eEc9/ug0
	MtQEo4j73tw3/SUsDrnKwW13rBMtmy8ii3Ej5J+qjPla4crDkA8oyDYyukkFV43WWfKpYEudjGE
	Bq8Z3PI83vIpjjXLR83OonL+ptBWtGs+8N9uCqYcxBQOnxbXc4PjNRu7Ny+eibb6Fmg8eHraIix
	m70jsmukBonO0x8ZK2g6rcCkpKiePe0pPAk+WA508uf36ZeOZq/0nbCn/qJNaa4neKbfA==
X-Google-Smtp-Source: AGHT+IHv+hpfAzEM1jWSHHo+CQUh+88z6j/YNs7gTzTxEDWLByoXhFiVkfuWp3tByyhGXcvrEPXzWmWYi8BtlOCpglU=
X-Received: by 2002:a2e:b8c2:0:b0:377:d151:c090 with SMTP id
 38308e7fff4ca-37a952d693amr15423091fa.1.1762899269424; Tue, 11 Nov 2025
 14:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111212201.1130-1-andrew.smirnov@gmail.com>
In-Reply-To: <20251111212201.1130-1-andrew.smirnov@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Nov 2025 17:14:15 -0500
X-Gm-Features: AWmQ_bnAUND9UvoIhHDiaiPMskdPOBMM-J_2PD-rvQF9WMGRZ4gorAWJO5rXR_k
Message-ID: <CABBYNZK-+g8KsXB51rxH-Oaq7a4nBL1uN5NhKAn2tF9uoOLUsA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Limit the number of retries on auth failures
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On Tue, Nov 11, 2025 at 4:25=E2=80=AFPM Andrey Smirnov <andrew.smirnov@gmai=
l.com> wrote:
>
> Currently BlueZ has no retry limit on reconnection attempts in case of
> authentication failures. This leads to a very unpleasant user
> experince with, for example, XBox controller. The scenario is as
> follows:
>
> 1. Host A is running BlueZ and XBox controller is paired and connected
>    to it.
> 2. Host A shuts down (for example)
> 3. XBox controller is put into pairing mode and is paired to a Host B
> 4. Host B is powered down
> 5. Host A is powered on
> 6. XBox controller is powered on
> 7. Host A/BlueZ will start spamming XBox controller with connection
>    attempts in an endless loop
>
> What happens under the hood is:
>
> 1. BlueZ starts up, sees that there's LTK saved for XBox controller,
>    so it adds it to kernels autoconnect list
> 2. Once XBox controller is on and advertising, kernel connects to it
> 3. BlueZ tries to elevate the security level, but is rejected by the
>    controller with "Key or PIN missing" because the controller is already
>    paired to another host.
> 4. Controller disconnects, controller goes back to advertising, goto 2
>
> To avoid this, let's add a simple auth failure counter and disable
> autoconnect for the device once we go past the failure threshold.

Ok, but then it won't auto connect ever again, so we would have to
somehow inform application auto-connect is disabled, we can't really
remove the pairing either since this could be an impersonation attack.

> ---
>
> I don't really expect this to be the final form of this change, so
> this is more of an RFC to get some feedback from upstream.
>
> I'd also love to get some feedback on the following:
>
> 1. Ideally I'd also want to add an exponential backoff to the retries,
> but I'm not familiar enough with BlueZ code to know how to go about
> that. Anyone has any advise what would be the best way to implement
> it? Assuming there's no objection to that.
>
> 2. It seems like another imporvement on this front would be for BlueZ
> to get the "Key or PIN is missing" error code and react to that by
> removing the stored LTK info. Does that seem reasonable? If yes, it
> looks like the kernel actually doesn't pass that error code to the
> userspace. Is that right? Does anyone know why and what's the best way
> to go about fixing that?
>
> Thanks!
>
>
>  src/device.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index 91b6cc0c6..434bdf721 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -77,6 +77,7 @@
>  #endif
>
>  #define RSSI_THRESHOLD         8
> +#define AUTH_FAILURES_THRESHOLD        5
>
>  static DBusConnection *dbus_conn =3D NULL;
>  static unsigned service_state_cb_id;
> @@ -306,6 +307,8 @@ struct btd_device {
>         time_t          name_resolve_failed_time;
>
>         int8_t          volume;
> +
> +       uint32_t        auth_failures;
>  };
>
>  static const uint16_t uuid_list[] =3D {
> @@ -7113,9 +7116,15 @@ void device_bonding_complete(struct btd_device *de=
vice, uint8_t bdaddr_type,
>                         btd_device_set_temporary(device, true);
>
>                 device_bonding_failed(device, status);
> +
> +               if (device->auth_failures > AUTH_FAILURES_THRESHOLD)
> +                       device_set_auto_connect(device, FALSE);
> +
>                 return;
>         }
>
> +       device->auth_failures =3D 0;
> +
>         device_auth_req_free(device);
>
>         /* Enable the wake_allowed property if required */
> @@ -7320,6 +7329,8 @@ void device_bonding_failed(struct btd_device *devic=
e, uint8_t status)
>         struct bonding_req *bonding =3D device->bonding;
>         DBusMessage *reply;
>
> +       device->auth_failures++;
> +
>         DBG("status %u", status);
>
>         if (!bonding)
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
