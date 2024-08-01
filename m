Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6016CD09
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500435; cv=none; b=cyYFAO/Rf0JLsCmAtf0dURFijf9/WpNbxximpE+x5Ml0WfXPRY3GsiL32hHBK8NxQLDs95lVh6cWpsbuUGZ9lrHzH321MOxT2YgD3kONgaagny3YoH5ENkBXzpRtLgfY4BY327o0St6tQFhbgueu8Hj4UOghD/jA/lmNBAGiyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500435; c=relaxed/simple;
	bh=97no5CpC6m5kcag1NJBudPwkKL4koM3OVU67tmeUwJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c/IAQ4res0UmxvsadI35PNF2eTPnIFmSo26zvCeDW7UpEZOaNhoB5HXjmNDj8iTu4j5sNjqQR4as2Xvb89N3eXL5TQDZbSC3HVXSyJrpxq5FmMbSPILJ89BQBt86Dnc8wZOaoPGFPZvY7qNJ8+RKrz++zqJunUP57891561e8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzo37e9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzo37e9F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C313C4AF09;
	Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722500435;
	bh=97no5CpC6m5kcag1NJBudPwkKL4koM3OVU67tmeUwJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gzo37e9FImxYJRa0uOZJjZ/dTtQjPhshP4lWmVxlpn5Bl4WK56V0bT/6T9W7hvLlU
	 YGgICNpWBv4YcxYpNysnXsO0o4djfPmdtUSQWIXAyKIn7afDEp0lQqWggaZdN+IJRL
	 b1ljgMB1r0zl+gKLFsj/u230fYvRNCL6zIa0D2IdGPoJzbN/W75qT4E2oApYvTfY0d
	 QgD2Fc0YOFB+4fe4cXaZsroBNjuFMcOvsfn99dNUbXPJkySMOSxWpQ7LYTQ2hZUpVR
	 tYwU6HivSo76Zc9h5uNntSa74bgkYxm20jVCzg5NGJA8rscXfEQqEg+DAt2Ggrsbh+
	 aUrCTWy9p6upw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A8D6C4332F;
	Thu,  1 Aug 2024 08:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: l2cap: always unlock channel in
 l2cap_conless_channel()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172250043523.11616.6767698730262967577.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 08:20:35 +0000
References: <20240731091936.476484-1-dmantipov@yandex.ru>
In-Reply-To: <20240731091936.476484-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 lvc-project@linuxtesting.org,
 syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 31 Jul 2024 12:19:36 +0300 you wrote:
> Add missing call to 'l2cap_chan_unlock()' on receive error handling
> path in 'l2cap_conless_channel()'.
> 
> Fixes: a24cce144b98 ("Bluetooth: Fix reference counting of global L2CAP channels")
> Reported-by: syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=45ac74737e866894acb0
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [...]

Here is the summary with links:
  - Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()
    https://git.kernel.org/bluetooth/bluetooth-next/c/1e69bd3ba19c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


