Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227731DDC3C
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127029; cv=none; b=szyFM4ugOS4bTsYlZ4mnCN77kNTmNSekd6MjrBfgqW5OOfYQNdOxRo+MCWyPPlAJQqvolOxG8r+lPZP9pFmmERdSNxTD/DfvzLWhPS+b3PrGs30sg8WBwnCPbkYLW94tMKbVL1fc9OBjImy3xnjjZpIF+zRFuk+8SlR04lSGTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127029; c=relaxed/simple;
	bh=ge4J82Tr9ZQ4ZWRYFo+Dv2O9QkDx0Qh5eSGVOMW2HUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DJI1nSj2o98hNtQLG+JSmiHFcua8ksS0eO6ziIwrteaPFerbx9pif5J+Hd+tnM34yypiT35mwvFChLZSZj9KdXSMfYLtTTJ/vs91SPtWkovKHkuQdhGLwoby2TxGQ5KET2Zv9r6MbMLlOCFGBZ2HWrJqxMievgxmvXYZAGeQNUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZP0n+kmO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZP0n+kmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB33C4CECD;
	Mon, 28 Oct 2024 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730127027;
	bh=ge4J82Tr9ZQ4ZWRYFo+Dv2O9QkDx0Qh5eSGVOMW2HUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZP0n+kmOjWXnrKRjzixXdR7Gdxvmj0vtnVyBM8LX03hB1q0IWaUOghbOpzbEtWO48
	 20TTO6LcAO92i1D1glEQMp8LQ/HyTomWhB9+UzZDMiT0iV0Qj/h4k92dOvXSbipyhP
	 K1ijItlWALeKmfd15uWx5t+aPrpRIsziI4i8Zy+RvD/KA0QS0eg+Dwx1qEVufLxqjN
	 pIymnGqZIWltypmF2kYwhyypLAjP9/6kj/wtB+hP/HmVv64x5tgBorwU5CfIAL718p
	 7eZE8frDrg7oDnB2A6LG4lIhpvzJOJn6qxCRXYX0tiBkxIrDDNm3GIeYW9edXm4FZ6
	 WrDyHeeGYKrWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3492D380AC1C;
	Mon, 28 Oct 2024 14:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] input: Add support for UserspaceHID=persist
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173012703474.76507.17008894458911278060.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 14:50:34 +0000
References: <20241025193011.3035565-1-luiz.dentz@gmail.com>
In-Reply-To: <20241025193011.3035565-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Oct 2024 15:30:11 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support supportfor persist mode via input.conf:UserspaceHID
> but don't default to it since this appears to create more problems than
> it solves.
> 
> Fixes: https://github.com/bluez/bluez/issues/983
> Fixes: https://github.com/bluez/bluez/issues/977
> Fixes: https://github.com/bluez/bluez/issues/949
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] input: Add support for UserspaceHID=persist
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1782bfd791f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


