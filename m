Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D647381C2;
	Thu,  1 Aug 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500435; cv=none; b=hU0HlY4tLYr3Mt4kVmtqHJkNRBxWKmWYZH1Q7anqjGWuwhoB0zL1M8YJcc555SL5QzVmGcO7XqKEHNBukRpoOT1AT+DEJg4isisiXGHCfVZBzecjAeHQbzQl9SS4UrGdPNg4z8pEBjsiBEKrq8CFeGdkD3AxrJFIU/H7DF0E/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500435; c=relaxed/simple;
	bh=k4Iwf+s99U7rDGCC/PaxZkpV7Cxs3qCZf+vgUr9MhEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oEjLVtEu078olzNuUdJcojSf3KGAYmFV75+hNH1wqFYeWT0tNdrtQAN5gHEaGiubYIeQMAgJG+kUBm96ZfR1Zuc+F75RT+bnnVd1Z/qOKmj8WoDCANefPvEhxf3aDslNxXagbJqwLalubxplbkc4AbR9aReYPDxOqdRJ8mBY7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q13Ztgdl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q13Ztgdl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A05D6C4AF0A;
	Thu,  1 Aug 2024 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722500434;
	bh=k4Iwf+s99U7rDGCC/PaxZkpV7Cxs3qCZf+vgUr9MhEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q13Ztgdlvn+A+FvilNj2PkFm++/n9aRtLwR5FQsS9Nib2f67piQaFRBTYxSZtXBye
	 reUFpRUvI7oInkTtYzcxBJEgYNY8J7YSOBR9bwbuvfiaBNKfhU1VsVzABFdM8zwP62
	 j6BkDJNCUMqsEw14tzYXsO8M5hAUXiKpppW70wvC50dJ27GmI5R8bQxSW4ZK+3mQeV
	 6vR+ylh6uWt8kMxXMwYcbB9nNywfn3hri2I+7LbESVLZ7ey6uDKuxo4m7FDYhNW4gI
	 KeAs3K4BWqHALav//h4mfB+3a/fouMgNv7MVpbbtviIVbEgSaaeAmK+P123frtARsB
	 avuPGZTi8er/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93BE7C43443;
	Thu,  1 Aug 2024 08:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: hci_qca: fix post merge window regressions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172250043460.11616.3564241762852213894.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 08:20:34 +0000
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
In-Reply-To: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, wt@penguintechs.org,
 dmitry.baryshkov@linaro.org, luiz.von.dentz@intel.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 31 Jul 2024 17:20:47 +0200 you wrote:
> Here are the fixes for regressions reported by Wren and Dmitry. I could
> reproduce the crash on db820c and so I was able to test it but patch 2/3
> could use a Tested-by from Wren on QCA6390.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Bartosz Golaszewski (3):
>       Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
>       Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
>       Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
    https://git.kernel.org/bluetooth/bluetooth-next/c/3c9b2c902da0
  - [2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
    https://git.kernel.org/bluetooth/bluetooth-next/c/786cd197c92b
  - [3/3] Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
    https://git.kernel.org/bluetooth/bluetooth-next/c/9fba2e3f4ac1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


