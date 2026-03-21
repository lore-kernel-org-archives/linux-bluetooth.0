Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C32D5937
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119041; cv=pass; b=ngoS+0IBo6c5kBdwcXqW4FsEbr7ErUG4sn7zLJrtxZbOEQaapuPUXT3vyyy+pxook3yvqnYLJnpUrWsthWCAH9gx7B+rbXVXg6gtzVklpkCGh8MtuGJA+w/FL8bAPD3wxHzc5IygNEgQreabZNlOm6H6dZ4Mysl7yfJESrp+5B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119041; c=relaxed/simple;
	bh=+0No1nOe3K8acpsovC+eRn2fpHxV0wIVdlMJvNTeFzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcrzaR3/QqIKX/JJ6yRkEJwdhYhimyvpviImnlC9jt/u9tvH5QJq7GGoFGVi/KR2V4GClajCJN53iKCvHBewkVMTb0qhj86g1cnGUERgvPV5AzvNAtI8DHTTRtTPzK87jU36kwuqlZn/V4qDZpF6tfg+cqJQ6H8eTup7ncqLu48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwOAGa6f; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwOAGa6f"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64e9f9226a7so2512496d50.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 11:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774119039; cv=none;
        d=google.com; s=arc-20240605;
        b=Rr3E1wPtNvAg2a9tDMPpkQ04cJ8hUujqUzmrKswff/61Df0O40hdAiAWcvjN2bWSpL
         Qt7XtQALgQIq0RU4wzF41U0ZRo1PAVaJSKKd4JDouKSJAyRiuvhaTtcbAPKxxkf9FYex
         Zpj713YwYWU9L1vBwRdMIpCAijQBCVQD3NCv43dvSVCCuhas/MqwqyyyPYDyp3Rsf261
         II9y5UY0Jpf9osQcFXBCSnX0a2bFoIOVmo02cWFt/8oHyvPQlzKXDMGgqJe9+e1Dx7mc
         VVajwRcnGDlfYEwBWG+PaPGQOAtD+WMkSInV0WnHlo4Zg+xSmbMan+VRttz5V0cTr3G9
         5PIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9kUzADYXy/NGXQSWeaYXgTqQSK+6xS5PfeQEuXgpkVs=;
        fh=GUIvuyIAYbVD3FGWUy9y9X9RQ1xi4VC9LC+Zp9w+t4M=;
        b=QPCBpn0+qBtIt5/8ezNqhuIsG3RGOiBuguQykAOuiXse/XcYoiXLPJM4PBf/9idoHL
         K2/bObqx8yayDRe8wq2NhBqDBBk2AmhLpnq/+l9ABlACYMS4U2RRvaxAI9i84c2RD1lV
         nk9N55Q85rr2P61lpemYSE+D0AZv8gvNtFhq9p9jMpTbEcpr6vfGgjhod2pmiSNw2phX
         1aF+2NF89eK722sd5e7TfQlRWs3Avk1sSJnm3YfVZyIDjhZH4c5YSJjeYP12XidL1NI6
         no6alWQ+EMKsxZO7dCcbJZdv+cegm593cF5mYnNUZ8YNsZduobNqierd4OnTPMIuCbbO
         iDHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774119039; x=1774723839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kUzADYXy/NGXQSWeaYXgTqQSK+6xS5PfeQEuXgpkVs=;
        b=gwOAGa6frfrfo1I1NCI2qE5kPq1Tlv+5/gAp6XUSPW315zVK6bWYjg7y6IM2aLQMgW
         gtOEggGT/G7sZXCQaNb93t1SFxZGsqGMS2b0SDyfvhvxAtJs4kKPnO6BeFBYxUJuU+3n
         l5iLkayGUDJrNFPLTIWxA2FIdqgkdC+a6bXyN33QhzwM/sp3xiEg8ASO5rpZqQx6mnIt
         vhRRnyEpM5OWPES80pg9GqrAt1OzqTAhZ9vu3+0oksOj/0KczXl+S6YAw6aI3PIVwK9C
         GL1OfhunjkP2ODJnZOBxf23o9BCRLvJagtMjj7QfFL6kardj84Fdck0hXp2ARP3+eHba
         ahIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774119039; x=1774723839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kUzADYXy/NGXQSWeaYXgTqQSK+6xS5PfeQEuXgpkVs=;
        b=WkUqs4yNqhn6tXk4vtzGws6RYvkfg4NXRbiiE+cIM3u5SDF/YfN3sgqYkD4MGvcexp
         Ol6nALObJxuCJQFmcT9wqMglT96YsvVHlDUpW6BgOKKTT3i//wDdnZAYuWBWX3d9occG
         ZHAUNyGUv5bnGX8pglPY5ccmemd7R7TuDMr8k+g1o0GRPzSqPYuTdiGP9AzKCJ52qUHg
         lpTErdbg4W/3ApwrZruVurHNyVFRmLziZS2V9EDa2gZzfrKFQFAj6disZBPQC5vtBE3i
         WgeIltHpfNJq2J3JJU0K1R1CHQC8TiUMaVZzi+YhF8cs+0SXpK2zrJY6qor5yl7i1+pa
         mC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUynWP5ubZZ0mZ+s6/WpYk0KQ4xkmXtWHDe5XHi3vWdv8iFVVj9/hS9YvlFsX4nPguAIBxAfu5hXmMSYAjm988=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXexFH6JNc4ZxkD09xFzT0s/Lef1ED3AA0tppKqsiKGLxfLExW
	4Q5Jxs6O7Er8i0d6mQzomR7/cq7udyT9g9w4h+1MIqrrI8VKhhZazUYBqqaQr+XZH+iA31LkQpk
	Aa60XCdNYKBYNrAtxdmXAe0+Agukr2LI=
X-Gm-Gg: ATEYQzxr5eHoDqDoUgJlg96nACudLIl/1rxOqJBFl28xavO1LP0f/HfptgCAmwpUXda
	i/wtiKQGfWbQEVWzsukV4RM+Vv7XN1dGKg/PpQ9KFZ4CO2BeATPc/EI6sd/by6ssdQA+TJYl8pN
	DrpFHfvpG2RoDrU5h/D9YaC7YSL9DJcbxY8RXUoIOlOFQXSiVRryEir1+HiBeIWNgrjxE6Vle/5
	F3yQTmoKQezbALth+Ltej7vCaPqlY9PLneZx5cHVjfioabbh8XXgp8b72qMUaaMl74m2zwdolnu
	z8jR9n4EYNe4GAoyUBUJnRlioFSdZSSgaOejnMfZYz1gP/qOVZeQd/AY55te5tJ767R2HQ==
X-Received: by 2002:a05:690e:3cf:b0:64a:f138:3172 with SMTP id
 956f58d0204a3-64eaa7f1428mr5525702d50.59.1774119039521; Sat, 21 Mar 2026
 11:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
 <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com> <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 21 Mar 2026 14:50:28 -0400
X-Gm-Features: AaiRm51cGXYHCRKZ4R7legIePMrTOfuHm9IjRv6oMxOWqE8F-4Vc5HcbG73sqko
Message-ID: <CABBYNZ+YC43qvRQb7-KXv-EJ=s1Bhdf-Xu1xeEZVuzq96R7NTA@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Fri, Mar 20, 2026 at 5:19=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 20 Mar 2026 at 14:03, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > That hardware may admittedly often not be great, and we may all wish
> > that it didn't exist, but hey, that's the thing about reality: it's
> > often messy.
>
> Of course, the thing about "reality is often messy" is that then you
> end up with the truly conflicting situations where there are other
> complications: security issues can sometimes mean that you *really*
> can't just revert a regression fix, because while paper standards and
> artificial tests are relatively worthless (compared to a user
> regression report), a severe security problem obviously isn't...
>
> Also, if the regression reports then come in late, people may have
> started relying on the new behavior, and reverting things then causes
> its own set of regressions.
>
> But when you get a regression report quickly during the early -rc
> period, that tends to mean that it's either a really bad fix, or it's
> just a very common piece of bad hardware (or a shared bug across many
> different hw implementations - which obviously is often then due to
> some common chip or firmware implementation or whatever)

While I agree specs sometimes tend to be worthless they sort of guide
future implementations, so in the end it is not always black or white.
Anyway, since this escalated rather quickly I think next time I'll
just revert and work out the situation on bluetooth-next, rather than
trying to access with the reporter and risk  delaying a fix.


--=20
Luiz Augusto von Dentz
