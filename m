Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203D17BED4
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996637; cv=none; b=jrfRJzZlGA/f5BqDAhQAlAPW0TQ1D1ofC9bSmupC3xwK8V1IdprOVD5wDNzxx+zr9UhvxS28DsNVO5Y292IgcHFB3K+gqyHyRwf7KVbFExVVFxzQmjuXlyhq3WVnLeFVqm1RSjV+DQze0dZmlm4DrL8CJy5+h6G7Ne/AZ604OmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996637; c=relaxed/simple;
	bh=MB3+wkxHlHdt8a87vyDWBrBqX7zcAXAitK1VtpkMKdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UX30q9VA+9OpxVgA07HHYY9dvJhEyLIUL1CExsg6RHJUowQHFrrL8roo6iV69exrRyddmIPsUqHWgewGzAMyn15NmTuQYfRAis6CcVyRcfiAntreAAvhQEnPD7TspvDoMr056+hf7wBHZVFdOzV4Zi3d8pEUYcjSAL0qa5tkkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqsPnx5g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqsPnx5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85C3C4CEC3;
	Tue, 10 Sep 2024 19:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725996636;
	bh=MB3+wkxHlHdt8a87vyDWBrBqX7zcAXAitK1VtpkMKdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kqsPnx5g0V7yOYGiWXHA2SMBR/4DGs/vG25y/QOyFKWZYIUKhdJZZR8Tuv7UscvhB
	 RTZWQHe40BFy/P2MpgNFNPInKa0NmiLViP+HS1ZJn+Mm0dkXDnwnTKkgSTSBuyO8Yd
	 +l0XXwRkzEQGSarb9/VD+geJSaAXF2LGXwVkBggjehBcUjp0949Crnf1AJh9/iCHYt
	 B1XduDv2P47XM21P+mify83+8hOhdyy7vWD1ATo2K92qWcj0SUdDTyoWxETqh60UlC
	 14nRkuK7REe0SyGfD/YS9N2lMEZzq035KiVSid6bxW8rlDxNIPdCJE3mu2xo1bRejo
	 aQGg0W9b54WFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3643804CAB;
	Tue, 10 Sep 2024 19:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4] gobex: Replace g_convert by utf16_to_utf8
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172599663780.370850.924119102853776939.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 19:30:37 +0000
References: <20240910154450.164911-1-frederic.danis@collabora.com>
In-Reply-To: <20240910154450.164911-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Sep 2024 17:44:50 +0200 you wrote:
> The glibc's iconv implementation is based around plug in modules
> for specific translations which may not been built on the platform
> and prevent to use g_convert().
> This commit replaces it by a function similar to the existing
> utf8_to_utf16() function.
> ---
> v1 -> v2: Fix missing g_free
> v2 -> v3: Replace g_malloc0 by alloca
>           Fix UTF-16 buffer size allocation
>           Ensure that UTF-16 buffer is terminated by '\0'
> v3 -> v4: Fix memory allocation size
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4] gobex: Replace g_convert by utf16_to_utf8
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=615fc3592a57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


