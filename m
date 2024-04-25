Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA314D280
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061974; cv=none; b=rhoNVtxpksao+9qIMrVzkEF+2eNX2P4xVnt4P5o7ZxKUU1XUCD/j8iq3hFZaSNLIhYRqpQxdujWl2Q9BHgUS/xUVv0dWzwfssnHtHfTCKbjpvsa9n93DLBe9YivI8qgjfcwibAzaCTnreK9PRBS05niPpcTfhxVAK8KVhwishns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061974; c=relaxed/simple;
	bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMLi1L6kaKxFkjU3R3fcj+evR7fVVxfBJuoGIN6GCt6WGtpmlF8HloI/+GUNq4wsZt58LJb2IejlCbYzziL9MJuHk3ZfvdM7Z0MByOWyWSe7qwLjXE+ow3xhfjxGjaOAkYPsCRtonHtiZTiH3h3PIpqzD6XkVf8VuUwnvixidI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iR18/QXa; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iR18/QXa"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6a077a861e7so7918926d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714061971; x=1714666771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
        b=iR18/QXatk7X9rQRIAZIzNYR0/bbLm5lRfWjD7zv6VIb3zigTChIpTafga4cwPp9Eh
         cBAkMD4/z0s6kgU77wMSQ2HizFsURrNNHUE5PBsEMfhP36QY0/WjfVHElamfPGaInbjS
         eB7DNYVvQABmHU5cK7+kLyIHEBREzXXb4sbec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061971; x=1714666771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
        b=JdUMsgmOUfUdnHQEsdYWOdjwAObasrKYK73jKwD8ltlh/Ast3hc6XHXo5iTCeghdEh
         3L0HuhQwM+WqpC8IiuZ6ZHCmqPAmECHnmBZZ7NnAKf94DJ9H2TIV3BLgjJW9qeTg2DJM
         2E2gMrMTbAD5Lm5AW3ExzdVfXYbepv7yMPuOhaFSwn7FGQYAmzNhEcs1scQNxg7GDgue
         1DSQ8SZVW+Fhu4eLq7lCt04AkwFN+HJYRNN6VibipWLk/mp2ax0aSN9jSRH+KmHImX8l
         XtgZ1nQLh/jyJu5mMVU/FEcXu8XUeUlDhdHbFv6ejAdx4o0Kbb9pmcDqo8MfKeVkmw5U
         +a+w==
X-Forwarded-Encrypted: i=1; AJvYcCW6HTqjfWhH+VIz9Px5DSM6ED0OnTWa6pw/P4kphddHgVFcDP2UkwH8LPCjEGy2A8G3PIFFW9uvNaI+l9obEyyObgaleIUrP/gnmC2od1ys
X-Gm-Message-State: AOJu0Yyg8mWQSw9dov8hc4Esn7z8EMw2eR7Wmi3Kn9E/XN0dmg24bYXB
	YQm6F/xZcAeNriH0/KzwW7kvb2ujHQzoyoEvOdFOkZeCYMfRwCIyhduZoLdaBc1+ZQ38AJnigdw
	=
X-Google-Smtp-Source: AGHT+IGYL6iuOnXjApBgaAERBxOyFiQ/3d0+t1gyETEvb4p90OEpzfcfXL4V6zUnqQiACEx0mTBMQA==
X-Received: by 2002:a05:6214:daa:b0:6a0:6f1b:761 with SMTP id h10-20020a0562140daa00b006a06f1b0761mr267882qvh.7.1714061971159;
        Thu, 25 Apr 2024 09:19:31 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cca87000000b006969f5d3159sm7122367qvk.50.2024.04.25.09.19.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:19:29 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-436ed871225so342771cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 09:19:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWofwvrhNzwmMLQEQ54/quYNRQ4ifAQtJZdthM49xZJ4x8CWY9/Nwm5FYFFKChGF2KRywrovIctzYskfgWXk6JxmkxJ2EjD34PmKMmlkMfA
X-Received: by 2002:a05:622a:1825:b0:43a:5f02:bbe2 with SMTP id
 t37-20020a05622a182500b0043a5f02bbe2mr125019qtc.24.1714061968946; Thu, 25 Apr
 2024 09:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com> <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com> <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
 <ZiqBQ3r3gRk2HBir@hovoldconsulting.com>
In-Reply-To: <ZiqBQ3r3gRk2HBir@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 09:19:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXHWUfg-Gh0u3PG67O5fHLhWqhGPQFQjZMmEYt3Pw-Wg@mail.gmail.com>
Message-ID: <CAD=FV=UXHWUfg-Gh0u3PG67O5fHLhWqhGPQFQjZMmEYt3Pw-Wg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 9:13=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Apr 25, 2024 at 11:22:50PM +0800, Doug Anderson wrote:
>
> > Quick question. I haven't spent lots of time digging into the
> > Bluetooth subsystem, but it seems like if the device tree property is
> > there it should take precedence anyway, shouldn't it? In other words:
> > if we think there is built-in storage for the MAC address but we also
> > see a device tree property then we need to decide which of the two we
> > are going to use. Are there any instances where there's a bogus DT
> > property and we want the built-in storage to override it?
>
> I guess we could decide to implement something like that, but note that
> a devicetree may have an all-zero address defined by default which the
> boot firmware may or may not fill in.
>
> So we can't just use the presence of the address property as an
> indication that the device has an address, but we could of course parse
> it and see if it's non-zero first. (Actually, I think this bit about
> checking for a non-zero address is already implemented.)

This would make me feel safer. Given that you've now found that the
MAC address is in the firmware, I worry that someone will update the
firmware and change the default and we'll forget to update here.
_Hopefully_ someone would notice before pushing the firmware out to
the world, but it still seems like a more fragile solution than just
seeing that there's a perfectly valid BT address in the device tree
and using that.


> Note however that we still need to determine when the controller address
> is invalid for the common case where there is no devicetree property and
> user space needs to provide an address before the controller can be used.

Fair enough.

-Doug
