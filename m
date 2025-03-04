Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD527934E
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100399; cv=none; b=kCKTJqpFwAtk3edbQYGqWc1e+kxuB1rlX6coZ7zc38L5qt6KngKHxxnjg8UyiNByKyxhWsjZDthVxJ0YNRs+IDCgYwnJLpiDLQQXKKJD7USTsmAUsy9B9Xa4qieZnpebppJm6fKzb3D/cz5fuvECIH4EI+aJxZFkBTUAB3cv2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100399; c=relaxed/simple;
	bh=Cdt+1WfpbB14q482LQQu+14P5kUQ3qg6QQcq9mXlZMM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=odsu6y9oUY884mcQvXBKlbxIBWBvGlokkYhl/ebhFkYv4WE9sLIfmYyejYEsh/YgsIfIJKMzMAQzneXrc/9XLg+1layempKLg3lEIb3yg2xpdvc/xZMcFlhveHhcbcRXHdXxCnEGkwiKGEiQW785xHVxJKLQxBhRpmShDENt6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGeGpT1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGeGpT1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AB5C4CEE5;
	Tue,  4 Mar 2025 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100398;
	bh=Cdt+1WfpbB14q482LQQu+14P5kUQ3qg6QQcq9mXlZMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZGeGpT1ZOXurqG29c67DsgvI6/xSpCiHpXVono1iVcPgqjwqwG11JbzPpLAA9OA7U
	 hOBlK/9oF4CGBZHWRyPk+NAGjrhIncfDKvjfG8iZL/TajiHP/tXHKPeS6JZbNNXhtB
	 nEEVIbyibBxUnGi6hsOeKa0JXuEb1zd+ZvZeJPf0GRS0VVT8B+mJDxPLp4P/Mnw7lY
	 RSDhr3rBWnybu7A38ganbcmFhw6VUtYyaDuXSnvWnBzTataOFNv1jg2WcgKo9NPHLr
	 oEBdJYJry9+ivx71OTFU4+7lHsDFLzaPu4UbdOFVuKrjMDnPqlv57kVq4/ZWNm9QVp
	 y7R4O4OMSTgMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3FE380AA7F;
	Tue,  4 Mar 2025 15:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174110043148.174904.12856753542973603477.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 15:00:31 +0000
References: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
In-Reply-To: <20250222050439.1494-1-nishiyama.pedro@gmail.com>
To: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, johan.hedberg@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 22 Feb 2025 02:04:38 -0300 you wrote:
> This adds quirks for broken READ_VOICE_SETTING and READ_PAGE_SCAN_TYPE.
> 
> Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
> ---
>  include/net/bluetooth/hci.h | 16 ++++++++++++++++
>  net/bluetooth/hci_sync.c    |  6 ++++++
>  2 files changed, 22 insertions(+)

Here is the summary with links:
  - [v2,1/2] Bluetooth: Add new quirks for fake Bluetooth dongles
    (no matching commit)
  - [v2,2/2] Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
    https://git.kernel.org/bluetooth/bluetooth-next/c/c2fe96fc96f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


