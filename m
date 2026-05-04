Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F13E1CE5
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913861; cv=pass; b=h3PvCXKGcgMhgxWNzJRJsaOMYHsFvlSHusYwbkU2OqK6KQIwWYPaQS7C7FOQY88Lgey8BM1p/coQjvE53aSP5X5yNEY/o1hutyyRfyvOchGsuiGvACzyTZj3g0RENluz6P1NXm/OaBQsDv++EO5VXMHHLyPo8Ce58MHPz23eE2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913861; c=relaxed/simple;
	bh=EFyVIOAqlvCcKz3Dyfq4jtAV7jNEmTD0W9RwtzFGa4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpS3xgNi0dJ3bpmNw+exK1bU4ODKi7RWCZTSHt6aoGYHu0YdTXnOP9P0X25xNcslyTQCs77TgN+ekF+wHB4eoMkqW8Mi2NcWFT38kmHCQHDVbmzmwZZH+UikOgOlMzBSiAwBjPdFuSBU4YtcqXJep07clzQLvOd5yLezKaWOiXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8aGEH/O; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8aGEH/O"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65318dafbcbso3649376d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 09:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777913859; cv=none;
        d=google.com; s=arc-20240605;
        b=dRGJG70UYvwBKUPtJupiZfk+XfCilxJqMeC2OJHjpDA9SaYEQ/QwgbRfvdy7Ar/xS6
         n3GYIAF3fraTNbEzSuvHRHhGU6gKlCC4XjRdjWMpdCuM6g+9nzoP0lUIoH2f+UP0OLRG
         u70EAdLrywCw8adFFSzgoz/5eszmJUTqOeOSwGmLCv2SeY8vBRMSLbnM4yNFaGQpXpDr
         5BRS2+fZRZfOGHCkbTHQUe33dfZIP+VyzVI4uPM04lx7JfwBL+/ZV6pHIVx4rPelOT2Y
         MS/n91sgwS3Lm1RZjvJioDra8NAjrEpOyXUV0eKnkDLWLjaZ0i66nkOpCwNR2qbR/HWk
         SN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/7f29viqGQdoNuF7A9O/7sq3glL/7zmOBWt0qS3qq+E=;
        fh=zzyOo1xL93/uHYZ/9wl7G5znNDozSf2XDLG2Uw+aLU8=;
        b=eeO8XdRc4b3j0RhS4ibVneH91PTV9XYMajBNeFoqZZGbTX47+ZvF4TBUx88iNcHvH+
         3gHpkkQtS7liOkZWS+USuEUs7vzM9gDfbc4trAZgk0JWo/TkmP7gRDNJiFSKqxkXM3Gn
         bYwdC4R28Rc2+HV4ri45hhe+7XrTx6gwGkLmQb2tLQIgLD2UtLyoZzcgh5s63JL3CsRC
         PmoycaPnojRWE74RL+UZQYxcujBJIKxaOgWQyFf2dy0PFNOAvdPaZYtIAJQea2a3WRLp
         18Ji8pr3+cglO5NckuBJlAWS4vkPltFMf3RYBcNCBVlmhbZK28hCBZwPd7M5yVdjfGFG
         /sKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777913859; x=1778518659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7f29viqGQdoNuF7A9O/7sq3glL/7zmOBWt0qS3qq+E=;
        b=E8aGEH/Ohhdhs8S/C7J28igXal3v5SHlWtRD9m5VDef8CjxjUzdBnG6x0+jX7i8TlR
         RbWeLrHjru5RECMDJqRhrYCvSi6kW94mFaOjRNJgGtFOipE92uuiibWY0KktCMXmugWr
         j76QblqKsQISL3+/ZYCFb5dXuHdc5+/pSgjO3Z/3HqPGtw9tatxmAZWBf78nXuaHkw6y
         1XOuPaI0k68MBWmlUwdkTIoz/3hPXFSFeZ19KnlTaz/0TYvVMt4t4rNBI49CytDhFccX
         o/95IiFVmp0uf9+Gs4IePQvlQI8Qw/VX5lYXuGL21sEAHPAya/MU1pZQ/P6j+joS+hSZ
         hAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777913859; x=1778518659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7f29viqGQdoNuF7A9O/7sq3glL/7zmOBWt0qS3qq+E=;
        b=o3gRLKxCN62G9URscSPrCAGx3gh45SsJB4hbz4YYqnNrkZ1/h23HG6xedW5SNR9wJA
         QJ/DObXhwkp36kQsQ4YXwwq1LoLhh3Or3G3w3b8qgPqTAwT7qBDdxWoyAC0EWo4B3mZ9
         1BTxtjz2oeD37ZEo4RCbjwVTkl9QjbUKw/eErZxTzq4BBJxvqpvFJLB33kgfKTD34yX9
         3rGK/IrziqJtCQ5yFCQVqsHmqao+zwFS+ecKtkOdBINRu4zJ0/IGrCLDI1QlhgDujZQ4
         bvvFS/4ZJMGh0/a0ZfEDMuQSg5pFLaFs+2uEgKqwWiFNNpJ6EXedDP4x5giLW2vxhf8p
         FoBg==
X-Gm-Message-State: AOJu0Yx7YXbK35U9OSZUMBRO+eRvnSETNH9boCC/RTbbueR48/zzyef5
	SleUv7jBqBdEyRXJiKzJO/MUkuiP+r/YYhES/fFyQtep6bFqkXUSizW8lW0v9NsaCx2qhWoIouw
	2mXw2SxR6NULgk4N63h+n0nN/KS6F/bs=
X-Gm-Gg: AeBDietZnSTbVtYcEncwIdx0cQxtbSQY3AUZCsj44eQgkdicbJlyBJbrD5D0S9xElNJ
	HxSZJoC2D6oULIX0PbJEmDJipInwDfgLv2Sj5XxigSO9INg+1P/8j47v68gZEyl7gSm6lYt9Huf
	2SzXC5jsbaqyf0cPb90QTHM6SL1YCui1nSHsIrDrCPokjyxIWSmcZRC2cHPySpdNyc/k+f71562
	HbYdxPNZg8m9u5q3rUu9yYakqwHQ6mjKIJQEMoeb9P39EkdqU+jYZ/H9BRsyzJQxxZzlMGysuuc
	1El3OZTzRWBTcrMjdiy/UxdVRgZBZsffLKH1UJUdERwdeUsVaWdXOwiJrIc/idtxOHHdpZ7nwV4
	DNmHRi8LuE3OGTKw=
X-Received: by 2002:a05:690e:1285:b0:650:7b5b:ed00 with SMTP id
 956f58d0204a3-65c3da86294mr10570440d50.23.1777913859542; Mon, 04 May 2026
 09:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504164649.31170-1-admin@fluentlogic.org>
In-Reply-To: <20260504164649.31170-1-admin@fluentlogic.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 May 2026 12:57:28 -0400
X-Gm-Features: AVHnY4LMXjNA9pl36LOfjprzn55B-T2vVrjjPK-IiPEAQjYsyQ2uX7nxG9MvjVQ
Message-ID: <CABBYNZLQVVrxpcVqU4abyE5sodh6wq=a_z4NbPp+XN04RYz2nA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] sdp: fix overflow in sdp_extract_seqtype()
To: Martin Brodeur <admin@fluentlogic.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Mon, May 4, 2026 at 12:47=E2=80=AFPM Martin Brodeur <admin@fluentlogic.o=
rg> wrote:
>
> bt_get_be32() returns uint32_t. Assigning the result directly
> to the int *size parameter sign-extends values greater than
> INT_MAX to negative, bypassing sequence-length sanity checks
> in extract_seq() and sdp_extract_pdu() callers.
>
> Store the result in a uint32_t first and reject values that
> exceed INT_MAX before assigning to *size.
>
> Reported-by: Martin Brodeur <admin@fluentlogic.org>
> ---
>  lib/bluetooth/sdp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
> index 7210ce0..3295fc0 100644
> --- a/lib/bluetooth/sdp.c
> +++ b/lib/bluetooth/sdp.c
> @@ -1249,7 +1249,15 @@ int sdp_extract_seqtype(const uint8_t *buf, int bu=
fsize, uint8_t *dtdp, int *siz
>                         SDPERR("Unexpected end of packet");
>                         return 0;
>                 }
> -               *size =3D bt_get_be32(buf);
> +               {
> +                       uint32_t val32 =3D bt_get_be32(buf);
> +
> +                       if (val32 > INT_MAX) {
> +                               SDPERR("Sequence length overflow");
> +                               return 0;
> +                       }
> +                       *size =3D (int) val32;

How about we simply pass a uint32_t *size?

> +               }
>                 scanned +=3D sizeof(uint32_t);
>                 break;
>         default:
> --
> 2.39.5 (Apple Git-154)
>
>
>


--=20
Luiz Augusto von Dentz
