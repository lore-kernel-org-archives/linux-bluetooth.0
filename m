Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E2340DA4;
	Mon, 15 Dec 2025 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765828041; cv=none; b=e5Xg1nquhHv1dwbvzrRYK47HuqYQDeaanT/EEvZo6qT+xhx4QiRB9cf8GbwpDlwTGfSWUH1RVVUkN8ZKGG9dY8xl7SByuSZoSZQKswOp1ywJzZg3xoYcivkww8DqeHPKOwlB63zvutBuUQlcdUC/E1GlbOEqR/zQsdvmveB6EYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765828041; c=relaxed/simple;
	bh=+Zn4sTno8uTuE6cZedmjC9m1NXuy9c26G3hZpAW2lI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MAxoUWCC+m2YcGxbYeU3BueA94L399vk81IQOLOqXU7ppYLsmDCiatnD4fsG36IGKujDby1AyW6g1puKEoHICHQm6go/1x+YcU1GgnWtD7xRnBiiTE4kQkAZ/UMQtI+CrbX1E4NVyXUYhyWTTWDipAF1zcdpCrK5lP/6TSJQCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSqCzViZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSqCzViZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48723C4CEF5;
	Mon, 15 Dec 2025 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765828041;
	bh=+Zn4sTno8uTuE6cZedmjC9m1NXuy9c26G3hZpAW2lI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YSqCzViZaB9JDVyF9PYTl+lxWO/++4QYosn6J2OWSv8aQtnHgBT9bSGQTQo8YKecD
	 cN8qBQ2m83SZ8iYD8yVUapRC7oBdQhHYbnJkzd7AIKogni8fsdHgo+8DvkBJbc/cqL
	 2mv7suPdZvA+dzpsEJusRJqM826FoqyPo8XbPnhNDUinPQgjGw3BQuh2f8Cmp3UlIv
	 duYZL+XTFdGK1BxPXLvM+qzfNHo8LvKor7cQewrNUOpcTP77WhMS+2Qgh3Mql4d5vq
	 +Oaez3pRVfDtzParQ39y68hueumbY1i8wuGUaX/A2w0jf/ZVxH0EX3EIUWSHj7kMSh
	 H0c4N+/F+PFsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A63380AAE2;
	Mon, 15 Dec 2025 19:44:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: revert use of devm_kzalloc in btusb
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176582785252.183851.12085529528363672921.git-patchwork-notify@kernel.org>
Date: Mon, 15 Dec 2025 19:44:12 +0000
References: <20251210160228.29074-2-rpthibeault@gmail.com>
In-Reply-To: <20251210160228.29074-2-rpthibeault@gmail.com>
To: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, oliver@neukum.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Dec 2025 11:02:28 -0500 you wrote:
> This reverts commit 98921dbd00c4e ("Bluetooth: Use devm_kzalloc in
> btusb.c file").
> 
> In btusb_probe(), we use devm_kzalloc() to allocate the btusb data. This
> ties the lifetime of all the btusb data to the binding of a driver to
> one interface, INTF. In a driver that binds to other interfaces, ISOC
> and DIAG, this is an accident waiting to happen.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: revert use of devm_kzalloc in btusb
    https://git.kernel.org/bluetooth/bluetooth-next/c/3a7cf69ce3cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


