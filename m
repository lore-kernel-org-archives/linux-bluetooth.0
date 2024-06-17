Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E0DDF4D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632830; cv=none; b=ogR/U/U5mlUNWdmhfIE/9BgjMi6c+/eXXK5T40CWakw3a0Ms9Z/OGGd6+o1rUxMhiQmPbF7SIoU8+a834ZH9a76hGAO77PKX75rH9XIsaM0bywXMu9uUj/NRdQqIxyNj60ylYDljDBJPXcmYxY3hgrUlq/gN5iofsC37+QJ5H78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632830; c=relaxed/simple;
	bh=5HJurojIibPmYtDtK5PSv+zQa7SUeajfspBYut/d96M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rpbDEcHgdPT5bCqBQEwUL8SjWNqjRzaWLHbqAaDlhwjALpcdurp/hEJ3bTkL29HyOBndmXMwZ5tPWQEFLggccm+1qTzI4VsQJt8uUxbyY3wIhnQKn7NXgUD8WFmLP7RpMvBqzulDIaj0VVO5Ye30kBH3BQhCLLdAv0gPuxxLW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAG1Ibx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAG1Ibx+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B615EC4AF1C;
	Mon, 17 Jun 2024 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718632829;
	bh=5HJurojIibPmYtDtK5PSv+zQa7SUeajfspBYut/d96M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IAG1Ibx+xIz/g9evnpysUVxDG81EpRA0K2N/5ecSsld/aKN+Q4H+6jaZUufJKqypP
	 MJEKeMHs4wD8nh3/PFysV5m9wQjL6fQ9FdPD2v21jW1LaXdsMut3iAojbsnOhFS4u8
	 5Mce7fXIcXCCgLpDqxxuz4Vdj+c6bkwzGQhOecEMb128E5a0yYT4KULL6r29O6fF4W
	 daq+6PrR6xtB/k4yPIkCZa+ljP5Nrqd3QeRQAE9m3bS5uZJ3HNpKGLXNBAvrwbLRzE
	 jjIhxKeNK+ID/GzgaT4x1ipxF20WNg5gzLVMaYu9DmgMqNYHkyfraVyn/coIMgKEgM
	 CutCnlz9ohPrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A526AC4167D;
	Mon, 17 Jun 2024 14:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/util: Update SDO defined UUIDs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171863282967.3187.11224594862363170437.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 14:00:29 +0000
References: <20240614134228.1299692-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20240614134228.1299692-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Jun 2024 15:42:28 +0200 you wrote:
> The list of SDO defined UUIDs taken from section 3.10 of:
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Assigned_Numbers/out/en/Assigned_Numbers.pdf
> ---
>  src/shared/util.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] shared/util: Update SDO defined UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e496c216f46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


