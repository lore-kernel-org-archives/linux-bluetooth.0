Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238912BE7C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513417; cv=none; b=inlGrzY3iQUsHix1MvnP3mnqbD8IBMHbdam6sD3DNMSIYn4lqoGLtQnrtPKIQl9oOJ4zT70npjFRziOtr6wJ+DVA+ud4FM2oB0BMQeJJTX7ONxhk15prLFXgciA9288fVlbp0g6G2z6PRKpkANheh29WxUwPQeUdDWgPtIA+WsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513417; c=relaxed/simple;
	bh=Cppl4MAcXwlYpcXtV7QOAHffy1N9QY0up2pAs8IjpDk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eGiX7sq0kPpSSZmkaT7479u1F5PGwUJMX5NquxGrTZn0lEAI/W+aD2WlLcazJg+WiBEZ+QQgZZOOkYLxSmWnEA1BK8DVcv4EZTOhmrMGwAP5C3H94GWxb3h3ALGjBeyn4rDl3sJAJUJM+SbVtzIqa3eoyskU2psw/p9BaYBFKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSYatF/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSYatF/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE69BC116D0;
	Thu, 15 Jan 2026 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768513417;
	bh=Cppl4MAcXwlYpcXtV7QOAHffy1N9QY0up2pAs8IjpDk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PSYatF/uKKlnoAEmTGYNKHVJD85G3gLXkzYyVFNgAtGRWHZCOkcT56AMoFxevCKBz
	 nqSL5Y9F5VCkofwX7eVvAdujP6RjNrKTTZxqd6q0Rb8CmtgyK4eCjkFXqUpcttlqs1
	 f9t7HRDqBem5hAenYD7TsoAMOLWFsOhuyD9UoHx73hnGrwm/TXaHFn3QhzUX3rYVvh
	 vTWaUzhKqj/hqkuHNRMGxElM2oeej5uJtcxHWd6D/JF9PxA5uoK8GdJE3EAXQ3gs91
	 KC0Ek1WMppjcppgi/yFI634b3S/K07LLPIchQ/W9KptV8gtIQTBy/IXGEqJB/CHNeD
	 l7suzLXbcSiyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B842380AA42;
	Thu, 15 Jan 2026 21:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/btp: Fix typo
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176851320897.4178208.16754173352835559041.git-patchwork-notify@kernel.org>
Date: Thu, 15 Jan 2026 21:40:08 +0000
References: <20260115143859.12834-1-frederic.danis@collabora.com>
In-Reply-To: <20260115143859.12834-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Jan 2026 15:38:59 +0100 you wrote:
> ---
>  src/shared/btp.h     | 2 +-
>  tools/btpclient.c    | 6 +++---
>  tools/btpclientctl.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/btp: Fix typo
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=64208980a374

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


