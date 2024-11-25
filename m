Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775342F2D
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562516; cv=none; b=uBIhdC8nBX4uraiKagUAo+8jmqNqHqlaOTkmp9iYDrbwxxI/jwGsPnseTQ6nARQYBosYUoFTQVelwyoNQwa0gxnkPRtH0lc8n/YDyu0vQqM2fJ71Gd2jE+dMXZc1m2GtiC6ckLTzklWMyQDsZQe1K3ibI/9r996jXMzKwQlP1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562516; c=relaxed/simple;
	bh=4UrHTDrRSccGYVinh6hjFgOQozgftfKuL6SjwClSmYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skH+X/59UIRAKO1OhDucXhBvGnfvH06dj0YK3wtCWpstXm20pMCUJAzTz32xjx2QZK0CGq9dhiCnZtF73hVNueYgxErD+vQAP9/lMYkfm2EqqtTWvOTdytlIg7X2aXIKqQJLee3XiAHchsiNgZKDYOFhLFbn3Y8CdaIlc6CyyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA+Vqxla; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA+Vqxla"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51533f41ce1so348788e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 11:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732562513; x=1733167313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UrHTDrRSccGYVinh6hjFgOQozgftfKuL6SjwClSmYk=;
        b=HA+VqxlaQayLZLw2MPzLDTs/N47a3FM9ZaJSyjORedVeieF+8FpVHucBj5Kn+HS6ih
         Nf1itoVqTma+hnUU8N2qernPw6PZ6y+OCC3lESGHh/iABiydZoia0Pr6rQKlSMFnB/W5
         NWqUlaqtSaywj2xTtlC/uIzvydDGAE9WPz+Zz9tc+3Izb/mZXeV5k/0i/ZyE8rD8Xpr5
         GXj0oAfR6bDfx4fQV0ValeFbPkpWmjeoXaU2ZvXrnhjjfUcLNbvjXWidFzyuZ+VGFrSX
         UkWTvbLfiAeE7ey3po6Dkx+NmvqTY1zUKRgHyhk/aPG0JgE0OW3Wl3b2XL36LjbBBQFh
         dlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732562513; x=1733167313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UrHTDrRSccGYVinh6hjFgOQozgftfKuL6SjwClSmYk=;
        b=Wduu1z9RUITQUlIEd7l4nt4D5ZgguPdRAfpJaRqThsF5Xeizv04h+ndivoO0ApdvmR
         U2Xtuk6t5K4X6kFJCfRrbEu8fgkwkbCKvo6cnGytIbOdCeMrr/HYvdk2JH6jORa3ugFN
         njW9svbS8QgSte0X2T1Sh6mKQXjz8TRxnxxTF0766dCKMbvM3OjJslEMSoKko8cSk4kF
         0eeKvw5S1lRkssATHFTFrLPkuvAhi9E0UFcQZTZqlwOrhMN5UeVVruaiJ7OTjzLcO0Mv
         2itSqG9k3TeYhnEHZ4st0uuGEF9YjhKxVe+HozvoAoPjzG0FwdbJ/rDE/kVlDmvWkdfS
         Scug==
X-Gm-Message-State: AOJu0Yyyz53cMVSd8lVtB9amL07c1kJDZN3IW3/CpbyX0uq1IKUZ+b+y
	LXHBcPc9K/BroadZLyiqwRazW/LetYRqLU6jz9wxBm6vhM6cqKDBfTo0a+xRfGxUE24CbFUZl0A
	I8IjfcYXC7BUXeB/wlMK7yDExlLc=
X-Gm-Gg: ASbGncunSs93ppwefWkNqa57UNqNkCalJ+xP40AwzUbVYlx9HP2bHhQDrSlRvjLVF6J
	/Omr5VyTa/rfSZwlUCTPbjX9yalUKXaM=
X-Google-Smtp-Source: AGHT+IECoXSNUWGtDj72qEgmu8emWQd4rlm8xIZK53fKGjN3Lu0gXeuf4DBOehacOq+DU6gq2pSZzFVqc1Lbeq1OpAw=
X-Received: by 2002:a05:6122:1b07:b0:50d:bfb2:4f2f with SMTP id
 71dfb90a1353d-515004cc7f7mr13098183e0c.2.1732562513301; Mon, 25 Nov 2024
 11:21:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124165539.2913146-1-yuxinwang9999@gmail.com>
 <20241124165539.2913146-3-yuxinwang9999@gmail.com> <CABBYNZLoyG+i4ztkbgZNwjp+ReRyakog8BdXT1HVxyvLuJaGAg@mail.gmail.com>
In-Reply-To: <CABBYNZLoyG+i4ztkbgZNwjp+ReRyakog8BdXT1HVxyvLuJaGAg@mail.gmail.com>
From: Yuxin Wang <yuxinwang9999@gmail.com>
Date: Tue, 26 Nov 2024 03:23:06 +0800
Message-ID: <CAPGQxBRsz552E2VNhuUvZydTUqk6ZRKjapJhdz1Rj8gTppQ1=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] advertising: Add scan response support in bluetoothctl
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:19=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

> We got a few options here:
>
> 1. As separate commands
> 2. As extra optional argument to existing commands
> 3. As mandatory argument that indicates its type to existing commands
>
> I think option 2 is the better one if we could skip entering ad with
> an empty array e.g:
>
> advertise.data type "" "srd..."
>
> Option 3 would break existing scripts since we need to change the
> argument positions, but we don't really care about it since now, so I
> don't think it would be a problem, but since we have option 2 I guess
> that is better in this sense.

Option 3 seems somewhat aggressive, in my opinion. From the outset,
`bluetoothctl` has not offered commands for scan responses, so I
assume these are not crucial for most developers. Therefore, making it
a mandatory argument to force all developers to be aware of scan
responses seems overly aggressive.

Option 2 appears more favorable, but I think that writing two
different datasets in one command is a bit complex. I would prefer to
set/get two datasets separately:

advertise.data type xx xx xx
advertise.data srd type yy yy yy
advertise.data
advertise.data srd

Option 1 remains my preferred choice because it seems simpler to me.
It also aligns well with the existing `clear` command:

advertise.sr-data type yy yy yy
advertise.clear sr-data

Is there any downside to introducing new commands?

The prefix 'sr-' may be hard to understand without reading the
documentation, but I haven't found a better abbreviation for 'scan
response'. Considering `bluetoothctl` is a command-line tool, I opted
for the shortest prefix.
