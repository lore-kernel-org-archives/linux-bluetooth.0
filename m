Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528DC1EE010
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313039; cv=none; b=MbtFvpqHrTxcK7ouYsG/g46/VTxKVXmJeM9/sUDzaImcSKzBpXHWg5+l30OIO4dQUzSx4OLJH9Eo2PFvX6INiAhyGYQ2HJ5d1rylhh7k7GMfqT8BZfYassezravVl60nmOMjiqJatcbWg4DOirpJ3qfrWwkgU31QSNBPuPefvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313039; c=relaxed/simple;
	bh=X9rvnaeUZ81Qrr/VmxTT56V3CkBFhIrPkY11lPA9q5k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uO3NvJoLv8+KHr1VnxY0l7i/IZ+6oDSv89dp0YzE+/VAxy+ee2+iEMJGGjQ22kJU93g13BqHNdNlp0DVPlKznjRND7NL8RKYRhockMyiWNLZRruZEPuAMzwyMsS7izCkh90wLuLfECrq+B56aDn7NxuwtY+GkO2e5VblVDvGbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJHmkCOK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJHmkCOK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3319C4CEE9;
	Tue, 22 Apr 2025 09:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313038;
	bh=X9rvnaeUZ81Qrr/VmxTT56V3CkBFhIrPkY11lPA9q5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oJHmkCOKPsYQhmtsrIQMlVSTELicnsSJ0KcVQ8xHdslBCQjzcwmMIQ5Z4/UiYUUb9
	 xoCXFj2/SmiX4/dMf8oepuYrenD/TFh5bDcGNtIBYhroAV1zAJPlFD4Wi1XnVTKLRs
	 MlkXHohiwq5uQjYOM1BYaobqkrwJzsRSMNOnsx8hAL9madA39cxtZHvxN8WtdRIdSe
	 WFpcwL0ZuGzlN+xaVypDrPCnNnGqNIz9nzi8R6p/7NswC2+FO1OlQ2F1Vx0A2qiWE+
	 tHBtvAvJjhX7ymOo3C5yOGcDOh71ByoISzbYGNArIxHeBf+3dZN949gxC9hhc2ht0n
	 b/CighENgIscw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7164839D6546;
	Tue, 22 Apr 2025 09:11:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: don't track streams without setup except for ucast
 server
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174531307699.1477965.13178452304460755952.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:11:16 +0000
References: <b3c84d2181db1acdc096df03e8d1046b89a7628d.1745252942.git.pav@iki.fi>
In-Reply-To: <b3c84d2181db1acdc096df03e8d1046b89a7628d.1745252942.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 21 Apr 2025 19:30:53 +0300 you wrote:
> data->streams is is used for determining which streams can connect to
> listening socket. This stream list is specific to ucast server.
> 
> Rename the variable to data->server_streams, and only put ucast server
> streams there.
> 
> Fixes data->streams accumulating dead stream pointers.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bap: don't track streams without setup except for ucast server
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d5ef57305b79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


