Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460D365A00
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240990; cv=none; b=WvtDuniu5ph1+KuzP0f9aXXbZ5KEtCTEkAEEtUxcsVWiJfMlD2bOEZiX5KMAK/g9+BAgHu5I00ExG+mtIj+r03K5BxOW6uFIDs8NTUFPzXTYeCBZj5vOi4yjfGqchq9iCg0E6HLdd3Ecqc/xuZV/3a0pxc2DcHcsKGvBb18chWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240990; c=relaxed/simple;
	bh=24Dn8UqRZ1p8BQICezHYOo9NJl5h5GUSnVLscYJARrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqkN1iMxkck/PLPAr16MgnmPFH6NI5iu0Lr10jWJHwA026CFvZ2JYBdRiSuolbiw5sVLb0r0wfnDhqRKsN3qIHdJrVhnSUzCz8liwJMV7Hn6tgdzOXCuU0dbhgoFJeRIigDtIE3Mc6mV4Ir8zhHv1CszBdqbNN3iZPPNrCkXk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P1rC2xKg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P1rC2xKg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c029505b389so230353766b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782240988; x=1782845788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTYMiI8T7qy3LqZCJa3jMkJNbrBL8JjUNCpZXVETjNU=;
        b=P1rC2xKgIfv1C7HAeG67IQX0uA11r56+jg95zHeion9XESiVGv9pzhlHQE8vXMGeJQ
         mEubM7UVwMu3Etn9+tV+WLABv9ZMlbo5KxxsJPEmVjg+zMmV/rtCa4UgUC0Iav8WO7vk
         ssw17MJZXFxwE/rBj46DKsZdD32Ahj1P0jVN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240988; x=1782845788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTYMiI8T7qy3LqZCJa3jMkJNbrBL8JjUNCpZXVETjNU=;
        b=QalZ7LnqNVahGqaYk/9HGUgEk16YpCYPPwfOXxQ2zqqJY9O4RApD4zVQocZ/ZMJSyS
         WSptQVCgKqWGbBechyNQqX6s8rxxoL8lYF9S1pJELkIMayCy5tVlOT/qImQcRjnjJE78
         +uqqsNKCMVNxdDUNWU9MbK0M7wEDVcdkHoOdD7tgKpy5pndmS8+0rZiKeqSjpmxRaOtM
         0SAs/jx8DeKtLMcgWyNiG/Ih3laxl3FMD0pG3Hk5oCNVSnnuoGrI1lkABOmd4xnctdGS
         JRnfTZTTydSDebyxQGAsb8M+Dd/HvHCb5RMrKsAIXYC5Ex0YKe+uHo56PJlllZJmYFqn
         DFTw==
X-Forwarded-Encrypted: i=1; AFNElJ8IEBSZnJEMrDLtc83yq3vIeEb6ZNtU1Lg3uaxNG6syHkIiKo2lvldCzrBa7FEaqzQtkHFy3DX9bJtPhXydFgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/mBTFhdk/olGcNPG+0W1puzJE5dEKMFDddrY8EcQRTOSUS1L
	ZpvpZlcDCxKyH91+dJXwLxtiANR0nLvFzV82G+8HBnKNalfpCGsR9KtMG4BCYXuhr5UnBpO5Xb3
	tO6IP0rI=
X-Gm-Gg: AfdE7clGzYpEwscQqfhmeucSaXEdGNJ/ueefDkbepPGx9gzfrXZuDQ37z/GuTEr0F+Y
	ZcHpP0mceQkl4AVdEYVuK67RUB5tZd47dkNiSeTmRpurpn2u6F8s3r0UspWgDTLmjioJl448xdk
	uXy5g/E/EGvFXn9C+oIxHQ1a1OOIRo/M4WBq/qiyMPBqvS/N2F1SwC0//WXVvZucJok5O3Np/ok
	j+36wVWufXc0XpUbY0WDWLtM5bKcCysSzTRl3WbAOs42+xxbcbYXkThC62hcpJR74hYSUm29/aq
	LUrsgyMSJjKo6dEpA+FDQf3TUk3GO/7EwGxO2kep4uJH0DvZX0pSnzzpLrUZnd8cNBZNUcEtxTj
	xfp/TQg2ft4b7koWcTtrzwdmZntOweq1JI25W3NW/qqFM899ZAe6AsU24Tdhs4St5+sp50H20d+
	6aqEWIUw/VX8dxdK/nXu2aovd7sPjlcVqaJMDY64VbQVN1v+woySJtFS3oXCzo0g==
X-Received: by 2002:a17:906:1c14:b0:bf2:6d61:3268 with SMTP id a640c23a62f3a-c1031979c6fmr191432066b.23.1782240988051;
        Tue, 23 Jun 2026 11:56:28 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99b968sm550556866b.24.2026.06.23.11.56.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 11:56:27 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c074142cf6dso194725566b.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2026 11:56:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/3s+DbL089Qe9tmhZQYbYx7S2A0aQZuID4ZLiSlhWat+C3Z6FJEvwjsnLsCcvU97dt7fmFPsYq9sqO+1dTy1w=@vger.kernel.org
X-Received: by 2002:a17:907:c207:b0:c11:8357:40f with SMTP id
 a640c23a62f3a-c11835704bfmr15229166b.2.1782240986490; Tue, 23 Jun 2026
 11:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430011544.31823-1-ebiggers@kernel.org> <7d08a6df54279e9915f5df6bd4e5e5dde52b4fe1.camel@hadess.net>
 <20260623164932.GA1793@sol>
In-Reply-To: <20260623164932.GA1793@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jun 2026 11:56:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNG=F3xO9PjL0RcKy3UWvq0Np9uZu+nFUQBAA8So9xdA@mail.gmail.com>
X-Gm-Features: AVVi8CdpFGqem5dP7mBI1VIDKVc8WIWTZWMdjSeug8fejnSzLkFpq4QaapJhuLo
Message-ID: <CAHk-=wgNG=F3xO9PjL0RcKy3UWvq0Np9uZu+nFUQBAA8So9xdA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-crypto@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, ell@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jun 2026 at 09:51, Eric Biggers <ebiggers@kernel.org> wrote:
>
> We're aware of that and are taking it into account in the allowlist:

Note that if we can  just unconditionally make it depend on
CAP_NET_ADMIN, that would be good - independently of any allowlist.

Because if iwd and abluetoothd are the main two users, and both of
those already require CAP_NET_ADMIN anyway...

                Linus
