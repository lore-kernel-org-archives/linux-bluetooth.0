Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF303264FC
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899052; cv=none; b=QBMkitQ7oBp8hIDnzcnDh0u+1UHR66TnOZXNfyzpzckSmhhpvA3JJukcR//xkt+tMkHrhQ7AVlaW6gwmwu4st8UC/EbSsXhul1zao1DEsr2kM49sEvY2QlNOQbaQwc8U82AJ1Q+iHsH9rR15RwaNkZ6t79Zpxn2x9x6G77SVZqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899052; c=relaxed/simple;
	bh=g28SAlcbc1vr+sxrLIOrDFIhcsDhEv249hAGfEnnbV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTA6ahytmStJ9b4VFaduiTBgaO1RWqm9GEMBZ2E2FLIenkGcKcjfVNiuBAVTX2X7vd788SBHA5nBlKn6FkOfJc1TMCRiaDI6gucBuafnyJlsPTXVPhw5MlEB20GXzBKIIv9Prc/G7gYavEyQ1Mj+h+w8Fa6O7bQjrycf6ZKp/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq2TUNVa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq2TUNVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19338C19425;
	Wed, 22 Apr 2026 23:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776899052;
	bh=g28SAlcbc1vr+sxrLIOrDFIhcsDhEv249hAGfEnnbV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vq2TUNVaQTsoQ+LNYifSK74ZAdbfbWl0sDU0fCEzLc6zAOHsJ/S2gOGn4F6efHTtg
	 IuYAd3GiyOkQzS5PBjClyKNrngHaR3j3u9mn6ZobyekcnXWImtT4kII+eS1dQLpI+j
	 5VVFX+uzRmB8h2oohBBQBuWmXoyQFSjaGj6M6IYsFm7l7I1Y5XZlfwOQIDUwMF9QkV
	 kBKMenwK/AYpno/G4Tq2qt9GyqXTv5nm58iRIbru0TpHWqPRj5CINOEhoNslipEnlS
	 XvkEe+jF4lZdO3SLfZDFXIMVUDJ0LlIlFkCvYR6K8s1LfHqXMc7xGNhA9YCWBqy0XQ
	 jmk+Sxc8Z+Vqw==
Date: Wed, 22 Apr 2026 16:02:56 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: Use AES-CMAC library API
Message-ID: <20260422230256.GC2226@sol>
References: <20260421230917.7057-2-ebiggers@kernel.org>
 <69e81184.050a0220.343b8b.d048@mx.google.com>
 <CABBYNZJHdfByt_Tg7WV2S-fZ9xxJYVH4MyBxT3MGTNkbX5f4rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJHdfByt_Tg7WV2S-fZ9xxJYVH4MyBxT3MGTNkbX5f4rA@mail.gmail.com>

On Wed, Apr 22, 2026 at 11:11:25AM -0400, Luiz Augusto von Dentz wrote:
> > net/bluetooth/smp.c:25:10: fatal error: crypto/aes-cbc-macs.h: No such file or directory
> >    25 | #include <crypto/aes-cbc-macs.h>
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~
> 
> I guess this is expected since rc1 wasn't tagged yet, right? In that
> case we will probably need to rebase once rc1 is tagged to integrate
> these changes.

Well, the bluez.test.bot seems to have ignored the
"base-commit: d46dd0d88341e45f8e0226fdef5462f5270898fc" and applied the
series to something a bit older.  In that case, yes this is expected.
Once the bluetooth branch has been updated to v7.1-rc1 or another commit
that has the prerequisite, this can be applied.  Thanks,

- Eric
