Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471B20DD75
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242406; cv=none; b=V9RtHLZIxG/ble9g+YhXuUhN+YUYy6UqBPzNqpXDAzHdjjtquI77zJR7mTpVUNPmZWjxgw1fplzApx5H63HBHlEGwHQnRY5McgfXy4Q7yfGiAT6Ia8arLo3tf4jyCa+4nUEbfI9vd2txo5sFOuLCLVJEyvYuBCjc+zzRYOcb9XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242406; c=relaxed/simple;
	bh=Arw2FDJqE868Rg6JeQYeaerDlDTYsUZIjr5O7h6Td7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BNzt0eUEOffe3NO0sG9BWKnLK3sb7NvOP+rlB8+2aAfRcGtq8Tq3287RcCGFxi/boRE8NL0k3sYgd26xreSzsbvXqmXhzJySQJ8iNmDlCrR1Bxc8emh/C5LiWjyZls36Z21J582SA8DX75OEjlId4RRY0sPVZhorzxQFoaMPlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2H4sZYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2H4sZYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32714C4CEF7;
	Wed,  4 Feb 2026 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770242406;
	bh=Arw2FDJqE868Rg6JeQYeaerDlDTYsUZIjr5O7h6Td7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M2H4sZYopAwFiafcmEEMkNfde3qu3+9F4IL6tYusNP6WfXFT1D2Nu8hPH7cm3sLi8
	 ZtzEiaNVPK25nCE0kIOUqF+DipnaLs4HcQZgllFb3HvWGBU48wYkl47o8S4NztUv2B
	 N4Rm2nW+o1BCWj6OLZVq6QWDGFBD8P6LMVsSiayJaPB101aZ7ES/xkOhQC7EKxseGT
	 auIhjmI1nOTVmQnVYwnOPUBOTkhzD3gkajolbgOwzj/8RRenxO+feTytm+fjf/OLRC
	 V+aj0ffxzMhPk5KceR6EuJtxSteXmPrkMfbpWQjGg2scrVroboPzpZV2NKvVIWY4IW
	 OVn9XcJd50VaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 851723808200;
	Wed,  4 Feb 2026 22:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor/l2cap: Add missing result for
 BT_L2CAP_PDU_ECRED_RECONF_RSP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177024240433.70576.12778414573997452669.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 22:00:04 +0000
References: <20260204185707.2327200-1-luiz.dentz@gmail.com>
In-Reply-To: <20260204185707.2327200-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Feb 2026 13:57:07 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Last 2 BT_L2CAP_PDU_ECRED_RECONF_RSP result opcodes were missing
> accourding to Bluetooth Core 6.2 spec:
> 
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specification.html#UUID-02ef4c03-7278-7ad6-bbf2-ee2f0e921fed
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor/l2cap: Add missing result for BT_L2CAP_PDU_ECRED_RECONF_RSP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fc20373d03c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


