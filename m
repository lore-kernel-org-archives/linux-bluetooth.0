Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BCF8F77
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Aug 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970534; cv=none; b=YaorjjxQuf29194MqaJnCH+/xJGW3xr8YfOzQ+noFfkEnX0J1gPqHAW3mMuvOb69//9/MmiMXvYqi233NvTHvULjhmnOPe7EIERa2rVuc6/DMb2M2YPTNfhccv0pmibvN70FjbEgj67Dmd77T9OPrZdRlN9QvY0kvsreWF5LfIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970534; c=relaxed/simple;
	bh=at7qNFzpjdczdwNySPrN/5u9nDz18wpw51RO+Mbx31E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkPqdqzM+viUGyYMGgEdR6XgXUl7kZSjQ1KLgTSqywoileDGrEfPp4xOyg4+2fKD3eszaJn4ut8LY6PzUpp4/iDPDrvQWbI/NLb7uVd/tVZk/LgXCvzpFZTDR4wR1/sXZvZRVp2vUsis3i3qrhVNampaoLwTgEAutXpSml/4sUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpwVYIMM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpwVYIMM"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso11449641fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Aug 2024 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722970530; x=1723575330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XYnhyt7+FE63NEf9RGuCh7IGA14SGocKLz4aCC1ZkU=;
        b=IpwVYIMMXPQxa4jWqdcoCqE6xy5IKS9b9rucY0W6XkXkVR+F7caMdssN6IVhXFRQPY
         qOCb9dOJBtZSmWytmYLWCVSvHkHEfZnx4McOvk+WNZMTyiDEGK9RboYr8MQvhIWnjmrq
         CD3zGZQxiYp31K0FySVszPCKJnodYCkDz5HvX7DJR4Q+rpfpt/Pbm6odp25Mu4JQ8Y90
         HmE0AcXRdvMV4UnjmExohNlktBr24SEkXzdD9l0XD7YCV/j1jJeRsVdZU9dXHV5Z4OIS
         6kGeHx/Get/kYMJxP8ntg8+n/igUl1/NgO8Aa5DCZ1Dw9SRNyLxz4/pyGiNpL9Az+Os5
         Y3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722970530; x=1723575330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XYnhyt7+FE63NEf9RGuCh7IGA14SGocKLz4aCC1ZkU=;
        b=iNwzjmRofYcQF/HlscL60edLgp8Sd6BpN8Ek9TYccsEgtPfE3fV2mx5I5jx4yA5HkG
         vOsaWhpIM4jPMh32vAIbs0yuT6NP8kce2fwyLCEdlUJOqSDu574jr9RSlMrNEtU3mzu+
         o4IWv0Dl8I7GDhb0Lz+ehyKBueSfRLA8bZd1bHB6/6bmkCEhpuE/niWkUCgeFUeW5ZAy
         0qa1T+u3E9vfJgqtfnjvH/0YXxIWcv6OBBvmMhH6af9Fy50PTyN6shIiUu05IdMAX/1V
         lNVhSZfbSFFYOw4QYE0pVnmOMnOsmjY8h4V5oDXfWBZVfqdENHCN9WVyTHCv0Y5DnNZ2
         832A==
X-Gm-Message-State: AOJu0Yy4PYqhWm/WWpTa+OzN8JPOj1x91Zl4eaiV8qthfMVTrdyJMh3Q
	4lyfpcRivHUqwl6V4i/K4JEn5CSht7x8iULwyaTG3yDfcbUjdvJbMmzhq6t08Aq2mTSuW5PjGXF
	sSqQkFHlAmuWadkHku5Ejr/LDi2EtaR7r
X-Google-Smtp-Source: AGHT+IF0fqdqafzzexgRJKK3Sb4cuqswlJ6wlw82E/83VEPhX/Ix0iwJXoFQHKLJiquI0JNZ8U1BtQ/kjS/+84T051Q=
X-Received: by 2002:a2e:91cd:0:b0:2ef:22e6:234b with SMTP id
 38308e7fff4ca-2f15aab0a51mr112743021fa.26.1722970530147; Tue, 06 Aug 2024
 11:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805140840.1606239-1-hadess@hadess.net> <20240805140840.1606239-9-hadess@hadess.net>
In-Reply-To: <20240805140840.1606239-9-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Aug 2024 14:55:17 -0400
Message-ID: <CABBYNZJVacgEaOq+dBMBqzBwbqj_F0eKveUDUgvTEn_5qywRCA@mail.gmail.com>
Subject: Re: [BlueZ 8/8] monitor: Check for possible integer underflow
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Aug 5, 2024 at 10:09=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Error: INTEGER_OVERFLOW (CWE-190): [#def4] [important]
> bluez-5.77/monitor/control.c:1094:2: tainted_data_return: Called function=
 "recv(data->fd, data->buf + data->offset, 1490UL - data->offset, MSG_DONTW=
AIT)", and a possible return value may be less than zero.
> bluez-5.77/monitor/control.c:1094:2: assign: Assigning: "len" =3D "recv(d=
ata->fd, data->buf + data->offset, 1490UL - data->offset, MSG_DONTWAIT)".
> bluez-5.77/monitor/control.c:1099:2: overflow: The expression "data->offs=
et" is considered to have possibly overflowed.
> bluez-5.77/monitor/control.c:1115:3: overflow: The expression "data->offs=
et -=3D pktlen + 6" is deemed overflowed because at least one of its argume=
nts has overflowed.
> bluez-5.77/monitor/control.c:1118:4: overflow_sink: "data->offset", which=
 might have underflowed, is passed to "memmove(data->buf, data->buf + 6 + p=
ktlen, data->offset)". [Note: The source code implementation of the functio=
n has been overridden by a builtin model.]
> 1116|
> 1117|                   if (data->offset > 0)
> 1118|->                         memmove(data->buf, data->buf + MGMT_HDR_S=
IZE + pktlen,
> 1119|                                                                   d=
ata->offset);
> 1120|           }
> ---
>  monitor/control.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/control.c b/monitor/control.c
> index 009cf15209f0..62857b4b84de 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -18,6 +18,7 @@
>  #include <stdbool.h>
>  #include <stddef.h>
>  #include <errno.h>
> +#include <limits.h>
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -1091,9 +1092,14 @@ static void client_callback(int fd, uint32_t event=
s, void *user_data)
>                 return;
>         }
>
> +       if (sizeof(data->buf) <=3D data->offset)
> +               return;
> +
>         len =3D recv(data->fd, data->buf + data->offset,
>                         sizeof(data->buf) - data->offset, MSG_DONTWAIT);
> -       if (len < 0)
> +       if (len < 0 ||
> +           len > UINT16_MAX ||
> +           UINT16_MAX - data->offset > len)
>                 return;

Not really sure why we would be using UINT16_MAX here instead of
BTSNOOP_MAX_PACKET_SIZE or sizeof(data->buf), and perhaps we should
really check that len > sizeof(data->buf) - data->offset since that
implicitly guarantees data->offset + len <=3D sizeof(data->buf), anyway
this is again suggesting that a syscall can return a bigger value than
it was asked for.

>         data->offset +=3D len;
> --
> 2.45.2
>
>


--=20
Luiz Augusto von Dentz
