Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515111E889
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583261; cv=none; b=k4ApQGnBubhuCaB9SDJKOcF5XYSRBkQexqwuI79SYSretO87JxT5l5D0znLeM0Vih35PbBXpUrfqji7TJrDBMVUBG+xle/Yw9nkht0r10YKibKEen5Tht+LKgepP5M5csKE5EvSUwSuoQYD3tw/NLIWAfqtgAYmIlDZ/WOGUSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583261; c=relaxed/simple;
	bh=HYVhYt9CYD6kEHG66C7T+RSvk4gN5sKU7Hae6U/CgzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/zzslycr/3wIzJcSDEy2Eacr6M4nL8KR1Xc/A3QVzQ82KgRxo10qMLc6gK6EcbmJD27u9S7tNk9X3NHKsmAZShOGcixOGUjSVY6v/vfKAK3WvUKUPy/Z9hB3hBfKzhdi0O0eXD42HJA81gSpGu8RZhVVCV7XOOfoA/sQbrw8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxWztP8X; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxWztP8X"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso7522451fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719583258; x=1720188058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiReLN0IDkDIPMMJcL2I03RV15tWZLpz7OA3fdYz2o4=;
        b=VxWztP8XzrsM7mLWd5Y2r8G/wCMsL6zgNCalD47Fz2DCn4tcb0Ig7SXM4o+L1D0RTa
         8ZvhMTF2vBuDPINxQe7Fck/yRwu9Mbj5RhyE+Zc4bBoivGbvgAboT0uOmtdjEHAgbBrn
         gCjLKhocJxcNFUGmRpFfU5uElLMH6doRwtdCQEhHM1cUaIyRPeE+H1gfmrBNoeWQUSXP
         wqMgrU++E/2wixqn1IMDK9EaDJ4r6Wd4aJL36rsG+ncCsExa+MZK1cLJmsdi0h0yIeDx
         RUxZtw9T/WRHXI0hcJSG6LwQgcSrI3Pd/vrguZIfdipAk9Pnife4BpOGwyrfQkdVW0NQ
         OELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719583258; x=1720188058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiReLN0IDkDIPMMJcL2I03RV15tWZLpz7OA3fdYz2o4=;
        b=dYpNlIgQiT/DVeW7TNvPaLTADyi8oZJwYRoXLSRNG8/citijhNbVzKxacRHUzSjiU7
         k0oWN5wjN4ZKp2HTuzzMc48wFLOjnnhFDddM3qxi/oNOOBsGIR6n7n/OFldPdFOJbb+O
         QSWbbGT5ZMURcVPg0YNIu6HFkk5GaTWodGcIhS6ZKkGtRg0Al2xoe+F1TX3X7NWk5w9V
         5iNwOLjfLJG7ykXi8Ot9S3X6tISEchZssL9yIaZab9xmGBvx2npN6TJD3/xwQvNZ3XH6
         Mh84kUaoz3BzL4938M7CuaQub9RzdBP1q/nihp1Cpi/7TsgE1bTr4o+HmYfQaGgfPQZz
         zCuQ==
X-Gm-Message-State: AOJu0YwFiwxJ+ZjENRVG29GBH1nfJOQom3a+GpHhoGRV7ubS4I6/G2wj
	zw59/13y3KdzbBZroVrWIU4FO7aYkOvH9WlDkNnF9gS9UmRAIq4+KfSa6lKx9fvs8WH/mNyVuiu
	yasqhFcqMaFgEgiaCEFCvz8aiX2fi6Q==
X-Google-Smtp-Source: AGHT+IHznJh8RgvLBGIXWFR4hHrLXx2WUztf33qMcUkpK7h6RF3jZ2TIn1/Qlii/neh78IP6SUfH7sJeszC/5TEmE1s=
X-Received: by 2002:a2e:9cd4:0:b0:2ec:520d:f1dd with SMTP id
 38308e7fff4ca-2ec593be843mr99192821fa.3.1719583258283; Fri, 28 Jun 2024
 07:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628101348.16820-1-zhaochengyi@uniontech.com>
In-Reply-To: <20240628101348.16820-1-zhaochengyi@uniontech.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Jun 2024 10:00:45 -0400
Message-ID: <CABBYNZKCymZyj2qXwrTYCPuWf4SAEKehcPsA6+CEL-TBxzLNBg@mail.gmail.com>
Subject: Re: [PATCH] adapter: Add retry when bonding device returns connection failure
To: Chengyi Zhao <zhaochengyi@uniontech.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengyi,

On Fri, Jun 28, 2024 at 6:15=E2=80=AFAM Chengyi Zhao <zhaochengyi@uniontech=
.com> wrote:
>
> When a user initiates pairing with a BLE Bluetooth mouse,
> MGMT_STATUS_CONNECT_FAILED(0x04) is returned with a low
> probability, resulting in pairing failure. To improve
> user experience, retry bonding is performed when
> MGMT_STATUS_CONNECT_FAILED is returned.
>
> log:
> bluetoothd[1539]: src/adapter.c:pair_device_complete() Connect Failed (0x=
04)
> bluetoothd[1539]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr DD=
:EC:0F:57:A9:2E type 2 status 0x4
> bluetoothd[1539]: src/device.c:device_bonding_complete() bonding 0x5591f8=
7230 status 0x04
> bluetoothd[1539]: src/device.c:btd_device_set_temporary() temporary 1
> bluetoothd[1539]: src/device.c:device_bonding_failed() status 4
>
> HCI package:
> Frame 2969: 7 bytes on wire (56 bits), 7 bytes captured (56 bits)
> Bluetooth
> Bluetooth HCI H4
> Bluetooth HCI Event - Disconnect Complete
>     Event Code: Disconnect Complete (0x05)
>     Parameter Total Length: 4
>     Status: Success (0x00)
>     Connection Handle: 0x0040
>     Reason: Connection Failed to be Established (0x3e)
> ---
>  src/adapter.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index bdc5bf920..ca5eb077c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8367,6 +8367,16 @@ static void bonding_attempt_complete(struct btd_ad=
apter *adapter,
>                 }
>         }
>
> +       if (status =3D=3D MGMT_STATUS_CONNECT_FAILED) {
> +               if (device !=3D NULL) {
> +
> +                       DBG("status is 0x%x, retry it.", status);
> +
> +                       if (device_bonding_attempt_retry(device) =3D=3D 0=
)
> +                               return;
> +               }
> +       }

There is already an if statement to handle retrying, not sure why you
didn't modify it?

>         /* Ignore disconnects during retry. */
>         if (status =3D=3D MGMT_STATUS_DISCONNECTED &&
>                                         device && device_is_retrying(devi=
ce))
> --
> 2.20.1
>
>


--=20
Luiz Augusto von Dentz
