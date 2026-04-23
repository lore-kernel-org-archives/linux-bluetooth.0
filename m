Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED093033DF
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965782; cv=none; b=hTatc67l912dSoZyrm2ZAB54YCUmxG8bbKoIonLtOwsypXllvJcR9ZPUJzbgpSMGyZNu1PoRvsfunxmoWWFjnVzcl7VNs1PTHZpGGS9+0/VupeUKnCA0rhDq6shhh1xqmTMyZU9ZqGrE7AGY7h9uqFiLLAEIFzELyFLhXam73GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965782; c=relaxed/simple;
	bh=xwtw0OJvGLE/Lum++zazpkBN2D4nXALffdNH3wQw0YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NK6fXogYgOKGF8c3m3cfd0UZSWKW8GH16xutxXl7yYxFuoOBvWAsRwGUu3aMgw6JRvrW/AuiZuqOYTwBbPQeQT+nRapVOp35WJFero9n2zjISb1uHYcWWPNQBUd4ANubbCJXqfpLZVmgijMKjZKS9r0Y0oUovHT9qGauE6COJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohamrm1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohamrm1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB233C2BCC6
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965782;
	bh=xwtw0OJvGLE/Lum++zazpkBN2D4nXALffdNH3wQw0YE=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=ohamrm1o8Z1E/xgWjSFDxDlknSNleOgeQbCp0ATK1BPeF44XQbhwrJICaj7SFv9cj
	 3CzPKG5ainaRsFAh5IVcfIaf46kshsY0xVwwwMQJL3AX3q2UKjVSQp7uphRp9REPzJ
	 hYaV5yRWHViuGNLdmscQsSWOjDndZu1trId3yOnVBUdLJAvPOyv1gUhy1NO0k9Jk0p
	 KyVNYyKjDjQ/zU/uF6y6QLNHKy802D61Qgc0B41SRDkKq02t+UUNoNY0vyyxxqS1XO
	 jzrZe7NUfWBH23BblQEuJ4TBcLm722QeX6jy4sSAEY3ijJceMVjT4Fqrtuv0qPBElf
	 C4Smh79HoY17A==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38dd575bca3so71106941fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 10:36:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8lte280xHby9g/r3vrzk4oxhxshA8l9mKA4G/p9qSZtnXcKencVz6fkbB81iuXH4l3mWFBE0O4HjcWE8RG6t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBinZNYJD0LxbGSYR+59MEKNmYX4+FUJqmiG+JPtj6gIa48Ll
	p53xNkZid2su/Zo7aPxOhPpWJ+Sq93JsgFX5DDU/Ll2c1RrR8uBAFsr5xinvm0soOpRXcqDwnf0
	8BVGy9fcb3lI6RbikdUaEnRJplmx5afo=
X-Received: by 2002:a2e:878c:0:b0:38e:94c6:b706 with SMTP id
 38308e7fff4ca-38ec8ff15fdmr59864981fa.7.1776965781090; Thu, 23 Apr 2026
 10:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKHmtrSaDR4fBxN0mvEzYPHoOwr2rrtnOJW6fsrxzsBAeHTjQg@mail.gmail.com>
In-Reply-To: <CAKHmtrSaDR4fBxN0mvEzYPHoOwr2rrtnOJW6fsrxzsBAeHTjQg@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 23 Apr 2026 12:36:09 -0500
X-Gmail-Original-Message-ID: <CAGp9LzpG3QXdHxy_E-9mCat9bTDDNSnz_vMHYgSNiVzwF3dkrg@mail.gmail.com>
X-Gm-Features: AQROBzCAd4x1at669eIVKMLAV0sDSHEHFBd8wCOhg12KB7-ZuJ4KwsllBKzDQDA
Message-ID: <CAGp9LzpG3QXdHxy_E-9mCat9bTDDNSnz_vMHYgSNiVzwF3dkrg@mail.gmail.com>
Subject: Re: [PATCH v1] mediatek MT7925: update bluetooth firmware to 20260414153243
To: David Ruth <druth@chromium.org>
Cc: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <chris.lu@mediatek.com>, 
	ben@decadent.org.uk, dwmw2@infradead.org, johan.hedberg@gmail.com, 
	jwboyer@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-firmware@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, marcel@holtmann.org, 
	ss.wu@mediatek.com, steve.lee@mediatek.com, will-cy.Lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 5:19=E2=80=AFPM David Ruth <druth@chromium.org> wro=
te:
>
> Tested-by: David Ruth <druth@chromium.org>
>

Merged
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1015
