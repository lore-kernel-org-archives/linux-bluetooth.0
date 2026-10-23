Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789240;
	b=tKf/syh1tA/K+ZnvGzL9baDIVtEeaFREeP0PCp6PAtEWpFWUCPghq2Yf7Ga/uKqPbwFt
	 KHkiICr2XOCfbkz/krmS1u2pLGA3JmckQLNGPgITL9sP1lkYRVxDlinCX5YEy/FSewl5f
	 TSduThr4BJZ+1yMoVu6WUj4LCLfqFf7EJ+RvKsoyEW2hOb18zuz8sv+59asC/BMYzROWu
	 S8GTJ+emQwxRVoU6WoLslWzEfF1Ifd4Rprlw/M2U0pVgWQEHXSXWqQsUL9EtWww44kN+v
	 dyLBVDMRN+VMbEK8RClCV8DSri89i/i3x9sgfQjZP2Mkyd1zknIq3YjQbYRcPOa3mFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789240;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nLEWUgkRbsF7oNEnaZx263StjYEEJjVyC65+Hp2uOs8=;
	b=UHM/S1LAvkBKHjKWk/xkXmu0nMVy5eI+Ag/Xgh5yJHXdKDJK0ArQS84wucXC/LCALo3g
	 VpDynw4BnvYPkVYSKyXcHfcQbNqbdKdO+shbx6JSKD7YVzhAUCV6nmW4o06SSwBDFIU0m
	 KkXeoFgZT3y4fAJgdgpGMxC20yXn8GB6w0z5Dcb5QUU5KbgwrCrYEs4304QD1ovUt7vfI
	 U8igVsSZ3B6uXJ1d8meDJ7VsfyvD1ZaN+CkU+twL/nhwXizTVffzjntu1LwNFIqaENNeq
	 FRtxkV1aArypr+ypXxSfeqsh9HseZR9puU8BA4S4LmIKI9nd/YtCoqBvdaGBeIiLdbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F5oY4WV/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA62606A325
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5oY4WV/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADE51F031E0;
	Fri, 23 Oct 2026 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789239;
	bh=nLEWUgkRbsF7oNEnaZx263StjYEEJjVyC65+Hp2uOs8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F5oY4WV/MYIoB8DtbutuGey1E5RkNlzPIm5bcj+iBd1b+Z1zmbFYMNxTgS4fd2m0H
	 vMyQyMvFGrofPZNglfZ7rz7GmCAHtKN6CADc4VwQnJLo00bpr3ItC6leJn+vRt2AM/
	 6DYBp/TndlvxgyrY7+CHOgDpPg491aEN1g00xAghyVqRcll8AKE1opEs8o8rnkYZ84
	 4mivA9G/amFDb5+2QmXFQ/0P6FwCOj4I3FAQ1QH2kw9MIiz5RIsEIz1Hf3GusBDLKl
	 lFmvAGoC1fk86gTBCoaIoiQrKK8zBNkJYU6Cxu7z/r+8fhEjD1auS633xfpCKItRlA
	 sG41VWLKO8EXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815C7391B157;
	Fri, 23 Oct 2026 21:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btmtk: remove redundant memory barrier with
 helper
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179278923809.1268720.9672691636919611279.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:38 +0000
References: <20261023093645.4669-1-abo@medichon.fr>
In-Reply-To: <20261023093645.4669-1-abo@medichon.fr>
To: Arnaud Bonnet <abo@medichon.fr>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, skhan@linuxfoundation.org,
 jkoolstra@xs4all.nl

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Oct 2026 11:36:45 +0200 you wrote:
> The test_and_clear_bit() call works as a full memory barrier, thus it is
> not required to emit a barrier using smp_mb__after_atomic() before
> wake_up_bit().
> 
> Replace the whole sequences with test_and_clear_wake_up_bit(), which was
> introduced later in commit 52d633def56c ("sched: Add
> test_and_clear_wake_up_bit() and atomic_dec_and_wake_up()") as a wrapper
> for the correct sequence.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btmtk: remove redundant memory barrier with helper
    https://git.kernel.org/bluetooth/bluetooth-next/c/ebb8ee296578

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


