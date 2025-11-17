Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2E18DB0D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406641; cv=none; b=TJP3JZ4JG8P7/C7lSWT4w5X+MEcfex9MKEO3wdGH/TSYGfCMfnz5thnYBahKTM1IxGnpxAqbAoREqm6d37J4P5B8HnvzcIT9AKGpk9ZLco3CNP1NasBMpUK4tckNfxwDjNc7auYIqTAl14y+VKnTIzQDoeHYh1CEYUPHJRVD9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406641; c=relaxed/simple;
	bh=LzNiE0V4Kce30GsHST787+HvzbXgbMVLcYgDrS82rMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kDck6kzhFWL6gzm9oQu+yUeID7eTRAr5cK2ImrHEUcQFxRSpe3iooTLjp8OtMpwK554En+fGKdgnaA9HLSHH/TcjD5tYkEQCtNK1OYVHj/Rprj9G2wFvh+j7RnKhnAAPTYTUyY/CvByXIdlMEu+1ZEJ02+cY+W8ThaqCq7m3qh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnJ2yMMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnJ2yMMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625A9C19424;
	Mon, 17 Nov 2025 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763406641;
	bh=LzNiE0V4Kce30GsHST787+HvzbXgbMVLcYgDrS82rMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LnJ2yMMYlFpKQsa43QoGLoualKzraBTMvx16sGs6DdKLxu3MO0CdnrdMEfovfBQ+3
	 VlPUdUBihj+Uq9tuTxDf3y07SrN72lDp1/tMWQ2DM+GA0nRh9lUCxKlmvxC8+uha2r
	 cNAq7J6xdWut0rjSwwtT0N+VwdWjpmwuL7+0ktr1elVHYNqm0oJOnqUMUSPb5ng4vD
	 SFo3IcUxVnCHST1TNfH59MdC2WVzsvAom/btY6h7ddrSiy4mpxEdLHF4ASPhYKXEIO
	 Xobr6zVOKyXk6xYFsedxhDgXY6BEEUm0fm4R9/1MT6pgcxiQQc/y5rgFpz0bYHEGJ4
	 D+VLzS9KvGb1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE88B3809A0B;
	Mon, 17 Nov 2025 19:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/6] shared/bap: fix channel allocation logic in
 bt_bap_select()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176340660753.3444598.13463194800102320570.git-patchwork-notify@kernel.org>
Date: Mon, 17 Nov 2025 19:10:07 +0000
References: 
 <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
In-Reply-To: 
 <69ef74b5d531804f4f793f42032da508d1497d1b.1763211509.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 15 Nov 2025 14:58:28 +0200 you wrote:
> bt_bap_select() does not correctly determine the need for multi-stream
> configurations 6,7,8,9,11(i), as its result depends on whether Audio
> Locations is read before or after the PACs, doesn't work with general
> location bits, etc.
> 
> Fix the procedure to be simpler: create streams for all locations, up to
> a specific number of channels.  By default, limit to max 2 channels per
> direction for compatibility (BAP doesn't have explicit AC with larger
> channel counts.) Also simplify the code.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/6] shared/bap: fix channel allocation logic in bt_bap_select()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f1afca6a097b
  - [BlueZ,v4,2/6] shared/bap: fix packet length comparison to ATT MTU in bap_queue_req()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0c56d482fd20
  - [BlueZ,v4,3/6] bap: don't configure endpoints of all codecs at once
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=231372ca5e15
  - [BlueZ,v4,4/6] shared/tester: better debug output on io memcmp failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1f8862a38a5
  - [BlueZ,v4,5/6] test-bap: make PDU macros parametrizable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7858675e6281
  - [BlueZ,v4,6/6] test-bap: add audio configuration selection and streaming tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a41ac3fde99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


