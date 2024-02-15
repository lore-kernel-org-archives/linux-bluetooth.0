Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CB139565
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023028; cv=none; b=B//OkqcwNl2xjHF0mAfXmKG5k38FC0SkPIjAiNae+w7NwA9ZoKhWVreCbJIQvTwHAFvvn2CZpdsG//bAG853PfaPg2hamdwIQoc9ukQ44huetd8DuU5sVswrOvhG117tUjTwuDAhqmQn/IyynU9XSVG1tFZdG2QMq74b3nXBHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023028; c=relaxed/simple;
	bh=TtAXNz9QrmNFPoGYXUVbdXcAx73RbdmEg9GUAbq9LWs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iwKhqOP1w+P5t3WqVPGWLUQW5hIhBiZNUIN0Rktz12AaLlVtfaWvAEKgJnsfuHJRKHYDod04wRBGixaN236/zw7GopuiA4u89D+aiZ5811sK9RiXvcGxuzZcPjkfxWscIg+49AxzJfE1Dyq8zmrkhtJoimkV4ptpq04XMGR4KhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p08fOdUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p08fOdUb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29874C433F1;
	Thu, 15 Feb 2024 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708023028;
	bh=TtAXNz9QrmNFPoGYXUVbdXcAx73RbdmEg9GUAbq9LWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p08fOdUbX0cttJkptJ/oRLxk27ahMCJHIpX6LEivwAox2jqZDyHu903QctTbPrCkI
	 BMSrpJTIc5qvgQS4oR5D1W1qWVQLHUy+pT/aDSKF6f13RsmNfNUOVJfa6OAGf+z76n
	 TgYzc0dGppGVUmtzmUShn+SkSbeaUIJG5n31nYcV+Oj3djDIRiTR9sGAz8Lu3g7qKt
	 th17O/GfHtmPt6kgs+VM0dOZOFqZiRvhUQDqzGtOzNGdyYRYS8oql4XnAmWX9y0PPc
	 clgAk/1cz5zzv0N0e+oMGLPC750SJy4rhbE8woE8DWbCSK3Ry+qYpK9rGj/a5aALtD
	 WHOkR0Qtvog/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18C56D8C97E;
	Thu, 15 Feb 2024 18:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] btdev: Fix crash on page_timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170802302809.16192.13676361481138368553.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 18:50:28 +0000
References: <20240215145227.782554-1-luiz.dentz@gmail.com>
In-Reply-To: <20240215145227.782554-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 15 Feb 2024 09:52:26 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If remote device cannot be found after page_timeout then the code shall
> not proceed to call pending_conn_del.
> ---
>  emulator/btdev.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/2] btdev: Fix crash on page_timeout
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3c35ed835bd
  - [BlueZ,v1,2/2] rfcomm-tester: Fix crash on test-basic
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb339bde646c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


