Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0B2036F5
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364615; cv=none; b=RF33cUmyT1bM+sATG/DTiH7pFJkvIK8enmpNGTUD6ooUFcwdN3Ba69eDXbuE+8pmsD6vtGy7syrv56yeHP8mX+B5UMhWCVKPz3W4Ai/uI4FqxiD2Q0CAEkPg12c6lYFpV2zFTpEpmiZV914WcI2ez/JhaJ4k3WEsNOARbMoILzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364615; c=relaxed/simple;
	bh=rFd9UtL99Nq/dDzVNG4JWFZ8PONScvh5M7SUHTeHUwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LARPS5aEvzsvlqpGOO1rJniOKQh3pkZSO86XZ7emuQ/lvFxyxNa/KIKiBUS85Hh9Ib7V6gAs1L4XEMLUWy2joDrebJWLxpnzJ4r5w81Z7HnTFkrHgdKpKS5kPdsEnCWHtrKr2+xZ3cj0AadmBfqnTHQqtzHu9x9IwfgodlGNSM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8aImZvC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8aImZvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F2C4CED3;
	Wed,  8 Jan 2025 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736364615;
	bh=rFd9UtL99Nq/dDzVNG4JWFZ8PONScvh5M7SUHTeHUwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8aImZvCj7HyFAqXX+W65fiHvqQ8CxHrykDZZ5ijc7pul86VGjaXQpJbThUezddoF
	 rvq/jJNd0/vn6G9dGNB6r986E6N71VE/JoDNz4UD1VsyHU7oD3iGf48pMqlLVT3QZQ
	 XzxkvUOrrqjgUkpqd1RLnwHq6MgaWMIveuFBMEWU0JphHnS27N/MzWp9OeImZC6QaG
	 BITrMvmKxfc8OXRJpGeDH66aqz7dTbNVjIIrvZTmOv9DkmMlsvF7B2LwUTPrEECyL0
	 2m3vThBV88qgHj1qTsHc42gJwJyyY6Ae7UyVJ29G7/YJuLmANVvtms9GNVzpOippre
	 3h9MGnjNrlVow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7A380A965;
	Wed,  8 Jan 2025 19:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] input: Switch back to kernel hidp if uhid cannot be
 initialized
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173636463673.754812.9467624000955406010.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 19:30:36 +0000
References: <20250107203056.1470303-1-luiz.dentz@gmail.com>
In-Reply-To: <20250107203056.1470303-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Jan 2025 15:30:56 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If bt_uhid_new_default doesn't work it is likely that the underline
> kernel doesn't support it so this attempts to switch back to kernel
> mode (hidp).
> ---
>  profiles/input/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] input: Switch back to kernel hidp if uhid cannot be initialized
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8f853903bdf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


