Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AF282F30
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774123805; cv=none; b=MMk29b/n76BqA8TsIFQ+raUyqN/rTZj7vjkWQLb6LOoa7dVtAGz5ebTADA4EGqz7Ysu1xSDPZxmFrN0RjgyD9MiH/hdk0UAuzcH8/o6UjMLkmjF/rl+tN3XPTww2jXBy5KUz56C1iMw15H1iAxjsXctyFXnWk0Q2t+2DRuCC+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774123805; c=relaxed/simple;
	bh=E6YZjKGXl0vQfGteXdj0Drrnp5o0VeuQbS+OxjmHhlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQvNCg+90TDw3O3wXMXljD15ZfMrbENQHXDxwBybTLhPaCmSYZwbVBB4HRh5dfu8PretnX67hjIaSz9Ye2RGPOj+lPJfopd01wKPK/TmxOZOflfw4Lsu3PZcGzBEzch0nDG48hknA/ZK4cXU8Jwsxn7fhHbdUmidK9JRaAHR5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cf1Q6vsR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cf1Q6vsR"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66966a394ceso761533a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 13:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774123802; x=1774728602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+GwK8Xw0ld/TS+qhy108IyjO9LdanTTp1MLkg1Ue/FM=;
        b=cf1Q6vsRSQtLZs3ZeqDo7JCBVMSf+5rvBXzfV0rsmXsOpVN76PNNyfgZsabBuS65a/
         IIUJB7ic8z+HGyqdVLXUkvbw4UIdc13NVgLCHbqT87tyPXzdCz8dLcWnpJos3EUyu6AG
         1TDfLemK8ZK5gaClzt3DruPqRCAZdj16ArC5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774123802; x=1774728602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GwK8Xw0ld/TS+qhy108IyjO9LdanTTp1MLkg1Ue/FM=;
        b=XqfyUa698pI+mYbEvpSGjlhRv3Z3S5E1MGbyj5Ru3yzM3RaPaj0UiZoOioqia6Ccgg
         FKTxXb+faoS7PkzW0b7PFjWbDfVjy9XWzz9ucfBOb7Rp2fRB5GbdH+O+7+9FjPQZVY5f
         vPHanGj0TaBPF9rQeqmfmjcEY2VGtIfar6aJKG3A1fZMKk+jTBM18YHQDGOSlJTo4xOQ
         AHTHIYoS5HhHu9ZKaM4cTHjvzBn6fisyHExQh/abUgh6knO25BaxJbU7OH3bfbzici5J
         3W6uUcE+wLVL2TIns/VRjevMcJv3fImJXwH39Cr+/WCZFVMdBTjwQjKHU8gmIRHcQVdl
         OP1A==
X-Forwarded-Encrypted: i=1; AJvYcCVLAS5wITNecIujAA2CzpiPJKrPI4TxXSsWg3tmt0X+yfqj4lPIf+X3+Pj6SQXQCvOFmBrCHr4PF1I2nqhMqT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwiHESonAQzo/iZ7cLi86hyX1WiPCgK+YPS1oFZI3sj+G4BG36
	9NUjFZPzwgg6WHTWlq15tHwNW0y4Y3kvk5wTDqhzXQEJHQ7OmOCYZbnHcDGwgzZFABtVT4musoF
	S0scqkp8=
X-Gm-Gg: ATEYQzzb7eMSxxIu9utQMEb/X7gQDehrvT/3RjqRhqU/jdHlFjGDnqgxzNuKJ600xZ5
	V8cDLCLLjUEQzXd+Jez94pS+2lNz2s5cOUfeWO0Bmlr+QCWAtjsx6BACjHmeA2oUu2rWbOUP8IE
	hRSjxz/l2fONBBKZxGgxNrJQw3RpoHUtsxaj47tddAQMJmiFdSYffDwINT4Uj/dcq6OTaBziPCm
	X7eI+flf9WsGrJgVXlejUGyM6UaqryEPD3EArCA3l4OOhf3bGbhFY5Tt0GkN8KkEtnGnYDgmhhM
	JDN5quBuZidGQrC8N+n8OjSRXFwtiCyCLrJS2hAbEq4CEWLvEPGBenBgs2iSb0pnIehtqE0q4ff
	MMi8s4tKwwCv1w4IciFPIhSteqKNAEJ7/IX3aiOXtJcTeLXoqyHSMUMLhFBb2ZNxKLCI22LZMHb
	gMgD/pVh9RaJBhGviuWr+5ZYHtkqa+F/lw345ZfZAxQXP1RYmI8kqSQ6wY7KAEY8rp01Rs1u1w
X-Received: by 2002:a05:6402:210c:b0:665:2676:7ec4 with SMTP id 4fb4d7f45d1cf-668cd712afemr4928246a12.9.1774123801670;
        Sat, 21 Mar 2026 13:10:01 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-668cf4f89fesm2086312a12.4.2026.03.21.13.10.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 13:10:01 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6686fbdbe2eso3761746a12.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 13:10:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOR9/YuCwvDg7yBmV9CY2i16eNHOSPKrvWh1hk+iFUVHZnCdrZnEzWqd5TqvhC2r/2Va4iD+TmAItNuv0zOdg=@vger.kernel.org
X-Received: by 2002:a05:6402:4348:b0:664:3344:f9f6 with SMTP id
 4fb4d7f45d1cf-668cd70f41fmr5367138a12.8.1774123800317; Sat, 21 Mar 2026
 13:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190455.135302-1-luiz.dentz@gmail.com> <177396481128.1855248.1024090053580545012.git-patchwork-notify@kernel.org>
 <6411a735-d187-4848-b199-a0e2c2e0e52c@leemhuis.info> <CABBYNZJfLf6PzKUkGjiCvqEm3h0+3SUcxY5RNbUHv6LBdPT_zQ@mail.gmail.com>
 <CAHk-=wh8dnp1qT_CHG-Zz9H2=G1Q=0rF5SYv+YsEaPnVhznxWA@mail.gmail.com>
 <CAHk-=wgryF_COh9xzhGaJ-FAm471pn5uvqt-Z94+3ENPVu4w-Q@mail.gmail.com> <CABBYNZ+YC43qvRQb7-KXv-EJ=s1Bhdf-Xu1xeEZVuzq96R7NTA@mail.gmail.com>
In-Reply-To: <CABBYNZ+YC43qvRQb7-KXv-EJ=s1Bhdf-Xu1xeEZVuzq96R7NTA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 21 Mar 2026 13:09:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFuDumk75VTTWeXzGfCQae4=XT-k8MdYWrca5JtcMrBw@mail.gmail.com>
X-Gm-Features: AaiRm52QcLSQz7-kVNJjvtQZRDwlGBpvmJh_VBc971qisQDLSOkf7cORlWW50mo
Message-ID: <CAHk-=whFuDumk75VTTWeXzGfCQae4=XT-k8MdYWrca5JtcMrBw@mail.gmail.com>
Subject: Re: bluetooth regression fix likely to miss -rc5 (was: Re: [GIT PULL]
 bluetooth 2026-03-19)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 11:50, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Anyway, since this escalated rather quickly I think next time I'll
> just revert and work out the situation on bluetooth-next, rather than
> trying to access with the reporter and risk  delaying a fix.

Yes, I think that lowers the risk - and stress - for these kinds of things.

Generally, I think that if there are regressions reports that come in
while we're still in the -rc series and the problem hasn't hit an
actual release yet, it's probably worth reverting simply to get time
to think about the issue more.

(Of course - some bugs are simply obvious once somebody has bisected
the issue, and don't need any more time to think about it more. "D'oh,
too much cut-and-paste, obvious fix is obvious" - just apply the fix.
But if it's a situation where it's not entirely clear why things are
going south, and a revert is simple and straightforward, I don't think
there's much real downside to just going "ok, I don't know what's
going on, let's revert and rethink this")

The *good* thing about early regression reports is that typically the
people who test rc kernels are also very responsive to "can you test
this change" kinds of patches. So there is usually then a good path
forward for trying alternate approaches.

              Linus
