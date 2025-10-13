Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9441DC997
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 19:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382022; cv=none; b=Gg7B/GASHYGRdBDd6lBhcCwBRpfxVHZAgODAIcH7nx/xV05NnD6QC/xF8A1U8B6WNDXqPHjcYiz44ozZig0vTB8Km4Jjsi/1KKenw+xFSE4k9PT/0Y0ZWUStg4ERWBj58ppocB+xzc7x4odsrocC2C0yVDXp7cJQzL/0RyQKWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382022; c=relaxed/simple;
	bh=W86+ty9DRRXlhsQKU2ENvn6sIVUSYHNO+78OhHExb5Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xfum9XSs5pF/VhRUrJqwIuUsauYpP2pcY8emaTURN+LI/rFkq0pmnJB7/1N/rF0F5RfvOWKdYeNTECoo3qcyqxq6a7Du0dle1w2MFU0cg1obn4oXoMSpozAwjPdoSD6UeD7WGitCtu0OeYBaZgCc2NLs5T8cVxL1OOa34EO60SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGZbUydx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGZbUydx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0A4C4CEE7;
	Mon, 13 Oct 2025 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760382022;
	bh=W86+ty9DRRXlhsQKU2ENvn6sIVUSYHNO+78OhHExb5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGZbUydxpXmbLtYdE6//FhqDuAOusTZvBxSA6Dp1o3bfh20xkYhx5k3v8J+Livfxc
	 GDjYqk/vv54k4OrvJU0B3OXMWpDXGGkudxEuUnqSPJX3d/D1X2OURNV+M+Lg9WJBLo
	 2HqXlmBiOl7o52WUK2vwR4TYZHMA/5HI4cLYhPRSp0bggtdzGfczcdRncmjQMevr7K
	 kS2ysmYqZOZIZ8a3w0tBF6MxXVZC6Obz9JOp9p+q4lq3H+IYqK885pUKw7Jga3rr0T
	 s7PPaJShboPdwXmZFJgenALMxg3NQmmVZyuR6TkW1caBWSbaTuw+TzLFL8E94wmzWB
	 rwtDub2+4nKuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7153B380A958;
	Mon, 13 Oct 2025 19:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] tools: add 6lowpan-tester
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176038200829.3178322.16746808324448736281.git-patchwork-notify@kernel.org>
Date: Mon, 13 Oct 2025 19:00:08 +0000
References: 
 <ced3d6d6e7591bbce715a683a3902cc564c6d3fc.1760378120.git.pav@iki.fi>
In-Reply-To: 
 <ced3d6d6e7591bbce715a683a3902cc564c6d3fc.1760378120.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Oct 2025 20:57:43 +0300 you wrote:
> Add 6lowpan smoke testing. It only exercises the kernel 6lowpan L2CAP
> connection handling, ipv6 testing is mostly out of scope for the tester.
> 
> Add tests:
> 
> Basic Framework - Success
> Client Connect - Terminate
> Client Connect - Disable
> Client Connect - Disconnect
> Client Recv Dgram - Success
> Client Recv Raw - Success
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] tools: add 6lowpan-tester
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8f0aa430bfb9
  - [BlueZ,v2,2/2] doc: enable 6lowpan in tester.config and explain in test-runner.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2db2d3593799

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


