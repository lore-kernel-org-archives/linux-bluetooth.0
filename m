Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4E1E482
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986629; cv=none; b=RNP2rH9cku48BQ+taUJteHUHszeA57tx9ptO0coh9DiMnJIxAVo6Um1Mbphy3N3KHLKAraDmxeUC9K/DuYOQ5mWzEICZrSTgz89KHdOlDuI9ZFVRGYD5Zp4uAFGdYXDOgz5FLY1vt3KEIr/JGGVNHU49GSU/5rzBa5qHrPFn/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986629; c=relaxed/simple;
	bh=W5wKrIpi0IAePrKWX8IDo1oFj5igPDD5g/goozOtPgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t73inNuDny3bZXzcFjhOTFXUaPdo/5teWSPaPpPeTxnoZsz9m0JeP75uXGtCnsM++J0nHb8Ut2EsEFKFCnCkfJOrkzUAHu4Cjn8j20u6+GaZC493P6thwyG4wS437MsuE+x5jtDtThjvg0Upcs+g5mTSjbod+ZYG57MG0PhoRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZHwU5pj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZHwU5pj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27CC0C43390;
	Mon, 26 Feb 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708986629;
	bh=W5wKrIpi0IAePrKWX8IDo1oFj5igPDD5g/goozOtPgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PZHwU5pjkuWX9G6QdvKGY9QBp+1lmt1bNilNG/OwadsA1RXeEZi4y6TxySK+twK5q
	 HRwndSE5zvYQB4FOl1tvdLM0Q3COZPsF9QS6wNRkcrIkfErsG5d/KosZ3bKWbyLzpV
	 L2rlPVRzhuuozFozjiVSXKmsSUm//v+GfUooLOTWmeGIBWUUo0OTvH9q57Maol5NuF
	 L91MxeJhnFRLyutHf8bbP6sRheHhh8Jy24nFd3R/9V2C01T9L3PiEAZ0O1654Nu/Vx
	 S4RonmNeQUuX4OvOW8OOkLaxFW+6yUdc9I65/jYwphIqfR/7SrJBaj68f2JYYkQIlC
	 gpRVWnsvYRbwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3092D88FB0;
	Mon, 26 Feb 2024 22:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez PATCH] advertising: Fix assigning mgmt callback id when adding
 advertisement
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170898662899.28930.17824404889345923273.git-patchwork-notify@kernel.org>
Date: Mon, 26 Feb 2024 22:30:28 +0000
References: <20240226132201.Bluez.1.I8d368be0c7f86e8a999fccc33f8c9742b405bcea@changeid>
In-Reply-To: <20240226132201.Bluez.1.I8d368be0c7f86e8a999fccc33f8c9742b405bcea@changeid>
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 johan.hedberg@gmail.com, marcel@holtmann.org,
 chromeos-bluetooth-upstreaming@chromium.org, apusaka@chromium.org,
 chharry@google.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Feb 2024 13:22:01 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> A struct member add_adv_id is used to track whether the adv client is
> still needed for some mgmt callback. This is checked when freeing the
> client to avoid UAF. We currently only set this member if we have a
> callback after calling mgmt_send.
> 
> [...]

Here is the summary with links:
  - [Bluez] advertising: Fix assigning mgmt callback id when adding advertisement
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c01c40498cfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


