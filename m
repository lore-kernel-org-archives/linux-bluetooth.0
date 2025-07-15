Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C862CA9
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590986; cv=none; b=Z5sRFzEU0t1VJ4svlkoV4GZvarxLeTMbmxJlvpfK1cnOdIRJoPylhWx7j75KXZGQgstEGOIz85mbTKL2V9TOKLcOhTVtsN1CJVeL5s2EDDiBdwe9S3IXeFWejeCX0c9XFTgHtKFMU8xYVK+0nuFjrUamHFXJPcNvxGkFgkDSERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590986; c=relaxed/simple;
	bh=vl6fZ0JILHkcSYNm7YUcuXat/LSdcCtSeB1OxtJ7c9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=supzjWPPXYydfp+4CaDqe+jKqRq4J3Aty9nkdcsd+b/RSSIt/yo/2XKzo6vE5VFSjRC6bI1vgozmDcmBJPD0jkMP2C9lyGHq7+NNXtpOlaA7CT1T1fT+u+uwPjD+A19NSXIQOjg9ORWJIc8MYwoEryngpIFig4bWWwP+nYfHuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6RmHmut; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6RmHmut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9647C4CEF1;
	Tue, 15 Jul 2025 14:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590985;
	bh=vl6fZ0JILHkcSYNm7YUcuXat/LSdcCtSeB1OxtJ7c9Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6RmHmutFelI1nzhbFy4V/9qR9JewB4hEDOy1/Cx4UKI6a2xIV8Qa9zt8imD4FazO
	 +GlJwhki9QA8TgRtQJ5dplp+Sl2Dvl41Qc5MLEVAdp/wfkxC0qA/SCXP4qFLqblZYP
	 Bj652K0aZ43GYA+neZp9SpwUACCL8rBxPoSZqH+kA2bvhBIJLqCFSMZWuziMlC2Klb
	 y+11qhsdp5PDMtQHhaEXlDSUoaRTrMHWLHpo35PGxHeopRjNhRZQCXQ70gAFGLAVnr
	 CWuCwpi7QczgxTSes4FCa8pp90kvu5nnKHOHcf1K7JVTZM/T7a+A3V7EAO6u8P13uB
	 G/w9mEJ6wAMpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2A8383BA03;
	Tue, 15 Jul 2025 14:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez] src/adapter: Fix RemoveDevice timeout when device
 already disconnected
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175259100650.468243.8950955498152418621.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 14:50:06 +0000
References: <20250712-adapter-rm-device-v1-1-808603331f92@amlogic.com>
In-Reply-To: <20250712-adapter-rm-device-v1-1-808603331f92@amlogic.com>
To: Ye He <ye.he@amlogic.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 12 Jul 2025 17:23:42 +0800 you wrote:
> From: Ye He <ye.he@amlogic.com>
> 
> When attempting to use RemoveDevice to delete a BIS source device that
> was synchronized by the BIS sink scan delegator, the kernel marks the
> device as disconnected due to PA sync termination. However, BlueZ is not
> notified of this disconnection and still proceeds to send MGMT Disconnect
> command. The kernel responds with MGMT_STATUS_DISCONNECTED, which BlueZ
> does not currently handle as a successful case. As a result, the RemoveDevice
> call never completes and no D-Bus reply is returned.
> 
> [...]

Here is the summary with links:
  - [bluez] src/adapter: Fix RemoveDevice timeout when device already disconnected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8c9977b02169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


