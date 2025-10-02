Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E4279354
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432680; cv=none; b=dDm4wefBhRwNYBe53gLlh5AQi6pee7PbnD1NRiWbd2OXAQyNCuA3vHM3z3JKKeuQ6oELSUjb/qunYq3azJgG9Y1mV7dtX4DY4MFrrwGAsdE/NExMQHddlKUnnxnQRWQa/8cpwK5JZHMXjkBpsTkSgt4RUzu4OP1Vlw2RljtZ3zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432680; c=relaxed/simple;
	bh=HD7F2OR8UwgY3zfHvXuxLFAhWFLNpYZsjIBAz0CZ8bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf20S9O6uWAgrZXzeJInhhPaud5f7lNHu5lJj+P5C/+Rs4gI9qGEylWFT7U2W3V212vk3QHaqGwQRS0ocLQw7BKp1nzaqMsBiY2Gzbia3zId0IMikJwOBpM9u2zQfaWxzU17pnmZQ6XVfTdC3m3Y5z8lEst/YinFGPWDhl98ics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO7j57o7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO7j57o7"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1842200e87.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759432677; x=1760037477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsacFhY688kmCw3ljgQ3LXTxUKBAt2jIe9uHSGes4ZU=;
        b=EO7j57o7Gws+ObC7jH87VyIIiZFVqer40BH+nCO2xcD4HXJIrBUR/6uTJhbw4uOdYp
         b0OUCY9DWIwL84pDF/9TrJ4aJcv3oEtBwE4Vl+gtdPHNsVV/CoOf6ZYVQbMWhk+mkwTm
         qLeDf9OLa6ljcODm7XlxoZwCZh1gJz+T1tGdpi7zWvKcloZVFE+IY5k0cZy7ZFn+uhqp
         oiWzFksbg7L5ecJT0MuEHm+ZSnpGkTAi5kSBA5gkKNqqtt31/Gb6eSAB4lbKCwHc8N8M
         0vG35nMlp4OzjN9WiDsaDK0LLmKiSl0Tzy2ZBGHYxwWj8gkoWfG9xoHfBEt3iJhOUFuC
         351g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759432677; x=1760037477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsacFhY688kmCw3ljgQ3LXTxUKBAt2jIe9uHSGes4ZU=;
        b=Y1nK/vJllz7hja0KMtO9jKVXDvfFjOeFX/cB1PPwYuSZnLrbrRl8L5zE8crIFs9lnB
         K9ngvRwY+8S9WNQ5mtXk2URMi7GyhNlTikMcShogGQ5vee+4bireRIl3XM8+qrfhYgjy
         XyfvJL3Cc/pKxAhAXhl2e0VnwaYD7TmTbGrfxt17T0aSGMF3sIK3KKxJrb+LdsSH9wwa
         L2zRFilE/QUchS3FNe+bdpYbSuq+jCb6lOIwb3bY70dtMgLFvVceczMJM3NLLgxcSTyh
         nd9dBjldHax/XvF3uWdBlyA/ICgiPcnkWRpGr5U0dPUTG+M1vzTVqYF0vXVBMOTlZpFA
         tt6A==
X-Forwarded-Encrypted: i=1; AJvYcCV4zhlkpEbxGYk9vfRrIJrQLFynPeNtmi1VOwNESA5ONhv+kcvR5GNUkur2/8iyazBiVEqPAbGUOq+o0nIMX3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNquDusONuP8gN++PQ/vDFVhUu+g3kE22SqwKrmhue1Nm1q9xk
	y2/mrs/xQ/sc881Kx9hPyvIomCii6kMA4EZPDnqqr4rAG4Mc3NKSWytrwaq2M4GjtrVvO1hR38v
	eIU1NNQ3dvcbqDZXp6pRQE1mPjd2D0YM=
X-Gm-Gg: ASbGncv5rvekp8y570GPEsJSlWiSjt+LTG27Bg/9nyams7abOuWNxdRymyWrDx3VFVq
	y7wbcJaujs2Yce7rmfImT0aCXdOhdpZUDjz8qpcdUHAdoVVYxePrRomw3zV1EsnzUplxSqMfXVS
	cBP27pQxj78hmkRZcCVImncjoJ7qkJQAcb9G9ZrmG5TRJE7T3Uyf0xDUrUdEVwFm/U/Rx26BL9I
	6KUt171Ci6dZzr6QHYLxVg+oYigbaid8JCkBlM8
X-Google-Smtp-Source: AGHT+IGanUA39EeWKN2bZPtr0nUYeSv1bV/nDDv933ayERP1FnFpJQ+koLjBOu9GVv+5Vty1qF8hdQd7PyFPxH3EVIc=
X-Received: by 2002:a05:6512:3d18:b0:57e:9c14:ac06 with SMTP id
 2adb3069b0e04-58b00be6121mr1327212e87.27.1759432676972; Thu, 02 Oct 2025
 12:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com> <175943240204.235529.17735630695826458855.robh@kernel.org>
In-Reply-To: <175943240204.235529.17735630695826458855.robh@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Oct 2025 15:17:44 -0400
X-Gm-Features: AS18NWA5rZuFqYFfCwp3TG9bhDZUCFaj7OWEGaE1URKJYiu9zd8yZE2o0Vq7Fmo
Message-ID: <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, andrew+netdev@lunn.ch, 
	conor+dt@kernel.org, kernel@collabora.com, krzk+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, kuba@kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 2, 2025 at 3:14=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Wed, 01 Oct 2025 15:33:20 -0300, Ariel D'Alessandro wrote:
> > Convert the existing text-based DT bindings for Marvell 8897/8997
> > (sd8897/sd8997) bluetooth devices controller to a DT schema.
> >
> > While here, bindings for "usb1286,204e" (USB interface) are dropped fro=
m
> > the DT   schema definition as these are currently documented in file [0=
].
> >
> > [0] Documentation/devicetree/bindings/net/btusb.txt
> >
> > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> > ---
> >  .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 ++++++++++++++++++
> >  .../devicetree/bindings/net/btusb.txt         |  2 +-
> >  .../bindings/net/marvell-bt-8xxx.txt          | 83 -------------------
> >  3 files changed, 80 insertions(+), 84 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mar=
vell,sd8897-bt.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/net/marvell-bt-8x=
xx.txt
> >
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> You'll probably have to resend this after rc1.

In that case I'd like to have a Fixes tag so I can remember to send it
as rc1 is tagged.

--=20
Luiz Augusto von Dentz
