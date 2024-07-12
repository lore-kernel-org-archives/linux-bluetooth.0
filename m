Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370101FBA
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810834; cv=none; b=JnqmYGHENDUCfozLuAm06gphRJm5B1mfuggZbjHitd3w5tXvsom9stwXvxdjQ9PJQL5CcJfdin4qBt5qa1o02CQB1X0SD4ddr1cYqQdSdcQ8CYTzyBGhsoFVoyvXyEmM/zAzV+1nuOWcds37BEs2UcpJv2v5Y/m2sVBWd8jpJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810834; c=relaxed/simple;
	bh=Lnyd0kLnSGRDeZGaVedlwp5ca179OQbrLboY2flaUBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gcJKBjXv1AcfsZJ138GEM85BQ/Zbbc/ssCQZoX1iuG4nwAocK/zYfaumU6bvnzL9FUljAdub1+tU/qGKz4lUpb6Wd4S777kfoYtCYtvbR5UuqqYUACFFxn5sb5zwTZOXgnMrVHxS1KDopJHFdiux11nnYtUKb0oV+PAjvW46Ufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuwtnVQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuwtnVQg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7AC4C4AF0B;
	Fri, 12 Jul 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720810833;
	bh=Lnyd0kLnSGRDeZGaVedlwp5ca179OQbrLboY2flaUBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZuwtnVQg6TLd0Gw9MERGhy1f5leqvZRRoCcNckFp0245wvXjf9/BCU9S2GJpK8jO5
	 IMGmBpEUXbH2QwhUXrt2f/CJY09EaVzCH6+U9lADZm6naJk5cgEUvXHxoAXERcejcO
	 xi2Gw4VIWUqxlT76UfoHfJEk9DLQ1MPWl115A2B18CnP4TDQWa4G826X6GiYzG7HMJ
	 zVEDAW68o1AwbqLlF7HANEBuaVlbUSlKH5HvV/SkPKdAN23PFctwF6D3s5oDUbClfV
	 ik62YzwnmL353VgXkhnsLI4ACOOau/7h0roBQ3jFZHuBtUemZf5+gFxjtGPRC3/1Il
	 l0jAiSXfGdk5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5224DAE95C;
	Fri, 12 Jul 2024 19:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] device: Fix overwritting current_flags
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172081083367.13862.11119672206464937868.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 19:00:33 +0000
References: <20240711192501.3699613-1-luiz.dentz@gmail.com>
In-Reply-To: <20240711192501.3699613-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Jul 2024 15:25:01 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> MGMT Set Device Flags overwrites the current_flags so only the last
> flags set this way would remain active which can be seem in the
> following sequence when LL Privacy is enabled:
> 
> @ MGMT Command: Set Device Flags (0x0050) plen 11
>         LE Address: CF:AC:A6:79:3D:B9 (Static)
>         Current Flags: 0x00000001
>           Remote Wakeup
> @ MGMT Event: Command Complete (0x0001) plen 10
>       Set Device Flags (0x0050) plen 7
>         Status: Success (0x00)
>         LE Address: CF:AC:A6:79:3D:B9 (Static)
> @ MGMT Command: Set Device Flags (0x0050) plen 11
>         LE Address: CF:AC:A6:79:3D:B9 (Static)
>         Current Flags: 0x00000002
>           Device Privacy Mode
> @ MGMT Event: Command Complete (0x0001) plen 10
>       Set Device Flags (0x0050) plen 7
>         Status: Success (0x00)
>         LE Address: CF:AC:A6:79:3D:B9 (Static)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] device: Fix overwritting current_flags
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9cc587947b6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


