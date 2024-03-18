Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782356462
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789628; cv=none; b=N/SrBblYQMotW5hTk4yTSPNYxdE3T3oDH2WyhvCfsdwJeOuj2lX9bzA8tHiyMFqPTojS8mgbksMMBRsTRz+fwqB4jqGUsj9UFmdXv0YkWskgp0J+tYIQmWkgmJfxcQ4lZnl0og3bZZKLbvi0Z3QxN1Oo2W34XNiJiA7SQj8/BqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789628; c=relaxed/simple;
	bh=e4FOPzalHS6ecFpaxnCz1kmfCzj2/4QySJEPu3dNSAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FVWSb/HBMhA0opUvhUHTwYVxWes10kt0byu3k7SM6UJsZ+RH0oqRV9RM3wfdKZPstF/nJnIIy7cYRruwNu8ZxldyL8owzpZHkApKSd5LHHkIhNkfEEBGgfTvzAjThuuPAQojlkYY0f2hd+k9DYwB52i3kqCWdDAadbRmvVSRGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMEWCpwQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMEWCpwQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C98CC433C7;
	Mon, 18 Mar 2024 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710789628;
	bh=e4FOPzalHS6ecFpaxnCz1kmfCzj2/4QySJEPu3dNSAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aMEWCpwQdCVg3XjlH4oJ38cW8hYZ77NkSEy2/AfHr+Y9pgeUXwFxVOIlfb9/iilIa
	 7tgtu2b+Av26CKFrscVSpBrUiOb9KRl1qx6kVc3hKw7QcjW1seVxZv195KkC6Y5TY5
	 843DOy2C2O9wO2iylzE+J/D9cSuyWW5r6p6ra7zyrRZesBF4kP6aD5rP2Wo7AMpQhR
	 8GitccUUmou9m/Kwoh3tMqYqIDk11O31VwZUo21JbdsMBCe2hwkSc+m3qcjTvXemw5
	 qWKtBxC2gvoA4lc7RYbTdoFbBdBhI4dL5/M7sacfEOS0/Vr9R95lX5Qp8McRKUz9SH
	 EwGIhmQRKflfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25562174C8D6;
	Mon, 18 Mar 2024 19:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] device: Fix device_is_connected checking for
 services being connected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171078962814.15223.18338791686219727389.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 19:20:28 +0000
References: <20240318160831.354442-1-luiz.dentz@gmail.com>
In-Reply-To: <20240318160831.354442-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 Mar 2024 16:08:31 +0000 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Change 44d3f67277f83983e1e9697eda7b9aeb40ca231d since to have introduced
> quite a few bugs related to device_is_connected return true which
> prevents proper cleanup of connection.
> 
> Fixes: https://github.com/bluez/bluez/issues/774
> Fixes: https://github.com/bluez/bluez/issues/778
> Fixes: https://github.com/bluez/bluez/issues/783
> Fixes: https://github.com/bluez/bluez/issues/784
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] device: Fix device_is_connected checking for services being connected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8060d1208673

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


