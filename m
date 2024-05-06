Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F241C77
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013029; cv=none; b=U7m4hj2sJxNebwN15bSlYVnbAePjzciC9DOEnrpcYPTW8sWsk9I107MRE2O8kTO6M6yclHTHf8a73wvjNQ006avYEuRkSN9FvqieqfEIhMtWBm6WatcTfAQKU4MAoc78hbzB9ymZNxpbPFSfUt7V2DQ++eY1P7VFeDNVdIGl1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013029; c=relaxed/simple;
	bh=CE5kI2bH4gBpW537WRYpPJnT8RL2CKPx2ahwVKKap04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N8NSsLKKxdapeX4RRFrhu1haIaZkRnLfvrJejW+LIyVHpi73y2vprjz17/UkE92hJcIBgztQyX63PKoVI0dXjs1hDrr0xKevJmPjaITSu650gknPl0z+6ysACV5VfvpmCJgMjquXPXFQTqUtIv+DkkV6DrWcBpk3nFXk6FwoZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyKngY2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyKngY2c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EEEEC4AF65;
	Mon,  6 May 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715013028;
	bh=CE5kI2bH4gBpW537WRYpPJnT8RL2CKPx2ahwVKKap04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyKngY2c4gGk5fQmTepEjt6YTin7lM2DYUFAVZK2Vh1wclX7So1tw/roelaVg/3d1
	 kfHS9ykN4zzMpqZteuKGCXOsXW0AbSH3FHsjL3XmuEZFDly0VqVKI/S+iLvH00a7rv
	 bAoYEmXwikniPfVFtavsn4/pYCaGB8qtM2x9SN0tW8LmyTW8/F5hDMVda0WJ3/LhgE
	 TSH1aQX1fgEgJzPRTWgoxU447at+QllfK2qyrvErzLiFwZMfr0kW96o59qdkwRnIV/
	 uA6O5IQKauLhrS2s8xrjd+9HBMhgiczM9EBhNNQhSEbg5U1Q3a4IPg3j7Ovrh/95dw
	 UnLDe+ydqdzYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CB0FC43334;
	Mon,  6 May 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluez: unregister-includes option is not working in
 bluetoothctl
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171501302850.27188.16123982217544734859.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 16:30:28 +0000
References: <20240506074043.4200-1-quic_nakella@quicinc.com>
In-Reply-To: <20240506074043.4200-1-quic_nakella@quicinc.com>
To: Naga Bhavani Akella <quic_nakella@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 6 May 2024 13:10:43 +0530 you wrote:
> unregister includes option takes two parameters service uuid and
> included service uuid, since the space between them is missing,
> the menu option is not working.
> When two uuids separated with space is given, it is throwing error.
> 
> Signed-off-by: Naga Bhavani Akella <quic_nakella@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluez: unregister-includes option is not working in bluetoothctl
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=78af547e94d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


