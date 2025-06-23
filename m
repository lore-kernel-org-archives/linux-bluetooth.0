Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB032D878A;
	Mon, 23 Jun 2025 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705795; cv=none; b=IgjAksoOnRUV7r+TID4v1uyfLCEtMwCIpArsasQXoG33q8WRkw0NKCGAko/8u6/lUm3ruzoV5vRFp0Ghqk6zkc+jbj4yM0O0YnARu40SDR2eWj5uDi9ZNCD6Y+CKMXv5a89LaNA2VsTfDH7awEFhDQDiuIRgh5JYg71+PbsBFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705795; c=relaxed/simple;
	bh=XPK2VtOti7ElzNyp2H0/CCUTU6C4JSYlyG/YD7MYBRI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ob4f3PZj7jL4nyfPWRUwjxgKYmeuXEem+8hIcWEpFAbfZ7juU1AQKiDElWQkGcfG79ZfAvR5o47VnrU7wMWFUsWAhJhMW6sM8UYKQTXZ6jkmjpNowg0JFOeSqkAYOT0GhCO1DcskFfsIgRM7Ocat5fBCg+yNABGsqjXL3ljr0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9cJBlv+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9cJBlv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CB3C4CEF0;
	Mon, 23 Jun 2025 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705794;
	bh=XPK2VtOti7ElzNyp2H0/CCUTU6C4JSYlyG/YD7MYBRI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T9cJBlv+2+/iOrFanCrMFHhTZ53ED968+j8nes6AqaQP3tJfe74ZXCc8Jy3L4Ei0F
	 BhGmy1O6ZgOOnBKfWyG/Iu0qxh37fkgWPohQ/b5DwFxnmPHbrx9a3mpHVsr2EK5WsF
	 LscVz9jmKJjKX7jR+QcmppJ7iRbnfe9O/eWdm5V6izIswZj+9f+tz7qBIWMh77QB6Z
	 10D7+qLhg8udavb3wWMYx3ilUufl86CFxoolm3mMojk1NdlbTU16qh8FlFxXHo4ML9
	 XmaRzp72Hf7a7tcF5IA+CJd4Z5f/R5FwUqFiClGYA77ry9I7JKboS8If+ybvRw61j2
	 2Cv8EZsgDQteQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349DF39F1DF2;
	Mon, 23 Jun 2025 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Prevent unintended pause by checking if
 advertising is active
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175070582174.3268784.13178824163503894231.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 19:10:21 +0000
References: <20250619-bluetooth_adv-v2-1-4bfc32941e53@amlogic.com>
In-Reply-To: <20250619-bluetooth_adv-v2-1-4bfc32941e53@amlogic.com>
To: Yang Li <yang.li@amlogic.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 Jun 2025 11:01:07 +0800 you wrote:
> From: Yang Li <yang.li@amlogic.com>
> 
> When PA Create Sync is enabled, advertising resumes unexpectedly.
> Therefore, it's necessary to check whether advertising is currently
> active before attempting to pause it.
> 
>   < HCI Command: LE Add Device To... (0x08|0x0011) plen 7  #1345 [hci0] 48.306205
>   		Address type: Random (0x01)
>   		Address: 4F:84:84:5F:88:17 (Resolvable)
>   		Identity type: Random (0x01)
>   		Identity: FC:5B:8C:F7:5D:FB (Static)
>   < HCI Command: LE Set Address Re.. (0x08|0x002d) plen 1  #1347 [hci0] 48.308023
>   		Address resolution: Enabled (0x01)
>   ...
>   < HCI Command: LE Set Extended A.. (0x08|0x0039) plen 6  #1349 [hci0] 48.309650
>   		Extended advertising: Enabled (0x01)
>   		Number of sets: 1 (0x01)
>   		Entry 0
>   		Handle: 0x01
>   		Duration: 0 ms (0x00)
>   		Max ext adv events: 0
>   ...
>   < HCI Command: LE Periodic Adve.. (0x08|0x0044) plen 14  #1355 [hci0] 48.314575
>   		Options: 0x0000
>   		Use advertising SID, Advertiser Address Type and address
>   		Reporting initially enabled
>   		SID: 0x02
>   		Adv address type: Random (0x01)
>   		Adv address: 4F:84:84:5F:88:17 (Resolvable)
>   		Identity type: Random (0x01)
>   		Identity: FC:5B:8C:F7:5D:FB (Static)
>   		Skip: 0x0000
>   		Sync timeout: 20000 msec (0x07d0)
>   		Sync CTE type: 0x0000
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Prevent unintended pause by checking if advertising is active
    https://git.kernel.org/bluetooth/bluetooth-next/c/8466ce07cb6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


