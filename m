Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3021770C
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161717; cv=none; b=XIfa0xOBnK7zSPHZ7kcwgtep6et/Jn4OehormJSABc6kGm0C2t/ixR/hVXBNPbm1SK1aDMx6kSLxgcPG+QU6Ow3P5KDNE1TEL2pGN0fLSdOdNluuTdzykN4q80Mtwor/e3bYdIN7EPbPCWbwtweDvUMwvkSqu0VmtrTfCUeMXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161717; c=relaxed/simple;
	bh=oadeOqdjiKMeev8PewOUiOhaRXh7jvid763ETEvZDMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6drKqnZ+K4Qe9A5T09SM3JiYd/KgxLDlN78xceruEbaywpGIrWkwTblftrlKOrTrplkf/1B74ym7bjNu2JUMJs+R/mIbj+yHhdetwxWiYUEv5OpmuZaIh5dyPZfcgy6BQ2ShlH2gElosXwqmICr26AeslpUWasnCrn3XLLVgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEhEzgtl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEhEzgtl"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36453927ffaso44461281fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759161714; x=1759766514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74Rsk0zhOTuyxjtX5jVC1PFwqE1QJ68IfeopCcWou6k=;
        b=iEhEzgtl82/CO/YBmOPpu5+e10gSYv53lCxSED2qj5rhyxaxwEk3/Ch/UX9e/KId7z
         YHGNLWjYGvniDAhuu9Hew0JaeR5kt35BC82hFbCCreNgPvU05UsCdw2FZliV4UeaEaSm
         BFLHVqGm/Y/d0L17St1NkuI4A8y6AMdl+Cs21rVxBif3H8/M3dCcj2uqmAO8vtxEmyTJ
         ITle15J2Bk0bLNKpd20thYgQJ4bj8DIosf9ih23dpC8QSXvhpBJx0MtU28InsU+PIcn/
         1jTKoJ227+WC4RbAUp7UgNcCJqlNIE4y8O7rTWh7D3k0SqIbpx+vLbIPvsHOn//nuYBg
         eRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161714; x=1759766514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74Rsk0zhOTuyxjtX5jVC1PFwqE1QJ68IfeopCcWou6k=;
        b=S+oKi3sLKw/exSIYn3tc9jLRPycqBxwIgFmphBHFs4LuKsVgYGUlRnv7DB1dkGEEUK
         65jr+Qij4QKaWUkE66dqS6mazRJSSxLkjaaITPnZwx8D8USKSf4F372HsOw7bVNOe7sy
         wrrwPjYJ+c69CLoIXFLM5lLYSDc4q7iHJsqx3kW8HsKX6PC7A/bus5+jlvxTvilK7+J4
         QR72QMxb7tFnqoktfT9aylJ5oGhgwq/2Iv5hNHvoPbR0wuXGtzOGcaDvOaeqtOKCxTaW
         iJKKuHs9H5XlZRq110N9o1HQaa6yXWthw+5nsmWguTO/bytSsGEf/w907ppwPPw9awxU
         lF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmo0pfuURjlzVonZALlBzYEDIuCWBEMfhUi7zYJvvV5G8HHn+Ws3JkyICqVCcvnqSOo3WDyzrrCxRBpLnPb4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGax9uMbWsSHZFxsU2oXukGuauu87cuSpBPTKoG/mBcR1b9WJ
	t82vhTKPfMej6zmil6dTTdhv8LCBHSkrgfrvKtkFQApiyIvaqdbkdQDmKfUYuiP73JDWFQPn7r5
	w22oicupsAn6SekmOG/xAkOyr1PjlMrg=
X-Gm-Gg: ASbGncuxC/nXB6iPiE4Fq+GUgoaE6pz+nwuB4hqtm86HajV65cWvmDZI7LsINGZDQVs
	MRl3/801qprA1a7X0dHu7iWqb59wCDjy6mp+OVIJKQTLottDCpeLTCM4/dFtlsWYEu9xBxMy6ZW
	Vht66Qf8j7oTUOEtXzFBnUJMLnAOTphxA1/DMXrQRELx1Gm7EUCK7OQAJaHajd8pWpGMdPrFpaT
	JOSC1q8XPTP2R7Q
X-Google-Smtp-Source: AGHT+IEwWC1V3nTvpmB+f+dIHO2ycq0Vs80iBUr3gJGVBaqbUlUNUlbBslyfGp0tDefml7Q2l/E51kEGs3f8lqmqYc8=
X-Received: by 2002:a05:651c:3608:b0:333:7e5b:15c0 with SMTP id
 38308e7fff4ca-36f7dab3512mr48089181fa.13.1759161714014; Mon, 29 Sep 2025
 09:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827043254.26611-1-jgnieto@cs.stanford.edu>
 <a261ed13-4c0b-43cf-b177-d33272626d25@molgen.mpg.de> <aLUC3u3ZrF35nIb6@macbookair.lan>
In-Reply-To: <aLUC3u3ZrF35nIb6@macbookair.lan>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Sep 2025 12:01:41 -0400
X-Gm-Features: AS18NWDROgcD9G9WWK-cUVeJOEWEqbKRC5wZ4GLZhXOeG8o6ocnum9b96niQbW0
Message-ID: <CABBYNZLqcdNTh_aMe3JVKBLauNkXq=6n+xTt7q798cDkZGaO9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: implement CRC data integrity
To: Javier Nieto <jgnieto@cs.stanford.edu>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Sun, Aug 31, 2025 at 10:20=E2=80=AFPM Javier Nieto <jgnieto@cs.stanford.=
edu> wrote:
>
> Dear Paul,
>
> Thanks for the review!
>
> On Wed, Aug 27, 2025 at 12:56:50PM +0200, Paul Menzel wrote:
>
> > Any btmon trace?
>
> The presence of CRC is limited to the H5 layer, so it is not visible on
> btmon. However, I did advertise and connect to a few devices while
> running btmon and everything worked and looked as normal. I also ensured
> that CRC was being used by adding temporary debugging prints.
>
> > I=C2=B4d add the above to the proper commit message.
>
> Should I resubmit the patch as v2?
>
> > >   static u8 h5_cfg_field(struct h5 *h5)
> > >   {
> > > -   /* Sliding window size (first 3 bits) */
> > > -   return h5->tx_win & 0x07;
> > > +   /* Sliding window size (first 3 bits) and CRC request (fifth bit)=
. */
> > > +   return (h5->tx_win & 0x07) | 0x10;
> >
> > Could a macro be defined for the CRC request bit?
>
> I thought about this, but decided against it since 0x10 is only used
> here and in one other place. Also, the existing code does not define a
> macro for the window size bits 0x07. I am not opposed to adding it if
> someone feels strongly about it though.
>
> > The diff looks good. Feel free to carry:
> >
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >
> >
> > Kind regards,
> >
> > Paul
>
> I see that my patch fails a few test cases because it fails to link
> crc-ccitt. Do you know whether this is a problem with my patch or the
> test environment and where the code for the tests is found?

Yeah, this seems really a problem you are introducing:

ld: vmlinux.o: in function `h5_rx_crc':
hci_h5.c:(.text+0xd938d9): undefined reference to `crc_ccitt'
ld: vmlinux.o: in function `h5_prepare_pkt':
hci_h5.c:(.text+0xd94798): undefined reference to `crc_ccitt'
ld: hci_h5.c:(.text+0xd947a6): undefined reference to `crc_ccitt'

I guess we are missing something like select CRC_CCITT on Kconfig.

> Thanks again for your feedback.
>
> Javier



--=20
Luiz Augusto von Dentz
