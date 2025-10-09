Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5723B607
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030078; cv=none; b=bDUDpUFeNjJIwpnkJXq7rQtE+/6Y0fsult5F7+7YY7gxt/7xjugPoO0M80KgZUe+epsiiQRZgNECzA52IYciNfO0anD8yMCPqImGY247Ub2FCxfDndDEygFa5HZcYukHDQi8jcVTb9uGG3+1DLiYMrz63Ghz1keiA1R4H5yTU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030078; c=relaxed/simple;
	bh=0zKM0e9qYySfTrXtzCDz9SownDZKCby8rjpw1jZ0wrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzEpdFou7wGBpgAaBcXjP4znYsXi/pgirPmBTqR1KQoAg0tFU9SISWRpldtwTKnkok5i86cF7XtkX0xb//O52Z44WMzgxQrEENFur12hzCa3UEL27IKDG34BGoRG30cQx2j+1Rvm/+WiHG/Wofu013glkhCpWX/Ks6SMjv8KK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4Myphls; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4Myphls"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3696f1d5102so11465291fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760030075; x=1760634875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlAR+KbSW1gZp/5eKig0p2dpF+5Yx/IHk0IkMrWQi6k=;
        b=c4Myphlstp3+ZW9ClEEPHWXOPKw/1rZz2bW4x0ObsovTOVMqwkKwsJCcLZWXxO0z6F
         ZG9uxH2T2Ih0K4el9QMWJbrZ1fHOnFgmu6dtVxgRqBNTIcF5B9aRbsYvM/1vX7Klrv2A
         HYDN39oM+IXpxwORI3izb1GvMPKO3Tba13hefXpUVjXzBhHM5gTpQSEUpfoI+hwfo5Cx
         qonmPF2RGUWwsIt24zHheY+EB/xqg0v8BXhrzqAsqo0HBvjt7d4I/djmHCaXq8RdKMn6
         Bo95BfCV+sigU+2vQy58fqivIKKGNJRyO6XA1ZGsJTZK8dPt3Ti6uyqROdhO28M9iYpF
         uMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030075; x=1760634875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlAR+KbSW1gZp/5eKig0p2dpF+5Yx/IHk0IkMrWQi6k=;
        b=iEzdilRhdWHV8zwrRO67DaS9kuaGAk42BnMorBYYfwQ5gUN5fGq4f05OxSwuPLNbzv
         VLEgJrbSUWcJ5vJTegZPjmxgCwfT/xm7rT/KWSfhyC4P8OQFEFYhLP112PCF7U5DhuP8
         AjdnJgymwXkj3f9B4kI0nCVoR8Gb2euStjs5ufKS+ciGVqPTlkUSie+Q+OFBrRWz06lV
         iW8YtNvtS8bkOprQ1kkK5zOyGG8DX05Lb0oS12TCO2E1L+e3qbNduLFc451QgZ+a0IVW
         mtEU+4KbHWz0dJvOUVD92sIQJwu/W4UKkdBVty8vMda+BKWvMnLlCyx575p/7xlMalIy
         qKGw==
X-Forwarded-Encrypted: i=1; AJvYcCVb6omHB4ur7ma9+Ei44miYpw2GJnYyXONv/f/FPpbpas23zARRFOSPv162MhFlmOvfgTe6MRU3p7lFZZ3hC4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsyEJDEzb4X6Z8FmvV1ADeK48sVxOzfW29WjbSHdXIY8fdnM8
	y0EYKUIDLSHbsabqHzpb+1Ng+f+/0fdZ5qt5V1zbQGvYWLS3Ok7MEkPCEMxOhYY1s8uzB2qm5Mz
	XJoVgKnelQv6HonEjiL1Xw9MF6tz51Xk=
X-Gm-Gg: ASbGncu5wcw0YuCyXOJANqd4ICRaG8fM9ZOxmoqBEW4nawcQY6vbRe99IFLtIpM5GPG
	wbGFnFhym6dEFhjN5SY+hJodT0vQuYgDb4IfsR29kjEPhvNKZ+JrimEd3Cendxx96ygwTwLV+En
	1C7O7ZmcPxnAF12FE3Vu3/R6QZ3X0w3aytHKRwRiOU+h99ACi99595EYMXZqxWYy6jmnvapmQst
	oSUNKsA9rgZjaurgEh57HHUgEzBbkFaI59SS5ux
X-Google-Smtp-Source: AGHT+IHnwfCA9lfjikRPwo6No8kmoalLOPLiFuzt6u82TYqFRhD9hGN9B18vXulFc+ISMpBlJz07vb1KGmj8nU7mltQ=
X-Received: by 2002:a05:651c:3608:b0:36c:7a76:d17a with SMTP id
 38308e7fff4ca-37609c9ef93mr25115931fa.9.1760030074994; Thu, 09 Oct 2025
 10:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <572c2a33-18dd-4bf0-8c41-e051d75f481b@molgen.mpg.de> <20251009164817.3762787-2-eeodqql09@gmail.com>
In-Reply-To: <20251009164817.3762787-2-eeodqql09@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Oct 2025 13:14:23 -0400
X-Gm-Features: AS18NWCMoU278nHtknLMHLGaJduuWlcP8XauUrHAdrQfETXUwzPW6eaASZ1p_bM
Message-ID: <CABBYNZLgOpam+34S-VA3pVYVfwYRxBSCLa8FU66rrB57ogUv=w@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: bfusb: Fix buffer over-read in rx
 processing loop
To: pip-izony <eeodqql09@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pip-Izony,

On Thu, Oct 9, 2025 at 12:51=E2=80=AFPM pip-izony <eeodqql09@gmail.com> wro=
te:
>
> From: Seungjin Bae <eeodqql09@gmail.com>
>
> The bfusb_rx_complete() function parses incoming URB data in a while loop=
.
> The logic does not sufficiently validate the remaining buffer size(count)
> across loop iterations, which can lead to a buffer over-read.
>
> For example, with 4-bytes remaining buffer, if the first iteration takes
> the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
> only 2-bytes remain, but the else branch is trying to access the third
> byte(buf[2]). This causes an out-of-bounds read and a potential kernel
> panic.
>
> This patch fixes the vulnerability by adding checks to ensure enough
> data remains in the buffer before it is accessed.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>

This is sort of useless if you ask me, this driver is never used in
practice, and even in case someone still have the only model it
handles  USB_DEVICE(0x057c, 0x2200) I bet it would have been easier to
just add it to btusb since it appears to be using the standard class
as well.

> ---
>   v1 -> v2: Fixing the error function name
>   v2 -> v3: Addressing feedback from Paul Menzel
>   v3 -> v4: Improving the error message for the block header count
>
>  drivers/bluetooth/bfusb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index 8df310983bf6..02ba16775004 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -360,6 +360,11 @@ static void bfusb_rx_complete(struct urb *urb)
>                         count -=3D 2;
>                         buf   +=3D 2;
>                 } else {
> +                       if (count < 3) {
> +                               bt_dev_err(data->hdev, "block header coun=
t %d < 3 (too short)",
> +                                          count);
> +                               break;
> +                       }
>                         len =3D (buf[2] =3D=3D 0) ? 256 : buf[2];
>                         count -=3D 3;
>                         buf   +=3D 3;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
