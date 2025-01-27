Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC81A83E7
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013918; cv=none; b=oEm4EcXRDkM2uzz4dQ9iZfFjsJRuZEQZR/hZjrAdaFvVjf8MN50LkNfm/uGpxLv/q3wTDWcHEzMile82N1oL1pWJ8pVFWse1ZoZqBQl6F5TLWo0QIVFLHjS7P+DhVWnG2uDHzcNDOwWKa1HEE2yzxPFQu8wfHxtjoyAn5aroXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013918; c=relaxed/simple;
	bh=NJV4hkXTRM3mkSl4bOZR2JIrUR8FynpLGq/T/n3Qniw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/GVN8HpMxACy3UVmQZ1qNmjbPZgIFVtdzza9uXmlCy4SiEDxheoPxXiFCXh+LX7PXUPz7JpS5mPd94UcD+1/8PZG3BKHq8CrgFr+TEccQno7hZ74EfA1wtI5fIgYl2HbEcM26BvDUWYImBsZ5pDVMMnhfY1l9nq17GUc58NlEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiuGM90p; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiuGM90p"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a6bso53165831fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 13:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738013914; x=1738618714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJV4hkXTRM3mkSl4bOZR2JIrUR8FynpLGq/T/n3Qniw=;
        b=DiuGM90p1I2t+QFtK2OJrjlhu5jUmJhUpdIAcbxuDACzP+v67SAhUsFSCDCB3v8FKS
         nUckfpewNFtr9FJCZeDUGOJd8+Q/wzPQuuDyakuySyOjjWP13NaZSFCjdq5LTX6bfhq9
         rVjhyMr61ZT/zbIiap0As4eInCDGfbyCBuvsO2wUA3SB5UZNFxUMcqIOf60azkXxvyJY
         Ys8AsrK5ztTlFIJNFL9PUk0q9MOnYc/5FUYA7xVfr+msDN8G4eTEmE2YQDpG6/YMReX9
         vQBUpBOSAV8C3gxDUGrki4bpl5x6io2Yy1EabUKtalE4GWETcNkCjt4pp2cm5I+fwawP
         DcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738013914; x=1738618714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJV4hkXTRM3mkSl4bOZR2JIrUR8FynpLGq/T/n3Qniw=;
        b=PdAwZ2PUMMsdlagXyWySCLRlCJDmxnCWJKQhUifE805xVkeK9gYSZAsWM0qVs38a4g
         DuLgXNtxktN97DOh4maR2f56XLQs+rzM4BXt3HTMck4oontj9kPfTHNYmZV1E9ONYLe/
         IYm4vPlRSCgUWC5W9WB33K3tnzh8hKFvFElsUZHcrW0z9PEOZ6J8BcuQqBP5eX9NvWEV
         iJ38ViiWl5uEAvFmgld/lJfUTO40b73j3pLSIyejXqo3TPzoe8fRyFPnoHjYwkQSC8Lj
         vDVsvdjAkqWNf6n+mS38wJLm8Mf6ZjtdD3F+ZCTLgrwRdSKfp1kkF1G71SHSm+rsqtAB
         0f1w==
X-Forwarded-Encrypted: i=1; AJvYcCWESGN9kfORqohXjjbwJ68NRH1emR8o1bgnsB9X1d2PCDye5mV8+2JgtNQ/skHtkwcf5twBwBgf/mgUtv2OKvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynTHDV7nHkVP00LqFuK8AYjd80OrSkVQf9wfmpkk2MrsvEOljW
	By+qPw7z2aGieTAEcF24N8mUm1C/TweJBAM41CmJ0WowCRePFd8LhsE2MfeGoTw0CNZr2PlgV0n
	88lLcZoQRZUVVbkSLtSI2L4l5nqg=
X-Gm-Gg: ASbGnctp++ciCqx8V7Tx/ckQOLYvOxJjnHSnJpJ/m5kKmv4xSE3S1kXJOACFpbw0MFv
	DhRtDgWoLQ33MUDcOMvjNSbQBkZTxj85AIzRb5FavcKmQ3c3K3YfTnVbxQCBTgtikTSTBc1lSIw
	==
X-Google-Smtp-Source: AGHT+IHMwkDbeoKGmmY/4P958+3BjOo1w2uFBUoDDLbvBDODYkClVWpja5fQT2nkqPVyRVntx8nuFLTvJ+CiPB1mLj8=
X-Received: by 2002:a2e:bd84:0:b0:302:350c:7e9f with SMTP id
 38308e7fff4ca-3072c995303mr168130001fa.0.1738013914287; Mon, 27 Jan 2025
 13:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5aMrXwnmEXxKWkC@vmi2410184.contaboserver.net>
 <452f118f-2a0d-4b54-9285-063ccbe6e5ab@web.de> <Z5f7BcSERmImx0_H@vmi2410184.contaboserver.net>
In-Reply-To: <Z5f7BcSERmImx0_H@vmi2410184.contaboserver.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jan 2025 16:38:22 -0500
X-Gm-Features: AWEUYZlPqU95kgtv6gVeUjpLGU3G6M2N4VtYCXwK2p_iZEmNl07_0-_GxkLOjyQ
Message-ID: <CABBYNZKxhq33FXEb_8LMLV4whhX0jc100tUPYCAs9t1q9_5MBA@mail.gmail.com>
Subject: Re: Bluetooth: Remove unnecessary braces around single line statement
To: Jeremy Dean <deaner92@yahoo.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-bluetooth@vger.kernel.org, 
	marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Mon, Jan 27, 2025 at 4:30=E2=80=AFPM Jeremy Dean <deaner92@yahoo.com> wr=
ote:
>
> On Mon, Jan 27, 2025 at 05:17:20PM +0100, Markus Elfring wrote:
> > See also once more:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.13#n145
>
> I read it.
>
> > Is such a tag really relevant for a coding style adjustment?
> Is it? I think it would work. So before I submit my patch I'll need to ad=
d
> a Fixes: line. I have already edited my commit message. How can I find
> the SHA-1code of my commit from 1-25

I normally don't require Fixes tag for coding style adjustments
submitted to bluetooth-next, these are not typically backported since
there is no change on the logic or final binary.

--=20
Luiz Augusto von Dentz
