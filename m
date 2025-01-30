Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C41EE03B
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254605; cv=none; b=uQGbceaxQPsOYKLKYPX3LdjkX3rKJ7Q/3C4sbARPYpadl+XbHQrnmArYwhdF7JZfecLE/KHgjlLhKBLE423PsWCI1+f4fQVTg+z+GxHmOl1F9fxq8XXhS8la/VTBhB+fc62DmfFavTSG1OtUDyaRO/tD81b08GYgdC6Z9/026co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254605; c=relaxed/simple;
	bh=C45Ih2QZy98HA4GC4HGk6WKQVhGGk4k/qpmWI7O/zMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mk4ADIpkmL2sgdrJIqGegV6Dzma0tl5avUyc1Ofo58p0ZJKHkl10ylBdKThctvfj3j1V/MpmcUAXkcCA7Jnxyw9SgOEEZKpX8j55yydrasOUcsCUqev/Iy/TPkZiTi+pYpmFwfbf6LlbvO9P2BCrQeq1dv0nog5Dt/AkOrv+SGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF3sUo/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF3sUo/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B802C4CED2;
	Thu, 30 Jan 2025 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738254605;
	bh=C45Ih2QZy98HA4GC4HGk6WKQVhGGk4k/qpmWI7O/zMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bF3sUo/MW3W54L0qrMEsUIMSm3bLb5isr5TSyH//WbemJrt13bFzFtXkPST2KkK8Q
	 qLAXNZEXe65uBjqxL0zoeuNqPFxoe5goMIIHnGcG2emfwF2VWUoQlzjliazzKcFVfW
	 5BDE1mlRYtgV2STN5yv1m886uaSmOIft8hCnS1ET9X+cHP1us/Bolf00L68zeYuWt3
	 IQrpvFNT4VDBJD+ZTVy3Sy+ZRnt1pdCroh6ZgCwq7C7K39SuNLbFpP0gL701/k/Opw
	 vwiAJe5jtUCO6lVvrozSBU8TWSQeJ/FycORf2yXl3+2U5obM6exI3QVU6IXYcjfXwq
	 hY3Syo2ktUBEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1DA380AA66;
	Thu, 30 Jan 2025 16:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] org.bluez.LEAdvertisement: Add dedicated Scan
 Response field
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173825463148.1008974.14161501059131467471.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 16:30:31 +0000
References: <20250127165833.866133-1-luiz.dentz@gmail.com>
In-Reply-To: <20250127165833.866133-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jan 2025 11:58:31 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds Scan Response fields as experimental so we can evaluate if
> this should be made into a stable API.
> ---
>  doc/org.bluez.LEAdvertisement.rst | 101 +++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 35 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/3] org.bluez.LEAdvertisement: Add dedicated Scan Response field
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=36c79632fc9f
  - [BlueZ,v1,2/3] advertising: Add scan response properties to LEAdvertisement1
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ab6502473a62
  - [BlueZ,v1,3/3] advertising: Add scan response support in bluetoothctl
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f9417eafa2ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


