Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D3140E34
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965104; cv=none; b=KQgCHFon01dhW7ieLXSxFWwjUjkJ9ndmJh6vH/WcsQ2nmjHfwNbD4utZA9wJOz5WFIqXsUGCYky/yXua1b/j7cj7+pDabrRXXgHf+kA64jotQKh0v+rsidolYsAwvBgsPDdC8BcvGz50gq9E8ZWi7qVchUZzBM658pj3w3S9Vy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965104; c=relaxed/simple;
	bh=0LwzbAkH5cO/0mQZjuNeh0TuA++xGZPXXu9rVncrRmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBmQ/uUrnsuMCCD06nzny20AkgPHhRUHsLjZfLIZ7IAOPss1U+FNcg5QVL31Qfu+XJQkD9WpRlItxdhFoG6pCFoOhKKad7hCZht7QMH5NOFUlErRZkPWimj9VQboK6AlmzLLrbUcQzMjDiuu0dKMCe0k8TWdjg7yBuggvZO6cLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGRHTJQ6; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGRHTJQ6"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-310447fe59aso58809971fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Jun 2025 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748965101; x=1749569901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w/M4MMqTkGnP+AIZmQ5iTc3WubUJ9lE/+eMQjKUeFc=;
        b=gGRHTJQ6KPrMxY1mEI8Xn8bumoDElaChr56qzUr1SLzEYk2DLYzBfA/fB7a8c2FlOI
         djVQ3WR0HK5hYdZdzERv2+yK0KCWN/mxuGoOmC+myC3nWhgf7tP5Fq+OuOPefO9hQGMe
         ftpSRQ4UrTbxvpiFce6713lD7kznM1h+No10jadNZBwfnrml0oilng0Aav0hMlo0cAz9
         9YJ5wifUDiJJVpQeFPcWxxXwAUhz2YfyauFUt3dUUJTcLCTZkRTn0Kcx8hST9/1T9mF3
         xGiFYfoWXwfdjzc+0T76ixivKyf8c6sT9d2p6jra37f2oITNyvXtJbpo/fi1FXg4DuYF
         jZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748965101; x=1749569901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w/M4MMqTkGnP+AIZmQ5iTc3WubUJ9lE/+eMQjKUeFc=;
        b=Geze7sUpMwRUBinmZACB2YCvs0xRTUQ5Bgi0+LCGgm8MZCI9n3Tu8rnzUBIGcV6vGN
         Nu7NS/uN0mJkdQoQbff0PJx2k2d4Qvvdi/nHtGA2/Wo2kFIqJxHJTqkOclyQm6SDxiU4
         jZya4bvtAheuooFNsSN15TbTHBgQ/267oWZPo8G4kv/T0yV7b//SXalyZ9JTrUn8Pv6s
         j/oTkgCtqygHQ3Qi/3Z3urGg8f/oMPdKokKRsd9GX/J5m+u95ppD74Sbx+MREEgGC7CV
         WRN0gwva4CUaa1idWSH7y2+TsbyWyrrnjrtPJtD86pzWQ0UyBymE9Z4M3NMuLep2976h
         uLdA==
X-Gm-Message-State: AOJu0YwWfFXaRuMVOM24dbPsng8aYy3hTQynzm6JsHSLk9wa6PO0rMmG
	qQjrjqxeWpxkVacAzKaYHAdZLZigDQ9PEwRZQGWC8PNlL5F6V9Wl6tOybHZf0rWp/qTurrH/Fub
	/9WjWl60GQMqfGhIvg3ueutQmSlT1HE8PzESkgAo=
X-Gm-Gg: ASbGnctigjykyRmKRvXser7EVzLR0b6T0LvPqqy5vRKSk2bxkDMS5dHKyDrb9VcEaAl
	QmmRxk17rEr4Uu/15Sp0loB5Qu++DyhdzhU8AdszhkiKGYjIEV8ApXMTM4CIAoKLG0xGPz2T1GG
	zn+aD4CWAPf3kc+HYUtHqb0q264rcK5H4=
X-Google-Smtp-Source: AGHT+IEQ5wMclTS9GU7xmGWtOMO16kVMcxJY4R/Fv7pJ3K7UDgJaXwpdIPX3d279ld/9laNmmMXnaCq5RGYNNSFOGwE=
X-Received: by 2002:a2e:b8c3:0:b0:30b:c91d:35cb with SMTP id
 38308e7fff4ca-32a9e99b9c5mr36339351fa.4.1748965100484; Tue, 03 Jun 2025
 08:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603095617.92785-1-sdoregor@sdore.me> <20250603095617.92785-3-sdoregor@sdore.me>
 <CABBYNZJYwKurqo+HDUKYtFx0+-rNquj=OHgpcZRZYVmAxDzqpA@mail.gmail.com> <c8b55be8b9abdb73bc57e8a2d455770199a2b21b.camel@sdore.me>
In-Reply-To: <c8b55be8b9abdb73bc57e8a2d455770199a2b21b.camel@sdore.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Jun 2025 11:38:07 -0400
X-Gm-Features: AX0GCFsYbtff6nLWn-PWXkRF_gcnj5lp_DNkwmP5I_KKri3ZvBCYQTRGXXHCIoY
Message-ID: <CABBYNZKL2gYmWPfP1owAUSAieWgt4ARaFp0-T5+vQ+rgjWnNHw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] plugins/sixaxis: Implement cable pairing for DualSense
To: sdoregor@sdore.me
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Egor,

On Tue, Jun 3, 2025 at 10:55=E2=80=AFAM Egor Vorontsov <sdoregor@sdore.me> =
wrote:
>
> On Tue, 2025-06-03 at 10:40 -0400, Luiz Augusto von Dentz wrote:
> > > +       /* TODO: we could put the key here but
> > > +          there is no way to force a re-loading
> > > +          of link keys to the kernel from here. */
> >
> > Not quite following, what key are you talking about? I thought the
> > link keys are still generated over Bluetooth, or are you talking about
> > passkeys here?
>
> Hi Luiz, thank you for the quick response!
>
> If you look a little bit upper, in the `ds4_set_central_bdaddr', you'll
> see the exact same comment. As I pointed out, I decided to just
> duplicate the code for now, as a proper general implementation might
> require some further refactoring of somewhat unrelated code.
>
> From my understanding of the original author's thoughts combined with
> the experimentation I've done, it is about the possibility to directly
> provide a generated link key, completely skipping the usual BT bonding
> process (that, I positively tested with my script by writing directly
> to BlueZ's device `/info' file), instead of writing all zeros and
> relying on (I assume?) Just Works repairing on the following connect.

Well except if there is some sort of OOB to generate the link key I
don't that is possible, note that we don't mark the device as paired
so the process of doing CablePairing is just creating a device, then
by the time it first connects it will then do the regular pairing.
Perhaps it is possible to write the link keys directly via cable but
then we need the OOB data, etc, to generate the keys which in my
opinion it just extra work that doesn't really add anything if just
works, or autopair, is used.

> My knowledge in terms of Kernel Bluetooth subsystem doesn't go so far
> to actually tackle the problem; it might require implementing a key
> reloading ABI in the kernel. On the other hand, there's `btmgmt keys'
> command which, I assume, does pretty much that, but I didn't have any
> success using it in my testing -- only a full restart of `bluetoothd'
> did the thing.
>
> I'm up to further investigation of this nitpick, as I'd love to see a
> seamless pairing process just like it was intended, but I'd need some
> assistance in locating the appropriate showstoppers mentioned in that
> comment. That said, I don't see this as a stopper for the patch itself.

Is it not seamless right now? Doesn't it use 'just works'/autopair?


--=20
Luiz Augusto von Dentz
