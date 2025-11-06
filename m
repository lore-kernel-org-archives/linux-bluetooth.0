Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A41DA0E1
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471840; cv=none; b=quXs/QHqjEGYjP8UUPzB1PN0VT1bJEz5hquz915kHCa5CQiSIRgp93GkhZk7uWWzIFN3UueD7/t+gqGqJS993y4TZeJtasYjbbRs2J3I49cLlO4kU5srXz62r47sFx4TBLmhUREi2aNx9zvYMar4R3y4dPtlpg9KJb79vuIGtZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471840; c=relaxed/simple;
	bh=46wOFF9KaLBoqZslKgbrQ59XmAqV3tJCu8w6LtQlwdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QbTFSfagXj8JRmrKZiKc7sL7os4Ml4KDd1+YLAm27k5mz6vwjle3H4RjXPMvC9BXJ8dzcouS2bBiIm/BYZ/DyUaUi+kVxdnsrjGuN4bLbLdCRVYv/BFhqCaq6awfRsgHDNQHHJZtN53keRyTGJ/qp/G+vRL7w6MxFQQ8/Go8FFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abWQX6an; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abWQX6an"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72866C113D0;
	Thu,  6 Nov 2025 23:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762471839;
	bh=46wOFF9KaLBoqZslKgbrQ59XmAqV3tJCu8w6LtQlwdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=abWQX6anB4mAT3Dav4mZl+szspd4UP8b3ZFFXXiEsPQP7lN8suugQ/x+jvfnr7TIP
	 bVoEpCd0zd64ImaUjGprtcardAkSSmGdPdmfOePQvq4DmQvCYZNS0My8JKED1H72vv
	 Jv99WxjsBRaHBxHmX/wgYnuUSQbOsqIW4jmjZG3UdHE0IcqjLjZoegKKZtuwbc3wbq
	 Z3B4X8jsLdPkI8o6rI3aPhqtBXWeWle3v2z2Jw80JQyfwAJCSr3uf9ijpiFkAuQhxB
	 leDLYG6A7y4h2GeOuTHdHInjfajC3f/mOvBmJfZApv1Ee7TkOyvryCVh4ERDBxmOKw
	 9H7wqKc56pk6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7115A39EF971;
	Thu,  6 Nov 2025 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] github/stale: Fix not removing stale tag when an
 issue is updated
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176247181223.389669.15759803989474821713.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 23:30:12 +0000
References: <20251106162615.745878-1-luiz.dentz@gmail.com>
In-Reply-To: <20251106162615.745878-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  6 Nov 2025 11:26:15 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> In order for stale action to automatically remove stale label from
> issues it requires the following permissions:
> 
> issues: write and pull-requests: write
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] github/stale: Fix not removing stale tag when an issue is updated
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ec5819b88281

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


