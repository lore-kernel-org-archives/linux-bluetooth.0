Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F9248F47
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885827; cv=none; b=WwNvAuQK9WxGnvmYEdAIYJjGSRZ+7+j/rVsXnCbf4pUqm8A3lqDlOs1whLkY/F9DjGkwRKI/ahSjckI8uQdrGycx3TSPnmhLBVvPtDbcCbUpGXY69qN1rMGqsrkvfrj2c92dRP9HsNuZzdY4mtz+36kUE74TZg/yafiCNCSeUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885827; c=relaxed/simple;
	bh=/VkObNxcQ3jGk7C5TDyEVDnc8ZvIAl9lHPEGVQwsewo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StaotqIad3ZOa6u9Yn5FRiD67daiMRQ8a97j1+p/MckP/miSSIxj3J99w1ML7TQcQrRot3L+8r2NwMVo8FJFR/jM9SwwgWiKkPQFvJXg6F/p/2lyiQOkJd+xE+BA9p8nuVroEUW4FoFlQRWL8JBC74A2Mqh2jWjPaZEmd/FU79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBXVOCkN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBXVOCkN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79088484065so35071727b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 07:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767885825; x=1768490625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPqRM1/NaFCpQxMWAsclJFsZZ8eS60tSxFGDEGVG6So=;
        b=YBXVOCkNjJL6ewST7zJjORt73YiVX93AlPhq6sLhSffpulRoXZfGaZvbN2nnk67XC8
         DQC/wz323zff37QkLtDgQcporOekbUU72cf2Isr0jcDQHrtaaeSV69zEICgTHmWGLHgN
         rUYdbts3jpug5GGHnKxxzDPZuZ1fwr9iz8Eg7UhOLhPG9EgnEE8a6Rv35umuP0QnYzvG
         sZF5JkeZEIdswfes5i83tp7KL1cleQqZckjv/bbtsIvyKEHb2IuRUKdWtgdDc+BIfRQK
         L1zNpyZ9QVr3qDN4KgIL3WthO8sCTFLNz4VFvqcj+Ay8JljBhrj3PyO1dw87LpzUNSzG
         HEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885825; x=1768490625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPqRM1/NaFCpQxMWAsclJFsZZ8eS60tSxFGDEGVG6So=;
        b=HKVeSSLJn4yRbHrdP+AB2IT25kO9kiBxmGVnJgZKg89R/yf3M+lC8DqY/Z8wFnlQPb
         oH1dsv5MZFIYMuQZZJQ2mL3Lbk2N2aX4ydqO7VSwqxAEELl72V3f3YzJSbnwUSBzNlok
         pI/ntFKoER3PCJwZ44BN0E9En8LEB06Y/9fg71wKJ30U8TNBhRXkKRDDp/1wmtauCKLN
         4NdVG2zWOayefCIkIfRU/8a+z2BaF2zydohdBiU0C2r4ZXdMKV+hTGPYjfIyN5Y3ddkL
         9fbrkN/5KEgT7Zmp438RAs49/7p4Ksc4rQQnlEwvI7sMHR/EeCuEs1yD5ZmKY4dU45Y+
         aDaQ==
X-Gm-Message-State: AOJu0YwLKGjVOpHaLJmxqm8AT4HBmFsIdfGg17iwiEL+Gd6NRgtNcOx9
	nljpUcHeXaKKaePOxwx4AlUSlTGVE3JY01GydFzcws5Cj2U7l4X1W4ZuJo4MpslCzRAIzlcOcYv
	TIVzN0yOFCaC3TMOahfF7cTdoF+QiyFLRaOaD
X-Gm-Gg: AY/fxX5bJbBSmSM/QjGR9sJYprORrdILeZTwracHLlpeAM/anShsdj8CspciTay6Gfi
	zM2EK7UGwDDWZLr5MuXPRMhZJdUxrZXDJvDuib32aGRE7UzOWRxpbXZJQW1b6P2D+13Xm/nUXNk
	0v/WlttDCRM+TXze1IxPKi9IbjWYhovmtbRMUH/pf+mrnr1BGieOGykfRSqyP24vJZRZsSxPmx+
	/rVJ65N6uUKNpNW2KDcjqKI5QUZVvZjxrbUhIYQJkhYtvHow1J9WlrVKahmpsRmQe6wgY0H8Bqy
	nBhovBKuu7yHB8ot4iaxLR0kB+3DAV0kznGdtnrIAqpC9QGEpCNM6Cd/sQ==
X-Google-Smtp-Source: AGHT+IGvWttxB+bmcpcyFH3jcvvZwO7Ado55/I+oCJrotpIPGwqp/KSRWqIsCC/CEpYF1gCmusJ9KckRCip/0cTpweY=
X-Received: by 2002:a05:690c:e0d:b0:78f:984b:4bef with SMTP id
 00721157ae682-790b5858f18mr132519787b3.68.1767885824857; Thu, 08 Jan 2026
 07:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108100136.486675-1-dalegaard@gmail.com>
In-Reply-To: <20260108100136.486675-1-dalegaard@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Jan 2026 10:23:33 -0500
X-Gm-Features: AQt7F2pKsHN4PDPAcN5mE18G4KXyVfnMtq4K5tBKdrKSddKiG-IdL3rZ4q-jpE8
Message-ID: <CABBYNZLfjWHAUorAmRvam+2NnGqRw0HF50XBoQNEXVEdzpQBjQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] gatt-client: fix use-after-free
To: Lasse Dalegaard <dalegaard@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On Thu, Jan 8, 2026 at 5:56=E2=80=AFAM Lasse Dalegaard <dalegaard@gmail.com=
> wrote:
>
> Clients with an acquired characteristic subscription would free the
> client during disconnect. When notify_io_destroy then tries to remove
> the client, it'll use-after-free.
>
> Add another reference when allocating the notify_io and unref it again
> in notify_io_destroy.

Please add a backtrace to the patch description.

> ---
>  src/gatt-client.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 44ec95db0..374e67c34 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1566,6 +1566,7 @@ static void notify_io_destroy(void *data)
>
>         if (queue_remove(client->chrc->notify_clients, client))
>                 notify_client_unref(client);
> +       notify_client_unref(client);
>  }
>
>  static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
> @@ -1607,7 +1608,7 @@ static DBusMessage *characteristic_acquire_notify(D=
BusConnection *conn,
>         queue_push_tail(chrc->notify_clients, client);
>
>         chrc->notify_io =3D new0(struct sock_io, 1);
> -       chrc->notify_io->data =3D client;
> +       chrc->notify_io->data =3D notify_client_ref(client);
>         chrc->notify_io->msg =3D dbus_message_ref(msg);
>         chrc->notify_io->destroy =3D notify_io_destroy;
>
> --
> 2.52.0
>
>


--=20
Luiz Augusto von Dentz
