Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5C1ACEB7
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962612; cv=none; b=anA3270m4/jmcgmBskOa/HVkt4n8xAsywOMOreOxqh24Rn86lnFIu53yCCZeRj2yZaQnmyLh2yKhfVOpBEtWxPmt4EFJ2fXgUeZAbZ1zK9m0QFv/LSTxT8MilHwbTNip/I++ktaeXh/FB0RFCT2upBoAqG8jrgNTrTK3gdByptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962612; c=relaxed/simple;
	bh=ZokbkMO+g+jIgEnHoJZWzXcRZAOLr0ObjoUu+lfmJsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CpDLHIHqYNjo0coP4vMr6/Cgr1A4PR++8oX5p8MdQ7XHjTmXVI/uBZLEIrHvkREafZnOKc9jxX4E1gp8RPaCMJBfhUMb8K5cWoErZ4R2Uvb8iKHivMeSy8DInDe8iAuWREoOZcbXHukw/7YjBUqt9GONzLxOkdUuk77Hf4naNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3ZRUtXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3ZRUtXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAB2C4CED1;
	Fri,  7 Feb 2025 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738962612;
	bh=ZokbkMO+g+jIgEnHoJZWzXcRZAOLr0ObjoUu+lfmJsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e3ZRUtXMWbEdwUgoUCQeZwFrUTQSMuH+dCkk7Kv3Jp/SYCiuZWFfrU8HKhCHLSNjM
	 iLYjBGBfy54Ms/EaDBsGkRoTTLLY4NSb7W9iYLs6A0n8eUkLuN5+jF/Nsl/u8XsYs+
	 EmiWLBdbJd8UjikIrcyHJKopQ8KwERKmBxdbETO2zqG1x3qyLnfW0VyaDkH7hGaLsk
	 fOSuWVWjhIJje2yaZuLcib+HrRQ8adrX0tP4W1Hnp4Ki2Wvk++CWIIn0Cb/aRzFz+k
	 x4gJhWpJkUGXkPe0zZaIH+7x0QUwLO4nDu7GGkhf4PhRHAMsLxI/pH04oRNSAXk3Yx
	 ccV3kMuZ/qnsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD5380AAF5;
	Fri,  7 Feb 2025 21:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173896264008.2382953.11092162100446211638.git-patchwork-notify@kernel.org>
Date: Fri, 07 Feb 2025 21:10:40 +0000
References: <20250207210153.3457111-1-luiz.dentz@gmail.com>
In-Reply-To: <20250207210153.3457111-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Feb 2025 16:01:53 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following trace by reworking the locking of l2cap_conn
> so instead of only locking when changing the chan_l list this promotes
> chan_lock to a general lock of l2cap_conn so whenever it is being held
> it would prevents the likes of l2cap_conn_del to run:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
    https://git.kernel.org/bluetooth/bluetooth-next/c/dd6367916d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


