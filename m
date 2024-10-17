Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D141DED54;
	Thu, 17 Oct 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180824; cv=none; b=OOmLfbvFA/EFogj5zshF6U3rmQN00LTyGvqQomAjuLP9DFzpovROahlHTKlwgX1wZIkZSlySCOc49XM671kRzaIa6aaqk7pngTtp/T8m17lxEJNC+MyetD1sFoyH4uzrLezYQEMlvI75uOLxQ2MPuhqmYaBG8cHW7qkoZo6YTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180824; c=relaxed/simple;
	bh=HWZ/+LpmEe+1A0we3KErLmK+BvF/9MtyVPilNRg8TTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rLSZ6bmP3DhThhbOepuXL6ell22iecQpOROmYAZGDThYnV0Mb4z/VbMsa5n7hm9G7gJWag9gdMyGXrsiegpbW0ffwcm+GpJCXLsfZL+iHO3VsuryE+POHl8/yXfhisZD3xgNqx/TAX+u5OC2KlNs51h3jxpjnuS0s7AW6iCQ1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YosQOlrJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YosQOlrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490A0C4CEC3;
	Thu, 17 Oct 2024 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729180824;
	bh=HWZ/+LpmEe+1A0we3KErLmK+BvF/9MtyVPilNRg8TTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YosQOlrJnzgfIBzM0XUJ5evn4SfuaI6xB7/S9V8XnC6REV0dSSHRcYPci+0gY7XUc
	 hnCIdqGL4K8ccYqGYirzdS6/IGhbnvFxmDi87Om4tx6SEbn9q+BpZlcrxXZwaey9Sh
	 TN7glTJ16i3+r5AZDwKTnu1FMq1O4v2CgZH+qCc7vKBbL3QBELv1IsFDUREn1eL2pO
	 Zpp0APcemoWKJ8sWKf+XyiHq3CUAp+Jr59gBeuz9/IPdXtI3j8yWb9Gpw0ibj2Qa+E
	 5JZsniqE6ja4tyz6w370ibMD14/aRmLWgDj9ImCjjG21Ml0ByO7Q586GFZK37DX7Wv
	 AVnyLIkjEvQhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD643809A8A;
	Thu, 17 Oct 2024 16:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3][next] Bluetooth: btintel_pcie: Remove structually deadcode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172918082975.2518908.12349114260012492384.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 16:00:29 +0000
References: <20241015193013.16790-1-everestkc@everestkc.com.np>
In-Reply-To: <20241015193013.16790-1-everestkc@everestkc.com.np>
To: Everest K.C. <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, skhan@linuxfoundation.org,
 kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Oct 2024 13:30:12 -0600 you wrote:
> The switch case statement has a default branch. Thus, the return
> statement at the end of the function can never be reached.
> Fix it by removing the return statement at the end of the
> function.
> 
> This issue was reported by Coverity Scan.
> 
> [...]

Here is the summary with links:
  - [V3,next] Bluetooth: btintel_pcie: Remove structually deadcode
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f66f6498463

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


