Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D45311972
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667209; cv=none; b=gk2StgYoDOAVeK3z05IhYzT/+bZcJXrvdp6/MuAx6aCzKLc+RCTSb+o9LFU4im4v0bVFw0uidqOnCsS7YjQiHusJWBH3Ek1jCqWhAzG+BGPjUkXz/iw5e2rH8TSUJboSBmYKAUxUfvFAPLFchkCJzDSqPl0lqN3MluMsQMyyOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667209; c=relaxed/simple;
	bh=3HN18342yBZ/qEPr8f6KSBd8Uk4/ckULPXw8o2NHIB0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BvRangg6cfDRfvZOOiiQUWw14RW4EMLhMOr4L6KGUk+kAG6UmhJ7qDbA/Mo+tIOeVzleZ/TTPjjIAezoc8wPEcwN5C3Woz/2KUmTsfULqm6hNznP6Aafd7N7owwqHen8bcjnLQpD+SSSDckwISY8NBViYgDBkUpDqQ6uyYCB0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFK3oWv5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFK3oWv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E74C116C6;
	Mon,  9 Feb 2026 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770667209;
	bh=3HN18342yBZ/qEPr8f6KSBd8Uk4/ckULPXw8o2NHIB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qFK3oWv5My8QtZsPd2QK4h72EFTp18FBCa1OXoOrmoGMxOyT4g/rInW6K6brG5ykT
	 3fD4Z9EI3Z/tnApjMFLHXYtDlalXpZIA0ZiXc/8zKTRTohS/5vWaDFNroPT+Wu6as8
	 qPpb4CGNiRusqhUr0uEB0tuyGG6iEd1NG16W/VdAqS26+Bs1CBRrCdWPxHQ19MohPb
	 gPFDR3qmXGD4Ac6JUI5V0D27EmY82UmArPcu4g4w4IAer+deMlpWoGZz3UVJv5rWGU
	 ks4ECOYcUA8QqIUMpqzcVfu+UdE+OHwTxqI0D4jCvjfn2sQriT4JPpgH3Gdo1fUvPi
	 WieIhN+9YzxeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 48107380AA48;
	Mon,  9 Feb 2026 20:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Bluetooth: mgmt: Fix heap overflow and race
 condition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177066720482.3196175.13167614416923442442.git-patchwork-notify@kernel.org>
Date: Mon, 09 Feb 2026 20:00:04 +0000
References: <20260208081559.44983-1-maiquelpaiva@gmail.com>
In-Reply-To: <20260208081559.44983-1-maiquelpaiva@gmail.com>
To: Maiquel Paiva <maiquelpaiva@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 gregkh@linuxfoundation.org, marcel@holtmann.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  8 Feb 2026 08:15:57 +0000 you wrote:
> This series fixes two vulnerabilities found in net/bluetooth/mgmt_util.c related to mesh handling.
> 
> Patch 1 addresses a heap buffer overflow in mgmt_mesh_add by validating the user-provided length.
> Patch 2 resolves race conditions in mgmt_mesh_add and mgmt_mesh_find by protecting the list operations.
> 
> Changes in v4:
> - Replaced guard(mutex) with guard(spinlock) using hdev->lock in Patch 2.
> - This fixes the "sleeping function called from invalid context" and circular locking warnings reported by the CI robot in v3.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
    (no matching commit)
  - [v4,2/2] Bluetooth: mgmt: Fix race conditions in mesh handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/567233b63ddb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


