Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C820BB3E
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Nov 2024 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923823; cv=none; b=BEg7yt4Ux935op3XG/7+kUHDyuoiHDyrscOlG06WWTUBYPwG+woWiaXU0Cj9t8yg9o9a6i8ZFGFFhiSvrQcqBrXj5wmhqnw6IWKNuXENaV7HkATsV2mgDEYBdQJZya1ItTg3HKZaZqWVYfdNbKuK43mf5mJiGFzwC8edX//O/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923823; c=relaxed/simple;
	bh=PPvCsjYPgPtHqzRTxQLyoA3YC3pdxWAEJ9ivyHY71lM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L2U2/yswlc4eeYq6OjuSc4xhBRQDxzH3E1K8J4XKod4bhOMoCkvZ+bn0GCBrhVB/7VYGb2ML4NnW74EU8EMaUjwwfiPYBwCJWy5wiU86+jHOQf6IHWhQCXm35ICVQpYe8vnaChCYYDG7P/ZByWxKijbpF74WU70ud2oTHHtlvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvqk3Yv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvqk3Yv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C257C4CEC6;
	Wed,  6 Nov 2024 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730923823;
	bh=PPvCsjYPgPtHqzRTxQLyoA3YC3pdxWAEJ9ivyHY71lM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tvqk3Yv+SC8rbC0jamxLqoLbS3d5As59OkKts+z63awKA/E7A6H5w/snB2sNNdVhu
	 9j3DqQpS4BXfXLfCCxT6AjdJeASZ8YVIjp3jn/e7uplsezHFmNVhhNHmhmJEOPYj1h
	 pisCZ59j0cZPm05sI+7IItU2DdsbHenyjzn/O0XMqlbrysu0tFJUQtrMDmlaivxE45
	 BwrDHp97LhcVOEXCBr07rjzc1EAqOD2zQHx5mclIi4pvsKTWvCxlD4N5uzLUeKPnqo
	 eGK6MzKjW+1az1nRxxpxTJLIRT1sV5KFGeRz+FyImT82xiD/74fqQNx+iR7zckWA1F
	 fPjKjcn3ZxMow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F483809A80;
	Wed,  6 Nov 2024 20:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] lib: Add IPC bus type
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173092383224.1405455.534791042487610929.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 20:10:32 +0000
References: <20241106145100.42889-1-luiz.dentz@gmail.com>
In-Reply-To: <20241106145100.42889-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Nov 2024 09:51:00 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Zephyr(1) has been using the same bus defines as Linux so tools likes of
> btmon, etc, are able to decode the bus under HCI, so this attempts to
> synchronize the definitions by adding the missing bus type IPC(11) and its
> decoding string.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] lib: Add IPC bus type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0025cdd0c103

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


