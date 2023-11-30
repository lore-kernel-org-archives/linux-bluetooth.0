Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XunByZbX"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C86E6
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 05:43:36 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9b7bd6fffso12741071fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Nov 2023 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701351815; x=1701956615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BhzNLxJ5m0mdq8se7Lw6aTAn+e9H1xTN6ktU4e5reg=;
        b=XunByZbXN4vx4OiQi+udiJN8wDAiXI0nni9Qa3LWntEUOA9dRKsQ1VebUMpKJeABqe
         rRaRabeOeR3iA6EoK5xGVW0eMbUbL608wXCxK0ofEJhEWHqWKnBzLTtRKgmKvMV8eWZh
         S0Vn/C7yPYf/G1dZhxLFM6UJlqDa+YpLENZZ2GFu0q7GiOPvu/7KRqPDPDkoI0LS4Bbw
         wDWzVXmbDPRBg7LxIuind/0HmUZ5MO2THzhOHPXrXw97Hw17apR9/1RkjLUsxitce4MO
         m/llBgLKGFtsdLw/8QXKb1krBkueXZa77JOc8qT6j4F/IjhycE51gWBt8j2D5onMF7kb
         m9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351815; x=1701956615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BhzNLxJ5m0mdq8se7Lw6aTAn+e9H1xTN6ktU4e5reg=;
        b=DXAvJOmoAZQnTh8EHb2Xy9SB415bXg7fTCnCABf+p5Hwu3S+ru6IsY2YsNfiMrgEZg
         YxE/0IQfacQsyrajjMssqRWLXHMkogbbfrjujqX2oSQbJCjbhLRWhYcYb/xtnRCcQNO3
         /H3aQFCt4Dz03LSRAaKTHFp83PzEsTVpQlzJuZ8IZBz3SbV5O7P2xU2siqzKrrJqfFiB
         cBwKZlaoq87NnYuA4EPy6IEztJYumRAy30Qzxw/RJDkq8EmgbmmPODeT0r7hvEOFXeFX
         SvWSssRxbN970QPrRZz20dHSfY9BR7JTN4I9qVNgJBcEJq4TDp39vlp4ubOrRJlp8DD1
         l4Hg==
X-Gm-Message-State: AOJu0YxuXJ9/rUdBkJ4d37D9KNNgiWAe55OMLWj+SdsWya48pKLBwyjY
	3/clkUjrErG53ggakoIxm0T8jVHQqu8TzM2+gMGBOLrVsio=
X-Google-Smtp-Source: AGHT+IGnq2ykytI0yIdOJLGA7OFtPDM8ydZRf7KymEyv8eIYKr15tAOS5zDPG6uPXBCXfgWE6y4VUecGTf/rf9JS6yM=
X-Received: by 2002:a2e:2e17:0:b0:2c9:af18:2e96 with SMTP id
 u23-20020a2e2e17000000b002c9af182e96mr6631865lju.12.1701351814862; Thu, 30
 Nov 2023 05:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200520212015.626026-1-luiz.dentz@gmail.com> <20200520212015.626026-2-luiz.dentz@gmail.com>
 <68150dc3fd176000e7dc893536182b3cd3cb8947.camel@hadess.net>
In-Reply-To: <68150dc3fd176000e7dc893536182b3cd3cb8947.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 30 Nov 2023 08:43:22 -0500
Message-ID: <CABBYNZ+TgaV5d+2N9XiqmPUvYO7zCFmNEsOh_8u4yhu9yCak+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: Fix bogus check for re-auth no
 supported with non-ssp
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Nov 30, 2023 at 7:02=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Wed, 2020-05-20 at 14:20 -0700, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This reverts 19f8def031bfa50c579149b200bfeeb919727b27
> > "Bluetooth: Fix auth_complete_evt for legacy units" which seems to be
> > working around a bug on a broken controller rather then any
> > limitation
> > imposed by the Bluetooth spec, in fact if there ws not possible to
> > re-auth the command shall fail not succeed.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Looks like this fell through the cracks, do you want me to rebase and
> re-send it?

Yeah, please resend so we get the CI to test it doesn't break anything.

--=20
Luiz Augusto von Dentz
