Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053D283FCF
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138942; cv=pass; b=MXroqoetvPNJjkw2Yxj/YKsyWCUY2S/ekaErhbFaCyN3Be5b1qSYVvJ3wOdygA3kJKHUL7WaZmbhia9/pxY1rWO+67I46IRuNswECP//0rzmwaqcYVEVvk+uy3MZ+zPIX9aT5CAePK4NmGjZmIBUA9x05O+LdKgJIgGxG/wZKxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138942; c=relaxed/simple;
	bh=deYJK0J2a5b5g9JrIzM0TcyKQdQJHp92QL3VYHfaZQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=B1FC4Dn6So8NwA+HGSzgcNGcpyWEINFPyD3JmgTpVLX+aQfMQeS1q+6lDoHOlJJyiPXfPQNfxDTENG/w+QdVhvZvM8Ql+VVVZhI04kOqIvw6CbrjH1ccmT5CRK1uoslSzqOy8J/h5TlhABmueTsgogfqtbttslItGe/T6ob6Bb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWILzcEV; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWILzcEV"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ca09f2056so945017d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772138940; cv=none;
        d=google.com; s=arc-20240605;
        b=BwaPI2O0nqzZBmylHJlb1cQmMBVKqo6zkl5szXOXSTp3L1QgmFo9G1i20jYVOSzJQp
         THO01ejQpmrGL2pAV86HTPHAo24hveeL1twWJfM1rW89YyO88CZetBRY7dffYChw2YOp
         yE/aRSrwggP+i6o/znYaAbL4tnbuE7xt9F92gCdG9e7RReNi+aQvFiuNUleeAaH98MJ6
         V2DSwJqZr3+BEId3YsEfMxuVxDpcjLwemwHrCPp8NH94y8kYN9wV/+UHqNAjigXlHAAG
         QweGG61aiNZLiB1bdmUonFu5chjSge2UfoQ2xSfOpFi/qqF66SwLzgSz4dVi+a35aIcj
         7A6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KIVstD2+pnNMtBA0HiAjlmf6N/4f32H2WjFIm26Q+3E=;
        fh=I08MVYRFsk3ianfGT74oyN+ut5eeUUw/nGErTUmy/QY=;
        b=SQWbXtfpDMs9KRUU8qOdyx9coUkH2xdRVjnJOtvW0voxTRFkIr/H6kCp4TAufzFhJ+
         8pZ4oQfY3ATklDQavNbw3xuE5OV6nY7SaeHDDDIY7CTdAjgnBxpSyslSIcGKXlpscLjv
         DIF8z4YZ5pQfxDL1S+Qu4Z/99qAYI5s7AK9tEWBfY77mjNfSkNAvzXuXkorx9S4PctRs
         8HCipPV0LfEVeMo/t+dMSV0NRX9ne28esHFfeb2CEDd+OEmaqdEKPgtQvOcZMlU1k5m1
         scJQJYe9U+VIQlz95uMQl/xTG683zgjXrZXfBV2odsUua7qCYJB+H932nsPpxudUBccs
         GDdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772138940; x=1772743740; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIVstD2+pnNMtBA0HiAjlmf6N/4f32H2WjFIm26Q+3E=;
        b=eWILzcEVLIdezVq479MqUmTsjz7zADEurNmpSTAmskNdE8Yp0EnlSB6ynW8NpPYpBN
         k7fVQfzROuuE9TqLv6sEQn5bKIqZhLTXO3E3T7aHtIcrEXxPsPHqZX2wKSzFj4TRxLAQ
         zbb+ibLVQhswM42RQD0l62AAZM0NufPB3zalGYDwkXCOGCfoJvet64yZKtDBBp9O5C3X
         J7AGSLoP+2Jk/3bB970K0jBdTi6XrW7B3vki62TVNyceH9RAOJJImV3WB5WqCz0P4Xc+
         ziCcy28NoUrIdNLs9Ewr17jIvej9zv7976lS7hn2xJ6nUc8a4NbXAbAVDs0fu1S4cXax
         awrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772138940; x=1772743740;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KIVstD2+pnNMtBA0HiAjlmf6N/4f32H2WjFIm26Q+3E=;
        b=nynigbA2tQx2Ewtyes6LAjpH3MUTR0BVB6gBIVMi9Oo2573xk4VKvQXAi6bxCx+WaC
         JcXW8lHh3yMFow0khH98ZjI8/5/UloGQj1XCe+K6xxe01d1GPgsLUHbWblLHxbww7K9+
         lEp8BW6zlVaPVQPMlsmx5yVG0coDIPbNWG/zv9kNXwe5mHz1Bq3LilRqDbINnUwkqR8G
         K1H9NIhFNtMBvi5k2lQiUPCSjXe3IHIK0r3SZDfll3uLBEz5fotQvDGXgG3CUG5QdoiM
         0No/kPs9VdrpGucFBjqeJYY/BSVKSceUtHOniNUg5ZKSJxfTjlFRR3HzaesNfT+fao33
         eEqw==
X-Gm-Message-State: AOJu0YxRPy6xdxpDyxvcWQr+vR1RReSsWctwB1nVIeHN8A3qjKV1HzvH
	c0/zX8mizekPt5Gs9JcKWrCwcEFzkHg/vMvjy5kcGIvaRJ39/wA6bJHEpbpW+RWJROec9ywBlfb
	r3P8egwAw66n59Q7Qxfh9AdYP6if0R6j1/GevzgJzPg==
X-Gm-Gg: ATEYQzxywo7LZ/BXUes6REPqj2/sxLUEoL7I2ngpzSIo4xFgj3IXvjZG1vdsmy4hoVd
	WK42K2qbnCwAuj8Cy/ME0gsyml3uorW6s9ZBNbI7ZBKSYHDcoHqF71TIv3h4PtvLv3QzkDrKi9Q
	TG8ttkDrAhnhJNtKfQguryKLFzJ16pva1mx6VHp7/DQZ9lWW1SIemQfL5quY9d0WO3NNZbGktpZ
	uI6dhSIT7M3o7MX4PIXu2a1fjnBt2xNLirxeumDcHeP9UEAijfLKAMVCfkZPLo5QVFH0UiTtP9f
	aYkWWfMZXr82MiZCkxq+S+ZWe/lU/B3qYMfpRNQ2iltmsrmK6sQrQACQ+i2y3izK+igYEg==
X-Received: by 2002:a53:ac9c:0:b0:649:b851:4eb with SMTP id
 956f58d0204a3-64cc22100bdmr639032d50.53.1772138940140; Thu, 26 Feb 2026
 12:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226204357.361000-1-luiz.dentz@gmail.com>
In-Reply-To: <20260226204357.361000-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Feb 2026 15:48:48 -0500
X-Gm-Features: AaiRm51mVdDiCHE5PkHlGLxgi5P68Dqr4rYcoQu1m9bPEZ5ZDGAQNiF5JMi19NQ
Message-ID: <CABBYNZJPBRVE3t0Q-fYdZtCTt3QTxKp8t8Sd-BLrHr5Vv7GSWw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: CoC: Disconnect if received packet
 size exceeds MPS
To: linux-bluetooth@vger.kernel.org, Christian Eggers <ceggers@arri.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, Feb 26, 2026 at 3:44=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Christian Eggers <ceggers@arri.de>
>
> Core 6.0, Vol 3, Part A, 3.4.3:
> "... If the payload size of any K-frame exceeds the receiver's MPS, the
> receiver shall disconnect the channel..."
>
> This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
> 0x0027 -V le_public -I 100').
>
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> Note: due to lack of L2CAP CoC segmentation support in bthost the followi=
ng
> test as expected to fail:
>
> L2CAP LE Client - Read 32k Success
> L2CAP LE Client - RX Timestamping 32k

I didn't have to introduce any new fields btw since the above tests
confirm the MPS is working. I reverted to just using chan->mps, remote
mps is tracked by remote_mps field and I check that the remote cannot
actually set our own MPS. I wonder if something else was at play or if
there is some specific requirement for L2CAP/LE/CFC/BV-27-C (e.g.
reconfigure?)

>
>  net/bluetooth/l2cap_core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f550ceceb618..14131e427efd 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -6669,6 +6669,13 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan =
*chan, struct sk_buff *skb)
>                 return -ENOBUFS;
>         }
>
> +       if (skb->len > chan->mps) {
> +               BT_ERR("Too big LE L2CAP MPS: len %u > %u", skb->len,
> +                      chan->mps);
> +               l2cap_send_disconn_req(chan, ECONNRESET);
> +               return -ENOBUFS;
> +       }
> +
>         chan->rx_credits--;
>         BT_DBG("chan %p: rx_credits %u -> %u",
>                chan, chan->rx_credits + 1, chan->rx_credits);
> --
> 2.52.0
>


--=20
Luiz Augusto von Dentz
