Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E2423A9F;
	Tue, 31 Mar 2026 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975824; cv=none; b=tY6eLOxwgm1X0Mcc+ejwwqaObRsYqq9nKTsJwOGykrEzd7Oee2BPQ5zYaS3uU4/x8awHdsxEbh0q6uffsRneHcgz100Wp+MjIgeVM55WFxYg6TkSgP+CbH+ztE7ImLXf04pn6b99Log9yfLsdRnSgrYuZsMUF0shKJKhuVX7HXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975824; c=relaxed/simple;
	bh=yPbT/W313OSJoZ8O0RXZ7diQTSAMILjsVYypreYNEew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T6UcT8um/+T5UMD5u5y8PhUq/wnwTsrC7/Wt+IsYX9TqF00nHCCh/IYMFfe/i1OOBkRvUWm4XRd5Eedah1H+KJUBWbwTk83fzAgCVbUBuodivK8U4o5ibWw4gx90JbVEeSeibOXvB/WnE6dIWIxJywx/eLhcX2UKErTy2XyH3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VouOZYbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VouOZYbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0750EC19423;
	Tue, 31 Mar 2026 16:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774975824;
	bh=yPbT/W313OSJoZ8O0RXZ7diQTSAMILjsVYypreYNEew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VouOZYbE5mttvfHFRwlMgQzatPf1c619iwkQnBoyE8tBQw6Gk+aQ4jMdrOqblMtiW
	 QZdHJ/pw73UBWAwwnECkyX3Vnr+yB+Ue4ND4A4JJqGxt5I8iBVmNa+N26MURipssNG
	 w4k6bmD/pbthSrbTtao4W2Zu6PYFPdzxvTpjlaieEj2c3L3Lj4i9GKI5p0/5T7nhnH
	 ts5BcrRKSQjWItX9d69IvvRG/XzFa8OZdteH0cC5nBLMRMz9u1zxbJqDZt3e9brxTK
	 8HBH6qflQwpUKIkoQPawePE0mH0tpgoaj0GgY/6Xww7pTQf4i8fkxN3L+RggybC+e/
	 QAdQN8cQSbEGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E4B3809A05;
	Tue, 31 Mar 2026 16:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177497580753.2805862.5559231119574123982.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 16:50:07 +0000
References: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
In-Reply-To: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
To: Javier Tia <floss@jetm.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, xelnaga@gmail.com, jnetto@mineiro.io,
 melinko2003@gmail.com, chapuisdario4@gmail.com, 3193631@gmail.com,
 nitin.reddy88@gmail.com, tibo@humeurlibre.fr, lubnin.ivan@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Mar 2026 14:39:22 -0600 you wrote:
> combo WiFi 7 + BT 5.4 module. The BT subsystem uses hardware variant
> 0x6639 and connects via USB.
> 
> The MT7927 is shipping in motherboards and PCIe add-in cards from ASUS,
> Gigabyte, Lenovo, MSI, and TP-Link since mid-2024. Without these patches,
> users see "Unsupported hardware variant (00006639)" or the BT subsystem
> hangs during firmware download.
> 
> [...]

Here is the summary with links:
  - [v4,1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
    https://git.kernel.org/bluetooth/bluetooth-next/c/4cdd001ff03f
  - [v4,2/8] Bluetooth: btmtk: fix ISO interface setup for single alt setting
    https://git.kernel.org/bluetooth/bluetooth-next/c/fe9e35d0b3f1
  - [v4,3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
    https://git.kernel.org/bluetooth/bluetooth-next/c/af6731663d8f
  - [v4,4/8] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
    https://git.kernel.org/bluetooth/bluetooth-next/c/70d2954d3051
  - [v4,5/8] Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
    https://git.kernel.org/bluetooth/bluetooth-next/c/e4fb2113d5e2
  - [v4,6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
    https://git.kernel.org/bluetooth/bluetooth-next/c/4be0c8800708
  - [v4,7/8] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
    https://git.kernel.org/bluetooth/bluetooth-next/c/26308f935d23
  - [v4,8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creator
    https://git.kernel.org/bluetooth/bluetooth-next/c/b65fdb465d54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


