Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D12FB985;
	Fri,  7 Nov 2025 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542640; cv=none; b=niC6t4UDyqup5uGEgsL9FQqynbD4oq1iY+08iw/oCFRAKBQ7HRBq0NqsiU07R8sSVLQ5o8WP/FtM9WADKA17Fp0vmwQ7lS1p9hg5YtvJZpCRP18zidcZSbjPy+K/nM08Ax8JLcAKiXgMNx9NPDjyt9Xq9tfYdi5Tr3odYUiXkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542640; c=relaxed/simple;
	bh=k81jmQ6Hfe/SgjuGe+WRy5B1gp40qb9bW52KGw6UbSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kxNbMgOK5fjaedLolWhs2baNROlhcU64BjRYJgWmEYTcPB60L6DbexzsQGTpQtBpw3v5w8GuCHwk48Q0dwDEEi7qqdjVyqNo3WRXynXt+isjJVVHSjHC+glrcpEBuwlw099NkrSy/xy3x1On7LV8qxTwbV4UccrnwOQPibqLx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=floYP4Kg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="floYP4Kg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380CDC19423;
	Fri,  7 Nov 2025 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762542640;
	bh=k81jmQ6Hfe/SgjuGe+WRy5B1gp40qb9bW52KGw6UbSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=floYP4KguXrRtutQEexxPo+j5ZFIpUOniOumQ5Pt+3Tq5MWaql3A0bSoLwRPGWDHY
	 j51ZRdfmjDc/1GQcnHv2J0hL+bGfDwkoMcKv3tly10NFFukRsF4bTGhLFxwY2Yt+Zz
	 lHu9oNhmUvGy2PlQbhlj5drYcLGuqwixfFuaLELYo/EagD/mv1zjHmUodYFacyqspP
	 i/qjXH7Ijh3a5Jr11J8dufoaI9YJMgzqZdh16EFhqjOw8M7RGlxHJLA3PRtBQHOPqt
	 OHBd1fAUgw+2LSC2035rNhyXpMqlstnvU/A/9VBqdQ8TH/6UI0ExwZFSBur6iGJdct
	 WMyj2BN16Q0gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF0C39FEB7D;
	Fri,  7 Nov 2025 19:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: reorder cleanup in btusb_disconnect to
 avoid UAF
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176254261224.1132280.14674857749168928355.git-patchwork-notify@kernel.org>
Date: Fri, 07 Nov 2025 19:10:12 +0000
References: <20251105192839.895418-3-rpthibeault@gmail.com>
In-Reply-To: <20251105192839.895418-3-rpthibeault@gmail.com>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 syzbot+2fc81b50a4f8263a159b@syzkaller.appspotmail.com,
 skhan@linuxfoundation.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  5 Nov 2025 14:28:41 -0500 you wrote:
> There is a KASAN: slab-use-after-free read in btusb_disconnect().
> Calling "usb_driver_release_interface(&btusb_driver, data->intf)" will
> free the btusb data associated with the interface. The same data is
> then used later in the function, hence the UAF.
> 
> Fix by moving the accesses to btusb data to before the data is free'd.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF
    https://git.kernel.org/bluetooth/bluetooth-next/c/162d88a68ccb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


