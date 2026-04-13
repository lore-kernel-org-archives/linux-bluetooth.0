Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2F13914FF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106834; cv=none; b=Lrp2iYhGc4+u9Pk228tzsYu3um3+KT/o7hev2KZtK1y0oJSeYQLYRZRLNGCzRyx5CM80gq+xUayFq+wSSR2zgJ06kCy8UI1/OmnJlVaGN9OD1GP9FnJbHTByXFg0G3c5v7/CW7kqDIfA3+NJZq6XTT4SuFDtEsUDBzQRHhPWOio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106834; c=relaxed/simple;
	bh=Hrt923vkfbA8APPT4xqyzIJ3xRwQ9eahXs3bFrp8Bw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=irnK2s7T0rREYRpEJAQe4MMsKcyvwpcxykgHxmKwwgpXzr9MwAbdYes/R7/w9V1l1A7rkYsmVEY8NZMtUma+IQwiTRFYN/00lMequbU0CYb/6P/VehOKepOTd1fKDnTwngjUoygUUHtvSHJYR521vKeeQQKjgE1hRqozCyLTKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEXjtcVO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEXjtcVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE00C2BCAF;
	Mon, 13 Apr 2026 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106834;
	bh=Hrt923vkfbA8APPT4xqyzIJ3xRwQ9eahXs3bFrp8Bw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PEXjtcVODv7ZJ5qpFIL4saVGVWHGf0dxM+R/gmOER5CKfstjKFtm0nOQEVzZPhPFG
	 EDvdNa9ZlzqGMJp3SGJ+z2eiBpVpP4aPRcjvTuHHtxCXOu/JkYXfByTV4nsACl+4jV
	 G+seB/B3wHo0SsbflBBO/3iqsCNSKAaCbIju4JSBme6TNYI4zY5KX5vzVq738GLVBT
	 44lM8pWe0hM/P9fktzB4GZxkCLXK9BtqXoBdsl7TvZ10/9Eg1kWW7f9i3nBc6JkidC
	 quKBgKRfHXOTHQ6tpdqxO5jLFxkpZ2eYZmuRYgWoSvJJtuuunwCCTGGAt2QSvTJEgE
	 Rp836Bkhh+2NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5643A3809A0B;
	Mon, 13 Apr 2026 19:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] audio/player: Ensure metadata string is valid UTF-8
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177610680604.496811.17931881044836584467.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 19:00:06 +0000
References: <20260413071246.19221-1-frederic.danis@collabora.com>
In-Reply-To: <20260413071246.19221-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Apr 2026 09:12:46 +0200 you wrote:
> bluetoothd crashes on reception of GetItemAttributes reply if it contains
> an invalid UTF-8 string:
> 
> > BR-ACL: Handle 11 [B8:3C:28:E8:07:69 (Apple, Inc.)] flags 0x02 dlen 680
>       Channel: 71 len 676 ctrl 0x0304 [PSM 27 mode Enhanced Retransmission
>                (0x03)] {chan 7}
>       I-frame: Unsegmented TxSeq 2 ReqSeq 3
>       AVCTP Browsing: Response: type 0x00 label 2 PID 0x110e
>         AVRCP: GetItemAttributes: len 0x029a
>           Status: 0x04 (Success)
>           AttributeCount: 0x01 (1)
>           AttributeID: 0x00000001 (Title)
>           CharsetID: 0x006a (UTF-8)
>           AttributeLength: 0x0290 (656)
>           AttributeValue: ................................................
> ..........................................................................
> .........................................................................2
> 009.......................................................................
> ..........................................................................
> ..........................................................................
> ..........................................................................
> ..........................................................................
> ..........................................................................
> ................
> = bluetoothd: profiles/audio/player.c:media_player_set_playlist_item() 0
> = bluetoothd: profiles/audio/player.c:media_player_set_metadata() Title:
>   奥巴马表示：美国之所以没有搞定中国，不是因为中国的军事实力以及经济强大
>   ，而是因为中国从始至终都没有掉进我们安排的“陷阱”。时间倒回2009年，北京
>   钓鱼台国宾馆。奥巴马的随行团队一进门，连句客套话都没顾得上说，反手就把
>   随身带的电子设备挨个拔了电源、卸了电池。这阵仗看着像是在防监听，实则是
>   心虚。那群在长桌对面坐下的人，心里正翻腾着一种从未有过的无力感。因为眼
>   前的谈判对象，压根没打算照着他们兜里的剧本念台词。多年以后，退下来的奥
>   巴马在回忆录《应�
> arguments to dbus_message_iter_append_basic() were incorrect,
>   assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in file
>   dbus-message.c line 2775.
> This is normally a bug in some application using the D-Bus library.
> 
> [...]

Here is the summary with links:
  - [BlueZ] audio/player: Ensure metadata string is valid UTF-8
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb0f8f495ace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


