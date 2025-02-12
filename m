Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387761D5143
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396406; cv=none; b=IWvR2uK5cvLKrAzvFJdoGPO/0l4WRyhdz/lhxa7VCMtwSLGPSm2YcF4AZ/iLyKnJ5T3zTYp8v1HMUlNXZdPQN0nrRjpCf69etLzWXF6ASTR8Yubewgu1O9zmTRAAMFapHqmS/UMjNss54SAO/Xr/zSTD9gJjHedJH8CBp0k8c/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396406; c=relaxed/simple;
	bh=YhFQUo+4LM32bQCbW5pzs5MEHdyXBdLCPUyesHG25+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V31aQIxpoqKEpGUj2HHQkOTanI3pHV3YNTC69/GdVjolkDxfjKKQaOE5AIl+/Kwb4aBd3bPxBd3lyziJAkD1nizxi0UBkTi0RBW70XshAPogCkRbQXSMwvmsJHdslytaigTnnA3fahlwQR+/BeQ8JLgYAjT//rDfsaYOwqVEeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkKyifxn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkKyifxn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7254C4CEDF;
	Wed, 12 Feb 2025 21:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739396404;
	bh=YhFQUo+4LM32bQCbW5pzs5MEHdyXBdLCPUyesHG25+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RkKyifxnRaE7htQNGAMjviqnMKfWXkUgPXN3jD9R5qJXN2+0eF9OMys2XWtqm5w0b
	 h3lsK1Ok20HB3KCI3cyXeN7TWyU0jeRJdTsT915DB51CaafkeZdSfUV9dMJyfThyur
	 czupTMR9HNspBVabO2dAPyY8MXKXAQM6BV0xaKMnzpL2M6LGgCk6QaZy9TQJK7eX/d
	 Ue4Edz0S+iwGtRyzG15kbmg9+JsPBAITzNgDLa/mFMIvQr4rvEAmSjUM7ZwJy/xUTG
	 4htxMaj2U8VuJhNOEuuEBkZNj8S1IWJCQFLRYoJuEFwBf8LHXYTKQm8P/apZZgLx+2
	 MePSpXzDYobRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBF38380CEDA;
	Wed, 12 Feb 2025 21:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Audio Profile version upgrade.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173939643377.667348.16482186448653604438.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 21:40:33 +0000
References: <20250212090553.3775-1-quic_rbujala@quicinc.com>
In-Reply-To: <20250212090553.3775-1-quic_rbujala@quicinc.com>
To: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Feb 2025 14:35:53 +0530 you wrote:
> Most of the existing profile versions are withdrawn
> to make PTS successfull, need to upgrade the version
> for audio profiles and there are no mandatory feature
> changes between these versions are seen.
> 
> Version changes
> A2DP from 1.3 to 1.4
> HFP from 1.7 to 1.8
> AVRCP TG from 1.5 to 1.6
> AVCTP from 1.3 to 1.4
> 
> [...]

Here is the summary with links:
  - [v1] Audio Profile version upgrade.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f0e9ecb9f4fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


