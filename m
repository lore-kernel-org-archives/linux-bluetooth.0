Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF64ABBA5;
	Mon, 21 Sep 2026 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999876; cv=none; b=t8QfnkqsMDxRWV+Yyp7MPAnGSGs2SqoI8TxEis0K1gVKGVnP/fyt0+M4vVuJf8Pfl08asKcPDJ+mwGpr+TN4YTwTPjYnUm60DxDj28J8fcGvYkY4SORwITFsXeap3v6Y4tVo2wKo/upwPUn64S4pOcxkzTSQDvRFHu5iBDagpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999876; c=relaxed/simple;
	bh=3L3Bap18qjSXCX6iBqqNWpCfPu57syouIoubX54xDLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CISkX++ByESOZATJMrzGif1THAPZTvB9auM+pu07s0/fCNSwvcQNyULaqql71eZB6e4rE7G+N8Lt6x4E5eDdjgC7Whf5Y7RdDXplQddmBVwsYFqaQ5oPuKOa2KryglN5vXqAZRKFe66QR2WhraveZaB333yNNVdHqZ5D+WZQnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf9ONZLU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf9ONZLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AFB1F000FF;
	Mon, 21 Sep 2026 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999874;
	bh=0A7d1TA37X32rbycSEftVefofy1c+Cm7HUxx/sK2yYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Uf9ONZLUPefg8+Y+geX7lyIkJT+o6wzkWjWAmyM4x20ij+Az63pl9NFEM+lYeInlS
	 I9YrcJlx2dA7qhEf1OlV3LyS5CFCHdPeb5DrgXXwWyLLZeCz7VzMuerPcQqOHqUw4p
	 5MQr+bZfBtr181t+c2m4d5avQ18xuzo+G5dv9OoRxQiP7pdpZgOpuol9MWUl9iCXEj
	 HK+5aYd6t/PiFM/v/B6RBq6hfJoes39hKCRpH8V5mS1pn4IaD6j9lbx53sqQ8P7uP7
	 /J9S9ImlfRUWRM98L11sS6c1IieYAzC6Xn4DnjrKDY3o5eek93zXvptKuwM5YBEFZg
	 sjrQxY+0HLU2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199503926659;
	Mon, 21 Sep 2026 14:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: Reject short EA=0 frames in
 rfcomm_recv_frame()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178999980590.3047822.8989068429457180405.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:10:05 +0000
References: <20260919112514.3871857-1-benquike@gmail.com>
In-Reply-To: <20260919112514.3871857-1-benquike@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 19 Sep 2026 11:25:14 +0000 you wrote:
> While rfcomm_recv_frame() verifies that skb->len is at least
> sizeof(*hdr) + 1 (4 bytes: 3-byte header + 1-byte FCS), an RFCOMM frame
> with an extended 2-byte length field (!__test_ea(hdr->len)) has a 4-byte
> header plus a 1-byte FCS (5 bytes minimum, sizeof(*hdr) + 2).
> 
> When a 4-byte RFCOMM frame with EA == 0 arrives:
> 1. The initial skb->len < sizeof(*hdr) + 1 check passes (4 < 4 is false).
> 2. Trimming the FCS byte decrements skb->len to 3.
> 3. If __check_fcs() succeeds, skb_pull(skb, 4) fails (4 > 3) and returns
>    NULL without advancing skb->data.
> 4. Because the return value of skb_pull() is ignored, the un-pulled
>    3-byte struct rfcomm_hdr remains at skb->data and is either queued as
>    application payload via rfcomm_recv_data() or parsed as a multiplexer
>    control command via rfcomm_recv_mcc() on DLCI 0.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d91041bb38b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


