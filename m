Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A54306B18
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685999; cv=none; b=PfwwGu70nut4vIRgkgP/OK21lTTa5xAVJZEunxZuD0eogXWOQHM8Nz8gCvX8BcTOQLdUHNjvO/xh1kOvxCH+4zVJXTPD6IOOj4TE2WZeoVHP7Lf7UdzQmkmi+WF2Uo5rUGPBPdif4Q7fggFrYsc5VRHkDgAN8KReu8YPg/Qi878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685999; c=relaxed/simple;
	bh=Cj7/3S3H8RZXNqmz1aLT7BXBDcSSf+Evo6Y3Bn8Hfc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JK9rK5czEAuob01b+ZCpljBfX72Uc9OYp84e8YTpJAK2IYVKIzMLnuAj6Mr/gjDYVIjSLkvXV55KOCTK+rAUMplN68bodToSdI+2dnH4+eDDz1ZQNDjvyOwJX/P1ZbEjncixGt4s8oKO0UjkfFgHHfZcVfg630MsRPsWg9NZoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0HFBHZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0HFBHZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6299C116B1;
	Tue,  2 Dec 2025 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764685998;
	bh=Cj7/3S3H8RZXNqmz1aLT7BXBDcSSf+Evo6Y3Bn8Hfc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P0HFBHZcsLDHB0fewrpQQEBv0gyPqoPUaAkgeoK/oz3o+yJ0ck67qhCSrsUMZb5O3
	 dNeUX5xBFrKJHKu89ZWJhYFUuZeiO44/9seNSuSURX2X4B/7gtXJqRoYTwzuUIaFnK
	 w78bSd4pTMQ0rXYR4vom/yclwIK6qkKh5ZIgDISk1T1QUTvXz25y+c9E631UeaPx3T
	 VGP/2KdH2SRa5y2YjZ+VYgY/ECKxVJFZrBXKnDfVENIc+L+4JUIi977yCW243ZA+m3
	 XtZ4LxuTdhciN7jm16Mo9iWgciQfGnHXlKEIQSvN27jYGYWrSgqfGxsj9cmmZdUZhg
	 A7FnvonEzqxGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78C3C3A54A16;
	Tue,  2 Dec 2025 14:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: Print
 MediaEndpoint.SupportedFeatures
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176468581802.3250289.13474236152923619585.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 14:30:18 +0000
References: <20251201180608.168392-1-luiz.dentz@gmail.com>
In-Reply-To: <20251201180608.168392-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Dec 2025 13:06:08 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes command endpoint.show print the MediaEndpoint interface
> property SupportedFeatures.
> ---
>  client/player.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ,v1] client/player: Print MediaEndpoint.SupportedFeatures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b9d8c388442

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


