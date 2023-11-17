Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A73715D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcXYvW3g"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2259C433CA;
	Fri, 17 Nov 2023 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700238023;
	bh=Rt/5+XUP1Tvt42nEkbYY5+f8XE6p6RyRvSm9Rlxz2Os=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lcXYvW3gyzU/im1goB+a0ngO4c66aHAL+wYN0PYWF9P7CjHbSuW+HX7Kg5rWqPIr5
	 5iFtHiAFYD5BKImY+TD99aYWhiFIiqgg6uHavndH7i2Y0o4Lz0b1ccJoxPXBGNIJ15
	 mT9ci3azwp4FUPqF6jMe1iU2AUvBTUtsjL7E36JErR3SQ4LKvxfycQ8XYQwmZAaieg
	 YhFZDg1xWAyXS8rrTJIaPQ6RPCh/5f2I56WaNO7t9jHjub+pEzodbX1eeFnK5pCeUA
	 +X8PBf6iCRVEJnSTL16h/a741UkW28IzXpuAmv5vzEcNgpTKuQ9WE/OWhKA3Cu3I+1
	 SLBd2NCOGPEqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5975E000A4;
	Fri, 17 Nov 2023 16:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES
 quirks for QCA2066
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170023802380.26338.8198277345666770468.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 16:20:23 +0000
References: <1699250566-17101-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1699250566-17101-1-git-send-email-quic_zijuhu@quicinc.com>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 6 Nov 2023 14:02:46 +0800 you wrote:
> Set both WIDEBAND_SPEECH_SUPPORTED and VALID_LE_STATES quirks
> for QCA2066.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [v2,1/1] Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066
    https://git.kernel.org/bluetooth/bluetooth-next/c/d5742377e3ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


