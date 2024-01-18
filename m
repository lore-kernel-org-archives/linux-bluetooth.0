Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C92F32181
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615228; cv=none; b=E3UafxBilV+KxEhHdXDTSVDLdfS4kzYNTBmUt41ky1xyrYLLPydCPn250iBXNigyoiFkAmjgyAEJ+5mvTI1KV3VpnVgg+DPCl9mVr3ved+eC6cxFa9NhsnnGsKa08ZK1FYx+YPUmZ3oZ1d3F9m47VwBB6qqUZRCVP8P5GX21M1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615228; c=relaxed/simple;
	bh=tMC8KP3DZ6YOmo6od5rrWm11HC8kpx0OGL501CNEgOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FyMDKDLTf9xSQTS5wVOf6U81jv5tNL92FR6pLv+5Qk/IJJEDyC8ndiweq2bpvzQvg3uKZaKkuFXiNfvOid4Uu0pjINnAKeKF7ZzSkeYmy2MywN0V3w6o2VKNSO2L7UxpCWzmYrklCcWtR3VtPDRQTx2Vx6VWgGKsJ+wk7uH1QAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcPZ7Fye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcPZ7Fye"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CD79C433F1;
	Thu, 18 Jan 2024 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705615227;
	bh=tMC8KP3DZ6YOmo6od5rrWm11HC8kpx0OGL501CNEgOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VcPZ7Fye6Fr3R6b6sfWl9ZkLWv7IkIB6Y2SLArElWLCSBP8G0Kk3bEfLpw1R5eMXw
	 PCU+0euHpynH1dgxi8kt7lLEI/P6am7vGa1bU0Jz8xvrBgYG5YFVCQSZOtM7DuMgOA
	 wrQ3YhGmG9f0vaiC0aEy2RgVdlS4QKLHyH84iAJ1x9DcBzmunpdf/bvLgUUoIx5o4B
	 ussT2vn7zgraUNwfDZCo0oRy/Kv2tS5gd2knevsmJFm8mouH+EqtSwMgpGS3NxFGFw
	 rdbswT7uSSNQwqAGro+fYo13x7FqzoJfjNFPVsyEDErobSXS/2DmjWMRSrkaPgF62c
	 LQ6SRr9SoBBqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75DB7D8C97A;
	Thu, 18 Jan 2024 22:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] client/player: Add support for printing A2DP
 codec details
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170561522747.11670.10487203213285609655.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jan 2024 22:00:27 +0000
References: <20240117222317.1792594-1-luiz.dentz@gmail.com>
In-Reply-To: <20240117222317.1792594-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Jan 2024 17:23:16 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for printing Capabilities and Configuration of A2DP
> endpoints and transports:
> 
> bluetoothctl> endpoint.show /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1
> Endpoint /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1
> 	UUID: 0000110b-0000-1000-8000-00805f9b34fb
> 	Codec: 0x00 (0)
> 	Media Codec: SBC
> 	Channel Modes: Mono DualChannel Stereo JointStereo
> 	Frequencies: 44.1Khz 48Khz
> 	Subbands: 4 8
> 	Blocks: 4 8 12 16
> 	Bitpool Range: 2-53
> 	...
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] client/player: Add support for printing A2DP codec details
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=62cf4a2ab52e
  - [BlueZ,v1,2/2] transport: Print owner information when it exit or release
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e108c744fa8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


