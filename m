Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0C38F948
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064813; cv=none; b=e8FPQvZnEXARd6FQ6xP8meJzPcinpHnSspNBnUi+FpCsXml09HsUUtC9QHXhmx+fZwfnfAfoTAE51qBGVGefoBpkxIIRUUjdE8yQaEFIkU6jQ2CNY4hsl1rDfs/5+vAc8zthME/3jRJFw0G06dj3TVCT7b26UrGQIoQS5YNI3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064813; c=relaxed/simple;
	bh=uUikIqdyrVpEoGGcTWlaPaWzqGbYnadRqN++u+OPLDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JvOj+hO4QsD8vT1yFhRuOw74seHzbR3CZqVQKdbZzgGc9JRx5gUitgJZRcJWCDPGfdqL6vqsdbPnwYktR7A+KulHcOrFwLcnTblDInxBhN7VL89UtHksxfU36WlOgn/I+/WPJLUJZVH7gwg4oU008WjVqIdaj/BDIxwYuh54o2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcGRn9qb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcGRn9qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894A6C4CEF7;
	Mon,  9 Mar 2026 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773064813;
	bh=uUikIqdyrVpEoGGcTWlaPaWzqGbYnadRqN++u+OPLDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UcGRn9qbV4QLDaeAS8ikFYj8t5El/gaLLliE4CZxTwueA9lG7Xakv2IzBEkEBbsHj
	 pJkQgyoTtogJ/VCHodeqRcB2Ql6UdJ+7uFAJzQqmq4VLYVsnwg87QE9FrkdecB80sH
	 k/vAtLwfaxHTc/Udc0hEkyIJMz8ryogkkVQPwsKXn2pQFG7pdgE7v5o7aTbBBJrcHH
	 h+e/YqFuFxutjokyru/bXaeJPl0Fhwzv8XGhZlKE/lyhTwJIJPupLRAta6c1sA+f3W
	 fZz6q3wljMI/M41PtqucgfAtCdpq1RxDlkfeSQ88/1wLB+XoA5Ec9JxEw5WLuJRabB
	 ZKNW/N4/Ko3zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC763808200;
	Mon,  9 Mar 2026 14:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] lib/bluetooth/mgmt: Add missing mgmt_op entry
 for
 HCI_CMD_SYNC
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177306481078.1231626.29655346520084841.git-patchwork-notify@kernel.org>
Date: Mon, 09 Mar 2026 14:00:10 +0000
References: <20260309045902.2354-1-wolozgabriel@gmail.com>
In-Reply-To: <20260309045902.2354-1-wolozgabriel@gmail.com>
To: Gabriel Woloz <wolozgabriel@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Mar 2026 00:59:01 -0400 you wrote:
> MGMT_OP_HCI_CMD_SYNC (0x005B) is missing from the mgmt_op[] array in lib/bluetooth/mgmt.h. The array terminates prematurely at 0x005A. Add the missing entry under the name "HCI Cmd Sync".
> 
> Gabriel Woloz (1):
>   lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op
> 
>  lib/bluetooth/mgmt.h | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ,1/1] lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c6e97516cb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


