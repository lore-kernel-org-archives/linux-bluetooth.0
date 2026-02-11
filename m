Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320B2D8795
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837610; cv=none; b=GIOp/kqQSlpfduhylrIVQ1NkQ34ibE7QEbDTGrPmqTffRipkcL/MwD82PV5SjGk9L2pTkitUSa+kVzLMHKLKpHTF/YPBo6QnjGx6yGXE6dn2XN5EpvZQMbsdLnehJ8mFhlEr7OyMKbtdF9uZP5uYBTV3juXQcjHOfbtGWaeWR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837610; c=relaxed/simple;
	bh=hPUpB+6TWGI8cf0hQV4J5M5+QYAoJ+6EJ9pqIPLveTE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EVlo1oc8aYu1KEzFci4Y57L2JiFtui2FFxLK6hwPCgjqhxk5yeoNwxAU5imjDcwt49LrGScX8czgJxYPexiU8vXhqtNCc+gcYCeLacmc2WveMeTugwjVV5RTSjRfW257kk4qDwct4PgFut8LQKZ40paa/FM7Ni/OxhQ81/UceHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUVvrAu9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUVvrAu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CD6C4CEF7;
	Wed, 11 Feb 2026 19:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770837610;
	bh=hPUpB+6TWGI8cf0hQV4J5M5+QYAoJ+6EJ9pqIPLveTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rUVvrAu9OcrNraSOpcKvx+D2d2xMb45Z8V9NBQfrvtRFDlmwIEB8gIzAJf3cNc+Kd
	 Cn8s5J41ttwzcoi8s3ksw/lb2+TKW2vKa8wq0wKKc6qes9MVqpPom2rJo0S3YZKbT1
	 btYdrHEvONfiBtyzt9uwBx4TnbA+vKdLdwt+oVcPBA4iZ5bxkyJmMapAzU8B17fXfz
	 cNOBdzTZ0RCuczI5sQK9WtZpby7zfcTTwLm5wZbjS8QnV40G73QpgZ7rEJH3MOvrtU
	 MDfgkWhzLW+XtTH1qNbX0GDsYoRQeG1sYYm7PQNPHhsNKrBJ9sWtUgL7zKjcGZO8FM
	 JCQjbmEauZwPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B02E39EF964;
	Wed, 11 Feb 2026 19:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP
 when
 MTU is too short
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177083760483.682289.1775124255661819819.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 19:20:04 +0000
References: <20260210212722.1250596-1-luiz.dentz@gmail.com>
In-Reply-To: <20260210212722.1250596-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Feb 2026 16:27:22 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Test L2CAP/ECFC/BV-26-C expect the response to L2CAP_ECRED_CONN_REQ with
> and MTU value < L2CAP_ECRED_MIN_MTU (64) to be L2CAP_CR_LE_INVALID_PARAMS
> rather than L2CAP_CR_LE_UNACCEPT_PARAMS.
> 
> Also fix not including the correct number of CIDs in the response since
> the spec requires all CIDs being rejected to be included in the
> response.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
    https://git.kernel.org/bluetooth/bluetooth-next/c/5c3d538e7be5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


