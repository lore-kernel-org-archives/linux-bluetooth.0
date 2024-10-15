Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FE1C4A29
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004427; cv=none; b=ZTBhMEVwihiNPvloXBi4n62u8BEr6vsDzkTLGO6kyt8CC3DxXwwaHe6rzesNFZ1XOq2nEK5QE/WJ+Dnr9j/B9OEmSLTTSb1EX8g/nuzpRyKTQ7T1sPfWVK5dVtNHHv1K7JfueV5Ivc0wGdFJB8GQoz0OR7GMl2gz8Efh/qvHyxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004427; c=relaxed/simple;
	bh=bGv2lFuG5KjkplzkKE3IJ+YkHtBBFUt5M2m2VVHZJsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X/5sb6g8smVMaZJFq5UeOIZfq5deEbJpOU2r+gOMEygGBH1Fo2QpbU4GY/vQYL4e59+3ALgl8kco+Y4EUTx/390vlJO3ODyWgWFFtAPc0q8YceJzKNVNMXA6qGBbBXyHPuy+Gz+J0aIYMlWrf4QN+2TUEXQtDMRr55AtRzbcGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9YrtFnW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9YrtFnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15F1C4CEC6;
	Tue, 15 Oct 2024 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729004426;
	bh=bGv2lFuG5KjkplzkKE3IJ+YkHtBBFUt5M2m2VVHZJsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n9YrtFnWITT4Ef+wJrDqXFMVAXY33Pw9khDYNErBt0RdiQLj6Gh2WrowU/yMw51sT
	 80LM78aYO++dvlvFXvfd9bffLItG79pwQYflu2PxVXkJQRAKl07VbBQ8vJ6ULugnpy
	 GTu8UkDCyLyG6lm6YjoKATlkKGdEeBDqBgmB7HARgwactao35maA4sveZ25agrBoit
	 Cjj2DQbNhkPIvEjiCyJ18CrEJZTIIVoAYUfdSql/fLwgqd91fXhwX63/4Ilt1m2dlr
	 xBDygBbPh4N+HJ0QCsNZ6ZRyLtW21eZAAhaKdxhCXAhfaFKl4cf54jE0zVtr1BLmLa
	 Z2P21lrExcQCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB93809A8A;
	Tue, 15 Oct 2024 15:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/7] Add Scan Delegator support for Set Broadcast Code
 op
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172900443200.1188615.3296885190237474152.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 15:00:32 +0000
References: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Oct 2024 11:01:19 +0300 you wrote:
> This patch adds Scan Delegator support to request the Broadcast Code from
> connected Broadcast Assistants.
> 
> The bluetoothctl log below shows a Scan Delegator creating a media
> transport for an encrypted BIS added by a Broadcast Assistant through
> the Add Source operation. The user is asked to enter the Broadcast Code
> at transport.select, and the "no" option is chosen, since the Code is
> unknown. However, the Code is received from the Broadcast Assistant and
> the transport is successfully acquired.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/7] client/player: Add support to set empty bcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1c681c553f45
  - [BlueZ,2/7] shared/bass: Add API to set BIG enc state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f5c0fe68539f
  - [BlueZ,3/7] bass: Add support to request bcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4bc20f9df405
  - [BlueZ,4/7] shared/bass: Call cp handler for the Set Broadcast Code op
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=29cb1b0b10fd
  - [BlueZ,5/7] shared/bass: Set correct BIG enc state after sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c5616c255b13
  - [BlueZ,6/7] transport: Add support to request bcode from Assistant
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7119b4f4e42
  - [BlueZ,7/7] client: Update scripts to include encrypted stream scenario
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d7e6a64b2fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


