Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10735161307
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843632; cv=none; b=WO5sw6Tze/JpzaFpyi/MLkjWmBw9y5aJHsiNFdQQhawhMltZtjbngpfbmRv/Eae8W4pMGyKaivbSezPU/vJ/u4XGAVHvIEMtFtNHpQ9TBHggYDhWad6FCOIgyi2GtIoLo3NU/2XVO8EqV/JHR5j8506nZ+YIl2chHVejsWMY9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843632; c=relaxed/simple;
	bh=GAdgCCblqjBuvJ6GueZBc/AD7wxumVWPQ8hy8+doxuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qCX7eJz2eeA0gwkK2MT7tJ+K6YHtJOYA64sv5SVKU9jlhiV0bcn6NS4RiB/+l/g/Puk+gM3gQL/RJ+hys8E+fo73zibtGY2AMkbnNk38KtnlxuXVVmgg3GudX9KwruyjcU8VsonH77W3XqLJrCdXuJPtOobAB9f2lBMZGuBz+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMG0lh4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMG0lh4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC7F1C4AF0D;
	Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843631;
	bh=GAdgCCblqjBuvJ6GueZBc/AD7wxumVWPQ8hy8+doxuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UMG0lh4Zr8FdCP9Kcci5u6ORz56r94AbIUzbUydgkl6jar8psljYvRMQ4+ZF8QnRT
	 AgvQLRbYYePsVSAjM3vrx2CMkf6Z/sMcT50Rk9M0T+x6bdy/HQqetQpXBwwFdt6L3U
	 kP6WxtU3MKEIvkMOjwk2GUgz6YO4llZCNZ8m9Rc/sca9wm72Cj3vT4mF/IqTuC6cSq
	 ijcIYyXwt5F8yEPxOUA5htC/RCjtwgELBMfI8wRjY7TdahvyRENcUciks8NgsCw6WN
	 GC0jJml8SmcbXTuNLIOdV3JqYo03PkOx40nxf0hYtBU3fKMRrTO2YAEET5mjXbLOvW
	 kNnzK+mQzHbMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACEA4C4333B;
	Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] policy: Fix AutoEnable default when main.conf doesn't
 exist
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171984363170.28078.14544852513051621588.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 14:20:31 +0000
References: <20240629201632.1356542-1-me@arnavion.dev>
In-Reply-To: <20240629201632.1356542-1-me@arnavion.dev>
To: Arnav Singh <me@arnavion.dev>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 29 Jun 2024 13:16:32 -0700 you wrote:
> 180cf09933b2d8eb03972c8638063429fe5fece5 changed the default to true
> if the config file did not set it, but it still remained false if
> the config file did not exist at all. This change fixes that.
> 
> Fixes: https://github.com/bluez/bluez/issues/886
> ---
>  plugins/policy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] policy: Fix AutoEnable default when main.conf doesn't exist
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f40e88d0bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


