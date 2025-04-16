Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924B0221D8B
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829997; cv=none; b=LwzDzuHLT+8Ue5eFPWUdiW/QXJetW9/LpTyCb++a4UgG24FVsM+eTSEEx8Fh1E4vW84lBH7352VWSJgNG/zuSb0q9zRrFojkhN20bySlIaQhYTLon19onuEbuMxUhoR3CG+PljU+lMWlYqU4sz/DRa+0UkJiRUR2ENNSXURYY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829997; c=relaxed/simple;
	bh=JaFLnCxjqQ7osLntXEYuSeYeue4K/Ge5NEdeS7KwF8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JCGXbw5+ICqu279tGUvfbas+d73ldWERCz5SQgpzUxRCNfyX6FqEEBHlBrrCyV4lOptLThGnOASbcglBYao3bk58uYSmBPCsujy3AZy2i7+RsOKng4bqFve8QTWp0fwhxqoy7GNGZSnps8nW4pLzxipjjXz1Sy1qUdQEQpdj1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ5Yx3vT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ5Yx3vT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067B4C4CEE2;
	Wed, 16 Apr 2025 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744829997;
	bh=JaFLnCxjqQ7osLntXEYuSeYeue4K/Ge5NEdeS7KwF8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cZ5Yx3vTT8Gbxe34j+IVojEMQV7NZyDj65Ozx1V2OgCweU6JtyMiGbUiyB3hUfF6n
	 fzXJ5iZSGU1E7/xatEco7OTl83r9CuBh4bnjOz4GXbdYhfuYCs2deYue0w74AVVSoB
	 YHtzND201Jo6xKFTn0AIAVAtP6N6BwY8+dI2JNdBOpptUcRKYhaEvdr2qR4dCiSvKj
	 Ktnkyyl/0CTOEiubcFRsWMV0K/be2xAjVbWVZAJ/aOR2ZZX/2XMwE3koq4Fa1Zv31l
	 yz8Ec8P3Y+k/XMxhkwBNe3ykC/bRL9toHmiCgrMXGffzEAcNyvwjYjxrrCHTM9V3ue
	 rrDryljsthkXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3449F3822D59;
	Wed, 16 Apr 2025 19:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/7] bap: Fix not setting SID for broadcast receiver
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174483003501.3467435.1794681280909394200.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 19:00:35 +0000
References: <20250416160433.1822263-1-luiz.dentz@gmail.com>
In-Reply-To: <20250416160433.1822263-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Apr 2025 12:04:27 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> SID most be set otherwise 0x00 is assume which may not be what the
> broadcast source is using over the air. but since we don't have access
> to the SID of the advertisement in userspace mark de SID as invalid
> (0xff) so the kernel fill it up while scanning when creating the PA
> sync.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/7] bap: Fix not setting SID for broadcast receiver
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=890149c1fb56
  - [BlueZ,v3,2/7] btdev: Check for valid SID on BT_HCI_CMD_LE_PA_CREATE_SYNC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=709aa00a1e50
  - [BlueZ,v3,3/7] btdev: Fix not matching SID on le_pa_sync_estabilished
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e5a27a9c7b68
  - [BlueZ,v3,4/7] iso-tester: Add test for SID=0xff
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7e67dc9dcb9e
  - [BlueZ,v3,5/7] iso-tester: Test getpeername return SID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b4c5300f5304
  - [BlueZ,v3,6/7] btio: Add support to BT_IO_OPT_ISO_BC_SID to bt_io_get
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=64e7377d455b
  - [BlueZ,v3,7/7] bap: Add support for using SID for broadcast receiver
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aedd7b936b72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


