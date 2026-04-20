Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FAD35AC2C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722437; cv=none; b=DbwXYEY3fyP+2nGwg/aMvy4zgzBu6MxDVLhDkoTshzDPxQrWDsUF7qnMkbPp1iPhC7U6ldTHB9GKBb3l8zjt/r+SLU/Zu+2xwZX0E/QujuKxZA/X29qMRA4tdgd+NN2RASSpRZP3ZK9zi3HfV/sDM9X2U5+xRZ9/3cIN/KgaHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722437; c=relaxed/simple;
	bh=EketaVvaIFDMszIe8GhAamMJb+mop9nC7x1bGhcjWIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EiJ1dArB4ami/ibrvoNhF/R/bLEHJxkGxex5Qfmmd6kKii9I5/ZbF+9KYW5m3UPEokg5z7V5Ga/RArP0jcTIoCWDqRPTTvNw7OOAblT5iX2gFId2s0CG2ad5xHB+B6ZRUxUSqRv91P3dALr9WHui7hWb9i8IMqoGpwwDRcu2NZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytv92VHf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytv92VHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37654C19425;
	Mon, 20 Apr 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722437;
	bh=EketaVvaIFDMszIe8GhAamMJb+mop9nC7x1bGhcjWIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ytv92VHfwj8kBxAajnhmD8FkQaq+hejZxXzz/e6LPKj4VgIesCNchFqMcS64yur/A
	 poprXKswZIdxAGeRWRl74SOxmQAIjjhRNGZgmOvclGLqztt5l/5bnbZq9jT+nHdCd5
	 GZRv+4NboLdov9QSwpHO27wrXFGt+HL0wHQ9z+afqyG09MO8g3OxdRZe4H1nnTTRe3
	 SeQ6hr4OeEY/WHvv6b5YpkCc7FObib7qZ79EiqAzjHm0ShX0vfrfQVceRcmQem991A
	 8TxKBu1iteGOePL6DwVNkxgImFfJ+JUi+OZ5qf3QlSjJMF5pbilDOSWghkzpHu2ZAW
	 /9Vvtp7gTLDOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BAAFB3930022;
	Mon, 20 Apr 2026 22:00:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/btpclient: Add BTP_OP_BAP_DISCOVER support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177672240132.1802062.9137474047862464607.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 22:00:01 +0000
References: <20260416184914.145135-1-frederic.danis@collabora.com>
In-Reply-To: <20260416184914.145135-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Apr 2026 20:49:14 +0200 you wrote:
> BAP/CL/CGGIT/SER/BV-01-C expects IUT to discover the services before
> continuation.
> 
> This reduces connection time for the BAP tests.
> ---
>  Makefile.tools          |   1 +
>  client/btpclient/bap.c  | 109 ++++++++++++++++++++++++++++++++++++++++
>  client/btpclient/bap.h  |  13 +++++
>  client/btpclient/core.c |  15 ++++++
>  src/shared/btp.h        |  16 ++++++
>  5 files changed, 154 insertions(+)
>  create mode 100644 client/btpclient/bap.c
>  create mode 100644 client/btpclient/bap.h

Here is the summary with links:
  - [BlueZ] client/btpclient: Add BTP_OP_BAP_DISCOVER support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b57658668c7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


