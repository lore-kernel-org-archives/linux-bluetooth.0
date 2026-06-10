Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C54358373
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116814; cv=none; b=FQztL6AusBwmr+CmbYIrX6Jcu9/ZlpmYKYxcRsBibhODl7iVIcORXfxl9u58tucGHGLuTBstpjpxhOyrvPnK4QLD3LhtmdTfJV7ZRmXH3i/+vhEouS+CKJ8zsi0aqf0OsH8aSNSfr/muxoP/qqVflEiMF9iA9mwgQb1c51enLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116814; c=relaxed/simple;
	bh=+OXAsTGZJR1armlXto5Oxb7Vxc8Me+C64fDOYpM6Wks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CWtIQn4g8Iq6VvFwVRLfia10kps6F7mLGmKDB4/ZQtaTpZzHPxqhhretArbUvn8yDqTy2Hzv10XLrIUmqg1qQLgBCfcT3uufhH4O01gknhIVcadmJOJ2oi6ybYog9X2oD3tc66vLO5y3SvLoXcJWjSecEkBNRS6GxWn23H5xIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orTstAdN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orTstAdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141C81F00898;
	Wed, 10 Jun 2026 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116813;
	bh=DSiKT2EAE8wTyBqJfbw5cT/ijYFo2lSjhRsyBKtcIfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=orTstAdNUkGy9LKHdUl94g9ujtdAwJhYYn8WOkEsQOd+NSt4atU1yTjdcEYvPB+au
	 W7PIbGXfkmUR24Yd0XcvLh+91FNteWIVPXLiiZXhK3zV7R0Db7hJDidf9o6eJW33o2
	 GF5yVcPplUBSewR43RqQI/DyGSwgvy0SXIP2nr1aHai65J8GDRExnkKYcM173jjD2O
	 UBydTdUuX4sInQGhPPn8z6zJp0ehFeY5de6jqGwqD8xRnMexBxGSMhzS5bqVE2Uj52
	 e9THPeE34BEqmkENYfHeg9ykWNaR0snHiNApJ/wAy07j/LPssNSfBXLTIfn0v6vzjE
	 a88cWQFEVU+9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197F43930DEB;
	Wed, 10 Jun 2026 18:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: Report invalid-length ASE CP write via
 notification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178111681063.3588149.6278164701179181672.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 18:40:10 +0000
References: <20260609211104.3887577-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20260609211104.3887577-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jun 2026 23:11:04 +0200 you wrote:
> A zero-length write to the ASE Control Point returned an ATT error, but
> ASCS requires the write to succeed at ATT level and the failure to be
> carried by a CP notification. Build a response with the truncated error
> code and return success instead.
> 
> Fixes PTS tests ASCS/SR/SPE/BI-01-C and BI-02-C
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: Report invalid-length ASE CP write via notification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2e00b83c0788

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


