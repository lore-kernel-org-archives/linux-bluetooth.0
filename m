Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF571DF259
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780231; cv=none; b=lz0lsvsKThUcOiXWLlavZDvQxCyg0piLgnPoKS5/lnvq5TlJLkzhoSYJd3yHSslrTH+X5v3zOFDMLZEeD5hmTXOc4cFnYSbSVga529reCCLSWurxE6UcqWBmv6ktxZPO0Aq4jv9vdL7Z7IQx9yW3+Fy9jClwYYRkFohtVfyYeaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780231; c=relaxed/simple;
	bh=e+snEIDKoouO8j4bLFFFLuo5JmUp7RbcUJLdbLejxtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RQEylgxgG5OH7aCxlK6sGKS1ao0t937aLpORrL9Ha4ZDYz5Oe2K/0N7QLmCZo36VgDv/rAxDaGN5p0DORpyzz15ifBWQ/D72b1KF2H9VGQjG4aZKeCdmR3P1LULslTi5UC91Vn0I8kjQgiUZG58wRhvPNLcZZ6varnMa9l7AVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tum8jUVV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tum8jUVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9106AC4CEC7;
	Thu, 24 Oct 2024 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780230;
	bh=e+snEIDKoouO8j4bLFFFLuo5JmUp7RbcUJLdbLejxtM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tum8jUVVnPks0WSe7dlyciJb7xyGy3KHPR3E4Xff4m8S0hrNUwntQ4lOVlke4vfs4
	 zG2N1mWtGgej4WeeUFgLLaC+4ctkSAyEqPvLGnYqFglGwPzOb6hy85TgMPa/ohKrBE
	 4OvLE0yZiOiRrL5aio8mFbZz1p6KdIk7gS+KTqzTcP3s7LsDgKVYJuUZ7e8yy/ElYd
	 DHLRgbaqfbB+hih4xzsgebWvpr8Rc7cia1bQjwkrSelzYIYzQFRU+SyjX7Jk9nI/7x
	 AH5k44DjLsit6ItDmjn3sOncWFbXpXJYwuijP1dlCtJwyO/cPcNcf+UWRX9bsbpkYJ
	 bX2qsfjSNNebQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C97380DBDC;
	Thu, 24 Oct 2024 14:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: Fix crash on bt_bap_stream_disable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172978023727.2259464.5576587023077995068.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 14:30:37 +0000
References: <20241023140042.2249809-1-luiz.dentz@gmail.com>
In-Reply-To: <20241023140042.2249809-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Oct 2024 10:00:42 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Calls to bt_bap_stream_disable with unicast stream shall result in
> stream_disable if when acting as a server (!stream->client) otherwise it
> may lead to the following trace:
> 
> bluetoothd[104990]: src/shared/bap.c:bap_queue_req() req 0x555555732470 (op 0x05) queue 0x55555571e850
> bluetoothd[104990]: src/gatt-database.c:send_notification_to_device() GATT server sending notification
> bluetoothd[104990]: src/shared/bap.c:stream_notify_state() stream 0x55555571b7f0
> bluetoothd[104990]: src/shared/bap.c:stream_notify_qos() stream 0x55555571b7f0
> bluetoothd[104990]: src/gatt-database.c:send_notification_to_device() GATT server sending notification
> bluetoothd[104990]: src/shared/bap.c:bap_process_queue()
> bluetoothd[104990]: src/shared/bap.c:bap_send() req 0x555555732470 len 3
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/bap: Fix crash on bt_bap_stream_disable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f93a73b2a54c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


