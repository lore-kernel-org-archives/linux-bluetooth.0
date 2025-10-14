Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB41FB1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481027; cv=none; b=o4mUnVdQE3MKOCOO7NhYPTGK7sb0nzAzealnR3LUkhhhxcsTIPM1ZOe/Pj+vh06mV1CrMoXjXJR6yS8U19JqOoDC8JfzdctZaW9kwrfZU4mQvoZzVmfzxZizak7QfcTh30bBcI2uJ1vqM0va1yO9h5U9thkbmrmzJyDm5YOrh08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481027; c=relaxed/simple;
	bh=rB+GnzM+QFJeugjG9UQ8u6+3BVdtXru8vAU4CVgUpqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=utzBx0ud6a//3ShqWY0NdgiYcGgBLn7C7dbIz4oalaPcDMbjQ0Zb10UAMDdnSBAWnuxrpvpXdpAx/lqK21mKdMdri3kCL8+LRo3TvYoIwoFQsoMtWoMd9Ig8rGs3gkjEW6iQhA0DOGBwsjQHdcM0aEvvDQzfX/Ako6CKgDfsHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PavKMyjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PavKMyjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905C5C4CEE7;
	Tue, 14 Oct 2025 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481026;
	bh=rB+GnzM+QFJeugjG9UQ8u6+3BVdtXru8vAU4CVgUpqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PavKMyjyv9F+3Kop+29BoRBej94qKramTk6Qshq/g7zM/6b59vSCIpF1nCfepyBuw
	 2NllkDUHMQNApvxNjZhRWrQAPNUGhL3EomjWV3SXshBeZTRnK/dZeLBjcHLE0VyEiF
	 bSj4pW9j8qZ8aAYjSPkySirXHX6cUqE10N8KTFre56JTPNy975HwbjQYSZPjD0YH1a
	 DXc7ePd8zS4ztud1xYEkzSt0VJwOqXMz2XwZSW5SQRP1S4bZmtFzHVk+b192TffG9d
	 MjDmGhazRcEnyp9VD+JRmcq7LHebSZc78qev5VkNt61JL3yHlvRe9MiPFXCTQp1b3U
	 9AWWnx2tQTV+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBD9B380AAFF;
	Tue, 14 Oct 2025 22:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/6] monitor: Use PAST to refer to Periodic
 Advertising Sync Transfer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176048101174.129201.2344801299402732417.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 22:30:11 +0000
References: <20251014203400.453454-1-luiz.dentz@gmail.com>
In-Reply-To: <20251014203400.453454-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Oct 2025 16:33:55 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This simplify the command and event names and their structs to just
> use PAST in place of other terminology currently in use.
> ---
>  monitor/bt.h     | 39 +++++++++++++++++++++++++++------------
>  monitor/packet.c | 41 +++++++++++++++++++++++------------------
>  2 files changed, 50 insertions(+), 30 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/6] monitor: Use PAST to refer to Periodic Advertising Sync Transfer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=620c5b4af4fd
  - [BlueZ,v3,2/6] emulator: Add initial support for PAST
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8656f1aa1556
  - [BlueZ,v3,3/6] iso-tester: Add tests for PAST procedures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d4811ecbcef6
  - [BlueZ,v3,4/6] monitor: Add support for PAST MGMT settings and flags
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a6974c55c0c4
  - [BlueZ,v3,5/6] MGMT: Add PAST Settings and Flags
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c53260bd5c4
  - [BlueZ,v3,6/6] iso.rst: Add documentation for PAST/rebind
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=025d2ef81245

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


