Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795C40F8CF
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205602; cv=none; b=Yd/1ULoUi0w+JP8ho6lWIqJkiM9UmiKWTkfFwrwU/4mu40N80056SyCuJC7amJcfGpHd49DS1TrcQivPTjlFk9/EGO2E6qulL7Z2az0xjUICjVlEQxvImNhqcbBHWotZB8olvpRg63DTMNpDPMLFMmeenAeLH8QNT5qqTBUf9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205602; c=relaxed/simple;
	bh=jqqsIYRtymoYGK7cdeL6HF3GNdasXCJ5Hhu+9yOzaEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MqBLELe+sBm0eLf3PJ7TXP/Mz5AsV+j8QvkCYgG4CZQWXeWlCRaHWUP7TAQ6HpbyaLiMdAhd0iVxx3q0qshtvbrDpCOvGbqXsepCk2XkmeZGfoWK+Ji74T3YfL82dqx8gzk61CGqxq1OIxcSM2GrsZsTGj0e7vFOM4VAB8RoKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRuB2NT7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRuB2NT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B29C116C6;
	Fri, 27 Feb 2026 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772205602;
	bh=jqqsIYRtymoYGK7cdeL6HF3GNdasXCJ5Hhu+9yOzaEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aRuB2NT7y75613mLt3yoA6e/kmgqBl2X4j/bIp9n6Uhk+K2btQfybUXAfmtroXlMo
	 l2EmP0LeBvN5E/OW0sCne/z1cRU+78/g6B0bP7CDVp3gShNZ3OHbTdqXrSHApdMs/q
	 KVV3G1ZTrYdwiclZ/+wlY/XTA22DulH963cntuTe7gUBOARlPHP9AkGsSVQO33vNDE
	 nBFGQoecwSIoWh4WlB3AClVTxape/6u0hFDlA0tOkrGZ8KySPov3NikbUBbqTiB1/n
	 kC81qKVwqWuurfi4Ih7ibtr8HangPY3DaD3ubwiIEyKBAkfrEwH8+Bk7s8KXXzdkh5
	 E2L5/lLAl7TZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDC239D6540;
	Fri, 27 Feb 2026 15:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH Bluez v2 0/4] client: align 'io-cap' and 'pair' cmds with
 the
 docs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177220560603.2588496.14899151545224229601.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 15:20:06 +0000
References: <20260227143242.5204-1-ceggers@arri.de>
In-Reply-To: <20260227143242.5204-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 27 Feb 2026 15:24:21 +0100 you wrote:
> According to doc/bluetoothctl-mgmt.rst, the 'io-cap' and 'pair' cmds
> should have a string type <cap> argument. But in the current
> implementation, the parser expects an integer (and doesn't complain if
> something else is passed).
> 
> v2:
> - Split the first patch into two parts
> - Use an enum instead of preprocessor defines
> - Remove obsolete documentation update for l2test's -O <mtu> option

Here is the summary with links:
  - [BlueZ,1/4] shared/mgmt: Add mgmt_parse_io_capability
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61f25f9aacdc
  - [BlueZ,2/4] adapter/agent/device: migrate to shared enum/parser for IO capabilities
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47a1be34629f
  - [BlueZ,3/4] client/mgmt: align implementation cmd_io_cap with its documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=63b82054c344
  - [BlueZ,4/4] client/mgmt: align implementation cmd_pair with its documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=65fcbe05dce1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


