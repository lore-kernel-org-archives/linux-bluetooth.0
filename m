Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A23B189
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jan 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb1tzuk0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21BFFC433B2;
	Tue,  9 Jan 2024 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704819625;
	bh=A39dMO7iSDoiNjIL2ioejeUToDOMgDqOmMdt3te3uIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mb1tzuk0tGSf/0D/CdN285xPHOFpFgotG1N7zKvOPLHiJ3DYdQODlGQurLPWuiP4i
	 OA4RaQ2ovC7WnvdvGaSfM3vteatzSt9BuIs/wXM+7FWTbeK0nBnLYtnwcJajiDqI5l
	 4HeOr9ML4FQoZKlYbQCz6UnHHSv3MQV1sIxdh4rNUI9kMkIXypPosda/8BeYSas2yz
	 Z5OoX1ZLwoCS0tGyT4zxQ2ZQMzOlX789AhQ2lFyLKO1dMdD/erNCwRcK6++5fpQi9g
	 aZ0ihMXNw8Ud/I3DunQs9rgvF6LgcejCY4JH3U6VdYJYASDd2AHrNCWITsP39xhixO
	 gPeQoWedEA6AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07AEBC4166F;
	Tue,  9 Jan 2024 17:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_event: Fix wrongly recorded wakeup
 BD_ADDR
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170481962502.3010.3836450870684553531.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 17:00:25 +0000
References: <1704798203-20887-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1704798203-20887-1-git-send-email-quic_zijuhu@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 9 Jan 2024 19:03:23 +0800 you wrote:
> hci_store_wake_reason() wrongly parses event HCI_Connection_Request
> as HCI_Connection_Complete and HCI_Connection_Complete as
> HCI_Connection_Request, so causes recording wakeup BD_ADDR error and
> potential stability issue, fix it by using the correct field.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/1] Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
    https://git.kernel.org/bluetooth/bluetooth-next/c/7974b2128489

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


