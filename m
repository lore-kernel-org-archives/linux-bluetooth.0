Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9923218732B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113802; cv=none; b=qYrB26pk3bki7dFF/fSy1mGGtTcyZlH0aYeDniUI5nai0q0Xg2jaI6sDPp3YcA8PhelAu85PWbRPjLofgdZJXTeciL0Ki8BVZ7pROVBm/brnyGp3BZXM0M4aaOP9+8pFLE84Bh7iySQzXVHcBJ5IrdHTMGyyrdKyPFozu5w1PlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113802; c=relaxed/simple;
	bh=Oc8efz1MWWvjDfcSZoswpoB6uaGcmYBsPwVOr7Kw7Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txz0bLKQgKmUHNQ8D7S5wvYOyMsMW0N0Zv2swiKXeKLAjP3cny9DTGFzw2aJ3BM+ayGxLne7lxnHF2zFGkbAljBhoh9nHfInhTyje2u0Ks83HGigH3NaF31T75V7U4YguQK9MtisAwu6ES6+LJMrGIqro71sqCMk+i3GqcO4naA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECKHqbw5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECKHqbw5"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e43c481b08so8010261fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715113799; x=1715718599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rMdbzjInroQ2TD0E4zrr1ScKLSiTtH7dmZC4T4Zkb0=;
        b=ECKHqbw5FRnrPPh07j5q/nvRHguwaiFPecPWO5YeOTYL82jm5Td/T4Vr4HKZKfXmj0
         itaML/tC2jLWJz3bfMCGVI1jdjk7qP+fhTvHjhn2YEQckC+xVpcCvV82P+00IoErTimx
         9d6DLSFyLY42LJxK5Lb9I8vR+nWI/BZSfCmg4udivxHTSIe6A70wKXZm2OHacOnmZjzi
         1/+V4A47bUVII52/gsh5rmBjcaZYLCPfS7DVfOzIM/D5A5Fz4LD/Pby6fTMdix6xnUKY
         EtQuFEyWvQyYVO5yZEQVOTkNZl6gBjqUWZVBQdZxljl0/NVIKcPy8xxZhBAoaoCZROX4
         67rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715113799; x=1715718599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rMdbzjInroQ2TD0E4zrr1ScKLSiTtH7dmZC4T4Zkb0=;
        b=X17SUHBmqlt1ZemtqHnOws6PvILPlZvyNT62V5nF7AH29Lsbn3tyyEphUrjHdusp+7
         QjJGzDgB8Xo3KcUIvs7d8EBI/e90Xkz1U5+i1z4eL7JUyW+oVAS6tG4xB7eFHVoCH7a/
         aLTTV2LNX5UxlDxn07zot0QtWkiyWjE5qAvmvxck9wWi7jDSwW+tMlvGZ9ZOaUKOqfBV
         7CybtlZT90NNIfVPm04IMJcFCMpekT7DLOZrwwk5WKXc4ltFDFrQbCV+Uk87Nkc+fahj
         FDMRhNbXsDdLn88ILRfPhUIwDFAOOfDf96wfQ1HTQ6DHjRHtxTlsWLWy9uCTxPLT9Ece
         II3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO1CEWqDC8cSxDauNxdG/KpZ/InJMdaTRe4zDR1pb4OicTc/b2eJBQNyytv8oot6Y132EL12oVNGWNemcBWZAOKBeFL/+kgV2MsQmfMXyM
X-Gm-Message-State: AOJu0YxSWE0LkzHDjUwjZcfW8vfdA9W2apkzcF1GDXeWQOWfISXnjc5d
	EZTQ7ezOaU4tIodSIXjeVY5by//T0r3o1xnM577RHMUdI7DkovyVX9iS4M7DvAPE6sBpWEKwSnL
	Nfqap9Z1/u7seqsWt2e/Y8uIVuWxJmQ==
X-Google-Smtp-Source: AGHT+IEbOgoCRnuDzabRAG0j7szlkrZPAYkLn7fdGIounTeBMnIp9RspZfjNheCe05ueywy/j1xzdeuP0Ln2Sl8KO/0=
X-Received: by 2002:a2e:9144:0:b0:2d4:50b2:62e9 with SMTP id
 38308e7fff4ca-2e44738a92bmr3969911fa.14.1715113798439; Tue, 07 May 2024
 13:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507155658.294676-1-kiran.k@intel.com> <171511322828.4249.17975655561935546329.git-patchwork-notify@kernel.org>
In-Reply-To: <171511322828.4249.17975655561935546329.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 May 2024 16:29:46 -0400
Message-ID: <CABBYNZLsxw9W=uExvUzdp-iZFxX6p8AgLPgu=CDYQ9vp+ypGSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel: Export few static functions
To: patchwork-bot+bluetooth@kernel.org
Cc: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, 
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com, 
	chandrashekar.devegowda@intel.com, helgaas@kernel.org, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, May 7, 2024 at 4:21=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Tue,  7 May 2024 21:26:56 +0530 you wrote:
> > Some of the functions used in btintel.c is made global so that they can
> > be reused in other transport drivers apart from USB.
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > ---
> >  drivers/bluetooth/btintel.c | 26 +++++++++++++---------
> >  drivers/bluetooth/btintel.h | 43 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 59 insertions(+), 10 deletions(-)
>
> Here is the summary with links:
>   - [v2,1/3] Bluetooth: btintel: Export few static functions
>     https://git.kernel.org/bluetooth/bluetooth-next/c/1d8e17157eb5
>   - [v2,2/3] Bluetooth: btintel_pcie: Add support for PCIe transport
>     (no matching commit)
>   - [v2,3/3] Bluetooth: btintel_pcie: Add *setup* function to download fi=
rmware
>     (no matching commit)

I did make some changes myself and since it is no longer enabled by
default I went ahead and applied it so we can continue working on it
while it is already upstream.

--=20
Luiz Augusto von Dentz
