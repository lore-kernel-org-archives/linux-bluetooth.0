Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C61AF0A4
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497015; cv=none; b=f+l+Znw38B4nhxRtPlOEcmg6UD6ERoIUHpFl0uZURygKySVvs4GjWg5uCC0QOq0gl6+RtMowGq3w/vfrvzAm7h9yqVqSf5FuAzaKhK9+JqSbxPsXmXQGOHdNTF+fsgg32M6IHJ5Dn/toarNmOoVWtGQQiFazpV9rEDKIkn1gkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497015; c=relaxed/simple;
	bh=I3z53h4oxzNVpihvB8ChcPNOklYwAmQgiI0At3pSWb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsKRmXQp7J6S6iAqPOLdg8MBmgfaSp4Z7+OE0u0L/WttmrKSf/qUv6lXW7Z0yCR0iKt+c7d9/HHvTwOJmxjBRM7Y6LTfDpVjX2R5cn8bSYVHN9CYrejGGkXVD27rLVxvIZ4Pb5+Lhg5wFGcobcmASv8R1FOFKRRgbvw+4/kua5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMMnu3zF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMMnu3zF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9E1C4CEF5;
	Fri,  3 Oct 2025 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759497014;
	bh=I3z53h4oxzNVpihvB8ChcPNOklYwAmQgiI0At3pSWb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GMMnu3zFEw+9wmy6xuG0GNoK6kmMvRKFf4ObBZX5/0JWEUwMNR6xR5ibVymP4ajLz
	 5gW93fTOsWkCRcKXQogftB0PJkSV/O1lxKZukZu2GbQEvhh8sW0TV5fqmLt3giQfU9
	 ajvc4Ea3wMoynux22tZzp+k1So5zS74iLgfDNH0gO2jhP52FrbU92jtTqyKPqGYMlM
	 O5S+DmvDcjENhBsdSJ1NQWTHkiAwgea/Mz9Jksg3wOcanaUl/CF5keM4cyIVkZ5V+h
	 kO85v9FxhEYD7OIAsEE3JOjRY0ExC9og1j2AIVwT9oZHWVvckpa/LUx8sMpQmsbyLI
	 ceCDBB5d3k31Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711B039D0C1A;
	Fri,  3 Oct 2025 13:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: HCI: Fix tracking of advertisement
 set/instance
 0x00
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175949700627.4115234.7584241190986847936.git-patchwork-notify@kernel.org>
Date: Fri, 03 Oct 2025 13:10:06 +0000
References: <20251002195313.303358-1-luiz.dentz@gmail.com>
In-Reply-To: <20251002195313.303358-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  2 Oct 2025 15:53:13 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the state tracking of advertisement set/instance 0x00 which
> is considered a legacy instance and is not tracked individually by
> adv_instances list, previously it was assumed that hci_dev itself would
> track it via HCI_LE_ADV but that is a global state not specifc to
> instance 0x00, so to fix it a new flag is introduced that only tracks the
> state of instance 0x00.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
    https://git.kernel.org/bluetooth/bluetooth-next/c/164e3e096390

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


