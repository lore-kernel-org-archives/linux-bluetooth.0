Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368DF55292C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089283; cv=none; b=UblK7uUfqliC5Slt3UdiAB34k7GOgMGTbj+QEbg8esheSE1RK/l2ldNx55OvVLzFSWG5S7hNOCIETrMwdMr9rTXvSf+TTFCCPLs3tQoxxiyTvqziTMsaz6Ikrjzs2no6Jmvw6Vlie8C6SZAdXAOMfYR+jEGs5Gf+MVQIprWw6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089283; c=relaxed/simple;
	bh=mblFGKlg/svmy4+dDKV1xfwNrYn/P+Bm/wpMjur3Zfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZlzECBtQgyCmSxD/uowqstoi1zdWPigaTHOSOLojpmE4MapJNszloST+B9oaGxgai6sqrdn8Zds9rnCiiCAGvHK92BP8O74tQ3oT531kpFxZkEkSdJyuHxt2kln0B/eHhW8JJmofzB7C2r18VdC1+dpsPD3ZvkSzOCbKjEkG7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9RkPPtv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9RkPPtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E270D1F00893;
	Tue, 22 Sep 2026 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089281;
	bh=R+/OWWQpWfVDjh3ZZOdPUOfT/sSf48q6lORq/a9XuQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f9RkPPtvtSUJxtCbtxc03flBrbWAyO21tRRFkX/f/pq+tZbxq+D9cCenTBqjzqf9M
	 VJIRvCw9N0xdVwYslBSwhfFrXC0HVjvlsUjhjZkEnyI4Qs8bUqNitzz8awf606cX9T
	 YnUiSuDEnKtRAGGBrQbecDz2Bac7U7kwBhd0mN1qQJVLuJKrqwHs5Gh7pg3+TIPz+e
	 xF+9jtd2T+n2EItYiyxdJRw7XKmwMm7a3NEQkLiQXN8WpceEZ+xk/FufzI9a7V+Y4x
	 XpEcQgbX5AoNV3PSEAFsbP2I6cKmvtObR+84LdUpGTce1swmy+0pi4/NOlKRJhbzzb
	 /foP3jdT/CjoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37E203811A4B;
	Tue, 22 Sep 2026 15:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel: validate DDC record lengths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179008921299.4126096.5111723603808643116.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 15:00:12 +0000
References: <20260922130312.24749-1-aluvala.sai.teja@intel.com>
In-Reply-To: <20260922130312.24749-1-aluvala.sai.teja@intel.com>
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Sep 2026 18:33:11 +0530 you wrote:
> Parse DDC record lengths in unsigned storage so 0xFF does not wrap.
> Reject records smaller than the mandatory three-byte header, records
> exceeding U8_MAX, and records exceeding remaining firmware bytes before
> issuing Intel_Write_DDC.
> 
> This issue was reported by Claude Mythos.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel: validate DDC record lengths
    https://git.kernel.org/bluetooth/bluetooth-next/c/4712bd9a14cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


