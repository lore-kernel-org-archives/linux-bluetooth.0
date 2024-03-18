Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EE4F896
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775888; cv=none; b=TtQED3G2t6pg8tHfjDdopsfUhf3eJwlBy/EGQDUtTTNOWSmBfLdTaZDpwAMDjDSwvKCdT5EhTuBuf6t7XAyxVQIDMYRBfkm8vA1CgwEKiq7KU/UflMzXP6U2GDJ13HVKEitBYxvQGx12my5kXGchsfl1SUV+w0E7wpIjCI37ogA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775888; c=relaxed/simple;
	bh=m4+I6MBoUeUHGxnrD5vzjttWojTZkPCJQ14dx3myEDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFHrWrH+U1X6UjQzPd9zGoKyUlZMI9W3GiQTDoOq26Gb9fL9Yiq/RFEwNzIP0YoJ2lRS03E7avINkbIUhd4jXiKFAPnP0d53O3E17TKD8TJ2wycc13TIFabQ7jfMRC448qWKpp9I8dx54AKhTX6FGiqgkLhBevek7JvsgPh14uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oW+ds6Wx; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oW+ds6Wx"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-430e1e06e75so73521cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710775885; x=1711380685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA9/NiX8/E19WUiHKA9tr52IADuhSxANcPtKQ97R1nM=;
        b=oW+ds6WxOpW/jRhOjraBRnZ9oYYtUDIgqGcTiI85U7K+Cpj8UktYnD9iWkB0J6OnGZ
         c2TNHu9EpLVqHrKYgQayqEAY3RLhQc/B/mf6fNManTAVjNN/zEA02701EyoSgQukjHYM
         MK8S3x0j44jgkZun13lguylavxOPYCsWEuvLSIZWcu5xr6C4OSoEkTFuRA8xmBXR1y+V
         /uFIY9300VbpIrFPs3Cn9cgtXjwkjtF8K0urRG+6KKl03MF7V9SiUMRrgtTpp5pVEK2j
         2jdwfKzWkL27aaIzCGKLYVXkz9qR7WzfeJ3IUoTfFSAyt8Iq5U5oTaodMnrlwV0ffY1G
         3Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775885; x=1711380685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA9/NiX8/E19WUiHKA9tr52IADuhSxANcPtKQ97R1nM=;
        b=lUasz/eKCJoubVaXIbi5Q6PMPOfeIi9VxFHKSaBDu/VYjyrX9RGec9vbq2O+bjlWfS
         EefvfnJZ99IvXEGbihH+00s4jHFWuIugQFXVarRxVQOOK9LiyNaQXIhEXQ3hPG2zjXos
         RmffZBjPmhxYc1Y4jICDYMeFClJ7gaPZfS2h+0oIqI0+l17SR+Nk+U/KKa1Tq7kXqa24
         P8/r3bUTU1mkaiKGVhcyEIAQR/2xVEx12IPq2+/sipaymHxLSWpITc3ueaSp0a09aIzp
         mI25I6lr/k0Ak9ojpgLM4IB9k2MjNdJhhThFZEVeD+SgdASvqt/5P5L/xxArq7ivq5hz
         qLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbpbSNSqZWoxsOtZT/nyJmDd+AdyIC8EGzsm0EozS3+gKVR/GSyvsTw/OdQpkShMABGchAF/oQihvGeQHUD//UD85PUGQJvZy9sogaPQdM
X-Gm-Message-State: AOJu0Yw5I+/aAU05lX50D1oOxBpQAvEgrefxQZaqkoyXKXMtgmVlQBAu
	M/6Az+YyWrlLvSmT7P3LyXRAgXPiLAQAq/SbnSbIE5jj1Nj+OVwSXIznAjYRNbLmt8KRWkYadCr
	tPZg1IAdT/m+WKLUjAEKAQbuAnl0jKruaRmp9
X-Google-Smtp-Source: AGHT+IGzWqUIOUu5I0duuZgvPFrMrMabv8H/NdN0jk0nuFo5i4muxUfa/my0tZITK0IRu5y8Tg7eEzkZ4UvjvZQkd6c=
X-Received: by 2002:ac8:5913:0:b0:430:a5df:a3af with SMTP id
 19-20020ac85913000000b00430a5dfa3afmr367264qty.5.1710775885132; Mon, 18 Mar
 2024 08:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org> <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com> <20240318144806.GA3963554-robh@kernel.org>
 <ZfhZffrZXwtKgZ13@hovoldconsulting.com> <CAD=FV=UpuD7Lq0DxSZAGpL4Mi2uxy9HNt3V3FZq7Y3p--gbMrg@mail.gmail.com>
In-Reply-To: <CAD=FV=UpuD7Lq0DxSZAGpL4Mi2uxy9HNt3V3FZq7Y3p--gbMrg@mail.gmail.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 18 Mar 2024 08:31:09 -0700
Message-ID: <CAD=FV=WCzrh926mkiyBnKRG_+KGuOkGN6v0DgPiXhQCD3PSQ9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991 compatible
 to fix bd_addr
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 18, 2024 at 8:26=E2=80=AFAM Doug Anderson <dianders@google.com>=
 wrote:
>
> Hi,
>
> On Mon, Mar 18, 2024 at 8:10=E2=80=AFAM Johan Hovold <johan@kernel.org> w=
rote:
> >
> > > > I wanted to avoid doing this, but if we have to support Google's br=
oken
> > > > boot firmware for these devices, then this is how it needs to be do=
ne.
> > >
> > > Don't Chromebooks update everything together. So maybe we don't care =
in
> > > this case?
> >
> > That was my hope, but Matthias seemed to suggest that we need to
> > continue supporting the current (broken) binding because doing such a
> > coordinated update may be easier said than done:
> >
> >         https://lore.kernel.org/lkml/ZcuQ2qRX0zsLSVRL@google.com/
>
> Chromebooks update kernel and devicetree together, but not firmware.
> Firmware is relatively hard to get updated trying to have kernel and
> firmware updates coordinated at the exact same time has challenges.
> This would further be complicated by the fact that firmware
> qualification for each variant happens on its own timeline.
>
>
> > A new compatible string (or one-off property) would allow them do make =
a
> > change when they are ready (e.g. by only updating the devicetrees after
> > all boot firmware has been patched and pushed out).
>
> I have no real opinion about the exact way this is solved so happy to
> let DT folks decide on how they want this. I will note, however, that
> device trees are never shipped separately and thus we have no
> intrinsic need for DT backward compatbility here. It would be OK from
> a ChromeOS perspective to add a property or compatible string for the
> broken case.

Actually, I should probably say more about this to make it clear how it wor=
ks.

Chromebooks ship the kernel as a FIT image which bundles the kernel
and device trees together. The firmware looks at all the bundled
device trees and picks the proper one based on the board name,
revision, and SKU ID. The firmware then looks for the bluetooth node
(I believe it finds it from the "aliases" section) and adds the MAC
address there.

...so we could update the DT to add a property (if that's desired)
even if we don't update the firmware.

-Doug
