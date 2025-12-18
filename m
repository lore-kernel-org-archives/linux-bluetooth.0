Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BAA347BA7
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090599; cv=none; b=uglz4DQq8Wc0pgDyO4mUNUry2E0Gn1tYoRwnIhg66sJqvE11TEebJcUwn7TRzP1HWegspilAI9jhseXXK0tyr4GFDXpUtfi43gzst9HilHXMWEV1QudKr15+TCZg6Sm1AOlYHSCQd6AaYySoGhCqokHBBQ1FfPOla4WoAeulIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090599; c=relaxed/simple;
	bh=+bv3ZMPg5oyvvXYHG0I43ch9Px2/jwSVmm67VQndgPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=crgcOmR3MAMeMi0covq3G9NEPAwH/O2hkRMxLDAlfjaB+RaVluvH/QbGufVqEDvgwuYRJ+w90ktVCjpp8C4Bz5s1wvK2dNxoWXyi32xZUz8W6yxNXxikcBT6aUpke98V+BJxz9m0VVvGahLgu2OMwGfMNaEc4akqrt6i1INg3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIOp6B3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIOp6B3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5800C113D0;
	Thu, 18 Dec 2025 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090599;
	bh=+bv3ZMPg5oyvvXYHG0I43ch9Px2/jwSVmm67VQndgPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XIOp6B3XQod0Zc9irjsoq0iKiCaHr7RcO2D7FNgmYKyb1oLorA7CydLQ8UUyZsQcK
	 lRRe/0Fl1VyrrpyHOQMLff7tfqO1Gb52gmG56jMlVnRI3iWQVM5Q2BGpC1qWXADUyW
	 b+OamIqUiD+0tXuJmUFy245aj/+3D7VHPL+Npgy2RDJhXd+JlD4GOm1RFLB6mwY8YB
	 ddaj99fO+IB4viFHD4AOse4SfJEM87QI/ggpl6Kvcpa9GzJAXIkHOwAPoAAs7qF5Hm
	 D6ugZZeHxO7lhxDd2d2s62eVUxFTpPGrjNMSfPFKJ9942ZvROoiJk7CyUQ9IQDDXWO
	 5bNp+Nbh8pyig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C973380AA41;
	Thu, 18 Dec 2025 20:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] emulator: Add support for
 BT_HCI_CMD_CHANGE_CONN_PKT_TYPE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176609040877.3123984.9366177878036343489.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 20:40:08 +0000
References: <20251217204133.282359-1-luiz.dentz@gmail.com>
In-Reply-To: <20251217204133.282359-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Dec 2025 15:41:31 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE as well as
> emit BT_HCI_EVT_CONN_PKT_TYPE_CHANGED when it completes.
> ---
>  emulator/btdev.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/3] emulator: Add support for BT_HCI_CMD_CHANGE_CONN_PKT_TYPE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c599007776a8
  - [BlueZ,v1,2/3] emulator: Add support for BT_HCI_CMD_LE_SET_PHY
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87bafc8d2dd5
  - [BlueZ,v1,3/3] tools/l2cap-tester: Add tests for setting BT_PHY
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a431702e9ec2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


