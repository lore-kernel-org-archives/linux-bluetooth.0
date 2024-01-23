Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238035F565
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018403; cv=none; b=Yj4rHH8ItKsLuZJ/OdxZgV0iu4g1g6VOU8zfniQEAFdJa2SQhLrsiJg7768KqUd7VJLB6dkqiNq2U1NDz2NVhar9by0gR97lwysnOU/pvO4cy58Brn3IphCJQo/OVyJSEkVlG+ABEYDsu8O9ox7Kk0rSVufQ/RrDggsvyilR8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018403; c=relaxed/simple;
	bh=wRvKrnECLOTYE+ROQ1lO5Y053zNVJJw8BmenNzEEXVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWrXLGA11qLphg3I17jQPWtMDrAPg27V1QpjaDgj3Ez79BGLWPTsdAIUW4yx8fMjaGxennQF7+FH094EjjFV2Lrs6HTcgvZMO+XIYlg9J6tu2EfLesMfHdYmnuApDHdV8P/RYuv89nIV1EquJ5+4QPnicaHMWPK6xJFYmYBzeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3xxzHqm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3xxzHqm"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf0390eddbso19535921fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 06:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706018400; x=1706623200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIqVHSZXgUD4j2ZeCBPPySeUkzoUyfA4rRYypz6t45U=;
        b=I3xxzHqm0a9TdTOdTaK8D5Cf2waeDHMtrjidDWOfZU59vX4AMxUiMB7Crg9MvGcdWb
         dwuneGm/60VzjWYWLDi4Rdz5Sp8bDtP9a3/J4fJgsnwtLhS9JL6rjhuS6f26dCldEYrP
         PsvBXva+GGJ7hwRzdqT7a8z2dA0Wds+kofJg/axWHqsaaYTU+e90OSkTvHV2taoiQbvG
         7x6qX+1Hr5wd0r2+YGhtIgsJEo1ML+y3XCp/VqJPv2VDgy22aTIdzfrd8OKsFpZL+2LI
         lJBvOA5AXDMB5F2Pzk+Xs8Gb9bBf68Tnp5sYeUEpU76uGQPW5kIg01Rr280G8kG9OsEe
         IedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018400; x=1706623200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIqVHSZXgUD4j2ZeCBPPySeUkzoUyfA4rRYypz6t45U=;
        b=ehWvY4NYNKKlBzGbPdub+Bl3QXyIooj1b0DriRZ9upJHfi3zHnM3mWldICbJuH3xRL
         /mmduChDW831E/9NJK9TYV4zzllv7a0DIN2evg8oktKEW4r6/DJDmPDi65Q6cYy2hK6t
         Tmg9eyI8GrseB5iI+olF9RtiRJTJN4wczDxiwHY3WTKQRtKVdYF0pBa76rZcpp4WJjlo
         nFlSoIpmfuqExFwmu/bYQumy6v0DGyTzkdTHCBAfcbVCBkHUSxVCpqpKBIqniLMFVKFT
         43MImcBRyDS9wa4P4rmaDgYXDD4YY93y3o74wVvAAH+1dgitOpRtWlr0RMDL4L3K92pY
         rk8w==
X-Gm-Message-State: AOJu0Yztgm3E6mBqrvj+3sJZkDgGpHgn/zxib4JQTIizjiCZcszfO4K9
	khIkSVgKWl3swUm1f0Haj8aaGOeJBfkQNcjOJuSMqGJrRCK3Y3Z3yXzp087uXgJbciOY/JK15+s
	knXqst0/s7wqSSMOJDrJk74Aw+Ig=
X-Google-Smtp-Source: AGHT+IHGWER7INI+NoH19zFlaUU70Nn5uyjgnb9SWRrNE++yfJlVw5HkTSR72U0bYdC1vxpdr322rQwx1pFsv874lXo=
X-Received: by 2002:a05:651c:4cf:b0:2cd:ef2c:b436 with SMTP id
 e15-20020a05651c04cf00b002cdef2cb436mr3630687lji.18.1706018399826; Tue, 23
 Jan 2024 05:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com>
 <CABBYNZKv+KFAAY-5-LwMdYKDHKtyh3BRbigUv06h_ZBLJPQobQ@mail.gmail.com> <CACvgo535rjwHh1J+kX8L8wYrgZJ0ui4DaLsjDqtptm5XU8dSHw@mail.gmail.com>
In-Reply-To: <CACvgo535rjwHh1J+kX8L8wYrgZJ0ui4DaLsjDqtptm5XU8dSHw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jan 2024 08:59:47 -0500
Message-ID: <CABBYNZKgnVd80m0tkrVtMaKO8Ba+rnXk9CUawCrsa9uLuV7W-A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/8] Remove support for external plugins
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Tue, Jan 23, 2024 at 8:54=E2=80=AFAM Emil Velikov <emil.l.velikov@gmail.=
com> wrote:
>
> On Mon, 22 Jan 2024 at 18:35, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Emil,
> >
> > On Tue, Jan 16, 2024 at 9:19=E2=80=AFAM Emil Velikov via B4 Relay
> > <devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
> > >
> > > Greetings one and all,
> > >
> > > In this series, we prune support for external plugins and cleanup the
> > > associated code. The inspiration here is multiple-fold:
> > >  - the plugins are under linked - generally a bad idea
> > >  - the plugins use undefined, unscoped, unversioned internal API
> > >  - the main daemons expose their internal API increasing their size
> >
> > Im not so sure I want to remove the external plugins support
> > completely, but I do understand that normally distros don't really
> > want to have it enabled in production due to the reasons mentioned
> > above, but I think we could find a middle ground here by disabling it
> > by default but still let systems to re-enable it if they have some
> > custom plugin that they may still want to use as external plugin.
> >
>
> Thanks for the feedback. Sure, I can convert this to a "configure
> --support-external-plugins", where all the presently removed code will
> be compiled out.
>
> Still not entirely sure how external plugins are supposed to work,
> considering the API/ABI mentioned earlier - any pointers? Do you know
> of any example plugins that you can mention?

Not really, well just the sixaxis but that can be converted to be
built-in, but that being external means that there could be external
plugins we don't know about thus why I think we would be better to
have a flag to re-enable them just in case. Anyway I think for sixaxis
we could just have it as built-in since it seems popular enough with
the likes of steam deck, etc.

> -Emil



--=20
Luiz Augusto von Dentz
