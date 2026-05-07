Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C53AB29D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176255; cv=none; b=hdecIz2ivVf8rsXaltAL/DS9ocpqOUDaR54ibZKCbQQjLkxkophfPNAiqbUSuIm+lAfmWowu0NTfBAw2qL6x1Y6eZOLj0VpL1Hw0Q404tEBDGiHlg8MA4TVfyQhY7Un2TS/Zy+KEayKtdU8xrVBb9LletyPPjbgkXtYWauVlDwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176255; c=relaxed/simple;
	bh=D5GveCXK0LT8w3JIV/QkwrVtDAUwkFdI8f7IuhIpx+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rr6JHvpuYUJhYVGZg7rrsxkBqzgvbbJY2SQTLFf7ySmEOSuLHncVZr++ax5wifR1rmI4Y4aYFBx1BebqsQ6RsH9T+V44Ov7ah7rn2a+5AkW7D7d3Kmxi8STxNqfXVMmGY0WljaXNY6unF39+EDSy7Guh75qMifuWFj93syyyfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbejDP5Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbejDP5Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D89C2BCB2;
	Thu,  7 May 2026 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778176255;
	bh=D5GveCXK0LT8w3JIV/QkwrVtDAUwkFdI8f7IuhIpx+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbejDP5Zw4BSjSAuGdCQytDdZ2+QmE9CyLYTjy8GI/ukYKhzqys3gqPHMLF6pDD1h
	 /jY6C6wEnsvYd+OnOkjTIKbt/A1vhVyJqso7zJhLzxGranvt6UvJw21jYkHC3fwTBr
	 06YUGv2/oQTtykLqafiy4iQbFUBuU6RIhd/eM6o+DNNk9WFjDtE8SQ1HY+wwLUnrP3
	 5ZkaQudlByGofMqtvrFoUb3PJyQ8AytnEFCemuGvylYgT7FQLD1NX5xC9PfRy+Wvl/
	 2wtdwKLYvog0XQKwan4n09UC8YcoEeHP/SMkZZlZXxvt/G8Gje5Ikq++av373thTKi
	 8N+bbHwg2uZpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DCA380CFFF;
	Thu,  7 May 2026 17:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: Fix typo in QoS D-Bus dictionary entry names
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177817620455.4096553.3101693467356251048.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 17:50:04 +0000
References: <20260506230051.27436-1-thomaskirschner85@yahoo.de>
In-Reply-To: <20260506230051.27436-1-thomaskirschner85@yahoo.de>
To: Thomas Kirschner <thomaskirschner85@yahoo.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 May 2026 01:00:51 +0200 you wrote:
> MinimumDelay and PreferredMinimumDelay had wrong spelling, causing
> them to be exposed incorrectly over D-Bus. Any client relying on
> the correct spelling would fail to find these entries, breaking
> LE Audio QoS negotiation.
> ---
>  profiles/audio/bap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] bap: Fix typo in QoS D-Bus dictionary entry names
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d45fd43a1cc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


