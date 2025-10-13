Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603792D781E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382024; cv=none; b=OtvScqRNjabzyzioveA2l9CRjG/WJ7jglDSDxDZ+X/9tscOyQjL88uReMtW9ITieZf0mNQMz2d1xoos6PkiKl6fpiN3LY3JjYRXHJsRzpm2fcdeS4vHGfkMWwyuDVFac2wLjJbGDSwshR9Y0ykaxgHGWasw7M4qGoIZEB1ZZh3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382024; c=relaxed/simple;
	bh=zTIqdSFMt5UpEX/ft7vb/9OvRKzzSIyaD1IOARrbt/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dueYo+IRd2uMuftey8aC1uXf6cLCoqs8U9CKpykU1UXFkDxkPJD4jQT4vqbC7KkN3CWuPuy4QF3ovBieTZxKYd1uDByJ+0mwnMae/MsbhQ8d+EvI9epOc6sbeukLO8aiIlsw4YUOntmXsu5uooPpuV1f/nWmsihqQIz4/Q1t+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghvi/gB3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghvi/gB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032F4C4CEE7;
	Mon, 13 Oct 2025 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760382024;
	bh=zTIqdSFMt5UpEX/ft7vb/9OvRKzzSIyaD1IOARrbt/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ghvi/gB37XpyBal9oDjX8qKJXd9fI+us3bZkuRX19p8fjdkG9+zg19cKuUGbUOKZA
	 CQ4rpy2tjAsVH8BAzRE3QOVcrgR+9h+0W9ua5ILWfLzVyYDzWt/IYdm8hN3pcl2/Gi
	 eIUnQRpXMvkjZ8EZsn6GvrX/L3r7KRTymy+Z3ThQmeW47vadj9lLgsO94kRLrMOA3z
	 iCdQZGG9UWbKXUMd0+WNc1CaNb0Kv/B1CdI664bPFPmEuJ6xN+ZGLtazT58+ElZJh+
	 TH2ge/cWdf1usj1vhypXrRQ8z9wJs8sHJjLtlSFsGtqskNdDD4TdF96gLTuDX77hwM
	 5pVyDCTMZsQ7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB971380A958;
	Mon, 13 Oct 2025 19:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Add 6lowpan-tester
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176038200949.3178322.17143579309545518521.git-patchwork-notify@kernel.org>
Date: Mon, 13 Oct 2025 19:00:09 +0000
References: <cover.1759702519.git.pav@iki.fi>
In-Reply-To: <cover.1759702519.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Oct 2025 01:17:38 +0300 you wrote:
> Make a basic tester for the net/bluetooth/6lowpan.c implementation.
> 
> This module doesn't look like it's much used and locking around
> l2cap_chan / hci_conn there looks suspicious, so probably some tests are
> useful.
> 
> Here just simple connection / disconnection and packet RX tests are
> added.  Some issues appear to be there:
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] bthost: handle L2CAP_DISCONN_RSP and remove l2cap_conns
    (no matching commit)
  - [BlueZ,2/4] bthost: handle L2CAP_FLOW_CONTROL_CREDIT_IND
    (no matching commit)
  - [BlueZ,3/4] tools: add 6lowpan-tester
    (no matching commit)
  - [BlueZ,4/4] doc: enable 6lowpan in tester.config and explain in test-runner.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2db2d3593799

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


