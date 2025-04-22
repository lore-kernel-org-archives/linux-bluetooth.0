Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CD1EE010
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313036; cv=none; b=qqsuiRVahpp5Q6KXbDIwQOi81uLa869vk5aNdAUAfh4dCZkdQvJtw9GVTuc6dy7WgKoBPJpasRXaVA6tgQ8LKryHMA+axWGgAS47OsAgVQ2lj9+lTe49VxExVLslHO0GsJDv9uS0keEzqWnZER6jHZM2aLFMcH+7MbM/4+WZWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313036; c=relaxed/simple;
	bh=CfX4edD9gnO+iCraUxcoiQgOsKXoKK122Gh4xHiiMlo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RwMbJCFZ5e+7ss5g/bG5bhwMIm05ZXFnwYhOVysl08MM28vW1tC4OPbiIIZ2V2mr1C/bb/W1fOqQo+C5RtMg8BFpv0I5+MggCatCl/Ypr9FYHNi6sFxF0WzojUwVrXfDjfRSyFbZ0JBBSneePCtR0dvjDFITaN0Bjxt8Kn36l/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz5vw8GE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz5vw8GE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFF2C4CEE9;
	Tue, 22 Apr 2025 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313035;
	bh=CfX4edD9gnO+iCraUxcoiQgOsKXoKK122Gh4xHiiMlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lz5vw8GE3TXavB6BiukWABW5WMTUcG+uM0w1wOlfxMu8IUq3UyFmg9Xbc/U8GJXLw
	 d9KM+6NmAzsIdkBC//nQixrkPYNqhTJoqNmSkdfUDn5MZ8RimHk6l6xymfeb4BAa74
	 uTy1aaMBqRpLYpkviKlfdmlLm95iJyEAJVVKvyP+G65qQoEXwmgBDwGgecdtf+SP7d
	 VFjkf4YdUwsk1e0+4UnOF3FdrNwkuvTdVYnW1TUYD5wTdVQXajUsrxEp8Er+UTYO+0
	 wqLfPwXrhD+NzTs62XJyjkOTr99EiFxbYx+0x/QJLt1QlpXG+LunDdQ1of5jsNB8uy
	 3YX1Pn1IxB3YA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7D39D6546;
	Tue, 22 Apr 2025 09:11:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/gatt-db: fix crash on bad attribute index in
 get_char_data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174531307398.1477965.13558244241637904118.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:11:13 +0000
References: <dd2290eb0393dc0c9978c94ad07ad6ae06ea3115.1745184652.git.pav@iki.fi>
In-Reply-To: <dd2290eb0393dc0c9978c94ad07ad6ae06ea3115.1745184652.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Apr 2025 00:36:32 +0300 you wrote:
> Fix AddressSanitizer: heap-buffer-overflow when index == 0.
> ---
>  src/shared/gatt-db.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/gatt-db: fix crash on bad attribute index in get_char_data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=73ae3fb93d27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


