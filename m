Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F412D9ECB
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774040631; cv=none; b=UL5KV+F0ejOxaG29v19+pnqjELa+9gxdNZlRB72fgWH1yjPjIsPAZUWDQe07x2xyGAXIuBuLL8tHz1YjPiQ+z6vwcr1ONKXt7FXZx8zkXf75NT227jfQDbkNmvmaeRK7lbDdZhmErl4TcLZpFt3rIiuzoRzD/ujXxyg8jACS4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774040631; c=relaxed/simple;
	bh=gz4z96j/kUq36nMix7l3YS85cXEqJghag0WF37XT8DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6wh+B/JkP/Cf/vQyvItop30FD1csJVr9NF36DZBRnmVqwAHTCwODu5n5MoKclBPMYFTbcChyGq9W3v8K291yzJigmft5w+d9Ek9POqtBnMC2LEBzpP6C1rfBBEU0E8VGw6haOFg/RHLVAJiZFxd70ckXDg5dVlwt6YDglxATkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SrHTcttn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SrHTcttn"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b97ed4ad579so183416766b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774040628; x=1774645428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RfykHQROXEayv7l3WCeAk4a6XCvf0bpEMNKpRypCktg=;
        b=SrHTcttnrQfQ/Fg5GcNWEUnh6/4mOwP/uX9vDfrCn/EoOJIBWAwWZwH6jxLxEJl6QE
         yFuiPy+FGbCbdQ/0zQ9NN9jLsOAwULJ+c1uBzIoSH23xvewplzjFOj/p97kWR2xndGg3
         wVydzvaLdr8M7jirAMenis50bDqSNEqQ7tfww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774040628; x=1774645428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfykHQROXEayv7l3WCeAk4a6XCvf0bpEMNKpRypCktg=;
        b=c7ukMNOEaFV5gel75fdkBjJ1ymzJIoYBfgeqRICI8zz4RV1IiprAb+uT4SWuCQfyS4
         FfMhPj5qUFQo11pZ6E02cNVhfkoFPLs+nd4YTTU1x/80A6cMfdB5tTZf7/qUb0T4Cpnh
         Rm8C8xH1hQl+9ywNbl3dNB2rnjXhKI0dRr6qvLI1Gi1cWNoCvAd1Aw7W6+Y83o1j4XEX
         eodW47yZqbwyzZn59shfyqtwXrvtnyWjeuWgjGwIdJD04kUlFuDdixBvheejtqcM8sFs
         q42SGUB5YBsSWlkwuRifn67hSzKmlgDNUyDCZATtMdvcYuXxZQAD6D9ML59ovMDgcYfe
         WCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1iQ9x3yvBEoYfHHDQjH+RefsrPCtr1fIoFl0nNK9f2W6Fhnti+4rsIAarFyDX+a1mQQD6qMj2GOtCdTWoV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7c3oJqy+pBfjdSKOQ/3ERvSJHAgHAC0uNDtJDnXY9TTOkJZv
	4O14WjJKDNosZD2dYpCRPu5vfAMHAQUb5gsDxW5jsWaKqChDpD3/FUZetoYqNUtWDJpZ8UQAmAh
	ipdJ8Cdg=
X-Gm-Gg: ATEYQzzsjqwGksoXmWJqcZfl+1Lhle9FvJA154/ZyWbaS5NPnb0sg6nMFS30URh1UBS
	0B2cfc5YseccarfxrBtjvLZjwP4+KSsPNHszJ4ToC4cP6IY41BXFA6/mdypskquZW6pgvS3b171
	bR0VjbpzuLuuzTK8kIVZNPk9DgcBRdx+Apm7kBcmlN8vlbInkZTRI73hScdur1Z5UPv2g1Lz3cR
	9yL3OHjNLnanpOjlwwunuXiIv4eQJr0ELJ2EkfwUl3hul7jV/q+/ttHCHoG4D33nOAhv8nKD0GU
	v7WuM+e6ANILR34Z0/trOl0uuhEFOO2Bt4TwcKZ6OyncgC6lZjaQut3im4wHJPWk5QCeHhUFpAV
	Ggkt6Qie8HEM7ktPMY2aDu5yhonvpnsr+Wz1VIrVtIvJRVykSCDd3Xw/OOauI0CHb5Iltx/J/50
	TZfStS6ZGIDZXl+GvFbPEhv1R8vfPigubO96Txo7J68rj0Li5XnzJSNThA9fVJBApUWdZT4vrUQ
	ODBLO45gLI=
X-Received: by 2002:a17:906:94a:b0:b96:ef3a:4709 with SMTP id a640c23a62f3a-b982f362b8amr282331666b.34.1774040627651;
        Fri, 20 Mar 2026 14:03:47 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335de1e3sm190891166b.39.2026.03.20.14.03.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 14:03:46 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-668abc98923so1896032a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 14:03:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1D/Ryt9Z+XynmV9tnxUWKYunRdZkomaw5uQwkj1ROvpXnMrWstPpSEEi1aMYVxlh3NS1LgLWW9B+clL6Zoh0=@vger.kernel.org
X-Received: by 2002:a05:6402:278c:b0:666:725b:b660 with SMTP id
 4fb4d7f45d1cf-668ca31fe2cmr3173661a12.30.1774040626571; Fri, 20 Mar 2026
 14:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
In-Reply-To: <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Mar 2026 14:03:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
X-Gm-Features: AaiRm50M8NUw_PkbhBRYCMaCqWtNi1uA19DPteegykkyQpXcCTwtsupjkqHhJK0
Message-ID: <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 11:02, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Bluetooth regressions are normally device-specific, though. In this
> case, the regression was introduced to pass a new Bluetooth
> Qualification test, so we would have to weigh what is more important:
> compliance or interoperability?

What?

That's nonsensical.

Compliance with some paper standard or artificial test is *COMPLETELY*
irrelevant in the face of an actual user experience regression.

Because when reality and theory collide, theory goes out the window.

There's no "weighing what is more important". None. Users are a
million times more important than specs or tests.

And yes, the world is full of hardware that is not actually compliant
with various standards that it's _supposed_ to be compliant with.

That hardware may admittedly often not be great, and we may all wish
that it didn't exist, but hey, that's the thing about reality: it's
often messy.

And sometimes it's the standard that is wrong.

> I can't remove a valid compliance fix just because
> a user (later more appeared which raized the severity) said his device
> stopped working.

Of course you can.

The test or the standard may be entirely invalid. Not unheard of.

But even more common is that the "fix" that made the test work may
simply be wrong.

Because that "fix some case, break something else" is in a fairly
common pattern.  And that just makes the fix invalid and buggy.

And we have a hard rule on regressions exactly BECAUSE of that
situation: having a "fix one thing, break another" is what the
suspend/resume code had for years and years.

The constant "one step forward, two steps back" dance was what made us
have that hard rule about regressions, because it's better to have a
stable base with known problems - that you can perhaps document - than
have a base where the problems just shift around like quicksand and
users are understandably nervous about upgrading their system, because
they never know if the end result works or not.

So the whole "it's a fix so we can't remove it" is simple not a valid
argument. It's absolutely wrong. Because a fix that causes regressions
is BY DEFINITION not a fix at all.

                Linus
