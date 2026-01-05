Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F2280A52
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646409; cv=none; b=GSUa6qB+hjFZYHsOND4+8rVNdSAQL1Fe8pb/RmDp/Jg+INrlBHFN+uzStSq8r/5Ce76piTEC+rG0MKYHMyrhZkf/o8sb8rp4IIMuF3hXtigQI5+cn7ntl7N2x2HpwWAH8Ydqzy8QFshGgR2CLFSzEPet97K6qmSxaVdCWRHHPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646409; c=relaxed/simple;
	bh=6GZG7hzi7NFsDqbOKUisSXohbXKxxtHq2K/ZmkfshEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IUWFTiZZKatruKF4vIdWwYAadEOy51qQAXUStkVunySIqyLOva+4JxrQ2zTrPswd2hEpba8ZYG3VVdrkhejc8aGZu8+lhNIWxHeFiK/fllG8rxwl+UTRROn03vOWe4XO3GX95rUQxRwsZGFxrriywfTcB0PUJ38jSVkxVKOhtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEyevMNO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEyevMNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875E6C16AAE;
	Mon,  5 Jan 2026 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767646408;
	bh=6GZG7hzi7NFsDqbOKUisSXohbXKxxtHq2K/ZmkfshEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cEyevMNOAh9n0yvWli91x7sYDTkEiglI0R8CO4QtGNESkmWbfpvdey+4pslc9256A
	 h2hjPu3thJCahknx51IvLQWJJqyMu4Ko3JeIGkRBQVraFljDSv3kPDWVJfV+tV70T1
	 Dt9zZU73p5nGxAYGMUfegTHs8pzxGEEC6cdm++cExk+Cv4bArfzVwLw0OIZktcvvIj
	 YhvQdF120zPME+YRR+Xnjze9/csS8oqOhuQPglEyExkqfdFHmbDI/MyvkNZ53R26Vz
	 Us6qHLPtRPbMX89wjgIOxtkxiz8Exf8cxOnNKWE2bdJhZIORjdSuRV4rJ8PsQCVbt7
	 UHgFIyywemwtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2B36380A963;
	Mon,  5 Jan 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] monitor: Fix parsing of
 BT_HCI_CMD_LE_SET_CIG_PARAMS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176764620679.1290617.3516936743398008266.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jan 2026 20:50:06 +0000
References: <20251222193504.650019-1-luiz.dentz@gmail.com>
In-Reply-To: <20251222193504.650019-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Dec 2025 14:35:02 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The fields of BT_HCI_CMD_LE_SET_CIG_PARAMS are bitfields rather than
> values, so this changes the fields to phy's' and fixes the parsing to
> print it as bitfield rather than value.
> ---
>  emulator/btdev.c  |  4 ++--
>  emulator/bthost.c |  4 ++--
>  monitor/bt.h      | 12 ++++++------
>  monitor/ll.c      |  8 ++++----
>  monitor/packet.c  | 18 +++++++++---------
>  5 files changed, 23 insertions(+), 23 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/3] monitor: Fix parsing of BT_HCI_CMD_LE_SET_CIG_PARAMS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=11b8db231e52
  - [BlueZ,v1,2/3] emulator: Fix using BT_HCI_CMD_LE_SET_CIG_PARAMS PHYs as values
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cfdda3b11ec2
  - [BlueZ,v1,3/3] monitor: Fix parsing of BT_HCI_BIT_LE_CREATE_BIG
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b35b6befb12c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


