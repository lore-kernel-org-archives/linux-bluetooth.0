Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8138F8F
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYIp/4J8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6BDDC433CB;
	Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703010537;
	bh=/2fhNeVjsJEvBowvGOnQAXuOQEOWNcJvM8d+ZHnvUQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CYIp/4J8zv5xtgcZk0ENUtYdjXRrQKIZXa3fE6hED22Z4F+RnVK3YRyZ0eIBMbcSl
	 eZXm3UF0bJa2ecgQOGp3Mn8SXtob48bJPHlVAGVQzxj3oVL7qY/N5mOVtPJ5MOv39i
	 1ghzUVVxmV3+zLRZrJV4WkHjdLdfauPaODLDbKMU7omcQ/dlvwJUD9tPNjWlkYDUiZ
	 PKTa6D883HQMCKCiyYnV2F4yMvYPJ6TVHt95VQBs0dflVz/L5HnvKOF8N+P5Bc6V8N
	 63hEN+SfQiYh3mZlaeWDWWl0q5Ue7L85rLbj0k2h13xah9CRL8WZa5WbO0HGLs+3V+
	 RwgC9S/HqTk+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACF0AC561EE;
	Tue, 19 Dec 2023 18:28:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix possible multiple reject send
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170301053770.15177.4455800246465589836.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 18:28:57 +0000
References: <20231219081022.41395-1-frederic.danis@collabora.com>
In-Reply-To: <20231219081022.41395-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Dec 2023 09:10:22 +0100 you wrote:
> In case of an incomplete command or a command with a null identifier 2
> reject packets will be sent, one with the identifier and one with 0.
> Consuming the data of the command will prevent it.
> This allows to send a reject packet for each corrupted command in a
> multi-command packet.
> 
> Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Fix possible multiple reject send
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff1bb03a94dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


