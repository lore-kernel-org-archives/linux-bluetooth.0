Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32001261586
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014011; cv=none; b=HRGd9XT8lE8IoSttROIWJreHOVCxFz16AX5t6oo4dzHyzCsfyr8wid3p14xrA7RifB29gq70GDL+0waQU8gQaEsvGrcJ4MA7dexSUDsRwkM57CA4OM3yid+bFJJTcRrRvV5weV9mRqqJQHs/FXVKv4YON0SmkVUf03LZGgwihtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014011; c=relaxed/simple;
	bh=6w0XmEX+pTHV/AH3msc+Gw3mtOnG0hL9eW928J1Zo80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UvOKRBFd7YvhO2RFCrwnNTvI44/NTuvzH1/QxTLyMcVdzblQgDplh+uPNRRvc5kceQ1Im51PSXp1K9I7TstkpZNjBU1SPq/EVPo2I+n7ySzxoGjrd2wBVoDc+y3OnchZaTcS5My2isKBu1FIdJB0rgw7qUM1hXCnqgH0ZRql3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+Kjenul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+Kjenul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE099C116C6;
	Fri, 13 Feb 2026 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014010;
	bh=6w0XmEX+pTHV/AH3msc+Gw3mtOnG0hL9eW928J1Zo80=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n+Kjenul8fs/ZcgFt/iksLj5rHHJdhneEz9wps2zIQ8nSr3VZsvNaOvx7w3AuHUWp
	 zJU1EF3YQMFH4jKgaz3PnvyRAWuc3IHzzb1Mtlgf+rcLtq9lBFOryjz4H0B5+ujtgF
	 NVE4J1ClK1SzarpOPP1JskdyH9s3Vim5MZeYAxOOueXCdLahq0nrddccrsqB2O225G
	 SoO0u9nl2gokfJ2ndxSZqf7FLaKlyIO4lQszf/vQ4n/eO7BX0++Cc816VqibMLGxn2
	 rzdQq/YeCNDDHkvyy7OAQ1vQNX/o6qO2YixlkH1ss25gZVEFfTIL9ijsKtW9rITNLV
	 xpoRr0/4xD8bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23473811A44;
	Fri, 13 Feb 2026 20:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc/btmon: Add reading output section
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177101400433.2543989.12829177253553273550.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:20:04 +0000
References: <20260212212134.1699927-1-luiz.dentz@gmail.com>
In-Reply-To: <20260212212134.1699927-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Feb 2026 16:21:30 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds a section explaining how to read the output of btmon.
> ---
>  doc/btmon.rst | 358 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 358 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] doc/btmon: Add reading output section
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eae36399e758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


