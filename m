Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08A26FA5C
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898603; cv=none; b=KUq010LqJsWqsIC0MJhjIZhPBy4vttK/pi0MZXgfHL+vv70MAxx6/6z4K4zBIgrK0zMj7USrl9a/Kn/3lONQRB+u9X0iSl1uaXv+0QxuUj57J6VuXtCT+sBVmFphWS8d/m7Oo6TNFVTPj3uCoQVsGjSPzHgW9PbQZY9+yKo2ipU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898603; c=relaxed/simple;
	bh=Xkj0BjzL64L7hJXmFYkBM3DwFpZeM+eGd2VDzIajwmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=apR/ipZMAnrDsmFY8RHw/WrzErUvI2/2IbtWoWLnoO/9ceusPoMnWLlevod6HqxQfbaAcEB7Jv5zxvFL+GPhR4B5NR/RobgaggaUnw1TWEM3p6WVu4OXQjRMOkjCeFJSwbTlp7710YSmZZWvPcu+vCLkNOljsD7jCc82odJqk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R95xY9Ig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R95xY9Ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D76C4CEE2;
	Tue, 18 Feb 2025 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898602;
	bh=Xkj0BjzL64L7hJXmFYkBM3DwFpZeM+eGd2VDzIajwmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R95xY9IgWQDIs//kwBV/u/UfODOsAMZ9dEOKPbpE1p9GBnsgTV/eT0ieP5J6feJjT
	 N4XM6WBBmrA5H/QnMZi1oeur644hkd+elxgxwBn0+AuzLqlGA/mogamUhqK1+CkJjc
	 wbo28/iI+M4OefZ13z6fYev1Xft/jbUU9TcgnImIJoiLzFMdeiqPGqCHioXP4Nttmy
	 Z3lNCNfgYk5EWJ8ushW9korEuME0QKc0fpqCPfzVF9DJpnJLWWXoUfhsb2ItOBiAnL
	 y53O2UWkpVJGQ+wSlgsRJu+Jk/Em3rfRTgHq/r0D/ZoYrlqJ/JFMl6V2zUajSUphy4
	 fn798uYiFNQag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E51380AAE9;
	Tue, 18 Feb 2025 17:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] bthost: Set advertising intervals to valid value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173989863300.4153921.5964047381696200510.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 17:10:33 +0000
References: <20250215201329.173999-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20250215201329.173999-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 15 Feb 2025 21:13:29 +0100 you wrote:
> The range for LE advertising intervals shall be in range between 20 ms
> and 10,485,759.375 ms. Requesting other value should result in the
> unsupported feature or parameter value error code (0x11).
> 
> After the modification in fa4d477, the btdev emulator no longer accepts
> uninitialized LE advertising intervals. To fix that, set the default LE
> advertising interval to the lowest possible value - 20 ms - in order to
> minimize tests delay cause by device discovery.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] bthost: Set advertising intervals to valid value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3c62df13abbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


