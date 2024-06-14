Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711915ECCF
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378443; cv=none; b=P8F3jyrSjyyzsNU3/8o+bBtMl3RCpe4wd+/HJ0TFOqMA9KOOwIAhZjP1DVSAUPMaPBM/FIMNZHyNvmiRDE2jr61zb+mXpVnT0oN588f9NUG6oDlBH4ot/fzLmF35Z1rj9O5+CXFqaxsSq0ZPNcLSMQquEGbuKK9dnWYYLnsjwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378443; c=relaxed/simple;
	bh=CE5XgxySA3EfGtvLNJSEHXtLt37EeoKl5QYIBGyIiP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uwR0Hnbh/xJxm5ivjLXshipLw888UzqW+CnV8vtUndQVLt67jqhdn+MyWewOQvPRIorfYVqEiMqwVlmIuaxrwOleKngtAyFoJQQ61VgbW5T3ur3MyPcLyZ7l0hWnpjcIZxtcMQOQxedKEASxUBMlcraIhQeT6RY1pYInUssM7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brBXsjD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brBXsjD2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB57FC4AF1A;
	Fri, 14 Jun 2024 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718378442;
	bh=CE5XgxySA3EfGtvLNJSEHXtLt37EeoKl5QYIBGyIiP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=brBXsjD2lvAtQzV/r+kJezbBye89GOjmlb3MRMzC3cw7nekcTA0i6kBLDY9AzJLzn
	 q5Spu5r1qGBSBBC8CaYjcyurVlQR8Bji1NmiJGUOH42AiZXYh3EpasLK27+68rth8Y
	 SWSCZ+4YKFQ7urc0guUjzWQX925TUmHOQrZkRo2L7fEE8/OJJWnS7q5j/ERDJOWHTA
	 5Ny4iudwdBtQl8/fhyARYigVBwKoKHvv4vvh0Q6xXnVV6YP/mEJDKd4MUPpEHc0hq9
	 IlVhqYLCQfHgpL3MAFHeC5milBr0EkgVAHRTTW26Q6i/lXe9oGbENqVnaXuV4HI6xz
	 r4zWDwBnD9ImA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC7A1C43616;
	Fri, 14 Jun 2024 15:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: cancel
 rx_work,cmd_work,tx_work,power_on,error_reset works upon hci_unregister_dev()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171837844276.3654.6537509060028400728.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 15:20:42 +0000
References: <7d6f0ed3-678e-4fd5-bd64-f980e0035b87@I-love.SAKURA.ne.jp>
In-Reply-To: <7d6f0ed3-678e-4fd5-bd64-f980e0035b87@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org,
 syzbot+da0a9c9721e36db712e8@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Jun 2024 20:00:32 +0900 you wrote:
> syzbot is reporting that calling hci_release_dev() from hci_error_reset()
> due to hci_dev_put() from hci_error_reset() can cause deadlock at
> destroy_workqueue(), for hci_error_reset() is called from
> hdev->req_workqueue which destroy_workqueue() needs to flush.
> 
> We need to make sure that hdev->{rx_work,cmd_work,tx_work} which are
> queued into hdev->workqueue and hdev->{power_on,error_reset} which are
> queued into hdev->req_workqueue are no longer running by the moment
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: cancel rx_work,cmd_work,tx_work,power_on,error_reset works upon hci_unregister_dev()
    https://git.kernel.org/bluetooth/bluetooth-next/c/5b41aa213455

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


