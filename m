Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499321CA19
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738705213; cv=none; b=n21y08ZS2PjK5GLEkI/s4++0tGRLx6h7YdnkuqvwS9kqsPoznKe6Z+t8KeidcBSGfC9+yIVJpKYgXlbp3TJAuF1JVXoNoUVq5bOPxrNV9/grnF/eV8+sgEIU3xNLF49imKj7Uyku8+aWQyu+JjiIBrUoW85NWEGrwkB+ZZw0/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738705213; c=relaxed/simple;
	bh=hmBW6wTsSH4k6QdluMImb/OcV9Oc5HZHbdLqnismBUI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fCQkC7VXiwzt3dWiS/tA/6FL0WtP6MRkfPCMzcdFm7QdlPus6UfJIb6j+Jtguz5YR3U8H9X3zLlqKL6M9/nk+s+2wPY3n/EQgo3tqIJwu3k10OPuC2K94Lo/fncoXHO6xlOP6dl4ptybE5fHwCD0a7mWiEPvXQpnln7H4IIYw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOM60jFx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOM60jFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FC3C4CEDF;
	Tue,  4 Feb 2025 21:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738705212;
	bh=hmBW6wTsSH4k6QdluMImb/OcV9Oc5HZHbdLqnismBUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bOM60jFxPKMdA1Y4b8ReyHKwMX0TO7gLgUNAbWgcwa94bVOnkxupm9i7VobMvH07Q
	 D3v5GXDedrRUTlhE++TBLuT2vazBLwWI1fYH8U0WHcQ+gRpE4bcTbmYoTaRLr8juxV
	 9FOPaM5VPJQDIcWX9h+1H8jKfBoT0ThLnd09rz6RzQqCfkWp/M5ev63t9+M50VEIsD
	 hLk2yFKhh4gmIUYo+dXrvvFjAPoYKuStDi2PfUN3GzWuRu4BSebooiEvL1VXXmrVKI
	 Bw90s/b4b6VPdMskNX/ZkW7D+CCruX17eNPY8WxeEFes3hMAE4d6atuDUo7YTw7rhz
	 Fo8uihy3lAg1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71D2A380AA7E;
	Tue,  4 Feb 2025 21:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] build: Enable -Wstringop-overflow and
 -D_FORTIFY_SOURCE=3
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173870524000.155646.5722943498829993759.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 21:40:40 +0000
References: <20250204201948.2883452-1-luiz.dentz@gmail.com>
In-Reply-To: <20250204201948.2883452-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Feb 2025 15:19:47 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables -Wstringop-overflow compiler warnings:
> 
>   'Warn for calls to string manipulation functions such as "memcpy" and
>   "strcpy" that are determined to overflow the destination buffer.'
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] build: Enable -Wstringop-overflow and -D_FORTIFY_SOURCE=3
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=26ef5a951e81
  - [BlueZ,v2,2/2] emulator: Fix Werror=stringop-overflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=de2773b659d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


