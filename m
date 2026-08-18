Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B433E1D1A
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078310; cv=none; b=iCdQuQWE52NR73Tg2uTsjlsgXLKzROukphH8bYHtlPQLTvXqrDkq3Dn+mPptVbsndcd8UlIrHYuPrx49lwIiOebwVdaBmdIGfvZKFH31xn+21Qwa9vvham2wwV+IoKOnr8aIEj+HSmqWtoJ+F0M5R4uL8UywSryad3hJYRXl1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078310; c=relaxed/simple;
	bh=tUfuR/qRW84LxIVZaVu6L3pAwwXm3NiD4+YIA9Jqg14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NmAS47lNWcXSt6JgmGT2nrOyw6kg1ipRJVdPz3kCLRyXRSBXM4AcDj9YlyqUnzvegxM5YoTVwCT5Wb7ZVkhE6kBeqokWr6HQ85yVa2WP8GuKpi3QlR/cn8Uq8SoMkBQEF0p5v03f/pEUZ26/D05lgGRwvjMcvI+YlsKwncn5bHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBIVUTEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBIVUTEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3C61F000E9;
	Tue, 18 Aug 2026 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078308;
	bh=wdKllLNBduaCJr80SbzUjoznhB859BIUWIYVN69ILno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eBIVUTEBryEDH/5eGRfzMKKM4+2+uFINX+CzWfAb3hiMIgSRaJ1Ppb6pIGP38heeP
	 wgdsRp9JtqSTAm3u7XJceX22J0Eyhnuw+NB2qJAtXrw2oKCQpw2A2tC2Y7VY/H+A9f
	 N/x3dxERMtfHyUaRx/qX7qo9blK06PemqiVX61zV98CmWdmd4yFKKh2tqMzPRG+sDo
	 mUhnY9pKd6m8Le0WX934ZIMikq7mGmlY3ZRk+b288sWu0UtOBWYXlL49dgmqqecZBF
	 eeTi1X02gxhVBXXhdYJnYBn6LhIIl2ewZFGH2qTRrqTt8qeL+jD0XrLcSEH51hzWsS
	 MLiZ8aMFtHtAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93826392704D;
	Tue, 18 Aug 2026 18:37:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/4] sdp-xml: Use a queue to collect sequence
 members
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178707826022.2194892.16036865943202250756.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 18:37:40 +0000
References: <20260817210038.1839617-1-luiz.dentz@gmail.com>
In-Reply-To: <20260817210038.1839617-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Aug 2026 17:00:35 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Appending a member to a sequence with sdp_seq_append() walks the
> single-linked list to find its tail, so building a sequence is O(n^2).
> 
> This was previously worked around by caching the tail of the sequence in
> struct sdp_xml_data, which required the caller to pick between appending
> to the cached tail and initialising val.dataseq, and to keep the cache in
> sync on every append.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] sdp-xml: Use a queue to collect sequence members
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b21edc49b2c3
  - [BlueZ,v2,2/4] sdp-xml: Fix leaking the parse stack on malformed input
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=97521ab4dd79
  - [BlueZ,v2,3/4] sdp: Fix memory leak when freeing alternates
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=078ef10a4531
  - [BlueZ,v2,4/4] unit/test-sdp-xml: Add a test parsing alternates
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5abc0045b84a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


