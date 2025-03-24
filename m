Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581822641D4
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835000; cv=none; b=eJl+60eOevO3h94MI3AqXWRQTnzUxGJC9ZiUZ1cvz0pm44URT/uJEhB3Ltorcn2qiCetIAf9ddX3hNF9AWQWtvn1dTBMIvO0/I2V19fY8vQpmfniqFv8gwaXR45r75TcVAQ+UFTgL5chcolDw0mXo/25IjP0m58TWQ+aZrBM0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835000; c=relaxed/simple;
	bh=P12zUGC81+nQ+3LmBF9tPaGAGiiqrjfuZSRjP+vOXhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WLTcFJVpzuyE/DVkQNlybzwOz6MEO3vXuyFnQKDOx2Y5th7LMR7bklIHmbvS4SSgupVjp7LTQO75MaPu6lEo8MML4HvQ9G5i+vTWYQqK4Aa/fdqx92Xqgcq4zmcUIGOUeMr2H9ScFsqOTiK4E1b0uS0liAT1iGaGZ9O2CPuYPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8xvA+6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8xvA+6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FD9C4CEDD;
	Mon, 24 Mar 2025 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834999;
	bh=P12zUGC81+nQ+3LmBF9tPaGAGiiqrjfuZSRjP+vOXhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T8xvA+6++7AwwXXei+5s3tTvw0KjBTTjfCssAPsrKTkUceNAkvESADXySwRP1nh4I
	 sJBlXYcgsO6+xyvo9iRUBELWqL5ai8gQaQzRxQIB2jaOOZ6sK7SeEeC4DlKD967dDC
	 Oj+b4c1HKVwlDE9FOfYOgX5MYJZipdIinETXm6QhMEPhBSwRuUZYtsJCEk1P1FHcyH
	 789MTvABrKujyZXHn06ZaljlXulUnUGWuJZxfyQ9ujm4g0qF5Gs8NKzuLLtlJWbclr
	 4WrsjM2Qdl+MNbFD1B0xunXz8vsasyUbK3dFyE3Ncm6eIa6uBE8dHCyTEUInzkjdqR
	 XjFL6bvQQLpzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34774380664D;
	Mon, 24 Mar 2025 16:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/5] mgmt-api: Add missing Device Flag
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174283503601.4093797.9637620850433944288.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 16:50:36 +0000
References: <20250324134920.2111414-1-luiz.dentz@gmail.com>
In-Reply-To: <20250324134920.2111414-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Mar 2025 09:49:16 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the missing Device Flag - Address Resolution = bit(2)
> ---
>  doc/mgmt-api.txt | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ,v3,1/5] mgmt-api: Add missing Device Flag
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e45343a37bf8
  - [BlueZ,v3,2/5] mgmt-api: Add LL Privacy setting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cf8b2f308e31
  - [BlueZ,v3,3/5] gatt-database: Fix always registering CentralAddressResolution
    (no matching commit)
  - [BlueZ,v3,4/5] mgmt-tester: Fix missing MGMT_SETTING_LL_PRIVACY
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=122c9fcacfa9
  - [BlueZ,v3,5/5] monitor: Add decoding of MGMT LL Privacy setting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=912e2f54fd57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


