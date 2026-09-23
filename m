Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216756853D
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191879; cv=none; b=pysQWHarSlACozq7KcNgEwkao5am3XEovvcV2iuG1g5Y/DCSLiiIh3BJKtPLisYCPet4lVNZSkl+muKVy7ur+f35FcvheNgWTVp2c+jzEdKO8wW0hKto8BgUn3tzjx5Nt5+5S608yV3gkc7AbFfZD6hz54MabiVKfm9jANhCjDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191879; c=relaxed/simple;
	bh=3GYNX8PBWpfHQs2bffqzmpsX/FrIGN5ir8IJc7nbnKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IVC7Pl4Gqq62ficOdcXBLAiU8q7pPX+wpO+RfM6KaC6areL43GC3/MgELXlQERkYEzzINoz2oE6eTvhVTJModDrYTPrNyAMRbXrdt7V4qY2O/USCwBCEDzBmoSueq0UvqDNlFh3/3WdL+754tckDzpMAkVNJn7yOZPSu+ZZor+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4MuCf2q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4MuCf2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941B51F00893;
	Wed, 23 Sep 2026 19:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790191877;
	bh=cBvy1PZmLSE0nZDhRmH+mnz/o6Kwu0h5H7qlMgkN+Tg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=D4MuCf2q3NRaIue2w82aFDULO/luC+au1dUQ+qZcmb8KaCSGI5+/DpEENPxb5sH8V
	 +AaEl01YFoPNFUwUuxBOGjRbpmf6UuI+4kZuEtW0bQdXU641rff7upngmG9zj1e2+R
	 fzenA04c+b+8XenWX0YjBjRVArNp7xzG86vOumhVfNbQR73V/quhqB5449lRfweHLh
	 UVv+OlG8lGH10Za2v3FwGmG4XcYRY4jUYMgL9jV/Bq86o175nmkaLkC7CwxmNXOqkI
	 MJGdB5Lt/TgvVMi00yTMj7J7zobLjCsJFOJOBKZFSuhdDtfAZ4NWnVfO5RtYuvJMV8
	 RAhJEovvwIOhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE69A39E8A64;
	Wed, 23 Sep 2026 19:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obexd/pbap: Fix u128_to_string skipping data[4]
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179019180738.664822.14639957919248086095.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 19:30:07 +0000
References: <20260923032957.4133667-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20260923032957.4133667-1-jinwang.li@oss.qualcomm.com>
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
 xiuzhuo.shang@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Sep 2026 11:29:57 +0800 you wrote:
> u128_to_string uses data[3] twice causing data[4] to be skipped and
> DatabaseIdentifier, PrimaryCounter and SecondaryCounter properties to
> be printed with wrong values.
> 
> Fixes: 5ee26d43c65c ("obexd/client: Add DatabaseIdentifier property")
> Assisted-by: opencode:claude-sonnet-5
> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
> 
> [...]

Here is the summary with links:
  - [v1] obexd/pbap: Fix u128_to_string skipping data[4]
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8b4a41760638

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


