Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA6537FE
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948511; cv=none; b=DPz4m2H9WjRGd5ygjIQ/9Ig0gzmCQ2RIcuWZ/9h0iaB1gwYRHIoL+2X2xu3d/qENsKcp4PSZEpPpslcFDrkDy4yLIkplvapAf7ibWDPhCOPzfhqotx42Dbfs8sAa1NgnBJDmjsnLUKZwbKwAJ+0pF7USU693LGVxfi0pChhqcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948511; c=relaxed/simple;
	bh=WjuUBWOR6rKrzhbQihEaNJxU6R+yAnLtJqihCXX11Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRXIvuIFu0RHIMcFrVLdH9ilcA40JsDN+Za/JSslKZKedsMCl4d25GAboalSUHPh2tomdS/NHA7NorWNdzW1fkiB+u3ReYBqD8Xj0vwVsOqUxS4TPnOSaLXOeRdEDoy/m4zRBqPmfoYu7I17vD5/vRYEFCnwniAs3Mr4vClSIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpI23AD4; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpI23AD4"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd0f4797aaso33662161fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 10:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705948508; x=1706553308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpIcFwHk8kM1CDGi1Wu6S1++eHqi3ashCsLMdIz8lzk=;
        b=GpI23AD4d2jWXonpod8aVByO/7cgfzvIEX9Oz+2TU1GjJhwpDTE8bBZPB9E4ziLQRy
         tNytjkh+YEAvTRJpUPw60N3GYdEpDJb0cQQu9S+d937HgJtqzSD+GXFutihwfgLPWaJ5
         DXzQHjscOUutYC/bqFPzZJAN1WRdsVX/TX8cYtlTv0aOEYsWvG4+KmQRG6CQRTIH/U8u
         ORN0xScTiN0ay9UHLTC886AE0XAQ7APZkPMunhlC1nRkasBEzm+UkIiJgKCM4aCH+9P2
         9YD8rDdP0Jm82NC80PzBME5mW6mZRoWcPvnrtBNDK5NxtPPn+80UxHrFYC0H7IXFY6kW
         i/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948508; x=1706553308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpIcFwHk8kM1CDGi1Wu6S1++eHqi3ashCsLMdIz8lzk=;
        b=xInBF0oXwXxj/V5Zz/d6t8CnaoVFu+eNOw7BMD87lZ1DCDwM2VlF3wQ6rVyYH5V613
         EwHp8kensuMxbgNB6ryuUhOcEoA9GYb4ZM3iNi5S7lxlrwlHZaGCSQIQHlkG3wu/o5KX
         nAH8D2I4vbciJ8fszdFDvGo+DynDOgRyZPDNSkEtLtZuG3dYMDWJWOg3KQA/ig+5RFXh
         TriSoe5qgu2v3530RhhrM9U3/KAkHua/PTHfqALPbhZJobdkzJEciOn8SP/OOyZnwk0F
         QARads16NFsXefT5DM9R5vXEdN1GGzLePomkEQw7gwsj6Nh5cr4FE0TxMfRTPvqfgJg3
         Jr4Q==
X-Gm-Message-State: AOJu0YysF05Nr+FmXuZZuBIFdrif+NMtoFWbw6BInt6KhLmO8hVL2cO9
	5wO5SXrIC8nDPuCJrSaTnZNYPTCwqSOSFOXCRMUtwdD/mOhgMhw+7Tqss3JHjL0V6T0mPoCgCur
	67A+bVshH/eYSz5fMtFvsmQEVYWk=
X-Google-Smtp-Source: AGHT+IGgBwhw6i7fgY4p3MLXV4EZVoy5hUQBCJrcO30rhCqbLliFTKxfWU1pl1dOp+nST/NY/NCmEZ+NeUoG3EIW6HQ=
X-Received: by 2002:a2e:a786:0:b0:2cc:a636:d5a0 with SMTP id
 c6-20020a2ea786000000b002cca636d5a0mr2112260ljf.100.1705948507708; Mon, 22
 Jan 2024 10:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
In-Reply-To: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2024 13:34:54 -0500
Message-ID: <CABBYNZKv+KFAAY-5-LwMdYKDHKtyh3BRbigUv06h_ZBLJPQobQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/8] Remove support for external plugins
To: emil.l.velikov@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Tue, Jan 16, 2024 at 9:19=E2=80=AFAM Emil Velikov via B4 Relay
<devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
>
> Greetings one and all,
>
> In this series, we prune support for external plugins and cleanup the
> associated code. The inspiration here is multiple-fold:
>  - the plugins are under linked - generally a bad idea
>  - the plugins use undefined, unscoped, unversioned internal API
>  - the main daemons expose their internal API increasing their size

Im not so sure I want to remove the external plugins support
completely, but I do understand that normally distros don't really
want to have it enabled in production due to the reasons mentioned
above, but I think we could find a middle ground here by disabling it
by default but still let systems to re-enable it if they have some
custom plugin that they may still want to use as external plugin.

> So this series:
>  - bluetoothd: removes the "dummy" external plugin
>  - bluetoothd: converts the sixaxis plugin to builtin
>  - bluetoothd, obexd: removes support for external plugins
>  - bluetoothd, obexd: cleans the exported symbols by the daemons
>  - android: (bonus) export only the required HMI plugin entrypoint
>
> Please note:
>  - expect minor conflicts wrt my earlier patches - happy to respin
>  - there _might_ be third-party external plugins, that my distro search
>    have missed
>
> This concludes the paper cut patches. Expect some more around config
> file handling in the upcoming days :-)
>
> Thanks
> Emil
>
> ---
> Emil Velikov (8):
>       obexd: remove support for external plugins
>       build: don't export internal obexd API
>       plugins: remove external-dummy
>       plugins: convert external sixaxis plugin to builtin
>       bluetoothd: remove support for external plugins
>       bluetoothd: remove debug support for external plugins
>       bluetoothd: don't export internal API
>       android: export only (android) entrypoint from the modules
>
>  Makefile.am              | 21 +-------------
>  Makefile.obexd           |  8 ++----
>  Makefile.plugins         |  8 ++----
>  android/Makefile.am      |  3 ++
>  android/hal-audio.c      |  1 +
>  android/hal-bluetooth.c  |  1 +
>  android/hal-sco.c        |  1 +
>  obexd/src/obexd.h        |  2 +-
>  obexd/src/plugin.c       | 73 ++++--------------------------------------=
-----
>  obexd/src/plugin.h       |  9 ------
>  plugins/external-dummy.c | 28 ------------------
>  src/bluetooth.ver        | 20 -------------
>  src/btd.h                |  2 +-
>  src/log.c                | 10 ++-----
>  src/log.h                |  3 +-
>  src/plugin.c             | 74 ++++--------------------------------------=
------
>  src/plugin.h             | 16 -----------
>  17 files changed, 30 insertions(+), 250 deletions(-)
> ---
> base-commit: 770ad5614e7e8074133e6f563495ce4822f63fe4
> change-id: 20240116-rm-ext-plugins-ba0b852a492b
>
> Best regards,
> --
> Emil Velikov <emil.l.velikov@gmail.com>
>
>


--=20
Luiz Augusto von Dentz
