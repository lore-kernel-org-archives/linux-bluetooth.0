Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F729ACC8;
	Fri, 18 Jul 2025 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854761; cv=none; b=Nh3zOPtQmJ+ZPVKprFyFJzkE9//LfNobgaOrYhKHaTwPNxDYT54/aaw2YtNxhpiwQFUSnuhUpbsG1EOjPjf06WPzgXuRQOaMqLlPOSBzqiGYZzTVvqfzQN4wicHQApTTxQOedJNJIwGdom3WZh58hyhPvCi/iBPPyMYlzSIrbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854761; c=relaxed/simple;
	bh=vxm02IW1/ASeT4iqjTX4eDaRWpQq90ZfLrekUxRBiLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGdBYlB6tBT73LnBq4T8K6zY0nuHBvXR+tI9OxKoBu4eGva4r3ZZM1g0CQo7UyO6MjbaE/G1J4C9TTqpwUyDWY1yeYFAu+mU1Qq48pke25RUodRmgcRexdB1qvH9Yp1Jywpt66jJ7ocnBmePnc0Mnyzkr14FrTSr8NxBH88TonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7OBtMK2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7OBtMK2"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b435ef653so17577361fa.2;
        Fri, 18 Jul 2025 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752854754; x=1753459554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ5QYrkKInHvp97NzNL9SSqlxHA7zeGJnZfWs7bkBf0=;
        b=E7OBtMK2ytwRb2pQ2OIgoxhBT/4IbZ7AJL6cU+uOEQjmuUhwAzdd4K4mn6oDDpKGCh
         iH5CMA56Zd9+KQRicnfiwMdY+s63D/VUvX2bH0drsMx13qOiA10SP3TVsWOVyNRKaSLL
         QmdDitLw1mIXxzB7+bShkRowhRRa3qNXdzfB4RYB8aTVvSc/yqUOF724a33IoPGhn+eI
         bAwvrlH6RrZ8+aV7tgLChJEfxWAaCY1K6bsf7GGNJI1EO7i3x+cX1ZItIHjQO1cnYXzu
         Osjs8h5KL+LVEUZwpWjt1xD03LdbEZXLeUYEvXjpU9LBTRwfoFbBnotbo4KkshNi+Jvx
         r0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752854754; x=1753459554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ5QYrkKInHvp97NzNL9SSqlxHA7zeGJnZfWs7bkBf0=;
        b=C6+pCHCh6h9+lBm/DKJXBh4g2GyEYGvoya/Ov7OoP6Rb6Gsu6NcA7bk2SF8xFQnotA
         XQLB/YMZ6lnRxwHgREj9VYnnn3QpuFQRoYJZHI1bu0kag4Z6p0qClytDvxxDFfWhqIST
         COzVQIMuhpwk+rI0w8sTDLZYuy1r9yt6mWhtxZVVhCRTts5W4T8eIo8Bxmo+rq1oowXM
         iI+Y5jLVXnXY8b2PM647sw4TLTDC49G9lm/3gEM32d1l32Q5Csku34y3uYucH9SIsQWP
         9d6xeVGzftq4ugOdg2HipNWs6xMB7JjlKfOMMt6dQP0MZYU2nNzgYBui2Gjh1COIS5WM
         EMqw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ep5TO8YfqG8pmTjqrQOmRhgfbdplN5dIaCL5N1DhwPSFs+s8aMyOJdsvyRjvpm2fH6T0r/VtBYliM1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1JP+Iltufa4ZGuwANPsnnfpKnskp3AtLTlzE/jVNLFTcuNAi
	cnKqIsVYL4VxmVY8padwtr79dYVmz4KBliPCfGoutxjqp5sLEAPjY/0VOnnJU2dw2CIt3HRNHVq
	7+a5Mon8ZJD+FxtLsmFy3+jyfFnR0xTk=
X-Gm-Gg: ASbGncuz88ORyhMeiw/tNk05HRExxHExqruwG3EMcoVZkwIIMVV/JfkXo6KIwyCDPM5
	lyozOC2JtoOidRvAyxN3AeU+SJGMiKrfmTwj45ELZRxoh3BFwjWaI4yhU/C4uWIbbxAXE71Xlw5
	SJxef1pVYzc/JvyHeoZCKLexS97tLmhGkYt5YaFbQNZ4BRBBrg2nGdC9YcCFenByqxt3uv42llw
	4asaA==
X-Google-Smtp-Source: AGHT+IHFX/iGitJSLJpKfzphir8WBXsEvpHgjepqiDLNytF+5Uc8m78PwyljNSeFTaOC1LDcJ5QvQjcTK5VMoAZgno0=
X-Received: by 2002:a05:651c:b21:b0:319:d856:c2f3 with SMTP id
 38308e7fff4ca-3309a4a9296mr21751821fa.10.1752854753834; Fri, 18 Jul 2025
 09:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHfd_H6c9MheDoQP@chrisdown.name> <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
 <aHoCQ_RfBl5Zm4oQ@chrisdown.name>
In-Reply-To: <aHoCQ_RfBl5Zm4oQ@chrisdown.name>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 18 Jul 2025 12:05:41 -0400
X-Gm-Features: Ac12FXzr7Eg2f3B19KfNkWyDPbZJF1EOXEReVru_gzfVS_fuQMotq15wl6tTitc
Message-ID: <CABBYNZJ60JUyz30u8QXvv6OO5dAu1A5-JDB_jJ=H_yR6+WYfng@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv reports
To: Chris Down <chris@chrisdown.name>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@fb.com, Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, Jul 18, 2025 at 4:13=E2=80=AFAM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Luiz,
>
> Thanks for the review!
>
> Luiz Augusto von Dentz writes:
> >Can you include a sample trace of the above?
>
> Is that with btmon or similar? Sorry, I'm not a regular contributor to th=
is
> subsystem :-)
>
> I mostly have a personal desire to get this merged because it's a particu=
larly
> noisy case where I happen to live :-) These are all with 0x40:
>
>    % dmesg | wc -l
>    3815
>    % dmesg | grep -c 'Unknown advertising'
>    3227

Try to capture one of them using btmon and then add to the patch descriptio=
n.

> >Also it would be great to  have a mgmt-tester for example that attempts =
to
> >generate an advertisement like that to exercise such change.
>
> Looks like that's in Bluez userspace code right, so what's the order of d=
oing
> these things?
>
> >> -       if (evt_type =3D=3D LE_EXT_ADV_NON_CONN_IND ||
> >> -           evt_type & LE_EXT_ADV_DIRECT_IND)
> >> +       if (pdu_type =3D=3D LE_EXT_ADV_NON_CONN_IND ||
> >
> >I'm not sure I would keep checking for  LE_EXT_ADV_NON_CONN_IND, maybe
> >just return LE_ADV_NONCONN_IND, LE_EXT_ADV_NON_CONN_IND is not
> >actually a bit it is the absence of any bits being set, so I guess the
> >only invalid adv are the ones for legacy which seem to require a bit
> >to be set.
>
> So are you thinking of doing this?
>
>    if (!(pdu_type & ~(LE_EXT_ADV_DIRECT_IND)))
>            return LE_ADV_NONCONN_IND;

We can probably return early on if (!evt_type) return
LE_ADV_NONCONN_IND since there is no point in evaluating it if it is
zero.

> Thanks for your help!
>
> Chris



--=20
Luiz Augusto von Dentz
