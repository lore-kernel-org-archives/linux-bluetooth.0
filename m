Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99334105C
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765828044; cv=none; b=IgATYSQQ5QJd7LsO1bx3DZHKg+9gji1yulQMWkR3xSzV6CNgu0eDZBMIxEQhxtnomNxyiTMgEYRri6zalLSoCIJHxnpxi3LQucfMh0c8/3HrOz3jIwGmOv86hZcI0KszIsPddnI3L0p5+oVMfiUK9a2Qn5Dms34tuHr2Q2EmWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765828044; c=relaxed/simple;
	bh=q0iIy4h3gxffkwr886IDPPy727RtfAYQCCMBEE9r3+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YM1C/PLPz+X2bSHVo8rI6cepHKFYFp48kiTHemsxQi3mS/mjNtxBIV+gP38G93U+g28I6y+12TekdzYfzB6Oikyn0HakMboqcGEM3OrQqVMWjjHm/Qrzlv34pibsxlVrIhXTywsVytbdBsWe0+YDehDMedGUG+6f6bCVBsfafB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVITs1Qi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVITs1Qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F57BC116B1;
	Mon, 15 Dec 2025 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765828044;
	bh=q0iIy4h3gxffkwr886IDPPy727RtfAYQCCMBEE9r3+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MVITs1QihQwMrghST0hN+qJwtYRsPnVN+wgVGwyXDdvP8MQwsTplH2rxgJABj6IPM
	 hlTRa1SnmJooadwEFC45Khf03HNLKdWagcGlWDVSr369vU6Pl3K1yWG0ijcUKXzZUR
	 hkpiiZJ1+RBeUj302Lt2SI0AuBn99XPHlA9UYn9M7jnhjfU5gBJ6SdFJhuzaW8WeS3
	 RNnNaFIQsZrTtjIXsTadxO6e1J3WofAEUDpS+KvyO/ab2Ce0kZeCriks+2yo9rC6Yb
	 J065HbgtqsVFXnRxgCzOerHth+Af7P+6D1jKY5tmq/XZoH7ciV2PyM1YBCOj5+Cg6F
	 Z81vY/Qgr4Mlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AFB380AAE2;
	Mon, 15 Dec 2025 19:44:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/palyer: Fix QoS 32_2_1 in lc3_ucast_presets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176582785577.183851.5799568780999239132.git-patchwork-notify@kernel.org>
Date: Mon, 15 Dec 2025 19:44:15 +0000
References: <20251215081912.1245-1-kx960506@163.com>
In-Reply-To: <20251215081912.1245-1-kx960506@163.com>
To: michael_kong <kx960506@163.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Dec 2025 16:19:12 +0800 you wrote:
> ---
>  client/player.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] client/palyer: Fix QoS 32_2_1 in lc3_ucast_presets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cc64a44d77e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


