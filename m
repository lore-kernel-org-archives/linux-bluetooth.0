Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6156B6A
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834033; cv=none; b=X5N0uWGibCNjTOYcmUkShVOUVPQDi0B3u4i08osnNqZObVOW83jLfqksLsKNlFflTnXQq4+vdT0UziUM6Hcm+r3hOxZ/h8jYZ/HSIhbblmc1L2SXdhGAgdLjpFox2S5F+f7iSxCoYlx5ih1MnRuCXzNoK/lF0nqDkrherU4nKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834033; c=relaxed/simple;
	bh=fMXMnWeFsZK9CpiFeSh+o/HSkDZOJYx8ZzSiBgbeYWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nLl4Gg5j7VRk1gQeCWnl6M27eWT7+M4MCqnBctgiCZgDL/ZGD8XV5tsSSeTlRRHf9mLcpCjOxIvr4rT/G6UG6FcQ3ZhNhFfIb+OhJUHWrZZtIbtxcebIVdUZyBfIYsVNZQL5K2ryJq7DgvHripQry4LanvFZ4OMEGJAbS2c8e64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkKaNt4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkKaNt4P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89698C43390;
	Tue, 13 Feb 2024 14:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707834032;
	bh=fMXMnWeFsZK9CpiFeSh+o/HSkDZOJYx8ZzSiBgbeYWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kkKaNt4PQr0kh8UIDnofuDD2xm7UtDTaJXy3vGgjMNn3+1GMNqlrZdlrqUGGJ0hbI
	 Aoi5Qde/fR82Ts1CEDeUHH1vhGRW4zsfWD5lrzivIBBBIa4AtQcVcHnZzICflzhPiU
	 pBf3O4qY0njURy+hhaaNS9m5HazMp53LYmV5KHDd39IuqXhq9qy6RuaX9AnXBClaq9
	 O260hd3bSxImfHhMja1bR0L/RkmFS2cy2/s+YMMKgif6vIVO3NwFwboyFTifHhQ7F7
	 rqdUuDeh9pYFcszX0S1mcFXmUpG1OEQxSDf/fu+09oK6brXNRtVzh5LHRaPTozVEw2
	 bhtMUzkvJNm+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FB57D84BC6;
	Tue, 13 Feb 2024 14:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170783403244.6627.16402080502104768769.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 14:20:32 +0000
References: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
In-Reply-To: <20240212-disto-patches-v2-0-8bab1bd08f4d@gmail.com>
To: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, slouken@libsdl.org, hadess@hadess.net,
 emil.velikov@collabora.com, iwamatsu@debian.org,
 gcampagna-cNUdlRotFMnNLxjTenLetw@public.gmane.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Feb 2024 20:02:36 +0000 you wrote:
> Hello team,
> 
> This is v2 of the earlier upstreaming effort, aiming to reduce and in
> some cases patches carried by distributions.
> 
> Changes in v2:
>  - dropped the first patch - no longer applicable with newer kernels
>  - fixed bug in phonebook/tracker patch
>  - added use glib helper for obex file handling - Gentoo, Debian
>  - added obex dbus service w/o systemd - Gentoo, Debian, OpenWRT
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/10] Return at least the title attribute from player_list_metadata()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f2671bf8f951
  - [BlueZ,v2,02/10] adapter: Remove experimental flag for PowerState
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3aeae79de4b
  - [BlueZ,v2,03/10] test: consistently use /usr/bin/env python3 shebang
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d31f04aa928a
  - [BlueZ,v2,04/10] profiles: remove unused suspend-dummy.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1313351f7144
  - [BlueZ,v2,05/10] obex: remove unused syncevolution plugin
    (no matching commit)
  - [BlueZ,v2,06/10] obex: remove unused mas/messages-tracker impl
    (no matching commit)
  - [BlueZ,v2,07/10] obex: remove phonebook tracker backend
    (no matching commit)
  - [BlueZ,v2,08/10] build: ship all config files with --enable-datafiles
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be0e796299b0
  - [BlueZ,v2,09/10] obex: Use GLib helper function to manipulate paths
    (no matching commit)
  - [BlueZ,v2,10/10] Allow using obexd without systemd in the user session
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b16b19885c53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


