Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982320E025
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998612; cv=none; b=UsVPkYaTKof53sLThCkkboj0Rlfo+zzfFB375lTMBPAEW87+XLbk5JmzEQ0QI2Ld3xDsGquLRy3huNdcMEfyiHew+U2BAfIEDlnyyyZeMfeTrql0wHeqB8JEoL5YqWYgCpSHYF5aQJ+xixhkxSb5dDI2diuexi5D4ffsQCrhEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998612; c=relaxed/simple;
	bh=i9debPfyabG3qaY0pVZ/5v4Vt3yNTCFVghCJ+k0F9NU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JXFa170dzxp/pcua1nnykw5vI32E6vWM1XrRe3qDJ19Qu0OXKKChoAB20f41GzubRVSOubAnKZc7QwNJaBWVU/oIPigFyVVJSIWBU7XP1FLFbCkHw0v5vUYcQuY0a/l4N8OtgzROge+Mlc+CFu4EeHFb+byXrsStSGIS+YJ8g/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLhUydjh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLhUydjh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AF2C4CEF1;
	Fri,  9 Jan 2026 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767998612;
	bh=i9debPfyabG3qaY0pVZ/5v4Vt3yNTCFVghCJ+k0F9NU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FLhUydjhY7g7CR9KKnfBNrP8R4pliNAd+W8PtrXzlpYn2luwG1YBFAmlMa0XyWQJu
	 8P7ntn2zQcD5aMBubpCbIVqdNqtHTHXgCL1DhAKUgZf+ImjF7+QZBG3THbGWh7OhVW
	 iqodiK7BFI5Tl1mJmRXmI21L0TqFrG6eRgY3TxLAOcK6HmWdg0Gd+oTNxKbBDDp3r9
	 H7KpyOqSoN2TfjkFyCVHi+P1yW6yQvjcE0e6Aj2/ZC0CBE2rntE5dwT1axNNYHZrn+
	 5YYouJr6NB03nDtXXQXNXS+Yki/Hvoe2vdD4w3RqlGPqvUQ5F+D+UHm0sSeMuPkWzQ
	 Udg+8GPm/wm+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78F5D3AA9A96;
	Fri,  9 Jan 2026 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] gatt-client: fix use-after-free
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176799840802.418288.2490552133540190635.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 22:40:08 +0000
References: <20260108100136.486675-1-dalegaard@gmail.com>
In-Reply-To: <20260108100136.486675-1-dalegaard@gmail.com>
To: Lasse Dalegaard <dalegaard@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Jan 2026 11:01:35 +0100 you wrote:
> Clients with an acquired characteristic subscription would free the
> client during disconnect. When notify_io_destroy then tries to remove
> the client, it'll use-after-free.
> 
> Add another reference when allocating the notify_io and unref it again
> in notify_io_destroy.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] gatt-client: fix use-after-free
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a94f994201a6
  - [BlueZ,2/2] device: fix memory leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=024b148d73ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


