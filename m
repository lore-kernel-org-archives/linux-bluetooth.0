Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399221DDC13
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935815; cv=none; b=J3jbLssRDmO6UA7PCGKj+jFtuD38I3atTWOYEmxDFAS3LdEcQtfLS0ySOkELJagNQDnG7M1Hhs72kZz5HPQxH/WZP6AOFx3lZqxiCJW/Wy0LCWxIYKNyvg+INdJ4MvGcpFa5izXa17NMK2TtNmvBgvNE6Ey8a4cuJnv1pS/HTiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935815; c=relaxed/simple;
	bh=o6PcnR1c7xEg6wA/JfQN4/icpK5gy4jiF0XLYoOAqng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ppmj+3PYP/V9SMkSq/QXVel6AcH3TzQCweYLapTeD/yJ5gQRyl5574ER9nbWHdsEO/wPrd5AhGnOV7Jr00Ach7CXvRPcNwlR5es7DGOI1Uw7yinkp/5VMIgzdLxiKdFYMaI6UbCDNhAytoj7eYR6yoP97wXm3cobBisWPzGhmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cttKk3Lt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cttKk3Lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA9FC4CEDD;
	Wed, 11 Dec 2024 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733935814;
	bh=o6PcnR1c7xEg6wA/JfQN4/icpK5gy4jiF0XLYoOAqng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cttKk3Ltts0X7r4CZ01jo8PovltwjbKgem9mcCi55oU7ntNn9a2QnfkUT7BjlLiX/
	 26Ai22j3dRzyo/SnheNxk7lA+7k0uFdZjVIENdP4TdkI9vgCtoYikMtqT0x9mE45g6
	 PAgAkYs07mhCvG9+6GzW1fvFMoYjdUcCOgJjKhZmOAZluOSGWAs7lNRTc2s0E11oZ6
	 DL7vmc5VI18XPJTaNGlHfiJdfgmFnNYno1e3yXwJadfcTihqmPxRmCQlqWxjna/Gl9
	 B+q2QKQ8DT6Y4Ue66KZBzduFkmWDwdmHk41VUSD2qZHI2/Xr6XxMbLg6Bww6m4ihIk
	 0tS/qNb5l+Rdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0BF380A962;
	Wed, 11 Dec 2024 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH Resend] Bluetooth: btmtk: avoid UAF in btmtk_process_coredump
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173393583088.1641618.16072077288978379551.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 16:50:30 +0000
References: <Z1iYKvmenw81i1UG@quatroqueijos.cascardo.eti.br>
In-Reply-To: <Z1iYKvmenw81i1UG@quatroqueijos.cascardo.eti.br>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, jing.cai@mediatek.com,
 chris.lu@mediatek.com, sean.wang@mediatek.com, kernel-dev@igalia.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Dec 2024 16:36:10 -0300 you wrote:
> hci_devcd_append may lead to the release of the skb, so it cannot be
> accessed once it is called.
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in btmtk_process_coredump+0x2a7/0x2d0 [btmtk]
> Read of size 4 at addr ffff888033cfabb0 by task kworker/0:3/82
> 
> [...]

Here is the summary with links:
  - [Resend] Bluetooth: btmtk: avoid UAF in btmtk_process_coredump
    https://git.kernel.org/bluetooth/bluetooth-next/c/845b4c649f56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


