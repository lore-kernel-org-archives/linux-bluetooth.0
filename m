Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E313F45F
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450232; cv=none; b=U9WY++pc8QEP+tQPuA5NG7aEUJtMOAtRf8Tp9IMSEhIrAu3KRu5WVMJx4iPaVaY4lS6XEqzIR58vESHOsA3TdZ/e3OlIJ5A5hHuT4NKC7yhy8UMLrrWBOCTR91+UbkKC2w1Bo6IH1ztJG/XkRIjHQ3EvVjkUZ0fT0yI//5X0q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450232; c=relaxed/simple;
	bh=6DrZP65XbJK31wksWcMeLQ0puBPVjOgIoJTPP/PP1Fg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NQ68Ceynt1ZQPjMtJ4AWcqcyWn0vEjfZ+ltJI3DQuXyd/1CJ7dShzt25InVarUJx3t8kdGUrMcDCHF3GBJYTG6ED3467aormdfaK51j/gt/ic7RkfZe0wgAK8qPoBVCNj023nyKCzOHSofEVQAZk28DsLJAVqRwR651671quGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCW9UT2K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCW9UT2K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3B07C4AF0C;
	Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720450231;
	bh=6DrZP65XbJK31wksWcMeLQ0puBPVjOgIoJTPP/PP1Fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCW9UT2KwIpd9gYTE5gVE/0harptYN0+4JmwJnPdlaODw9epFtc/rwBDMPOt+C4Bp
	 Qr3fNquVS7Opw0d28JYVxrFnsRNu7nsR1WWm/nUlUQGFlBRhFSxNBy9G5Pvr5TMw+r
	 14ghkU8PToyMVQ+gaQLLAkCM7TvP/uafbwwaCWQMkvk7+QE7SuL26Ie7pevXu0Kkg3
	 J+IhE5bgJ0HjtljoxLYhCqDpFkPXnf31C1BvueBhN7+Tee8c4sVqxVyzW+DcyaJYyq
	 TuKwJNFJ2PyIycK3X51ZOQmdvPPzuTiaiNBezm5PP0eoQ2/Gf4h99VCal5OT9KQhxD
	 n/P261RC6Ke5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0F6DDF3716;
	Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/5] fix errors found by SVACE static analyzer #2 
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172045023172.5742.10118758304712401185.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 14:50:31 +0000
References: <20240704180752.94264-1-r.smirnov@omp.ru>
In-Reply-To: <20240704180752.94264-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 4 Jul 2024 21:07:45 +0300 you wrote:
> Several bug fixes.
> 
> Roman Smirnov (5):
>   obexd: add NULL checks to file_stat_line()
>   shared/shell: prevent integer overflow in bt_shell_init()
>   tools/isotest: limit the maximum possible data_size
>   tools/rctest: limit the maximum possible data_size
>   settings: add NULL checks to gatt_db_load()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/5] obexd: add NULL checks to file_stat_line()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0fda2dd545fc
  - [BlueZ,v1,2/5] shared/shell: prevent integer overflow in bt_shell_init()
    (no matching commit)
  - [BlueZ,v1,3/5] tools/isotest: limit the maximum possible data_size
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c389209ce455
  - [BlueZ,v1,4/5] tools/rctest: limit the maximum possible data_size
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e495f00cded
  - [BlueZ,v1,5/5] settings: add NULL checks to gatt_db_load()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=804696dee795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


