Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779112F6F9A;
	Thu, 17 Jul 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762586; cv=none; b=dZzEOl+2MPjsJgM4djGcqL9JyyGuh/cKal0vOJF6uBGE2+o3U4bxxfE5ggBvEnjL+l700x++ZXeHtwCo6PpGZNT91kPRzkPFMA5T9HNQxfmG1WwLRkfAUiN+5LSA0D4TaqhVZj9o9SQfjl7RKtrV+cNdlMGWQ1hWhoPja96r7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762586; c=relaxed/simple;
	bh=SQc4JAJA9TBOgArSwTBKs5fkqRY451bGiBu8XgVPCrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LjkTTixU6//6mRuqDvNTkIyhVOMHXIVbaFftzMVJ0JWoG6A8Ntqs8rd8KE6EOuBT4YooJrJjqojjvG8PA/kCM/jdKVdFG38xWJrxBS8mNXFDDWfI/jBpUrzB9w3lQt5517xBnt96blweDN3yIuhyOnSk3Mo9H/WOjWGNexPNh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2ih8/BK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2ih8/BK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E04C4CEE3;
	Thu, 17 Jul 2025 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752762586;
	bh=SQc4JAJA9TBOgArSwTBKs5fkqRY451bGiBu8XgVPCrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u2ih8/BKNNnYsiOR0TXBL0lciQhgrOK1JeQlGbVxID8LezxLDDtXvfX2naN8kvQcW
	 tSxQ3L0B/sHyYe6fa6rcF+ZpApv+cTV8xytn36sLLjZuum2K9D0jFUjXvalOTGjnF9
	 Urpl1f9a2ct9x+eJdSngNNfTFD+hFHAypUmOqUzz/JfnZK36X9Vynjs4h6SyXYP2Gc
	 tt/gKMfyd5G3WZ4GIZrcbMPLDd4d39ciPDo2ExNr15CaxfSB1jkdE/Vo/MsidztKdB
	 z5AlwSKvKhrq9miTLYGKdymtbqOZ3dx15K9sP4n7fDbBVAPxmXH0TcGyR3z9FoHSa2
	 d2lOJiKbj1vKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D74383BF47;
	Thu, 17 Jul 2025 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: hci_sync: fix double free in
 'hci_discovery_filter_clear()'
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175276260601.1952378.8770858924188078776.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 14:30:06 +0000
References: <1313ef02-285a-7012-74eb-b6589d471be5@salutedevices.com>
In-Reply-To: <1313ef02-285a-7012-74eb-b6589d471be5@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, oxffffaa@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Jul 2025 22:23:58 +0300 you wrote:
> Function 'hci_discovery_filter_clear()' frees 'uuids' array and then
> sets it to NULL. There is a tiny chance of the following race:
> 
> 'hci_cmd_sync_work()'
> 
>  'update_passive_scan_sync()'
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: hci_sync: fix double free in 'hci_discovery_filter_clear()'
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd8174bd527e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


