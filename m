Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC91233151
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2025 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997001; cv=none; b=fAgAsQhOZUEvecRH97ybkKYpETYVYblybd6CsnEaiaj9oi7bS8jDYtkRE7O9tgBdinjWxbKbdto6bvAAQ6HgedjWHCNb/imvpi2GBxkU0xXwpZ/wXQRqltdjrrXQ+acGAOddMNaYX88z3/8vtXUfNZB065kZZXpqQciPNL68I+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997001; c=relaxed/simple;
	bh=0FPe/l1Mrkilip+qEmtz/tGOcVBMMEUVbXTxdjda0Cc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IP0XaqOncvekwjcvXfk4uzkSy5Vxq2RxS89QZO0VB3Zon8It5JRUBM4g7oKj3MRO4AYGGFkO2E76scKv+SqrNkUWraM0QnGXGoK3XgnxEyDmuLrbVo0DFJZyabwak1hU3Mo34cz625qzuyCeW8990Tuf77NXJURYQMadx/lSClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH5a2gl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH5a2gl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CEEC4CED1;
	Wed, 19 Feb 2025 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739997001;
	bh=0FPe/l1Mrkilip+qEmtz/tGOcVBMMEUVbXTxdjda0Cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JH5a2gl6ktPWkVf3hEJ1StieiVKZqwtzO65+BFSPUTBbHvFBgBIx7z/ylZMhSgDw4
	 Djbdh8LcyrD/Qa8s0oS5FYGboRRknxDecf7MXQmwoUyw6np3knIOdvG71Ty3yPEm8g
	 N8DIJDK3IpJ1nSUzs1fUidXbLozwR+tVR6hxZ8eqwKl1bsEz5ZcNcEfjbSKg9sRzgA
	 WZdP79YQky21hPB7wr1vKHKxYGizeyiXNEyetsuBz3xS4C/El2eVdPMp4shObfY4/Y
	 n4pT5VcKdtkJieKzNVwFjSAK3g7wkngps/QInsZcKr1zzD3qnxpVQe1X6HckuQet0C
	 fggny6byxaDPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA6F380AAE9;
	Wed, 19 Feb 2025 20:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] a2dp: Remove Endpoints cache entries on device removal
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173999703176.735166.8418445560040405555.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 20:30:31 +0000
References: <20250217114802.52247-1-frederic.danis@collabora.com>
In-Reply-To: <20250217114802.52247-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Feb 2025 12:48:02 +0100 you wrote:
> When a device is removed, currently the endpoints and last used info
> are kept in cache:
>   [General]
>   Name=Frederic's Phone
> 
>   [Endpoints]
>   01=00:00:01:29f50235
>   02=00:02:01:80010484e200
>   LastUsed=01:02
> 
> [...]

Here is the summary with links:
  - [BlueZ] a2dp: Remove Endpoints cache entries on device removal
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea3f4047e452

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


