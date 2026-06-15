Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B0404882
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536813; cv=none; b=GaY22OERr6UVtSQC3TBt33aPBx41n7TEGrsXKyOSEHKkQE6oLW3HdddRdnqFwVgrD0vrdm+bJGbpqXbQgJtfrkSEuRBMyICTthHPIsimSmWuDHq2Cdo9VBGgRiddBWcNDCa/v8UFVDnLk/1OFF+LeCFZ+1wm/kABwSiJ7t5DEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536813; c=relaxed/simple;
	bh=4tQMLrOt8J2bwOxjQlvKFsqFeux74o2xZPp9ZZwzoxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kR5NaMMYq9D84QgcUArJBMTfaI8dQjmkdnzMDReck2uHrLu+dCOiE4iRBhxAO+VO89JBjxO2PF900hQQqFofwkry9CkKm+826sWP6bC4Ry5cQGs2Wuhi8WlElb6ACfNP4jLe03c3WB8PYmy/jxL7kCb0ktvv7d/vC18hIwGDrq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3GLxZV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3GLxZV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3B81F000E9;
	Mon, 15 Jun 2026 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781536812;
	bh=AR14rgYUH20wpUN3LlkS4kFfUzie/FgeP9/WN9ytkAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l3GLxZV3x52ZQz/GO8PdeDO6GNNehMNgHCDu1RICLrxW02jRqaYE7yqxDIJA4Q0vr
	 KQszkj43Q+lDxaGBbLBBfoWRp7V4QXmWBOjumHDALp90cZqtQeCRhuLAr0f2JA3Zcg
	 9Sk4egIp3u3QeBks/QQ22le9AJxpZAjtJYhDbIBLWPZFdWjqnqLThaN7ToSZIr3fpA
	 4OAFKPcZXji4SeQdRWDJG53XAU797KJV3G0ogT32nFp9PRc/kBq6uHLolHY8tEqk0a
	 3R+5KP/1qJP810RyHhzQwE6vopadkeqocOjYjq4H14Bfm0Zk+F1x7QvVwajjy/dCzV
	 TacA/Kur7y66A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938B03811A64;
	Mon, 15 Jun 2026 15:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 2/2] gatt-database: Prefer notifications over
 indications
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178153680713.3644727.18355513118559791192.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 15:20:07 +0000
References: <20260614102931.1133819-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260614102931.1133819-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 14 Jun 2026 12:29:31 +0200 you wrote:
> When both notifications and indications are enabled (CCC value=0x0003)
> we will send notifications by default.
> ---
>  src/gatt-database.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,2/2] gatt-database: Prefer notifications over indications
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c36e4189e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


