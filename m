Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00AE187343
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113228; cv=none; b=YMvR7Xu0TDyxWPhBduN9mo2TXDX3lZSzI15MopsY/n+xk3uZYlQrVN6aMbjsuv3liWQt8nHSUa6KW9hXsk8u8Lm2QMIUo9j3XiJD/ACHrXJVQsibHw/Oq4Z9tZpx5QhL6a9jdged4Nz5JRiZ1xj0EiOnVo/m6AEHGIuQalrT44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113228; c=relaxed/simple;
	bh=8ayJv6yVYPDFNci6nu8zhwY9ONd/J/T9F3CVSnisfGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DfO4cDgBbiecr5wskWynk3W6V2cc4gotMltKRZVYfI+LFjOZHpw5kx7TAzh2tJo+olWBO+3u+kG18GZIB9Py1qmZZVoUo7xcYv+1RX71NJKZJI3PKOU15lAzcg4sAHHLyEToCb4aMSzC/jEkdE4eFIPnme7m1VBVLqQBjQhaRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jClOBWmy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jClOBWmy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D029C4AF63;
	Tue,  7 May 2024 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715113228;
	bh=8ayJv6yVYPDFNci6nu8zhwY9ONd/J/T9F3CVSnisfGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jClOBWmy2yrQKSFE8+jAMfVrG2YYH9LPc/mLLqUbl4dS3rqEYQYbPwmCeqD5/0c9l
	 UD7o/Ru3DJyWZsr0e+JjHY/ijaZgJBu2Z3tlXGc+ioYOWcNB+KT4M6zqzephoBqEuX
	 jEhpDzIQERiI+OHqWwJ+SsMGzxOno18tU71mMc3a9b44xCS2F7x4NDS6sVF6lvGIE9
	 wodWdNyi0fOQde8bBrS5Ffm8ciPMjvYBSgTavNxvQvwAaFadSfSNNnljgW0jnlgFzj
	 nbuWu36AG85vKcxQn94wTMI+k+kPyAP+z9ekSrOexIQUvUFnRW4NaVrdNfsl5jvuRl
	 hHF+Dq7oV7X1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46ACCC43617;
	Tue,  7 May 2024 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] Bluetooth: btintel: Export few static functions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171511322828.4249.17975655561935546329.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 20:20:28 +0000
References: <20240507155658.294676-1-kiran.k@intel.com>
In-Reply-To: <20240507155658.294676-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 helgaas@kernel.org, pmenzel@molgen.mpg.de

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 May 2024 21:26:56 +0530 you wrote:
> Some of the functions used in btintel.c is made global so that they can
> be reused in other transport drivers apart from USB.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 26 +++++++++++++---------
>  drivers/bluetooth/btintel.h | 43 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [v2,1/3] Bluetooth: btintel: Export few static functions
    https://git.kernel.org/bluetooth/bluetooth-next/c/1d8e17157eb5
  - [v2,2/3] Bluetooth: btintel_pcie: Add support for PCIe transport
    (no matching commit)
  - [v2,3/3] Bluetooth: btintel_pcie: Add *setup* function to download firmware
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


