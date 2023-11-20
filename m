Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C513FFB
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSMoIdxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1694C433C7;
	Mon, 20 Nov 2023 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700491825;
	bh=OYzB7lXsZ4ZSb4iYLuOKIqnfP6VLR6CoNpU4iUqhcmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BSMoIdxQnkYyhRESCKp/xirnWujc6RkSXyph+y1e8pvHqZy7OyiYOlbMO6BmzJF3C
	 I5Stzx12W1aEwkgjk3XqY0STp4x73637Y3X1Tw1v6UYh1pOgbCjUPYnfHHogr9vWM7
	 TPlhAxsLcP0YCVZ6MDX/NLg87C+8gI6ZfBtMMQqanV1AEuyjGZVfxwOYDnATeNodkJ
	 7iU1R0p5Vr0XnhIVqvvgX2s67StfGBd6mCLfQK9ZuaK3aKFFHQxlOz7CQMpd9cS8yu
	 reZsRfDTAx049VDdyvgzwsvQcVwGlELS8kkzuado74BJcNk8LFASeZoK+VQSq4JUg9
	 Ft6xYYq2ohFwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5EBEEAA95F;
	Mon, 20 Nov 2023 14:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/shell: Remove readline color escapes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170049182487.24101.17324645955062284886.git-patchwork-notify@kernel.org>
Date: Mon, 20 Nov 2023 14:50:24 +0000
References: <20231117220506.273238-1-luiz.dentz@gmail.com>
In-Reply-To: <20231117220506.273238-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 Nov 2023 17:05:06 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This removes readline color escapes from color defines and instead only
> used them with prompt since they are only really useful when readline
> is rendering the text, so it can calculate the prompt length properly.
> 
> Fixes: https://github.com/bluez/bluez/issues/10
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/shell: Remove readline color escapes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d8fc0dd5942e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


