Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2056719ADB9
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513631; cv=none; b=qMUWkTjYJ4/daNAoY2CT1vQ5iFB6ZCjt6ZLprQJbcAaGc4tmznYP7hX62hcjdln8XGb+X0dB+fAqtLG4wI2Tn/R6igffON0eCdp/BNpEizgDF1omywGtgqC/lhSu82/iY+sePLE1Z4DTOVGq+VxmgCUF2pxkiVq80F7t4Zyl7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513631; c=relaxed/simple;
	bh=xE3c9EKMjNt+GminvfIaNSTxcXXMp7BsLq4A8ij+NYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X2LJZGRdRmDHDms3KjMy9sVeP1N5V2SSN/TMievbSkQkWsHmHrSH9EOS9yAZBsQMnW1Uzz1OubaE7K+hcunkemEg0DWoO0V8EcH1jAo4loQG4s9gmRqqfmyIV7FpDzeGQ4QpAf9IANWG6+pkpv3FSrAEssH8UkGmI5lRgHpMlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1+g6ftg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1+g6ftg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 960CFC4AF0B;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719513630;
	bh=xE3c9EKMjNt+GminvfIaNSTxcXXMp7BsLq4A8ij+NYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V1+g6ftgKSbeBAfifCvT07gYP9qLqbyvZfuRYvtDfugT8r4OmN72gIW2amEeN0vwO
	 gQqBmjGVJCjA5FRse75Jc51oU7BzqaDQDqIpFUumDRy2VEaoJz+BdWbRyWcZg7nsTw
	 PP5FuIIcu+ZN9E6R8Oa0+JVr98FoE4mhF5U25aI5O0tQpa2ZVH4UShzpxuvWLPedHp
	 2z3V5ukKKNoh/pMf15tTfy1kTMq8rpTLX3L+RVjKTCS1IqHh2n1C5J1ESDoIyAD/vj
	 0ARkUdllZMt5Ift1VY7TPtrPAIlfJfnYkfZ5rE15JadOhVGSE+XXAgLIxgrbGdfHkt
	 hEtBm4ZHIgdJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82CF6C43156;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] l2cap-tester: Add tests for multiple data
 packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171951363053.21304.7859779660797220564.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 18:40:30 +0000
References: <20240626150229.103047-1-luiz.dentz@gmail.com>
In-Reply-To: <20240626150229.103047-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 26 Jun 2024 11:02:27 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the following tests which cover the TX/RX of multiple
> packets (up to 32K):
> 
> L2CAP BR/EDR Client - Read 32k Success
> L2CAP BR/EDR Client - Write 32k Success
> L2CAP BR/EDR Server - Read 32k Success
> L2CAP BR/EDR Server - Write 32k Success
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] l2cap-tester: Add tests for multiple data packets
    (no matching commit)
  - [BlueZ,v1,2/3] bthost: Introduce bthost_add_l2cap_server_custom
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b6f8c0024a87
  - [BlueZ,v1,3/3] l2cap-tester: Add tests for multiple data packets over LE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=72c3f5bf1ce6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


