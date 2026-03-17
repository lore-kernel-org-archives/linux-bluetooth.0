Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E89384244
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780338; cv=pass; b=fz6OFfjSSM0YXU6FAGuVXAqBnoDZu8WO+MQSHlr5D+HbY8TtY/U9pq5M0yUT348atEuNRKEcBqeHL4jBdM5lq/rStX4fdK6SzbU0dIaEgOkmhdNRJ3I9XEwK19PSmRKjgg3dcH/BSo9PN4bCmtz0oGxmiMuhciVBh2oqkascdbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780338; c=relaxed/simple;
	bh=508WZbpIZy5IPV0CpnyQwnfFwGRNa+N20CdCla3pV8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9lSReApjYfPjbqUN+rXYfHwIddlkKdBjENXv0pcm2I+tlFjvfEyBx+NU1UxjfKUZCKMo7PKvFRbFY6EWS3g3ZtCXanJXXmZlAuk8KG7I8yooWwSATU7tKDi3CXgL/RcmnYdxRnpvkFXSAGq5QmFSiek6e/jTbjwyE+Cc1P0rxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JchGP02I; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JchGP02I"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64e8cdafeffso491121d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 13:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780336; cv=none;
        d=google.com; s=arc-20240605;
        b=MRYcQkAfyWXsZfyQ/7dAG9w/B5Pxgz8Rmma1k8QIvgX4ANIxnmld0XuGL/y9M8f88W
         Euad7ZZ6Fki9ScdVEh2pWBcz0ufXtLiBYu5UULb9Jc+rc5bBkDeg3v5bMe0tktYptAfD
         /Nz1xEoqRt2j51gB0IwwVEBpbLNNoIGFz8Uh5iWdWMLg6D7NS05nIXUeoOajO6L3QQko
         W17HT7r6Oi/SXaRqtAS51B2pwKZC5W1sQDrb6B1CdQwwOygKaPVEG+Pq++5QaPRfOABp
         ZlJeZHFv2dYWypDpy0QQaGbfX9W8hLMSqcVfuhOMrJPqquIA3q3bjElvtPJJlRrjLqMf
         ClIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=508WZbpIZy5IPV0CpnyQwnfFwGRNa+N20CdCla3pV8Y=;
        fh=spUOYZUyymKh3AtHS+gMnpmv5YcoOohdIpdaqMwgR+8=;
        b=d9NR2CaJd4pMpRhUIVHvQwTADm8isv99UyVL+gKILjrW4yTiUNZeQwkI5RF4ow70Rk
         4pHXdMzHBaxVYvMGs/sruKBzV65+vTdHYlm9FFo/leCThb4Ucsjca79Gu59bAwrfjR6h
         G2/MvkDx+5grf/5Bih3fNkmuXGdyhtqV9o4S5v8HdUHeObZofhNJafhsFwVm5czg1gJD
         Wh9UImPZUR5u7lk0DUtb6PHZoXIeow0eWDFD49+kR17ok9B4OqqqMxSstybUEkiQSHPO
         Og6g0IFYtdN+e8OLwcrflQXGFplAUiJlOoIaCEYot6emWvMUymqFH7cjLVp0Uip/glXQ
         chzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773780336; x=1774385136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=508WZbpIZy5IPV0CpnyQwnfFwGRNa+N20CdCla3pV8Y=;
        b=JchGP02IlUYHQKELetDxPFG6MFJYM2OOlsa2cV4R6jNgNAPHYBCAjl3p+rYX4RaOPo
         lVzMhq3Q70kwQEuwSLiGSn7TXVCiHfamsBTUuGVcpUmf2iNvnfKbPfNNGtdGQCtDPfwn
         jN9yqfCYxsGiXogNvqFGEwZWZYi20IbndPwVFZ8ZRk9rr6QniEoB3C4yc8EemA+4V/Cl
         9DOz6WZQPbtlGvY/DJA4J5zMG1iQQP8OaeuGvwO7C3tl92IBZFeQgapXkWg+QDMcoWju
         khxeHqc2YyJ4T3qy8SXT2gu7+YBs+cPydCzbOG5GGThEHppAPk1AVcVR08iv/AuzRpo1
         xFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773780336; x=1774385136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=508WZbpIZy5IPV0CpnyQwnfFwGRNa+N20CdCla3pV8Y=;
        b=FytGHRrPm4kIU4S7TXK90kUYVo5QFBXSt5bC27lKEfh6wQ0a/YmFPJ1VDFgGO7iy89
         8D9xY+1GSFA2RmourrbiJ1qM9ciNr2bzVCp5cILh+txyZ3YVUozAAd8ay4mxT8uQdqxl
         LHIlwXtLo9ZAB1LStRBZAatXCpN0dR4Ki5KvTo1aWHwRP6xcAUE88W3vXpyOn4KfBr6y
         P9zmQMjEQntJGa+8pE6C6GUmJ/j/pVO9O8pP3YaANp/m2tO3TQ+pk22i6vvK0Abj05Ds
         RcAmNmjYoNmIdg9GhHZu25kJVK0n+oAH3Fay/swcffjHGAZDEXPBqxESfdP3ubyUb4CF
         0fFg==
X-Forwarded-Encrypted: i=1; AJvYcCU5nN+Rmg6YNcN0b1JU2tQsnKEogUdg0Wr/rrXKnLX7EmQXpKlikEh+u2/VGw+1ojK/lYg0C74ndZ4/X10GVm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0O8jHaIjdf1HxK/kqB1UazF2W/+NNpJEk6JXLmxU/Gnw0Kj8
	/41gbhRh/cZZL2Kv7QzaoQw1bBZeV8uk4UVJE5GJZPD5qYSJ1S4AgsynsU7pJ1ABi8RGLiOh17Z
	kcxU7osrC6nvvFmPhFkMo1j/I3IDkG3M=
X-Gm-Gg: ATEYQzwPjF94HWBWkMmfRHa/9q1bh0fon+qq/x/FbvmX9q574bk1eiKh/DCCsDcVGG+
	Y6i491FDD3rKwx2pKUPJjkNGs31I4mYbujWAYypL7Qas1/bxZr58ZWr06uXPMPyqA5nv6zjDPFA
	dw7gwjdlx2reT2bIjDVJEXHGs/3UjnFshXTRaf6CsTn/fXUqSzgKRi/UksNXuN7uN0QXDTI5GQG
	kZ2thwBu1mpGHKLfgEUwPKRcQ+eofKfzVw26QxXx9mPg1zL0Fgha2HsffFwOKjv7gNe3kFGtwpN
	cbgULcSQpThYpRxEFgMnNthZbY7usjT/IljYhUC8WMw57nhXUX4eE/cJXDWakkbJxHk=
X-Received: by 2002:a53:a0c9:0:b0:644:59ed:dba3 with SMTP id
 956f58d0204a3-64e88ae8608mr3628225d50.30.1773780335764; Tue, 17 Mar 2026
 13:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
 <20260314094707.105683b1@kernel.org> <CABBYNZJo0aZW1p1YqyKNDWURunAHxZcS8B86OZGstfgWr0S58A@mail.gmail.com>
 <20260316162626.6829f49c@kernel.org>
In-Reply-To: <20260316162626.6829f49c@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Mar 2026 16:45:23 -0400
X-Gm-Features: AaiRm51Sq07q8TCRFBGRe6oIbP4lXve558SYH9gvPIMh569-Yf39T4vpvUdWTCA
Message-ID: <CABBYNZKpwwXWVi1pvksN=A2BVWh3-omsY9wJFv0CjzUbxnH9UQ@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-03-12
To: Jakub Kicinski <kuba@kernel.org>, helpdesk@kernel.org
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Helpdesk,

On Mon, Mar 16, 2026 at 7:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 16 Mar 2026 09:58:56 -0400 Luiz Augusto von Dentz wrote:
> > > FWIW this is what our AI had to say about the series, mostly nit pick=
s
> > > but not all (LMK if you want me to hook the AI reviewer up to your
> > > patchwork):
> >
> > Sure, I like to receive reviews of that, note though that
> > linux-bluetooth and patchwork are for both kernel and userspace, so we
> > may need so quirks for detecting if a set is for kernel or userspace.
>
> I think similar thing happens for iouring.
> The user space patches just fail to apply and the LLM doesn't run.
> If that's alright with you please ask helpdesk@ to give the "nipa"
> user permissions to post checks to your patchwork instance and LMK
> when ready, I'll hook it up.

Can you guys help me with the above?


--=20
Luiz Augusto von Dentz
