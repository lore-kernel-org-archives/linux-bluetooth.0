Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A026289;
	Mon, 23 Sep 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110829; cv=none; b=vAWd+hwBCtjoqQBaw4KsSI+lZWove06T2zvZvzdAEcDChJ0CQ4E/fHq6wefevyrKNKWLaPBjyqKjD/5KEKSRMPY/IVtzJ9o6LXJ7b7OoHmyCfRtKm9pCgiQ0YmjWVre3TCSM6qt6uh0bi/Ckpp8P+c+DNfnSInrpV/IEkVy2ywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110829; c=relaxed/simple;
	bh=XbW0lreaNy1Fnb8lFlUXOsOSzfmJhY6bCaHFE3PTm1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lOSosZtdiLj03FRi1wSQihSnUzDFP38MYi0F3YxpJBEenJmuUaYx5bU3ztIRR9xtcuBF090ibx2BkdEcMc4yEYoO17bCFb6HqIot5YpwdNUUZ9iCyq4wV3YFG8AJm/IR+VYGZ+0V07jihz5Tpi1B1IMWY0zsZX6P086Dj2wy8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkKXG4V0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkKXG4V0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B360EC4CEC4;
	Mon, 23 Sep 2024 17:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727110828;
	bh=XbW0lreaNy1Fnb8lFlUXOsOSzfmJhY6bCaHFE3PTm1A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkKXG4V0/F6m32pfSYBI2x1hCNdArsGC4QlO3U+jqkaCOIJtCoUkkuA/iaIGCIinb
	 GmU4eDztA9zaYS34t9sOsTCfkBUfEpEJ/+rgwEcNFbcwkWFAEIBhOtmZmRfJEJEH00
	 sdrdPikYitxDAmWYcSNkeHs2pF8z5haMNQRKjdwpKakRuvKqk8/WDdPxS1Oz7fF8cK
	 Gs6I79vaXUNaBKhFbivgTKLTlgYGhUYNhOJRxxdMWxOzGYOyvuI2168Ro1Q7mOxF2D
	 ia+EwiEKnE80Ll+W/5YkatAzcCtH7qs6RlgM45aJ1wk/ZEdtI9WsL+ehXgrD9uYPxn
	 2f/tL9W+C9aUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340543809A80;
	Mon, 23 Sep 2024 17:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/4] Bluetooth: btusb: Mediatek ISO interface claim/release
 adjustment
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172711083101.3420231.13056956178938775510.git-patchwork-notify@kernel.org>
Date: Mon, 23 Sep 2024 17:00:31 +0000
References: <20240923084705.14123-1-chris.lu@mediatek.com>
In-Reply-To: <20240923084705.14123-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Sep 2024 16:47:01 +0800 you wrote:
> MediaTek performs some test on the platform which can support LE audio and
> ISO data transmission with kernel driver. We found the additional interface
> claim and release flow issue need some adjustment.
> 
> These patches mainly add a callback function within the usb_disconnect
> function to prevent a kernel panic caused by interfaces not being released
> when the BT USB dongle is physically removed. Additionally, the condition
> for claiming/releasing ISO usb interface have also been adjusted to make
> driver works as expected.
> 
> [...]

Here is the summary with links:
  - [v3,1/4] Bluetooth: btusb: mediatek: move Bluetooth power off command position
    https://git.kernel.org/bluetooth/bluetooth-next/c/65e9c1bf2076
  - [v3,2/4] Bluetooth: btusb: mediatek: add callback function in btusb_disconnect
    https://git.kernel.org/bluetooth/bluetooth-next/c/bcfc09e8a15d
  - [v3,3/4] Bluetooth: btusb: mediatek: add intf release flow when usb disconnect
    https://git.kernel.org/bluetooth/bluetooth-next/c/6f3f7e941483
  - [v3,4/4] Bluetooth: btusb: mediatek: change the conditions for ISO interface
    https://git.kernel.org/bluetooth/bluetooth-next/c/667e8026261d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


