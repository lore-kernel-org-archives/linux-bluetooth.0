Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F71B4F0A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979525; cv=none; b=fkSRfAmKFsLDvL9A32fPEZTiVWZcMGZefMy5oJeSB2+Z7y0zDlfVWyu4C2zEOkcFrC9BOtJhKnaPoHIHLE4L3dVlJlzx7+L+Vmc58dhdybVQbIiiIM3QCH+1/JcIiLgb5T/E3FF6BadrPMeLRQv+9X8kKRaGo4WX2a4Y8QDpMeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979525; c=relaxed/simple;
	bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcVrC6acWGI22ynLjtAjK7SxKCzPYnZPjNfcEdW5ezY6i3iGx2n5FiKmw5/syMpv35QVe981B0ItKfNTyHF/5Z0td33qjLL6A1hsFRzz29uAQwuY5qkuRXz3FSXfAB2yt6UB0Vp3PHwN8cNaqODv40ptgsgFwDlE8bn+BAWTt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhVzr2A9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhVzr2A9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so3497207a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 01:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979520; x=1729584320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
        b=LhVzr2A9It71YnFnO/lZTidFk5WmLGfHKa4KH/Ckgl3F++ctFCTb04TTOyBQooxVsL
         yEwCPtDz0BtWiOfKPce9a7rP38owkGvBKdmgu5uQ+/qDMGHHA9PIB1K1/X2a57xdv55B
         F3RiCmCfh6Sw79XVNWcr7hm1WE7KouHTQFEG3hWHBldemauacOtwefwkOc/lvK5C5JRz
         F/jmHWBVifdgVP1gqVSUBGDV55c6WkdvuMP6exX5fVNtUyjjL/pRz5xLpRKsQ5HO7BnI
         wvwy0CzhApmAGpc9Y4YRo/r+CvWp1FcdT2fMV2yFu04QyoD9tcfzK7FBB1WRZ3S7+6Zi
         DjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979520; x=1729584320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRRY21STBkjQewXTNmdPkxPhscZ4ArSYg0L46zZY/x4=;
        b=LjZPnWuMVZXR6U6okNzJ6UY/lmthrmzb9Pdz6XzoNmAlF41E2GNBhDj0MiwW1Bj92b
         O9Ry3R/CmaGlrtHEFfTKi/dhZDia6hvoZ2Ef9lTVZmXh519rvuNeKf2AbbgU2Tb46ru9
         H10kUdPiBqlPIjR4PABnBO3qlX4pWhrW87cWXJ0DkwUFNofkRMQJP8T9RBc9VsnW4e2w
         cz5dtVtiygqI8KLuTjCzkYcPAgZCX6oYCOj//KVp2y0y2MGbvrc+Cp+WB8b3cV4kcxLn
         mJ50tQlinFv5vk+6B1peYIeS0KOdhztlxvgVIytcxhShr79FVLVng2xMXhKkDhLS4w4e
         yhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Al1RlKqbKzS6XjUsJXQv8trHx8W7PVFFh7UP7J1iFn20dHVvPiMN5Buqgsm1+MGa+bKvbFxjZs3S5AOt1Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRsFosGL5XsFqerAxlKmsPkt0AWuXrjSByKmi6RJxPob8auYA
	bYP33EQaBDwmyILHCj0lxMhgHqXX+PxkpUdwsmCI7uI5U2NzYKzUY210JNkhT5Y7xesTssk7F/6
	ds+0ux2ksn1/Aqxb7lAVwsUIjnQrl+XLTQQx5
X-Google-Smtp-Source: AGHT+IGhXaZt34jHqjOXUdH0Zm4cm5o6e/qM4AoXLZ89WM8Mb4hUFPFZtihXBdV2SHb1Q6OTW0ryALy+WWGkbtzvcNY=
X-Received: by 2002:a05:6402:1e93:b0:5c9:845f:25fd with SMTP id
 4fb4d7f45d1cf-5c9845f2752mr3195903a12.23.1728979520189; Tue, 15 Oct 2024
 01:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014153808.51894-6-ignat@cloudflare.com> <20241014213503.99078-1-kuniyu@amazon.com>
In-Reply-To: <20241014213503.99078-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:05:09 +0200
Message-ID: <CANn89iJ49HQGuZikfz_56jUpdUDHfO_1QPGSrnN_OA6PxZdK4g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/9] net: ieee802154: do not leave a dangling
 sk pointer in ieee802154_create()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: ignat@cloudflare.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
	davem@davemloft.net, dsahern@kernel.org, johan.hedberg@gmail.com, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	miquel.raynal@bootlin.com, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, stefan@datenfreihafen.org, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:35=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Ignat Korchagin <ignat@cloudflare.com>
> Date: Mon, 14 Oct 2024 16:38:04 +0100
> > sock_init_data() attaches the allocated sk object to the provided sock
> > object. If ieee802154_create() fails later, the allocated sk object is
> > freed, but the dangling pointer remains in the provided sock object, wh=
ich
> > may allow use-after-free.
> >
> > Clear the sk pointer in the sock object on error.
> >
> > Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
