Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73D26ED33;
	Thu, 28 May 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978002; cv=none; b=Hlf4+HxrZmOEydT6rEOmzdiKJ7muD55sAeaGUhOqNm+c7XTPofqhBa3lvNqSfd6zLJ36K12hlr9EoWq3ufMaxXdBmO7v9Wqk/t23gTI2mgahlyKHi0a+epNV0qXwHhitoVNrrh5M0WuTGOQ4U29+yusRGW261oxvDvQbqCXFpIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978002; c=relaxed/simple;
	bh=tfBDJIq+dBTutPsGBRFlPbUxu+6fxp+1z0IdYM9rZic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RzJZdwILrjacJEABkWOHrvAmbptlUnrinH+cuwRZT2DmxKzxJvW5oDNzAQDy2zVYV2uA2z59XrZcshdvkgm4uGoz+jEsnqrqPbz/ylt5cmhqkTOY8nomx27ELCfAzem+dYAeYV3E8Womk0sSZiPE/Y51WPXwfQAVmTttESQgFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV0SdSTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV0SdSTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D713D1F000E9;
	Thu, 28 May 2026 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978000;
	bh=+vlQ1sJs9kpVDtJi/GE/iaiW5Ih7Dse3yMbYX/zKgJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IV0SdSTWUuxLAtpy9WghMFs6peMgDor5sCCQgokowP0igDuQr2QNELDe99RGKVv8m
	 7UhDUgsBHz8J4E6fkhU4r7tRUT/MveZQdaB2EY4Spa0jMLOtQke1LfIm5kcTd7gH6M
	 O5osOt4nzoxSPRiGO3XCqT72s8uvuWCD/vcX/fLtLC8DvxxqYgdnQitNwl08hOwpsa
	 wFwJUk1Spsf5TpIGzIOswOpHr1lomC8qZfINdmt/mOmKDUVkxsT9P3+tLyuhqPWsvn
	 BH2YJ2746J3D+3dM+Du4FNm66FVr/GM02iGcch5BQI4xF2JdDv23BST3LmBrXLfyVO
	 yGH3Nq/WgGxYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AC4381195D;
	Thu, 28 May 2026 14:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: hold listener socket in
 rfcomm_connect_ind()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177997800514.948024.9564191237691986482.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 14:20:05 +0000
References: <20260528075641.3416308-1-rollkingzzc@gmail.com>
In-Reply-To: <20260528075641.3416308-1-rollkingzzc@gmail.com>
To: Cen Zhang <rollkingzzc@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zerocling0077@gmail.com, 2045gemini@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 May 2026 15:56:41 +0800 you wrote:
> rfcomm_get_sock_by_channel() scans rfcomm_sk_list under the list lock,
> but returns the selected listener after dropping that lock without
> taking a reference. rfcomm_connect_ind() then locks the listener,
> queues a child socket on it, and may notify it after unlocking it.
> 
> The buggy scenario involves two paths, with each column showing the
> order within that path:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: RFCOMM: hold listener socket in rfcomm_connect_ind()
    https://git.kernel.org/bluetooth/bluetooth-next/c/339cf04eb21a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


