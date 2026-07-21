Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0A47252A
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662864; cv=none; b=jNQrP1n/8U77q4+LUqkgJv6HCTX4Jp2wKcVILgQ5JaZqT/pOIi6bc9SojK/G1rTrdgx/uFu2VVEzXCn+hSekalatLjHZsiRHukrFwoAp4Q/H3eDsgGubF2UX45pM0uUizuqI0MQlvdzvWhK+bIud3qBYw4Vxd/jYN9H6PNINh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662864; c=relaxed/simple;
	bh=yu1imsQmnlBiw0VDrMDWNUcNlzu3VYg2NYkRdo5mqX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SkjjgwLoBmCQGufl/rsxX5yAAzQkVAOmSyx5HsXaHJiMimL8e0qTdRD3ASiu6UHn+fPzqRuuXsDKiLY/Uonzneb/hSDwe+A9XTNnjrC2ZHqPIc/koeA/XI+wJ4X85WcmRPpARpL9kJgPh7qLjoT5avpNHKGdLHm4Ke81iJTgfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrBOAIHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrBOAIHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9521F000E9;
	Tue, 21 Jul 2026 19:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662863;
	bh=O14+71wBFP3vhbhr8BBSAtkyCezSflS3KvOhhH4914A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XrBOAIHE+NVACAFrTM6YyN1Md0hZRsAGHib3ZgCeoIzA9bbMNVaCMSh0hM8lkYv7D
	 sHmMVaX+LOCTnXGEGfMY/3AenQ2q/F9TZbjnxx5hEmQRxojDuYd/YU94W8E9zFyC7h
	 yp4/b84TUyhN3iUHB9CmdjxbTKsjfE7pRl4/oIp/9YSwJApH7dlK2gQ/DvipdnPZux
	 JS7gpsTSzf2N3vOGnCYp2YNkDrXgP9F+HuaP/Z4jTjY1EsdO5FDGdXhSVw6re4yyUL
	 hjNIjlmyIZ6ol6q0KqUmr97dhDu223eqUtXwY6I4hupBohQJSvFplNSG2HWXyy6PIu
	 ErFW4qeOs+OoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C9E39253FD;
	Tue, 21 Jul 2026 19:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: mgmt: fix pairing command UAF
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178466283291.1001510.16769064007177227077.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:40:32 +0000
References: <cover.1784492458.git.xizh2024@lzu.edu.cn>
In-Reply-To: <cover.1784492458.git.xizh2024@lzu.edu.cn>
To: Ren Wei <enjou1224z@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, padovan@profusion.mobi, johan.hedberg@nokia.com,
 vega@nebusec.ai, xizh2024@lzu.edu.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Jul 2026 22:36:06 +0800 you wrote:
> From: Zihan Xi <xizh2024@lzu.edu.cn>
> 
> 
> Hi Linux kernel maintainers,
> 
> We found and validated a bug in net/bluetooth/mgmt.c. The bug is
> reachable by a privileged local user through the Bluetooth management
> interface when a Pair Device command races with pairing failure and
> cancellation paths. The fixed kernel was run with the reproducer for
> 420 seconds and then for 1200 seconds without the original KASAN
> use-after-free, list_debug BUG, or panic. The reproducer did not
> naturally finish before the timeout in those fixed-kernel runs.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: mgmt: fix UAF in pair command cancellation
    https://git.kernel.org/bluetooth/bluetooth-next/c/300a6fb2d8b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


