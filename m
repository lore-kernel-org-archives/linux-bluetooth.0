Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEE3914FF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106833; cv=none; b=kBfTxHAf+VkZGJJ0BP/Ckxj+5j64HENIQL4wIkGEk4fIs9WD1mWwYw2VtRb+20Va6TVLnsPlLcSWw66F6GdnGbGexDzt9b8RkWPReaR7Yk5Rmw33k/j4GCX/PQxSG+rK55+ygA1f1/T1jtUxYhMTLDfIkBnErubjQDwimhUTrlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106833; c=relaxed/simple;
	bh=w3YM1N5yArPvTWS5gnMVHkSLznYMJwcVsa1p0mLHb8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KcEY9dsdIF0u9+5ais1tJ0Fk+q3bjzAjyqiqPKftKPGsFDGVNf+mt3OEYJDFuTMekC8CeZ39vRo6CvpnzDqJwK51cBY9WSnZjDm3pkJ8aO55FNJboOmSJrVLJofLskbUbjRNDglMwTY6WuZGkWf/8Pyws1N5mYN/eNCZuFxngFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfS916FG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfS916FG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C4CC2BCAF;
	Mon, 13 Apr 2026 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106833;
	bh=w3YM1N5yArPvTWS5gnMVHkSLznYMJwcVsa1p0mLHb8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FfS916FGIC2dOfiYEzeFgxZjbEiroHcIxdyzn8K/eghsq66Hfa4N4vpBydZJHHDWh
	 UwAmZuSg9j1nGHXnJlQc+2HyGyFHoxeR9vEOGP9+r99gRc2gMK4JVzNU2AWI8qXUry
	 FgXpmi8/EhHEbc98vHVbYcBYdn/k3c4zR1CIm+aF+CjX9BRJdq9ZGzrq25WzB+NDNa
	 YSIcha4f6K3HWZhftSuw14imfBWCd/DvbQyu6xlyXWxreTafLKtSo+kv3emDhi3kMt
	 SpPnIOmFFJxxu4ajKQ2MVYRzLqNLewmnsIrFDa2so9QusEBYJlirJTuNX+14UkEknS
	 eKcRpi3R0+png==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E543809A0B;
	Mon, 13 Apr 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] gatt-database: remove database from dbs list when
 destroyed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177610680454.496811.3599813256996986063.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 19:00:04 +0000
References: 
 <3806351a2fbd1b5e463c9530203f7d121f673f61.1775992233.git.pav@iki.fi>
In-Reply-To: 
 <3806351a2fbd1b5e463c9530203f7d121f673f61.1775992233.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 12 Apr 2026 14:11:30 +0300 you wrote:
> btd_gatt_database_new() adds btd_gatt_database to the dbs lookup queue,
> but nothing removes it from there even when destroying.
> 
> Fix by removing databases from the lookup queue before destroy.
> 
> Fixes crash on adapter removal in some cases:
> 
> [...]

Here is the summary with links:
  - [BlueZ] gatt-database: remove database from dbs list when destroyed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1ab128f6d749

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


