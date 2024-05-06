Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48D156F28;
	Mon,  6 May 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014828; cv=none; b=WIoB1R6JfFW46xkMAzHxnWp40MamcY6IVMVbHfx28R4TSWD3YAXRt4tO/GOSSKp/yYTa4pfSo1gnM4sx2Wdq21nxrwP72t4y7SCVaz0w5sLmuYttOKFynGtYo7hOqmtyRNEGcvjbWRiiUAzDuogO5/O6MsHedo25E6GM+pnfFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014828; c=relaxed/simple;
	bh=vHsd79PfUgA+GN+RxuaEzU8r6S6xHi+0vSNnyqST6lY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DV8HKJUjLMw/ctVLJR+EsNrqP3e+2QDewFgoprghFBAdOCH9z3QFLf5H1b+UnwiaLX9+yOJPHmktCop+zukN99Rsra37ErNdi0UzAwx7Y+Z/R21CrskwWKQCB7aSNqMgWNJNTBLzTbH1V+7uAkY+Zgot1DMaqMjiAZc443Qwdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqDK3McT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqDK3McT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DED7C4AF63;
	Mon,  6 May 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715014828;
	bh=vHsd79PfUgA+GN+RxuaEzU8r6S6xHi+0vSNnyqST6lY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FqDK3McTEmy2OxsBFq+TTyRx++hYJR2WekDzaa51hu47/lHm4wVm6QODtzKIGknaL
	 +HH8WT/RHmIk0MigC5chldc7cUQ+LW77Tm+oHUHeN7KJ11Wrt9Yoz6UTomG3CGtnVI
	 9WoUrTW7AMEdE1Rs3mnnMVdhj5EaynmY9Ukzivj2mqUSIcE0+GG83Qfickr+XYsptZ
	 cvWbchE57Y5x023TrJjz3t2DgFVw8AL6AwUjrCbmtviQvWSZhcN1iL9k39kxRNNwLm
	 3hytvy5von0qTeZqembbZOCVWCkgd3ejk8UdfDAdvpLLlTyCF7NUXilfYC8xb8uqhd
	 Aa+FggLzRI1tg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1910CC43337;
	Mon,  6 May 2024 17:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: qca: Fix error code in qca_read_fw_build_info()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171501482809.13196.7620199307769330029.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 17:00:28 +0000
References: <515be96c-4c44-44d5-891f-fe57275e9f47@moroto.mountain>
In-Reply-To: <515be96c-4c44-44d5-891f-fe57275e9f47@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: johan+linaro@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 4 May 2024 14:25:43 +0300 you wrote:
> Return -ENOMEM on allocation failure.  Don't return success.
> 
> Fixes: cfc2a7747108 ("Bluetooth: qca: fix info leak when fetching fw build id")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/bluetooth/btqca.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: qca: Fix error code in qca_read_fw_build_info()
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ae8d9b9ea1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


