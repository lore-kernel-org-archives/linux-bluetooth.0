Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8010A12
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206740; cv=none; b=lH7mU0Ru8LYd0VGw9yjD0Q6OpOtWYAgp+15iLitPQW7u6Tu5pm7LYWApuWBCyCYSUFdp3CQ1niuiFxkdKlrgTsP0w0RcfRzwP6f/jih9LkOd76dB3/k4bFaTkyGr/4fLcAOkvhSYKZWQgq81xvEPVG8e7VbrQHCQK+S5FwAPJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206740; c=relaxed/simple;
	bh=uPZLB/eQPXIUf2pIn6HTeXeziOIlhg4HRW9d44Plrrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTGGOnAETBQqj8N+2m1mZQdZipfHW1tmZghBeVMUXRAT4stjsBJKa7Tf9T4ycqbsz8NIbHCLPr6AjdpzwXedFDAh5EIk7NbnCHh5Y4G2tJu1V3GnRoOiQugTzns7Gwl2+ziGUZjG7h0YcjzVFgRHzIdhGNpmi+QhMqVNxClgNEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6CoBG/H; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6CoBG/H"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso28559921fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706206737; x=1706811537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmrZYgnBHKp7Idev3Ejhlm1obLKwQL/c4TT1e4dRR0E=;
        b=f6CoBG/Hi32qDWp4hrw72x4i8mByDbbRLZ6JH1TYqv6e+OM9OtLu3uwbfFMuY1D9Np
         bYcExcmblUeXM6hVw78+kSP6AMZCKTQUjNrhki2b0dR69t0cGw3XyMHQ7HIzQ7qcU4F4
         PgRvoqHZnqU8ErYj3UePPw5N638Ho9VTujcX1wIjB+9tQrZR9qRPPgikFobSiuLLDJ05
         8/Qf/qNaLCCJzZMaQzS5Gp/sRWOKHu1F8VTEc3KKrJnl+pdnnBtzP+oinDj9ksVrTO54
         Ss0PO91TqYWOSDhlv/3HUByIqfQirULup9KEz56Lb9lc4Q7zTblSSwkBRxqbpd+0ERQa
         J+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706206737; x=1706811537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmrZYgnBHKp7Idev3Ejhlm1obLKwQL/c4TT1e4dRR0E=;
        b=OkGaeRHJSkOF3C3oSpecmeffOwgt0HsMi5+GOxfVlF1L1cwBkV9pa0rHXmSKBAk3pn
         hdW9uzQZyr7/YQ1BKcwFndwaOnYG2dO85FZeIcsOipU4POcIbQ3EQWYZmaW/DDqf27tx
         sWvdynZ275HwY3ZpM643cMupsFzsM7dAFZWOfUKgKNYCMNvisceCj1GG6rUuaUULtcN/
         pgBbNGMXZKJofkjgDHxaGQwiJ7e2yvf2lfsvdW4JpxBG4SnbWcny6nWcCffYflakAkUE
         e3ehf54gRb8K4XulW/yl5d6XgulWlMFPDBqExmaXXHk9Lt1P6RLPVl96S1E/6FIze1eN
         CbgA==
X-Gm-Message-State: AOJu0Ywhcc+w+/C0fF59W2pbda2eNqkfrzBPViTBnHcCMrA2oWP3XWeV
	gmXyP+GcEW3e808CqUay24qATe647E6ek783SzJ8AfUTLZEzS+dFvGX+QvMgoTp3uvo3LqRV8Kg
	SvMRJSd/8bCEVU1YRExcLb/u+MQA=
X-Google-Smtp-Source: AGHT+IEBYWppg7vF41cWvZwg9XecFH1FQ6r/jUjRJJioZUEQOMVzGn8PTbf1ToDit6KvJ9W4v4pgKzvW2iJCP6AmxiY=
X-Received: by 2002:a2e:9dd9:0:b0:2cd:c811:6a24 with SMTP id
 x25-20020a2e9dd9000000b002cdc8116a24mr1315ljj.18.1706206736527; Thu, 25 Jan
 2024 10:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124-disto-patches-v1-0-97e0eb5625a3@gmail.com>
 <20240124-disto-patches-v1-1-97e0eb5625a3@gmail.com> <CABBYNZLibBw-_SJ4wpzF-r5cDPSds99kShO9C3v2FVNJ2Um9vg@mail.gmail.com>
 <CACvgo51BHdhdzhPifJjuz66Dc2vJ1QEvCrkxQwQnC8dNWC8nZA@mail.gmail.com>
 <CABBYNZKmRsr=i4zQcqw8ofs-yrb488FVm8pu5XcpZerudcBGag@mail.gmail.com> <CACvgo5120w03bgn8ZYeVPVcXh-mU1KWSJYJSTPN-6PfDb2zJzg@mail.gmail.com>
In-Reply-To: <CACvgo5120w03bgn8ZYeVPVcXh-mU1KWSJYJSTPN-6PfDb2zJzg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 25 Jan 2024 13:18:43 -0500
Message-ID: <CABBYNZJqkjF0WCtdCp7RpWbRVq9motgpSJvc_TyU=+7MYgZpAw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/9] Enable alternate Bluetooth connection modes
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Vicki Pfau <vi@endrift.com>, 
	Rachel Blackman <rachel.blackman@synapse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Thu, Jan 25, 2024 at 11:32=E2=80=AFAM Emil Velikov <emil.l.velikov@gmail=
.com> wrote:
>
> Hi Luiz,
>
> On Thu, 25 Jan 2024 at 14:59, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>
> [snip]
>
> > Hmm, are you sure you are not missing something like:
> >
> > commit 288c90224eec55d13e786844b7954ef060752089
> > Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Date:   Mon Dec 19 13:37:02 2022 -0800
> >
> >     Bluetooth: Enable all supported LE PHY by default
> >
> >     This enables 2M and Coded PHY by default if they are marked as supp=
orted
> >     in the LE features bits.
> >
> >     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Later one we had to introduce HCI_QUIRK_BROKEN_LE_CODED because of it,
> > but so far that was the only drawback.
> >
>
> Hell yeah, that commit should fix our problem. Fwiw we were on the 6.1
> stable tree where the above landed in 6.4. Glancing around it was not
> picked for any(?) stable branches, which is why we're missing it.

I didn't tag it for stable since I was afraid something could blow up
like it did, well now at least we know that a quirk is required and
perhaps we can mark both to be backported.

> Thanks a million,
> Emil



--=20
Luiz Augusto von Dentz
