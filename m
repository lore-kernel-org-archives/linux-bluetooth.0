Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92141F5F3;
	Wed,  8 May 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177940; cv=none; b=J2fc4GXcntR8Ptaw/EwWUrwxEat6rOxwCqjpu3EDvIm4aGDPM41cIi/cFgbzTrjvCRsbW91FurIyDGVHIbsNmsllS4o2CG1/uUtMa4FrDTlPD9QGVbvyu4sYsJl5al0+t2oHXJqQzRpuki4SMQMERsg+TXV4s4//QUKKELw3QyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177940; c=relaxed/simple;
	bh=2kkirt6e1tPPOnZq3X5WtkWdhQIf6ryAuUYhO5Df7RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyJUv969IdKe6xEQSApK2gh4CwIUIPIi8Q4DczDJrsBwOMqy3ZLD7dVPzVFnK9/GKYrI2TMyGC6uIgpv2qcJI3uqIzCuL8Wu4+MYbvNkDBg4w4aBXnL2zMyeyoi14LM7hOSjCOujNBUIxSimAxE7foRA3zIBW7MfWaBjtj+QhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxjHvgoS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxjHvgoS"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so53567971fa.1;
        Wed, 08 May 2024 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715177937; x=1715782737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/o8FZDVnI5HiA6gRp5LYG7KHS1m880+Mz+IUrCObIk=;
        b=fxjHvgoS5X8vtsQbkp8sJDwM4Py+F2ed/vR7sDQdiHahybRWPj5K3s4WctnpZGI9Fc
         vXJfDprtTMdcFk6YmtVtwR2YDnR2bec/wax63wWlMoSJEHVYHVzuHjFzq/dFdeHATmSh
         hi0MLJvc/gjA0YXOPKyGnK4WdMKJm4ZLIGODX1ODaOp5cw3zkjjYzls4RGDg4+nGkoIX
         U6yTwd7EFFD8nZdgTRfwKn1kpA/qQ4+3gNHRoDIrWe/cL996BRz0ouLgRPQdtAP2ci0+
         CWVfNGV6A+rxrQ5AMQ0UV4OL2oowwV3muJVVe1xSL8dlzUG0gAcHYp5BUL/J5aZ+52VO
         yACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715177937; x=1715782737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/o8FZDVnI5HiA6gRp5LYG7KHS1m880+Mz+IUrCObIk=;
        b=hjKfraCw4avOmK68QtkJJc86fNPrYuj61/vH8LTA6Q5R21mZ2iRld+H5m0meGK/FK0
         nCExAwIuWHjYA+OEQXQS7AzPb8BiprM/rF6LE77mI0zqHfa7jgmps6OrsGUO6P0xkOBm
         ghUwenu+n57brroiu7wMXh4QR/VGailo5Bg/Ct/t8c4bVW7CFTx50qRkr4tPxbMz44hI
         tT0MLkwiC0icroNwZ0j4GCVbnH5RV/eNRPfS1Pc+136IwIHxEFpcDKll7IxefJYSya7r
         hlVlDyOiEg1CqXAQlzFM576n7YroWq1kzZcGKK1Znoan99Wg3j6shvnxfnB47yX4e89h
         miFg==
X-Forwarded-Encrypted: i=1; AJvYcCWfLmAZKQZ9U1SYLfIwDL+EELzQWUzIRtnuilk+Ezt61I3EdbUA98m01MhV8+rVwk3LEE/WDRLTgC/avyXySi5hWK79b68FOd410bQvXtFANBDRW0LFdA6Uuds18aTmjewCoMbaucaQrwJssYGw
X-Gm-Message-State: AOJu0YwXHRGlOVCCf05vtAOwPYD4MUxX1mneBSMaYmoiVb1XBUq0Lb3w
	pfPeu4meL8n4gMmqQnTVNVVIiFVO+i93BhxqpkfjxzSFnNQaJi0GD67xOXh7/q3ZBGpTCsL7KXh
	OX/G+8dFAyqyP731SWcRMLrMbMjc=
X-Google-Smtp-Source: AGHT+IHNN2Jg6pxtqKtrszRPpVa+3MamJp9KOJV7TV2Xe0scCtageC9Am3BgR9TNsbvf9fMR9gNXRhBjiHur8eRokC4=
X-Received: by 2002:a05:651c:617:b0:2e2:be7a:e497 with SMTP id
 38308e7fff4ca-2e447cac611mr13719581fa.49.1715177936843; Wed, 08 May 2024
 07:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141922.25055-1-peter.tsao@mediatek.com>
 <171328023414.16225.12939333659144302573.git-patchwork-notify@kernel.org> <0d59ae68-7552-454a-8d01-72c359496901@leemhuis.info>
In-Reply-To: <0d59ae68-7552-454a-8d01-72c359496901@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 May 2024 10:18:44 -0400
Message-ID: <CABBYNZK1QWNHpmXUyne1Vmqqvy7csmivL7q7N2Mu=2fmrUV4jg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fix the patch for MT7920 the affected
 to MT7921
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, sean.wang@mediatek.com, 
	deren.Wu@mediatek.com, chris.lu@mediatek.com, aaron.hou@mediatek.com, 
	steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	patchwork-bot+bluetooth@kernel.org, Peter Tsao <peter.tsao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 4:34=E2=80=AFAM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 16.04.24 17:10, patchwork-bot+bluetooth@kernel.org wrote:
> >
> > This patch was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >
> > On Mon, 15 Apr 2024 22:19:22 +0800 you wrote:
> >> Because both MT7920 and MT7921 use the same chip ID.
> >> We use the 8th bit of fw_flavor to distingush MT7920.
> >> The original patch made a mistake to check whole fw_flavor,
> >> that makes the condition both true (dev_id =3D=3D 0x7961 && fw_flavor)=
,
> >> and makes MT7921 flow wrong.
> >>
> >> In this patch, we correct the flow to get the 8th bit value for MT7920=
.
> >> And the patch is verified pass with both MT7920 and MT7921.
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/263296438807
>
> Hi! 6.9 is only days close and this is fixing a 6.9 regression, so allow
> me to quickly ask: do you still plan to submit this for mainline merge
> soon? Or did you already and I just missed it? Ciao, Thorsten

It wasn't marked with Fixes or stable though which is what I usually
use as an indicator to backport.

--=20
Luiz Augusto von Dentz
