Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50D1A255C
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737137412; cv=none; b=nwz1zORdEl6KV6FQsh6WogM/t8hZaNcOxgdtJ58RR/AYCL8r8lLDEJH+bcuGuO9Vkc0k1sUsXWTx/NrlF0Uw1QPGg5xWh4mSj0D/i6edTrWvzj5UgmTDULqkWkWCx+8O5nov/62vIB7Coxk0p2DTJ68OtUGUZ+8v3iTsND+xVcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737137412; c=relaxed/simple;
	bh=GCpfCAfLLiNYH7Bwi6+zJcs1Lq4OUdqVC7T2pUxwhrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AwZj4jcOKEzC55sth+Nqa6KaF7p/caVytZtoYG7F9q0r8HaIepEJwJoRe3WLqJIJExnrNXOTNVuOK/JvF0xZA3uKdF6axnJNbaf5ORRBC0jiV7KxBqNnabaR6XS+b+VOM6deFpnB8vjE13H0VGJVjH7iRD0fZpGPuATrMpLQfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyWQ0fK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyWQ0fK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9690EC4CEDD;
	Fri, 17 Jan 2025 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737137411;
	bh=GCpfCAfLLiNYH7Bwi6+zJcs1Lq4OUdqVC7T2pUxwhrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CyWQ0fK1Tw4SpmzD2ORHoOCQOyeu3botUFQWboEHN1ybSR5PHzc+BroUlAsasCVhX
	 tdMQTMHia2ETaPfH01uSzsTqrBpPxc9VbrFu5Np3siXHTS1KID2weWaxWZE2kq/zJG
	 L7y0MQsoL2Y8rEV2qnXv0TLnOpMwLLlrRRyiFwYIkNgBHJUkgJ6jUTm+bwV9avmKJ9
	 0OYdw7IeZTJYIvopVMEqJoFGYmBr0T6lNp7K/eEFrJZUHgsZAysXvjg5Huy9rL10om
	 AMfqWokbtxNlsHiq8jje+42SRGCWbBpiIZBkPNLuk/jEJI1strVyfA8U46Egmzdw3I
	 K1QkA6D1X2xgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35742380AA6A;
	Fri, 17 Jan 2025 18:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/shell: Always set stdout to be line buffered
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173713743474.2213962.1755117778346019806.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 18:10:34 +0000
References: <20250116203900.3722253-1-luiz.dentz@gmail.com>
In-Reply-To: <20250116203900.3722253-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Jan 2025 15:39:00 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This always set stdout to be line buffered to avoid cluttering the
> output:
> 
> https://github.com/bluez/bluez/issues/747#issuecomment-2596840382
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/shell: Always set stdout to be line buffered
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07c14fcfbd8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


