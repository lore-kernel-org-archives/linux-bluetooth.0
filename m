Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4943C078
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978322; cv=pass; b=W4HFD7byd5fVH3dUG3uhZpvIeEOH86d/L0ok+/9xSOdpfTu3nu4UXkSHzqZd5wlIzegEvE/0ZpdH0w5T7AmvfrdUqnOxjjF82kh6CXVYc1q9QgAReLwMvoyIv5HZsYBr3ptqJ3IqZIdlMDTR22nKohCAC/v6SQBbATvg4CvhjQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978322; c=relaxed/simple;
	bh=XzUfQwvo93OQ5Al8tlsTNLhQ0klWen3NjlrngtwTN7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYoO2xvKaQG79JGFSPsYWqKY7oZtYfZC97tDC6f/yZW/RxWzPJl5afC9164aCrmOsFhQkof4AOc99B9kUmo+V7ojvpiGay7zfskN8Py4rxrPC1QPKOm6RJIWerCZ7ceQno89rEaZyR9EYBsxgKDBtR99OG2WngK0KCCB+q0lzZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1LBOcsQ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1LBOcsQ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64f48a5c3d8so9943636d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 10:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774978319; cv=none;
        d=google.com; s=arc-20240605;
        b=CzSRiAA9XOXtjuIBCdNpwffeN7FOqDeeEQmm+7rauvUv+RLaQZ5i7tGuOrsjtat7iO
         UR07q/VFnACbkESrYsf+h5bRXPnk7OfJBKvFptvHLTlYTJlyrG0w92TMCyR9nRyUzysg
         0SPKEbsIS9hPhS/k6PuI3gb5Lqv2LTSByWoIWMQy9iJBUWyrHQtO4DmbwHecWXZBDlsd
         vG3r7Qez8uV3RjP7a+t1d69mcdREw4N3OW8WmArfrAh+c5Li/xwbYci2z6I9RNAXe1eF
         AS+R1wYxl281rqqUmjv5qaBzBCMjIq/ld/RFdUQ+rIzxrp/fbie94i/J+s2K2jTHqQ2I
         Ve8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0yhE4GnVbJG4hKHIdWBFQgvJX3G1vXsn2yBdUvHrzU=;
        fh=5vrJeO033DdEQ/rUqO+JvXKATGQ3bhraqm4622VFeUM=;
        b=dklZYJylRwn6sX/pgGvzk9YYMVcJbbo+yQt62HzQ+ZJxnY7Np7tGwyBHJ4/AtK9pnp
         zq5TFiuAJ2d8N9ATANbTvZfCbcALOd/D4tG+MiImeE/SkFGtXSvXpF6CFPqD/RnYEIfx
         Nsh1aO32X5JAfS9Uft5lQfTkK/ilJEf8rPM7efemAipc8+6JNhAF/5DOG3IMleQ5iXSB
         WEM6HJo9Wg1puUDYmEzKFvCjnushyYKShL+ByqbzehwoMvA+hVmufMZDM0AvYmOBx872
         AlzPnprSNK9P+l5VgzBtT+LU8I7o6itXx69dalE3M5TgjLC8IAhLS1AFls2I5MhtWj4L
         dkhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774978319; x=1775583119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0yhE4GnVbJG4hKHIdWBFQgvJX3G1vXsn2yBdUvHrzU=;
        b=Y1LBOcsQMmcL3FjgSwBfgOkQEOJ12Dx46ZYGJrCUN3eIjhc0/yPx4BWicZyAtkvUUA
         o7Vm0DWuQfrBSGP25kcgaeZ6BL0LgyboDOBsn8SZK8SXOHePHuKqafpJzeOuEnmMu6ez
         jMvq9RwuNkN3sony2z2lSFskrtCXLnAQEeg00Gf9JLakn1Xtv3z3SuLHAwg7hfHXpVTS
         o6PWwv5YO7NaejHnOcJNPIHyQp/XN4EqzZ2LrkBQ7O52acKP6EKHWfGDTP5RbOvtU8Jx
         7cEtRgDUQgmIPpqrUuys3PrUv/P2Ly0ZPbWOG/Z1mwHIEDlTlB8IIX+kNuVcTuOgvsJR
         z1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978319; x=1775583119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0yhE4GnVbJG4hKHIdWBFQgvJX3G1vXsn2yBdUvHrzU=;
        b=BYOs3bTyCs8KP1gNWEwfI9VTa707pVPM72iOUa8ezB0Sp1qGXsHB43Qmk+UyH7HPRJ
         UMcMNre9LoX3+xsL+NsDDVCS/NZ2QUBvJ8AqpBYdD+P6Sk9WUB/RCmw3bhXC74UhVWxi
         M2PN40Uj0P+pexB2HVFjKpGoGtRXyUNiZ+m0WnudcwwD445aKgDKov+0/ahYk9TNdlZo
         oAbUNSOvOWWGrm5QjwNDazikHu9Jp86k1sJ3TfR91wnnvuRI3Q0ps2VfT4+8/HEiy4fP
         klSy05HR0QORO0Nl40w9W4weyL2KAfhaIHFXipeMq1aehWM9d/xoM2o/eOAX4SIysPBV
         tDrw==
X-Forwarded-Encrypted: i=1; AJvYcCVa8wOOFtRQ98wDbGRfXtPHQskbJDFQsHuPA6SeIJAYJ5WbpV3UtgGQn1T13DeAPqLmMCBep55+1qb+wxUYGp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNh5Ezo0R6H7JhipCtlDsH8svbRV/q/QyMmNqbbQCSPC4C5fDp
	guZDbwlbH/Qhi1+ZtsyUoY/+qulvDl6UnZVTRlkLcYLCJk0gU0bZQYm2z2KdeYI5hpJWucXPs+U
	7TjRY3xpyFrx2IS6PJ/nix1IHkwktkAw=
X-Gm-Gg: ATEYQzyTCO1spNgQmLxfZOco8eW2v+DolL9djAl1Yl2S6SGgzTfDH2H+w8qKGAURiVl
	4aj5Lx9HJ/cHB5yTUhFtzSaYjK7Q/JiU5dtQKzLfag74adShODlKbzOW7cfZmF/Vwc+UM4sa1Fj
	JkuySaPVccgzZ12OhiVsAV9YcXsJjMR+7vdCVJ0VMEZaCycAmQfyJIHCKAO6AdSuFmTW0QT9xlI
	jk06qrM6MTgebCwFujpUtmjH9ZNJ++7S9I6rHwy7up4CGYqbYEFC03OA9RSX7nga1AaS2qjBK6U
	c3myc3vZfFUkiZAV3JPmXtxNll4btZIQ8I7CmSJWXfsZZ/db+TPlGCnT/oP/1SGdbO5Rnw==
X-Received: by 2002:a53:d103:0:b0:649:97d9:cf1f with SMTP id
 956f58d0204a3-6502fe40abcmr71151d50.44.1774978316344; Tue, 31 Mar 2026
 10:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331171043.F1C481EA006B@mailuser.phl.internal>
In-Reply-To: <20260331171043.F1C481EA006B@mailuser.phl.internal>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 31 Mar 2026 13:31:45 -0400
X-Gm-Features: AQROBzDtH2rQqqFQDzX0DAENqJJXYBOysXiWpgWuMs-qnB_6ztR_ntWKoAltnrI
Message-ID: <CABBYNZ+mr1_rf0shA8xiWweq2tydLhFXBrhjpry-tnY2u4X8qw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
To: Javier Tia <floss@jetm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Ryan Gilbert <xelnaga@gmail.com>, 
	Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>, Llewellyn Curran <melinko2003@gmail.com>, 
	Chapuis Dario <chapuisdario4@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, 
	Nitin Gurram <nitin.reddy88@gmail.com>, Thibaut FRANCOIS <tibo@humeurlibre.fr>, 
	Ivan Lubnin <lubnin.ivan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Tue, Mar 31, 2026 at 1:10=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> Hi Luiz,
>
> On Tue, 31 Mar 2026 Luiz Augusto von Dentz wrote:
> > Ok, but on 8/8 it seem to suggest the problem still exists which
> > trigger the following review:
> >
> > https://sashiko.dev/#/patchset/20260330-mt7927-bt-support-v4-0-cecc025e=
7062%40jetm.me
> >
> > Perhaps we should ajust the commit description if the 19 seconds
> > doesn't really occurs when 2/8 is applied.
>
> Good catch. The ~19 second delay is indeed fixed by patch 2/8, so the
> note in 8/8 was misleading as written.
>
> I've updated the commit message in 8/8 to clarify:
>
>   Note: boards with this USB ID expose only one ISO alternate setting
>   (alt 0). Without the fix in patch 2/8 ("btmtk: fix ISO interface
>   setup for single alt setting"), this caused ~19 second initialization
>   delays. With the fix applied, initialization completes in ~2.6
>   seconds.
>
> This is addressed in v5:
> https://lore.kernel.org/linux-bluetooth/20260331-mt7927-bt-support-v5-0-6=
f31b4342daa@jetm.me/

I've already pushed v4 with the 19 seconds comments removed.

> Best,
> Javier



--=20
Luiz Augusto von Dentz
