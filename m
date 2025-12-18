Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B8345CD6
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090596; cv=none; b=ZeuIuFebGGRM3hLPTzvS5iFBsqb9L99L7vNdsMKmcvqnkPEs9K1y9jrq9S2uuhQSacHPq3C7zPErfmPvnysBU8XBZKoRc9KHuuli/Ac/g3Fm3M8S1t0S70quWPw0oe/0JHlvPFU4/x8bCvutRfE1bAnf1PwFEMr6MKzB7f1+fUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090596; c=relaxed/simple;
	bh=59En6GFuc3oIAVaPsAZNik584DzkZ9v7sm/WEtcp9fI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MpX0B4BEWegvpIB0Ko/vwAWTpsSsMOPxk3uKNUhTbJIWNGmTYr+0Kf0e/KgrLRcx7C5LekXBUP4V1ndFWwt6H2XTo6KqIseURbRLvO7053X9/0i7+aOVivPhK/37Hgc54nCnnSk8YeHUEWbZMOg17HfOH3NKo1KYCddwnerVmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGJH0aEV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGJH0aEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5ADC113D0;
	Thu, 18 Dec 2025 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090595;
	bh=59En6GFuc3oIAVaPsAZNik584DzkZ9v7sm/WEtcp9fI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iGJH0aEVLXNLSGBdwBR8goipy5/edJ9zplPYOhNKMx8Q66eWyGZX0pcG20OQNNjw1
	 Ov9S49yE2asEVLeQ1UMCpsrEBzlKLMC9heMzt0pIAtU2JSixXtyFZeCCDBdjM9VNlF
	 0LHE/GOpo6y6REZpL9Q+6lcfqJB1qhZ9aFUvC9usqE5VDLPMKtx3l8JsFNL3ZP7hKK
	 xuE417yaaenJq1m+aNeARGgOrM80uaffai+k10RpEv1TBoJrf8OXvMB/V8ij0br3n+
	 U5s9ZwIEMsk5WlvPyDHN31d/SKlMZxeejHYHHkEEzcvrvk27UZHQwSX3mgAxjDuAx5
	 LeOf/ptIXu31w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7920C380AA42;
	Thu, 18 Dec 2025 20:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Add support for setting BT_PHY
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176609040502.3123984.680361473507723473.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 20:40:05 +0000
References: <20251218192159.624935-1-luiz.dentz@gmail.com>
In-Reply-To: <20251218192159.624935-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 18 Dec 2025 14:21:59 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This enables client to use setsockopt(BT_PHY) to set the connection
> packet type/PHY:
> 
> Example setting BT_PHY_BR_1M_1SLOT:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Add support for setting BT_PHY
    https://git.kernel.org/bluetooth/bluetooth-next/c/98246938a0e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


