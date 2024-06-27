Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205B819ADBC
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513631; cv=none; b=nfqeHtKRn3LUvQNIFE2GjXf7JBdCzzbAajPWUnugEbsBfCqkEyCxd+HeZJO8eXMeV3trZEMolxTnbiYYj7DX1jAZT+drUq5HGdJLPNYZpYGH2JBP1MN+2xQULzqCAuB3TZJeJ6wkkBG5yls3BpZJLlGy/QglJVBOp031wp1cv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513631; c=relaxed/simple;
	bh=cmRnVxacpOZ4UNedMVa3Rkr4xYMmWeAv3e3NWrbBf30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XXdsHwxSxY58NJvmhtPhaG1+DNHTxoLwriD6a7Vn1cz8Xl8QHnGgPoZ6CnIN/9uHc8ZhuNOkB4lEZZJ0llMA9XL1/3zpwCQxCsALN8Z/yAM0tVHGazhsSvRCvDDBla0OvI8oDIvFe8OWtSseGULYObJG0scRHyeT34uzXbQGUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXMYMuVc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXMYMuVc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8199AC4AF0A;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719513630;
	bh=cmRnVxacpOZ4UNedMVa3Rkr4xYMmWeAv3e3NWrbBf30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RXMYMuVcpmOGuWlgZXqKRkE2aoxciq9ZUMQoji/tyJIKa6Y4hhWXGdL3SPeGA2BYl
	 nLx8E2B4Xx9JvyS9wqS7jCWDSk2+/22wKvIDbi/7bK0y56vcOxa3plbJZzAJUrtqBj
	 bgY9CtJbS0Rt5FjSgpsdmVu1YU5RTafpohwjzR3Q054naJfiaE/YN4/y0pUW9Tuu9F
	 vX72kLMOzAKpSP6x17xHltHEqMSsqBrr0OM8/pMVwfZOAeisY/XUm3pSq7s7IHV9ZC
	 RpGlJaKGY4s9anK6M7Oc7mU6rTkIFJ5CZM74Mui9K/t+zV8B9+Dx1UiMZgwK3BVL+v
	 kjASJv+UsUqoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71D7FC43336;
	Thu, 27 Jun 2024 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] plugins/sixaxis: add NULL check in setup_device()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171951363046.21304.5216423130914448485.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 18:40:30 +0000
References: <20240627123935.67784-1-r.smirnov@omp.ru>
In-Reply-To: <20240627123935.67784-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Jun 2024 15:39:02 +0300 you wrote:
> btd_adapter_get_device() may return NULL on the next call stack:
> 
> btd_adapter_get_device()
>     adapter_create_device()
>         device_create()
>             device_new()
>                 g_try_malloc0()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] plugins/sixaxis: add NULL check in setup_device()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3616b776ae0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


