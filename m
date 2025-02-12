Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38571EF08E
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400614; cv=none; b=WMOVxyGOtCpd73fKE7toZeHUmlDuetGRZVzGdBLNg07sdQ0gaWHPk5OAhmQDZQwtbl7XrTL8BBq+QL0GnJcEWXGXIkJ7xYn4N0WY5GzOUaB4n2dYfgwBjR3q7a5PVC59gr+aL0GffSUkdvYNTpD7ZYoqO3OmkKXC5wipNi3yJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400614; c=relaxed/simple;
	bh=nAZEBEhyHvR4j4bP/+6aDc7scXdhjjb4hceczsUK3gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1sdFYe1fM6EKiuDfR6+LL+D2vhV0JkUbkPC1QTaY/wSqx7eFPSdhTNgscOfL8qhBOeuoz1+FgVUelw5CexgDCVRciMyf9pEAswV5moOxRaSiiVfu99uvlmJ2wpJkeGGeeuDSkDjSsc2H6k5D3txcOtEFMU5hcs7iBhHNkhBn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/8iWkFK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/8iWkFK"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3072f8dc069so2588721fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 14:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739400611; x=1740005411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwB6kD5JX3m0egPWyjfRa46FJnSjglNeoS+ecGKAms0=;
        b=T/8iWkFKPxBthqGAmIgOcWzBxs+oVPBlVh2hUzbVsVAZGVkhWi1QvjqMlkPAtzasr3
         CBLeRVziNxL13zkh9UGYUNeDDttU6C4ZLKKsDzuQu8ZV+OKmGu08sMViFaxcXqpOxiu0
         ihRhL4VpzBC92U7CUmuIDWcXjVnGwNwIFszcQ+HMioNKzKHw4pPm4u0cELE1LGzJPscR
         dns0Uz70AbGDE7m/KlamPZ4t8D+Pary65bP3qmjTiOR6fQ7eflvlPu0ahyblCQNA6czz
         NOHDK7z8iItd//dsiYif8FeramMY28r1T2IL5p9ptj2ssOSJnVxcFF+fNmrUNmw0OoIM
         3J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400611; x=1740005411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwB6kD5JX3m0egPWyjfRa46FJnSjglNeoS+ecGKAms0=;
        b=Kd8mjTD7vBnqeBw4BdrsyxNeZdtOXNG/rIy0w1zZ0uh4cFrgcbugRiSWwi9S9DNIui
         KzV6TE3eFtje9hdFXpAQ2WP71ZGY2DiIbewYxJOanRz5cKSvjA66+Ht4B9ZcVeyeuu2A
         Lq3uZDtI5Twyny/29enovyhsWrSGOvHnVn4i//sjAiE4IXsWJ8Wunfc6faLC2MuK8MUP
         t+OnQ25PQpEkNvYOXfQmTnwtH+1+/K0acOu+iUpkJ6C8KWer4T0OvrOztv+tI47ww7IN
         jowmFNK1wWbgZl/rrKopHyMhb06CJ6nYmru8X/knn8pTW2o6/YB/kYdbj56aRxHJFgkd
         8tAQ==
X-Gm-Message-State: AOJu0YxFb4x5yfmFnItIPD+FlyyVVW4f3OLsf3XJaiHVOKDur9uLE3yc
	3vy5JsFm9OEremIa2Xmmv8pSXgQOPnbt0uF+aPsX9HN23PpRGCLHXRHolaaxuVtxn6iKEMukf7+
	OHuAgAx8NPL7exsUdPPJ/lMkHilY=
X-Gm-Gg: ASbGncseQLd6xooodq2fq8tZv9e1Mu8m7SaNSXnFsOJmlK/uMnRcM2PUEKIrpg3YG4u
	tNek5wL9guE1dKyJDh9eyGKg7nAHCc5QTbJSwfWg657Q7hutESyMdAmJ0t1rCrhr/9G875N+6ZQ
	==
X-Google-Smtp-Source: AGHT+IHOfSF9m1VrrKtNflW4zBk3mWXxXBDOj9s24r5bUVYNg9vCROH2F4gHy/uYb1zhANmY9DZrWfkKqZqUgz/7gHs=
X-Received: by 2002:a05:651c:a0a:b0:302:360e:a153 with SMTP id
 38308e7fff4ca-309036f48d2mr14071491fa.36.1739400610762; Wed, 12 Feb 2025
 14:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+SYtZ48Rc5mife8bLV12ri4EvqL7QDJLnxuSNBmV46rg@mail.gmail.com>
 <20250212175427.131356-1-arkadiusz.bokowy@gmail.com> <CAGFh027qyNyE+h3g+nxLy8A3eXyAE3TDYZGXGg4sRwM8XUpMEg@mail.gmail.com>
In-Reply-To: <CAGFh027qyNyE+h3g+nxLy8A3eXyAE3TDYZGXGg4sRwM8XUpMEg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Feb 2025 17:49:58 -0500
X-Gm-Features: AWEUYZkaV6v8pamltIAcCUHLerNGGgUGkaFCaAd6RknErPyKTjCk91uNgbNcXQE
Message-ID: <CABBYNZKs1wZ8UfkKyq8pGXWEkV4hFbC30kWm7-SwSybp5JwKvg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] btdev: Broadcast EXT_ADV packets every 200 ms
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Wed, Feb 12, 2025 at 1:10=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > > No, it's not an optimization for my particular setup, but more
> > > generally for CPU load. I thought that it might be better not to run
> > > advertisement code too frequently. But I guess that lower values
> > > should also be OK, e.g. 100 ms or 50 ms. There is one "issue" with
> > > that, though.... Now, the advertisement packet will be sent one
> > > interval after the advertisement was enabled. If that's indeed an
> > > issue, it can be fixed by calling the callback function in the moment
> > > when the timer is armed.
> >
> > I'd keep the initial logic of sending the advertisement immediately
>
> I've fixed that in the v2 patch.

Ive sent a v3 with a couple of updates so it should now use the
advertisement interval rather than just assuming 200ms would cover all
intervals.

> > Btw, make sure you run the testers to confirm you are not breaking any
> > kernel testers.
>
> I've run the test-runner to verify everything (--auto). The result
> seems to be no worse than without my patch. What do I mean by that?
> The case is that I was not able to run the test-runner on the vanilla
> master branch with 100% success rate. There is always some failure
> with my "setup". However, when checking only the tools/mgmt-tester
> test, the success rate seems to be higher than without it (but it
> might be just a fluke). I run it like this: "tools/test-runner -k
> ~/linux/arch/x86/boot/bzImage -- tools/mgmt-tester". Anyway, I can see
> one test always failing - "Read Exp Feature - Success (Index None)" -
> it happens with and without my patch. Also, I've verified that the
> advertising broadcast code was executed (by adding some prints to that
> function).
>
> To conclude that, I'm afraid that I don't know how to run the test
> suite properly... So, my verification might miss something. I would
> advise you to verify that patch with your setup as well (if you can).

On v3 there actually seems to be some regression with the following test:

Ext Device Found - Advertising data - Zero padded - test passed
  Client set connectable: Success (0x00)
  Test setup condition complete, -1 left
  Client set connectable: Success (0x00)
  Test setup condition complete, -2 left
qqemu-system-x86_64: terminating on signal 2

So we will probably need to fix that before we can apply it, I suspect
we are getting more events than anticipated causing the steps to go
into negative which probably is why it hangs, anyway it should have
stopped when it reached the end.

> Regards,
> Arek



--=20
Luiz Augusto von Dentz
