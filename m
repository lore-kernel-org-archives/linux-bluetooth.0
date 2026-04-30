Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DF4279E6
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560056; cv=none; b=YEm209L+SFxj2MKnS4rLakwbjmzvl3gH0vNTg6VEoKf+HgBNmfMBcIrtF7zmpZMqb9cCqOCiYIs/EB2SBcR+xUXVkwaSC22ykDmkLNSKtpTuH8ed9Z5jSLMpejJ4XG9E7SpHzTsyr8GEvST7ag0uzEX1ryDi4PKVbtciegJsk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560056; c=relaxed/simple;
	bh=slJvszf6NdXKKzMeS7C8toUYiTe9alVMXr81ZRGQZAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UDXL1hQTT2rlCj3DWVF3TmDVOVOOdIKxqGfvQnq4jdYkKu4L2zpr8srShE5/F3dqREFaR3Q4PdBYbpz6QETaceND7NNr3Dt8WdDsBw3jVJWweiAATvCdvczpWF0zyF2aU1xdDBDfG5ngl2oycCRExrRyNnc3ZK4Zm9dK48eGBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IObgQTRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IObgQTRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315ABC2BCB3;
	Thu, 30 Apr 2026 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560056;
	bh=slJvszf6NdXKKzMeS7C8toUYiTe9alVMXr81ZRGQZAA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IObgQTRCEB9TlSA8VJpTMWKZF/Lu+x1APNOqmenWw+glLB2dIjaiTeoBXamDxope+
	 lsVLTfpkku6NGuusCpEyi5GSrzFTXfejgDwvuZHHMqvuk8wX+EceWmtDT7F1YlXMF8
	 AnM9pXS8GakYPkSN9PfcD8oMByPNMcTZo3gqhmlYXs+Wk0RcwXMLnMKnWu5i6MjcfH
	 XDUF8PKwqjStJCWZkDVnOcFIllyFszHoSMPDc7I63zvEDeFJhxo8pswP8aaEOE/wPr
	 tIqQ4vRJXNZjzO9IUOy1YfYW/MT4xOQ1oMYNAXpJF6AV/mdPe92S3Y9d44q9vgLlZL
	 lD2nKys7bTJeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B6C380AA5D;
	Thu, 30 Apr 2026 14:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/3] Add RAS Packet format and Notification
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177756001054.3037252.15175030582440255063.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 14:40:10 +0000
References: <20260428023111.1640377-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260428023111.1640377-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Apr 2026 08:01:08 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Changes in v5:
>  Fixed Max length err in title
> 
> Changes in v4:
>  Fixed declaration after statement in src/shared/rap.c
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/3] src/shared: Add RAS packet format and notification support
    (no matching commit)
  - [BlueZ,v5,3/3] profiles/ranging: Read cs_mode_one_data members
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d4792dc2a20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


