Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA14146018
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692624; cv=none; b=XhldKlfs73JmF5MFIPanqfe47B0kWeUnkq+SqKTNj/lq/86HyG3VtRuDmdoAPjs67Nuh0+Ksn+3/77dGwC6KaSL+FJsnKEs1laLrIPp/4qNDpDqif5g/e0kpNydS9gydaVub6g+5LK5cNi/Xnc7QiN/w/mCW7F/jARAl5Pxal7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692624; c=relaxed/simple;
	bh=tKTKf410O0x46/ibOfSXOiWCB/4KRd+8sIUdrYXA2sw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MOzrWJIh8cwCGZFa2uf6vGvzvGYky3uBrYNnTTDwHFCpdZItqkXQmMbcD419MH1I05owteb5UnLI5Ez8jA8VDWShUH+pGCMJ3vqRhuswzKUTPjjrbZRQQxi5C9KV+Yndmw2ZPw0NOcGJvrLmE7UGamtEYN6p4n8VOZ/SCDp0hWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdmx3cPs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdmx3cPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AEEC4CEC6;
	Wed, 23 Oct 2024 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729692623;
	bh=tKTKf410O0x46/ibOfSXOiWCB/4KRd+8sIUdrYXA2sw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kdmx3cPsD7KjnZyuB+BFaqJmZ3BhecCc0k8OkKnZZ3xN+ZDl2l1aGYcJ8B8rNebed
	 j1lAMjQqQOHMvRvxA5QIMl8ob3xtjqgzNXyKmBnBHv//Ql8+wTvGMr3LwcJB9yA+cU
	 DK2OcvbqIC+unFVXFbzBasS1BGnAMRvQNLrnJIFxg/slgCkxZyF3ecna+Mjubwm44h
	 V4t23KNSeFVLQRb5kZcQGBoNm3rwX1V7K1GI/at9llpf0wPua2s96lJwSxDe+TevwA
	 8h/so9/bqou5Q+NM205AnRWcS0gs+6UXxbPIP1YjvFn8QkZTudTlKmwgiwtRK6bpNz
	 U1FfFc0dVa+5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E693809A8A;
	Wed, 23 Oct 2024 14:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_core: Disable works on hci_unregister_dev
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172969263024.1607474.5878553827876943324.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 14:10:30 +0000
References: <20241022150913.1855164-1-luiz.dentz@gmail.com>
In-Reply-To: <20241022150913.1855164-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Oct 2024 11:09:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This make use of disable_work_* on hci_unregister_dev since the hci_dev is
> about to be freed new submissions are not disarable.
> 
> Fixes: 0d151a103775 ("Bluetooth: hci_core: cancel all works upon hci_unregister_dev()")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_core: Disable works on hci_unregister_dev
    https://git.kernel.org/bluetooth/bluetooth-next/c/92e242adc4ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


