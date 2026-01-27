Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D82E8E12
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538618; cv=none; b=ZfeKF05OfVYqtQ3tMN6ljZl1xUN0eRaRVazQ1Kj4CTZDvyfOxMLDuLhsNKxTs4Qn0TVoIV5QM/Wk72VtJz7PYW99ZdYNEZxiWG+vmE4p7oM/ieZsAc8UQ08f3oiwMmu7urvin+lAL0bBLggGikmC0s6e18DiofdrvIQMMWHfGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538618; c=relaxed/simple;
	bh=ndJZt6EsGXgSI5+WcvgYNgQusybkqLHWi02qNRrhMhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UyKtW5O7NhFquVufjgRc+nIFLSJPQsI02sejydzXWbpV+ZdxqkRupMQ3ZJcxyDVOXjibXY7SaiKBWXX4SVhMzsortI5A8cxK0TDBq7bQZRi8L8/lx1G/5p+cR9HCRZJ3G+6YVjdatJX8iGAu40kRWySZRt2E70nK1ov+Z+R4hSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nifXh7eF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nifXh7eF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35C3C116C6;
	Tue, 27 Jan 2026 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769538618;
	bh=ndJZt6EsGXgSI5+WcvgYNgQusybkqLHWi02qNRrhMhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nifXh7eFMeotlDva+RlZ0BUX9xWFB0HD0tjZ6abI+VX+Y1OWIAX6GuLfMfksSrOXb
	 dTNU/J+JZY+ge8qgWG1HNqhecNBUimtZqqfeKAic/RwwTH/VfmXybxAJGuwbygpUnT
	 62rtsJ4VTw5ODyOanrLnvnw+3EYIJC/kMXSk3gFZyoMG2gRECGQ6ldSAo/FZP3U/dZ
	 S2MSQE15tlFVZqP1YAO6wa7X4y/rfRhx2gYgPdpdOnBakq8iG+zXntzALQ7TzuHQTp
	 C6IQh6pqM35GLIxvQMgQxwGUH62ZGw8uE58j8Dqbfy36IqOVpojNEyd536UaInzrDU
	 NvC4NbJqL6dMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8BAA380AA58;
	Tue, 27 Jan 2026 18:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Add PICS and howto for the HoGP
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953861234.1352702.1841230686193146698.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:30:12 +0000
References: <20260127171543.151581-1-frederic.danis@collabora.com>
In-Reply-To: <20260127171543.151581-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 18:15:43 +0100 you wrote:
> ---
>  doc/qualification/hogp-pics.rst | 592 ++++++++++++++++++++++++++++++++
>  doc/qualification/hogp-pts.rst  | 104 ++++++
>  2 files changed, 696 insertions(+)
>  create mode 100644 doc/qualification/hogp-pics.rst
>  create mode 100644 doc/qualification/hogp-pts.rst

Here is the summary with links:
  - [BlueZ] doc/qualification: Add PICS and howto for the HoGP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=402d0c52ac40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


