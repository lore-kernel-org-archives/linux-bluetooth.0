Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A018F2E1
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665255; cv=none; b=QpURmZZn3Cw3ni+R7W4E++jDot5xYaYjFsStO01WFAZZbW1AGnxajPcgnTAYG7USSbLjMmLPdQMm0QruCyXRTzkOtp7OeBr2y0FjUv3oUAbB93ClQMNp3zKQiQItWQQn9nnC8KBfuYVq/niA/MZufzBJnKRgFlt0xvjp+NiWAug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665255; c=relaxed/simple;
	bh=gTKVHkW1xZtVYY3eOX2P1pRamfg/sbP4BfSVBkumSOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXpC9nT2dIt6dwTg4hBl6nx//FB4jIMuAgxGKrk9PdlfMqWqaqeSjBPaPi3iz0CJy4V0pZY0SIMhU6vBjIKXNdWmbfivG0hiI7a8vAppQtYJQ5LhXbcmWsmR6PIw4w4/9pXqUyrl5rZoVMHbZDt7dKd9K4r/cZdWZ6EiwZxw0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=I49rtoJZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="I49rtoJZ"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6efae34c83so596605466b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1718665251; x=1719270051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgqsUK44ZQpqmoRMnmn8FFdT1lwDfmmk05VzO+/mADE=;
        b=I49rtoJZ833sx+f1S61bqgnMGtJnXvluKB26CH85LKQNfTQ+vOqlCZX5wE29kCV7Di
         vUDrbS/GeWdG5QwAF747ERrtu0J5Qqmk8+I7YElFqZI7+FRsC8DZjqO8pRfmiBRnIJWX
         GZXepyMkLHnOT8AGltZIe8ZN1YWlqR2UakKsDYP1g0TXEF2DjIy7bfedJ4K5r/ANw4jW
         SNr8u1sjIazMag3/akHPAtV99RdHChBjC9Qqagms9wShB4L2nlbT+MyNqhNtcGV61qrJ
         AmbVkURfXj/n05xBO5uS0rmyEolsBZwxF6HpTEfHeWwzpV0n5Bi6/wlf80vehI/uKY+b
         AN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665251; x=1719270051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgqsUK44ZQpqmoRMnmn8FFdT1lwDfmmk05VzO+/mADE=;
        b=UBL3YSxIOFwB2GpCUPSEUobzDQrGIcTZZLhMqtwevAta9f8kcVgZV0v50KgIqlxkaX
         ECHhkl8PZyD4fG0yuFLgXD16m2MKzLOV4L3mX5ywxs7do/CxXHbmhkCPcXu4kQya0F2a
         i4FBPIJndYlXjoLK9njrqqOFuS7c92x3Jc/ZoCwmZvkmNi4LKViRlafWCFDggeEpK88A
         3okj+E8oaGW1c4pFYxa03BbgX7DxVXujheyTt9R96ZUvsscJ0Os+40giOpdgco2DFstu
         YAs7uje1tHd+10CTLRcSDvlqPma7mNOWSOcl1q/emt5rmj0wLXLComapWGtlkX2AesjQ
         nI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/p8lhJXsMah1u0u7G5APlsi+Yglh5ePqRtOWHYmgsBHu0Lgb0Ao/vyqDVU3F2rM6F3U7yGqOkMKPJNeZ1lm/ZkaDEVGkYVnHpd5/nyMaX
X-Gm-Message-State: AOJu0Yw0rwqJTWm0OzM7ST2yI8W1j+rptkjhiBKQh0FFWDLzpxVQw7py
	6eOlXsBNXtnN/tZEbhxmsTyuKOwKWxS3DeEnSZXn9Reg4LDsmgBDMwCXQxrhpQu+olVtg1Bx4mA
	yv4G9q5tRH8NQ//ATVZxs5uxnB8LwlRpPUGK28w==
X-Google-Smtp-Source: AGHT+IHR0xGGPPqIxEcMBglBzedI2u10zJP6TfAwAastiEFg8OFQ/2Qr4OdE8MHvNaKjebLavkS/eRoOocFkLCKgFno=
X-Received: by 2002:a17:906:4816:b0:a6f:2001:aa53 with SMTP id
 a640c23a62f3a-a6f60d460admr669589566b.42.1718665250629; Mon, 17 Jun 2024
 16:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513162200.2658571-1-tharvey@gateworks.com>
In-Reply-To: <20240513162200.2658571-1-tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 17 Jun 2024 16:00:38 -0700
Message-ID: <CAJ+vNU0F4n4Hfu=ZL5Mu3Nsk3vh4Y3iuH5funvshrkhQZD+b0Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btsdio: Do not bind to non-removable CYW4373
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Scott Ehlert <ehlert@battelle.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 9:22=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> From: Scott Ehlert <ehlert@battelle.org>
>
> CYW4373 devices soldered onto the PCB (non-removable),
> use a UART connection for Bluetooth and the advertised btsdio
> support as an SDIO function should be ignored.
>
> Signed-off-by: Scott Ehlert <ehlert@battelle.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/bluetooth/btsdio.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
> index f19d31ee37ea..bc9631bddc40 100644
> --- a/drivers/bluetooth/btsdio.c
> +++ b/drivers/bluetooth/btsdio.c
> @@ -298,6 +298,7 @@ static int btsdio_probe(struct sdio_func *func,
>                 case SDIO_DEVICE_ID_BROADCOM_4345:
>                 case SDIO_DEVICE_ID_BROADCOM_43455:
>                 case SDIO_DEVICE_ID_BROADCOM_4356:
> +               case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
>                         return -ENODEV;
>                 }
>         }
> --
> 2.25.1
>

Greetings,

It seems that this patch got archived due to failure of an automated
test. The failure doesn't appear to me to have anything to do with the
code change or perhaps I'm just not understanding the error:
https://patchwork.kernel.org/project/bluetooth/patch/20240513162200.2658571=
-1-tharvey@gateworks.com/

Is there something I need to do here?

Best Regards,

Tim
