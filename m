Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0057187342
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113228; cv=none; b=qU9u+ampXL0LBrNzTelIFDdiW2YOVM82eF/lj8SzFxHU+mIyekIhNKOW/lKo9zC8y4CiIFq8IUYCmZPdx04Zwopd+IoPIww4SsPI320FVU6Y9qPwYok+57PVwKXfYORY0FcKLwYmdUajd6nwK2oSgZQf9FdBVpuqEtEzyGsnefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113228; c=relaxed/simple;
	bh=LUE4pQ9sEerEAci+zQJ5Nr4w4Uy3uARrhoYV3dazSj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DE5teyecIDKnLzmLbZU73bl726hRXRGqr/voW8Gkn62vITaJZwVemGDJM+f0TEXqsnhAm8TLYqX1QO08AAu5k+Uv+GC8wHJ5Ok1fgIEfzyWTd1g7QKyxuVqgvrj2ae7TLLMJcscVA808y7XhqZhEn7impUb/hHaC5Kqu64eRJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBCOe7aF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBCOe7aF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6187DC4AF18;
	Tue,  7 May 2024 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715113228;
	bh=LUE4pQ9sEerEAci+zQJ5Nr4w4Uy3uARrhoYV3dazSj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pBCOe7aF1jhwUXWZVU/+mVrK02WV6UPc0FKxl4Jp+vjkHkvsHrhn6Ktf9bYf8aE0l
	 +MQR6s5gnWtXuc+O8str3f+jVDTvhXZdoJzkY4NL5833SJRPuPVahtKufQgV4+a4lH
	 EM1zW++u4e3E3+1sFJfkoRp8UBJGE9ZG/BIe8m627s0pYxAOK+MRvCK4RB2atFm3E9
	 2iCb4UcUWhZLjaV68HsMkMlPuIVxRM0w8E5Tj0WvtGSaVqxqHfTG/0aF0sa+t62U9o
	 Jt4Bvepo/b5IjoUf1PUUtIRqIR4bWvLvEmGQg6LBy4dpoL+xcYGIFZ7TGxNT5sPpO0
	 HvlQ+dsJ+DO1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E472C43614;
	Tue,  7 May 2024 20:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: HCI: Remove HCI_AMP support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171511322831.4249.79516490746284082.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 20:20:28 +0000
References: <20240507143639.539863-1-luiz.dentz@gmail.com>
In-Reply-To: <20240507143639.539863-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 May 2024 10:36:39 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Since BT_HS has been remove HCI_AMP controllers no longer has any use so
> remove it along with the capability of creating AMP controllers.
> 
> Since we no longer need to differentiate between AMP and Primary
> controllers, as only HCI_PRIMARY is left, this also remove
> hdev->dev_type altogether.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: HCI: Remove HCI_AMP support
    https://git.kernel.org/bluetooth/bluetooth-next/c/1b24d2b97e0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


