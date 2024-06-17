Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F3F198E98
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651433; cv=none; b=qLyLWdRxcTs2UU3SK5UtF6Tk75z1KJ4tOko4xdnR15NofrNsxEtZcn/7kUxaF/MBWUHRburwSpjOB5YxkRBZJ3ZvNoeMX1uVJDx/s/Ryb97Qfnk/KCYm8A/O9wTDT18nYMtJrwyAkbaCx0OW/By6oJTEhfoS0WrzMcw31sFutZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651433; c=relaxed/simple;
	bh=R6uaZ/LqJKjNfZA/c0GM9CP7/GT3XkLQDrZM+OUjzeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gpE3gkXAHdVOz3x1MeCRyc1kJVxiKVXSn++OSCSy/zyLWcwk/rVnsvSokDFSI69OghiYYIa51UKHuA9+46LB5dF94kHb34E76wpX7dHr6Wx58MetGTz3qoujKcPrP8O9R0BtBo6ZQ+9Q8fIsRvHeyIBnXal3TWfNGPG6cDgIo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ8USBF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ8USBF+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2786C4AF1C;
	Mon, 17 Jun 2024 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718651432;
	bh=R6uaZ/LqJKjNfZA/c0GM9CP7/GT3XkLQDrZM+OUjzeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VZ8USBF+jqf+UQgwa8qLm9bg6aEtno0laxoYsKqID6gPQHaZLXtHlPXa5JYWeypyv
	 kx4WxWLIvfMz5ysiZRQwMEK41jwXlahkwHLTcOMPiGuwqXCQp0vewkktfX1j2f7Fyk
	 Nu6aacQ5QJ/6MPv35Vd0BBNgasGe3t7AtRXh6N+J1ls/EKDkWHbvn4XZLYOapnc5Y6
	 RL2qyyOtFVpQOXA6RphEHuIu3uQbSSOG2Nkb6QZDLK6jfY6hABI8I6jMtebdxuCf2z
	 YE7CdR1ZU44+DHWuCfbSLPwPLwLS75MDTQAjCSf5IQ1FMMyprU9UOAqm7ZBvg0LtEq
	 eUewD2df7dhuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0F19C4936D;
	Mon, 17 Jun 2024 19:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: fix crash when freeing transport
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171865143265.1080.60294571697268947.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 19:10:32 +0000
References: <ee5b81f6306bb9ac014b02c028d159295acc469a.1718644267.git.pav@iki.fi>
In-Reply-To: <ee5b81f6306bb9ac014b02c028d159295acc469a.1718644267.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Jun 2024 20:11:53 +0300 you wrote:
> Fix UAF by freeing transport->remote_endpoint in media_transport_free,
> which also frees the struct (not in destroy after the struct is freed).
> 
> ERROR: AddressSanitizer: heap-use-after-free
> READ of size 8 at 0x508000022ab8 thread T0
>     #0 0x493624 in media_transport_destroy profiles/audio/transport.c:223
> ...
> freed by thread T0 here:
>     #1 0x7fb057d10294 in g_free (/lib64/libglib-2.0.so.0+0x5d294)
>     #2 0x49dd2d in media_transport_free profiles/audio/transport.c:1276
>     #3 0x7e0e99 in remove_interface gdbus/object.c:682
>     #4 0x7e8f40 in g_dbus_unregister_interface gdbus/object.c:1430
>     #5 0x4935a2 in media_transport_destroy profiles/audio/transport.c:220
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: fix crash when freeing transport
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87ad4c66b934

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


