Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF178F3A
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586174; cv=pass; b=XPuGCA059Y5zEJeGOlss7zjd5b6icgqtr4BmgAuXCVksRp8Q/TIeSWDhwtVKWU/oB/nzEdmXs7PcvK8tLhfu0GKXimyXFT9wn6Utf935THlDfKEdxHW5WFNQNc+XoBJG1Zz6d5XKJYA2WfcwkanpohnvotcXFfBgOVs2qL/f/fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586174; c=relaxed/simple;
	bh=zDe6TZZxJ4B67ZD6wMzNIczRgBALHRtp1s1BE9T79nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzmNW96PaKrA9pzpNtOd1nvlpS3WVL+hl2Qxa170CW5R9YwhAHgnZIE5W2rGmIDhmotkhPAFBK4t5ZO1JtzYMWTrBF4dq3vxFa3cS8tWH4+2L3XDBj91pDMQBoGpyHlUm5xZXGOwswXKmHS4SZ7u+Yv5MHZxTBY0hABTPle23pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEf97dju; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEf97dju"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66039d3efcbso939560d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 08:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780586172; cv=none;
        d=google.com; s=arc-20240605;
        b=A0Pxdy8HRXV7f5mK2lQNem3eEnXQndy2Y5GnfMpryrhWT27ysOckhxkvpCqMnBGqti
         POdW6ooQg2U+zA1xeQKQsIJwnLdvQMYVxOreX/SZolfrzF6xGRrZhmQQyo+tUS0CwUE8
         bxIv9p07vfQzKL7hH7lmi4M/QTh21lyIO94g2nmESkkq2qLa9qQ6I3Ud07qHiLJCQLOD
         Vp3RBAS+KNsycc22HSWLMRxZv7QukThHvCNw5QHwN9+QEFA8QQzRPwp0q4QAHGKd5q58
         tiY31TIiEU8osbNmyIvO4BkinQDMM9iwryxIKGx94MHBSkqOi7fCevsh7Ws+Yn/7y0k3
         /5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zDe6TZZxJ4B67ZD6wMzNIczRgBALHRtp1s1BE9T79nw=;
        fh=u97GpbGRgz7zfZe45L8XaRrZ0Uh57xAKe2VtnV8c9gU=;
        b=cjF0VlIkufSLzZFXOzXhVm/hLryU2mGsZO3IfmPMlAzT2h5TK16Q3BXruXfpwlN37n
         LGft/+Ho+8JPWmlF5KY7F1r69hF/xctVl6NeWdprS5ggeJLgU0FtSgmfdusFJYOE5bR8
         EEEPGaDCMUh2q4Cy9u8hDGjeT0hsONhQE7uX3DToK6dCSRUKC+D0KDWWEoV9ZXiWuSXn
         t1Y2MGg2HV6TnlLKg/fguereEVN3hpKN8qBADFVd7bPigDT5h6dXP6Z9V44yFB6IJvOz
         561uBXMPpU100F/DGqUZkNt7WBS+ynNI98hVwfKZEDFGPUx7OaqbAJbq9xLznWKUd1Xy
         MmrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780586172; x=1781190972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDe6TZZxJ4B67ZD6wMzNIczRgBALHRtp1s1BE9T79nw=;
        b=YEf97dju7kHdLfVlkA/C0HNfkP0EF2s4EhuZ9/i23exOZpaBmVvLruE9Kg2n9AEdXj
         d/V3tjx3yJpsD23PYBZYbvSgtttqhNb2vhE/wZ3+z22vYyDffdn9MbyGh+H/rBO9mEy8
         JJhLrUVGlwZWXpzahrQhRxL4T1t669rPTi27NmuCXTCcfEZKnbVdIMfcZ7qfgVmkjaNx
         9L6QnUjaKMAnyKnHJkhAEb8m97PpZIs0SbtegJfThXDNW+WDYBRoCV+CVoR+XqotfjjC
         KvguaHhtDwJdZwJ4FW2f+no1z4E6mGpQ7gfueOq5sPjzEs7vEq68IxImfmA4wA9ry9X/
         w+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586172; x=1781190972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zDe6TZZxJ4B67ZD6wMzNIczRgBALHRtp1s1BE9T79nw=;
        b=g3WDZ4/ze207osz7118j64YDpLa4sU+ywF7JOveJVa89mTL0KPvEEuBQHbT9mBr8k7
         dLB0De3FHG3YyalUkwujNH2QauyrnPZ/2re+p08BwGuztycjhmkZFN8kMyaF6k8lVpdw
         38Uh4jOx0g5SkuZsvdbPhCVsvDMaFjrbjN9hpz8IjC7iOsLB8efi/6ZOGp0X+6woZNpO
         efDSrU2mVE8VTSNgNiS7zcsJpv1BXFli6HdomNUFQU3+8Flp2RaD2y8iVYRvtIqG7Z18
         M6LcY0e5dEaMM0W9DVXgey4J2ZAH09TseJrEHTLRAwHJimTdypyTgGhoQO5vS/CTdROg
         xAoA==
X-Forwarded-Encrypted: i=1; AFNElJ+mRRanBr2VZOu5/0gkahFWh35p+M3WAPGMrOvFoQ201biaLbKqUiChKcFtDlngnFK37uNGUOe5rf0CEznL8yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDWe60/eD/dchb/dvi2MPqIVBO1b4FRmo4r7VxUHF7K/l4qaa
	6IFpuIbn4dMelNpM4cyq4t111T3ZHe/4xbXlcnQt5Nk03MENcNla3jrtQhP8HZtu904ac89MJNq
	qf9Hg35C0afvtSsyTq1OjlR/TeTIalQQ=
X-Gm-Gg: Acq92OFgPbjoOrxZ4szPf9UnkfAXQT8HytUcZV0oJSwEHww24pzFAVPs8JnHq5yMd5s
	UN178GzLPrrCrL4xQq+osLmXGXo7pK5NBThGjogpbnsRX0dvM+MgowKCJl76eMjeDJGoM1sHtC0
	68pxJXkLpZACy/Bu6AqR2lMLKccXZ0wpAAb6ASm4uJ8XOpeGu+dG0QsukHtRHcwCOdtuBTEtZHI
	SNAf4Fw3khaqyKh+sKeld0HSbC4UdlvLmB4hByNdujaCj9RpGid5aRK/f1YFDFhsp/mvZJuHfMJ
	PJ0+KcgwPDfJ7dA11j5lebecGjYVeu1I2Z79QRqBW3adFjrGumgxlfywxkVb93rHlVcAB/goMhu
	jAw==
X-Received: by 2002:a53:4209:0:b0:660:9441:9e71 with SMTP id
 956f58d0204a3-660dc2a942dmr6177930d50.37.1780586171832; Thu, 04 Jun 2026
 08:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604004125.715884-1-tim.bird@sony.com> <1b4540a3814b2e6106f48435df8692beaf177f8a.camel@hadess.net>
In-Reply-To: <1b4540a3814b2e6106f48435df8692beaf177f8a.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jun 2026 11:16:00 -0400
X-Gm-Features: AVHnY4LfGZf2PqLvOoFZLUj-Lf0YhizgcgTAO7vzQ6PqDxciu6hTfavuDEkclFM
Message-ID: <CABBYNZKzZWXxE+fYkOOv1zx4Gk49KVae9L_i-HMVbJANAwpBzQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
To: Bastien Nocera <hadess@hadess.net>
Cc: Tim Bird <tim.bird@sony.com>, marcel@holtmann.org, jannh@google.com, 
	kuba@kernel.org, kiran.k@intel.com, chharry@chromium.org, gustavo@padovan.org, 
	prameela.j04cs@gmail.com, salvatore.benedetto@intel.com, maxk@qualcomm.com, 
	linux-bluetooth@vger.kernel.org, linux-spdx@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Jun 4, 2026 at 7:32=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> Hello Tim,
>
> On Wed, 2026-06-03 at 18:41 -0600, Tim Bird wrote:
> > Many bluetooth source files are missing SPDX-License-Identifier
> > lines. Add appropriate IDs to these files, and remove other
> > license lines from the headers.
>
> I think it would be useful to separate the changes in drivers/bluetooth
> and the ones in {include/,}net/bluetooth.
>
> Why do some of the id lines use C-style comments and others C++-style
> comments? (/* */ vs. //) ?

It seems to be a common practice where on *.c it uses // and on *.h /*
*/ is used, it is consistent across other subsystems and the BlueZ
userspace tree as well.

> > Leave the warranty disclaimer in files where the license ID is
> > GPL-2.0 but the wording of the disclaimer is slightly different
> > from that of the GPL v2 disclaimer.
> >
> > It is not different enough to cause licensing conflicts, but is
> > kept to honor the original contributors' legal intent.
>
> Good job doing this, do you know if there's a plan to automate this
> somehow? It would be great to be able to re-run a script on top of a
> codebase to verify that no sources were missed, and that we got the
> same license ID assigned for the same license verbiage in the source
> headers.
>
> Cheers



--=20
Luiz Augusto von Dentz
