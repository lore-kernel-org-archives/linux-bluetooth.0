Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A01E1DE2
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931519; cv=none; b=CHlmX3HhnSHq+nQf3kVf+Iw8OZjXYKQQHzv45wWcp0CNAHiYwXjEbxPbLkvtBF+pW9tJvFhTDkb0wabTyiC8inUrpQ2seEf0Cr+ppWpn3a7KoQJMmIW0UIHCuwUfrqkbRXLTikPWXt6ES+i/IrrJPFDJFnVkXggfCdDZOyKje4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931519; c=relaxed/simple;
	bh=B3iajGfO1fO55C8EE0Yn4Sm6QyN2q79820w7TOU3z3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLIwjH7rBxNz1h0JBpEnm3N/dWyTyl+vStirL5YG59HF/mpUFBVYoDoK+cyyxD8/3VGaPzWc48Wuvvy3/ZTmmaSj2G0QyEPBFv5mBPPtg8B09PKv4SdxChAZ1Fgp5ahVyxQvBI/w9Md5L4WPJfF8fnSznbZ/ZQdhDCao4Oqi4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KctlrJ8g; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KctlrJ8g"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bfed67e08so68633261fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Mar 2025 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742931516; x=1743536316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/dlZi7J63hnfl/3gsuy+sauSv6KSwyAbb3mi/bmg/U=;
        b=KctlrJ8gu6EC50sP2GTsxnCqysChGU8t6iylniJQrSdABftBNUzTf20xiEK4sT0tb/
         k2iPEg8dyRN+Yk7DN1pn47rfvgfFdr5kMSgKuUNVuDp+RHy8jP/3q66n7LGMDX1gtf2q
         A0NfzHJKoCadXoTUuhHgB1SjN/LUvdn4KklDNA2zOtZcm9z+pKaerj2rQjsPROi8NZy7
         614DB5EKIxtRfrTuu4/w4A7Lqgdd0+LUn7tti4lzNkmRWawTjuNw52drJmsFbGKrF6uL
         THRuE9eQapwYMjW+tOskPysHchOb4KwdSG+L5TQuPIVV6zfY2vPQpaSrisq6aSzsJzrS
         pljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742931516; x=1743536316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/dlZi7J63hnfl/3gsuy+sauSv6KSwyAbb3mi/bmg/U=;
        b=bD31tyhujqe9nwBtrAsScfUN05Je908uINO2KWfXBAOFrdBIK26b7DvoZQWcG1PsOL
         6oGXDQcwDmAGqw1siLxdYWg3aHl4qJv5V3FK6pxRj4Tpb0xCq2zV/Ou0FaX739c7G7Nh
         TPe7Tru31BVZGpKwphu3cd3oV3AZWM2/khpA17NpPpgJu7TsQLwRHPhS8rXiYVbjC0ls
         qIGqzZMASZjCLb2m25X4RLuF1PqzbhyHiAyTI+pFbdd3HDRxDjOLVLfkSUp32xi9QMg2
         dADQ1fRsd4eBzjJw3DDm8/+V0A3p6cTB+pvxAX4sNYjjwnOBXwC5V5WxaIJjpw+m90zC
         cdbg==
X-Gm-Message-State: AOJu0Yw6r4XqKLzkIVfg7lDyGfxte3q2r65B9gWi+4rhj2JOR6T/S7+f
	2rZVH4vL8CjfNehqjUw/54GujAOrxh15m59luFlLB47fqnllDJhLYZij+rbKiNPMefTmUPjMzoI
	9eOYCc0Tb1iO+NU6SlMYmOdcovZXGgS2n
X-Gm-Gg: ASbGnctGurJEPS8jYHOo7SLyuS3WY9i4m5RNCZNCuL3+I107flx1CJoV0C3RBbOhwxO
	4Ah4oJEXltK0wzHi/9C9UXWeFRAyYSzB9+1RIRSgae16hfnW9ZnUdHQAOnxJlWHpTdFQDzqJqfM
	akCR3MWEBjdeM2gv2TzgxFfXkE
X-Google-Smtp-Source: AGHT+IGkWeRy+a33Embg/8v2TinspGpXyOJzDVazrr9kVRzwCCXc0JjkDv44O3kvoWToQbLvNjC4FuqHbt7lEPUxNSU=
X-Received: by 2002:a2e:a9a7:0:b0:30b:9813:b00d with SMTP id
 38308e7fff4ca-30d7e3001f0mr77833421fa.23.1742931515961; Tue, 25 Mar 2025
 12:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325172846.139431-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250325172846.139431-1-ludovico.denittis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Mar 2025 15:38:22 -0400
X-Gm-Features: AQ5f1JqyeHaUaaBd4CoD-S75PEaglQIign5byNcvLgIsuLDGMdcOJEw831EJl8o
Message-ID: <CABBYNZK7eEUWS606Ys3DnzA7TbTmOXTUfwmsnu57DG+PxOnnuA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Fix wake_allowed reported error and not being
 set after pairing
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Tue, Mar 25, 2025 at 1:30=E2=80=AFPM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> When a new HID or HOG device is in range, Bluez reports the following err=
or:
> ```
> src/device.c:set_wake_allowed_complete() Set device flags return status:
> Invalid Parameters
> ```
>
> Also, a side effect of that issue, when pairing a HID or HOG device, the
> wake_allowed property doesn't get enabled by default, as expected.
> It requires a Bluez restart in order to get that property correctly set.
>
> This patch series addresses those issues.
>
> Ludovico de Nittis (3):
>   adapter: Preserve pending flags when setting the Device Privacy Mode
>   device: Preserve pending flags when setting the wake allowed
>   device: Try to set the wake_allowed property only for bonded devices
>
>  src/adapter.c |  5 ++++-
>  src/device.c  | 19 +++++++++++++++----
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> --
> 2.49.0

One thing I just realized is that we do not persist the flags accross
restart/reboot, so while at it it might be worth adding support for
it, the other remark is that perhaps we should store things like
pending flags into struct mgmt so we can add unit test to make things
a little more future-proof in this respect, any these can probably
come later so we don't need to delay including these fixes.

--=20
Luiz Augusto von Dentz
