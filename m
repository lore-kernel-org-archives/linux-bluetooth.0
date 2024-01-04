Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE620DFF
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoY2EdOy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2342C433CA;
	Thu,  4 Jan 2024 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704384626;
	bh=1OG7w1gpUF3QXO4AW/JTowDm5jQS7iB8T/95W2oQQ4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VoY2EdOynrwzT2evr5N/m2HBxfCUqJLrQGwzzSOKNTVeIV8zGdeLJkfn+mMpm/Dl6
	 /vcN6WJ6y+JIp1qa+2awJToweSW1rUAqacFI67uvnI5w8iIOl00fXPAF0ZG4Sk71ei
	 7W+uUknEf9bLiaV2yQLTmJWQ3rTSiuOc108GH19A9Vj2PMbAcTjRzs8zBa+O4iORVS
	 KxzZByN+4O+Bdf3+jWSUoZvxk0Uqp+I0cWvbxxLxMOU5wqM8VYRP9GgG1V/zRDA1CK
	 gLxu7D3oFBbN8gDrIQ9Y9jC1BbC5EV7tINBx1m5bmth9biOO/BnEB4gE6bCVNJhcg8
	 +a1V8YqYN36XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1A5CC3959F;
	Thu,  4 Jan 2024 16:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] audio: transport: Fix crash on A2DP suspend
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170438462677.32236.8083382052140471903.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 16:10:26 +0000
References: <20240103205124.3839768-1-luiz.dentz@gmail.com>
In-Reply-To: <20240103205124.3839768-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Jan 2024 15:51:22 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Commit 052534ae07b8 ("transport: Update transport release flow for
> bcast src") introduced a crash where it assumes transport->data always
> refers to struct bap_transport which causes a crash when the transport
> is in fact A2DP.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] audio: transport: Fix crash on A2DP suspend
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=36f057d7f66c
  - [BlueZ,v2,2/3] audio/transport: Refactor transport operations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e4764af76228
  - [BlueZ,v2,3/3] audio/transport: Fix runtime error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1c321baca781

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


