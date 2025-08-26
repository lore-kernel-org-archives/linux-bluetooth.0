Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8A34F47D
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226239; cv=none; b=FBJZYGkyib2ABizOZ4mBEF5um61EEF4fTgtcgHhE6SunPNXOApbA5WtDksRMYiEOlIg87aHzHkgYVf6nyvT7UhtEApjF/OUBZWmuc7pgdydi/JPJZHy+mZeKqloBEbbZPKOjNBswZPUO/s6da2B/coawxGu/idkGacmIG/6tSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226239; c=relaxed/simple;
	bh=oqabilAq4pjLXoaL2HXnocEbdNI3bdZC9Q2YiJKRS5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+yzyZUUhOyZRzWCT2Sn9RdJJSrOPpnCWkRhnVGa7I39nKcSeHaZGtdBiHGEGwo92Wn5eomT4JXs2hyCF1tbGoQfsDjWSYvUVW9MTuye+5bxnIjzzuqK8uMhoFyZPxRVXF6+WIjdPD/GOb5+9m6buAa9H9WUyaFOduoMJ2PzEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW5Xi7SJ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW5Xi7SJ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3364e945ce7so41053331fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226236; x=1756831036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqabilAq4pjLXoaL2HXnocEbdNI3bdZC9Q2YiJKRS5E=;
        b=IW5Xi7SJbXUCt1flYE6tPLaISjsEY8uqOMaq4W1iMNXyEjrmYhJzIeSoFThi/WvL6v
         FVpjGCuZGNzJSECfuEfijtcRzz+PW8H6PDaxLKih1CJpmDqrveX9EaeN4nAVHzPo/8Ii
         xXbdliAW+79fxnU1Av1Xxm4tV1f0e3zOd96JePzcwuShmRezNe/DkZ84x09QVpFpnqyQ
         lFrbNJUikaQQI8kaL3EEqHaukU10bd1xkEfNVzjPmI1AB8GM8Lk7W11/kC2KBZ7FeHHY
         /k4+AmMKN105SOnb0/OJneaVlYs4rBkqQxvvV7Im09cs6bm9XTaaPyzQ6zBFx/5VIAa4
         1qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226236; x=1756831036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqabilAq4pjLXoaL2HXnocEbdNI3bdZC9Q2YiJKRS5E=;
        b=rnD+gDsGxQt6UEzIj2Dyt9w+KJlR+0xenfRK559lFEdrmQ5l0mW3mVSSPPDkbUVYeK
         ep9hahwBKxSdlhrk29RwHSiFR/EOKXaP0yNDNSrFJGibTQSS8ekzPBRhl9PNB2Qcb5Rh
         OMHJRDba10ihEuoIof9q8qwndQADOoksEi6HxqH9gz1g13Os3cr/zuE30lqNvAh4iSyz
         WC5e/c9NTNrCQJIyFbiHJKUV0RykBm1mxEeGjH9YKJyBEIQ/cElRroUsGDT3FGT30vXi
         GXNlgWEj1nsUPoqJebQuq1N78/58XNpGD2jmQYaFmwE8wOdcurf0rkuxkaeIEBjDHThC
         eAfA==
X-Gm-Message-State: AOJu0YxD741JPfVY39/53PV5eN9KYkfGw8d77ggHyTYNsXYhXjCwUv/c
	rIzQJKlscLJYFsf8OnI6mH0sL5FCmdwTaXduuzgouLMjTt+x01OdYdfYnygGXC+ETO1JqdzOenM
	LxSy8VgfwZaVjsAiPmzFq9V0jmUQq47qx2xvscfs=
X-Gm-Gg: ASbGncvCptawU+h8452vqtKna4SrnWJZv79KIEfedg+lOdZ4+RvmIQdUPRD/WMBGNQJ
	MikJNJ4g2Z+zm0T0uOF0vF8iZJQdCx1RSD/WSGJCzGos97qQ+Y8FhfwkT6tPP2lPYNZUwurZt4z
	3SXMbW8pijtNGa3ISVNo7kGw2GQSzyVb6793MSYIFKSbaxWFwHREzO21t9zIpYH947ZanOpNy9K
	lHEY6zB5MpHR2DOhYbxGyDOe3H04Wtj1vEW+wDcsuUBlNnK2BXpIpW4
X-Google-Smtp-Source: AGHT+IFZgkWorpU3Q6es4xCgIXi46gAiHWITurdKHkUmnlHK9M87BfBnb/9U9ioKtAvVOYAIjg2t6iD/2iMVnwuJsJk=
X-Received: by 2002:a2e:a987:0:b0:336:69fb:1e14 with SMTP id
 38308e7fff4ca-33669fb1f71mr22033271fa.10.1756226235288; Tue, 26 Aug 2025
 09:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
 <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
 <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com>
 <CAGFh025kOatLYjLrBMzrFQQG0oQHZQ-4=U-d0Nky780HrrOPhw@mail.gmail.com>
 <CABBYNZKN3PwV4XPM3=7t_1-+=m1nAmEVcZ9UB0yfgks45vnOXg@mail.gmail.com>
 <CAGFh026t_ba4x48ZQqhKnBxkQC=uLF5O8vHx--c_fxJTS1b=pg@mail.gmail.com>
 <CABBYNZLHWsNXWRXn4CyK9yOQ6=TosuFMz=NQ6FPBk+_tu63shA@mail.gmail.com> <CAGFh027-mBYt-6DYLcxV8S_qXH2javvkyK56J7Lo4_9mGeKe=Q@mail.gmail.com>
In-Reply-To: <CAGFh027-mBYt-6DYLcxV8S_qXH2javvkyK56J7Lo4_9mGeKe=Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Aug 2025 12:36:57 -0400
X-Gm-Features: Ac12FXyW9KRolAy_fE0HW97ohWfz7Y44IA-QYIWvXN8vxfhs3O_gkC-SgbYB_Nk
Message-ID: <CABBYNZLmTCh_mn7w6U31B82cBZsmLaj92dxwfK9PVWZeMqk54Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Tue, Aug 26, 2025 at 12:23=E2=80=AFPM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > Great, do you care to respin the patch with the above changes?
>
> But, I'm not the author of these changes any more. It's not a minor
> post-code review change but a different approach. If you really want I
> can reupload it with your changes, but the proper way (from the
> authorship point of view) is that you will submit this patch as yours
> :)

Who develop it is not that important, and in the end I will have to
add my Signed-off-by anyway when applying these changes and you should
definitely appear on it, even if it is just with Tested-by, that said
now I realize we may want to rewrite the commit description as well
since with this we are now able to detect extra bytes sent by the
controller.



--=20
Luiz Augusto von Dentz
