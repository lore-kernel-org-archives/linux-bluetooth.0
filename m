Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538611990C7
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664592; cv=none; b=tEMW8v8itlghlvkmTpu4xlg2Bj7IZuKsHutKaVX71LDdytK6+A7WfwZeXYlcC8+LGZ6iZem82knU7rRndeBvoSojCQMUJCO0VKr3uXiIenfDClmMfc4M6RinQZcK98eH1N8twQxaxx1LqUJ2H3+eCFe1GHkRjZaZv4p2APfDDlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664592; c=relaxed/simple;
	bh=z33LCeiSdIQK+c8Fm2Cmv+dpBOX5xt7lZL0xzJq+C/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4bc7qpKrO8yhuETWXA8WdPxHa9gZNekiKx/BmE/fcyVpnygS/EpxFkLpW8AYs7vQm8fUIWeW+ZrwxUPGU9Qm6ZrfdAH/uIEGClr9372ix1RA+aXKjQw3G4y/HAmsXAoA0VJAB3GE3WQlWglv+dboTYqvA2Rwi3s+o/0EolLYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJcuG6Nj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJcuG6Nj"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb3110b964so12511741fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728664589; x=1729269389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z33LCeiSdIQK+c8Fm2Cmv+dpBOX5xt7lZL0xzJq+C/w=;
        b=dJcuG6Nj4d2GQrYwVzqPoVsBEx4vIyzHOMAvMwSBY5hzxX2KAFLZ1tjNQCXsMfJjgg
         sHqu2MocSbEHpnavVQdFlaIN715xx0GJb1bfjdjo8QBB20rZJMMglWZ1zfEFsOao/vVd
         zUr20775lPHLDwyv3xfolBUxbDaWZW96ybgvtYKk6NSZfw6GoLJNP1Z+Iop36fOim72m
         W26lvg4WeeU0+4fvwE2/Zq5EpLNCGMLEIonsOPPiPIPGe4XifZ7p4ChxqO7DPPsFkbya
         ASde84YqdP/uWwxu/mQjyW3g5ys4zKNYiGQ7bLlrTCkydumrrfxl8r0v0+Ac+L35QAhG
         N1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728664589; x=1729269389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z33LCeiSdIQK+c8Fm2Cmv+dpBOX5xt7lZL0xzJq+C/w=;
        b=rQ5UvyflloZPPw+Jva19fBi+AiAH35L45iw0pXUVA+KHUYVeQ4GxOGSb/wKRLOUuU5
         3lBHN2xqd9pM/kABoRNN0PoNGde47wuCvRr7109wYl+UJPusvcX2UroFkbVbbO7pHkcA
         dUYE7uLAwI/nFvsPE78dJRDXwXu97paZ35WEX6ROYcJFIrQSW4tyEhJ4xMZTfMaqpo4m
         2OyZds0CT+1LRZxL+Kl+fG2jz+jc/rRzVEbEbYdchg8p8JimuCsK/VM04HkiU6vB9aKZ
         zat2nOQFWZCcfFbBmr05TjAAFrzAULltW0Vhc9WqH0nPpzlO3286PPpZIfkGBjUpXlK0
         HKIg==
X-Forwarded-Encrypted: i=1; AJvYcCXiJ6MiRfWflyxaFZZXQxYWFLTLarLY5CoNgETwUElIJ2fy3leX26QZ9akyY/Q9pp2pDQ/lCS/wsGNOrr3+XRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3beXbWGJsluUgJSrJ5qXnBf0JLc+BJaYSq16VP30I2UZyBaR
	J07gqKL+cJtK7Gcmf6cO8etzUiifDHx/rOU3RpmTl3twsGVkwaKcAiKl57e8ZtVJEBeGGnM5SAk
	qWD76fGCGmWEiFb2rBuQVcvqGoYM=
X-Google-Smtp-Source: AGHT+IHF9ZZT/8VHblc8TALJUZqEeU+cKgXy+4E55pB5xDa0pcYJDbcTUw6zcZ94069bvcFRJpOQqcpqRmHB9t7PTYU=
X-Received: by 2002:a05:651c:2220:b0:2f1:a30c:cd15 with SMTP id
 38308e7fff4ca-2fb3f2d16a8mr1016611fa.36.1728664589011; Fri, 11 Oct 2024
 09:36:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
In-Reply-To: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 11 Oct 2024 12:36:14 -0400
Message-ID: <CABBYNZJMWni33VQ2sX9EDcNbsFbX7pjAFj4QLri9N7jyLY0HvQ@mail.gmail.com>
Subject: Re: Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't
 fail external suspend requests")
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	BlueZ development <linux-bluetooth@vger.kernel.org>, Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

On Fri, Oct 11, 2024 at 6:49=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> Since linux-next from Oct 4th my bt speaker fails to connect if I switch =
it on.
> It just hangs trying. Manually connecting it via bluetoothctl works thoug=
h.
> With this patch reverted it auto-connects again.
> If you need additional details, please let me know.

I suspect something is trying to suspend the controller then, it
shouldn't be USB auto-suspend since that should behave as it
previously but if there is something externally (aka. userspace)
trying to suspend then it will force it to suspend.

--=20
Luiz Augusto von Dentz
